terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
    profile = "dream"
  
}

data "aws_ami" "ami_for_ec2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "assignment_ec2" {
  ami           = data.aws_ami.ami_for_ec2.id
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform_Assignment"
  }
}

resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-app-logs-${random_string.random.result}"
}
