From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 9/9] Remove all logic from get_git_work_tree()
Date: Mon,  1 Nov 2010 13:26:34 +0700
Message-ID: <1288592794-24221-9-git-send-email-pclouds@gmail.com>
References: <AANLkTim-uW4Esk1bkPzNNGRb8svZoNwCUvXF3Fqb4QmR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 07:27:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCns1-0001yM-5Y
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 07:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471Ab0KAG1t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Nov 2010 02:27:49 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63253 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab0KAG1r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 02:27:47 -0400
Received: by gwj21 with SMTP id 21so2954395gwj.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 23:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=CMLv6m9ejKhroAJrZTZTXxLvNp9KmyZfpn2wfJHW3DM=;
        b=DbrJW+cAhHZAzsq4Mqk0Q/vKTA347NsJUyaAjryTJCDqdJEShs6FUtEWFNiY2swF+5
         uFOxlMmPqAyY/Re7LX+fbCuYL5n/9D/KRpbcD9ePYmjGwyRCPnnVtXT9j6nLu1UB2Aye
         yeeZuvsC+r8bly72uzlFkwgZnZbmKYhDjt4yI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=jpYxrG+p/SGUQlhj1v6o9tEycLbTb1RCi3uQ4INwFcydgWSi+yjOQUecqlM+TB5FDw
         oik5d1nvxLp0x/KMYQaJLv6gf0mVVps3/C4yeypU9ESkDdFsRNgR1xDLXroXO3uaRR/T
         gITw2VFkLzq9t+ioWpAW9hSG5yTXu2YY4CdhU=
Received: by 10.150.204.18 with SMTP id b18mr27445522ybg.318.1288592866626;
        Sun, 31 Oct 2010 23:27:46 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id q14sm7082031ybk.19.2010.10.31.23.27.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 23:27:45 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 01 Nov 2010 13:27:47 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <AANLkTim-uW4Esk1bkPzNNGRb8svZoNwCUvXF3Fqb4QmR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160466>

This logic is now only used by cmd_init_db(). setup_* functions do not
rely on it any more. Move all the logic to cmd_init_db() and turn
get_git_work_tree() into a simple function.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/init-db.c |   14 +++++++++++---
 cache.h           |    1 -
 environment.c     |   26 ++------------------------
 3 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index ea06478..e3af9ea 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -414,6 +414,7 @@ static const char *const init_db_usage[] =3D {
 int cmd_init_db(int argc, const char **argv, const char *prefix)
 {
 	const char *git_dir;
+	const char *work_tree;
 	const char *template_dir =3D NULL;
 	unsigned int flags =3D 0;
 	const struct option init_db_options[] =3D {
@@ -480,8 +481,8 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 	 * without --bare.  Catch the error early.
 	 */
 	git_dir =3D getenv(GIT_DIR_ENVIRONMENT);
-	if ((!git_dir || is_bare_repository_cfg =3D=3D 1)
-	    && getenv(GIT_WORK_TREE_ENVIRONMENT))
+	work_tree =3D getenv(GIT_WORK_TREE_ENVIRONMENT);
+	if ((!git_dir || is_bare_repository_cfg =3D=3D 1) && work_tree)
 		die("%s (or --work-tree=3D<directory>) not allowed without "
 		    "specifying %s (or --git-dir=3D<directory>)",
 		    GIT_WORK_TREE_ENVIRONMENT,
@@ -496,7 +497,6 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 	if (is_bare_repository_cfg < 0)
 		is_bare_repository_cfg =3D guess_repository_type(git_dir);
=20
-	startup_info->setup_explicit =3D 1;
 	if (!is_bare_repository_cfg) {
 		if (git_dir) {
 			const char *git_dir_parent =3D strrchr(git_dir, '/');
@@ -511,10 +511,18 @@ int cmd_init_db(int argc, const char **argv, cons=
t char *prefix)
 			if (!getcwd(git_work_tree_cfg, PATH_MAX))
 				die_errno ("Cannot access current working directory");
 		}
+		if (work_tree)
+			set_git_work_tree(make_absolute_path(work_tree));
+		else
+			set_git_work_tree(git_work_tree_cfg);
 		if (access(get_git_work_tree(), X_OK))
 			die_errno ("Cannot access work tree '%s'",
 				   get_git_work_tree());
 	}
+	else {
+		if (work_tree)
+			set_git_work_tree(make_absolute_path(work_tree));
+	}
=20
 	set_git_dir(make_absolute_path(git_dir));
=20
diff --git a/cache.h b/cache.h
index b2cdda7..123dd4b 100644
--- a/cache.h
+++ b/cache.h
@@ -1119,7 +1119,6 @@ const char *split_cmdline_strerror(int cmdline_er=
rno);
 /* git.c */
 struct startup_info {
 	int have_repository;
-	int setup_explicit;
 };
 extern struct startup_info *startup_info;
=20
diff --git a/environment.c b/environment.c
index 15764ee..6db00da 100644
--- a/environment.c
+++ b/environment.c
@@ -137,36 +137,14 @@ static int git_work_tree_initialized;
  */
 void set_git_work_tree(const char *new_work_tree)
 {
+	if (git_work_tree_initialized)
+		die("internal error: work tree has already been set");
 	git_work_tree_initialized =3D 1;
-	free(work_tree);
 	work_tree =3D xstrdup(make_absolute_path(new_work_tree));
-	is_bare_repository_cfg =3D 0;
 }
=20
 const char *get_git_work_tree(void)
 {
-	if (startup_info && !startup_info->setup_explicit) {
-		if (is_bare_repository_cfg =3D=3D 1)
-			return NULL;
-		if (work_tree)
-			is_bare_repository_cfg =3D 0;
-		return work_tree;
-	}
-
-	if (!git_work_tree_initialized) {
-		work_tree =3D getenv(GIT_WORK_TREE_ENVIRONMENT);
-		/* core.bare =3D true overrides implicit and config work tree */
-		if (!work_tree && is_bare_repository_cfg < 1) {
-			work_tree =3D git_work_tree_cfg;
-			/* make_absolute_path also normalizes the path */
-			if (work_tree && !is_absolute_path(work_tree))
-				work_tree =3D xstrdup(make_absolute_path(git_path("%s", work_tree)=
));
-		} else if (work_tree)
-			work_tree =3D xstrdup(make_absolute_path(work_tree));
-		git_work_tree_initialized =3D 1;
-		if (work_tree)
-			is_bare_repository_cfg =3D 0;
-	}
 	return work_tree;
 }
=20
--=20
1.7.3.2.210.g045198
