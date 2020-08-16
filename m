Return-Path: <SRS0=m/NF=B2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D6CC433E1
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 06:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F2E2065C
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 06:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/3wU40j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgHPG7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Aug 2020 02:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbgHPG7R (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Aug 2020 02:59:17 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CE6C061385
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 23:59:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c19so11119018wmd.1
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 23:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZrJ7pai114Fzc5IoVpWnRKyIRPCcvWzEB4ynT5Y+AG4=;
        b=s/3wU40jCkro7Adyl3vW6iZP8kRvjOjtpVM/oN3dVd/CT6VBALTUvbtMnp3ALHhB+B
         ZFXO3w5abv9Ujc0aL8jVoTc/aPpu6mKQFKaxnx+uZXYhHru181Y7lJev7+WkE0uF4ccj
         zyb5O/Iv0UqGjVvvbI/1muMdneZ0zA5WhNDK8tdhZmQOZeyCY9J8V9vGHDvniiZUAFE6
         ZTjjgBuotH8k0D0EPyPyePrPs5+ZpUtFPvOT1VebeYAQ8quMmfUpIRywLg9S3yCRHqZm
         ahwRplpLVdTnNJXr+igfv/KVUC7gENhY1APJCwEGDwiDQAQWsKYMp6ayQQcUw7AHzRwK
         Zvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZrJ7pai114Fzc5IoVpWnRKyIRPCcvWzEB4ynT5Y+AG4=;
        b=JPTxvNt8KBLC/ec9VUhY3lFdF5+M9x4ZCmHR+xcOhHAz8mqz4luekbv1Jfqo49yizz
         uJNwUNo09ByCHyE+X5ftMqmt4kK46u4CbEK/IrL/H6g0Ui0yAqixj477VcdOonoQ6GcN
         JXgVHdsLph508+udSotn8SH295EXWBELTz4mQ7Om4eyUbNy6mxS/sXBDGe43zvhcuBqI
         stfHajsPnNMT/TYlYzF7VZZKnd9NRd7tQiewcujXCrqVZ8iW5TQmzWDfbWE2Xa/w1Hl2
         VfGtPFAjQmkLCqLb84fN1MbXPP9X/alwTZ7g5fHHJwOijVApr1YAf4pxlwuT07zDZA6Q
         8RcQ==
X-Gm-Message-State: AOAM530BWaKqtDy4CJB0CwAIuNzgp+G2RwcDShwZaceWRVntH1uKNExG
        KYT0D9DMI070P8H2GPqys3fMVp+TNRY=
X-Google-Smtp-Source: ABdhPJzJcsiAl1Y52q7sqP5d/ljkzBHW+V2QTQY3TW7BYlRCYUhGRLNo+YXO72QLIpKYc5nkO2FWCg==
X-Received: by 2002:a7b:c011:: with SMTP id c17mr9478983wmb.63.1597561155310;
        Sat, 15 Aug 2020 23:59:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6sm32134525wme.32.2020.08.15.23.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 23:59:14 -0700 (PDT)
Message-Id: <b9310e9941e91336258edd97a913e5908180720e.1597561152.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.831.git.git.1597561152.gitgitgadget@gmail.com>
References: <pull.831.git.git.1597561152.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Aug 2020 06:59:11 +0000
Subject: [PATCH 3/3] dir: fix problematic API to avoid memory leaks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Two commits ago, we noticed that parent_hashmap and recursive_hashmap
were being leaked and fixed it by making clear_pattern_list() free those
hashmaps.  One commit ago, we noticed that clear_directory() was only
taking responsibility for a subset of fields within dir_struct, despite
the fact that entries[] and ignored[] we allocated internally to dir.c,
resulting in many callers either leaking or haphazardly trying to free
these arrays and their contents.

Digging further, I found that despite the pretty clear documentation
near the top of dir.h that folks were supposed to call clear_directory()
when the user no longer needed the dir_struct, there were four callers
that didn't bother doing that at all.  However, two of them clearly
thought about leaks since they had an UNLEAK(dir) directive, which to me
suggests that the method to free the data was too unclear.  I suspect
the non-obviousness of the API and its holes led folks to avoid it,
which then snowballed into further problems with the entries[],
ignored[], parent_hashmap, and recursive_hashmap problems.

Rename clear_directory() to dir_free() to be more in line with other
data structures in git, and introduce a dir_init() to handle the
suggested memsetting of dir_struct to all zeroes.  I hope that a name
like "dir_free()" is more clear, and that the presence of dir_init()
will provide a hint to those looking at the code that there may be a
corresponding dir_free() that they need to call.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/add.c          |  4 ++--
 builtin/check-ignore.c |  4 ++--
 builtin/clean.c        |  8 ++++----
 builtin/grep.c         |  3 ++-
 builtin/ls-files.c     |  4 ++--
 builtin/stash.c        |  4 ++--
 dir.c                  |  7 ++++++-
 dir.h                  | 19 ++++++++++---------
 merge.c                |  3 ++-
 wt-status.c            |  4 ++--
 10 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index ab39a60a0d..46c9a0f552 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -534,11 +534,11 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	die_in_unpopulated_submodule(&the_index, prefix);
 	die_path_inside_submodule(&the_index, &pathspec);
 
+	dir_init(&dir);
 	if (add_new_files) {
 		int baselen;
 
 		/* Set up the default git porcelain excludes */
-		memset(&dir, 0, sizeof(dir));
 		if (!ignored_too) {
 			dir.flags |= DIR_COLLECT_IGNORED;
 			setup_standard_excludes(&dir);
@@ -611,7 +611,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("Unable to write new index file"));
 
+	dir_free(&dir);
 	UNLEAK(pathspec);
-	UNLEAK(dir);
 	return exit_status;
 }
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index ea5d0ae3a6..29b464a1fa 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -180,7 +180,7 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 	if (!no_index && read_cache() < 0)
 		die(_("index file corrupt"));
 
-	memset(&dir, 0, sizeof(dir));
+	dir_init(&dir);
 	setup_standard_excludes(&dir);
 
 	if (stdin_paths) {
@@ -190,7 +190,7 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 		maybe_flush_or_die(stdout, "ignore to stdout");
 	}
 
-	clear_directory(&dir);
+	dir_free(&dir);
 
 	return !num_ignored;
 }
