Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96309C4321A
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 20:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5107A64F88
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 20:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbhCLUUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 15:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbhCLUUK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 15:20:10 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F72EC061761
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 12:20:10 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo15882749wmq.4
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 12:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O3UKttDzoutI+kfO8VDHaWMDOLai8aXlBBoKroTcbQk=;
        b=pnBmLdlXUULsE+2C2Tqs/Tve8y8jTvmJWTcaEIGjUfcrLVQo20qKyt29gXruiB+lXc
         Og4k5CpWCrlVtq1+auAWQXgvlD+5i768vQNW5opWXzBPToRaWhl1Uk0C/r6KsXc61IUz
         DvC02cEvbqMjm7X8iwnRf5CKEy6uRgDI/gqL99lHT4KjhazEfjqrzM5TP5KHll9xThSr
         OMbQlnE5TWzRL4jbZfdm6OwZo1SKABSd1sURU2bUSzRHQC3X70Ss4ecLTBkB+/UickhP
         V9p8m3WHTnwvl6gkXTYzW/8+//kJZkQ6W5jwZFnr0z/sG7iBMhLi4p3XvwpF+6cYRiL5
         TvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O3UKttDzoutI+kfO8VDHaWMDOLai8aXlBBoKroTcbQk=;
        b=HFnWb/tZqH4oTJIDMxrrMgsQsFsSGysQXEDJSAMuBamOTWB+/bRa1E89uh1l2uisCs
         QqCsv4b1Mm1/XyJxlJWUYjLC9br32VkWl1LeSoJbQ5wALMcmfcUx+3MEUuw+A+iHNpHm
         QQOa3PUJqsO5fjhNg0MNXipJ5vVDL1E53mKQQWWO/kew8BaNfWZKOrhQsjzqp+7v6qy1
         GhZ9BI3COWnBFL1NtYPffDYKrUtGvP2rKhZSsK+P056y10W7mwbTax5/CF8W6hzVVIbB
         V/24ATgOPpS/APpwEP9uNbduqEf+9k0oPSt/pyM3Tbc+L4cPEEFdkIr3eQtWOMoitasN
         mF7Q==
X-Gm-Message-State: AOAM531gmfDJMDWeeqpzXhSBA3Ob6BtFG185sxq+qJwz4QXI1Hih2CvH
        C7LphkWxUBUVi0lwhvYBN1FC0bzVQyI=
X-Google-Smtp-Source: ABdhPJyeA7OvVl89WVgs9iMwCqJ/yA5nFwU5W0Bhjhrw3L3GSYnpJTDzbISuFzUQS95LLxWUuTXZFQ==
X-Received: by 2002:a05:600c:19ce:: with SMTP id u14mr13970642wmq.109.1615580408499;
        Fri, 12 Mar 2021 12:20:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q19sm9533339wrg.80.2021.03.12.12.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:20:08 -0800 (PST)
Message-Id: <bdb19af22cc7c4f3383f03f42cb4906c3ec5c5f3.1615580397.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
References: <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
        <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Mar 2021 20:19:54 +0000
Subject: [PATCH v5 13/15] Reftable support for git-core
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

For background, see the previous commit introducing the library.

This introduces the file refs/reftable-backend.c containing a reftable-powered
ref storage backend.

It can be activated by passing --ref-storage=reftable to "git init", or setting
GIT_TEST_REFTABLE in the environment.

Example use: see t/t0031-reftable.sh

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Junio Hamano <gitster@pobox.com>
Co-authored-by: Jeff King <peff@peff.net>
---
 Documentation/config/extensions.txt           |    9 +
 .../technical/repository-version.txt          |    7 +
 Makefile                                      |    4 +
 builtin/clone.c                               |    5 +-
 builtin/init-db.c                             |   55 +-
 builtin/worktree.c                            |   27 +-
 cache.h                                       |    8 +-
 config.mak.uname                              |    2 +-
 contrib/buildsystems/Generators/Vcxproj.pm    |   11 +-
 refs.c                                        |   27 +-
 refs.h                                        |    3 +
 refs/refs-internal.h                          |    1 +
 refs/reftable-backend.c                       | 1446 +++++++++++++++++
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 setup.c                                       |    9 +-
 t/t0031-reftable.sh                           |  203 +++
 t/t1409-avoid-packing-refs.sh                 |    6 +
 t/t1450-fsck.sh                               |    6 +
 t/t3210-pack-refs.sh                          |    6 +
 t/test-lib.sh                                 |    5 +
 21 files changed, 1812 insertions(+), 33 deletions(-)
 create mode 100644 refs/reftable-backend.c
 create mode 100755 t/t0031-reftable.sh

diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
index 4e23d73cdcad..82c5940f1434 100644
--- a/Documentation/config/extensions.txt
+++ b/Documentation/config/extensions.txt
@@ -6,3 +6,12 @@ extensions.objectFormat::
 Note that this setting should only be set by linkgit:git-init[1] or
 linkgit:git-clone[1].  Trying to change it after initialization will not
 work and will produce hard-to-diagnose issues.
++
+extensions.refStorage::
+	Specify the ref storage mechanism to use.  The acceptable values are `files` and
+	`reftable`.  If not specified, `files` is assumed.  It is an error to specify
+	this key unless `core.repositoryFormatVersion` is 1.
++
+Note that this setting should only be set by linkgit:git-init[1] or
+linkgit:git-clone[1].  Trying to change it after initialization will not
+work and will produce hard-to-diagnose issues.
diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
index 7844ef30ffde..725762358333 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -100,3 +100,10 @@ If set, by default "git config" reads from both "config" and
 multiple working directory mode, "config" file is shared while
 "config.worktree" is per-working directory (i.e., it's in
 GIT_COMMON_DIR/worktrees/<id>/config.worktree)
+
+==== `refStorage`
+
+Specifies the file format for the ref database. Values are `files`
+(for the traditional packed + loose ref format) and `reftable` for the
+binary reftable format. See https://github.com/google/reftable for
+more information.
diff --git a/Makefile b/Makefile
index a00cc17ec781..90c204501739 100644
--- a/Makefile
+++ b/Makefile
@@ -967,6 +967,7 @@ LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
 LIB_OBJS += refs/debug.o
 LIB_OBJS += refs/files-backend.o
+LIB_OBJS += refs/reftable-backend.o
 LIB_OBJS += refs/iterator.o
 LIB_OBJS += refs/packed-backend.o
 LIB_OBJS += refs/ref-cache.o
@@ -2401,8 +2402,11 @@ REFTABLE_OBJS += reftable/zlib-compat.o
 
 REFTABLE_TEST_OBJS += reftable/basics_test.o
 REFTABLE_TEST_OBJS += reftable/block_test.o
+REFTABLE_TEST_OBJS += reftable/merged_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
+REFTABLE_TEST_OBJS += reftable/refname_test.o
 REFTABLE_TEST_OBJS += reftable/reftable_test.o
+REFTABLE_TEST_OBJS += reftable/stack_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
 REFTABLE_TEST_OBJS += reftable/tree_test.o
 
diff --git a/builtin/clone.c b/builtin/clone.c
index 51e844a2de0a..6eee72d1ffe5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1139,7 +1139,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, NULL,
-		INIT_DB_QUIET);
+		default_ref_storage(), INIT_DB_QUIET);
 
 	if (real_git_dir)
 		git_dir = real_git_dir;
@@ -1277,7 +1277,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		 * Now that we know what algorithm the remote side is using,
 		 * let's set ours to the same thing.
 		 */
-		initialize_repository_version(hash_algo, 1);
+		initialize_repository_version(hash_algo, 1,
+					      default_ref_storage());
 		repo_set_hash_algo(the_repository, hash_algo);
 
 		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 7766661a4755..c4fb62056344 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -179,12 +179,14 @@ static int needs_work_tree_config(const char *git_dir, const char *work_tree)
 	return 1;
 }
 
