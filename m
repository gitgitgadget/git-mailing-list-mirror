From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/16] init/clone: turn on startup->have_repository properly
Date: Thu, 11 Mar 2010 20:22:26 +0700
Message-ID: <1268313754-28179-9-git-send-email-pclouds@gmail.com>
References: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 14:23:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpiMh-0001K7-H4
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 14:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452Ab0CKNX3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 08:23:29 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60688 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932388Ab0CKNX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 08:23:28 -0500
Received: by pwi1 with SMTP id 1so9492pwi.19
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 05:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=a3u13iYfnhB7abbcuBeSip7b0cwNrfpK24+sTqz216M=;
        b=xOrEnc/c65WjR72IuqVnhkKmCzdx1C/AHrIHRU/t3TtdNfcdqUd4+TZvv9Agsys5G0
         3NE9xoNHqDBpzYoQb6rj4+BE/KgT7AbkIHCN2K0caKeuuG0WHa4mG0Cg376aAbKBiu6O
         vaVSNwQCIUdFg/P1yHdQWNg3+dUonaMVHsu2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=p27620rzDqooBDuDZURu73DvyODNEdXsUwne1mC+W/VkG7hrY0QIvmex36CGQVk/Te
         5bs072bhyUgJzheY13vqILE2p/O+1HXlggPua3dHRThp9roYWaIPKofFoMPB4Y8Wv/sI
         ampbmOt0lTCPBk9TVCdh6JL5OGF25vvYjXRWI=
Received: by 10.115.100.16 with SMTP id c16mr1347502wam.122.1268313805589;
        Thu, 11 Mar 2010 05:23:25 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.196.130])
        by mx.google.com with ESMTPS id 23sm8798855pzk.6.2010.03.11.05.23.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Mar 2010 05:23:24 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Mar 2010 20:23:19 +0700
X-Mailer: git-send-email 1.7.0.1.384.g6abcaa
In-Reply-To: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141971>

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
1.7.0.1.384.g6abcaa
