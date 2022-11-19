Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3D0C433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 13:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbiKSNI3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 08:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbiKSNI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 08:08:26 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8593D93CE1
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:58 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id l11so10605008edb.4
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xur1b1eNofBFc/W+qb7oxP6Hk1pCrKX6vnecY4HOhEQ=;
        b=j18T7mQ+2CjBnRy0Himl10WHgYJTY/kTyocFZY9mstHA9HGwEsfG4qH4VA+mK83F1E
         XG8vS9ggvv3m4iUSZO1UuOBwi71cTP+NH3wvTNzMaof/WVml5LQtauKlk3s+ZEKg0VP/
         VOdEsvlg+OVONxCOgm3p4gh0Ic09Qjd7qjiuKF89UScYvjqAquIEEeWhb1bwfXxkXh+8
         Ei9poOWhu/eRhh2tnDDJbogkTcDsx3f86sXGHIVE5ixlIFm1FeXC6zutw5U0GgsL4LGa
         c7rEowjexv+aYUcK4NpDBJN8V4L6FdiKMVeETbo+xaEGDi0DTJm2SnMAhela/NAUJr1u
         OEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xur1b1eNofBFc/W+qb7oxP6Hk1pCrKX6vnecY4HOhEQ=;
        b=TOtT9uSR1FVmpXy0neSSYy6fZIYBQfT+qiUKxrE0K1n7u8jRmg5rHJMLGKT84ZeKEf
         ZcMJ8D+5AcHDcFO9oH9k68BjWuK20POcr8w7oQ+Dm9w2FZL0rGlJjptDu6EgqBaoj8v3
         nV4YwyjLEFmA/R9ENGxve8E9yTlwjZ4d5S8LkXeUScIFksc5myDz0GrshpIQjVqReXJf
         P/oIwLfGWtuBSVI9Tw7xpjtRepswz/Vm9CpznrA92TaBZH1QJ2bV9KJVpnV5TZZ2/6Ys
         fvVp+i5lLsnBpx5jsTiMoHPwI3MQnENBbNj0oJE6ETPLsrdNueq7GrywNlYy+bEk3sa8
         tOzA==
X-Gm-Message-State: ANoB5pl+dCnAbtFP3qEbtLpdY0q7uIgwe1JyzPzA0KQmjBRi33YB2qcR
        GxL4870xL/12C7g9jS2HcOy6yrQN6v0mpg==
X-Google-Smtp-Source: AA0mqf44Z1zz+8y1NYwkb5Z9unfCqFDvQ6PVzcFbj9JevocxdTz5JXWxDPewral/rTdpZK+G0Z4CXg==
X-Received: by 2002:a05:6402:915:b0:467:d741:f359 with SMTP id g21-20020a056402091500b00467d741f359mr9861691edz.100.1668863277112;
        Sat, 19 Nov 2022 05:07:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ch28-20020a0564021bdc00b0045d74aa401fsm2923802edb.60.2022.11.19.05.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 05:07:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/11] cocci: apply "pending" index-compatibility to some "builtin/*.c"
Date:   Sat, 19 Nov 2022 14:07:38 +0100
Message-Id: <patch-v2-11.11-b645cec189e-20221119T125551Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1509.g9445af83948
In-Reply-To: <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply "index-compatibility.pending.cocci" rule to "builtin/*", but
exclude those where we conflict with in-flight changes.

As a result some of them end up using only "the_index", so let's have
them use the more narrow "USE_THE_INDEX_VARIABLE" rather than
"USE_THE_INDEX_COMPATIBILITY_MACROS".

Manual changes not made by coccinelle, that were squashed in:

* Whitespace-wrap argument lists for repo_hold_locked_index(),
  repo_read_index_preload() and repo_refresh_and_write_index(), in cases
  where the line became too long after the transformation.
* Change "refresh_cache()" to "refresh_index()" in a comment in
  "builtin/update-index.c".
* For those whose call was followed by perror("<macro-name>"), change
  it to perror("<function-name>"), referring to the new function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/add.c                                 |  8 +--
 builtin/am.c                                  | 21 ++++----
 builtin/check-attr.c                          |  4 +-
 builtin/check-ignore.c                        |  4 +-
 builtin/checkout-index.c                      |  9 ++--
 builtin/checkout.c                            | 12 ++---
 builtin/clean.c                               |  4 +-
 builtin/clone.c                               |  4 +-
 builtin/commit.c                              | 40 +++++++-------
 builtin/describe.c                            |  7 +--
 builtin/diff-files.c                          |  5 +-
 builtin/diff-index.c                          |  9 ++--
 builtin/diff-tree.c                           |  4 +-
 builtin/diff.c                                | 25 +++++----
 builtin/fsck.c                                |  4 +-
 builtin/merge-index.c                         |  6 +--
 builtin/merge-ours.c                          |  3 +-
 builtin/merge.c                               | 19 ++++---
 builtin/mv.c                                  | 16 +++---
 builtin/read-tree.c                           |  4 +-
 builtin/rebase.c                              |  6 +--
 builtin/reset.c                               |  9 ++--
 builtin/rev-parse.c                           |  4 +-
 builtin/rm.c                                  |  8 +--
 builtin/stash.c                               | 35 ++++++------
 builtin/submodule--helper.c                   | 14 ++---
 builtin/update-index.c                        | 19 +++----
 cache.h                                       |  5 --
 contrib/coccinelle/index-compatibility.cocci  | 53 ++++++++++++++++++
 .../index-compatibility.pending.cocci         | 54 -------------------
 30 files changed, 213 insertions(+), 202 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 23f9f0e08bb..76277df326b 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2006 Linus Torvalds
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
@@ -312,7 +312,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 
-	if (read_cache() < 0)
+	if (repo_read_index(the_repository) < 0)
 		die(_("Could not read the index"));
 
 	repo_init_revisions(the_repository, &rev, prefix);
