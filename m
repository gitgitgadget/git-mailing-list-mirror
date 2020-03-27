Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038F7C2D0E7
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8695206E6
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWANxgG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgC0AtS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:49:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55743 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbgC0AtN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 20:49:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id z5so9796990wml.5
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 17:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ft+lD/pmj9/I+0sLX5XALEw9YiuI86o5omHSTW9DEQ4=;
        b=mWANxgG3o63g42leRGwPHiCNEwGJ3HdUu6yYsbay3uAe2iULh8T3b2z/asw/SVRkVC
         UzhBrJlajcU4clJOFbwwbDlCeAOn440n2yMKHTxh6aS5pGg7xXd/lO4UYi4Z+q9FzdS2
         ZFf3pt7NBQT2gfJgrBaOvhFLa4VIHf/EU0FFh4Gh844mEKOTC0OXkgQ+bidEpVQqoXAM
         x8oz5lPl57OYhaH9M1hYT7k4hienn5x1EFjDnGxCXHe60VCWI9HSr07qnrqERmDglK3z
         AtAI+bPe7KVDhshaE4o1vxfG1aWoDBdOkwMPcznnRO2H/2XICAJQBoxOF/zl33IFctjP
         +nTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ft+lD/pmj9/I+0sLX5XALEw9YiuI86o5omHSTW9DEQ4=;
        b=uDJP/kXYw3X/ZIM0r/SwFiaqaS7Ektk2x7XWPkGNLvFwQygNzTDspHS/m0U00xrdx9
         2RZjJULkk3jwM7e1/xE0XoErBYtT3NhVEiSzOXyMG7bSOGQYdUVrxWXFV3aJYYFgXb0L
         Bhxo9i5egF9hJrg24UqFJwfMglHNTdlCvpxfI/JxMxR7R3eBdUdQ8oU6SFv6GnISGmWV
         P5jo4Jdhxa/rqZfZMSxXjECQCeuXcMkD+gAsM9QerYnYVY7kNEXv9szlQ1oc4/viUthq
         9d618iSpGTxs1lpG5Nm63JtC+tqVJeCZgfLOIUwVqXv1F8dv763uRY6j3kCkgPsJH2oW
         pRcg==
X-Gm-Message-State: ANhLgQ2byNAJVMuToUlYmM+kphAiSrHH+Zp9uYcAvYm9a4PHnpDBHexT
        0QAQ8hBDKFUbPNBskMbbHkvQCew9
X-Google-Smtp-Source: ADFU+vs6glfSAayUdaHd0Wcc1Ty0EnjCeWBvQCxy01Ifm156ky7Zk9Bb3bRgQLCAZ0PnbsKr9Ph0gg==
X-Received: by 2002:a7b:c004:: with SMTP id c4mr2585571wmb.108.1585270150959;
        Thu, 26 Mar 2020 17:49:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g128sm5947174wmf.27.2020.03.26.17.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 17:49:10 -0700 (PDT)
Message-Id: <9040ac97175a8a5e525285b5c0ff41060621a72e.1585270142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
References: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
        <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 00:48:53 +0000
Subject: [PATCH v3 10/18] sparse-checkout: use new update_sparsity() function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Remove the equivalent of 'git read-tree -mu HEAD' in the sparse-checkout
codepaths for setting the SKIP_WORKTREE bits and instead use the new
update_sparsity() function.

Note that when an issue is hit, the error message splits 'error' and
'Cannot update sparse checkout' on separate lines.  For now, we use two
greps to find both pieces of the error message but subsequent commits
will clean up the messages reported to the user.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          | 40 ++++++++----------------------
 t/t1091-sparse-checkout-builtin.sh | 39 +++++++++++++++++++++--------
 2 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index d102a9697fd..a55c60d7594 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -94,49 +94,35 @@ static int sparse_checkout_list(int argc, const char **argv)
 
 static int update_working_directory(struct pattern_list *pl)
 {
-	int result = 0;
+	enum update_sparsity_result result;
 	struct unpack_trees_options o;
 	struct lock_file lock_file = LOCK_INIT;
-	struct object_id oid;
-	struct tree *tree;
-	struct tree_desc t;
 	struct repository *r = the_repository;
 
-	if (repo_read_index_unmerged(r))
-		die(_("you need to resolve your current index first"));
-
-	if (get_oid("HEAD", &oid))
-		return 0;
-
-	tree = parse_tree_indirect(&oid);
-	parse_tree(tree);
-	init_tree_desc(&t, tree->buffer, tree->size);
-
 	memset(&o, 0, sizeof(o));
 	o.verbose_update = isatty(2);
-	o.merge = 1;
 	o.update = 1;
-	o.fn = oneway_merge;
 	o.head_idx = -1;
 	o.src_index = r->index;
 	o.dst_index = r->index;
 	o.skip_sparse_checkout = 0;
 	o.pl = pl;
 
-	resolve_undo_clear_index(r->index);
 	setup_work_tree();
 
-	cache_tree_free(&r->index->cache_tree);
-
 	repo_hold_locked_index(r, &lock_file, LOCK_DIE_ON_ERROR);
 
-	core_apply_sparse_checkout = 1;
-	result = unpack_trees(1, &t, &o);
+	result = update_sparsity(&o);
 
-	if (!result) {
-		prime_cache_tree(r, r->index, tree);
+	if (result == UPDATE_SPARSITY_WARNINGS)
+		/*
+		 * We don't do any special handling of warnings from untracked
+		 * files in the way or dirty entries that can't be removed.
+		 */
+		result = UPDATE_SPARSITY_SUCCESS;
+	if (result == UPDATE_SPARSITY_SUCCESS)
 		write_locked_index(r->index, &lock_file, COMMIT_LOCK);
-	} else
+	else
 		rollback_lock_file(&lock_file);
 
 	return result;
@@ -303,8 +289,6 @@ static int sparse_checkout_init(int argc, const char **argv)
 	};
 
 	repo_read_index(the_repository);
