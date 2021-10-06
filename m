Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095FAC4332F
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFD8A61166
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbhJFJm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 05:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbhJFJmx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 05:42:53 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936C2C061753
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 02:41:01 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m22so7000017wrb.0
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 02:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z3lNL57aQ1PtAWJIlJ9j1dI4wIKFcNeO6R1VJxuZqJY=;
        b=ehoXa/wwuy5GlImIZjeyqB1A/z3qZtMSkd7svOzs6MLP9rWlQUTJ9wW4Memq4cMCVi
         LyL8VKPFNH0O8kqkNlhmlMElj/snNfE1rfmQM7CGlDNI7eJESN7+nBSA6qGBt80qFrCg
         zL8BMG+ovm7eSh0IWKmqvEOaVkx6NomwF/8TtqfKd/LqEBYOb0VLYYldanhvu/kSWcPr
         06b549+1X+mPP2HznMHH0790YQ6cE77petEamPfJgGH4LG+J/BvDrKZIbroOuLATVgP9
         bS0ZN5eW/yhCGLBnj8qkxbuZCgW9nKyJFCtDJUxbaiaQ4tEyK9QOHroRJvZPnohbe/7Q
         oKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z3lNL57aQ1PtAWJIlJ9j1dI4wIKFcNeO6R1VJxuZqJY=;
        b=r3tBK5ORrsWq60NygKJQ10naTh2hneQ7x3FvBPe7N7CH+TQVehMeimEhaKUOs2hJqL
         w8C3VpG+bflhSc49SZiOzHUlXirNyWst3RNzXTDKx7hmNFqtLwdDpOr+dB3bQ+XPURVy
         owRVQhDGaHYJiCsQH5KZfTaXkCZtAAb5tWgeSaLZUlvl2vsYK7HCjCM/KzwzFbrcahfj
         xvDIZfIqUrh2sblRXcoSL51RO8TggF2q/Q2O8W0I3gL4mjaqHNoPxJsMIGSEpAHUt7Ej
         buIssfj1DJyf0oxzwzWeRBHE6Mm8tgx670py/+RI+t6ysVYEGKpRpc3BFNdZFR5tAg8A
         iOuw==
X-Gm-Message-State: AOAM533r3V8GGPNXbQVEyQR4xqf1fW+zxSn/dgwwKY6BTpksV6Wg29eG
        QfIZ17qw2T5Vtsowj34YMgzpZCdLB/cnCg==
X-Google-Smtp-Source: ABdhPJxGndoDydLPjg2oxTA6E2Qi/2gSUpmdld1vJQC7FroYLRmJulkef/AbqoaXvpEzgRPNbmQQWA==
X-Received: by 2002:a7b:ca51:: with SMTP id m17mr8695174wml.49.1633513259783;
        Wed, 06 Oct 2021 02:40:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x10sm4741868wmk.42.2021.10.06.02.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 02:40:59 -0700 (PDT)
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
Subject: [PATCH 2/2] built-ins & lib: plug memory leaks with unpack_trees_options_release()
Date:   Wed,  6 Oct 2021 11:40:48 +0200
Message-Id: <patch-2.2-21f9da06b46-20211006T093405Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-0.2-00000000000-20211006T093405Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211006T093405Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Plug memory leaks in various built-ins and the "diff-lib.c" and
"sequencer.c" libraries that were missing
unpack_trees_options_release() calls.

In the case of "git archive" we'll need to memset() the "struct
unpack_trees_options" first, to avoid having to call
clear_unpack_trees_porcelain() twice within the
"!args->worktree_attributes" branch.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.c           | 11 ++++++++---
 builtin/am.c        | 17 ++++++++++++-----
 builtin/checkout.c  |  9 +++++++--
 builtin/clone.c     |  1 +
 builtin/commit.c    |  6 +++++-
 builtin/merge.c     |  6 ++++--
 builtin/read-tree.c | 14 ++++++++++----
 builtin/reset.c     | 13 +++++++++----
 builtin/stash.c     | 14 ++++++++++----
 diff-lib.c          |  5 ++++-
 sequencer.c         |  2 ++
 11 files changed, 72 insertions(+), 26 deletions(-)

diff --git a/archive.c b/archive.c
index a3bbb091256..b0acc5a8b88 100644
--- a/archive.c
+++ b/archive.c
@@ -299,16 +299,18 @@ int write_archive_entries(struct archiver_args *args,
 	/*
 	 * Setup index and instruct attr to read index only
 	 */
+	memset(&opts, 0, sizeof(opts));
 	if (!args->worktree_attributes) {
-		memset(&opts, 0, sizeof(opts));
 		opts.index_only = 1;
 		opts.head_idx = -1;
 		opts.src_index = args->repo->index;
 		opts.dst_index = args->repo->index;
 		opts.fn = oneway_merge;
 		init_tree_desc(&t, args->tree->buffer, args->tree->size);
-		if (unpack_trees(1, &t, &opts))
-			return -1;
+		if (unpack_trees(1, &t, &opts)) {
+			err = -1;
+			goto cleanup;
+		}
 		git_attr_set_direction(GIT_ATTR_INDEX);
 	}
 
@@ -347,8 +349,11 @@ int write_archive_entries(struct archiver_args *args,
 		if (err)
 			break;
 	}
+
+cleanup:
 	strbuf_release(&path_in_archive);
 	strbuf_release(&content);
+	clear_unpack_trees_porcelain(&opts);
 
 	return err;
 }