@@ -544,7 +544,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
 
 	/*
 	 * Check the "pathspec '%s' did not match any files" block
@@ -587,7 +587,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		 (!(addremove || take_worktree_changes)
 		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
 
-	if (read_cache_preload(&pathspec) < 0)
+	if (repo_read_index_preload(the_repository, &pathspec, 0) < 0)
 		die(_("index file corrupt"));
 
 	die_in_unpopulated_submodule(&the_index, prefix);
diff --git a/builtin/am.c b/builtin/am.c
index f362a1c29fd..30c9b3a9cd7 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1519,8 +1519,8 @@ static int run_apply(const struct am_state *state, const char *index_file)
 
 	if (index_file) {
 		/* Reload index as apply_all_patches() will have modified it. */
-		discard_cache();
-		read_cache_from(index_file);
+		discard_index(&the_index);
+		read_index_from(&the_index, index_file, get_git_dir());
 	}
 
 	return 0;
@@ -1562,8 +1562,8 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	if (build_fake_ancestor(state, index_path))
 		return error("could not build fake ancestor");
 
-	discard_cache();
-	read_cache_from(index_path);
+	discard_index(&the_index);
+	read_index_from(&the_index, index_path, get_git_dir());
 
 	if (write_index_as_tree(&orig_tree, &the_index, index_path, 0, NULL))
 		return error(_("Repository lacks necessary blobs to fall back on 3-way merge."));
@@ -1596,8 +1596,8 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 
 	say(state, stdout, _("Falling back to patching base and 3-way merge..."));
 
-	discard_cache();
-	read_cache();
+	discard_index(&the_index);
+	repo_read_index(the_repository);
 
 	/*
 	 * This is not so wrong. Depending on which base we picked, orig_tree
@@ -1781,7 +1781,8 @@ static void am_run(struct am_state *state, int resume)
 
 	unlink(am_path(state, "dirtyindex"));
 
-	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0) < 0)
+	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
+					 NULL, NULL, NULL) < 0)
 		die(_("unable to write index file"));
 
 	if (repo_index_has_changes(the_repository, NULL, &sb)) {
@@ -1967,9 +1968,9 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 	if (parse_tree(head) || parse_tree(remote))
 		return -1;
 
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
 
-	refresh_cache(REFRESH_QUIET);
+	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
 
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
@@ -2007,7 +2008,7 @@ static int merge_tree(struct tree *tree)
 	if (parse_tree(tree))
 		return -1;
 
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
 
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index dd833977864..0fef10eb6bc 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -1,4 +1,4 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
@@ -115,7 +115,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, check_attr_options,
 			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
 
-	if (read_cache() < 0) {
+	if (repo_read_index(the_repository) < 0) {
 		die("invalid cache");
 	}
 
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 21912569650..ab776061c7c 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -1,4 +1,4 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
@@ -179,7 +179,7 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 		die(_("--non-matching is only valid with --verbose"));
 
 	/* read_cache() is only necessary so we can watch out for submodules. */
