From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 16/27] setup.c: convert check_repository_format_gently to use strbuf
Date: Sat,  1 Mar 2014 19:12:52 +0700
Message-ID: <1393675983-3232-17-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 13:22:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJiw5-0002Jd-6h
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbaCAMW3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 07:22:29 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:65437 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbaCAMW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:22:28 -0500
Received: by mail-pd0-f170.google.com with SMTP id y10so1879822pdj.1
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bop9+jlnGufAD+pgQH37bA0ZMYsYl86ro7p3INd0zjg=;
        b=rCjmIoemB3VPUlJFUpDfxqN1IHxuCc0n+82bFVup3bmTdNshCfSu2tuqMtGG7x6M1p
         TZ6TveO4bV7D7N7hDSKFruM//IftOlPnGK6qo0fa+fl/ORI6OKI96kpY70V0GFpDfOeQ
         wA+XZAlHddyd/R3UDEa3cmuQTDdB/fagJ05cnOg5NENNHqtWhKZVz8CpYIEDihfTUxAo
         dy9PzakjY7VGszZJqC2YvHCyWhLAQqUQGMHhIJVNTavSbhZbuepd0Bv7rYHWZWNB0tfx
         nuP8jOSRSM/n27Y8EqErl0K5HHAcyJamFLw9r8TgUac/zlqV2L2KXjYXeZRGQXo+RvTc
         r7Zw==
X-Received: by 10.68.135.137 with SMTP id ps9mr87077pbb.160.1393676548061;
        Sat, 01 Mar 2014 04:22:28 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id c7sm15941222pbt.0.2014.03.01.04.22.24
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 04:22:27 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 01 Mar 2014 19:22:53 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243081>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 7e5b334..5085ab1 100644
--- a/setup.c
+++ b/setup.c
@@ -288,7 +288,9 @@ void setup_work_tree(void)
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
@@ -299,7 +301,8 @@ static int check_repository_format_gently(const cha=
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
@@ -309,9 +312,10 @@ static int check_repository_format_gently(const ch=
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
1.9.0.40.gaa8c3ea