diff --git a/builtin/clean.c b/builtin/clean.c
index 4ffe00dd7f..a4cf58af74 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -667,7 +667,7 @@ static int filter_by_patterns_cmd(void)
 		if (!confirm.len)
 			break;
 
-		memset(&dir, 0, sizeof(dir));
+		dir_init(&dir);
 		pl = add_pattern_list(&dir, EXC_CMDL, "manual exclude");
 		ignore_list = strbuf_split_max(&confirm, ' ', 0);
 
@@ -698,7 +698,7 @@ static int filter_by_patterns_cmd(void)
 		}
 
 		strbuf_list_free(ignore_list);
-		clear_directory(&dir);
+		dir_free(&dir);
 	}
 
 	strbuf_release(&confirm);
@@ -923,7 +923,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, builtin_clean_usage,
 			     0);
 
-	memset(&dir, 0, sizeof(dir));
+	dir_init(&dir);
 	if (!interactive && !dry_run && !force) {
 		if (config_set)
 			die(_("clean.requireForce set to true and neither -i, -n, nor -f given; "
@@ -1021,7 +1021,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		string_list_append(&del_list, rel);
 	}
 
-	clear_directory(&dir);
+	dir_free(&dir);
 
 	if (interactive && del_list.nr > 0)
 		interactive_main_loop();
diff --git a/builtin/grep.c b/builtin/grep.c
index cee9db3477..fef2cc05ca 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -693,7 +693,7 @@ static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
 	struct dir_struct dir;
 	int i, hit = 0;
 
-	memset(&dir, 0, sizeof(dir));
+	dir_init(&dir);
 	if (!use_index)
 		dir.flags |= DIR_NO_GITLINKS;
 	if (exc_std)
@@ -705,6 +705,7 @@ static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
 		if (hit && opt->status_only)
 			break;
 	}
+	dir_free(&dir);
 	return hit;
 }
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 30a4c10334..740feff53e 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -584,7 +584,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(ls_files_usage, builtin_ls_files_options);
 
-	memset(&dir, 0, sizeof(dir));
+	dir_init(&dir);
 	prefix = cmd_prefix;
 	if (prefix)
 		prefix_len = strlen(prefix);
@@ -688,6 +688,6 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		return bad ? 1 : 0;
 	}
 
-	UNLEAK(dir);
+	dir_free(&dir);
 	return 0;
 }
diff --git a/builtin/stash.c b/builtin/stash.c
index da48533d49..85b646b7ad 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -864,7 +864,7 @@ static int get_untracked_files(const struct pathspec *ps, int include_untracked,
 	int found = 0;
 	struct dir_struct dir;
 
-	memset(&dir, 0, sizeof(dir));
+	dir_init(&dir);
 	if (include_untracked != INCLUDE_ALL_FILES)
 		setup_standard_excludes(&dir);
 
@@ -877,7 +877,7 @@ static int get_untracked_files(const struct pathspec *ps, int include_untracked,
 		strbuf_addch(untracked_files, '\0');
 	}
 
-	clear_directory(&dir);
+	dir_free(&dir);
 	return found;
 }
 
