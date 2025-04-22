.PHONY: build up down restart logs shell test migrate makemigrations superuser clean help flower flower-logs

help:
	@echo "Available commands:"
	@echo "  make build         - Build Docker images"
	@echo "  make up           - Start all containers"
	@echo "  make down         - Stop and remove containers"
	@echo "  make restart      - Restart all containers"
	@echo "  make logs         - View logs from all containers"
	@echo "  make shell        - Open Django shell"
	@echo "  make test         - Run Django tests"
	@echo "  make migrate      - Run Django migrations"
	@echo "  make makemigrations - Create new migrations"
	@echo "  make superuser    - Create Django superuser"
	@echo "  make clean        - Remove all containers and volumes"
	@echo "  make flower       - Start Flower monitoring tool"
	@echo "  make flower-logs  - View logs from Flower container"

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

restart:
	docker-compose restart

logs:
	docker-compose logs -f

shell:
	docker-compose exec web python manage.py shell

test:
	docker-compose exec web python manage.py test

migrate:
	docker-compose exec web python manage.py migrate

makemigrations:
	docker-compose exec web python manage.py makemigrations

superuser:
	docker-compose exec web python manage.py createsuperuser

clean:
	docker-compose down -v
	docker system prune -f

flower:
	docker-compose exec flower celery -A w_store flower --port=5555

flower-logs:
	docker-compose logs -f flower