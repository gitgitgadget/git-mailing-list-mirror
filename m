Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB55C433F5
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 20:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhLLUOs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 15:14:48 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:33323 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhLLUOj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 15:14:39 -0500
Received: by mail-wr1-f53.google.com with SMTP id d24so23983695wra.0
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 12:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EP4j0ehH52yo5HCw2KVS7d4E3IkAdZ8GCM5tUkQdKzE=;
        b=nNjXp7rGCwfTx2c4cl60QcXrDIXg6ahtXC7U5YxIttFBfvL7U88MhInGEnvlI/HE2x
         uWhxFgQGXyU94fY1lwAaeoR51HeYZtRfy25eUiu7RJmvBwhpTIKh/Pc87mzauTuzPMf3
         Ue1BxIpE4KRvqa6XZpRyEuE5y/XCEfRifMfKhHoufUiWWZxF9uPlCFTO7rQ3TojtnkyE
         gMMNHFlZyy5f/aANehRCDiryhW7ppbkK/B9mdCVXL8yh6up887t7RYFZRdBl6v0iFSDw
         MKHEHBJ1s4bHrZ5umvVV+MP4slIihZ9X/9SeLC9XqG4vLkdd/TPOzeA2inCjC9Pumnb2
         szbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EP4j0ehH52yo5HCw2KVS7d4E3IkAdZ8GCM5tUkQdKzE=;
        b=CqU5Pb21MfVczvxbW06qf6+OgsZw/8kmvMVuUdAg5lMHVORG7JhVpO7J28LAgha+Kh
         VRb54Zzogu9vvK05/dEUPdVAYCYALOiVcfszbDtBTBpw3T6I6nJiy+/UR33Fd3Cc4j8Z
         oRY7wDuLcmQ1fGfw5Oiu7cvB1UWfi2UCXBCVDy9DCkEG8mzlN/5Hr0sjFJm2fF3uCG7l
         /r3cSul7CsolwsKYlFFFGp0k5KIFSOJyUUtubRh5K1ahxFB3YRKsJmlOeBvRmD0dy8RE
         m3ybHRf3p5EslvKOcQ4ub2ZsjDXsPO2/0yXKLt56sykycqlnM3nY09glRIILyC8rfBXB
         H72g==
X-Gm-Message-State: AOAM533j58SvML9kmyGyyQ78LvooG5Kdz8tQIXi9uIgGRZAMIJn1lDv1
        ov7rWB9siDXw800UaoLj3+V6m9PQ1B6V+Q==
X-Google-Smtp-Source: ABdhPJw/mswrQDYtVQocaNOI5MZHN565iVgraOxhvTSxNHoUUpAxh6bUZMqedm3AHRBn0H5HiDtETA==
X-Received: by 2002:a5d:4d07:: with SMTP id z7mr27821815wrt.487.1639340017619;
        Sun, 12 Dec 2021 12:13:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay21sm4824336wmb.7.2021.12.12.12.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 12:13:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/13] init & clone: add a --no-template option
Date:   Sun, 12 Dec 2021 21:13:15 +0100
Message-Id: <patch-05.13-6bbb39f13fc-20211212T201308Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gb1392dd1877
In-Reply-To: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new "--no-template" convenience option to "git init" and "git
clone".

This option is functionally equivalent to the long-standing "trick" of
providing an empty parameter to --template, i.e. "--template=". See
172035f044e (init: handle empty "template" parameter, 2008-07-28).

But that long-standing trick has never been documented, and isn't
obvious. Instead of documenting it let's provide an alternate way of
doing this that conforms with how we usually handle other such cases.

Let's also add a GIT_NO_TEMPLATE_DIR environment variable. For now
this is for consistency with the existing "GIT_TEMPLATE_DIR", but in a
subsequent commit we'll make use of it within "t/test-lib.sh".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-clone.txt |  8 +++++++-
 Documentation/git-init.txt  | 24 +++++++++++++++++++++---
 builtin/clone.c             | 15 ++++++++++++---
 builtin/init-db.c           | 34 ++++++++++++++++++++++++----------
 cache.h                     |  2 ++
 t/t0001-init.sh             |  4 ++++
 6 files changed, 70 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 9685ea06915..0227ee9a4c0 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -9,7 +9,9 @@ git-clone - Clone a repository into a new directory
 SYNOPSIS
 --------
 [verse]
-'git clone' [--template=<template-directory>]
+
+
+'git clone' [--no-template | --template=<template-directory>]
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--dissociate] [--separate-git-dir <git-dir>]
@@ -211,6 +213,10 @@ objects from the source repository into a pack in the cloned repository.
 	via ssh, this specifies a non-default path for the command
 	run on the other end.
 
+--no-template:
+	Specify that no template directory will be used;
+	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
+
 --template=<template-directory>::
 	Specify the directory from which templates will be used;
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index ad921fe782e..d0ce9b185a5 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -9,7 +9,8 @@ git-init - Create an empty Git repository or reinitialize an existing one
 SYNOPSIS
 --------
 [verse]
