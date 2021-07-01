Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B39C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 10:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B2206147D
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 10:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbhGAKyJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 06:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbhGAKyI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 06:54:08 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94463C0617AD
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 03:51:37 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r3so4202789wmq.1
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 03:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J62VD9CK7RpAgptmkAbcgEVIp9kjtSSQNRCoxzVMxBI=;
        b=MZMzre5IXF8TsGOVCyGtGNjMsYxkn3ODoArxJtme2k6piKMJxp13WD9pdZAJ458eRJ
         hLA3AkdrAuFbMf3x4fmUjm+diSHnnFlxHAdqJOBLBtwo6NlQ3gFr6o+iFn2BRKEcQici
         7DgKIA5qJUsX5eNMWeIcFiELxOS5MQfCkpI4wWGX2wjLjTQHXVEEBPiRjVUdtQp+u2Jx
         jRA0cpR0BmDIlbI+m/0cAK4hzkl/HOwPGwrV5R6j34WeeKLCsU0uE/vQxoheNjSwuDWH
         wIMuOxwtogjskoThJBLONXmjAg8ZsNx2nfeDgirOoVEjjhsRTENfpgJXwBbVaNqJOBN1
         1kGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J62VD9CK7RpAgptmkAbcgEVIp9kjtSSQNRCoxzVMxBI=;
        b=ooJfcrUadjXXv1kJRCHQUkPlTWX1HVqhYgJq8nsMGkpwRkXDgadhGemCrhTobz1ize
         yhU653c8BPevisNvBTdbQfatW2NjyXnRKWupU/hSNjuKGZIZ97LhLI+nkkcl43GAEcbc
         CFO87KaCF+DEqKJKLJD7x8Yg6Q/zNGD+Ffp/pYw2ef0jzyTQjgZGIZrYJ24npf0lYeOW
         kpXop25VjD7HpOY2j17gMtIw/3+3Of+hyxjFUs6/MwGAycYRWdv/17s7XCOn7Ni/O0r8
         5qf6bDLNe9rb/jsBsuSJof3UWZpdshzGCNTVgAnMJLGH0WCG1f6Sg8SL9m5BoSZlbkGL
         M1Ww==
X-Gm-Message-State: AOAM53385KBOv58XKj3ppD18lj1xgKXM2aK/yfw6sJ71jS32vKBw5/4E
        2BEDOckjs3fc8LvSNywYuFxLw9BPYZ2uMg==
X-Google-Smtp-Source: ABdhPJwDh5/dAnNlAz2SZUhEzmuDZOL7ovfEY5XGQ0pa9Eju/CIJUIEWxKcJe9CHqd1xLugxQ1BkVQ==
X-Received: by 2002:a05:600c:4f87:: with SMTP id n7mr44335656wmq.9.1625136695951;
        Thu, 01 Jul 2021 03:51:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p9sm8015699wmm.17.2021.07.01.03.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 03:51:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] dir.[ch]: replace dir_init() with DIR_INIT
Date:   Thu,  1 Jul 2021 12:51:27 +0200
Message-Id: <patch-3.5-5f776976b81-20210701T104855Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.632.g11c1df94a06
In-Reply-To: <cover-0.5-00000000000-20210701T104855Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210701T104855Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the dir_init() function and replace it with a DIR_INIT
macro. In many cases in the codebase we need to initialize things with
a function for good reasons, e.g. needing to call another function on
initialization. The "dir_init()" function was not one such case, and
could trivially be replaced with a more idiomatic macro initialization
pattern.