-	if (!no_index && read_cache() < 0)
+	if (!no_index && repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
 
 	setup_standard_excludes(&dir);
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index c2aee450c40..cf6fba97ba7 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2005 Linus Torvalds
  *
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "dir.h"
@@ -65,7 +65,7 @@ static void write_tempfile_record(const char *name, const char *prefix)
 static int checkout_file(const char *name, const char *prefix)
 {
 	int namelen = strlen(name);
-	int pos = cache_name_pos(name, namelen);
+	int pos = index_name_pos(&the_index, name, namelen);
 	int has_same_name = 0;
 	int is_file = 0;
 	int is_skipped = 1;
@@ -249,7 +249,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
-	if (read_cache() < 0) {
+	if (repo_read_index(the_repository) < 0) {
 		die("invalid cache");
 	}
 
@@ -270,7 +270,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	if (index_opt && !state.base_dir_len && !to_tempfile) {
 		state.refresh_cache = 1;
 		state.istate = &the_index;
-		hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+		repo_hold_locked_index(the_repository, &lock_file,
+				       LOCK_DIE_ON_ERROR);
 	}
 
 	get_parallel_checkout_configs(&pc_workers, &pc_threshold);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3fd303f5604..3fa29a08eea 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1,4 +1,4 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "advice.h"
 #include "blob.h"
@@ -148,7 +148,7 @@ static int update_some(const struct object_id *oid, struct strbuf *base,
 	 * entry in place. Whether it is UPTODATE or not, checkout_entry will
 	 * do the right thing.
 	 */
-	pos = cache_name_pos(ce->name, ce->ce_namelen);
+	pos = index_name_pos(&the_index, ce->name, ce->ce_namelen);
 	if (pos >= 0) {
 		struct cache_entry *old = the_index.cache[pos];
 		if (ce->ce_mode == old->ce_mode &&
@@ -529,7 +529,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	}
 
 	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
-	if (read_cache_preload(&opts->pathspec) < 0)
+	if (repo_read_index_preload(the_repository, &opts->pathspec, 0) < 0)
 		return error(_("index file corrupt"));
 
 	if (opts->source_tree)
@@ -741,8 +741,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	struct lock_file lock_file = LOCK_INIT;
 	struct tree *new_tree;
 
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
-	if (read_cache_preload(NULL) < 0)
+	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
+	if (repo_read_index_preload(the_repository, NULL, 0) < 0)
 		return error(_("index file corrupt"));
 
 	resolve_undo_clear_index(&the_index);
@@ -762,7 +762,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		struct unpack_trees_options topts;
 		const struct object_id *old_commit_oid;
 
-		refresh_cache(REFRESH_QUIET);
+		refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
 
 		if (unmerged_index(&the_index)) {
 			error(_("you need to resolve your current index first"));
diff --git a/builtin/clean.c b/builtin/clean.c
index 7084e685f6f..b2701a28158 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -6,7 +6,7 @@
  * Based on git-clean.sh by Pavel Roskin
  */
 
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
@@ -1012,7 +1012,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
-	if (read_cache() < 0)
+	if (repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
 
 	pl = add_pattern_list(&dir, EXC_CMDL, "--exclude option");
diff --git a/builtin/clone.c b/builtin/clone.c
index 0e4348686b6..f518bb2dc1f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -8,7 +8,7 @@
  * Clone a repository into a different directory that does not yet exist.
  */
 
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "lockfile.h"
@@ -703,7 +703,7 @@ static int checkout(int submodule_progress, int filter_submodules)
 	/* We need to be in the new work tree for the checkout */
 	setup_work_tree();
 
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
 
 	memset(&opts, 0, sizeof opts);
 	opts.update = 1;
diff --git a/builtin/commit.c b/builtin/commit.c
index abbed750276..06b1330346f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -316,7 +316,7 @@ static void create_base_index(const struct commit *current_head)
 	struct tree_desc t;
 
 	if (!current_head) {
-		discard_cache();
+		discard_index(&the_index);
 		return;
 	}
 
@@ -343,7 +343,7 @@ static void refresh_cache_or_die(int refresh_flags)
 	 * refresh_flags contains REFRESH_QUIET, so the only errors
 	 * are for unmerged entries.
 	 */
-	if (refresh_cache(refresh_flags | REFRESH_IN_PORCELAIN))
+	if (refresh_index(&the_index, refresh_flags | REFRESH_IN_PORCELAIN, NULL, NULL, NULL))
 		die_resolve_conflict("commit");
 }
 
@@ -382,12 +382,13 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	    (!amend || (fixup_message && strcmp(fixup_prefix, "amend"))))))
 		die(_("No paths with --include/--only does not make sense."));
 
-	if (read_cache_preload(&pathspec) < 0)
+	if (repo_read_index_preload(the_repository, &pathspec, 0) < 0)
 		die(_("index file corrupt"));
 
 	if (interactive) {
 		char *old_index_env = NULL, *old_repo_index_file;
-		hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
+		repo_hold_locked_index(the_repository, &index_lock,
+				       LOCK_DIE_ON_ERROR);
 
 		refresh_cache_or_die(refresh_flags);
 
@@ -410,8 +411,9 @@ static const char *prepare_index(const char **argv, const char *prefix,
 			unsetenv(INDEX_ENVIRONMENT);
 		FREE_AND_NULL(old_index_env);
 
-		discard_cache();
-		read_cache_from(get_lock_file_path(&index_lock));
+		discard_index(&the_index);
+		read_index_from(&the_index, get_lock_file_path(&index_lock),
+				get_git_dir());
 		if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
 			if (reopen_lock_file(&index_lock) < 0)
 				die(_("unable to write index file"));
@@ -438,7 +440,8 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	 * (B) on failure, rollback the real index.
 	 */
 	if (all || (also && pathspec.nr)) {
-		hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
+		repo_hold_locked_index(the_repository, &index_lock,
+				       LOCK_DIE_ON_ERROR);
 		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
@@ -459,7 +462,8 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	 * We still need to refresh the index here.
 	 */
 	if (!only && !pathspec.nr) {
-		hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
+		repo_hold_locked_index(the_repository, &index_lock,
+				       LOCK_DIE_ON_ERROR);
 		refresh_cache_or_die(refresh_flags);
 		if (the_index.cache_changed
 		    || !cache_tree_fully_valid(the_index.cache_tree))
@@ -505,13 +509,13 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
 		exit(1);
 
-	discard_cache();
-	if (read_cache() < 0)
+	discard_index(&the_index);
+	if (repo_read_index(the_repository) < 0)
 		die(_("cannot read the index"));
 
-	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(the_repository, &index_lock, LOCK_DIE_ON_ERROR);
 	add_remove_files(&partial);
-	refresh_cache(REFRESH_QUIET);
+	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
 	update_main_cache_tree(WRITE_TREE_SILENT);
 	if (write_locked_index(&the_index, &index_lock, 0))
 		die(_("unable to write new_index file"));
@@ -523,14 +527,14 @@ static const char *prepare_index(const char **argv, const char *prefix,
 
 	create_base_index(current_head);
 	add_remove_files(&partial);
-	refresh_cache(REFRESH_QUIET);
+	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
 
 	if (write_locked_index(&the_index, &false_lock, 0))
 		die(_("unable to write temporary index file"));
 
-	discard_cache();
+	discard_index(&the_index);
 	ret = get_lock_file_path(&false_lock);
-	read_cache_from(ret);
+	read_index_from(&the_index, ret, get_git_dir());
 out:
 	string_list_clear(&partial, 0);
 	clear_pathspec(&pathspec);
@@ -1068,9 +1072,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		 * and could have updated it. We must do this before we invoke
 		 * the editor and after we invoke run_status above.
 		 */
-		discard_cache();
+		discard_index(&the_index);
 	}
-	read_cache_from(index_file);
+	read_index_from(&the_index, index_file, get_git_dir());
 
 	if (update_main_cache_tree(0)) {
 		error(_("Error building trees"));
@@ -1556,7 +1560,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		      &s.pathspec, NULL, NULL);
 
 	if (use_optional_locks())
-		fd = hold_locked_index(&index_lock, 0);
+		fd = repo_hold_locked_index(the_repository, &index_lock, 0);
 	else
 		fd = -1;
 
diff --git a/builtin/describe.c b/builtin/describe.c
index 23e3f05fb10..eea1e330c00 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -1,4 +1,4 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "config.h"
 #include "lockfile.h"
@@ -653,10 +653,11 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			int fd, result;
 
 			setup_work_tree();
-			read_cache();
+			repo_read_index(the_repository);
 			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
 				      NULL, NULL, NULL);
-			fd = hold_locked_index(&index_lock, 0);
+			fd = repo_hold_locked_index(the_repository,
+						    &index_lock, 0);
 			if (0 <= fd)
 				repo_update_index_if_able(the_repository, &index_lock);
 
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 096ea2fedbc..dc991f753bb 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -3,7 +3,6 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "diff.h"
@@ -76,8 +75,8 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	    (rev.diffopt.output_format & DIFF_FORMAT_PATCH))
 		diff_merges_set_dense_combined_if_unset(&rev);
 
-	if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
-		perror("read_cache_preload");
+	if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0) {
+		perror("repo_read_index_preload");
 		result = -1;
 		goto cleanup;
 	}
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index aea139b9d8f..35dc9b23eef 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "diff.h"
@@ -62,12 +61,12 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		usage(diff_cache_usage);
 	if (!(option & DIFF_INDEX_CACHED)) {
 		setup_work_tree();
-		if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
-			perror("read_cache_preload");
+		if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0) {
+			perror("repo_read_index_preload");
 			return -1;
 		}
-	} else if (read_cache() < 0) {
-		perror("read_cache");
+	} else if (repo_read_index(the_repository) < 0) {
+		perror("repo_read_index");
 		return -1;
 	}
 	result = run_diff_index(&rev, option);
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 85e8c81e594..25b853b85ca 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -1,4 +1,4 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "config.h"
 #include "diff.h"
@@ -120,7 +120,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	repo_init_revisions(the_repository, opt, prefix);
-	if (read_cache() < 0)
+	if (repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
 	opt->abbrev = 0;
 	opt->diff = 1;
diff --git a/builtin/diff.c b/builtin/diff.c
index 854d2c5a5c4..163f2c6a874 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2006 Junio C Hamano
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "config.h"
 #include "ewah/ewok.h"
@@ -157,12 +157,13 @@ static int builtin_diff_index(struct rev_info *revs,
 		usage(builtin_diff_usage);
 	if (!(option & DIFF_INDEX_CACHED)) {
 		setup_work_tree();
-		if (read_cache_preload(&revs->diffopt.pathspec) < 0) {
-			perror("read_cache_preload");
+		if (repo_read_index_preload(the_repository,
+					    &revs->diffopt.pathspec, 0) < 0) {
+			perror("repo_read_index_preload");
 			return -1;
 		}
-	} else if (read_cache() < 0) {
-		perror("read_cache");
+	} else if (repo_read_index(the_repository) < 0) {
+		perror("repo_read_cache");
 		return -1;
 	}
 	return run_diff_index(revs, option);
@@ -239,12 +240,13 @@ static void refresh_index_quietly(void)
 	struct lock_file lock_file = LOCK_INIT;
 	int fd;
 
-	fd = hold_locked_index(&lock_file, 0);
+	fd = repo_hold_locked_index(the_repository, &lock_file, 0);
 	if (fd < 0)
 		return;
-	discard_cache();
-	read_cache();
-	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
+	discard_index(&the_index);
+	repo_read_index(the_repository);
+	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL,
+		      NULL);
 	repo_update_index_if_able(the_repository, &lock_file);
 }
 
@@ -279,8 +281,9 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
 		diff_merges_set_dense_combined_if_unset(revs);
 
 	setup_work_tree();
-	if (read_cache_preload(&revs->diffopt.pathspec) < 0) {
-		perror("read_cache_preload");
+	if (repo_read_index_preload(the_repository, &revs->diffopt.pathspec,
+				    0) < 0) {
+		perror("repo_read_index_preload");
 		return -1;
 	}
 	return run_diff_files(revs, options);
diff --git a/builtin/fsck.c b/builtin/fsck.c
index cd47675e371..d207bd909b4 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1,4 +1,4 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "cache.h"
 #include "repository.h"
@@ -958,7 +958,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	if (keep_cache_objects) {
 		verify_index_checksum = 1;
 		verify_ce_order = 1;
-		read_cache();
+		repo_read_index(the_repository);
 		/* TODO: audit for interaction with sparse-index. */
 		ensure_full_index(&the_index);
 		for (i = 0; i < the_index.cache_nr; i++) {
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index a334c513c9d..452f833ac46 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,4 +1,4 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "run-command.h"
 
@@ -47,7 +47,7 @@ static int merge_entry(int pos, const char *path)
 
 static void merge_one_path(const char *path)
 {
-	int pos = cache_name_pos(path, strlen(path));
+	int pos = index_name_pos(&the_index, path, strlen(path));
 
 	/*
 	 * If it already exists in the cache as stage0, it's
@@ -82,7 +82,7 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	if (argc < 3)
 		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] [<filename>...])");
 
-	read_cache();
+	repo_read_index(the_repository);
 
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(&the_index);
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 3583cff71c7..284eb486098 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -7,7 +7,6 @@
  *
  * Pretend we resolved the heads, but declare our tree trumps everybody else.
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "git-compat-util.h"
 #include "builtin.h"
 #include "diff.h"
@@ -25,7 +24,7 @@ int cmd_merge_ours(int argc, const char **argv, const char *prefix)
 	 * commit.  The index must match HEAD, or this merge cannot go
 	 * through.
 	 */
-	if (read_cache() < 0)
+	if (repo_read_index(the_repository) < 0)
 		die_errno("read_cache failed");
 	if (index_differs_from(the_repository, "HEAD", NULL, 0))
 		return 2;
diff --git a/builtin/merge.c b/builtin/merge.c
index 27218ee93c9..dd474371a25 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -318,7 +318,7 @@ static int save_state(struct object_id *stash)
 	int rc = -1;
 
 	fd = repo_hold_locked_index(the_repository, &lock_file, 0);
-	refresh_cache(REFRESH_QUIET);
+	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
 	if (0 <= fd)
 		repo_update_index_if_able(the_repository, &lock_file);
 	rollback_lock_file(&lock_file);
@@ -716,7 +716,9 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 {
 	const char *head_arg = "HEAD";
 
-	if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED, 0) < 0)
+	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET,
+					 SKIP_IF_UNCHANGED, 0, NULL, NULL,
+					 NULL) < 0)
 		return error(_("Unable to write index."));
 
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree") ||
@@ -750,7 +752,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		for (j = common; j; j = j->next)
 			commit_list_insert(j->item, &reversed);
 
-		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
+		repo_hold_locked_index(the_repository, &lock,
+				       LOCK_DIE_ON_ERROR);
 		if (!strcmp(strategy, "ort"))
 			clean = merge_ort_recursive(&o, head, remoteheads->item,
 						    reversed, &result);
@@ -859,9 +862,9 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		 * the editor and after we invoke run_status above.
 		 */
 		if (invoked_hook)
-			discard_cache();
+			discard_index(&the_index);
 	}
-	read_cache_from(index_file);
+	read_index_from(&the_index, index_file, get_git_dir());
 	strbuf_addbuf(&msg, &merge_msg);
 	if (squash)
 		BUG("the control must not reach here under --squash");
@@ -910,7 +913,9 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 	struct object_id result_tree, result_commit;
 	struct commit_list *parents, **pptr = &parents;
 
-	if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED, 0) < 0)
+	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET,
+					 SKIP_IF_UNCHANGED, 0, NULL, NULL,
+					 NULL) < 0)
 		return error(_("Unable to write index."));
 
 	write_tree_trivial(&result_tree);
