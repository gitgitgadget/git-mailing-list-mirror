Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50D621F991
	for <e@80x24.org>; Thu,  3 Aug 2017 18:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbdHCSUg (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 14:20:36 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35794 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbdHCSUc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 14:20:32 -0400
Received: by mail-pg0-f48.google.com with SMTP id v189so9318274pgd.2
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 11:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BXYiuB5s/16T9G85kvhTR9hwhhWnd4x0RHvJnMLaMSU=;
        b=IY1Foz+q4gQBKV7PVAlhU54ixtAxwDfyCl1lEzTf+n0iiASuZB73TuA1WHwKH+Rawb
         30zMYqlNaA1sStfmww6P2IjrRxTif0+9crWVf99TjgWp7qOPvtRIiJ1yFpKrApupuwps
         VfB8totl2wP0B9INjWS6bgRSBPlzd6nCpa68wvapbQUx7tqoi4Wp6kvA6MouCPyoZHxo
         yJSXuyqubAwuS7WTyjUyfV2hS3Lu+Zeneu2LGXY64DtHmGnx9yqn9ZBlkfn2zZkWwiN1
         XjzMLJDc20SNgwZjngVzNOJZLM9TIhUzBP1mfYRCQW1wit29ClY+m4jTvvQaZEPdqha1
         ccRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BXYiuB5s/16T9G85kvhTR9hwhhWnd4x0RHvJnMLaMSU=;
        b=dNTYDIFtoo0AYXHEYKzoUpH4/goYauZfy5AejxHUgqSiEmZ74SJQiA0N8rjg6sNSXZ
         sQ0u4PaAetfqJiTQ9QD3a6Jve8h5JJ47xy+sujQ5rbpYHbJxxM3pRdroxnS7tmIE5dBm
         Yqpiym7g5kpMZZy09gADTfLehs7/Sb4gCVTX72UPsUlKbAKbPimNH/maI+9R4qVp3Kk/
         PMRDFQVnH4ITibLB2ccXY7SrUUgnxEueyijFDpOGr+GicK4BCmkLugUG3G+aXJ4zg3zu
         XdkIHZ/zI2hgT3ga8GTyUAOA5cZGCfK31tlAa5HleMxPG7XWhl2Gdnd0Jn24Wj9yU0vO
         D7HQ==
X-Gm-Message-State: AIVw111/f6pLYc4X4Cnj3Qb5bvZeXDwBLiY5X3nHfJ3BTg2creF2+3go
        7iekE8B/uTHmkpPFjG6LHA==
X-Received: by 10.84.196.129 with SMTP id l1mr2810189pld.337.1501784431513;
        Thu, 03 Aug 2017 11:20:31 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d1sm10706293pgc.57.2017.08.03.11.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 11:20:30 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Jens.Lehmann@web.de, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 15/15] submodule: remove gitmodules_config
Date:   Thu,  3 Aug 2017 11:20:00 -0700
Message-Id: <20170803182000.179328-16-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170803182000.179328-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170803182000.179328-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the submodule-config subsystem can lazily read the gitmodules
file we no longer need to explicitly pre-read the gitmodules by calling
'gitmodules_config()' so let's remove it.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/checkout.c               |  1 -
 builtin/commit.c                 |  1 -
 builtin/diff-files.c             |  1 -
 builtin/diff-index.c             |  1 -
 builtin/diff-tree.c              |  1 -
 builtin/diff.c                   |  2 --
 builtin/fetch.c                  |  4 ----
 builtin/grep.c                   |  4 ----
 builtin/mv.c                     |  1 -
 builtin/read-tree.c              |  2 --
 builtin/reset.c                  |  2 --
 builtin/rm.c                     |  1 -
 builtin/submodule--helper.c      | 14 --------------
 submodule.c                      | 15 ---------------
 submodule.h                      |  2 --
 t/helper/test-submodule-config.c |  1 -
 16 files changed, 53 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 246e0cd16..63ae16afc 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1179,7 +1179,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.prefix = prefix;
 	opts.show_progress = -1;
 
