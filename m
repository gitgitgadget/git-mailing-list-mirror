Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B658C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 00:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18110610CC
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 00:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhJDAsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 20:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbhJDAsG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 20:48:06 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F22C061780
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 17:46:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t8so27584955wri.1
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 17:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fHNMVX+tmtrz838dcrFxdPv9ckV28+cFUly6/2r1sp4=;
        b=WTNpWxKnuWWz7djf98AvUJId/Tyxo6yEVch2h/JK6IVU+qxC9iJxkooeUHcHMkrAqa
         uHJ5amNZVeuJfA88H7IeoceJgkNItaTLjF/LfvMA0Wwz6ibe325jAjTqJBG4DBYvR3rU
         ifO4a2JPjwDG1tDQ3ncQTxGJYNDHK9Ztxj9pfkR5Fu0EhdFlWvuQfmauLnLUokCdTG7n
         8jRdUlQVa+Kk0pTYhPwh9+qfjkqiztjx0EKHEGFIPAkHin6tenUVTMW3fS/xnwh11Kp1
         hA9jcMFRVT1T+zC3k6QFXQudVxHHhxfebzYh/3wWIkpO2ubr34hj5Ve+BcD8wq1ls+hD
         plwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fHNMVX+tmtrz838dcrFxdPv9ckV28+cFUly6/2r1sp4=;
        b=BLyguJiPLTz52b/SmBjHWBZAiw7DVs6CaB5gXPehkrZXIde5ug+gf7Dxcj6OISViGW
         4oCRac6QUBQLUA1LMMieBrqu/hY6GnT7mO5vZbjmwDR5bZ3YGvZ1dcUqq3RWOobhoMYq
         TWCJY42lBBZTOxG9VSL7ML8EdDV0VpkHOkes4THbUvgs5Te0gEaHz+HND1JXrlmoHhQM
         yxwSW8m94jfEM5jH3MWCRR2d70Zc+iGw7g/hMa/3IIEXZsp+ywbfICN5xf81C4ow13/E
         e0Ckf1tU12Hfmk/D6Ehp5SdUYqyN7WuxkTOWYKiuKf8LS+8XYDCLIvWV1b1NR8jbRJoW
         iEtg==
X-Gm-Message-State: AOAM532P322Edizk/4dFSqTabSfaPd6J0wBHLLvS9OCOZP584X5wgk9M
        /LolXcln0Fh8USTbJ2DlIIcm1zn8VYnakg==
X-Google-Smtp-Source: ABdhPJwPU5jYO25mjhkzy/S6gnhz8q3PVYleMpTM/SO7ESoBMeVCi0+qdAE7ChAmGR8l7hxQVsJxcQ==
X-Received: by 2002:a5d:6da9:: with SMTP id u9mr10885847wrs.58.1633308376014;
        Sun, 03 Oct 2021 17:46:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7sm13526773wrc.55.2021.10.03.17.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 17:46:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/10] unpack-trees.[ch]: define and use a UNPACK_TREES_OPTIONS_INIT
Date:   Mon,  4 Oct 2021 02:46:02 +0200
Message-Id: <patch-01.10-b550c290c11-20211004T002226Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g83021034c5d
In-Reply-To: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
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

This covers all callers except a special-case in "merge-recursive.c",
which will be dealt with in a subsequent commit.

1. https://lore.kernel.org/git/87k0ixrv23.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/87fstlrumj.fsf@evledraar.gmail.com/

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
 merge.c                   | 3 +--
 reset.c                   | 2 +-
 sequencer.c               | 3 +--
 unpack-trees.h            | 2 ++
 16 files changed, 20 insertions(+), 35 deletions(-)

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
diff --git a/merge.c b/merge.c
index 6e736881d90..086f04b0f97 100644
--- a/merge.c
+++ b/merge.c
@@ -50,7 +50,7 @@ int checkout_fast_forward(struct repository *r,
 			  int overwrite_ignore)
 {
 	struct tree *trees[MAX_UNPACK_TREES];
-	struct unpack_trees_options opts;
+	struct unpack_trees_options opts = UNPACK_TREES_OPTIONS_INIT;
 	struct tree_desc t[MAX_UNPACK_TREES];
 	int i, nr_trees = 0;
 	struct dir_struct dir = DIR_INIT;
@@ -79,7 +79,6 @@ int checkout_fast_forward(struct repository *r,
 		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
 	}
 
-	memset(&opts, 0, sizeof(opts));
 	if (overwrite_ignore) {
 		dir.flags |= DIR_SHOW_IGNORED;
 		setup_standard_excludes(&dir);
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
index 2d88b19dca7..ecf256cbcea 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -91,6 +91,8 @@ struct unpack_trees_options {
 	struct checkout_metadata meta;
 };
 
+#define UNPACK_TREES_OPTIONS_INIT { 0 }
+
 int unpack_trees(unsigned n, struct tree_desc *t,
 		 struct unpack_trees_options *options);
 
-- 
2.33.0.1404.g83021034c5d

