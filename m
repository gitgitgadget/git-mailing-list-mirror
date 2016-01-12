From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 15/21] init: allow alternate backends to be set for new repos
Date: Mon, 11 Jan 2016 20:22:14 -0500
Message-ID: <1452561740-8668-16-git-send-email-dturner@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jan 12 02:23:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIng3-0003Vs-UV
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 02:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761927AbcALBXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 20:23:12 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33593 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761843AbcALBWt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 20:22:49 -0500
Received: by mail-qk0-f180.google.com with SMTP id p186so153621454qke.0
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 17:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+IOjp9LGTWw3YDPisUPg/7vVaHtAXg3Cg8WC3n+C8TA=;
        b=VYxJ8i+umes8TF4tPkH2wdivKV+XRQrBc1HkmKFdL8XCjjsBmYvX+Q/0WilLHLD7Bi
         KMi2Szzm2Izz6AAkWun2ifuPPgWCp32kJ7xNhRBgsKWfrS52IHRSN6Ht9kVeHh0cCojD
         PTwhbo27Wg61TXDui523eyqRC5mcRHVSnzsl+K2cywsEBegRgvtXH7/PDggFvevgOF9V
         9DW5Q7fYHq7pa2jsaxkSWn4NSrA7gqMiV50Q28+ScvX1N9OHZ3klJbDxj/zhzz+gnr5P
         7toqv4m3YxiOAgl1WEGZRWQmHyjJ+fgZIYItQ0F25p1kZcjOPIY1luZgIpdh9Xjgs2fJ
         BOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+IOjp9LGTWw3YDPisUPg/7vVaHtAXg3Cg8WC3n+C8TA=;
        b=SZY+QrQXvk9s2E9/nNIZ48tAt2dDRlVm3JgL+knOfEYqdg9AaZuYDVDqjnSWKaHI0c
         M5tBCv0sd6QK3bdzbQ4wIFBb58LUck6nF7tGuyZgyu9PBhndu5z+pM47rQ1JfCeHhvgW
         X0RrYw41zlWQvWFYkxcY0I4FaLX0N80YWOpJYMzOY6grssoLS3I1kNliYeHF959jU4AC
         yGrR61XiPtcZj7TXwwoiyHMOVIdTmC/ucKelKutOfBAmrkA1FBy9LqjMbxrXvZDsLImG
         6yGjXI30kXeRGwbWOv/UU7OV3GKpf/1p5rJF8YNERPVwqY71hT8L2/3A6KqPD2ijSWMB
         fCCA==
X-Gm-Message-State: ALoCoQk07NzfyYWvvg+RHbkjAq8ucKCijX20IZanCLeDKZYeACwNbymo6tCvqP8t3HZSsYHdUqZ8H1jOjAFdQorNwKR4z5wLkg==
X-Received: by 10.55.81.70 with SMTP id f67mr46668591qkb.28.1452561768986;
        Mon, 11 Jan 2016 17:22:48 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id d64sm55362053qgd.48.2016.01.11.17.22.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jan 2016 17:22:47 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283751>

git init learns a new argument --ref-storage.  Presently, only
"files" is supported, but later we will add other backends.

When this argument is used, the repository's extensions.refStorage
configuration value is set (as well as core.repositoryformatversion),
and the refs backend's initdb function is used to set up the ref
database.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-init-db.txt |  2 +-
 Documentation/git-init.txt    |  7 ++++++-
 builtin/init-db.c             | 31 ++++++++++++++++++++++++++-----
 cache.h                       |  2 ++
 path.c                        | 29 +++++++++++++++++++++++++++--
 refs.c                        |  8 ++++++++
 refs.h                        |  8 ++++++++
 setup.c                       | 12 ++++++++++++
 t/t0001-init.sh               | 24 ++++++++++++++++++++++++
 9 files changed, 114 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index 648a6cd..d03fb69 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -9,7 +9,7 @@ git-init-db - Creates an empty Git repository
 SYNOPSIS
 --------
 [verse]
-'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]]
+'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]] [--ref-storage=<name>]
 
 
 DESCRIPTION
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 8174d27..d2b150f 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
 	  [--separate-git-dir <git dir>]
 	  [--shared[=<permissions>]] [directory]
