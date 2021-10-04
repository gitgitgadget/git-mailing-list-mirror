Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE357C433FE
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B75A36115B
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhJDBN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 21:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhJDBNz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 21:13:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4BFC0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 18:12:06 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v25so16915750wra.2
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 18:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DYiAc/m4McpM45Boa52PfqupNuEfO2mMHAaUMbKBPFE=;
        b=kaz4i+9QOYvrM9vpl1ghoPOOyyAWp7obR07KC1Mg+JHXnFwe/rj2oAn5Ywel0LEZrQ
         mDyH0exL9Vcy3Im3hralHL95Lpo2dbAD/ns2Y7rDFpdSEqT3OorvXEV93Xwt9K9f5YUh
         +aG47nRJ2wTyjjzY1cC70GWtRnSnQN6bXfGO+ChYChFYV3zKATjE/20snzHoxGXdSaZK
         SFjTRXiLIJE8l0j/KF6VTwHWX1TTjyYu2MKgjxX6N8/ei8ItUbyCmsKGj4ZQzPHR5F17
         xgJOfolksnia+na1Ld/kVBKLGLVmvsgWEoYvuzQPQZBq7ANoSox1idJIbNBnt3BdNJdj
         jULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DYiAc/m4McpM45Boa52PfqupNuEfO2mMHAaUMbKBPFE=;
        b=Einr/YfaVOBpnNTieJRdhIf6gSS+gnelpcekwfmfSFiEovLponR1Nig0drkPDEFiDG
         Pk3xYkBpODpByRak3cWqwhCtPCoCW4WRKcyvcJZ2wOSfaApnxa4tLAQtM3YqDEyQ/gUo
         0dpFtMJSwVJZe2UESz4gZOASuKt7Yhxb9pS2+kz5insfL0JFp3xEtu3hgROWCFIJlS00
         OK3TNu+etHDa1jzGr6vrvQynEY3rEwyfvw5BdcBE4Tp0pBXDL+15JvX3MX3oFkMO3QFu
         HU3+RgB2269lZkH/k7M106fXFchHZeIUP1sWSN0IgSGPOs5EmkCPIgDifRd+hsJ8Cyzr
         Psqg==
X-Gm-Message-State: AOAM533m8aQI8uTmc+PvtX5H02dQLz8n9Eh5/2qJLGLNstwbs+A4YHPR
        LGMFgD3DG7CRt0bqBUgKq0bODoDioQ6RDA==
X-Google-Smtp-Source: ABdhPJxCubL2ielGYD+Tgq2hLCSVearPnZhzBKXlIrhf6YlK8ecc/RPg/VxeVuggtPR0S0A7zyJDDg==
X-Received: by 2002:a5d:4481:: with SMTP id j1mr11333818wrq.6.1633309924526;
        Sun, 03 Oct 2021 18:12:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q3sm12384317wmc.25.2021.10.03.18.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:12:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v4 03/10] unpack-trees: introduce preserve_ignored to unpack_trees_options
Date:   Mon,  4 Oct 2021 03:11:52 +0200
Message-Id: <RFC-patch-v4-03.10-739e9b871c4-20211004T004902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g83021034c5d
In-Reply-To: <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
References: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com> <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Currently, every caller of unpack_trees() that wants to ensure ignored
files are overwritten by default needs to:

   * flip the DIR_SHOW_IGNORED flag in unpack_trees_options.dir.flags
   * call setup_standard_excludes(&unpack_trees_options.dir)

Avoid that boilerplate by introducing a new boolean value where
the default value (0) does what we want so that new callers of
unpack_trees() automatically get the appropriate behavior.  And move all
the handling of unpack_trees_options.dir into unpack_trees() itself.