diff --git a/dir.c b/dir.c
index b136c037d9..e3c8e7ffd6 100644
--- a/dir.c
+++ b/dir.c
@@ -54,6 +54,11 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 static int resolve_dtype(int dtype, struct index_state *istate,
 			 const char *path, int len);
 
+void dir_init(struct dir_struct *dir)
+{
+	memset(dir, 0, sizeof(*dir));
+}
+
 int count_slashes(const char *s)
 {
 	int cnt = 0;
@@ -3013,7 +3018,7 @@ int remove_path(const char *name)
 }
 
 /* Frees memory within dir which was allocated.  Does not free dir itself. */
-void clear_directory(struct dir_struct *dir)
+void dir_free(struct dir_struct *dir)
 {
 	int i, j;
 	struct exclude_list_group *group;
diff --git a/dir.h b/dir.h
index 7d76d0644f..7c55c1a460 100644
--- a/dir.h
+++ b/dir.h
@@ -19,22 +19,21 @@
  * CE_SKIP_WORKTREE marked. If you want to exclude files, make sure you have
  * loaded the index first.
  *
- * - Prepare `struct dir_struct dir` and clear it with `memset(&dir, 0,
- * sizeof(dir))`.
+ * - Prepare `struct dir_struct dir` using `dir_init()` function.
  *
  * - To add single exclude pattern, call `add_pattern_list()` and then
  *   `add_pattern()`.
  *
  * - To add patterns from a file (e.g. `.git/info/exclude`), call
- *   `add_patterns_from_file()` , and/or set `dir.exclude_per_dir`.  A
- *   short-hand function `setup_standard_excludes()` can be used to set
- *   up the standard set of exclude settings.
+ *   `add_patterns_from_file()` , and/or set `dir.exclude_per_dir`.
  *
- * - Set options described in the Data Structure section above.
+ * - A short-hand function `setup_standard_excludes()` can be used to set
+ *   up the standard set of exclude settings, instead of manually calling
+ *   the add_pattern*() family of functions.
  *
- * - Call `read_directory()`.
+ * - Call `fill_directory()`.
  *
- * - Use `dir.entries[]`.
+ * - Use `dir.entries[]` and `dir.ignored[]`.
  *
  * - Call `clear_directory()` when the contained elements are no longer in use.
  *
@@ -362,6 +361,8 @@ int match_pathspec(const struct index_state *istate,
 int report_path_error(const char *ps_matched, const struct pathspec *pathspec);
 int within_depth(const char *name, int namelen, int depth, int max_depth);
 
+void dir_init(struct dir_struct *dir);
+
 int fill_directory(struct dir_struct *dir,
 		   struct index_state *istate,
 		   const struct pathspec *pathspec);
@@ -428,7 +429,7 @@ void parse_path_pattern(const char **string, int *patternlen, unsigned *flags, i
 void add_pattern(const char *string, const char *base,
 		 int baselen, struct pattern_list *pl, int srcpos);
 void clear_pattern_list(struct pattern_list *pl);
-void clear_directory(struct dir_struct *dir);
+void dir_free(struct dir_struct *dir);
 
 int repo_file_exists(struct repository *repo, const char *path);
 int file_exists(const char *);
diff --git a/merge.c b/merge.c
index 753e461659..ee149b87ea 100644
--- a/merge.c
+++ b/merge.c
@@ -80,8 +80,8 @@ int checkout_fast_forward(struct repository *r,
 	}
 
 	memset(&opts, 0, sizeof(opts));
+	dir_init(&dir);
 	if (overwrite_ignore) {
-		memset(&dir, 0, sizeof(dir));
 		dir.flags |= DIR_SHOW_IGNORED;
 		setup_standard_excludes(&dir);
 		opts.dir = &dir;
@@ -102,6 +102,7 @@ int checkout_fast_forward(struct repository *r,
 		clear_unpack_trees_porcelain(&opts);
 		return -1;
 	}
+	dir_free(&dir);
 	clear_unpack_trees_porcelain(&opts);
 
 	if (write_locked_index(r->index, &lock_file, COMMIT_LOCK))
diff --git a/wt-status.c b/wt-status.c
index c00ea3e06a..5624a8ff7f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -703,7 +703,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 	if (!s->show_untracked_files)
 		return;
 
-	memset(&dir, 0, sizeof(dir));
+	dir_init(&dir);
 	if (s->show_untracked_files != SHOW_ALL_UNTRACKED_FILES)
 		dir.flags |=
 			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
@@ -732,7 +732,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 			string_list_insert(&s->ignored, ent->name);
 	}
 
-	clear_directory(&dir);
+	dir_free(&dir);
 
 	if (advice_status_u_option)
 		s->untracked_in_ms = (getnanotime() - t_begin) / 1000000;
-- 
gitgitgadget
