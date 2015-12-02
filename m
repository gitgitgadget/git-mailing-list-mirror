From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/5] setup.c: remove special case of core.worktree and core.bare
Date: Wed,  2 Dec 2015 20:13:44 +0100
Message-ID: <1449083626-20075-4-git-send-email-pclouds@gmail.com>
References: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Max Kirillov <max@max630.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 20:14:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Cr7-0003VY-9J
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 20:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933084AbbLBTOL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Dec 2015 14:14:11 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34898 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932376AbbLBTOI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 14:14:08 -0500
Received: by wmuu63 with SMTP id u63so228397800wmu.0
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 11:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yL9g+05aT8lauw1NA6QoF7FYMhdhTbtF1Ko1lgQdIYU=;
        b=cyX6YyY4ALfQnaYFtplgn3b4gGEEpJwExcYyKwB7k/cFUZqQBADkH81KNqhPrBF8hR
         J49VQ481EG3O6H5tJhlPcggy7MlKjIZbeiedPAb2Ra3gMYFfK/ZStlJmPnS1cxWPli5T
         FUabvG72sQ4QHBvfi2RuoEgZ/EDw0MHvBJwOeI/cQ8JY0FERNFU8B7DUbKiPG3+gkAb5
         I1YpuF63AVIr7LJDFXL2f/ggK45+av79omsoIOtxpAnMoOm1QEsXlKiHmcdq3BtTMgFt
         +qbxttziXLM092+5HaQgDkKRuYn+ZixWJlvCoTlwaZ/b8CzWjbWo4Tjx9hcBzSUCc8nY
         HS7w==
X-Received: by 10.194.82.229 with SMTP id l5mr7394258wjy.140.1449083647470;
        Wed, 02 Dec 2015 11:14:07 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.internal.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id uz5sm4090822wjc.8.2015.12.02.11.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Dec 2015 11:14:06 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
In-Reply-To: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281902>

core.worktree and core.bare, which are treated specially in 31e26eb [1]=
,
are now moved to info/core.worktree and the special treatment
reverted. The test "$GIT_DIR/common overrides core.worktree" in t1501
from 31e26eb verifies that the behavior is still correct after this
change.

A note about core.bare. On the surface it does not make sense for
core.bare to be worktree specific. It's made so in order to "grow" new
worktrees from a bare repo. In these new linked worktrees, core.bare
will be hidden away and worktree-related commands won't complain about
bare repository.

[1] 31e26eb (setup.c: support multi-checkout repo setup - 2014-11-30)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |  4 ++++
 config.c                 |  8 +++++++
 setup.c                  | 62 ++++++++++++++++++++++------------------=
--------
 3 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5c6cd4b..09a8b57 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -454,6 +454,8 @@ linkgit:git-init[1] when the repository was created=
=2E  By default a
 repository that ends in "/.git" is assumed to be not bare (bare =3D
 false), while all other repositories are assumed to be bare (bare
 =3D true).
++
+This variable is per-worktree in multiple working tree setup.
=20
 core.worktree::
 	Set the path to the root of the working tree.
@@ -478,6 +480,8 @@ still use "/different/path" as the root of the work=
 tree and can cause
 confusion unless you know what you are doing (e.g. you are creating a
 read-only snapshot of the same index to a location different from the
 repository's usual working tree).
++
+This variable is per-worktree in multiple working tree setup.
=20
 core.logAllRefUpdates::
 	Enable the reflog. Updates to a ref <ref> is logged to the file
diff --git a/config.c b/config.c
index 75c45e1..54a6219 100644
--- a/config.c
+++ b/config.c
@@ -91,6 +91,11 @@ static long config_buf_ftell(struct config_source *c=
onf)
 	return conf->u.buf.pos;
 }