-void initialize_repository_version(int hash_algo, int reinit)
+void initialize_repository_version(int hash_algo, int reinit,
+				   const char *ref_storage_format)
 {
 	char repo_version_string[10];
 	int repo_version = GIT_REPO_VERSION;
 
-	if (hash_algo != GIT_HASH_SHA1)
+	if (hash_algo != GIT_HASH_SHA1 ||
+	    !strcmp(ref_storage_format, "reftable"))
 		repo_version = GIT_REPO_VERSION_READ;
 
 	/* This forces creation of new config file */
@@ -238,6 +240,7 @@ static int create_default_files(const char *template_path,
 	is_bare_repository_cfg = init_is_bare_repository;
 	if (init_shared_repository != -1)
 		set_shared_repository(init_shared_repository);
+	the_repository->ref_storage_format = xstrdup(fmt->ref_storage);
 
 	/*
 	 * We would have created the above under user's umask -- under
@@ -247,6 +250,24 @@ static int create_default_files(const char *template_path,
 		adjust_shared_perm(get_git_dir());
 	}
 
+	/*
+	 * Check to see if .git/HEAD exists; this must happen before
+	 * initializing the ref db, because we want to see if there is an
+	 * existing HEAD.
+	 */
+	path = git_path_buf(&buf, "HEAD");
+	reinit = (!access(path, R_OK) ||
+		  readlink(path, junk, sizeof(junk) - 1) != -1);
+
+	/*
+	 * refs/heads is a file when using reftable. We can't reinitialize with
+	 * a reftable because it will overwrite HEAD
+	 */
+	if (reinit && (!strcmp(fmt->ref_storage, "reftable")) ==
+			      is_directory(git_path_buf(&buf, "refs/heads"))) {
+		die("cannot switch ref storage format.");
+	}
+
 	/*
 	 * We need to create a "refs" dir in any case so that older
 	 * versions of git can tell that this is a repository.
@@ -261,9 +282,6 @@ static int create_default_files(const char *template_path,
 	 * Point the HEAD symref to the initial branch with if HEAD does
 	 * not yet exist.
 	 */
-	path = git_path_buf(&buf, "HEAD");
-	reinit = (!access(path, R_OK)
-		  || readlink(path, junk, sizeof(junk)-1) != -1);
 	if (!reinit) {
 		char *ref;
 
@@ -280,7 +298,7 @@ static int create_default_files(const char *template_path,
 		free(ref);
 	}
 
-	initialize_repository_version(fmt->hash_algo, 0);
+	initialize_repository_version(fmt->hash_algo, 0, fmt->ref_storage);
 
 	/* Check filemode trustability */
 	path = git_path_buf(&buf, "config");
@@ -396,7 +414,7 @@ static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
 
 int init_db(const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash, const char *initial_branch,
-	    unsigned int flags)
+	    const char *ref_storage_format, unsigned int flags)
 {
 	int reinit;
 	int exist_ok = flags & INIT_DB_EXIST_OK;
@@ -435,6 +453,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
 	check_repository_format(&repo_fmt);
+	repo_fmt.ref_storage = xstrdup(ref_storage_format);
 
 	validate_hash_algorithm(&repo_fmt, hash);
 
@@ -489,6 +508,9 @@ int init_db(const char *git_dir, const char *real_git_dir,
 		git_config_set("receive.denyNonFastforwards", "true");
 	}
 
+	if (!strcmp(ref_storage_format, "reftable"))
+		git_config_set("extensions.refStorage", ref_storage_format);
+
 	if (!(flags & INIT_DB_QUIET)) {
 		int len = strlen(git_dir);
 
@@ -562,6 +584,7 @@ static const char *const init_db_usage[] = {
 int cmd_init_db(int argc, const char **argv, const char *prefix)
 {
 	const char *git_dir;
+	const char *ref_storage_format = default_ref_storage();
 	const char *real_git_dir = NULL;
 	const char *work_tree;
 	const char *template_dir = NULL;
@@ -570,15 +593,18 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	const char *initial_branch = NULL;
 	int hash_algo = GIT_HASH_UNKNOWN;
 	const struct option init_db_options[] = {
-		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
-				N_("directory from which templates will be used")),
+		OPT_STRING(0, "template", &template_dir,
+			   N_("template-directory"),
+			   N_("directory from which templates will be used")),
 		OPT_SET_INT(0, "bare", &is_bare_repository_cfg,
-				N_("create a bare repository"), 1),
+			    N_("create a bare repository"), 1),
 		{ OPTION_CALLBACK, 0, "shared", &init_shared_repository,
-			N_("permissions"),
-			N_("specify that the git repository is to be shared amongst several users"),
-			PARSE_OPT_OPTARG | PARSE_OPT_NONEG, shared_callback, 0},
+		  N_("permissions"),
+		  N_("specify that the git repository is to be shared amongst several users"),
+		  PARSE_OPT_OPTARG | PARSE_OPT_NONEG, shared_callback, 0 },
 		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
+		OPT_STRING(0, "ref-storage", &ref_storage_format, N_("backend"),
+			   N_("the ref storage format to use")),
 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 			   N_("separate git dir from working tree")),
 		OPT_STRING('b', "initial-branch", &initial_branch, N_("name"),
@@ -719,10 +745,11 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	}
 
 	UNLEAK(real_git_dir);
+	UNLEAK(ref_storage_format);
 	UNLEAK(git_dir);
 	UNLEAK(work_tree);
 
 	flags |= INIT_DB_EXIST_OK;
 	return init_db(git_dir, real_git_dir, template_dir, hash_algo,
-		       initial_branch, flags);
+		       initial_branch, ref_storage_format, flags);
 }
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 1cd5c2016e3f..a5d044e116b1 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -13,6 +13,7 @@
 #include "utf8.h"
 #include "worktree.h"
 #include "quote.h"
+#include "../refs/refs-internal.h"
 
 static const char * const worktree_usage[] = {
 	N_("git worktree add [<options>] <path> [<commit-ish>]"),
@@ -330,9 +331,29 @@ static int add_worktree(const char *path, const char *refname,
 	 * worktree.
 	 */
 	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
-	write_file(sb.buf, "%s", oid_to_hex(&null_oid));
-	strbuf_reset(&sb);
+	if (get_main_ref_store(the_repository)->be == &refs_be_reftable) {
+		/* XXX this is cut & paste from reftable_init_db. */
+		strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
+		write_file(sb.buf, "%s", "ref: refs/heads/.invalid\n");
+		strbuf_reset(&sb);
+
+		strbuf_addf(&sb, "%s/refs", sb_repo.buf);
+		safe_create_dir(sb.buf, 1);
+		strbuf_reset(&sb);
+
+		strbuf_addf(&sb, "%s/refs/heads", sb_repo.buf);
+		write_file(sb.buf, "this repository uses the reftable format");
+		strbuf_reset(&sb);
+
+		strbuf_addf(&sb, "%s/reftable", sb_repo.buf);
+		safe_create_dir(sb.buf, 1);
+		strbuf_reset(&sb);
+	} else {
+		strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
+		write_file(sb.buf, "%s", oid_to_hex(&null_oid));
+		strbuf_reset(&sb);
+	}
+
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
 
diff --git a/cache.h b/cache.h
index 6fda8091f11d..be8fa1ddd6fc 100644
--- a/cache.h
+++ b/cache.h
@@ -629,9 +629,10 @@ int path_inside_repo(const char *prefix, const char *path);
 #define INIT_DB_EXIST_OK 0x0002
 
 int init_db(const char *git_dir, const char *real_git_dir,
-	    const char *template_dir, int hash_algo,
-	    const char *initial_branch, unsigned int flags);
-void initialize_repository_version(int hash_algo, int reinit);
+	    const char *template_dir, int hash_algo, const char *initial_branch,
+	    const char *ref_storage_format, unsigned int flags);
+void initialize_repository_version(int hash_algo, int reinit,
+				   const char *ref_storage_format);
 
 void sanitize_stdfds(void);
 int daemonize(void);
@@ -1045,6 +1046,7 @@ struct repository_format {
 	int is_bare;
 	int hash_algo;
 	char *work_tree;
+	char *ref_storage;
 	struct string_list unknown_extensions;
 	struct string_list v1_only_extensions;
 };
diff --git a/config.mak.uname b/config.mak.uname
index d204c20a6469..6cba285e8fa3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -699,7 +699,7 @@ vcxproj:
 	# Make .vcxproj files and add them
 	unset QUIET_GEN QUIET_BUILT_IN; \
 	perl contrib/buildsystems/generate -g Vcxproj
-	git add -f git.sln {*,*/lib,t/helper/*}/*.vcxproj
+	git add -f git.sln {*,*/lib,*/libreftable,t/helper/*}/*.vcxproj
 
 	# Generate the LinkOrCopyBuiltins.targets and LinkOrCopyRemoteHttp.targets file
 	(echo '<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">' && \
diff --git a/contrib/buildsystems/Generators/Vcxproj.pm b/contrib/buildsystems/Generators/Vcxproj.pm
index d2584450ba17..1a25789d2851 100644
--- a/contrib/buildsystems/Generators/Vcxproj.pm
+++ b/contrib/buildsystems/Generators/Vcxproj.pm
@@ -77,7 +77,7 @@ sub createProject {
     my $libs_release = "\n    ";
     my $libs_debug = "\n    ";
     if (!$static_library) {
-      $libs_release = join(";", sort(grep /^(?!libgit\.lib|xdiff\/lib\.lib|vcs-svn\/lib\.lib)/, @{$$build_structure{"$prefix${name}_LIBS"}}));
+      $libs_release = join(";", sort(grep /^(?!libgit\.lib|xdiff\/lib\.lib|vcs-svn\/lib\.lib|reftable\/libreftable\.lib)/, @{$$build_structure{"$prefix${name}_LIBS"}}));
       $libs_debug = $libs_release;
       $libs_debug =~ s/zlib\.lib/zlibd\.lib/g;
       $libs_debug =~ s/libexpat\.lib/libexpatd\.lib/g;
@@ -232,6 +232,7 @@ sub createProject {
 EOM
     if (!$static_library || $target =~ 'vcs-svn' || $target =~ 'xdiff') {
       my $uuid_libgit = $$build_structure{"LIBS_libgit_GUID"};
+      my $uuid_libreftable = $$build_structure{"LIBS_reftable/libreftable_GUID"};
       my $uuid_xdiff_lib = $$build_structure{"LIBS_xdiff/lib_GUID"};
 
       print F << "EOM";
@@ -241,6 +242,14 @@ sub createProject {
       <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
     </ProjectReference>
 EOM
+      if (!($name =~ /xdiff|libreftable/)) {
+        print F << "EOM";
+    <ProjectReference Include="$cdup\\reftable\\libreftable\\libreftable.vcxproj">
+      <Project>$uuid_libreftable</Project>
+      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
+    </ProjectReference>
+EOM
+      }
       if (!($name =~ 'xdiff')) {
         print F << "EOM";
     <ProjectReference Include="$cdup\\xdiff\\lib\\xdiff_lib.vcxproj">
diff --git a/refs.c b/refs.c
index a665ed5e10ac..bc27a5e1b282 100644
--- a/refs.c
+++ b/refs.c
@@ -19,10 +19,16 @@
 #include "repository.h"
 #include "sigchain.h"
 
+const char *default_ref_storage(void)
+{
+	const char *test = getenv("GIT_TEST_REFTABLE");
+	return test ? "reftable" : "files";
+}
+
 /*
  * List of all available backends
  */
-static struct ref_storage_be *refs_backends = &refs_be_files;
+static struct ref_storage_be *refs_backends = &refs_be_reftable;
 
 static struct ref_storage_be *find_ref_storage_backend(const char *name)
 {
@@ -1875,13 +1881,13 @@ static struct ref_store *lookup_ref_store_map(struct hashmap *map,
  * Create, record, and return a ref_store instance for the specified
  * gitdir.
  */
-static struct ref_store *ref_store_init(const char *gitdir,
+static struct ref_store *ref_store_init(const char *gitdir, const char *be_name,
 					unsigned int flags)
 {
-	const char *be_name = "files";
-	struct ref_storage_be *be = find_ref_storage_backend(be_name);
+	struct ref_storage_be *be;
 	struct ref_store *refs;
 
+	be = find_ref_storage_backend(be_name);
 	if (!be)
 		BUG("reference backend %s is unknown", be_name);
 
@@ -1897,7 +1903,11 @@ struct ref_store *get_main_ref_store(struct repository *r)
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
 
-	r->refs_private = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
+	r->refs_private = ref_store_init(r->gitdir,
+					 r->ref_storage_format ?
+						       r->ref_storage_format :
+						       default_ref_storage(),
+					 REF_STORE_ALL_CAPS);
 	r->refs_private = maybe_debug_wrap_ref_store(r->gitdir, r->refs_private);
 	return r->refs_private;
 }
@@ -1953,7 +1963,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 		goto done;
 
 	/* assume that add_submodule_odb() has been called */
-	refs = ref_store_init(submodule_sb.buf,
+	refs = ref_store_init(submodule_sb.buf, default_ref_storage(),
 			      REF_STORE_READ | REF_STORE_ODB);
 	register_ref_store_map(&submodule_ref_stores, "submodule",
 			       refs, submodule);
@@ -1967,6 +1977,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 
 struct ref_store *get_worktree_ref_store(const struct worktree *wt)
 {
+	const char *format = default_ref_storage();
 	struct ref_store *refs;
 	const char *id;
 
@@ -1980,9 +1991,9 @@ struct ref_store *get_worktree_ref_store(const struct worktree *wt)
 
 	if (wt->id)
 		refs = ref_store_init(git_common_path("worktrees/%s", wt->id),
-				      REF_STORE_ALL_CAPS);
+				      format, REF_STORE_ALL_CAPS);
 	else
-		refs = ref_store_init(get_git_common_dir(),
+		refs = ref_store_init(get_git_common_dir(), format,
 				      REF_STORE_ALL_CAPS);
 
 	if (refs)
diff --git a/refs.h b/refs.h
index 48970dfc7e0f..5a6d4ca9fa8d 100644
--- a/refs.h
+++ b/refs.h
@@ -11,6 +11,9 @@ struct string_list;
 struct string_list_item;
 struct worktree;
 
+/* Returns the ref storage backend to use by default. */
+const char *default_ref_storage(void);
+
 /*
  * Resolve a reference, recursively following symbolic refererences.
  *
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 467f4b3c936d..28166bf1f82b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -669,6 +669,7 @@ struct ref_storage_be {
 };
 
 extern struct ref_storage_be refs_be_files;
+extern struct ref_storage_be refs_be_reftable;
 extern struct ref_storage_be refs_be_packed;
 
 /*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
new file mode 100644
index 000000000000..f1f3e60a9c7c
--- /dev/null
+++ b/refs/reftable-backend.c
@@ -0,0 +1,1446 @@
+#include "../cache.h"
+#include "../chdir-notify.h"
+#include "../config.h"
+#include "../iterator.h"
+#include "../lockfile.h"
+#include "../refs.h"
+#include "../reftable/reftable-stack.h"
+#include "../reftable/reftable-record.h"
+#include "../reftable/reftable-error.h"
+#include "../reftable/reftable-blocksource.h"
+#include "../reftable/reftable-reader.h"
+#include "../reftable/reftable-iterator.h"
+#include "../reftable/reftable-merged.h"
+#include "../reftable/reftable-generic.h"
+#include "../worktree.h"
+#include "refs-internal.h"
+
+extern struct ref_storage_be refs_be_reftable;
+
+struct git_reftable_ref_store {
+	struct ref_store base;
+	unsigned int store_flags;
+
+	int err;
+	char *repo_dir;
+
+	char *reftable_dir;
+	char *worktree_reftable_dir;
+
+	struct reftable_stack *main_stack;
+	struct reftable_stack *worktree_stack;
+};
+
+static struct reftable_stack *stack_for(struct git_reftable_ref_store *store,
+					const char *refname)
+{
+	if (store->worktree_stack == NULL)
+		return store->main_stack;
+
+	switch (ref_type(refname)) {
+	case REF_TYPE_PER_WORKTREE:
+	case REF_TYPE_PSEUDOREF:
+	case REF_TYPE_OTHER_PSEUDOREF:
+		return store->worktree_stack;
+	default:
+	case REF_TYPE_MAIN_PSEUDOREF:
+	case REF_TYPE_NORMAL:
+		return store->main_stack;
+	}
+}
+
+static int git_reftable_read_raw_ref(struct ref_store *ref_store,
+				     const char *refname, struct object_id *oid,
+				     struct strbuf *referent,
+				     unsigned int *type);
+
+static void clear_reftable_log_record(struct reftable_log_record *log)
+{
+	log->refname = NULL;
+	switch (log->value_type) {
+	case REFTABLE_LOG_UPDATE:
+		log->update.old_hash = NULL;
+		log->update.new_hash = NULL;
+		log->update.message = NULL;
+		break;
+	case REFTABLE_LOG_DELETION:
+		break;
+	}
+	reftable_log_record_release(log);
+}
+
+static void fill_reftable_log_record(struct reftable_log_record *log)
+{
+	const char *info = git_committer_info(0);
+	struct ident_split split = { NULL };
+	int result = split_ident_line(&split, info, strlen(info));
+	int sign = 1;
+	assert(0 == result);
+
+	reftable_log_record_release(log);
+	log->value_type = REFTABLE_LOG_UPDATE;
+	log->update.name =
+		xstrndup(split.name_begin, split.name_end - split.name_begin);
+	log->update.email =
+		xstrndup(split.mail_begin, split.mail_end - split.mail_begin);
+	log->update.time = atol(split.date_begin);
+	if (*split.tz_begin == '-') {
+		sign = -1;
+		split.tz_begin++;
+	}
+	if (*split.tz_begin == '+') {
+		sign = 1;
+		split.tz_begin++;
+	}
+
+	log->update.tz_offset = sign * atoi(split.tz_begin);
+}
+
+static int has_suffix(struct strbuf *b, const char *suffix)
+{
+	size_t len = strlen(suffix);
+
+	if (len > b->len) {
+		return 0;
+	}
+
+	return 0 == strncmp(b->buf + b->len - len, suffix, len);
+}
+
+/* trims the last path component of b. Returns -1 if it is not
+ * present, or 0 on success
+ */
+static int trim_component(struct strbuf *b)
+{
+	char *last;
+	last = strrchr(b->buf, '/');
+	if (!last)
+		return -1;
+	strbuf_setlen(b, last - b->buf);
+	return 0;
+}
+
+/* Returns whether `b` is a worktree path, trimming it to the gitdir
+ */
+static int is_worktree(struct strbuf *b)
+{
+	if (trim_component(b) < 0) {
+		return 0;
+	}
+	if (!has_suffix(b, "/worktrees")) {
+		return 0;
+	}
+	trim_component(b);
+	return 1;
+}
+
+static struct ref_store *git_reftable_ref_store_create(const char *path,
+						       unsigned int store_flags)
+{
+	struct git_reftable_ref_store *refs = xcalloc(1, sizeof(*refs));
+	struct ref_store *ref_store = (struct ref_store *)refs;
+	struct reftable_write_options cfg = {
+		.block_size = 4096,
+		.hash_id = the_hash_algo->format_id,
+	};
+	struct strbuf sb = STRBUF_INIT;
+	const char *gitdir = path;
+	struct strbuf wt_buf = STRBUF_INIT;
+	int wt = 0;
+
+	strbuf_addstr(&wt_buf, path);
+
+	/* this is clumsy, but the official worktree functions (eg.
+	 * get_worktrees()) function will try to initialize a ref storage
+	 * backend, leading to infinite recursion.  */
+	wt = is_worktree(&wt_buf);
+	if (wt) {
+		gitdir = wt_buf.buf;
+	}
+
+	base_ref_store_init(ref_store, &refs_be_reftable);
+	ref_store->gitdir = xstrdup(gitdir);
+	refs->store_flags = store_flags;
+	strbuf_addf(&sb, "%s/reftable", gitdir);
+	refs->reftable_dir = xstrdup(sb.buf);
+	strbuf_reset(&sb);
+
+	refs->err =
+		reftable_new_stack(&refs->main_stack, refs->reftable_dir, cfg);
+	assert(refs->err != REFTABLE_API_ERROR);
+
+	if (refs->err == 0 && wt) {
+		strbuf_addf(&sb, "%s/reftable", path);
+		refs->worktree_reftable_dir = xstrdup(sb.buf);
+
+		refs->err = reftable_new_stack(&refs->worktree_stack,
+					       refs->worktree_reftable_dir,
+					       cfg);
+		assert(refs->err != REFTABLE_API_ERROR);
+	}
+
+	strbuf_release(&sb);
+	strbuf_release(&wt_buf);
+	return ref_store;
+}
+
+static int git_reftable_init_db(struct ref_store *ref_store, struct strbuf *err)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct strbuf sb = STRBUF_INIT;
+
+	safe_create_dir(refs->reftable_dir, 1);
+	assert(refs->worktree_reftable_dir == NULL);
+
+	strbuf_addf(&sb, "%s/HEAD", refs->base.gitdir);
+	write_file(sb.buf, "ref: refs/heads/.invalid");
+	strbuf_reset(&sb);
+
+	strbuf_addf(&sb, "%s/refs", refs->base.gitdir);
+	safe_create_dir(sb.buf, 1);
+	strbuf_reset(&sb);
+
+	strbuf_addf(&sb, "%s/refs/heads", refs->base.gitdir);
+	write_file(sb.buf, "this repository uses the reftable format");
+
+	return 0;
+}
+
+struct git_reftable_iterator {
+	struct ref_iterator base;
+	struct reftable_iterator iter;
+	struct reftable_ref_record ref;
+	struct object_id oid;
+	struct ref_store *ref_store;
+
+	/* In case we must iterate over 2 stacks, this is non-null. */
+	struct reftable_merged_table *merged;
+	unsigned int flags;
+	int err;
+	const char *prefix;
+};
+
+static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
+{
+	struct git_reftable_iterator *ri =
+		(struct git_reftable_iterator *)ref_iterator;
+	while (ri->err == 0) {
+		ri->err = reftable_iterator_next_ref(&ri->iter, &ri->ref);
+		if (ri->err) {
+			break;
+		}
+
+		if (ref_type(ri->ref.refname) == REF_TYPE_PSEUDOREF) {
+			/*
+			  pseudorefs, eg. HEAD, FETCH_HEAD should not be
+			  produced, by default.
+			 */
+			continue;
+		}
+		ri->base.refname = ri->ref.refname;
+		if (ri->prefix != NULL &&
+		    strncmp(ri->prefix, ri->ref.refname, strlen(ri->prefix))) {
+			ri->err = 1;
+			break;
+		}
+		if (ri->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
+		    ref_type(ri->base.refname) != REF_TYPE_PER_WORKTREE)
+			continue;
+
+		ri->base.flags = 0;
+		switch (ri->ref.value_type) {
+		case REFTABLE_REF_VAL1:
+			hashcpy(ri->oid.hash, ri->ref.value.val1);
+			break;
+		case REFTABLE_REF_VAL2:
+			hashcpy(ri->oid.hash, ri->ref.value.val2.value);
+			break;
+		case REFTABLE_REF_SYMREF: {
+			int out_flags = 0;
+			const char *resolved = refs_resolve_ref_unsafe(
+				ri->ref_store, ri->ref.refname,
+				RESOLVE_REF_READING, &ri->oid, &out_flags);
+			ri->base.flags = out_flags;
+			if (resolved == NULL &&
+			    !(ri->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
+			    (ri->base.flags & REF_ISBROKEN)) {
+				continue;
+			}
+			break;
+		}
+		default:
+			abort();
+		}
+
+		ri->base.oid = &ri->oid;
+		if (!(ri->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
+		    !ref_resolves_to_object(ri->base.refname, ri->base.oid,
+					    ri->base.flags)) {
+			continue;
+		}
+
+		break;
+	}
+
+	if (ri->err > 0) {
+		return ITER_DONE;
+	}
+	if (ri->err < 0) {
+		return ITER_ERROR;
+	}
+
+	return ITER_OK;
+}
+
+static int reftable_ref_iterator_peel(struct ref_iterator *ref_iterator,
+				      struct object_id *peeled)
+{
+	struct git_reftable_iterator *ri =
+		(struct git_reftable_iterator *)ref_iterator;
+	if (ri->ref.value_type == REFTABLE_REF_VAL2) {
+		hashcpy(peeled->hash, ri->ref.value.val2.target_value);
+		return 0;
+	}
+
+	return -1;
+}
+
+static int reftable_ref_iterator_abort(struct ref_iterator *ref_iterator)
+{
+	struct git_reftable_iterator *ri =
+		(struct git_reftable_iterator *)ref_iterator;
+	reftable_ref_record_release(&ri->ref);
+	reftable_iterator_destroy(&ri->iter);
+	if (ri->merged) {
+		reftable_merged_table_free(ri->merged);
+	}
+	return 0;
+}
+
+static struct ref_iterator_vtable reftable_ref_iterator_vtable = {
+	reftable_ref_iterator_advance, reftable_ref_iterator_peel,
+	reftable_ref_iterator_abort
+};
+
+static struct ref_iterator *
+git_reftable_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
+				unsigned int flags)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct git_reftable_iterator *ri = xcalloc(1, sizeof(*ri));
+
+	if (refs->err < 0) {
+		ri->err = refs->err;
+	} else if (refs->worktree_stack == NULL) {
+		struct reftable_merged_table *mt =
+			reftable_stack_merged_table(refs->main_stack);
+		ri->err = reftable_merged_table_seek_ref(mt, &ri->iter, prefix);
+	} else {
+		struct reftable_merged_table *mt1 =
+			reftable_stack_merged_table(refs->main_stack);
+		struct reftable_merged_table *mt2 =
+			reftable_stack_merged_table(refs->worktree_stack);
+		struct reftable_table *tabs =
+			xcalloc(2, sizeof(struct reftable_table));
+		reftable_table_from_merged_table(&tabs[0], mt1);
+		reftable_table_from_merged_table(&tabs[1], mt2);
+		ri->err = reftable_new_merged_table(&ri->merged, tabs, 2,
+						    the_hash_algo->format_id);
+		if (ri->err == 0)
+			ri->err = reftable_merged_table_seek_ref(
+				ri->merged, &ri->iter, prefix);
+	}
+
+	base_ref_iterator_init(&ri->base, &reftable_ref_iterator_vtable, 1);
+	ri->prefix = prefix;
+	ri->base.oid = &ri->oid;
+	ri->flags = flags;
+	ri->ref_store = ref_store;
+	return &ri->base;
+}
+
+static int fixup_symrefs(struct ref_store *ref_store,
+			 struct ref_transaction *transaction)
+{
+	struct strbuf referent = STRBUF_INIT;
+	int i = 0;
+	int err = 0;
+
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+		struct object_id old_oid;
+
+		err = git_reftable_read_raw_ref(ref_store, update->refname,
+						&old_oid, &referent,
+						/* mutate input, like
+						   files-backend.c */
+						&update->type);
+		if (err < 0 && errno == ENOENT &&
+		    is_null_oid(&update->old_oid)) {
+			err = 0;
+		}
+		if (err < 0)
+			goto done;
+
+		if (!(update->type & REF_ISSYMREF))
+			continue;
+
+		if (update->flags & REF_NO_DEREF) {
+			/* what should happen here? See files-backend.c
+			 * lock_ref_for_update. */
+		} else {
+			/*
+			  If we are updating a symref (eg. HEAD), we should also
+			  update the branch that the symref points to.
+
+			  This is generic functionality, and would be better
+			  done in refs.c, but the current implementation is
+			  intertwined with the locking in files-backend.c.
+			*/
+			int new_flags = update->flags;
+			struct ref_update *new_update = NULL;
+
+			/* if this is an update for HEAD, should also record a
+			   log entry for HEAD? See files-backend.c,
+			   split_head_update()
+			*/
+			new_update = ref_transaction_add_update(
+				transaction, referent.buf, new_flags,
+				&update->new_oid, &update->old_oid,
+				update->msg);
+			new_update->parent_update = update;
+
+			/* files-backend sets REF_LOG_ONLY here. */
+			update->flags |= REF_NO_DEREF | REF_LOG_ONLY;
+			update->flags &= ~REF_HAVE_OLD;
+		}
+	}
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	strbuf_release(&referent);
+	return err;
+}
+
+static int git_reftable_transaction_prepare(struct ref_store *ref_store,
+					    struct ref_transaction *transaction,
+					    struct strbuf *errbuf)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_addition *add = NULL;
+	struct reftable_stack *stack =
+		transaction->nr ?
+			      stack_for(refs, transaction->updates[0]->refname) :
+			      refs->main_stack;
+	int err = refs->err;
+	if (err < 0) {
+		goto done;
+	}
+
+	err = reftable_stack_reload(stack);
+	if (err) {
+		goto done;
+	}
+
+	err = reftable_stack_new_addition(&add, stack);
+	if (err) {
+		goto done;
+	}
+
+	err = fixup_symrefs(ref_store, transaction);
+	if (err) {
+		goto done;
+	}
+
+	transaction->backend_data = add;
+	transaction->state = REF_TRANSACTION_PREPARED;
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	if (err < 0) {
+		transaction->state = REF_TRANSACTION_CLOSED;
+		strbuf_addf(errbuf, "reftable: transaction prepare: %s",
+			    reftable_error_str(err));
+	}
+
+	return err;
+}
+
+static int git_reftable_transaction_abort(struct ref_store *ref_store,
+					  struct ref_transaction *transaction,
+					  struct strbuf *err)
+{
+	struct reftable_addition *add =
+		(struct reftable_addition *)transaction->backend_data;
+	reftable_addition_destroy(add);
+	transaction->backend_data = NULL;
+	return 0;
+}
+
+static int reftable_check_old_oid(struct ref_store *refs, const char *refname,
+				  struct object_id *want_oid)
+{
+	struct object_id out_oid;
+	int out_flags = 0;
+	const char *resolved = refs_resolve_ref_unsafe(
+		refs, refname, RESOLVE_REF_READING, &out_oid, &out_flags);
+	if (is_null_oid(want_oid) != (resolved == NULL)) {
+		return REFTABLE_LOCK_ERROR;
+	}
+
+	if (resolved != NULL && !oideq(&out_oid, want_oid)) {
+		return REFTABLE_LOCK_ERROR;
+	}
+
+	return 0;
+}
+
+static int ref_update_cmp(const void *a, const void *b)
+{
+	return strcmp((*(struct ref_update **)a)->refname,
+		      (*(struct ref_update **)b)->refname);
+}
+
+static int write_transaction_table(struct reftable_writer *writer, void *arg)
+{
+	struct ref_transaction *transaction = (struct ref_transaction *)arg;
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)transaction->ref_store;
+	struct reftable_stack *stack =
+		stack_for(refs, transaction->updates[0]->refname);
+	uint64_t ts = reftable_stack_next_update_index(stack);
+	int err = 0;
+	int i = 0;
+	struct reftable_log_record *logs =
+		calloc(transaction->nr, sizeof(*logs));
+	struct ref_update **sorted =
+		malloc(transaction->nr * sizeof(struct ref_update *));
+	COPY_ARRAY(sorted, transaction->updates, transaction->nr);
+	QSORT(sorted, transaction->nr, ref_update_cmp);
+	reftable_writer_set_limits(writer, ts, ts);
+
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *u = sorted[i];
+		struct reftable_log_record *log = &logs[i];
+		fill_reftable_log_record(log);
+		log->update_index = ts;
+		log->value_type = REFTABLE_LOG_UPDATE;
+		log->refname = (char *)u->refname;
+		log->update.old_hash = u->old_oid.hash;
+		log->update.new_hash = u->new_oid.hash;
+		log->update.message = u->msg;
+
+		if (u->flags & REF_LOG_ONLY) {
+			continue;
+		}
+
+		if (u->flags & REF_HAVE_NEW) {
+			struct reftable_ref_record ref = { NULL };
+			struct object_id peeled;
+
+			int peel_error = peel_object(&u->new_oid, &peeled);
+			ref.refname = (char *)u->refname;
+			ref.update_index = ts;
+
+			if (!peel_error) {
+				ref.value_type = REFTABLE_REF_VAL2;
+				ref.value.val2.target_value = peeled.hash;
+				ref.value.val2.value = u->new_oid.hash;
+			} else if (!is_null_oid(&u->new_oid)) {
+				ref.value_type = REFTABLE_REF_VAL1;
+				ref.value.val1 = u->new_oid.hash;
+			}
+
+			err = reftable_writer_add_ref(writer, &ref);
+			if (err < 0) {
+				goto done;
+			}
+		}
+	}
+
+	for (i = 0; i < transaction->nr; i++) {
+		err = reftable_writer_add_log(writer, &logs[i]);
+		clear_reftable_log_record(&logs[i]);
+		if (err < 0) {
+			goto done;
+		}
+	}
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	free(logs);
+	free(sorted);
+	return err;
+}
+
+static int git_reftable_transaction_finish(struct ref_store *ref_store,
+					   struct ref_transaction *transaction,
+					   struct strbuf *errmsg)
+{
+	struct reftable_addition *add =
+		(struct reftable_addition *)transaction->backend_data;
+	int err = 0;
+	int i;
+
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *u = transaction->updates[i];
+		if (u->flags & REF_HAVE_OLD) {
+			err = reftable_check_old_oid(transaction->ref_store,
+						     u->refname, &u->old_oid);
+			if (err < 0) {
+				goto done;
+			}
+		}
+	}
+	if (transaction->nr) {
+		err = reftable_addition_add(add, &write_transaction_table,
+					    transaction);
+		if (err < 0) {
+			goto done;
+		}
+	}
+
+	err = reftable_addition_commit(add);
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	reftable_addition_destroy(add);
+	transaction->state = REF_TRANSACTION_CLOSED;
+	transaction->backend_data = NULL;
+	if (err) {
+		strbuf_addf(errmsg, "reftable: transaction failure: %s",
+			    reftable_error_str(err));
+		return -1;
+	}
+	return err;
+}
+
+static int
+git_reftable_transaction_initial_commit(struct ref_store *ref_store,
+					struct ref_transaction *transaction,
+					struct strbuf *errmsg)
+{
+	int err = git_reftable_transaction_prepare(ref_store, transaction,
+						   errmsg);
+	if (err)
+		return err;
+
+	return git_reftable_transaction_finish(ref_store, transaction, errmsg);
+}
+
+struct write_delete_refs_arg {
+	struct reftable_stack *stack;
+	struct string_list *refnames;
+	const char *logmsg;
+	unsigned int flags;
+};
+
+static int write_delete_refs_table(struct reftable_writer *writer, void *argv)
+{
+	struct write_delete_refs_arg *arg =
+		(struct write_delete_refs_arg *)argv;
+	uint64_t ts = reftable_stack_next_update_index(arg->stack);
+	int err = 0;
+	int i = 0;
+
+	reftable_writer_set_limits(writer, ts, ts);
+	for (i = 0; i < arg->refnames->nr; i++) {
+		struct reftable_ref_record ref = {
+			.refname = (char *)arg->refnames->items[i].string,
+			.value_type = REFTABLE_REF_DELETION,
+			.update_index = ts,
+		};
+		err = reftable_writer_add_ref(writer, &ref);
+		if (err < 0) {
+			return err;
+		}
+	}
+
+	for (i = 0; i < arg->refnames->nr; i++) {
+		struct reftable_log_record log = {
+			.update_index = ts,
+		};
+		struct reftable_ref_record current = { NULL };
+		fill_reftable_log_record(&log);
+		log.update_index = ts;
+		log.refname = (char *)arg->refnames->items[i].string;
+
+		log.update.message = xstrdup(arg->logmsg);
+		log.update.new_hash = NULL;
+		log.update.old_hash = NULL;
+		if (reftable_stack_read_ref(arg->stack, log.refname,
+					    &current) == 0) {
+			log.update.old_hash =
+				reftable_ref_record_val1(&current);
+		}
+		err = reftable_writer_add_log(writer, &log);
+		log.update.old_hash = NULL;
+		reftable_ref_record_release(&current);
+
+		clear_reftable_log_record(&log);
+		if (err < 0) {
+			return err;
+		}
+	}
+	return 0;
+}
+
+static int git_reftable_delete_refs(struct ref_store *ref_store,
+				    const char *msg,
+				    struct string_list *refnames,
+				    unsigned int flags)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack =
+		stack_for(refs, refnames->items[0].string);
+	struct write_delete_refs_arg arg = {
+		.stack = stack,
+		.refnames = refnames,
+		.logmsg = msg,
+		.flags = flags,
+	};
+	int err = refs->err;
+	if (err < 0) {
+		goto done;
+	}
+
+	string_list_sort(refnames);
+	err = reftable_stack_reload(stack);
+	if (err) {
+		goto done;
+	}
+	err = reftable_stack_add(stack, &write_delete_refs_table, &arg);
+done:
+	assert(err != REFTABLE_API_ERROR);
+	return err;
+}
+
+static int git_reftable_pack_refs(struct ref_store *ref_store,
+				  unsigned int flags)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	int err = refs->err;
+	if (err < 0) {
+		return err;
+	}
+	err = reftable_stack_compact_all(refs->main_stack, NULL);
+	if (err == 0 && refs->worktree_stack != NULL)
+		err = reftable_stack_compact_all(refs->worktree_stack, NULL);
+	return err;
+}
+
+struct write_create_symref_arg {
+	struct git_reftable_ref_store *refs;
+	struct reftable_stack *stack;
+	const char *refname;
+	const char *target;
+	const char *logmsg;
+};
+
+static int write_create_symref_table(struct reftable_writer *writer, void *arg)
+{
+	struct write_create_symref_arg *create =
+		(struct write_create_symref_arg *)arg;
+	uint64_t ts = reftable_stack_next_update_index(create->stack);
+	int err = 0;
+
+	struct reftable_ref_record ref = {
+		.refname = (char *)create->refname,
+		.value_type = REFTABLE_REF_SYMREF,
+		.value.symref = (char *)create->target,
+		.update_index = ts,
+	};
+	reftable_writer_set_limits(writer, ts, ts);
+	err = reftable_writer_add_ref(writer, &ref);
+	if (err == 0) {
+		struct reftable_log_record log = { NULL };
+		struct object_id new_oid;
+		struct object_id old_oid;
+
+		fill_reftable_log_record(&log);
+		log.refname = (char *)create->refname;
+		log.update_index = ts;
+		log.update.message = (char *)create->logmsg;
+		if (refs_resolve_ref_unsafe(
+			    (struct ref_store *)create->refs, create->refname,
+			    RESOLVE_REF_READING, &old_oid, NULL) != NULL) {
+			log.update.old_hash = old_oid.hash;
+		}
+
+		if (refs_resolve_ref_unsafe((struct ref_store *)create->refs,
+					    create->target, RESOLVE_REF_READING,
+					    &new_oid, NULL) != NULL) {
+			log.update.new_hash = new_oid.hash;
+		}
+
+		if (log.update.old_hash != NULL ||
+		    log.update.new_hash != NULL) {
+			err = reftable_writer_add_log(writer, &log);
+		}
+		log.refname = NULL;
+		log.update.message = NULL;
+		log.update.old_hash = NULL;
+		log.update.new_hash = NULL;
+		clear_reftable_log_record(&log);
+	}
+	return err;
+}
+
+static int git_reftable_create_symref(struct ref_store *ref_store,
+				      const char *refname, const char *target,
+				      const char *logmsg)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+	struct write_create_symref_arg arg = { .refs = refs,
+					       .stack = stack,
+					       .refname = refname,
+					       .target = target,
+					       .logmsg = logmsg };
+	int err = refs->err;
+	if (err < 0) {
+		goto done;
+	}
+	err = reftable_stack_reload(stack);
+	if (err) {
+		goto done;
+	}
+	err = reftable_stack_add(stack, &write_create_symref_table, &arg);
+done:
+	assert(err != REFTABLE_API_ERROR);
+	return err;
+}
+
+struct write_rename_arg {
+	struct reftable_stack *stack;
+	const char *oldname;
+	const char *newname;
+	const char *logmsg;
+};
+
+static int write_rename_table(struct reftable_writer *writer, void *argv)
+{
+	struct write_rename_arg *arg = (struct write_rename_arg *)argv;
+	uint64_t ts = reftable_stack_next_update_index(arg->stack);
+	struct reftable_ref_record ref = { NULL };
+	int err = reftable_stack_read_ref(arg->stack, arg->oldname, &ref);
+
+	if (err) {
+		goto done;
+	}
+
+	/* XXX do ref renames overwrite the target? */
+	if (reftable_stack_read_ref(arg->stack, arg->newname, &ref) == 0) {
+		goto done;
+	}
+
+	reftable_writer_set_limits(writer, ts, ts);
+
+	{
+		struct reftable_ref_record todo[2] = {
+			{
+				.refname = (char *)arg->oldname,
+				.update_index = ts,
+				.value_type = REFTABLE_REF_DELETION,
+			},
+			ref,
+		};
+		todo[1].update_index = ts;
+		free(todo[1].refname);
+		todo[1].refname = strdup(arg->newname);
+
+		err = reftable_writer_add_refs(writer, todo, 2);
+		if (err < 0) {
+			goto done;
+		}
+	}
+
+	if (reftable_ref_record_val1(&ref)) {
+		uint8_t *val1 = reftable_ref_record_val1(&ref);
+		struct reftable_log_record todo[2] = { { NULL } };
+		fill_reftable_log_record(&todo[0]);
+		fill_reftable_log_record(&todo[1]);
+
+		todo[0].refname = (char *)arg->oldname;
+		todo[0].update_index = ts;
+		todo[0].update.message = (char *)arg->logmsg;
+		todo[0].update.old_hash = val1;
+		todo[0].update.new_hash = NULL;
+
+		todo[1].refname = (char *)arg->newname;
+		todo[1].update_index = ts;
+		todo[1].update.old_hash = NULL;
+		todo[1].update.new_hash = val1;
+		todo[1].update.message = (char *)arg->logmsg;
+
+		err = reftable_writer_add_logs(writer, todo, 2);
+
+		clear_reftable_log_record(&todo[0]);
+		clear_reftable_log_record(&todo[1]);
+
+		if (err < 0) {
+			goto done;
+		}
+
+	} else {
+		/* XXX symrefs? */
+	}
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	reftable_ref_record_release(&ref);
+	return err;
+}
+
+static int git_reftable_rename_ref(struct ref_store *ref_store,
+				   const char *oldrefname,
+				   const char *newrefname, const char *logmsg)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, newrefname);
+	struct write_rename_arg arg = {
+		.stack = stack,
+		.oldname = oldrefname,
+		.newname = newrefname,
+		.logmsg = logmsg,
+	};
+	int err = refs->err;
+	if (err < 0) {
+		goto done;
+	}
+	err = reftable_stack_reload(stack);
+	if (err) {
+		goto done;
+	}
+
+	err = reftable_stack_add(stack, &write_rename_table, &arg);
+done:
+	assert(err != REFTABLE_API_ERROR);
+	return err;
+}
+
+static int git_reftable_copy_ref(struct ref_store *ref_store,
+				 const char *oldrefname, const char *newrefname,
+				 const char *logmsg)
+{
+	BUG("reftable reference store does not support copying references");
+}
+
+struct git_reftable_reflog_ref_iterator {
+	struct ref_iterator base;
+	struct reftable_iterator iter;
+	struct reftable_log_record log;
+	struct object_id oid;
+
+	/* Used when iterating over worktree & main */
+	struct reftable_merged_table *merged;
+	char *last_name;
+};
+
+static int
+git_reftable_reflog_ref_iterator_advance(struct ref_iterator *ref_iterator)
+{
+	struct git_reftable_reflog_ref_iterator *ri =
+		(struct git_reftable_reflog_ref_iterator *)ref_iterator;
+
+	while (1) {
+		int err = reftable_iterator_next_log(&ri->iter, &ri->log);
+		if (err > 0) {
+			return ITER_DONE;
+		}
+		if (err < 0) {
+			return ITER_ERROR;
+		}
+
+		ri->base.refname = ri->log.refname;
+		if (ri->last_name != NULL &&
+		    !strcmp(ri->log.refname, ri->last_name)) {
+			/* we want the refnames that we have reflogs for, so we
+			 * skip if we've already produced this name. This could
+			 * be faster by seeking directly to
+			 * reflog@update_index==0.
+			 */
+			continue;
+		}
+
+		free(ri->last_name);
+		ri->last_name = xstrdup(ri->log.refname);
+		hashcpy(ri->oid.hash, ri->log.update.new_hash);
+		return ITER_OK;
+	}
+}
+
+static int
+git_reftable_reflog_ref_iterator_peel(struct ref_iterator *ref_iterator,
+				      struct object_id *peeled)
+{
+	BUG("not supported.");
+	return -1;
+}
+
+static int
+git_reftable_reflog_ref_iterator_abort(struct ref_iterator *ref_iterator)
+{
+	struct git_reftable_reflog_ref_iterator *ri =
+		(struct git_reftable_reflog_ref_iterator *)ref_iterator;
+	reftable_log_record_release(&ri->log);
+	reftable_iterator_destroy(&ri->iter);
+	if (ri->merged)
+		reftable_merged_table_free(ri->merged);
+	return 0;
+}
+
+static struct ref_iterator_vtable git_reftable_reflog_ref_iterator_vtable = {
+	git_reftable_reflog_ref_iterator_advance,
+	git_reftable_reflog_ref_iterator_peel,
+	git_reftable_reflog_ref_iterator_abort
+};
+
+static struct ref_iterator *
+git_reftable_reflog_iterator_begin(struct ref_store *ref_store)
+{
+	struct git_reftable_reflog_ref_iterator *ri = xcalloc(1, sizeof(*ri));
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+
+	if (refs->worktree_stack == NULL) {
+		struct reftable_stack *stack = refs->main_stack;
+		struct reftable_merged_table *mt =
+			reftable_stack_merged_table(stack);
+		int err = reftable_merged_table_seek_log(mt, &ri->iter, "");
+		if (err < 0) {
+			free(ri);
+			/* XXX is this allowed? */
+			return NULL;
+		}
+	} else {
+		struct reftable_merged_table *mt1 =
+			reftable_stack_merged_table(refs->main_stack);
+		struct reftable_merged_table *mt2 =
+			reftable_stack_merged_table(refs->worktree_stack);
+		struct reftable_table *tabs =
+			xcalloc(2, sizeof(struct reftable_table));
+		int err = 0;
+		reftable_table_from_merged_table(&tabs[0], mt1);
+		reftable_table_from_merged_table(&tabs[1], mt2);
+		err = reftable_new_merged_table(&ri->merged, tabs, 2,
+						the_hash_algo->format_id);
+		if (err < 0) {
+			free(tabs);
+			/* XXX see above */
+			return NULL;
+		}
+		err = reftable_merged_table_seek_ref(ri->merged, &ri->iter, "");
+		if (err < 0) {
+			return NULL;
+		}
+	}
+	base_ref_iterator_init(&ri->base,
+			       &git_reftable_reflog_ref_iterator_vtable, 1);
+	ri->base.oid = &ri->oid;
+
+	return (struct ref_iterator *)ri;
+}
+
+static int git_reftable_for_each_reflog_ent_newest_first(
+	struct ref_store *ref_store, const char *refname, each_reflog_ent_fn fn,
+	void *cb_data)
+{
+	struct reftable_iterator it = { NULL };
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+	struct reftable_merged_table *mt = NULL;
+	int err = 0;
+	struct reftable_log_record log = { NULL };
+
+	if (refs->err < 0) {
+		return refs->err;
+	}
+
+	mt = reftable_stack_merged_table(stack);
+	err = reftable_merged_table_seek_log(mt, &it, refname);
+	while (err == 0) {
+		struct object_id old_oid;
+		struct object_id new_oid;
+		const char *full_committer = "";
+
+		err = reftable_iterator_next_log(&it, &log);
+		if (err > 0) {
+			err = 0;
+			break;
+		}
+		if (err < 0) {
+			break;
+		}
+
+		if (strcmp(log.refname, refname)) {
+			break;
+		}
+
+		hashcpy(old_oid.hash, log.update.old_hash);
+		hashcpy(new_oid.hash, log.update.new_hash);
+
+		full_committer = fmt_ident(log.update.name, log.update.email,
+					   WANT_COMMITTER_IDENT,
+					   /*date*/ NULL, IDENT_NO_DATE);
+		err = fn(&old_oid, &new_oid, full_committer, log.update.time,
+			 log.update.tz_offset, log.update.message, cb_data);
+		if (err)
+			break;
+	}
+
+	reftable_log_record_release(&log);
+	reftable_iterator_destroy(&it);
+	return err;
+}
+
+static int git_reftable_for_each_reflog_ent_oldest_first(
+	struct ref_store *ref_store, const char *refname, each_reflog_ent_fn fn,
+	void *cb_data)
+{
+	struct reftable_iterator it = { NULL };
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+	struct reftable_merged_table *mt = NULL;
+	struct reftable_log_record *logs = NULL;
+	int cap = 0;
+	int len = 0;
+	int err = 0;
+	int i = 0;
+
+	if (refs->err < 0) {
+		return refs->err;
+	}
+	mt = reftable_stack_merged_table(stack);
+	err = reftable_merged_table_seek_log(mt, &it, refname);
+
+	while (err == 0) {
+		struct reftable_log_record log = { NULL };
+		err = reftable_iterator_next_log(&it, &log);
+		if (err > 0) {
+			err = 0;
+			break;
+		}
+		if (err < 0) {
+			break;
+		}
+
+		if (strcmp(log.refname, refname)) {
+			break;
+		}
+
+		if (len == cap) {
+			cap = 2 * cap + 1;
+			logs = realloc(logs, cap * sizeof(*logs));
+		}
+
+		logs[len++] = log;
+	}
+
+	for (i = len; i--;) {
+		struct reftable_log_record *log = &logs[i];
+		struct object_id old_oid;
+		struct object_id new_oid;
+		const char *full_committer = "";
+
+		hashcpy(old_oid.hash, log->update.old_hash);
+		hashcpy(new_oid.hash, log->update.new_hash);
+
+		full_committer = fmt_ident(log->update.name, log->update.email,
+					   WANT_COMMITTER_IDENT, NULL,
+					   IDENT_NO_DATE);
+		err = fn(&old_oid, &new_oid, full_committer, log->update.time,
+			 log->update.tz_offset, log->update.message, cb_data);
+		if (err) {
+			break;
+		}
+	}
+
+	for (i = 0; i < len; i++) {
+		reftable_log_record_release(&logs[i]);
+	}
+	free(logs);
+
+	reftable_iterator_destroy(&it);
+	return err;
+}
+
+static int git_reftable_reflog_exists(struct ref_store *ref_store,
+				      const char *refname)
+{
+	struct reftable_iterator it = { NULL };
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+	struct reftable_merged_table *mt = reftable_stack_merged_table(stack);
+	struct reftable_log_record log = { NULL };
+	int err = refs->err;
+
+	if (err < 0) {
+		goto done;
+	}
+	err = reftable_merged_table_seek_log(mt, &it, refname);
+	if (err) {
+		goto done;
+	}
+	err = reftable_iterator_next_log(&it, &log);
+	if (err) {
+		goto done;
+	}
+
+	if (strcmp(log.refname, refname)) {
+		err = 1;
+	}
+
+done:
+	reftable_iterator_destroy(&it);
+	reftable_log_record_release(&log);
+	return !err;
+}
+
+static int git_reftable_create_reflog(struct ref_store *ref_store,
+				      const char *refname, int force_create,
+				      struct strbuf *err)
+{
+	return 0;
+}
+
+static int git_reftable_delete_reflog(struct ref_store *ref_store,
+				      const char *refname)
+{
+	return 0;
+}
+
+struct reflog_expiry_arg {
+	struct git_reftable_ref_store *refs;
+	struct reftable_stack *stack;
+	struct reftable_log_record *tombstones;
+	int len;
+	int cap;
+};
+
+static void clear_log_tombstones(struct reflog_expiry_arg *arg)
+{
+	int i = 0;
+	for (; i < arg->len; i++) {
+		reftable_log_record_release(&arg->tombstones[i]);
+	}
+
+	FREE_AND_NULL(arg->tombstones);
+}
+
+static void add_log_tombstone(struct reflog_expiry_arg *arg,
+			      const char *refname, uint64_t ts)
+{
+	struct reftable_log_record tombstone = {
+		.refname = xstrdup(refname),
+		.update_index = ts,
+	};
+	if (arg->len == arg->cap) {
+		arg->cap = 2 * arg->cap + 1;
+		arg->tombstones =
+			realloc(arg->tombstones, arg->cap * sizeof(tombstone));
+	}
+	arg->tombstones[arg->len++] = tombstone;
+}
+
+static int write_reflog_expiry_table(struct reftable_writer *writer, void *argv)
+{
+	struct reflog_expiry_arg *arg = (struct reflog_expiry_arg *)argv;
+	uint64_t ts = reftable_stack_next_update_index(arg->stack);
+	int i = 0;
+	reftable_writer_set_limits(writer, ts, ts);
+	for (i = 0; i < arg->len; i++) {
+		int err = reftable_writer_add_log(writer, &arg->tombstones[i]);
+		if (err) {
+			return err;
+		}
+	}
+	return 0;
+}
+
+static int
+git_reftable_reflog_expire(struct ref_store *ref_store, const char *refname,
+			   const struct object_id *oid, unsigned int flags,
+			   reflog_expiry_prepare_fn prepare_fn,
+			   reflog_expiry_should_prune_fn should_prune_fn,
+			   reflog_expiry_cleanup_fn cleanup_fn,
+			   void *policy_cb_data)
+{
+	/*
+	  For log expiry, we write tombstones in place of the expired entries,
+	  This means that the entries are still retrievable by delving into the
+	  stack, and expiring entries paradoxically takes extra memory.
+
+	  This memory is only reclaimed when some operation issues a
+	  git_reftable_pack_refs(), which will compact the entire stack and get
+	  rid of deletion entries.
+
+	  It would be better if the refs backend supported an API that sets a
+	  criterion for all refs, passing the criterion to pack_refs().
+	*/
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+	struct reftable_merged_table *mt = NULL;
+	struct reflog_expiry_arg arg = {
+		.stack = stack,
+		.refs = refs,
+	};
+	struct reftable_log_record log = { NULL };
+	struct reftable_iterator it = { NULL };
+	int err = 0;
+	if (refs->err < 0) {
+		return refs->err;
+	}
+	err = reftable_stack_reload(stack);
+	if (err) {
+		goto done;
+	}
+
+	mt = reftable_stack_merged_table(stack);
+	err = reftable_merged_table_seek_log(mt, &it, refname);
+	if (err < 0) {
+		goto done;
+	}
+
+	while (1) {
+		struct object_id ooid;
+		struct object_id noid;
+
+		int err = reftable_iterator_next_log(&it, &log);
+		if (err < 0) {
+			goto done;
+		}
+
+		if (err > 0 || strcmp(log.refname, refname)) {
+			break;
+		}
+		hashcpy(ooid.hash, log.update.old_hash);
+		hashcpy(noid.hash, log.update.new_hash);
+
+		if (should_prune_fn(&ooid, &noid, log.update.email,
+				    (timestamp_t)log.update.time,
+				    log.update.tz_offset, log.update.message,
+				    policy_cb_data)) {
+			add_log_tombstone(&arg, refname, log.update_index);
+		}
+	}
+	err = reftable_stack_add(stack, &write_reflog_expiry_table, &arg);
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	reftable_log_record_release(&log);
+	reftable_iterator_destroy(&it);
+	clear_log_tombstones(&arg);
+	return err;
+}
+
+static int reftable_error_to_errno(int err)
+{
+	switch (err) {
+	case REFTABLE_IO_ERROR:
+		return EIO;
+	case REFTABLE_FORMAT_ERROR:
+		return EFAULT;
+	case REFTABLE_NOT_EXIST_ERROR:
+		return ENOENT;
+	case REFTABLE_LOCK_ERROR:
+		return EBUSY;
+	case REFTABLE_API_ERROR:
+		return EINVAL;
+	case REFTABLE_ZLIB_ERROR:
+		return EDOM;
+	default:
+		return ERANGE;
+	}
+}
+
+static int git_reftable_read_raw_ref(struct ref_store *ref_store,
+				     const char *refname, struct object_id *oid,
+				     struct strbuf *referent,
+				     unsigned int *type)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+
+	struct reftable_ref_record ref = { NULL };
+	int err = 0;
+	if (refs->err < 0) {
+		return refs->err;
+	}
+
+	/* This is usually not needed, but Git doesn't signal to ref backend if
+	   a subprocess updated the ref DB.  So we always check.
+	*/
+	err = reftable_stack_reload(stack);
+	if (err) {
+		goto done;
+	}
+
+	err = reftable_stack_read_ref(stack, refname, &ref);
+	if (err > 0) {
+		errno = ENOENT;
+		err = -1;
+		goto done;
+	}
+	if (err < 0) {
+		errno = reftable_error_to_errno(err);
+		err = -1;
+		goto done;
+	}
+
+	if (ref.value_type == REFTABLE_REF_SYMREF) {
+		strbuf_reset(referent);
+		strbuf_addstr(referent, ref.value.symref);
+		*type |= REF_ISSYMREF;
+	} else if (reftable_ref_record_val1(&ref) != NULL) {
+		hashcpy(oid->hash, reftable_ref_record_val1(&ref));
+	} else {
+		*type |= REF_ISBROKEN;
+		errno = EINVAL;
+		err = -1;
+	}
+done:
+	assert(err != REFTABLE_API_ERROR);
+	reftable_ref_record_release(&ref);
+	return err;
+}
+
+struct ref_storage_be refs_be_reftable = {
+	&refs_be_files,
+	"reftable",
+	git_reftable_ref_store_create,
+	git_reftable_init_db,
+	git_reftable_transaction_prepare,
+	git_reftable_transaction_finish,
+	git_reftable_transaction_abort,
+	git_reftable_transaction_initial_commit,
+
+	git_reftable_pack_refs,
+	git_reftable_create_symref,
+	git_reftable_delete_refs,
+	git_reftable_rename_ref,
+	git_reftable_copy_ref,
+
+	git_reftable_ref_iterator_begin,
+	git_reftable_read_raw_ref,
+
+	git_reftable_reflog_iterator_begin,
+	git_reftable_for_each_reflog_ent_oldest_first,
+	git_reftable_for_each_reflog_ent_newest_first,
+	git_reftable_reflog_exists,
+	git_reftable_create_reflog,
+	git_reftable_delete_reflog,
+	git_reftable_reflog_expire,
+};
diff --git a/repository.c b/repository.c
index c98298acd017..4d8f572fc9cd 100644
--- a/repository.c
+++ b/repository.c
@@ -174,6 +174,8 @@ int repo_init(struct repository *repo,
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
+	repo->ref_storage_format = xstrdup_or_null(format.ref_storage);
+
 	clear_repository_format(&format);
 	return 0;
 
diff --git a/repository.h b/repository.h
index b385ca3c94b6..8019a7d0a1fc 100644
--- a/repository.h
+++ b/repository.h
@@ -78,6 +78,9 @@ struct repository {
 	 */
 	struct ref_store *refs_private;
 
+	/* The format to use for the ref database. */
+	char *ref_storage_format;
+
 	/*
 	 * Contains path to often used file names.
 	 */
diff --git a/setup.c b/setup.c
index c04cd25a30df..c6b57efd0318 100644
--- a/setup.c
+++ b/setup.c
@@ -500,6 +500,9 @@ static enum extension_result handle_extension(const char *var,
 			return error("invalid value for 'extensions.objectformat'");
 		data->hash_algo = format;
 		return EXTENSION_OK;
+	} else if (!strcmp(ext, "refstorage")) {
+		data->ref_storage = xstrdup(value);
+		return EXTENSION_OK;
 	}
 	return EXTENSION_UNKNOWN;
 }
@@ -651,6 +654,7 @@ void clear_repository_format(struct repository_format *format)
 	string_list_clear(&format->v1_only_extensions, 0);
 	free(format->work_tree);
 	free(format->partial_clone);
+	free(format->ref_storage);
 	init_repository_format(format);
 }
 
