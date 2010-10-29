From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 38/42] Remove all logic from get_git_work_tree()
Date: Fri, 29 Oct 2010 13:48:50 +0700
Message-ID: <1288334934-17216-39-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:54:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBiqm-0007ZV-Hx
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933543Ab0J2GyG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:54:06 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933422Ab0J2GyE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:54:04 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=dara9lQSWdPSEOu+5ftVRiw+8w9Jzezj3+Wa68JyIdg=;
        b=vw4z52DaPE3XrEWzJQxxrs+kVim6lrFl+1qfvtspfIb+v3+n5/C/WfdNRVjzvHqLj4
         g2PCkU2ILUYD6fxLb16tefq2sfyKGox4ip1/DheGFTHMHBHpfTi9Kip85yRs2aH6H1n1
         QSQBO/ChVRYoTih5dqIX4dW1qA9z3ZOKdsixQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Y7ZbBsHseqPkB02uBz0bed11VZc5DqPc163HKqOqYOicpHjVE5aCOIjSQb+ftYTl8j
         hrdxuZKhv2729X7jG45pG4HpH466sXFX6lnzYbx0kY+tx00jQHRTPmWpXwLFnSWlCwvR
         uTlk3b0bsDyk8nBTN6tV8SYKPfy+Rdx0NvmG8=
Received: by 10.142.211.20 with SMTP id j20mr1033252wfg.408.1288335243830;
        Thu, 28 Oct 2010 23:54:03 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id e36sm1028281wfj.14.2010.10.28.23.53.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:54:02 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:54:03 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160306>

This helps break things some more. Eventually all repo setup logic
should be centralized in setup_* functions. This helps push all the
bugs back to setup_* functions.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/init-db.c |   13 +++++++++++--
 environment.c     |   21 ++-------------------
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 9d4886c..e3af9ea 100644
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
@@ -510,10 +511,18 @@ int cmd_init_db(int argc, const char **argv, cons=
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
diff --git a/environment.c b/environment.c
index de5581f..6d8c90b 100644
--- a/environment.c
+++ b/environment.c
@@ -137,30 +137,13 @@ static int git_work_tree_initialized;
  */
 void set_git_work_tree(const char *new_work_tree)
 {
-	if (is_bare_repository_cfg >=3D 0)
-		die("cannot set work tree after initialization");
-	git_work_tree_initialized =3D 1;
-	free(work_tree);
+	if (git_work_tree_initialized)
+		die("internal error: work tree has already been set");
 	work_tree =3D xstrdup(make_absolute_path(new_work_tree));
-	is_bare_repository_cfg =3D 0;
 }
=20
 const char *get_git_work_tree(void)
 {
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
1.7.0.2.445.gcbdb3
