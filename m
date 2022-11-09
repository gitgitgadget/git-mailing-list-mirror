Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E353C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 00:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiKIAry (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 19:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiKIArf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 19:47:35 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B7A627E1
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 16:47:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q62-20020a25d941000000b006cac1a4000cso15411304ybg.14
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 16:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VeKu1cchG/zF3Aum8UkZ44ZUHzDLNKYFOqMsM2VsPlQ=;
        b=ryk5PDRvakKCaFUQxCkf5cZENUKwOSsrSG4jehHQ7b6ZOt0MUCJFtjxMlMC/PW1KvW
         xA56P6SPSF51HAnVHSA2jxK3y8+5q3VHfsQu8kilzrympVzlGARD8mBRBFOQJBPjv/4f
         SVFFncPPq9jnCDamYi9VOxoSdjkH3JZ4DteO+g+UpgCr2lACkOHMRHWbLDkgyKrdsX9x
         SrAiGrdvLAJOch1FI9clRAUGLeqSrtOciQV3ZqDLsh5Z1LeofdW5rRIj4lD1cCZozQIy
         8FrAAxwr2MSrWnsw6oR3JQfOhbbD4hAkj7wtzUG7xsaXZOxIZSCC6MZAY4QVawnuPyvi
         YVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VeKu1cchG/zF3Aum8UkZ44ZUHzDLNKYFOqMsM2VsPlQ=;
        b=ec58c/N6ZNPJBGSwX8vq5N3Escnpm3gCn3d4bpXcdGDmKXqmZGnZDJjdyGGdM4/2ql
         BUeq/L3wsojp+4u6aA9J9ZVb5fW3gZtNRCaHfP9wz8mOGD9zfKUr1hLau9Lzh4EA6i1d
         j98PE4lnUc1kaANkvBT1PB3jku5x1xE3ba6kXih0mjtwTyJbY8a3xsld34cepJrQeIgn
         7KQWnap680qL9O38UAFRuUqzwWf3qYopiVCK8Lh6BFjfy2TLeYCGNUxiVh1DwrlYr9G5
         b8f6/nZ5g1b4aeBp9HKx/ViPJsWOkoCIHQMGTIBHm8ATlJlTPEW+oDjFU/IhEYWUrXVm
         EQMg==
X-Gm-Message-State: ACrzQf1fjMW/H2oWhMCWcH91TllwGf/iDNenKXOOxPIRjhKpDzUMLh4I
        gusgOaV6b2KRAYNxGdv1nxIe9iCDPfXL85NipNTYl61wNCAw5HgDtI9CTb4eF403aI4zJt3uvgH
        hTZw2sGQwP9au/M1uAhRWFgPO5laLGkmbilZ4AyQBCZSHwqh3+r8ne8SVdbKjt1k=
X-Google-Smtp-Source: AMsMyM5JKQjifmVpmMnPIvj6ZOBtBzS9cI6Vzwq/CAj05EaiNa2cs5n24CEHNlfuuVCuhYaE8+X2mx8MasHs3Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:d609:0:b0:6ca:6c0c:9caa with SMTP id
 n9-20020a25d609000000b006ca6c0c9caamr58598586ybg.557.1667954852836; Tue, 08
 Nov 2022 16:47:32 -0800 (PST)
Date:   Tue,  8 Nov 2022 16:47:08 -0800
In-Reply-To: <20221109004708.97668-1-chooglen@google.com>
Mime-Version: 1.0
References: <20221109004708.97668-1-chooglen@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221109004708.97668-5-chooglen@google.com>
Subject: [RFC PATCH 4/4] git: remove --super-prefix
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It has no more users, and prospective new users can use per-command
flags instead, e.g. "git fetch --submodule-prefix" or "git
submodule--helper --toplevel-cwd-prefix".

Now that this flag is gone, also remove a now-defunct test from
t/t7527-builtin-fsmonitor.sh.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/git.txt        |  7 +----
 builtin.h                    |  4 ---
 cache.h                      |  2 --
 environment.c                | 13 ----------
 git.c                        | 40 +++++------------------------
 t/t7527-builtin-fsmonitor.sh | 50 ------------------------------------
 6 files changed, 8 insertions(+), 108 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 1d33e083ab..85c7d9500e 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -13,7 +13,7 @@ SYNOPSIS
     [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--bare]
     [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
-    [--super-prefix=<path>] [--config-env=<name>=<envvar>]
+    [--config-env=<name>=<envvar>]
     <command> [<args>]
 
 DESCRIPTION
@@ -169,11 +169,6 @@ If you just want to run git as if it was started in `<path>` then use
 	details.  Equivalent to setting the `GIT_NAMESPACE` environment
 	variable.
 
---super-prefix=<path>::
-	Currently for internal use only.  Set a prefix which gives a path from
-	above a repository down to its root.  One use is to give submodules
-	context about the superproject that invoked it.
-
 --bare::
 	Treat the repository as a bare repository.  If GIT_DIR
 	environment is not set, it is set to the current working
diff --git a/builtin.h b/builtin.h
index 8901a34d6b..8264b7e524 100644
--- a/builtin.h
+++ b/builtin.h
@@ -51,10 +51,6 @@
  *	on bare repositories.
  *	This only makes sense when `RUN_SETUP` is also set.
  *
- * `SUPPORT_SUPER_PREFIX`:
- *
- *	The built-in supports `--super-prefix`.
- *
  * `DELAY_PAGER_CONFIG`:
  *
  *	If RUN_SETUP or RUN_SETUP_GENTLY is set, git.c normally handles
diff --git a/cache.h b/cache.h
index 26ed03bd6d..a4a0377b80 100644
--- a/cache.h
+++ b/cache.h
@@ -504,7 +504,6 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
 #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
 #define GIT_PREFIX_ENVIRONMENT "GIT_PREFIX"
-#define GIT_SUPER_PREFIX_ENVIRONMENT "GIT_INTERNAL_SUPER_PREFIX"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
@@ -590,7 +589,6 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
 int get_common_dir(struct strbuf *sb, const char *gitdir);
 const char *get_git_namespace(void);
 const char *strip_namespace(const char *namespaced_ref);
-const char *get_super_prefix(void);
 const char *get_git_work_tree(void);
 
 /*
diff --git a/environment.c b/environment.c
index 18d042b467..1ee3686fd8 100644
--- a/environment.c
+++ b/environment.c
@@ -102,8 +102,6 @@ char *git_work_tree_cfg;
 
 static char *git_namespace;
 
-static char *super_prefix;
-
 /*
  * Repository-local GIT_* environment variables; see cache.h for details.
  */
@@ -121,7 +119,6 @@ const char * const local_repo_env[] = {
 	NO_REPLACE_OBJECTS_ENVIRONMENT,
 	GIT_REPLACE_REF_BASE_ENVIRONMENT,
 	GIT_PREFIX_ENVIRONMENT,
-	GIT_SUPER_PREFIX_ENVIRONMENT,
 	GIT_SHALLOW_FILE_ENVIRONMENT,
 	GIT_COMMON_DIR_ENVIRONMENT,
 	NULL
@@ -234,16 +231,6 @@ const char *strip_namespace(const char *namespaced_ref)
 	return NULL;
 }
 
-const char *get_super_prefix(void)
-{
-	static int initialized;
-	if (!initialized) {
-		super_prefix = xstrdup_or_null(getenv(GIT_SUPER_PREFIX_ENVIRONMENT));
-		initialized = 1;
-	}
-	return super_prefix;
-}
-
 static int git_work_tree_initialized;
 
 /*
diff --git a/git.c b/git.c
index fb69e60591..5548619aea 100644
--- a/git.c
+++ b/git.c
@@ -14,9 +14,8 @@
  * RUN_SETUP for reading from the configuration file.
  */
 #define NEED_WORK_TREE		(1<<3)
-#define SUPPORT_SUPER_PREFIX	(1<<4)
-#define DELAY_PAGER_CONFIG	(1<<5)
-#define NO_PARSEOPT		(1<<6) /* parse-options is not used */
+#define DELAY_PAGER_CONFIG	(1<<4)
+#define NO_PARSEOPT		(1<<5) /* parse-options is not used */
 
 struct cmd_struct {
 	const char *cmd;
@@ -29,7 +28,7 @@ const char git_usage_string[] =
 	   "           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
 	   "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]\n"
 	   "           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
-	   "           [--super-prefix=<path>] [--config-env=<name>=<envvar>]\n"
+	   "           [--config-env=<name>=<envvar>]\n"
 	   "           <command> [<args>]");
 
 const char git_more_info_string[] =
@@ -226,20 +225,6 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			setenv(GIT_WORK_TREE_ENVIRONMENT, cmd, 1);
 			if (envchanged)
 				*envchanged = 1;
-		} else if (!strcmp(cmd, "--super-prefix")) {
-			if (*argc < 2) {
-				fprintf(stderr, _("no prefix given for --super-prefix\n" ));
-				usage(git_usage_string);
-			}
-			setenv(GIT_SUPER_PREFIX_ENVIRONMENT, (*argv)[1], 1);
-			if (envchanged)
-				*envchanged = 1;
-			(*argv)++;
-			(*argc)--;
-		} else if (skip_prefix(cmd, "--super-prefix=", &cmd)) {
-			setenv(GIT_SUPER_PREFIX_ENVIRONMENT, cmd, 1);
-			if (envchanged)
-				*envchanged = 1;
 		} else if (!strcmp(cmd, "--bare")) {
 			char *cwd = xgetcwd();
 			is_bare_repository_cfg = 1;
@@ -449,11 +434,6 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 		trace_repo_setup(prefix);
 	commit_pager_choice();
 
-	if (!help && get_super_prefix()) {
-		if (!(p->option & SUPPORT_SUPER_PREFIX))
-			die(_("%s doesn't support --super-prefix"), p->cmd);
-	}
-
 	if (!help && p->option & NEED_WORK_TREE)
 		setup_work_tree();
 
@@ -504,7 +484,7 @@ static struct cmd_struct commands[] = {
 	{ "check-ref-format", cmd_check_ref_format, NO_PARSEOPT  },
 	{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
 	{ "checkout--worker", cmd_checkout__worker,
-		RUN_SETUP | NEED_WORK_TREE | SUPPORT_SUPER_PREFIX },
+		RUN_SETUP | NEED_WORK_TREE },
 	{ "checkout-index", cmd_checkout_index,
 		RUN_SETUP | NEED_WORK_TREE},
 	{ "cherry", cmd_cherry, RUN_SETUP },
@@ -539,7 +519,7 @@ static struct cmd_struct commands[] = {
 	{ "format-patch", cmd_format_patch, RUN_SETUP },
 	{ "fsck", cmd_fsck, RUN_SETUP },
 	{ "fsck-objects", cmd_fsck, RUN_SETUP },
-	{ "fsmonitor--daemon", cmd_fsmonitor__daemon, SUPPORT_SUPER_PREFIX | RUN_SETUP },
+	{ "fsmonitor--daemon", cmd_fsmonitor__daemon, RUN_SETUP },
 	{ "gc", cmd_gc, RUN_SETUP },
 	{ "get-tar-commit-id", cmd_get_tar_commit_id, NO_PARSEOPT },
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
@@ -583,7 +563,7 @@ static struct cmd_struct commands[] = {
 	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE },
 	{ "push", cmd_push, RUN_SETUP },
 	{ "range-diff", cmd_range_diff, RUN_SETUP | USE_PAGER },
-	{ "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX},
+	{ "read-tree", cmd_read_tree, RUN_SETUP },
 	{ "rebase", cmd_rebase, RUN_SETUP | NEED_WORK_TREE },
 	{ "receive-pack", cmd_receive_pack },
 	{ "reflog", cmd_reflog, RUN_SETUP },
@@ -610,7 +590,7 @@ static struct cmd_struct commands[] = {
 	{ "stash", cmd_stash, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
-	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX },
+	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP },
 	{ "switch", cmd_switch, RUN_SETUP | NEED_WORK_TREE },
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 	{ "tag", cmd_tag, RUN_SETUP | DELAY_PAGER_CONFIG },
@@ -727,9 +707,6 @@ static void execv_dashed_external(const char **argv)
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	int status;
 
-	if (get_super_prefix())
-		die(_("%s doesn't support --super-prefix"), argv[0]);
-
 	if (use_pager == -1 && !is_builtin(argv[0]))
 		use_pager = check_pager_config(argv[0]);
 	commit_pager_choice();
@@ -799,9 +776,6 @@ static int run_argv(int *argcp, const char ***argv)
 			 */
 			trace2_cmd_name("_run_git_alias_");
 
-			if (get_super_prefix())
-				die("%s doesn't support --super-prefix", **argv);
-
 			commit_pager_choice();
 
 			strvec_push(&args, "git");
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 4abc74db2b..d11cb1854c 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -860,56 +860,6 @@ test_expect_success 'submodule always visited' '
 	my_match_and_clean
 '
 
-# If a submodule has a `sub/.git/` directory (rather than a file
-# pointing to the super's `.git/modules/sub`) and `core.fsmonitor`
-# turned on in the submodule and the daemon is not yet started in
-# the submodule, and someone does a `git submodule absorbgitdirs`
-# in the super, Git will recursively invoke `git submodule--helper`
-# to do the work and this may try to read the index.  This will
-# try to start the daemon in the submodule *and* pass (either
-# directly or via inheritance) the `--super-prefix` arg to the
-# `git fsmonitor--daemon start` command inside the submodule.
-# This causes a warning because fsmonitor--daemon does take that
-# global arg (see the table in git.c)
-#
-# This causes a warning when trying to start the daemon that is
-# somewhat confusing.  It does not seem to hurt anything because
-# the fsmonitor code maps the query failure into a trivial response
-# and does the work anyway.
-#
-# It would be nice to silence the warning, however.
-
-have_t2_error_event () {
-	log=$1
-	msg="fsmonitor--daemon doesnQt support --super-prefix" &&
-
-	tr '\047' Q <$1 | grep -e "$msg"
-}
-
-test_expect_success "stray submodule super-prefix warning" '
-	test_when_finished "rm -rf super; \
-			    rm -rf sub;   \
-			    rm super-sub.trace" &&
-
-	create_super super &&
-	create_sub sub &&
-
-	# Copy rather than submodule add so that we get a .git dir.
-	cp -R ./sub ./super/dir_1/dir_2/sub &&
-
-	git -C super/dir_1/dir_2/sub config core.fsmonitor true &&
-
-	git -C super submodule add ../sub ./dir_1/dir_2/sub &&
-	git -C super commit -m "add sub" &&
-
-	test_path_is_dir super/dir_1/dir_2/sub/.git &&
-
-	GIT_TRACE2_EVENT="$PWD/super-sub.trace" \
-		git -C super submodule absorbgitdirs &&
-
-	! have_t2_error_event super-sub.trace
-'
-
 # On a case-insensitive file system, confirm that the daemon
 # notices when the .git directory is moved/renamed/deleted
 # regardless of how it is spelled in the the FS event.
-- 
2.38.1.431.g37b22c650d-goog

