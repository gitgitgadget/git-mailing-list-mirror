From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/6] abspath.c: add and use real_path_dup()
Date: Mon, 18 Jan 2016 18:21:32 +0700
Message-ID: <1453116094-4987-5-git-send-email-pclouds@gmail.com>
References: <1453116094-4987-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 12:04:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aL7bT-00044a-U4
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 12:04:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681AbcARLED convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jan 2016 06:04:03 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35161 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479AbcARLEA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 06:04:00 -0500
Received: by mail-pf0-f195.google.com with SMTP id 65so11614243pff.2
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 03:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=q1VgTlReHPj6ABjT3NuAZPz5PYaYf8OM1ubdwYR7I7o=;
        b=fr+yE8Wq9gWGgwFCMSOD95V70XA6Lu/2+70e6LfBWGN55Gi0FZ/kn55+mHnc4HdWWt
         0vLl/bw9VnAnUDSZqzr9i07+kwaIJC6LVstk1w3G6/eeDzEFharNwunHGaX6vUDYIwP8
         2zzyyt9ktdg2GXvnfaKY69NIQZRnyEXvZC1Gk6CmzkLLuJyQLwJvCRHL9j3WwW812xtx
         +EyYJiFdJZq2G3IGgiqWPbsw27NJX1xzmD7vd16iySHiEroJVvmvfzA5AvRzI5mmQ98q
         TvfBEJz0uBMw4aYMR5NhTx3nmTI6WOvSgFIP/BjWgoLPPz/HTleQ2ZQQ7BOO34h5UYSE
         asOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=q1VgTlReHPj6ABjT3NuAZPz5PYaYf8OM1ubdwYR7I7o=;
        b=FW24zPmTabNUlZKHaqGpknJ50v6oaq+mKmABSMwuWC/uZXRjud38/TlJdjE63cnegW
         BtBKb5nm5APKph4S2Z68QW5XK/v6eCeBNswV3vspTsqbjfVv4B+H1+ynyTQ1wZceFMqv
         UyU1wFKdHrYwXE/K22i/o5JwIjGqAJutgkqvBVpue9E+OrApnVv0qY3kKIwNr/DgLXjo
         xAnK8TfOPOK8N71gbZkJpxiUkLtvybiDPtTis4e8/Sm1qGCiDlSRvFqtaiLDaHG39eaa
         RXpbBvUPE1+aJNH76aD9Zpr8jIktcj24Mnm8BTzsUBsF4ak3DoCePDzos8z4/AVSAJj6
         InTg==
X-Gm-Message-State: ALoCoQnLHSKmDp44ZtyI5KAJvOehSEclcOHCbEiSNadJ+kmPCjXQYLo02mJIKcSgE42KsCqTmslyJscDmTET/Y3GA+sdBm43Bw==
X-Received: by 10.98.67.212 with SMTP id l81mr35479743pfi.90.1453115039639;
        Mon, 18 Jan 2016 03:03:59 -0800 (PST)
Received: from lanh ([115.72.43.83])
        by smtp.gmail.com with ESMTPSA id ud10sm33261713pab.27.2016.01.18.03.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 03:03:58 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 18 Jan 2016 18:22:01 +0700
X-Mailer: git-send-email 2.7.0.96.g5373197
In-Reply-To: <1453116094-4987-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284287>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 abspath.c         | 5 +++++
 builtin/clone.c   | 2 +-
 builtin/init-db.c | 6 +++---
 cache.h           | 1 +
 setup.c           | 2 +-
 5 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/abspath.c b/abspath.c
index 5edb4e7..ca44eb9 100644
--- a/abspath.c
+++ b/abspath.c
@@ -135,6 +135,11 @@ const char *real_path(const char *path)
 	return real_path_internal(path, 1);
 }
=20
+char *real_path_dup(const char *path)
+{
+	return xstrdup(real_path(path));
+}
+
 const char *real_path_if_valid(const char *path)
 {
 	return real_path_internal(path, 0);
diff --git a/builtin/clone.c b/builtin/clone.c
index a0b3cd9..7652e03 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -280,7 +280,7 @@ static int add_one_reference(struct string_list_ite=
m *item, void *cb_data)
 	struct strbuf alternate =3D STRBUF_INIT;
=20
 	/* Beware: read_gitfile(), real_path() and mkpath() return static buf=
fer */
-	ref_git =3D xstrdup(real_path(item->string));
+	ref_git =3D real_path_dup(item->string);
=20
 	repo =3D read_gitfile(ref_git);
 	if (!repo)
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 07229d6..65c95fd 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -315,7 +315,7 @@ int set_git_dir_init(const char *git_dir, const cha=
r *real_git_dir,
 		 * make sure symlinks are resolved because we'll be
 		 * moving the target repo later on in separate_git_dir()
 		 */
-		git_link =3D xstrdup(real_path(git_dir));
+		git_link =3D real_path_dup(git_dir);
 		set_git_dir(real_path(real_git_dir));
 	}
 	else {
@@ -480,7 +480,7 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 	argc =3D parse_options(argc, argv, prefix, init_db_options, init_db_u=
sage, 0);
=20
 	if (real_git_dir && !is_absolute_path(real_git_dir))
-		real_git_dir =3D xstrdup(real_path(real_git_dir));
+		real_git_dir =3D real_path_dup(real_git_dir);
=20
 	if (argc =3D=3D 1) {
 		int mkdir_tried =3D 0;
@@ -551,7 +551,7 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 		const char *git_dir_parent =3D strrchr(git_dir, '/');
 		if (git_dir_parent) {
 			char *rel =3D xstrndup(git_dir, git_dir_parent - git_dir);
-			git_work_tree_cfg =3D xstrdup(real_path(rel));
+			git_work_tree_cfg =3D real_path_dup(rel);
 			free(rel);
 		}
 		if (!git_work_tree_cfg)
diff --git a/cache.h b/cache.h
index c63fcc1..fbe29ac 100644
--- a/cache.h
+++ b/cache.h
@@ -960,6 +960,7 @@ static inline int is_absolute_path(const char *path=
)
 int is_directory(const char *);
 const char *real_path(const char *path);
 const char *real_path_if_valid(const char *path);
+char *real_path_dup(const char *path);
 const char *absolute_path(const char *path);
 const char *remove_leading_path(const char *in, const char *prefix);
 const char *relative_path(const char *in, const char *prefix, struct s=
trbuf *sb);
diff --git a/setup.c b/setup.c
index 6ee2b23..8b02429 100644
--- a/setup.c
+++ b/setup.c
@@ -643,7 +643,7 @@ static const char *setup_discovered_git_dir(const c=
har *gitdir,
 	/* --work-tree is set without --git-dir; use discovered one */
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
 		if (offset !=3D cwd->len && !is_absolute_path(gitdir))
-			gitdir =3D xstrdup(real_path(gitdir));
+			gitdir =3D real_path_dup(gitdir);
 		if (chdir(cwd->buf))
 			die_errno("Could not come back to cwd");
 		return setup_explicit_git_dir(gitdir, cwd, nongit_ok);
--=20
2.7.0.96.g5373197