diff --git a/builtin/am.c b/builtin/am.c
index f296226e95f..0126ec2669b 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1903,6 +1903,7 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 	struct lock_file lock_file = LOCK_INIT;
 	struct unpack_trees_options opts;
 	struct tree_desc t[2];
+	int ret = 0;
 
 	if (parse_tree(head) || parse_tree(remote))
 		return -1;
@@ -1925,13 +1926,15 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 
 	if (unpack_trees(2, t, &opts)) {
 		rollback_lock_file(&lock_file);
-		return -1;
+		ret = -1;
+		goto cleanup;
 	}
 
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
-
-	return 0;
+cleanup:
+	clear_unpack_trees_porcelain(&opts);
+	return ret;
 }
 
 /**
@@ -1943,6 +1946,7 @@ static int merge_tree(struct tree *tree)
 	struct lock_file lock_file = LOCK_INIT;
 	struct unpack_trees_options opts;
 	struct tree_desc t[1];
+	int ret = 0;
 
 	if (parse_tree(tree))
 		return -1;
@@ -1959,13 +1963,16 @@ static int merge_tree(struct tree *tree)
 
 	if (unpack_trees(1, t, &opts)) {
 		rollback_lock_file(&lock_file);
-		return -1;
+		ret = -1;
+		goto cleanup;
 	}
 
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	return 0;
+cleanup:
+	clear_unpack_trees_porcelain(&opts);
+	return ret;
 }
 
 /**
diff --git a/builtin/checkout.c b/builtin/checkout.c
index cbf73b8c9f6..7b74380528b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -641,6 +641,7 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 {
 	struct unpack_trees_options opts;
 	struct tree_desc tree_desc;
+	int ret;
 
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = -1;
@@ -670,10 +671,14 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 		 */
 		/* fallthrough */
 	case 0:
-		return 0;
+		ret = 0;
+		break;
 	default:
-		return 128;
+		ret = 128;
 	}
+
+	clear_unpack_trees_porcelain(&opts);
+	return ret;
 }
 
 static void setup_branch_path(struct branch_info *branch)
diff --git a/builtin/clone.c b/builtin/clone.c
index 559acf9e036..c489a9bda10 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -699,6 +699,7 @@ static int checkout(int submodule_progress)
 	init_tree_desc(&t, tree->buffer, tree->size);
 	if (unpack_trees(1, &t, &opts) < 0)
 		die(_("unable to checkout working tree"));
+	clear_unpack_trees_porcelain(&opts);
 
 	free(head);
 
diff --git a/builtin/commit.c b/builtin/commit.c
index e7320f66f95..55bb178289f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -305,6 +305,7 @@ static void create_base_index(const struct commit *current_head)
 	struct tree *tree;
 	struct unpack_trees_options opts;
 	struct tree_desc t;
+	int exit_early = 0;
 
 	if (!current_head) {
 		discard_cache();
@@ -325,7 +326,10 @@ static void create_base_index(const struct commit *current_head)
 	parse_tree(tree);
 	init_tree_desc(&t, tree->buffer, tree->size);
 	if (unpack_trees(1, &t, &opts))
-		exit(128); /* We've already reported the error, finish dying */
+		exit_early = 1; /* We've already reported the error, finish dying */
+	clear_unpack_trees_porcelain(&opts);
+	if (exit_early)
+		exit(128);
 }
 
 static void refresh_cache_or_die(int refresh_flags)
diff --git a/builtin/merge.c b/builtin/merge.c
index 0ccd5e1ac83..b4bdba2faf6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -671,6 +671,7 @@ static int read_tree_trivial(struct object_id *common, struct object_id *head,
 	struct tree *trees[MAX_UNPACK_TREES];
 	struct tree_desc t[MAX_UNPACK_TREES];
 	struct unpack_trees_options opts;
+	int ret = 0;
 
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 2;
@@ -697,8 +698,9 @@ static int read_tree_trivial(struct object_id *common, struct object_id *head,
 		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
 	}
 	if (unpack_trees(nr_trees, t, &opts))
-		return -1;
-	return 0;
+		ret = -1;
+	clear_unpack_trees_porcelain(&opts);
+	return ret;
 }
 
 static void write_tree_trivial(struct object_id *oid)
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 2109c4c9e5c..060daa3913f 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -149,6 +149,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 		OPT__QUIET(&opts.quiet, N_("suppress feedback messages")),
 		OPT_END()
 	};
