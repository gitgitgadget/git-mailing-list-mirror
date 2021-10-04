Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B475C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 00:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35FBE6124F
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 00:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhJDAsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 20:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhJDAsO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 20:48:14 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF81CC061794
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 17:46:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so17852139wmq.1
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 17:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pNGAzF2L6GF/Rm6GdZu/R2+R4qby32vzkVXcoF03WB0=;
        b=YItCNnMHq9Q6DyhFkqPMXOM8G8y1rbnZ8oK6eI350Elj8Qeu91tE0jpojoWfmDGoCg
         dKI9xVoFVWHoF1nBOx66USQMjCggAxt0bMqfxqT+29Id4WuA/ve07/ZeeGi+S8Uk+HSm
         NHMVFu83RQoLn81xggSzhTv3TLU5iYbEpeUfv1jLxEAxb7l1klxs6nlJWKB3zufTwbNR
         jq3Rf+xQR+ie8g7txAlxoa9wt2DUUaecANQsvymstiV9CWVoErtr1ikAjnednm7lbs4b
         R3zdo2X659NgxObfeiLuvAKwend+Gl1byCw4/h06/XsC7ltuzqXrnQ/OiS3WtkthwZAL
         MZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pNGAzF2L6GF/Rm6GdZu/R2+R4qby32vzkVXcoF03WB0=;
        b=GlOs07GocsNedzU272BLREmRQo6gNY80rEKBBX8/m4v9cROxmUTEcZ0j6Txtb1FMe8
         y4lX9ILj0XAp7i9BuLNJNF44EK4tj+LxnDZV/5xx76xGO/CTTr+C8rSMy8HREblCN8K8
         y+wDCDwwdM4kv+I4wuukL3MHloTnZ+5bZhvj03/AYbTNVwo4VcLcW5WsnPQ7F6pL7YmI
         ibht7Wl0WP18JzCyog95Coe0gC5i+qqt3hQPifbmgbY+RtWWnnfbKK9xHT9KEofqU+t+
         BwJUqwEB6bRe0tFGuXeQYTsyxZjEZyrEbp6DOW4sWQbComNGZn5p/5dVJTJI6B2SaA5e
         fmLw==
X-Gm-Message-State: AOAM533tqj4r6RlhfIVNOhxPZA6Fp1QWE98RUTNngWT/dE6FGtRxN9+s
        g/xXjn3PqBRN0XTGG2yqJJrG49s+PwNZYw==
X-Google-Smtp-Source: ABdhPJyMaYaffnmgzjp94RPXz4F17gOICDvuj6ODoGmpZpHFFZudqPi5A9g+rYCP/H2SBwznMiT2Hg==
X-Received: by 2002:a1c:f216:: with SMTP id s22mr16294941wmc.27.1633308384155;
        Sun, 03 Oct 2021 17:46:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7sm13526773wrc.55.2021.10.03.17.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 17:46:23 -0700 (PDT)
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
Subject: [PATCH 10/10] built-ins: plug memory leaks with unpack_trees_options_release()
Date:   Mon,  4 Oct 2021 02:46:11 +0200
Message-Id: <patch-10.10-06ad6baf566-20211004T002226Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g83021034c5d
In-Reply-To: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Plug memory leaks in various built-ins that were missing
unpack_trees_options_release() calls. In an earlier commit these
functions were all made to use the "UNPACK_TREES_OPTIONS_INIT" macro,
now let's have the ones that didn't clean up their memory do so.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.c           |  9 +++++++--
 builtin/am.c        | 17 ++++++++++++-----
 builtin/checkout.c  |  9 +++++++--
 builtin/clone.c     |  1 +
 builtin/commit.c    |  6 +++++-
 builtin/merge.c     |  6 ++++--
 builtin/read-tree.c | 14 ++++++++++----
 builtin/reset.c     | 13 +++++++++----
 builtin/stash.c     | 14 ++++++++++----
 diff-lib.c          |  5 ++++-
 10 files changed, 69 insertions(+), 25 deletions(-)

diff --git a/archive.c b/archive.c
index 210d7235c5a..003db7d355d 100644
--- a/archive.c
+++ b/archive.c
@@ -306,8 +306,10 @@ int write_archive_entries(struct archiver_args *args,
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
 
@@ -346,8 +348,11 @@ int write_archive_entries(struct archiver_args *args,
 		if (err)
 			break;
 	}
+
+cleanup:
 	strbuf_release(&path_in_archive);
 	strbuf_release(&content);
+	unpack_trees_options_release(&opts);
 
 	return err;
 }
diff --git a/builtin/am.c b/builtin/am.c
index 82641ce68ec..4d4bb473c0f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1903,6 +1903,7 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 	struct lock_file lock_file = LOCK_INIT;
 	struct unpack_trees_options opts = UNPACK_TREES_OPTIONS_INIT;
 	struct tree_desc t[2];
+	int ret = 0;
 
 	if (parse_tree(head) || parse_tree(remote))
 		return -1;
