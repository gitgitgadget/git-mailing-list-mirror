Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA334F61B
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 22:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7DtEgBz"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d54b86538aso22529055ad.0
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 14:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704927435; x=1705532235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KR3xPiJDHYd6CoT4jqVqIX6qyjkqoi9/bLLJwa4Oan4=;
        b=d7DtEgBzcKKOAcn3xHgqi4xMvji/6UdqYym8BOwObvgq6/4IGormWdpoHl4W2Cc3ec
         NIXBqsAgELt1Ya6SLLcCubCHbRmJ6WaY+ODyQeTqV3K1jx41fmAEIBgRGHsbNT30WIOc
         xj0asiOKeNRecQTgE000TL6twnfur0SS4/OYkdBimpRyA52StJULCU/tIIR1dryiso7F
         L073+/8ZwDcHT9QrwgjIOwg4sh5ly7PVSoE0XIKQIJqWC1JXnV0YD2vDI18LxG7V1gzf
         pw9YmzpwnetCCmSUOhJXVUxKt8JXkaV9iOvHluEGIlKLGcr8TENDJlJd1kah+LI41V5p
         5Zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704927435; x=1705532235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KR3xPiJDHYd6CoT4jqVqIX6qyjkqoi9/bLLJwa4Oan4=;
        b=BTrcAy6zkbFpYrVwNjxx/ptQH9aqyzDIpQX/+5FB77Q6ddG3kIk4qCPxUkY/BDxMYy
         vCwn3NWAum4/6YhT4YntoRcHyQj1P1guwtBaBm2BO2/ZlM9exHKS6WcCdrVesOvODhQt
         bumStUKp8JWtjYZJeDHXb03oSHEh4EAwgl0O42fQQ4zmdvOLH8uz/EjWjgL8sR3SLSml
         +PyzfBuGfc8AGNPhRkDiS7QeHWA/W726se1qehDNPSvSfYDNMjwsDXwi2yCZwrxYgFbU
         ewvEkcOWUdwv71gLiAhElWCwBfWabD17ea/wvdUX+9rDG0twW0MnQtPajrILbXgjB3KD
         32/w==
X-Gm-Message-State: AOJu0Yx1KJO1kmtkvZWOXS0Bw7mSvQErJpb0XqNRyPoILC4RxM5suvG8
	3JeWAbvRShPAEhFFuNgg5oo=
X-Google-Smtp-Source: AGHT+IGYltYq/HO0l05RYCtvYYhbbC+23vtSe5uQKkHIZtoUbf0tG2UJrAxEoQZjwh9EGVYhkMis0g==
X-Received: by 2002:a17:902:f545:b0:1d5:36cf:a8a with SMTP id h5-20020a170902f54500b001d536cf0a8amr302160plf.39.1704927434822;
        Wed, 10 Jan 2024 14:57:14 -0800 (PST)
Received: from linux-af78.suse ([189.122.227.168])
        by smtp.gmail.com with ESMTPSA id jw17-20020a170903279100b001d0ca40158dsm4167312plb.280.2024.01.10.14.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 14:57:14 -0800 (PST)
From: Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com>
To: marcelo.jimenez@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH v2] gitweb: Fixes error handling when reading configuration
Date: Wed, 10 Jan 2024 19:57:09 -0300
Message-ID: <20240110225709.30168-1-marcelo.jimenez@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACjc_5pdijCZrrXQWHswsxYrGUzZ7pZq+nj3SzY1z+Xxop64Ww@mail.gmail.com>
References: <CACjc_5pdijCZrrXQWHswsxYrGUzZ7pZq+nj3SzY1z+Xxop64Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a possibility of a permission to access error go
unnoticed.

Perl uses two different variables to manage errors from a do. One
is $@, which is set in this case when do is unable to compile the
file. The other is $!, which is set in case do cannot read the file.
By printing the value of $! I found out that it was set to Permission
denied. Since the script does not currently test for $!, the error
goes unnoticed.

Perl do block documentation: https://perldoc.perl.org/functions/do

Signed-off-by: Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com>
---
 gitweb/gitweb.perl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e66eb3d9ba..5d0122020f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -728,9 +728,11 @@ sub filter_and_validate_refs {
 sub read_config_file {
 	my $filename = shift;
 	return unless defined $filename;
-	# die if there are errors parsing config file
 	if (-e $filename) {
 		do $filename;
+		# die if there is a problem accessing the file
+		die $! if $!;
+		# die if there are errors parsing config file
 		die $@ if $@;
 		return 1;
 	}

base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
-- 
2.43.0