-	require_clean_work_tree(the_repository,
-				N_("initialize sparse-checkout"), NULL, 1, 0);
 
 	argc = parse_options(argc, argv, NULL,
 			     builtin_sparse_checkout_init_options,
@@ -559,8 +543,6 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
 	};
 
 	repo_read_index(the_repository);
-	require_clean_work_tree(the_repository,
-				N_("set sparse-checkout patterns"), NULL, 1, 0);
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_sparse_checkout_set_options,
@@ -576,8 +558,6 @@ static int sparse_checkout_disable(int argc, const char **argv)
 	struct strbuf match_all = STRBUF_INIT;
 
 	repo_read_index(the_repository);
-	require_clean_work_tree(the_repository,
-				N_("disable sparse-checkout"), NULL, 1, 0);
 
 	memset(&pl, 0, sizeof(pl));
 	hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 8607a8e6d1a..a991e0a80d5 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -277,16 +277,23 @@ test_expect_success 'cone mode: add parent path' '
 	check_files repo a deep folder1
 '
 
-test_expect_success 'revert to old sparse-checkout on bad update' '
+test_expect_success 'not-up-to-date does not block rest of sparsification' '
 	test_when_finished git -C repo sparse-checkout disable &&
 	test_when_finished git -C repo reset --hard &&
 	git -C repo sparse-checkout set deep &&
+
 	echo update >repo/deep/deeper2/a &&
 	cp repo/.git/info/sparse-checkout expect &&
-	test_must_fail git -C repo sparse-checkout set deep/deeper1 2>err &&
-	test_i18ngrep "cannot set sparse-checkout patterns" err &&
-	test_cmp repo/.git/info/sparse-checkout expect &&
-	check_files repo/deep a deeper1 deeper2
+	test_write_lines "!/deep/*/" "/deep/deeper1/" >>expect &&
+
+	git -C repo sparse-checkout set deep/deeper1 2>err &&
+
+	test_i18ngrep "Cannot update sparse checkout" err &&
+	test_cmp expect repo/.git/info/sparse-checkout &&
+	check_files repo/deep a deeper1 deeper2 &&
+	check_files repo/deep/deeper1 a deepest &&
+	check_files repo/deep/deeper1/deepest a &&
+	check_files repo/deep/deeper2 a
 '
 
 test_expect_success 'revert to old sparse-checkout on empty update' '
@@ -316,16 +323,28 @@ test_expect_success '.gitignore should not warn about cone mode' '
 	test_i18ngrep ! "disabling cone patterns" err
 '
 
-test_expect_success 'sparse-checkout (init|set|disable) fails with dirty status' '
+test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status' '
 	git clone repo dirty &&
 	echo dirty >dirty/folder1/a &&
-	test_must_fail git -C dirty sparse-checkout init &&
-	test_must_fail git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
-	test_must_fail git -C dirty sparse-checkout disable &&
+
+	git -C dirty sparse-checkout init 2>err &&
+	test_i18ngrep "error" err &&
+	test_i18ngrep "Cannot update sparse checkout" err &&
+
+	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* 2>err &&
+	test_i18ngrep "error" err &&
+	test_i18ngrep "Cannot update sparse checkout" err &&
+	test_path_is_file dirty/folder1/a &&
+
+	git -C dirty sparse-checkout disable 2>err &&
+	test_must_be_empty err &&
+
 	git -C dirty reset --hard &&
 	git -C dirty sparse-checkout init &&
 	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
-	git -C dirty sparse-checkout disable
+	test_path_is_missing dirty/folder1/a &&
+	git -C dirty sparse-checkout disable &&
+	test_path_is_file dirty/folder1/a
 '
 
 test_expect_success 'cone mode: set with core.ignoreCase=true' '
-- 
gitgitgadget