@@ -1923,13 +1924,15 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 
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
+	unpack_trees_options_release(&opts);
+	return ret;
 }
 
 /**
@@ -1941,6 +1944,7 @@ static int merge_tree(struct tree *tree)
 	struct lock_file lock_file = LOCK_INIT;
 	struct unpack_trees_options opts = UNPACK_TREES_OPTIONS_INIT;
 	struct tree_desc t[1];
+	int ret = 0;
 
 	if (parse_tree(tree))
 		return -1;
@@ -1956,13 +1960,16 @@ static int merge_tree(struct tree *tree)
 
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
+	unpack_trees_options_release(&opts);
+	return ret;
 }
 
 /**
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 482d17676a0..fd76b504861 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -641,6 +641,7 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 {
 	struct unpack_trees_options opts = UNPACK_TREES_OPTIONS_INIT;
 	struct tree_desc tree_desc;
+	int ret;
 
 	opts.head_idx = -1;
 	opts.update = worktree;
@@ -667,10 +668,14 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
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
+	unpack_trees_options_release(&opts);
+	return ret;
 }
 
 static void setup_branch_path(struct branch_info *branch)
diff --git a/builtin/clone.c b/builtin/clone.c
index 0df820c5970..df3bb9a7884 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -697,6 +697,7 @@ static int checkout(int submodule_progress)
 	init_tree_desc(&t, tree->buffer, tree->size);
 	if (unpack_trees(1, &t, &opts) < 0)
 		die(_("unable to checkout working tree"));
+	unpack_trees_options_release(&opts);
 
 	free(head);
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 6cc7313bad8..84c79ecb5a5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -305,6 +305,7 @@ static void create_base_index(const struct commit *current_head)
 	struct tree *tree;
 	struct unpack_trees_options opts = UNPACK_TREES_OPTIONS_INIT;
 	struct tree_desc t;
+	int exit_early = 0;
 
 	if (!current_head) {
 		discard_cache();
@@ -324,7 +325,10 @@ static void create_base_index(const struct commit *current_head)
 	parse_tree(tree);
 	init_tree_desc(&t, tree->buffer, tree->size);
 	if (unpack_trees(1, &t, &opts))
-		exit(128); /* We've already reported the error, finish dying */
+		exit_early = 1; /* We've already reported the error, finish dying */
+	unpack_trees_options_release(&opts);
+	if (exit_early)
+		exit(128);
 }
 
 static void refresh_cache_or_die(int refresh_flags)
diff --git a/builtin/merge.c b/builtin/merge.c
index 73290a07fcc..28089e2c5ed 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -671,6 +671,7 @@ static int read_tree_trivial(struct object_id *common, struct object_id *head,
 	struct tree *trees[MAX_UNPACK_TREES];
 	struct tree_desc t[MAX_UNPACK_TREES];
 	struct unpack_trees_options opts = UNPACK_TREES_OPTIONS_INIT;
+	int ret = 0;
 
 	opts.head_idx = 2;
 	opts.src_index = &the_index;
@@ -695,8 +696,9 @@ static int read_tree_trivial(struct object_id *common, struct object_id *head,
 		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
 	}
 	if (unpack_trees(nr_trees, t, &opts))
-		return -1;
-	return 0;
+		ret = -1;
+	unpack_trees_options_release(&opts);
+	return ret;
 }
 
 static void write_tree_trivial(struct object_id *oid)
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 06f3b97ac05..8f1b8a7e74c 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -154,6 +154,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 		OPT__QUIET(&opts.quiet, N_("suppress feedback messages")),
 		OPT_END()
 	};
+	int ret = 0;
 
 	opts.head_idx = -1;
 	opts.src_index = &the_index;
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
+	unpack_trees_options_release(&opts);
+	return ret;
 }
diff --git a/builtin/reset.c b/builtin/reset.c
index 86c604b21e9..713d084c3eb 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -78,10 +78,14 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 
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
@@ -103,6 +107,7 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 	ret = 0;
 
 out:
+	unpack_trees_options_release(&opts);
 	for (i = 0; i < nr; i++)
 		free((void *)desc[i].buffer);
 	return ret;
diff --git a/builtin/stash.c b/builtin/stash.c
index 1137e5fcbe8..be6ecb1ae11 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -237,6 +237,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 	struct tree_desc t[MAX_UNPACK_TREES];
 	struct tree *tree;
 	struct lock_file lock_file = LOCK_INIT;
+	int ret = 0;
 
 	read_cache_preload(NULL);
 	if (refresh_cache(REFRESH_QUIET))
@@ -258,13 +259,17 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 	opts.update = update;
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
+	unpack_trees_options_release(&opts);
+	return ret;
 }
 
 static int diff_tree_binary(struct strbuf *out, struct object_id *w_commit)
@@ -815,6 +820,7 @@ static void diff_include_untracked(const struct stash_info *info, struct diff_op
 
 	if (unpack_trees(ARRAY_SIZE(tree_desc), tree_desc, &unpack_tree_opt))
 		die(_("failed to unpack trees"));
+	unpack_trees_options_release(&unpack_tree_opt);
 
 	do_diff_cache(&info->b_commit, diff_opt);
 }
diff --git a/diff-lib.c b/diff-lib.c
index 8a08d9af4eb..2d8a90a51b2 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -527,6 +527,7 @@ static int diff_cache(struct rev_info *revs,
 	struct tree *tree;
 	struct tree_desc t;
 	struct unpack_trees_options opts = UNPACK_TREES_OPTIONS_INIT;
+	int ret;
 
 	tree = parse_tree_indirect(tree_oid);
 	if (!tree)
@@ -545,7 +546,9 @@ static int diff_cache(struct rev_info *revs,
 	opts.pathspec->recursive = 1;
 
 	init_tree_desc(&t, tree->buffer, tree->size);
-	return unpack_trees(1, &t, &opts);
+	ret = unpack_trees(1, &t, &opts);
+	unpack_trees_options_release(&opts);
+	return ret;
 }
 
 void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb)
-- 
2.33.0.1404.g83021034c5d

