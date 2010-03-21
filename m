From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 08/19] init/clone: turn on startup->have_repository properly
Date: Sun, 21 Mar 2010 17:30:35 +0700
Message-ID: <1269167446-7799-9-git-send-email-pclouds@gmail.com>
References: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 11:35:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtIV7-0003M8-H6
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 11:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119Ab0CUKfR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 06:35:17 -0400
Received: from mail-yx0-f182.google.com ([209.85.210.182]:59165 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab0CUKfO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 06:35:14 -0400
Received: by yxe12 with SMTP id 12so1312096yxe.33
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 03:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=SqZpuOVNJKV8fo0Y1q/hBuZbpHYE1pcDzaski41Gr3Y=;
        b=Oq53h0dF+7Z9Ate9ERk/lvOQIC50PNDgiIYDlZxq1USJ7WIN0gu/vbQ4UO/EX47puj
         /i7KlzADbuaheuBVcRBqcAbn0a1xGD1S3n87WU9GGwIlWzaAy6yUtyWNJ5GQgDRh7mqS
         +r+43uS+RUgWxMf/Vxhi8sUDnXUAJpsC0+N4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=w+kCkkrhIwsdZ+mDoZwp05cuVgG7xman0ilxmJC9UjgIBd7d0WMCBBuxMcEh6Lum/I
         Ui/BhRoocHXSeaY6p1juHn3tCGbkh3eSaTi6tBRLDwgQ2IP0PiTfxnh0WP3qlNd3DDAE
         8GDQ4wmdHdHeL9ucEeAXznonbRiTgcBhwUiac=
Received: by 10.150.55.32 with SMTP id d32mr7287263yba.261.1269167713732;
        Sun, 21 Mar 2010 03:35:13 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.230.17])
        by mx.google.com with ESMTPS id 23sm3361720iwn.2.2010.03.21.03.35.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 03:35:12 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 21 Mar 2010 17:31:33 +0700
X-Mailer: git-send-email 1.7.0.2.425.gb99f1
In-Reply-To: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142804>

With startup_info !=3D NULL, many code path may be disabled, depending
on repo setup. Also move set_git_dir() closer to have_repository
assignment to make it clear about repo setup.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c   |    3 +--
 builtin/init-db.c |    9 +++++----
 cache.h           |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 58bacbd..ab7a3c4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -460,9 +460,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
=20
 	if (safe_create_leading_directories_const(git_dir) < 0)
 		die("could not create leading directories of '%s'", git_dir);
-	set_git_dir(make_absolute_path(git_dir));
=20
-	init_db(option_template, option_quiet ? INIT_DB_QUIET : 0);
+	init_db(git_dir, option_template, option_quiet ? INIT_DB_QUIET : 0);
=20
 	/*
 	 * At this point, the config exists, so we do not need the
diff --git a/builtin/init-db.c b/builtin/init-db.c
index edc40ff..064b919 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -294,12 +294,15 @@ static int create_default_files(const char *templ=
ate_path)
 	return reinit;
 }
=20
-int init_db(const char *template_dir, unsigned int flags)
+int init_db(const char *git_dir, const char *template_dir, unsigned in=
t flags)
 {
 	const char *sha1_dir;
 	char *path;
 	int len, reinit;
=20
+	set_git_dir(make_absolute_path(git_dir));
+	startup_info->have_repository =3D 1;
+
 	safe_create_dir(get_git_dir(), 0);
=20
 	init_is_bare_repository =3D is_bare_repository();
@@ -509,7 +512,5 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 				   get_git_work_tree());
 	}
=20
-	set_git_dir(make_absolute_path(git_dir));
-
-	return init_db(template_dir, flags);
+	return init_db(git_dir, template_dir, flags);
 }
diff --git a/cache.h b/cache.h
index 8e9d818..dd27e11 100644
--- a/cache.h
+++ b/cache.h
@@ -427,7 +427,7 @@ extern void verify_non_filename(const char *prefix,=
 const char *name);
=20
 #define INIT_DB_QUIET 0x0001
=20
-extern int init_db(const char *template_dir, unsigned int flags);
+extern int init_db(const char *git_dir, const char *template_dir, unsi=
gned int flags);
=20
 #define alloc_nr(x) (((x)+16)*3/2)
=20
--=20
1.7.0.2.425.gb99f1
