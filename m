Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14D6C433FE
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C6C561A6F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353606AbhJAK3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353578AbhJAK3e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:29:34 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72725C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:27:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h15so13082957wrc.3
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7HzLWFNBImKnp7o/ZCpEEw2drZWcf5DDyaWePBOzSDw=;
        b=OUk62OeOcQ8wydWmZWzxNrUp9a1Lt62lvTqokrOcnFDY+51LJ8m2Eua7YtTkKAU0p8
         jX6zQGJnAC60F2Oy8KE3Vbo0eRBNuE9IuojkTUtFBIMmKCAkLgi+C0c66spGguE4OaRX
         0sFOMc2yVyn0OBM8GZmyAQeXWB85bG59YJ3BJ8bMzLRx4Z4QEDYG2HTVqscN1iNjY7gS
         fEv4elsVoAnRyIdbF9B1/ucs0Ct1Z0eE67AuSUtjv52n3mKKhBXQWwYDhqPrC5mK+mod
         Oxx3eFKiv6g6NwFSyxJll/Q62y7dvo/kNY1FVBAxVZqWxNu7blYyrTw8WyHSe4o4bvxD
         H5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7HzLWFNBImKnp7o/ZCpEEw2drZWcf5DDyaWePBOzSDw=;
        b=4wd+Ao/F7DD3J8M6RqIw0m29HxS929wwp3F6uSGtzhC6piA0YPenCK5TrPczztADQn
         0noRcgYxXDk+OTaBjpnI7UrgbcJ7278Q7RGFL/UWzZddk6jBpHmqhkGa1N7zIL0dfhXw
         X7EvG5cFLvJFUlNSuBKYQaPoFDkrY/FepVSsUujMukwJ/onpjBdc+g4BpthnCXxFglWZ
         h0oJHNdfKWM38d/bGtTFIhMcSib1ftQFOOEx9Ilhk4VmPI2Roz+jnWwpzTAgAdeXqBeu
         SDLjdWftnOAM/bUMh+/iJANTiAGntSmX+YGieYAi4z3yLMIhAgEZJRY+JDk/Abz41QXc
         FhOQ==
X-Gm-Message-State: AOAM532aMjAGie/M5INboyd5lV/WTH5aAE6t5h6W/8MIU+PwB2iITk6/
        BKF9p/jwMsr286lYEaAmVQ9pRGDlhYP3aQ==
X-Google-Smtp-Source: ABdhPJxmsLhB0UPT/1/V4RWRR1OEL3XExztrURkpOGcdoY3T6ePLDsdQIUuEoPyKTSqbE80RWLWOjA==
X-Received: by 2002:a05:6000:1b8d:: with SMTP id r13mr11797242wru.230.1633084068693;
        Fri, 01 Oct 2021 03:27:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h7sm5398952wrx.14.2021.10.01.03.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:27:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/6] unpack-trees.[ch]: define and use a UNPACK_TREES_OPTIONS_INIT
Date:   Fri,  1 Oct 2021 12:27:36 +0200
Message-Id: <patch-v3-6.6-18358f5d57a-20211001T102056Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.gbbd823cc90f
In-Reply-To: <cover-v3-0.6-00000000000-20211001T102056Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210927T125715Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20211001T102056Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Almost all users of "struct unpack_trees_options" allocate it on the
stack already, let's provide an *_INIT macro for them to use. This
will make later changes that would like to initialize other members of
the struct easier[1][2], but for now we're keeping it compatible with
a memset() to "0" with an "{ 0 }" initialization.

This leaves a caller in "checkout_fast_forward()" in "merge.c" still
doing the memset(). I've left it to avoid a conflict with the
in-flight en/removing-untracked-fixes. As noted above conflict is just
textual, not semantic, so we can clean it up some other time. I've
manually validated[3] with some WIP changes on top of this that the
remaining "checkout_fast_forward()" caller is the only one that.s
left.