While preserve_ignored = 0 is the behavior we feel is the appropriate
default, we defer fixing commands to use the appropriate default until a
later commit.  So, this commit introduces several locations where we
manually set preserve_ignored=1.  This makes it clear where code paths
were previously preserving ignored files when they should not have been;
a future commit will flip these to instead use a value of 0 to get the
behavior we want.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c        | 3 +++
 builtin/checkout.c  | 6 ++----
 builtin/clone.c     | 2 ++
 builtin/merge.c     | 2 ++
 builtin/read-tree.c | 7 +++----
 builtin/reset.c     | 2 ++
 builtin/stash.c     | 3 +++
 merge-ort.c         | 5 +----
 merge-recursive.c   | 4 ++--
 merge.c             | 6 +-----
 reset.c             | 2 ++
 sequencer.c         | 2 ++
 unpack-trees.c      | 5 +++++
 unpack-trees.h      | 1 +
 14 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4d4bb473c0f..3c6efe2a46b 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1918,6 +1918,9 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 	opts.update = 1;
 	opts.merge = 1;
 	opts.reset = reset;
+	if (!reset)
+		/* FIXME: Default should be to remove ignored files */
+		opts.preserve_ignored = 1;
 	opts.fn = twoway_merge;
 	init_tree_desc(&t[0], head->buffer, head->size);
 	init_tree_desc(&t[1], remote->buffer, remote->size);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index fd76b504861..0c5187025c5 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -648,6 +648,7 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	opts.skip_unmerged = !worktree;
 	opts.reset = 1;
 	opts.merge = 1;
+	opts.preserve_ignored = 0;
 	opts.fn = oneway_merge;
 	opts.verbose_update = o->show_progress;
 	opts.src_index = &the_index;
@@ -749,10 +750,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 				       new_branch_info->commit ?
 				       &new_branch_info->commit->object.oid :
 				       &new_branch_info->oid, NULL);
-		if (opts->overwrite_ignore) {
-			topts.dir.flags |= DIR_SHOW_IGNORED;
-			setup_standard_excludes(&topts.dir);
-		}
+		topts.preserve_ignored = !opts->overwrite_ignore;
 		tree = parse_tree_indirect(old_branch_info->commit ?
 					   &old_branch_info->commit->object.oid :
 					   the_hash_algo->empty_tree);
diff --git a/builtin/clone.c b/builtin/clone.c
index df3bb9a7884..e76c38e4e81 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -686,6 +686,8 @@ static int checkout(int submodule_progress)
 	opts.update = 1;
 	opts.merge = 1;
 	opts.clone = 1;
+	/* FIXME: Default should be to remove ignored files */
+	opts.preserve_ignored = 1;
 	opts.fn = oneway_merge;
 	opts.verbose_update = (option_verbosity >= 0);
 	opts.src_index = &the_index;