-
+	  [--ref-storage=<name>]
 
 DESCRIPTION
 -----------
@@ -113,6 +113,11 @@ does not exist, it will be created.
 
 --
 
+--ref-storage=<name>::
+Type of refs storage backend. Default is to use the original "files"
+storage, which stores ref data in files in .git/refs and
+.git/packed-refs.
+
 TEMPLATE DIRECTORY
 ------------------
 
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 4771e7e..ebc747c 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -24,6 +24,7 @@ static int init_is_bare_repository = 0;
 static int init_shared_repository = -1;
 static const char *init_db_template_dir;
 static const char *git_link;
+static char *requested_ref_storage_backend;
 
 static void copy_templates_1(struct strbuf *path, struct strbuf *template,
 			     DIR *dir)
@@ -179,6 +180,7 @@ static int create_default_files(const char *template_path)
 	int reinit;
 	int filemode;
 	struct strbuf err = STRBUF_INIT;
+	int repo_version = 0;
 
 	/* Just look for `init.templatedir` */
 	git_config(git_init_db_config, NULL);
@@ -204,9 +206,6 @@ static int create_default_files(const char *template_path)
 		adjust_shared_perm(get_git_dir());
 	}
 
-	if (refs_init_db(&err, shared_repository))
-		die("failed to set up refs db: %s", err.buf);
-
 	/*
 	 * Create the default symlink from ".git/HEAD" to the "master"
 	 * branch, if it does not exist yet.
@@ -214,14 +213,34 @@ static int create_default_files(const char *template_path)
 	path = git_path_buf(&buf, "HEAD");
 	reinit = (!access(path, R_OK)
 		  || readlink(path, junk, sizeof(junk)-1) != -1);
-	if (!reinit) {
+	if (reinit) {
+		if (requested_ref_storage_backend &&
+		    strcmp(ref_storage_backend, requested_ref_storage_backend))
+			die("You can't change the refs storage type (was %s; you requested %s)",
+			    ref_storage_backend, requested_ref_storage_backend);
+	} else {
 		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
 			exit(1);
 	}
 
+	if (requested_ref_storage_backend)
+		ref_storage_backend = requested_ref_storage_backend;
+	if (strcmp(ref_storage_backend, "files")) {
+		git_config_set("extensions.refStorage", ref_storage_backend);
+		git_config_set("core.repositoryformatversion", ref_storage_backend);
+#ifdef USE_LIBLMDB
+		register_ref_storage_backend(&refs_be_lmdb);
+#endif
+		set_ref_storage_backend(ref_storage_backend);
+		repo_version = 1;
+	}
+
+	if (refs_init_db(&err, shared_repository))
+		die("failed to set up refs db: %s", err.buf);
+
 	/* This forces creation of new config file */
 	xsnprintf(repo_version_string, sizeof(repo_version_string),
-		  "%d", GIT_REPO_VERSION);
+		  "%d", repo_version);
 	git_config_set("core.repositoryformatversion", repo_version_string);
 
 	/* Check filemode trustability */
@@ -469,6 +488,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 			   N_("separate git dir from working tree")),
+		OPT_STRING(0, "ref-storage", &requested_ref_storage_backend,
+			   N_("name"), N_("name of backend type to use")),
 		OPT_END()
 	};
 
diff --git a/cache.h b/cache.h
index 51c35c3..d5297f2 100644
--- a/cache.h
+++ b/cache.h
@@ -696,6 +696,8 @@ extern enum object_creation_mode object_creation_mode;
 
 extern char *notes_ref_name;
 
+extern const char *ref_storage_backend;
+
 extern int grafts_replace_parents;
 
 /*
diff --git a/path.c b/path.c
index 3cd155e..be01cdd 100644
--- a/path.c
+++ b/path.c
@@ -2,6 +2,7 @@
  * Utilities for paths and pathnames
  */
 #include "cache.h"
+#include "refs.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "dir.h"
@@ -511,8 +512,32 @@ int validate_headref(const char *path)
 	int fd;
 	ssize_t len;
 
