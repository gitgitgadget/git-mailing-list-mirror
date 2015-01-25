From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/21] list-files -F: show submodules with the new indicator '&'
Date: Sun, 25 Jan 2015 19:37:54 +0700
Message-ID: <1422189476-7518-20-git-send-email-pclouds@gmail.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 13:29:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFMJb-0004A0-4B
	for gcvg-git-2@plane.gmane.org; Sun, 25 Jan 2015 13:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487AbbAYM3M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2015 07:29:12 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:57285 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527AbbAYM3K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2015 07:29:10 -0500
Received: by mail-pd0-f175.google.com with SMTP id fl12so6846707pdb.6
        for <git@vger.kernel.org>; Sun, 25 Jan 2015 04:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=D55VWB8LFSmCI11d6M5Z2YaR9FQNAnlGtF+WxjcpKLU=;
        b=AKITDHgeMqltudvoovTzaFUnlLb3u53r51jqGSPys0QXTAKBhoenUXXP7PbIO7MK8u
         kVS60mjgim0srfJCaNNHdXt9t2FRzMLH/1XS3rgUlmXUTulcOuWwdBS4/kmAKPuInR6b
         EbuxIIU8QrikLxWe+xcX5oBlqNBmPVpWv5U+JBVSPwQSLGBJfV4sJuzSSyn+MxABIP5T
         Q3YpRV4CvQ9agzGgxR5DJbl0h1p9d8xdiS9goAHceFZo7WyDNLzSUSI18i2tsNJWpF1h
         pdwNq+W3zg0MMbYTH4R/ksMVm/L2TrWyqlzRXiO+mC8pVgw/W4vvILe+Inxz3OaaV6FF
         7dZQ==
X-Received: by 10.66.178.198 with SMTP id da6mr26348534pac.126.1422188949530;
        Sun, 25 Jan 2015 04:29:09 -0800 (PST)
Received: from lanh ([115.73.204.104])
        by mx.google.com with ESMTPSA id ms5sm7108814pbb.59.2015.01.25.04.29.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Jan 2015 04:29:08 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 25 Jan 2015 19:40:32 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263015>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-list-files.txt | 4 ++--
 builtin/ls-files.c               | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-list-files.txt b/Documentation/git-list-=
files.txt
index 475c6da..223f6fd 100644
--- a/Documentation/git-list-files.txt
+++ b/Documentation/git-list-files.txt
@@ -54,8 +54,8 @@ OPTIONS
=20
 -F::
 --classify::
-	Append indicator (one of `*/=3D>@|`, which is executable,
-	directory, socket, Solaris door, symlink, or fifo
+	Append indicator (one of `*/=3D>@|&`, which is executable,
+	directory, socket, Solaris door, symlink, fifo, or submodule
 	respectively) to entries.
=20
 -R::
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index bbeb4ce..697a307 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -92,6 +92,8 @@ static void append_indicator(struct strbuf *sb, mode_=
t mode)
 		c =3D '|';
 	else if (S_ISSOCK(mode))
 		c =3D '=3D';
+	else if (S_ISGITLINK(mode))
+		c =3D '&';
 #ifdef S_ISDOOR
 	else if (S_ISDOOR(mode))
 		c =3D '>';
--=20
2.2.0.84.ge9c7a8a