@@ -1308,8 +1312,11 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
 			setup_git_env(gitdir);
 		}
-		if (startup_info->have_repository)
+		if (startup_info->have_repository) {
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
+			the_repository->ref_storage_format =
+				xstrdup_or_null(repo_fmt.ref_storage);
+		}
 	}
 
 	strbuf_release(&dir);
diff --git a/t/t0031-reftable.sh b/t/t0031-reftable.sh
new file mode 100755
index 000000000000..ba0738e51561
--- /dev/null
+++ b/t/t0031-reftable.sh
@@ -0,0 +1,203 @@
+#!/bin/sh
+#
+# Copyright (c) 2020 Google LLC
+#
+
+test_description='reftable basics'
+
+. ./test-lib.sh
+
+INVALID_SHA1=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
+
+git_init () {
+	git init -b primary "$@"
+}
+
+initialize ()  {
+	rm -rf .git &&
+	git_init --ref-storage=reftable &&
+	mv .git/hooks .git/hooks-disabled
+}
+
+test_expect_success 'SHA256 support, env' '
+	rm -rf .git &&
+	GIT_DEFAULT_HASH=sha256 && export GIT_DEFAULT_HASH &&
+	git_init --ref-storage=reftable &&
+	mv .git/hooks .git/hooks-disabled &&
+	test_commit file
+'
+
+test_expect_success 'SHA256 support, option' '
+	rm -rf .git &&
+	git_init --ref-storage=reftable --object-format=sha256 &&
+	mv .git/hooks .git/hooks-disabled &&
+	test_commit file
+'
+
+test_expect_success 'delete ref' '
+	initialize &&
+	test_commit file &&
+	SHA=$(git show-ref -s --verify HEAD) &&
+	test_write_lines "$SHA refs/heads/primary" "$SHA refs/tags/file" >expect &&
+	git show-ref >actual &&
+	! git update-ref -d refs/tags/file $INVALID_SHA1 &&
+	test_cmp expect actual &&
+	git update-ref -d refs/tags/file $SHA  &&
+	test_write_lines "$SHA refs/heads/primary" >expect &&
+	git show-ref >actual &&
+	test_cmp expect actual
+'
+
+
+test_expect_success 'clone calls transaction_initial_commit' '
+	test_commit message1 file1 &&
+	git clone . cloned &&
+	(test  -f cloned/file1 || echo "Fixme.")
+'
+
+test_expect_success 'basic operation of reftable storage: commit, show-ref' '
+	initialize &&
+	test_commit file &&
+	test_write_lines refs/heads/primary refs/tags/file >expect &&
+	git show-ref &&
+	git show-ref | cut -f2 -d" " >actual &&
+	test_cmp actual expect
+'
+
+test_expect_success 'reflog, repack' '
+	initialize &&
+	for count in $(test_seq 1 10)
+	do
+		test_commit "number $count" file.t $count number-$count ||
+		return 1
+	done &&
+	git pack-refs &&
+	ls -1 .git/reftable >table-files &&
+	test_line_count = 2 table-files &&
+	git reflog refs/heads/primary >output &&
+	test_line_count = 10 output &&
+	grep "commit (initial): number 1" output &&
+	grep "commit: number 10" output &&
+	git gc &&
+	git reflog refs/heads/primary >output &&
+	test_line_count = 0 output
+'
+
+test_expect_success 'branch switch in reflog output' '
+	initialize &&
+	test_commit file1 &&
+	git checkout -b branch1 &&
+	test_commit file2 &&
+	git checkout -b branch2 &&
+	git switch - &&
+	git rev-parse --symbolic-full-name HEAD >actual &&
+	echo refs/heads/branch1 >expect &&
+	test_cmp actual expect
+'
+
+
+# This matches show-ref's output
+print_ref() {
+	echo "$(git rev-parse "$1") $1"
+}
+
+test_expect_success 'peeled tags are stored' '
+	initialize &&
+	test_commit file &&
+	git tag -m "annotated tag" test_tag HEAD &&
+	{
+		print_ref "refs/heads/primary" &&
+		print_ref "refs/tags/file" &&
+		print_ref "refs/tags/test_tag" &&
+		print_ref "refs/tags/test_tag^{}"
+	} >expect &&
+	git show-ref -d >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'show-ref works on fresh repo' '
+	initialize &&
+	rm -rf .git &&
+	git_init --ref-storage=reftable &&
+	>expect &&
+	! git show-ref >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'checkout unborn branch' '
+	initialize &&
+	git checkout -b primary
+'
+
+
+test_expect_success 'dir/file conflict' '
+	initialize &&
+	test_commit file &&
+	! git branch primary/forbidden
+'
+
+
+test_expect_success 'do not clobber existing repo' '
+	rm -rf .git &&
+	git_init --ref-storage=files &&
+	cat .git/HEAD >expect &&
+	test_commit file &&
+	(git_init --ref-storage=reftable || true) &&
+	cat .git/HEAD >actual &&
+	test_cmp expect actual
+'
+
+# cherry-pick uses a pseudo ref.
+test_expect_success 'pseudo refs' '
+	initialize &&
+	test_commit message1 file1 &&
+	test_commit message2 file2 &&
+	git branch source &&
+	git checkout HEAD^ &&
+	test_commit message3 file3 &&
+	git cherry-pick source &&
+	test -f file2
+'
+
+# cherry-pick uses a pseudo ref.
+test_expect_success 'rebase' '
+	initialize &&
+	test_commit message1 file1 &&
+	test_commit message2 file2 &&
+	git branch source &&
+	git checkout HEAD^ &&
+	test_commit message3 file3 &&
+	git rebase source &&
+	test -f file2
+'
+
+test_expect_success 'worktrees' '
+	git_init --ref-storage=reftable start &&
+	(cd start && test_commit file1 && git checkout -b branch1 &&
+	git checkout -b branch2 &&
+	git worktree add  ../wt
+	) &&
+	cd wt &&
+	git checkout branch1 &&
+	git branch
+'
+
+test_expect_success 'worktrees 2' '
+	initialize &&
+	test_commit file1 &&
+	mkdir existing_empty &&
+	git worktree add --detach existing_empty primary
+'
+
+test_expect_success 'FETCH_HEAD' '
+	initialize &&
+	test_commit one &&
+	(git_init sub && cd sub && test_commit two) &&
+	git --git-dir sub/.git rev-parse HEAD >expect &&
+	git fetch sub &&
+	git checkout FETCH_HEAD &&
+	git rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_done
diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
index be12fb63506e..c6f783255633 100755
--- a/t/t1409-avoid-packing-refs.sh
+++ b/t/t1409-avoid-packing-refs.sh
@@ -4,6 +4,12 @@ test_description='avoid rewriting packed-refs unnecessarily'
 
 . ./test-lib.sh
 
