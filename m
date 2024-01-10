Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF0A482C5
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbuSsfbC"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d4414ec9c7so23637125ad.0
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 14:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704924314; x=1705529114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLUHhDR+LJbLQuLZJQGEt9wKaIN7qPQ/VBTEVwsqSjo=;
        b=WbuSsfbCz03JVUGIwlzVY/LcKSnjWPpMqDqhqwrsgGyDlF/JDyU1XIqwxbS/ZaBhEj
         pLY7Frc2e/fIVG6M16HLJ0dquF8x5B1JDknbYWBfoIEkPW6N0jyL6MDQfVCS83kJM4St
         87j3rxowk8RNAR+Fa1Tgli+xQrxRkrqPElOCrleB8eMmbGiJdEBrrzKVsgTnIRxBK8C0
         g+0ddWeRXETnA88/6oMkUV6WgjMak5/4Nbjb6SvITVrZpWI04/eIG2yGQlAE7e4T4DRd
         s5LKcbrZUN5234Y8KTJunA1KndFkn6/K0vdEKaTi3d6ybkPe046u1hYimgPFCio6Kj8j
         pxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704924314; x=1705529114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLUHhDR+LJbLQuLZJQGEt9wKaIN7qPQ/VBTEVwsqSjo=;
        b=oFNFRpdbQ2vGHTcSZvEzsdmpDNS9XNJboofcXipnI0g0ql5o7yr2dlIzwuk52ELHem
         nAe2oJstDnmB9NmF9bEAoRhhrzgCB0BuiEO8o3wkWxZOqqxIj+N7/EdEORPzjexbtCkp
         JKRLhlQwTd0hOt2pcRgOdUgvjVbQf+o1nEKMEPScFYHO5Dl4UakbDJRsw8bR10CbjArm
         6MyQaRZIp+Hj+NAIGPqtrrbObThWrLs1uKOH5EwP34ZHwb8f77tRHn/YOjcjGsk99Q4G
         inyTfPTuUcF8jy7OecwLGadsBDM8cjA13P2FSqjlraqi/pe+6D97/2KcgSLpf5yoVNHE
         ZS/g==
X-Gm-Message-State: AOJu0YyEwMzI24CpkG0K1zf5LGLKo9iobqFVQJ8z2lQ3nkjLm7mfWVlo
	8EX9Cw73DvUB0Dghy0eCFDyG48BMbxk=
X-Google-Smtp-Source: AGHT+IFnF9aQIkhpuA0NcjJSNHs8NFc2LH9+Om4JOgUcmC1MqVHdD6e+7McJFHPI/KiwiCKjTXciug==
X-Received: by 2002:a17:902:ba8a:b0:1d4:c235:9a94 with SMTP id k10-20020a170902ba8a00b001d4c2359a94mr170253pls.26.1704924314385;
        Wed, 10 Jan 2024 14:05:14 -0800 (PST)
Received: from linux-af78.suse ([189.122.227.168])
        by smtp.gmail.com with ESMTPSA id jb11-20020a170903258b00b001d4752f540esm4142041plb.198.2024.01.10.14.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 14:05:13 -0800 (PST)
From: Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com>
To: marcelo.jimenez@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH] gitweb: Fixes error handling when reading configuration
Date: Wed, 10 Jan 2024 19:05:06 -0300
Message-ID: <20240110220506.27491-1-marcelo.jimenez@gmail.com>
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
index e66eb3d9ba..47577ec566 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -728,9 +728,11 @@ sub filter_and_validate_refs {
 sub read_config_file {
 	my $filename = shift;
 	return unless defined $filename;
-	# die if there are errors parsing config file
 	if (-e $filename) {
 		do $filename;
+		#die if there is a problem accessing the file
+		die $! if $!;
+		# die if there are errors parsing config file
 		die $@ if $@;
 		return 1;
 	}
-- 
2.43.0