=20
+static const char* default_config_worktree[] =3D {
+	"core/bare",
+	"core/worktree"
+};
+
 static void load_info_config_worktree(void)
 {
 	struct exclude_list *el =3D &config_local;
@@ -101,6 +106,9 @@ static void load_info_config_worktree(void)
=20
 	clear_exclude_list(el);
=20
+	for (i =3D 0; i < ARRAY_SIZE(default_config_worktree); i++)
+		add_exclude(default_config_worktree[i], "", 0, el, 0);
+
 	if (strbuf_read_file(&sb,
 			     git_path("info/config.worktree"),
 			     128) <=3D 0) {
diff --git a/setup.c b/setup.c
index 0047d40..c088d45 100644
--- a/setup.c
+++ b/setup.c
@@ -355,43 +355,20 @@ void setup_work_tree(void)
 	initialized =3D 1;
 }
=20
-static int check_repo_format(const char *var, const char *value, void =
*cb)
-{
-	const char *ext;
-
-	if (strcmp(var, "core.repositoryformatversion") =3D=3D 0)
-		repository_format_version =3D git_config_int(var, value);
-	else if (strcmp(var, "core.sharedrepository") =3D=3D 0)
-		shared_repository =3D git_config_perm(var, value);
-	else if (skip_prefix(var, "extensions.", &ext)) {
-		/*
-		 * record any known extensions here; otherwise,
-		 * we fall through to recording it as unknown, and
-		 * check_repository_format will complain
-		 */
-		if (!strcmp(ext, "noop"))
-			;
-		else if (!strcmp(ext, "preciousobjects"))
-			repository_format_precious_objects =3D git_config_bool(var, value);
-		else
-			string_list_append(&unknown_extensions, ext);
-	}
-	return 0;
-}
-
 static int check_repository_format_gently(const char *gitdir, int *non=
git_ok)
 {
 	struct strbuf sb =3D STRBUF_INIT;
+	struct strbuf sb2 =3D STRBUF_INIT;
 	const char *repo_config;
-	config_fn_t fn;
+	const char *worktree_config =3D NULL;
 	int ret =3D 0;
=20
 	string_list_clear(&unknown_extensions, 0);
=20
-	if (get_common_dir(&sb, gitdir))
-		fn =3D check_repo_format;
-	else
-		fn =3D check_repository_format_version;
+	if (get_common_dir(&sb, gitdir)) {
+		strbuf_addf(&sb2, "%s/config.worktree", gitdir);
+		worktree_config =3D sb2.buf;
+	}
 	strbuf_addstr(&sb, "/config");
 	repo_config =3D sb.buf;
=20
@@ -404,7 +381,8 @@ static int check_repository_format_gently(const cha=
r *gitdir, int *nongit_ok)
 	 * Use a gentler version of git_config() to check if this repo
 	 * is a good one.
 	 */
-	git_config_early(fn, NULL, repo_config, NULL);
+	git_config_early(check_repository_format_version, NULL,
+			 repo_config, worktree_config);
 	if (GIT_REPO_VERSION_READ < repository_format_version) {
 		if (!nongit_ok)
 			die ("Expected git repo version <=3D %d, found %d",
@@ -431,6 +409,7 @@ static int check_repository_format_gently(const cha=
r *gitdir, int *nongit_ok)
 	}
=20
 	strbuf_release(&sb);
+	strbuf_release(&sb2);
 	return ret;
 }
=20
@@ -963,10 +942,25 @@ int git_config_perm(const char *var, const char *=
value)
=20
 int check_repository_format_version(const char *var, const char *value=
, void *cb)
 {
-	int ret =3D check_repo_format(var, value, cb);
-	if (ret)
-		return ret;
-	if (strcmp(var, "core.bare") =3D=3D 0) {
+	const char *ext;
+
+	if (strcmp(var, "core.repositoryformatversion") =3D=3D 0)
+		repository_format_version =3D git_config_int(var, value);
+	else if (strcmp(var, "core.sharedrepository") =3D=3D 0)
+		shared_repository =3D git_config_perm(var, value);
+	else if (skip_prefix(var, "extensions.", &ext)) {
+		/*
+		 * record any known extensions here; otherwise,
+		 * we fall through to recording it as unknown, and
+		 * check_repository_format will complain
+		 */
+		if (!strcmp(ext, "noop"))
+			;
+		else if (!strcmp(ext, "preciousobjects"))
+			repository_format_precious_objects =3D git_config_bool(var, value);
+		else
+			string_list_append(&unknown_extensions, ext);
+	} else if (strcmp(var, "core.bare") =3D=3D 0) {
 		is_bare_repository_cfg =3D git_config_bool(var, value);
 		if (is_bare_repository_cfg =3D=3D 1)
 			inside_work_tree =3D -1;
--=20
2.2.0.513.g477eb31