-	if (lstat(path, &st) < 0)
-		return -1;
+	if (lstat(path, &st) < 0) {
+		int backend_type_set;
+		struct strbuf config_path = STRBUF_INIT;
+		char *pathdup = xstrdup(path);
+		char *git_dir = dirname(pathdup);
+		char *storage = NULL;
+
+		strbuf_addf(&config_path, "%s/%s", git_dir, "config");
+		free(pathdup);
+
+		if (git_config_from_file(ref_storage_backend_config,
+					 config_path.buf, &storage)) {
+			strbuf_release(&config_path);
+			return -1;
+		}
+
+		backend_type_set = !!storage;
+		free((void *)storage);
+		strbuf_release(&config_path);
+		/*
+		 * Alternate backends are assumed to keep HEAD
+		 * in a valid state, so there's no need to do
+		 * further validation.
+		 */
+		return backend_type_set ? 0 : -1;
+	}
 
 	/* Make sure it is a "refs/.." symlink */
 	if (S_ISLNK(st.st_mode)) {
diff --git a/refs.c b/refs.c
index d035feb..07f1dab 100644
--- a/refs.c
+++ b/refs.c
@@ -24,6 +24,14 @@ static struct ref_storage_be *the_refs_backend = &refs_be_files;
  */
 static struct ref_storage_be *refs_backends = &refs_be_files;
 
+const char *ref_storage_backend = "files";
+
+void register_ref_storage_backend(struct ref_storage_be *be)
+{
+	be->next = refs_backends;
+	refs_backends = be;
+}
+
 int set_ref_storage_backend(const char *name)
 {
 	struct ref_storage_be *be;
diff --git a/refs.h b/refs.h
index df7bfc4..7a27c94 100644
--- a/refs.h
+++ b/refs.h
@@ -511,8 +511,16 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 			 void *policy_cb_data);
 
 /*
+ * Read the refdb storage backend name out of the config file
+ */
+int ref_storage_backend_config(const char *var, const char *value, void *ptr);
+
+struct ref_storage_be;
+/*
  * Switch to an alternate ref storage backend.
  */
 int set_ref_storage_backend(const char *name);
 
+void register_ref_storage_backend(struct ref_storage_be *be);
+
 #endif /* REFS_H */
diff --git a/setup.c b/setup.c
index d343725..a329a51 100644
--- a/setup.c
+++ b/setup.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "dir.h"
+#include "refs.h"
 #include "string-list.h"
 
 static int inside_git_dir = -1;
@@ -263,6 +264,15 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
 	return ret;
 }
 
+int ref_storage_backend_config(const char *var, const char *value, void *ptr)
+{
+	char **cdata = ptr;
+
+	if (!strcmp(var, "extensions.refstorage"))
+		*cdata = xstrdup(value);
+	return 0;
+}
+
 /*
  * Test if it looks like we're at a git directory.
  * We want to see:
@@ -373,6 +383,8 @@ static int check_repo_format(const char *var, const char *value, void *cb)
 			;
 		else if (!strcmp(ext, "preciousobjects"))
 			repository_format_precious_objects = git_config_bool(var, value);
+		else if (!strcmp(ext, "refstorage"))
+			ref_storage_backend = xstrdup(value);
 		else
 			string_list_append(&unknown_extensions, ext);
 	}
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index f91bbcf..7f754a3 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -157,6 +157,30 @@ test_expect_success 'reinit' '
 	test_i18ncmp again/empty again/err2
 '
 
+test_expect_success 'init with bogus storage backend fails' '
+
+	(
+		mkdir again2 &&
+		cd again2 &&
+		git init --ref-storage=test >out2 2>err2
+	)
+'
+
+test_expect_failure 'reinit with changed storage backend fails' '
+
+	(
+		mkdir again3 &&
+		cd again3 &&
+		git init >out1 2>err1 &&
+		git init --ref-storage=test >out2 2>err2
+	) &&
+	test_i18ngrep "Initialized empty" again3/out1 &&
+	test_i18ngrep "Reinitialized existing" again3/out2 &&
+	>again3/empty &&
+	test_i18ncmp again3/empty again3/err1 &&
+	test_i18ncmp again3/empty again3/err2
+'
+
 test_expect_success 'init with --template' '
 	mkdir template-source &&
 	echo content >template-source/file &&
-- 
2.4.2.749.g730654d-twtrsrc