+if test_have_prereq REFTABLE
+then
+  skip_all='skipping pack-refs tests; incompatible with reftable'
+  test_done
+fi
+
 # Add an identifying mark to the packed-refs file header line. This
 # shouldn't upset readers, and it should be omitted if the file is
 # ever rewritten.
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 5071ac63a5b5..16440d58d6bb 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -8,6 +8,12 @@ test_description='git fsck random collection of tests
 
 . ./test-lib.sh
 
+if test_have_prereq REFTABLE
+then
+  skip_all='skipping tests; incompatible with reftable'
+  test_done
+fi
+
 test_expect_success setup '
 	git config gc.auto 0 &&
 	git config i18n.commitencoding ISO-8859-1 &&
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 3b7cdc56ec84..667a23affe36 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -14,6 +14,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+if test_have_prereq REFTABLE
+then
+  skip_all='skipping pack-refs tests; incompatible with reftable'
+  test_done
+fi
+
 test_expect_success 'enable reflogs' '
 	git config core.logallrefupdates true
 '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index d3f6af6a6545..943aa9713961 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1481,6 +1481,11 @@ parisc* | hppa*)
 	;;
 esac
 
+if test -n "$GIT_TEST_REFTABLE"
+then
+  test_set_prereq REFTABLE
+fi
+
 ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PTHREADS" && test_set_prereq PTHREADS
-- 
gitgitgadget