@@ -1602,7 +1607,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * We are not doing octopus, not fast-forward, and have
 		 * only one common.
 		 */
-		refresh_cache(REFRESH_QUIET);
+		refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
 		if (allow_trivial && fast_forward != FF_ONLY) {
 			/*
 			 * Must first ensure that index matches HEAD before
diff --git a/builtin/mv.c b/builtin/mv.c
index 883cf3ff12b..19790ce38fa 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -106,7 +106,7 @@ static int index_range_of_same_dir(const char *src, int length,
 	const char *src_w_slash = add_slash(src);
 	int first, last, len_w_slash = length + 1;
 
-	first = cache_name_pos(src_w_slash, len_w_slash);
+	first = index_name_pos(&the_index, src_w_slash, len_w_slash);
 	if (first >= 0)
 		die(_("%.*s is in index"), len_w_slash, src_w_slash);
 
@@ -136,7 +136,7 @@ static int empty_dir_has_sparse_contents(const char *name)
 	const char *with_slash = add_slash(name);
 	int length = strlen(with_slash);
 
-	int pos = cache_name_pos(with_slash, length);
+	int pos = index_name_pos(&the_index, with_slash, length);
 	const struct cache_entry *ce;
 
 	if (pos < 0) {
@@ -189,8 +189,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	if (--argc < 1)
 		usage_with_options(builtin_mv_usage, builtin_mv_options);
 
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
-	if (read_cache() < 0)
+	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
+	if (repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
 
 	source = internal_prefix_pathspec(prefix, argv, argc, 0);
@@ -255,7 +255,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			int pos;
 			const struct cache_entry *ce;
 
-			pos = cache_name_pos(src, length);
+			pos = index_name_pos(&the_index, src, length);
 			if (pos < 0) {
 				const char *src_w_slash = add_slash(src);
 				if (!path_in_sparse_checkout(src_w_slash, &the_index) &&
@@ -278,7 +278,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				goto act_on_entry;
 			}
 			/* Check if dst exists in index */
-			if (cache_name_pos(dst, strlen(dst)) < 0) {
+			if (index_name_pos(&the_index, dst, strlen(dst)) < 0) {
 				modes[i] |= SPARSE;
 				goto act_on_entry;
 			}
@@ -303,7 +303,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 dir_check:
 		if (S_ISDIR(st.st_mode)) {
 			int j, dst_len, n;
-			int first = cache_name_pos(src, length), last;
+			int first = index_name_pos(&the_index, src, length), last;
 
 			if (first >= 0) {
 				prepare_move_submodule(src, first,
@@ -468,7 +468,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		if (mode & (WORKING_DIRECTORY | SKIP_WORKTREE_DIR))
 			continue;
 
-		pos = cache_name_pos(src, strlen(src));
+		pos = index_name_pos(&the_index, src, strlen(src));
 		assert(pos >= 0);
 		if (!(mode & SPARSE) && !lstat(src, &st))
 			sparse_and_dirty = ie_modified(&the_index,
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index c50b563e2be..f702f9d47bb 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -4,7 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "config.h"
 #include "lockfile.h"
@@ -176,7 +176,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
 
 	/*
 	 * NEEDSWORK
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5d855fd8f51..1384008fe09 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2018 Pratik Karki
  */
 
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "run-command.h"
 #include "exec-cmd.h"
@@ -292,7 +292,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	if (ret)
 		error(_("could not generate todo list"));
 	else {
-		discard_cache();
+		discard_index(&the_index);
 		if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
 						&todo_list))
 			BUG("unusable todo list");
@@ -1268,7 +1268,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (get_oid("HEAD", &head))
 			die(_("Cannot read HEAD"));
 
-		fd = hold_locked_index(&lock_file, 0);
+		fd = repo_hold_locked_index(the_repository, &lock_file, 0);
 		if (repo_read_index(the_repository) < 0)
 			die(_("could not read index"));
 		refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL,
diff --git a/builtin/reset.c b/builtin/reset.c
index 75e061f5dcf..1fa86edb4c9 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -7,7 +7,7 @@
  *
  * Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "lockfile.h"
@@ -160,7 +160,7 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 		 * if this entry is outside the sparse cone - this is necessary
 		 * to properly construct the reset sparse directory.
 		 */
-		pos = cache_name_pos(one->path, strlen(one->path));
+		pos = index_name_pos(&the_index, one->path, strlen(one->path));
 		if ((pos >= 0 && ce_skip_worktree(the_index.cache[pos])) ||
 		    (pos < 0 && !path_in_sparse_checkout(one->path, &the_index)))
 			ce->ce_flags |= CE_SKIP_WORKTREE;
@@ -423,7 +423,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
-	if (read_cache() < 0)
+	if (repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
 
 	/* Soft reset does not touch the index file nor the working tree
@@ -434,7 +434,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	if (reset_type != SOFT) {
 		struct lock_file lock = LOCK_INIT;
-		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
+		repo_hold_locked_index(the_repository, &lock,
+				       LOCK_DIE_ON_ERROR);
 		if (reset_type == MIXED) {
 			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
 			if (read_from_tree(&pathspec, &oid, intent_to_add))
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 8f61050bde8..d4c81352a65 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "config.h"
 #include "commit.h"
@@ -997,7 +997,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--shared-index-path")) {
-				if (read_cache() < 0)
+				if (repo_read_index(the_repository) < 0)
 					die(_("Could not read the index"));
 				if (the_index.split_index) {
 					const struct object_id *oid = &the_index.split_index->base_oid;
diff --git a/builtin/rm.c b/builtin/rm.c
index 2b23eb25438..40b7990de11 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -72,7 +72,7 @@ static void submodules_absorb_gitdir_if_needed(void)
 		int pos;
 		const struct cache_entry *ce;
 
-		pos = cache_name_pos(name, strlen(name));
+		pos = index_name_pos(&the_index, name, strlen(name));
 		if (pos < 0) {
 			pos = get_ours_cache_pos(name, pos);
 			if (pos < 0)
@@ -117,7 +117,7 @@ static int check_local_mod(struct object_id *head, int index_only)
 		int local_changes = 0;
 		int staged_changes = 0;
 
-		pos = cache_name_pos(name, strlen(name));
+		pos = index_name_pos(&the_index, name, strlen(name));
 		if (pos < 0) {
 			/*
 			 * Skip unmerged entries except for populated submodules
@@ -291,9 +291,9 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
 
-	if (read_cache() < 0)
+	if (repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
 
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &pathspec, NULL, NULL);
diff --git a/builtin/stash.c b/builtin/stash.c
index c251419af7c..62e36718d38 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -261,11 +261,11 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 	struct tree *tree;
 	struct lock_file lock_file = LOCK_INIT;
 
-	read_cache_preload(NULL);
-	if (refresh_cache(REFRESH_QUIET))
+	repo_read_index_preload(the_repository, NULL, 0);
+	if (refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL))
 		return -1;
 
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
 
 	memset(&opts, 0, sizeof(opts));
 
@@ -523,8 +523,9 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 	struct tree *head, *merge, *merge_base;
 	struct lock_file lock = LOCK_INIT;
 
-	read_cache_preload(NULL);
-	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
+	repo_read_index_preload(the_repository, NULL, 0);
+	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
+					 NULL, NULL, NULL))
 		return -1;
 
 	if (write_cache_as_tree(&c_tree, 0, NULL))
@@ -549,14 +550,14 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 				return error(_("conflicts in index. "
 					       "Try without --index."));
 
-			discard_cache();
-			read_cache();
+			discard_index(&the_index);
+			repo_read_index(the_repository);
 			if (write_cache_as_tree(&index_tree, 0, NULL))
 				return error(_("could not save index tree"));
 
 			reset_head();
-			discard_cache();
-			read_cache();
+			discard_index(&the_index);
+			repo_read_index(the_repository);
 		}
 	}
 
@@ -1082,7 +1083,7 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 	if (get_oid("HEAD", &dummy))
 		return -1;
 
-	if (read_cache() < 0)
+	if (repo_read_index(the_repository) < 0)
 		return -1;
 
 	init_revisions(&rev, NULL);
@@ -1286,7 +1287,7 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 	rev.diffopt.format_callback = add_diff_to_buf;
 	rev.diffopt.format_callback_data = &diff_output;
 
-	if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
+	if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0) {
 		ret = -1;
 		goto done;
 	}
@@ -1344,8 +1345,9 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 
 	prepare_fallback_ident("git stash", "git@stash");
 
-	read_cache_preload(NULL);
-	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0) < 0) {
+	repo_read_index_preload(the_repository, NULL, 0);
+	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
+					 NULL, NULL, NULL) < 0) {
 		ret = -1;
 		goto done;
 	}
@@ -1513,7 +1515,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		goto done;
 	}
 
-	read_cache_preload(NULL);
+	repo_read_index_preload(the_repository, NULL, 0);
 	if (!include_untracked && ps->nr) {
 		int i;
 		char *ps_matched = xcalloc(ps->nr, 1);
@@ -1533,7 +1535,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		free(ps_matched);
 	}
 
-	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0)) {
+	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
+					 NULL, NULL, NULL)) {
 		ret = -1;
 		goto done;
 	}
@@ -1590,7 +1593,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 				goto done;
 			}
 		}
-		discard_cache();
+		discard_index(&the_index);
 		if (ps->nr) {
 			struct child_process cp_add = CHILD_PROCESS_INIT;
 			struct child_process cp_diff = CHILD_PROCESS_INIT;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 808865a5e31..ebe86e68176 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1,4 +1,4 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "repository.h"
 #include "cache.h"
@@ -196,7 +196,7 @@ static int module_list_compute(const char **argv,
 	if (pathspec->nr)
 		ps_matched = xcalloc(pathspec->nr, 1);
 
-	if (read_cache() < 0)
+	if (repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
 
 	for (i = 0; i < the_index.cache_nr; i++) {
@@ -1109,13 +1109,13 @@ static int compute_summary_module_list(struct object_id *head_oid,
 	if (!info->cached) {
 		if (diff_cmd == DIFF_INDEX)
 			setup_work_tree();
-		if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
-			perror("read_cache_preload");
+		if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0) {
+			perror("repo_read_index_preload");
 			ret = -1;
 			goto cleanup;
 		}
-	} else if (read_cache() < 0) {
-		perror("read_cache");
+	} else if (repo_read_index(the_repository) < 0) {
+		perror("repo_read_cache");
 		ret = -1;
 		goto cleanup;
 	}
@@ -3240,7 +3240,7 @@ static void die_on_index_match(const char *path, int force)
 	const char *args[] = { path, NULL };
 	parse_pathspec(&ps, 0, PATHSPEC_PREFER_CWD, NULL, args);
 
-	if (read_cache_preload(NULL) < 0)
+	if (repo_read_index_preload(the_repository, NULL, 0) < 0)
 		die(_("index file corrupt"));
 
 	if (ps.nr) {
diff --git a/builtin/update-index.c b/builtin/update-index.c
index fec3da05abb..82d5902cc8b 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -237,7 +237,7 @@ static int test_if_untracked_cache_is_supported(void)
 static int mark_ce_flags(const char *path, int flag, int mark)
 {
 	int namelen = strlen(path);
-	int pos = cache_name_pos(path, namelen);
+	int pos = index_name_pos(&the_index, path, namelen);
 	if (0 <= pos) {
 		mark_fsmonitor_invalid(&the_index, the_index.cache[pos]);
 		if (mark)
@@ -331,7 +331,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 static int process_directory(const char *path, int len, struct stat *st)
 {
 	struct object_id oid;
-	int pos = cache_name_pos(path, len);
+	int pos = index_name_pos(&the_index, path, len);
 
 	/* Exact match: file or existing gitlink */
 	if (pos >= 0) {
@@ -441,7 +441,7 @@ static void chmod_path(char flip, const char *path)
 	int pos;
 	struct cache_entry *ce;
 
-	pos = cache_name_pos(path, strlen(path));
+	pos = index_name_pos(&the_index, path, strlen(path));
 	if (pos < 0)
 		goto fail;
 	ce = the_index.cache[pos];
@@ -638,7 +638,7 @@ static int unresolve_one(const char *path)
 	struct cache_entry *ce_2 = NULL, *ce_3 = NULL;
 
 	/* See if there is such entry in the index. */
-	pos = cache_name_pos(path, namelen);
+	pos = index_name_pos(&the_index, path, namelen);
 	if (0 <= pos) {
 		/* already merged */
 		pos = unmerge_index_entry_at(&the_index, pos);
@@ -802,15 +802,16 @@ struct refresh_params {
 static int refresh(struct refresh_params *o, unsigned int flag)
 {
 	setup_work_tree();
-	read_cache();
-	*o->has_errors |= refresh_cache(o->flags | flag);
+	repo_read_index(the_repository);
+	*o->has_errors |= refresh_index(&the_index, o->flags | flag, NULL,
+					NULL, NULL);
 	if (has_racy_timestamp(&the_index)) {
 		/*
 		 * Even if nothing else has changed, updating the file
 		 * increases the chance that racy timestamps become
 		 * non-racy, helping future run-time performance.
 		 * We do that even in case of "errors" returned by
-		 * refresh_cache() as these are no actual errors.
+		 * refresh_index() as these are no actual errors.
 		 * cmd_status() does the same.
 		 */
 		the_index.cache_changed |= SOMETHING_CHANGED;
@@ -1109,11 +1110,11 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	the_repository->settings.command_requires_full_index = 0;
 
 	/* we will diagnose later if it turns out that we need to update it */
-	newfd = hold_locked_index(&lock_file, 0);
+	newfd = repo_hold_locked_index(the_repository, &lock_file, 0);
 	if (newfd < 0)
 		lock_error = errno;
 
-	entries = read_cache();
+	entries = repo_read_index(the_repository);
 	if (entries < 0)
 		die("cache corrupted");
 
diff --git a/cache.h b/cache.h
index 707806d2125..07d40b0964b 100644
--- a/cache.h
+++ b/cache.h
@@ -441,13 +441,8 @@ extern struct index_state the_index;
 #define active_nr (the_index.cache_nr)
 
 #define read_cache() repo_read_index(the_repository)
-#define read_cache_from(path) read_index_from(&the_index, (path), (get_git_dir()))
-#define read_cache_preload(pathspec) repo_read_index_preload(the_repository, (pathspec), 0)
 #define discard_cache() discard_index(&the_index)
 #define cache_name_pos(name, namelen) index_name_pos(&the_index,(name),(namelen))
-#define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
-#define refresh_and_write_cache(refresh_flags, write_flags, gentle) repo_refresh_and_write_index(the_repository, (refresh_flags), (write_flags), (gentle), NULL, NULL, NULL)
-#define hold_locked_index(lock_file, flags) repo_hold_locked_index(the_repository, (lock_file), (flags))
 #endif
 #endif
 #endif
diff --git a/contrib/coccinelle/index-compatibility.cocci b/contrib/coccinelle/index-compatibility.cocci
index 8b1ed65e7b0..4c1b890c3ef 100644
--- a/contrib/coccinelle/index-compatibility.cocci
+++ b/contrib/coccinelle/index-compatibility.cocci
@@ -26,11 +26,27 @@ identifier f != prepare_to_commit;
 (
 - read_cache_unmerged
 + repo_read_index_unmerged
+|
+- hold_locked_index
++ repo_hold_locked_index
 )
   (
 + the_repository,
   ...)
 
+// "the_repository" special-cases
+@@
+@@
+(
+- read_cache_preload
++ repo_read_index_preload
+)
+  (
++ the_repository,
+  ...
++ , 0
+  )
+
 // "the_index" simple cases
 @@
 @@
@@ -80,3 +96,40 @@ identifier f != prepare_to_commit;
   (
 + &the_index,
   ...)
+
+@@
+@@
+(
+- refresh_and_write_cache
++ repo_refresh_and_write_index
+)
+  (
++ the_repository,
+  ...
++ , NULL, NULL, NULL
+  )
+
+// "the_index" special-cases
+@@
+@@
+(
+- read_cache_from
++ read_index_from
+)
+  (
++ &the_index,
+  ...
++ , get_git_dir()
+  )
+
+@@
+@@
+(
+- refresh_cache
++ refresh_index
+)
+  (
++ &the_index,
+  ...
++ , NULL, NULL, NULL
+  )
diff --git a/contrib/coccinelle/index-compatibility.pending.cocci b/contrib/coccinelle/index-compatibility.pending.cocci
index 8207aee62c3..01f875d0060 100644
--- a/contrib/coccinelle/index-compatibility.pending.cocci
+++ b/contrib/coccinelle/index-compatibility.pending.cocci
@@ -4,9 +4,6 @@
 (
 - read_cache
 + repo_read_index
-|
-- hold_locked_index
-+ repo_hold_locked_index
 )
   (
 + the_repository,
@@ -25,54 +22,3 @@
   (
 + &the_index,
   ...)
-
-// "the_repository" special-cases
-@@
-@@
-(
-- read_cache_preload
-+ repo_read_index_preload
-)
-  (
-+ the_repository,
-  ...
-+ , 0
-  )
-
-@@
-@@
-(
-- refresh_and_write_cache
-+ repo_refresh_and_write_index
-)
-  (
-+ the_repository,
-  ...
-+ , NULL, NULL, NULL
-  )
-
-
-// "the_index" special-cases
-@@
-@@
-(
-- read_cache_from
-+ read_index_from
-)
-  (
-+ &the_index,
-  ...
-+ , get_git_dir()
-  )
-
-@@
-@@
-(
-- refresh_cache
-+ refresh_index
-)
-  (
-+ &the_index,
-  ...
-+ , NULL, NULL, NULL
-  )
-- 
2.38.0.1509.g9445af83948

