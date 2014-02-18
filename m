From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 16/25] setup.c: convert check_repository_format_gently to use strbuf
Date: Tue, 18 Feb 2014 20:40:05 +0700
Message-ID: <1392730814-19656-17-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 14:42:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFkwd-0000pO-Ig
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 14:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755733AbaBRNlw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 08:41:52 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:40426 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755727AbaBRNlt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 08:41:49 -0500
Received: by mail-pd0-f175.google.com with SMTP id w10so16277445pde.20
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 05:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xOgPWFCTr+OmJIMsXhPwihpFYNpERsXHLVN5PYibDhs=;
        b=y6zZ5pl8qwirnE33EbPzfKv43dxGF/MovRWZOdWtU3z7jEe4YU4gYhs/swfb57TXKJ
         el9Hh9v8jfbTYfd0DHkc1mCWxZBmtxcif3ElwGvxG/uMwLuS6ePHwe5bma1bWFVsvvB+
         1CDWmXVt2xYq2zfQeX9rSisWRxLhhd793iEk1wYrArR05ZkpTImw1conhHpLCgIhFbM9
         o8T1z+SrQRlIqm8SrXYuChG3IfLBWv1rNyAeH8Y3gLyVuoR6qmHFUB8dmyEUnoDAC/XN
         hB9tjQCH5gj8xZFd7Co7ITuN/0RhN5fmhGsLGowz4hyYtD4IHMyAebkGfTPaZqHMKQYA
         Umow==
X-Received: by 10.66.139.100 with SMTP id qx4mr10573945pab.141.1392730909303;
        Tue, 18 Feb 2014 05:41:49 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id eo11sm142599322pac.0.2014.02.18.05.41.46
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 05:41:48 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Feb 2014 20:42:02 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242316>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 4e5711c..282fdc9 100644
--- a/setup.c
+++ b/setup.c
@@ -281,7 +281,9 @@ void setup_work_tree(void)
=20
 static int check_repository_format_gently(const char *gitdir, int *non=
git_ok)
 {
-	char repo_config[PATH_MAX+1];
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *repo_config;
+	int ret =3D 0;
=20
 	/*
 	 * git_config() can't be used here because it calls git_pathdup()
@@ -292,7 +294,8 @@ static int check_repository_format_gently(const cha=
r *gitdir, int *nongit_ok)
 	 * Use a gentler version of git_config() to check if this repo
 	 * is a good one.
 	 */
-	snprintf(repo_config, PATH_MAX, "%s/config", gitdir);
+	strbuf_addf(&sb, "%s/config", gitdir);
+	repo_config =3D sb.buf;
 	git_config_early(check_repository_format_version, NULL, repo_config);
 	if (GIT_REPO_VERSION < repository_format_version) {
 		if (!nongit_ok)
@@ -302,9 +305,10 @@ static int check_repository_format_gently(const ch=
ar *gitdir, int *nongit_ok)
 			GIT_REPO_VERSION, repository_format_version);
 		warning("Please upgrade Git");
 		*nongit_ok =3D -1;
-		return -1;
+		ret =3D -1;
 	}
-	return 0;
+	strbuf_release(&sb);
+	return ret;
 }
=20
 /*
--=20
1.8.5.2.240.g8478abd
