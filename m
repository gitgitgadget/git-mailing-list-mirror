Received: from mailrelay1-3.pub.mailoutpod2-cph3.one.com (mailrelay1-3.pub.mailoutpod2-cph3.one.com [46.30.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F198A1D172E
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802287; cv=none; b=KzT9epxibUGAzFpCyvF4GG599SNpFbFh4Bq+jzRynHknuUrrrgJcibMilBb25/hu1dNBA3koD0rDBXM9eS3OBYKPkoVIGs6DTIreNgwE1//EweYlOBblDkJr4jkcy1ZfQt6rv/l9uiTw7H9IBIEvRZIUeMH3aLGgLX886QtVKU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802287; c=relaxed/simple;
	bh=sgB/Ss0zeaZdaLr/1XQl9tUuHK/ILikjvqKlUqzvbrs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=eLW3X9/b6x/+myBNIMH2/BlnvCbsdadAM4t/NreO2Bcxt9LFZ4aSh2WhjqND24RuWFUOJmxKA+051tUm3/zo18lcMvuMnC0HFwS98wI6TFYNavgIQUWMGb5B4incFEO6bchVILNMi+AmKWimWNtTcpNtLJHCFD5HazfvaEgLDlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxsi.org; spf=none smtp.mailfrom=maxsi.org; dkim=pass (2048-bit key) header.d=maxsi.org header.i=@maxsi.org header.b=tQGwv6Bw; dkim=permerror (0-bit key) header.d=maxsi.org header.i=@maxsi.org header.b=zMSObqZA; arc=none smtp.client-ip=46.30.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxsi.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=maxsi.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxsi.org header.i=@maxsi.org header.b="tQGwv6Bw";
	dkim=permerror (0-bit key) header.d=maxsi.org header.i=@maxsi.org header.b="zMSObqZA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=maxsi.org; s=rsa1;
	h=content-transfer-encoding:content-type:cc:to:subject:from:mime-version:date:
	 message-id:from;
	bh=kZpNn4p3RREBndgK7XiGAnr4hQZqRl0KUbu86jeFiWY=;
	b=tQGwv6Bwuq2i5/HQJBdb9rlfJFjny2kgnoMhb9YwGVwmICzQzPFSRHK+VV18zOJU+2r6GkvgruyBV
	 dX6Ds2yedbRcSSeFZUUQ/jvHBgrvkdr7CBzmsLn/Ui2rukMl9ldW4S47MHveHxePf2IZp/LgaN2JXE
	 6rYwsGgR4ul9Uhml7sCK2FKfQliFzK7P3TacZFh7S+sSCloQ+Nm+LeAeSHExw83RIsurabgtBjJY9W
	 QcAazWOWv6+dlLLkHK8gqVFHAoLgT43E0qVJNDyQ7nifG9iKphkowSrzH+lgVkp+uK0P8XcS7meObr
	 Fw+aoEcfq4pKQpEZSYBoJc3vl4GHrYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=maxsi.org; s=ed1;
	h=content-transfer-encoding:content-type:cc:to:subject:from:mime-version:date:
	 message-id:from;
	bh=kZpNn4p3RREBndgK7XiGAnr4hQZqRl0KUbu86jeFiWY=;
	b=zMSObqZA5NEL7yyTajqzKg58MT/HIqKmP6T0R19XKUEX0+7D2k0vEpvS0VMrIk+s8ObHySjZwqVSl
	 ePpx8ToAQ==
X-HalOne-ID: 01c1bc19-9b60-11ef-a3df-a581d61233e4
Received: from [192.168.87.156] (unknown [85.203.218.213])
	by mailrelay1.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 01c1bc19-9b60-11ef-a3df-a581d61233e4;
	Tue, 05 Nov 2024 10:23:33 +0000 (UTC)
Message-ID: <436f1046-a997-4bd1-9d4e-17a429822c07@maxsi.org>
Date: Tue, 5 Nov 2024 11:23:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jonas 'Sortie' Termansen <sortie@maxsi.org>
Subject: [PATCH] compat: only replace hstrerror if NO_IPV6.
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Modern POSIX-1.2024 systems might only have getaddrinfo(3) but not
gethostbyname(3) (and hstrerror(3)). Git will only use getaddrinfo
in this case and not hstrerror, but will still attempt to replace
the missing hstrerror function, and the build fails due to the
missing the error constants.

This change declares githstrerror only if it is going to be used.

Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>
---
 compat/hstrerror.c | 2 ++
 git-compat-util.h  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/compat/hstrerror.c b/compat/hstrerror.c
index b85a2fa956..0a481d97dc 100644
--- a/compat/hstrerror.c
+++ b/compat/hstrerror.c
@@ -2,6 +2,7 @@
 #include <stdio.h>
 #include <netdb.h>
 
+#ifdef NO_IPV6
 const char *githstrerror(int err)
 {
 	static char buffer[48];
@@ -19,3 +20,4 @@ const char *githstrerror(int err)
 	snprintf(buffer, sizeof(buffer), "Name resolution error %d", err);
 	return buffer;
 }
+#endif
diff --git a/git-compat-util.h b/git-compat-util.h
index e4a306dd56..4a1072b9cf 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -930,10 +930,12 @@ uintmax_t gitstrtoumax(const char *, char **, int);
 intmax_t gitstrtoimax(const char *, char **, int);
 #endif
 
+#ifdef NO_IPV6
 #ifdef NO_HSTRERROR
 #define hstrerror githstrerror
 const char *githstrerror(int herror);
 #endif
+#endif
 
 #ifdef NO_MEMMEM
 #define memmem gitmemmem
-- 
2.45.2

