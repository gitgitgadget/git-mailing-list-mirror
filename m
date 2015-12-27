From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/6] setup.c: remove special case of core.worktree and core.bare
Date: Sun, 27 Dec 2015 10:14:36 +0700
Message-ID: <1451186079-6119-4-git-send-email-pclouds@gmail.com>
References: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
 <1451186079-6119-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@drmicha.warpmail.net, max@max630.net, Jens.Lehmann@web.de,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 27 04:15:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aD1ni-0003O8-IT
	for gcvg-git-2@plane.gmane.org; Sun, 27 Dec 2015 04:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbbL0DPN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Dec 2015 22:15:13 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33220 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494AbbL0DPM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2015 22:15:12 -0500
Received: by mail-pa0-f45.google.com with SMTP id cy9so93826026pac.0
        for <git@vger.kernel.org>; Sat, 26 Dec 2015 19:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tK4Idc69D50Tc0SuEKPP/+l1Qhog50YpxRZoM9Su4ZE=;
        b=W4bWiGMLzduPtfN6z0mXx7eIsOXErCSQSFFO2dTUK4yXIcP/TR6m81TnZv9GAc6OAv
         g3gVi3s0vSIZ3GrKfzUep4DG5bKqbDTtxT7a46tMdR1rtE3zRCGmsYEYSH4FC0joVTYd
         8KC/b9IunEctKtupRetmJchsG0a7+rq4594ZZZ0G9BqzIzt0o0sHIKi81aG1Plpz5JnP
         F2PeQojWuC+mtUJcZod139yblFZlSn4QgrcQyNEEWY7QG4xdrA623ZjFRaTOgcLQQRcx
         nSUZsN5oSDNV6KSV6yc4heRiSZAu3OoSEsdiLjyA7vgun1P1hn2SSEXoMegWIMzrLd4y
         0I4A==
X-Received: by 10.66.219.194 with SMTP id pq2mr69128032pac.107.1451186110836;
        Sat, 26 Dec 2015 19:15:10 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id hz8sm72822501pac.10.2015.12.26.19.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Dec 2015 19:15:09 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 27 Dec 2015 10:15:16 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283011>

core.worktree and core.bare, which are treated specially in 31e26eb [1]=
,
are now defined per-worktree with repo extension worktree=3D1 and the
special treatment reverted. The test "$GIT_DIR/common overrides
core.worktree" in t1501 from 31e26eb verifies that the behavior is
still correct after this change.

A note about core.bare. On the surface it does not make sense for
core.bare to be worktree specific. It's made so in order to "grow" new
worktrees from a bare repo. In these new linked worktrees, core.bare
will be hidden away and worktree-related commands won't complain about
bare repository.

[1] 31e26eb (setup.c: support multi-checkout repo setup - 2014-11-30)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt                 |  1 +
 Documentation/technical/repository-version.txt |  3 ++
 config.c                                       |  2 +
 setup.c                                        | 68 ++++++++++++------=
--------
 4 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index bc0734c..087b35e 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -157,6 +157,7 @@ $GIT_COMMON_DIR/worktrees/X/config. Even though per=
-working tree
 variables for the main working tree are in the default config place,
 they are invisible from all linked working trees. The following
 configuration variables are per working directory:
+core.bare, core.worktree.
=20
 LIST OUTPUT FORMAT
 ------------------
diff --git a/Documentation/technical/repository-version.txt b/Documenta=
tion/technical/repository-version.txt
index c680528..fc2cdb9 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -92,3 +92,6 @@ objects in the repository MUST NOT be deleted (e.g., =
by `git-prune` or
=20
 Define behavior in multiple worktree setup. The value specifies the
 version. Default version is zero.
+
+In version 1, the following config variables are per-worktree:
+core.bare, core.worktree.
diff --git a/config.c b/config.c
index 7d94f21..c2ea91b 100644
--- a/config.c
+++ b/config.c
@@ -48,6 +48,8 @@ static struct config_source *cf;
 static int zlib_compression_seen;
=20
 static struct config_pattern worktree_v1[] =3D {
+	{ 0, 0, "core.bare" },
+	{ 0, 0, "core.worktree" },
 	{ 0, 0, NULL }
 };
=20
diff --git a/setup.c b/setup.c
index 9196945..b49d61e 100644
--- a/setup.c
+++ b/setup.c
@@ -355,46 +355,20 @@ void setup_work_tree(void)
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
-		else if (!strcmp(ext, "worktree"))
-			repository_format_worktree_version =3D
-				git_config_ulong(var, value);
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
@@ -407,7 +381,8 @@ static int check_repository_format_gently(const cha=
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
@@ -434,6 +409,7 @@ static int check_repository_format_gently(const cha=
r *gitdir, int *nongit_ok)
 	}
=20
 	strbuf_release(&sb);
+	strbuf_release(&sb2);
 	return ret;
 }
=20
@@ -966,10 +942,28 @@ int git_config_perm(const char *var, const char *=
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
+		else if (!strcmp(ext, "worktree"))
+			repository_format_worktree_version =3D
+				git_config_ulong(var, value);
+		else
+			string_list_append(&unknown_extensions, ext);
+	} else if (strcmp(var, "core.bare") =3D=3D 0) {
 		is_bare_repository_cfg =3D git_config_bool(var, value);
 		if (is_bare_repository_cfg =3D=3D 1)
 			inside_work_tree =3D -1;
--=20
2.3.0.rc1.137.g477eb31