-'git init' [-q | --quiet] [--bare] [--template=<template-directory>]
+'git init' [-q | --quiet] [--bare]
+	  [--no-template | --template=<template-directory>]
 	  [--separate-git-dir <git-dir>] [--object-format=<format>]
 	  [-b <branch-name> | --initial-branch=<branch-name>]
 	  [--shared[=<permissions>]] [<directory>]
@@ -62,6 +63,12 @@ include::object-format-disclaimer.txt[]
 Specify the directory from which templates will be used.  (See the "TEMPLATE
 DIRECTORY" section below.)
 
+--no-template::
+
+Do not use any template directory. On older versions of git this can
+be emulated by providing a `--template' argument where
+'<template_directory>' is a path to an empty directory.
+
 --separate-git-dir=<git-dir>::
 
 Instead of initializing the repository as a directory to either `$GIT_DIR` or
@@ -132,10 +139,21 @@ does not exist, it will be created.
 TEMPLATE DIRECTORY
 ------------------
 
-Files and directories in the template directory whose name do not start with a
+If a template directory is in use files and directories in the
+template directory whose name do not start with a
 dot will be copied to the `$GIT_DIR` after it is created.
 
-The template directory will be one of the following (in order):
+Using a template template directory can be disabled by any of of:
+
+ - The `--no-template` option being given. This option is incompatible
+   with `--template`.
+
+ - The `GIT_NO_TEMPLATE_DIR` variable being set to `true` in the
+   environment (or any other `true` value. See the discussion of
+   boolean canonicalization in linkgit:git-config[1]).
+
+If none of those conditions are true, then the template directory
+will be one of the following (in order):
 
  - the argument given with the `--template` option;
 
diff --git a/builtin/clone.c b/builtin/clone.c
index fb377b27657..a57ba4da31d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -53,6 +53,7 @@ static int option_shallow_submodules;
 static int option_reject_shallow = -1;    /* unspecified */
 static int config_reject_shallow = -1;    /* unspecified */
 static int deepen;
+static int option_no_template;
 static char *option_template, *option_depth, *option_since;
 static char *option_origin = NULL;
 static char *remote_name = NULL;
@@ -113,8 +114,11 @@ static struct option builtin_clone_options[] = {
 	OPT_ALIAS(0, "recursive", "recurse-submodules"),
 	OPT_INTEGER('j', "jobs", &max_jobs,
 		    N_("number of submodules cloned in parallel")),
-	OPT_STRING(0, "template", &option_template, N_("template-directory"),
-		   N_("directory from which templates will be used")),
+	OPT_BOOL_F(0, "no-template", &option_no_template, N_("do not use a template"),
+		   PARSE_OPT_NONEG | PARSE_OPT_HIDDEN),
+	OPT_STRING_F(0, "template", &option_template, N_("template-directory"),
+		     N_("directory from which templates will be used"),
+		     PARSE_OPT_NONEG),
 	OPT_STRING_LIST(0, "reference", &option_required_reference, N_("repo"),
 			N_("reference repository")),
 	OPT_STRING_LIST(0, "reference-if-able", &option_optional_reference,
@@ -907,6 +911,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
+	if (option_no_template && option_template)
+		die(_("--no-template and --template are incompatible."));
+
 	repo_name = argv[0];
 
 	path = get_repo_path(repo_name, &is_bundle);
@@ -1037,7 +1044,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, NULL,
+	init_db(git_dir, real_git_dir,
+		option_no_template, option_template,
+		GIT_HASH_UNKNOWN, NULL,
 		INIT_DB_QUIET);
 
 	if (real_git_dir) {
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 75495c9c8c6..4c4ff6fe412 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -93,7 +93,8 @@ static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
 	}
 }
 
-static void copy_templates(const char *template_dir, const char *init_template_dir)
+static void copy_templates(int no_template, const char *template_dir,
+			   const char *init_template_dir)
 {
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf template_path = STRBUF_INIT;
@@ -103,6 +104,11 @@ static void copy_templates(const char *template_dir, const char *init_template_d
 	DIR *dir;
 	char *to_free = NULL;
 
+	if (no_template)
+		return;
+	if (!template_dir && !init_template_dir &&
+	    git_env_bool(GIT_NO_TEMPLATE_DIR_ENVIRONMENT, 0))
+		return;
 	if (!template_dir)
 		template_dir = getenv(TEMPLATE_DIR_ENVIRONMENT);
 	if (!template_dir)
@@ -187,7 +193,7 @@ void initialize_repository_version(int hash_algo, int reinit)
 		git_config_set_gently("extensions.objectformat", NULL);
 }
 
-static void create_template_files(const char *template_path)
+static void create_template_files(int no_template, const char *template_path)
 {
 	const char *init_template_dir = NULL;
 
@@ -201,7 +207,7 @@ static void create_template_files(const char *template_path)
 	 * disk).
 	 */
 	git_config_get_pathname("init.templatedir", &init_template_dir);
-	copy_templates(template_path, init_template_dir);
+	copy_templates(no_template, template_path, init_template_dir);
 	free((char *)init_template_dir);
 	git_config_clear();
 	reset_shared_repository();
@@ -391,7 +397,8 @@ static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
 }
 
 int init_db(const char *git_dir, const char *real_git_dir,
-	    const char *template_dir, int hash, const char *initial_branch,
+	    int no_template, const char *template_dir,
+	    int hash, const char *initial_branch,
 	    unsigned int flags)
 {
 	int reinit;
@@ -434,7 +441,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 
 	validate_hash_algorithm(&repo_fmt, hash);
 
-	create_template_files(template_dir);
+	create_template_files(no_template, template_dir);
 	reinit = create_default_files(original_git_dir,
 				      initial_branch, &repo_fmt,
 				      flags & INIT_DB_QUIET);
@@ -525,7 +532,7 @@ static int shared_callback(const struct option *opt, const char *arg, int unset)
 }
 
 static const char *const init_db_usage[] = {
-	N_("git init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]] [<directory>]"),
+	N_("git init [-q | --quiet] [--bare] [--no-template | --template=<template-directory>] [--shared[=<permissions>]] [<directory>]"),
 	NULL
 };
 
@@ -540,14 +547,18 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	const char *git_dir;
 	const char *real_git_dir = NULL;
 	const char *work_tree;
+	int no_template = 0;
 	const char *template_dir = NULL;
 	unsigned int flags = 0;
 	const char *object_format = NULL;
 	const char *initial_branch = NULL;
 	int hash_algo = GIT_HASH_UNKNOWN;
 	const struct option init_db_options[] = {
-		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
-				N_("directory from which templates will be used")),
+		OPT_BOOL_F(0, "no-template", &no_template, N_("do not use a template"),
+			   PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "template", &template_dir, N_("template-directory"),
+			     N_("directory from which templates will be used"),
+			     PARSE_OPT_NONEG),
 		OPT_SET_INT(0, "bare", &is_bare_repository_cfg,
 				N_("create a bare repository"), 1),
 		{ OPTION_CALLBACK, 0, "shared", &init_shared_repository,
@@ -572,6 +583,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	if (real_git_dir && !is_absolute_path(real_git_dir))
 		real_git_dir = real_pathdup(real_git_dir, 1);
 
+	if (no_template && template_dir)
+		die(_("--no-template and --template are incompatible"));
 	if (template_dir && *template_dir && !is_absolute_path(template_dir)) {
 		template_dir = absolute_pathdup(template_dir);
 		UNLEAK(template_dir);
@@ -701,6 +714,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	UNLEAK(work_tree);
 
 	flags |= INIT_DB_EXIST_OK;
-	return init_db(git_dir, real_git_dir, template_dir, hash_algo,
-		       initial_branch, flags);
+	return init_db(git_dir, real_git_dir,
+		       no_template, template_dir,
+		       hash_algo, initial_branch, flags);
 }
diff --git a/cache.h b/cache.h
index d5cafba17d4..d2c7b5e1899 100644
--- a/cache.h
+++ b/cache.h
@@ -498,6 +498,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define GRAFT_ENVIRONMENT "GIT_GRAFT_FILE"
 #define GIT_SHALLOW_FILE_ENVIRONMENT "GIT_SHALLOW_FILE"
 #define TEMPLATE_DIR_ENVIRONMENT "GIT_TEMPLATE_DIR"
+#define GIT_NO_TEMPLATE_DIR_ENVIRONMENT "GIT_NO_TEMPLATE_DIR"
 #define CONFIG_ENVIRONMENT "GIT_CONFIG"
 #define CONFIG_DATA_ENVIRONMENT "GIT_CONFIG_PARAMETERS"
 #define CONFIG_COUNT_ENVIRONMENT "GIT_CONFIG_COUNT"
@@ -656,6 +657,7 @@ int path_inside_repo(const char *prefix, const char *path);
 #define INIT_DB_EXIST_OK 0x0002
 
 int init_db(const char *git_dir, const char *real_git_dir,
+	    int no_template,
 	    const char *template_dir, int hash_algo,
 	    const char *initial_branch, unsigned int flags);
 void initialize_repository_version(int hash_algo, int reinit);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index e0b965cdc8f..388c28062c2 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -173,6 +173,10 @@ test_expect_success 'reinit' '
 	test_must_be_empty again/err2
 '
 
+test_expect_success 'usage: init with --no-template --template' '
+	test_expect_code 128 git init --no-template --template=$PWD
+'
+
 setup_template_priority() {
 	test_when_finished "rm -rf template" &&
 	mkdir template &&
-- 
2.34.1.1020.gb1392dd1877