-	gitmodules_config();
 	git_config(git_checkout_config, &opts);
 
 	opts.track = BRANCH_TRACK_UNSPECIFIED;
diff --git a/builtin/commit.c b/builtin/commit.c
index 4bbac014a..18ad714d9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -195,7 +195,6 @@ static void determine_whence(struct wt_status *s)
 static void status_init_config(struct wt_status *s, config_fn_t fn)
 {
 	wt_status_prepare(s);
-	gitmodules_config();
 	git_config(fn, s);
 	determine_whence(s);
 	init_diff_ui_defaults();
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 17bf84d18..e88493ffe 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -26,7 +26,6 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	init_revisions(&rev, prefix);
-	gitmodules_config();
 	rev.abbrev = 0;
 	precompose_argv(argc, argv);
 
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 185e6f9b5..9d772f8f2 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -23,7 +23,6 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	init_revisions(&rev, prefix);
-	gitmodules_config();
 	rev.abbrev = 0;
 	precompose_argv(argc, argv);
 
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 31d2cb410..d66499909 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -110,7 +110,6 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	init_revisions(opt, prefix);
-	gitmodules_config();
 	opt->abbrev = 0;
 	opt->diff = 1;
 	opt->disable_stdin = 1;
diff --git a/builtin/diff.c b/builtin/diff.c
index 7cde6abbc..7e3ebcea3 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -315,8 +315,6 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			no_index = DIFF_NO_INDEX_IMPLICIT;
 	}
 
-	if (!no_index)
-		gitmodules_config();
 	init_diff_ui_defaults();
 	git_config(git_diff_ui_config, NULL);
 	precompose_argv(argc, argv);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3fe99073d..132e3224e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1360,10 +1360,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (depth || deepen_since || deepen_not.nr)
 		deepen = 1;
 
-	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
-		gitmodules_config();
-	}
-
 	if (all) {
 		if (argc == 1)
 			die(_("fetch --all does not take a repository argument"));
diff --git a/builtin/grep.c b/builtin/grep.c
index ac06d2d33..2d65f27d0 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1048,10 +1048,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 #endif
 
-	if (recurse_submodules) {
-		gitmodules_config();
-	}
-
 	if (show_in_pager && (cached || list.nr))
 		die(_("--open-files-in-pager only works on the worktree"));
 
diff --git a/builtin/mv.c b/builtin/mv.c
index 94fbaaa5d..ffdd5f01a 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -131,7 +131,6 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	struct stat st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
 
-	gitmodules_config();
 	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_mv_options,
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index d5f618d08..bf87a2710 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -164,8 +164,6 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	argc = parse_options(argc, argv, unused_prefix, read_tree_options,
 			     read_tree_usage, 0);
 
-	load_submodule_cache();
-
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
 	prefix_set = opts.prefix ? 1 : 0;
diff --git a/builtin/reset.c b/builtin/reset.c
index 772d078b8..50488d273 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -309,8 +309,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 						PARSE_OPT_KEEP_DASHDASH);
 	parse_args(&pathspec, argv, prefix, patch_mode, &rev);
 