+	int ret = 0;
 
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = -1;
@@ -243,11 +244,13 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 		parse_tree(tree);
 		init_tree_desc(t+i, tree->buffer, tree->size);
 	}
-	if (unpack_trees(nr_trees, t, &opts))
-		return 128;
+	if (unpack_trees(nr_trees, t, &opts)) {
+		ret = 128;
+		goto cleanup;
+	}
 
 	if (opts.debug_unpack || opts.dry_run)
-		return 0; /* do not write the index out */
+		goto cleanup; /* do not write the index out */
 
 	/*
 	 * When reading only one tree (either the most basic form,
@@ -262,5 +265,8 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die("unable to write new index file");
-	return 0;
+
+cleanup:
+	clear_unpack_trees_porcelain(&opts);
+	return ret;
 }
diff --git a/builtin/reset.c b/builtin/reset.c
index 73935953494..8fb9bee1a98 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -85,10 +85,14 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 
 	if (reset_type == KEEP) {
 		struct object_id head_oid;
-		if (get_oid("HEAD", &head_oid))
-			return error(_("You do not have a valid HEAD."));
-		if (!fill_tree_descriptor(the_repository, desc + nr, &head_oid))
-			return error(_("Failed to find tree of HEAD."));
+		if (get_oid("HEAD", &head_oid)) {
+			error(_("You do not have a valid HEAD."));
+			goto out;
+		}
+		if (!fill_tree_descriptor(the_repository, desc + nr, &head_oid)) {
+			error(_("Failed to find tree of HEAD."));
+			goto out;
+		}
 		nr++;
 		opts.fn = twoway_merge;
 	}
@@ -110,6 +114,7 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 	ret = 0;
 
 out:
+	clear_unpack_trees_porcelain(&opts);
 	for (i = 0; i < nr; i++)
 		free((void *)desc[i].buffer);
 	return ret;
diff --git a/builtin/stash.c b/builtin/stash.c
index cc93ace4223..6bde00393fe 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -237,6 +237,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 	struct tree_desc t[MAX_UNPACK_TREES];
 	struct tree *tree;
 	struct lock_file lock_file = LOCK_INIT;
+	int ret = 0;
 
 	read_cache_preload(NULL);
 	if (refresh_cache(REFRESH_QUIET))
@@ -262,13 +263,17 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 		opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	opts.fn = oneway_merge;
 
-	if (unpack_trees(nr_trees, t, &opts))
-		return -1;
+	if (unpack_trees(nr_trees, t, &opts)) {
+		ret = -1;
+		goto cleanup;
+	}
 
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
-		return error(_("unable to write new index file"));
+		ret = error(_("unable to write new index file"));
 
-	return 0;
+cleanup:
+	clear_unpack_trees_porcelain(&opts);
+	return ret;
 }
 
 static int diff_tree_binary(struct strbuf *out, struct object_id *w_commit)
@@ -833,6 +838,7 @@ static void diff_include_untracked(const struct stash_info *info, struct diff_op
 
 	if (unpack_trees(ARRAY_SIZE(tree_desc), tree_desc, &unpack_tree_opt))
 		die(_("failed to unpack trees"));
+	clear_unpack_trees_porcelain(&unpack_tree_opt);
 
 	do_diff_cache(&info->b_commit, diff_opt);
 }
diff --git a/diff-lib.c b/diff-lib.c
index ca085a03efc..ddfbcf22abf 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -527,6 +527,7 @@ static int diff_cache(struct rev_info *revs,
 	struct tree *tree;
 	struct tree_desc t;
 	struct unpack_trees_options opts;
+	int ret;
 
 	tree = parse_tree_indirect(tree_oid);
 	if (!tree)
@@ -546,7 +547,9 @@ static int diff_cache(struct rev_info *revs,
 	opts.pathspec->recursive = 1;
 
 	init_tree_desc(&t, tree->buffer, tree->size);
-	return unpack_trees(1, &t, &opts);
+	ret = unpack_trees(1, &t, &opts);
+	clear_unpack_trees_porcelain(&opts);
+	return ret;
 }
 
 void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb)
diff --git a/sequencer.c b/sequencer.c
index 6872b7b00a4..74d478d67d3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3720,6 +3720,7 @@ static int do_reset(struct repository *r,
 		rollback_lock_file(&lock);
 		free((void *)desc.buffer);
 		strbuf_release(&ref_name);
+		clear_unpack_trees_porcelain(&unpack_tree_opts);
 		return -1;
 	}
 
@@ -3736,6 +3737,7 @@ static int do_reset(struct repository *r,
 				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
 
 	strbuf_release(&ref_name);
+	clear_unpack_trees_porcelain(&unpack_tree_opts);
 	return ret;
 }
 
-- 
2.33.0.1441.gbbcdb4c3c66