The only place where we made use of its use of memset() was in
dir_clear() itself, which resets the contents of an an existing struct
pointer. Let's use the new "memcpy() a 'blank' struct on the stack"
idiom to do that reset.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/add.c          | 3 +--
 builtin/check-ignore.c | 3 +--
 builtin/clean.c        | 6 ++----
 builtin/grep.c         | 3 +--
 builtin/ls-files.c     | 3 +--
 builtin/stash.c        | 3 +--
 dir.c                  | 9 ++-------
 dir.h                  | 4 ++--
 merge.c                | 3 +--
 wt-status.c            | 3 +--
 10 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index b773b5a4993..09e684585d9 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -470,7 +470,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 {
 	int exit_status = 0;
 	struct pathspec pathspec;
-	struct dir_struct dir;
+	struct dir_struct dir = DIR_INIT;
 	int flags;
 	int add_new_files;
 	int require_pathspec;
@@ -577,7 +577,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	die_in_unpopulated_submodule(&the_index, prefix);
 	die_path_inside_submodule(&the_index, &pathspec);
 
-	dir_init(&dir);
 	if (add_new_files) {
 		int baselen;
 
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 81234552b7f..21912569650 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -153,7 +153,7 @@ static int check_ignore_stdin_paths(struct dir_struct *dir, const char *prefix)
 int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 {
 	int num_ignored;
-	struct dir_struct dir;
+	struct dir_struct dir = DIR_INIT;
 
 	git_config(git_default_config, NULL);
 
@@ -182,7 +182,6 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 	if (!no_index && read_cache() < 0)
 		die(_("index file corrupt"));
 
-	dir_init(&dir);
 	setup_standard_excludes(&dir);
 
 	if (stdin_paths) {
diff --git a/builtin/clean.c b/builtin/clean.c
index 4944cf440b4..98a2860409b 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -641,7 +641,7 @@ static int clean_cmd(void)
 
 static int filter_by_patterns_cmd(void)
 {
-	struct dir_struct dir;
+	struct dir_struct dir = DIR_INIT;
 	struct strbuf confirm = STRBUF_INIT;
 	struct strbuf **ignore_list;
 	struct string_list_item *item;
@@ -665,7 +665,6 @@ static int filter_by_patterns_cmd(void)
 		if (!confirm.len)
 			break;
 
-		dir_init(&dir);
 		pl = add_pattern_list(&dir, EXC_CMDL, "manual exclude");
 		ignore_list = strbuf_split_max(&confirm, ' ', 0);
 
@@ -890,7 +889,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	int ignored_only = 0, config_set = 0, errors = 0, gone = 1;
 	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
 	struct strbuf abs_path = STRBUF_INIT;
-	struct dir_struct dir;
+	struct dir_struct dir = DIR_INIT;
 	struct pathspec pathspec;
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
@@ -921,7 +920,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, builtin_clean_usage,
 			     0);
 
-	dir_init(&dir);
 	if (!interactive && !dry_run && !force) {
 		if (config_set)
 			die(_("clean.requireForce set to true and neither -i, -n, nor -f given; "
diff --git a/builtin/grep.c b/builtin/grep.c
index ab8822e68f4..7d2f8e5adb6 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -704,10 +704,9 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
 			  int exc_std, int use_index)
 {
-	struct dir_struct dir;
+	struct dir_struct dir = DIR_INIT;
 	int i, hit = 0;
 
-	dir_init(&dir);
 	if (!use_index)
 		dir.flags |= DIR_NO_GITLINKS;
 	if (exc_std)
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 45cc3b23dd6..29a26ad8ae4 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -608,7 +608,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 {
 	int require_work_tree = 0, show_tag = 0, i;
 	char *max_prefix;
-	struct dir_struct dir;
+	struct dir_struct dir = DIR_INIT;
 	struct pattern_list *pl;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
 	struct option builtin_ls_files_options[] = {
@@ -678,7 +678,6 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(ls_files_usage, builtin_ls_files_options);
 
-	dir_init(&dir);
 	prefix = cmd_prefix;
 	if (prefix)
 		prefix_len = strlen(prefix);
diff --git a/builtin/stash.c b/builtin/stash.c
index 9c72e4b1257..8f42360ca91 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -991,9 +991,8 @@ static int get_untracked_files(const struct pathspec *ps, int include_untracked,
 {
 	int i;
 	int found = 0;
-	struct dir_struct dir;
+	struct dir_struct dir = DIR_INIT;
 
-	dir_init(&dir);
 	if (include_untracked != INCLUDE_ALL_FILES)
 		setup_standard_excludes(&dir);
 
diff --git a/dir.c b/dir.c
index ebe5ec046e0..313e9324597 100644
--- a/dir.c
+++ b/dir.c
@@ -53,12 +53,6 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	int check_only, int stop_at_first_file, const struct pathspec *pathspec);
 static int resolve_dtype(int dtype, struct index_state *istate,
 			 const char *path, int len);
-
-void dir_init(struct dir_struct *dir)
-{
-	memset(dir, 0, sizeof(*dir));
-}
-
 struct dirent *readdir_skip_dot_and_dotdot(DIR *dirp)
 {
 	struct dirent *e;
@@ -3105,6 +3099,7 @@ void dir_clear(struct dir_struct *dir)
 	struct exclude_list_group *group;
 	struct pattern_list *pl;
 	struct exclude_stack *stk;
+	struct dir_struct new = DIR_INIT;
 
 	for (i = EXC_CMDL; i <= EXC_FILE; i++) {
 		group = &dir->exclude_list_group[i];
@@ -3132,7 +3127,7 @@ void dir_clear(struct dir_struct *dir)
 	}
 	strbuf_release(&dir->basebuf);
 
-	dir_init(dir);
+	memcpy(dir, &new, sizeof(*dir));
 }
 
 struct ondisk_untracked_cache {
diff --git a/dir.h b/dir.h
index e3db9b9ec65..8d0ddd8f18d 100644
--- a/dir.h
+++ b/dir.h
@@ -342,6 +342,8 @@ struct dir_struct {
 	unsigned visited_directories;
 };
 
+#define DIR_INIT { 0 }
+
 struct dirent *readdir_skip_dot_and_dotdot(DIR *dirp);
 
 /*Count the number of slashes for string s*/
@@ -367,8 +369,6 @@ int match_pathspec(struct index_state *istate,
 int report_path_error(const char *ps_matched, const struct pathspec *pathspec);
 int within_depth(const char *name, int namelen, int depth, int max_depth);
 
-void dir_init(struct dir_struct *dir);
-
 int fill_directory(struct dir_struct *dir,
 		   struct index_state *istate,
 		   const struct pathspec *pathspec);
diff --git a/merge.c b/merge.c
index 5fb88af1025..6e736881d90 100644
--- a/merge.c
+++ b/merge.c
@@ -53,7 +53,7 @@ int checkout_fast_forward(struct repository *r,
 	struct unpack_trees_options opts;
 	struct tree_desc t[MAX_UNPACK_TREES];
 	int i, nr_trees = 0;
-	struct dir_struct dir;
+	struct dir_struct dir = DIR_INIT;
 	struct lock_file lock_file = LOCK_INIT;
 
 	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
@@ -80,7 +80,6 @@ int checkout_fast_forward(struct repository *r,
 	}
 
 	memset(&opts, 0, sizeof(opts));
-	dir_init(&dir);
 	if (overwrite_ignore) {
 		dir.flags |= DIR_SHOW_IGNORED;
 		setup_standard_excludes(&dir);
diff --git a/wt-status.c b/wt-status.c
index 42b67357169..b5a3e1cc252 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -699,14 +699,13 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 static void wt_status_collect_untracked(struct wt_status *s)
 {
 	int i;
-	struct dir_struct dir;
+	struct dir_struct dir = DIR_INIT;
 	uint64_t t_begin = getnanotime();
 	struct index_state *istate = s->repo->index;
 
 	if (!s->show_untracked_files)
 		return;
 
-	dir_init(&dir);
 	if (s->show_untracked_files != SHOW_ALL_UNTRACKED_FILES)
 		dir.flags |=
 			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
-- 
2.32.0.623.ge833f40cd87