1. https://lore.kernel.org/git/87k0ixrv23.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/87fstlrumj.fsf@evledraar.gmail.com/
3. https://lore.kernel.org/git/877dexrqvg.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.c                 | 3 +--
 builtin/am.c              | 6 ++----
 builtin/checkout.c        | 6 ++----
 builtin/clone.c           | 3 +--
 builtin/commit.c          | 3 +--
 builtin/merge.c           | 3 +--
 builtin/read-tree.c       | 3 +--
 builtin/reset.c           | 3 +--
 builtin/sparse-checkout.c | 3 +--
 builtin/stash.c           | 6 ++----
 diff-lib.c                | 3 +--
 merge-ort.c               | 3 +--
 merge-recursive.c         | 4 +++-
 reset.c                   | 2 +-
 sequencer.c               | 3 +--
 unpack-trees.h            | 1 +
 16 files changed, 21 insertions(+), 34 deletions(-)

diff --git a/archive.c b/archive.c
index a3bbb091256..210d7235c5a 100644
--- a/archive.c
+++ b/archive.c
@@ -269,7 +269,7 @@ int write_archive_entries(struct archiver_args *args,
 		write_archive_entry_fn_t write_entry)
 {
 	struct archiver_context context;
-	struct unpack_trees_options opts;
+	struct unpack_trees_options opts = UNPACK_TREES_OPTIONS_INIT;
 	struct tree_desc t;
 	int err;
 	struct strbuf path_in_archive = STRBUF_INIT;
@@ -300,7 +300,6 @@ int write_archive_entries(struct archiver_args *args,
 	 * Setup index and instruct attr to read index only
 	 */
 	if (!args->worktree_attributes) {
-		memset(&opts, 0, sizeof(opts));
 		opts.index_only = 1;
 		opts.head_idx = -1;
 		opts.src_index = args->repo->index;
diff --git a/builtin/am.c b/builtin/am.c
index e4a0ff9cd7c..82641ce68ec 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1901,7 +1901,7 @@ static void am_resolve(struct am_state *state)
 static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 {
 	struct lock_file lock_file = LOCK_INIT;
-	struct unpack_trees_options opts;
+	struct unpack_trees_options opts = UNPACK_TREES_OPTIONS_INIT;
 	struct tree_desc t[2];
 
 	if (parse_tree(head) || parse_tree(remote))
@@ -1911,7 +1911,6 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 
 	refresh_cache(REFRESH_QUIET);
 
-	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
@@ -1940,7 +1939,7 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 static int merge_tree(struct tree *tree)
 {
 	struct lock_file lock_file = LOCK_INIT;
-	struct unpack_trees_options opts;
+	struct unpack_trees_options opts = UNPACK_TREES_OPTIONS_INIT;
 	struct tree_desc t[1];
 
 	if (parse_tree(tree))
@@ -1948,7 +1947,6 @@ static int merge_tree(struct tree *tree)
 
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
-	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8c69dcdf72a..fea4533dbec 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -639,10 +639,9 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 		      int worktree, int *writeout_error,
 		      struct branch_info *info)
 {
-	struct unpack_trees_options opts;
+	struct unpack_trees_options opts = UNPACK_TREES_OPTIONS_INIT;
 	struct tree_desc tree_desc;
 
-	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = -1;
 	opts.update = worktree;
 	opts.skip_unmerged = !worktree;
@@ -719,9 +718,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	} else {
 		struct tree_desc trees[2];
 		struct tree *tree;
-		struct unpack_trees_options topts;
+		struct unpack_trees_options topts = UNPACK_TREES_OPTIONS_INIT;
 
-		memset(&topts, 0, sizeof(topts));
 		topts.head_idx = -1;
 		topts.src_index = &the_index;
 		topts.dst_index = &the_index;
diff --git a/builtin/clone.c b/builtin/clone.c
index ff1d3d447a3..0df820c5970 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -655,7 +655,7 @@ static int checkout(int submodule_progress)
 	struct object_id oid;
 	char *head;
 	struct lock_file lock_file = LOCK_INIT;
-	struct unpack_trees_options opts;
+	struct unpack_trees_options opts = UNPACK_TREES_OPTIONS_INIT;
 	struct tree *tree;
 	struct tree_desc t;
 	int err = 0;
@@ -683,7 +683,6 @@ static int checkout(int submodule_progress)
 
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
-	memset(&opts, 0, sizeof opts);
 	opts.update = 1;
 	opts.merge = 1;
 	opts.clone = 1;
diff --git a/builtin/commit.c b/builtin/commit.c
index e7320f66f95..6cc7313bad8 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -303,7 +303,7 @@ static void add_remove_files(struct string_list *list)
 static void create_base_index(const struct commit *current_head)
 {
 	struct tree *tree;
-	struct unpack_trees_options opts;
+	struct unpack_trees_options opts = UNPACK_TREES_OPTIONS_INIT;
 	struct tree_desc t;
 
 	if (!current_head) {
@@ -311,7 +311,6 @@ static void create_base_index(const struct commit *current_head)
 		return;
 	}
 
-	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
 	opts.index_only = 1;
 	opts.merge = 1;
diff --git a/builtin/merge.c b/builtin/merge.c
index 3fbdacc7db4..73290a07fcc 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -670,9 +670,8 @@ static int read_tree_trivial(struct object_id *common, struct object_id *head,
 	int i, nr_trees = 0;
 	struct tree *trees[MAX_UNPACK_TREES];
 	struct tree_desc t[MAX_UNPACK_TREES];
-	struct unpack_trees_options opts;
+	struct unpack_trees_options opts = UNPACK_TREES_OPTIONS_INIT;
 
-	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 2;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 485e7b04794..847182fdad6 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -116,7 +116,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	int i, stage = 0;
 	struct object_id oid;
 	struct tree_desc t[MAX_UNPACK_TREES];
-	struct unpack_trees_options opts;
+	struct unpack_trees_options opts = UNPACK_TREES_OPTIONS_INIT;
 	int prefix_set = 0;
 	struct lock_file lock_file = LOCK_INIT;
 	const struct option read_tree_options[] = {
@@ -158,7 +158,6 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 		OPT_END()
 	};
 
-	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = -1;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
diff --git a/builtin/reset.c b/builtin/reset.c
index 51c9e2f43ff..86c604b21e9 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -51,10 +51,9 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 	int i, nr = 0;
 	struct tree_desc desc[2];
 	struct tree *tree;
-	struct unpack_trees_options opts;
+	struct unpack_trees_options opts = UNPACK_TREES_OPTIONS_INIT;
 	int ret = -1;
 
-	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index d0f5c4702be..4c3c29fb580 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -195,7 +195,7 @@ static void clean_tracked_sparse_directories(struct repository *r)
 static int update_working_directory(struct pattern_list *pl)
 {
 	enum update_sparsity_result result;
-	struct unpack_trees_options o;
+	struct unpack_trees_options o = UNPACK_TREES_OPTIONS_INIT;
 	struct lock_file lock_file = LOCK_INIT;
 	struct repository *r = the_repository;
 
@@ -205,7 +205,6 @@ static int update_working_directory(struct pattern_list *pl)
 
 	r->index->sparse_checkout_patterns = pl;
 
-	memset(&o, 0, sizeof(o));
 	o.verbose_update = isatty(2);
 	o.update = 1;
 	o.head_idx = -1;
diff --git a/builtin/stash.c b/builtin/stash.c
index 8f42360ca91..1137e5fcbe8 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -233,7 +233,7 @@ static int clear_stash(int argc, const char **argv, const char *prefix)
 static int reset_tree(struct object_id *i_tree, int update, int reset)
 {
 	int nr_trees = 1;
-	struct unpack_trees_options opts;
+	struct unpack_trees_options opts = UNPACK_TREES_OPTIONS_INIT;
 	struct tree_desc t[MAX_UNPACK_TREES];
 	struct tree *tree;
 	struct lock_file lock_file = LOCK_INIT;
@@ -244,8 +244,6 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
-	memset(&opts, 0, sizeof(opts));
-
 	tree = parse_tree_indirect(i_tree);
 	if (parse_tree(tree))
 		return -1;
@@ -799,7 +797,7 @@ static void diff_include_untracked(const struct stash_info *info, struct diff_op
 	const struct object_id *oid[] = { &info->w_commit, &info->u_tree };
 	struct tree *tree[ARRAY_SIZE(oid)];
 	struct tree_desc tree_desc[ARRAY_SIZE(oid)];
-	struct unpack_trees_options unpack_tree_opt = { 0 };
+	struct unpack_trees_options unpack_tree_opt = UNPACK_TREES_OPTIONS_INIT;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(oid); i++) {
diff --git a/diff-lib.c b/diff-lib.c
index ca085a03efc..8a08d9af4eb 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -526,13 +526,12 @@ static int diff_cache(struct rev_info *revs,
 {
 	struct tree *tree;
 	struct tree_desc t;
-	struct unpack_trees_options opts;
+	struct unpack_trees_options opts = UNPACK_TREES_OPTIONS_INIT;
 
 	tree = parse_tree_indirect(tree_oid);
 	if (!tree)
 		return error("bad tree object %s",
 			     tree_name ? tree_name : oid_to_hex(tree_oid));
-	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
 	opts.index_only = cached;
 	opts.diff_index_cached = (cached &&
diff --git a/merge-ort.c b/merge-ort.c
index 35aa979c3a4..75d2b8e4b99 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4021,9 +4021,8 @@ static int checkout(struct merge_options *opt,
 	/* Switch the index/working copy from old to new */
 	int ret;
 	struct tree_desc trees[2];
-	struct unpack_trees_options unpack_opts;
+	struct unpack_trees_options unpack_opts = UNPACK_TREES_OPTIONS_INIT;
 
-	memset(&unpack_opts, 0, sizeof(unpack_opts));
 	unpack_opts.head_idx = -1;
 	unpack_opts.src_index = opt->repo->index;
 	unpack_opts.dst_index = opt->repo->index;
diff --git a/merge-recursive.c b/merge-recursive.c
index e594d4c3fa1..40254ec0b3d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -404,8 +404,10 @@ static int unpack_trees_start(struct merge_options *opt,
 	int rc;
 	struct tree_desc t[3];
 	struct index_state tmp_index = { NULL };
+	struct unpack_trees_options blank = UNPACK_TREES_OPTIONS_INIT;
 
-	memset(&opt->priv->unpack_opts, 0, sizeof(opt->priv->unpack_opts));
+	assert(sizeof(blank) == sizeof(opt->priv->unpack_opts));
+	memcpy(&opt->priv->unpack_opts, &blank, sizeof(opt->priv->unpack_opts));
 	if (opt->priv->call_depth)
 		opt->priv->unpack_opts.index_only = 1;
 	else
diff --git a/reset.c b/reset.c
index 79310ae071b..d13984ab781 100644
--- a/reset.c
+++ b/reset.c
@@ -21,7 +21,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	struct object_id head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
-	struct unpack_trees_options unpack_tree_opts = { 0 };
+	struct unpack_trees_options unpack_tree_opts = UNPACK_TREES_OPTIONS_INIT;
 	struct tree *tree;
 	const char *reflog_action;
 	struct strbuf msg = STRBUF_INIT;
diff --git a/sequencer.c b/sequencer.c
index 614d56f5e21..abd85b6c562 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3652,7 +3652,7 @@ static int do_reset(struct repository *r,
 	struct lock_file lock = LOCK_INIT;
 	struct tree_desc desc;
 	struct tree *tree;
-	struct unpack_trees_options unpack_tree_opts;
+	struct unpack_trees_options unpack_tree_opts = UNPACK_TREES_OPTIONS_INIT;
 	int ret = 0;
 
 	if (repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0)
@@ -3691,7 +3691,6 @@ static int do_reset(struct repository *r,
 		}
 	}
 
-	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
 	setup_unpack_trees_porcelain(&unpack_tree_opts, "reset");
 	unpack_tree_opts.head_idx = 1;
 	unpack_tree_opts.src_index = r->index;
diff --git a/unpack-trees.h b/unpack-trees.h
index 2d88b19dca7..caa7ada59ab 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -90,6 +90,7 @@ struct unpack_trees_options {
 	struct pattern_list *pl; /* for internal use */
 	struct checkout_metadata meta;
 };
+#define UNPACK_TREES_OPTIONS_INIT { 0 }
 
 int unpack_trees(unsigned n, struct tree_desc *t,
 		 struct unpack_trees_options *options);
-- 
2.33.0.1375.gbbd823cc90f