-	load_submodule_cache();
-
 	unborn = !strcmp(rev, "HEAD") && get_oid("HEAD", &oid);
 	if (unborn) {
 		/* reset on unborn branch: treat as reset to empty tree */
diff --git a/builtin/rm.c b/builtin/rm.c
index 4057e73fa..d91451fea 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -255,7 +255,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	struct pathspec pathspec;
 	char *seen;
 
-	gitmodules_config();
 	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_rm_options,
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ba767c704..c97fde439 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -275,8 +275,6 @@ static void module_list_active(struct module_list *list)
 	int i;
 	struct module_list active_modules = MODULE_LIST_INIT;
 
-	gitmodules_config();
-
 	for (i = 0; i < list->nr; i++) {
 		const struct cache_entry *ce = list->entries[i];
 
@@ -337,9 +335,6 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	struct strbuf sb = STRBUF_INIT;
 	char *upd = NULL, *url = NULL, *displaypath;
 
-	/* Only loads from .gitmodules, no overlay with .git/config */
-	gitmodules_config();
-
 	if (prefix && get_super_prefix())
 		die("BUG: cannot have prefix and superprefix");
 	else if (prefix)
@@ -475,7 +470,6 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	if (argc != 2)
 		usage(_("git submodule--helper name <path>"));
 
-	gitmodules_config();
 	sub = submodule_from_path(&null_oid, argv[1]);
 
 	if (!sub)
@@ -1042,8 +1036,6 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	if (pathspec.nr)
 		suc.warn_if_uninitialized = 1;
 
-	gitmodules_config();
-
 	run_processes_parallel(max_jobs,
 			       update_clone_get_next_task,
 			       update_clone_start_failure,
@@ -1084,8 +1076,6 @@ static const char *remote_submodule_branch(const char *path)
 	const char *branch = NULL;
 	char *key;
 
-	gitmodules_config();
-
 	sub = submodule_from_path(&null_oid, path);
 	if (!sub)
 		return NULL;
@@ -1204,8 +1194,6 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, embed_gitdir_options,
 			     git_submodule_helper_usage, 0);
 
-	gitmodules_config();
-
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
 		return 1;
 
@@ -1221,8 +1209,6 @@ static int is_active(int argc, const char **argv, const char *prefix)
 	if (argc != 2)
 		die("submodule--helper is-active takes exactly 1 argument");
 
-	gitmodules_config();
-
 	return !is_submodule_active(the_repository, argv[1]);
 }
 
diff --git a/submodule.c b/submodule.c
index c1cef1c37..77346da88 100644
--- a/submodule.c
+++ b/submodule.c
@@ -208,19 +208,6 @@ int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
 	return 0;
 }
 
-void load_submodule_cache(void)
-{
-	if (config_update_recurse_submodules == RECURSE_SUBMODULES_OFF)
-		return;
-
-	gitmodules_config();
-}
-
-void gitmodules_config(void)
-{
-	repo_read_gitmodules(the_repository);
-}
-
 /*
  * Determine if a submodule has been initialized at a given 'path'
  */
@@ -1093,7 +1080,6 @@ int submodule_touches_in_range(struct object_id *excl_oid,
 	struct argv_array args = ARGV_ARRAY_INIT;
 	int ret;
 
-	gitmodules_config();
 	/* No need to check if there are no submodules configured */
 	if (!submodule_from_path(NULL, NULL))
 		return 0;
@@ -2000,7 +1986,6 @@ int submodule_to_gitdir(struct strbuf *buf, const char *submodule)
 		strbuf_addstr(buf, git_dir);
 	}
 	if (!is_git_directory(buf->buf)) {
-		gitmodules_config();
 		sub = submodule_from_path(&null_oid, submodule);
 		if (!sub) {
 			ret = -1;
diff --git a/submodule.h b/submodule.h
index 02195c24f..be103ad9d 100644
--- a/submodule.h
+++ b/submodule.h
@@ -45,8 +45,6 @@ extern int git_default_submodule_config(const char *var, const char *value, void
 struct option;
 int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
 						     const char *arg, int unset);
-void load_submodule_cache(void);
-extern void gitmodules_config(void);
 extern int is_submodule_active(struct repository *repo, const char *path);
 /*
  * Determine if a submodule has been populated at a given 'path' by checking if
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index f4a7c431c..f23db3b19 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -32,7 +32,6 @@ int cmd_main(int argc, const char **argv)
 		die_usage(argc, argv, "Wrong number of arguments.");
 
 	setup_git_directory();
-	gitmodules_config();
 
 	while (*arg) {
 		struct object_id commit_oid;
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