diff --git a/builtin/merge.c b/builtin/merge.c
index 28089e2c5ed..55aac869e5a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -680,6 +680,8 @@ static int read_tree_trivial(struct object_id *common, struct object_id *head,
 	opts.verbose_update = 1;
 	opts.trivial_merges_only = 1;
 	opts.merge = 1;
+	/* FIXME: Default should be to remove ignored files */
+	opts.preserve_ignored = 1;
 	trees[nr_trees] = parse_tree_indirect(common);
 	if (!trees[nr_trees++])
 		return -1;
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index d0f88bbf3e3..7f3c987b126 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -201,10 +201,9 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if ((opts.update || opts.index_only) && !opts.merge)
 		die("%s is meaningless without -m, --reset, or --prefix",
 		    opts.update ? "-u" : "-i");
-	if (opts.update && !opts.reset) {
-		opts.dir.flags |= DIR_SHOW_IGNORED;
-		setup_standard_excludes(&opts.dir);
-	}
+	if (opts.update && !opts.reset)
+		opts.preserve_ignored = 0;
+	/* otherwise, opts.preserve_ignored is irrelevant */
 	if (opts.merge && !opts.index_only)
 		setup_work_tree();
 
diff --git a/builtin/reset.c b/builtin/reset.c
index 713d084c3eb..73477239146 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -66,6 +66,8 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 	case KEEP:
 	case MERGE:
 		opts.update = 1;
+		/* FIXME: Default should be to remove ignored files */
+		opts.preserve_ignored = 1;
 		break;
 	case HARD:
 		opts.update = 1;
diff --git a/builtin/stash.c b/builtin/stash.c
index be6ecb1ae11..78492013529 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -257,6 +257,9 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 	opts.merge = 1;
 	opts.reset = reset;
 	opts.update = update;
+	if (update && !reset)
+		/* FIXME: Default should be to remove ignored files */
+		opts.preserve_ignored = 1;
 	opts.fn = oneway_merge;
 
 	if (unpack_trees(nr_trees, t, &opts)) {
diff --git a/merge-ort.c b/merge-ort.c
index 0a5937364c9..e5620bda212 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4044,10 +4044,7 @@ static int checkout(struct merge_options *opt,
 	unpack_opts.quiet = 0; /* FIXME: sequencer might want quiet? */
 	unpack_opts.verbose_update = (opt->verbosity > 2);
 	unpack_opts.fn = twoway_merge;
-	if (1/* FIXME: opts->overwrite_ignore*/) {
-		unpack_opts.dir.flags |= DIR_SHOW_IGNORED;
-		setup_standard_excludes(&unpack_opts.dir);
-	}
+	unpack_opts.preserve_ignored = 0; /* FIXME: !opts->overwrite_ignore*/
 	parse_tree(prev);
 	init_tree_desc(&trees[0], prev->buffer, prev->size);
 	parse_tree(next);
diff --git a/merge-recursive.c b/merge-recursive.c
index a4131b8837b..5c6b95a79c0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -410,8 +410,8 @@ static int unpack_trees_start(struct merge_options *opt,
 		opt->priv->unpack_opts.index_only = 1;
 	else {
 		opt->priv->unpack_opts.update = 1;
-		opt->priv->unpack_opts.dir.flags |= DIR_SHOW_IGNORED;
-		setup_standard_excludes(&opt->priv->unpack_opts.dir);
+		/* FIXME: should only do this if !overwrite_ignore */
+		opt->priv->unpack_opts.preserve_ignored = 0;
 	}
 	opt->priv->unpack_opts.merge = 1;
 	opt->priv->unpack_opts.head_idx = 2;
diff --git a/merge.c b/merge.c
index 2e3714ccaa0..e1f3165e407 100644
--- a/merge.c
+++ b/merge.c
@@ -79,11 +79,7 @@ int checkout_fast_forward(struct repository *r,
 		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
 	}
 
-	if (overwrite_ignore) {
-		opts.dir.flags |= DIR_SHOW_IGNORED;
-		setup_standard_excludes(&opts.dir);
-	}
-
+	opts.preserve_ignored = !overwrite_ignore;
 	opts.head_idx = 1;
 	opts.src_index = r->index;
 	opts.dst_index = r->index;
diff --git a/reset.c b/reset.c
index f4bf3fbfac0..cd344f47f13 100644
--- a/reset.c
+++ b/reset.c
@@ -56,6 +56,8 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
 	unpack_tree_opts.update = 1;
 	unpack_tree_opts.merge = 1;
+	/* FIXME: Default should be to remove ignored files */
+	unpack_tree_opts.preserve_ignored = 1;
 	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
 	if (!detach_head)
 		unpack_tree_opts.reset = 1;
diff --git a/sequencer.c b/sequencer.c
index abd85b6c562..669ea15944c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3698,6 +3698,8 @@ static int do_reset(struct repository *r,
 	unpack_tree_opts.fn = oneway_merge;
 	unpack_tree_opts.merge = 1;
 	unpack_tree_opts.update = 1;
+	/* FIXME: Default should be to remove ignored files */
+	unpack_tree_opts.preserve_ignored = 1;
 	init_checkout_metadata(&unpack_tree_opts.meta, name, &oid, NULL);
 
 	if (repo_read_index_unmerged(r)) {
diff --git a/unpack-trees.c b/unpack-trees.c
index 260e7ec5bb4..02bc999c6c3 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1711,6 +1711,11 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		ensure_full_index(o->dst_index);
 	}
 
+	if (!o->preserve_ignored) {
+		o->dir.flags |= DIR_SHOW_IGNORED;
+		setup_standard_excludes(&o->dir);
+	}
+
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout && !o->pl) {
diff --git a/unpack-trees.h b/unpack-trees.h
index a8d1f083b33..65a8d99d4ef 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -52,6 +52,7 @@ struct unpack_trees_options {
 	unsigned int reset,
 		     merge,
 		     update,
+		     preserve_ignored,
 		     clone,
 		     index_only,
 		     nontrivial_merge,
-- 
2.33.0.1404.g83021034c5d

