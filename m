Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D32C4332D
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FB020663
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uc31O4UR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgCUSAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:00:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37936 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgCUSAU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:00:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id e5so1162593edq.5
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 11:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kWxyL6SA0pIObn23znpcOTUKTQfs6gWKs2tb9oX3otI=;
        b=Uc31O4URYomH+oTZo5pIumzvtaaWH/vQcjaSPLX2cK3XoRwFCA621CqMwEL1os10sZ
         MyTXsqwrRIA/KFQasWyAkvnNMAkR9QVuFzTBRQzO/DlFn8Rpf6TKp/HFfSZqQcCRljHu
         L+sYV1Cxc+DxptKyrxGFPU6T6WRCQxoFyvotI0fxJvZDAuQSG9PbSb24Hzav3DfxCicZ
         2z9mtdAQEcXaqZ4BH2Bsh82I/HiDYy+ac4Jg22GmChsVJZfcLWBmwmiW4GCFulhIrYjD
         X02oG4Hf+00br6/hzPaCf6j6YyCNU1AQTXgcnhK+ShNM43WjuJT5oCUIPFBY6DWWjSSm
         DM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kWxyL6SA0pIObn23znpcOTUKTQfs6gWKs2tb9oX3otI=;
        b=X/pRq87IxoZFYRSswURwR/CfD2QgV95yu4pcxEtMfcWMXn1Rphc5JgMSMfWWy8XwUT
         T2iyeGbC3haOgt3Adt98tjnZ/Oh2k63TZMaO7/3YalsaFhAOozz+XaFOpzbhOk/1Jkew
         F2dwgDFVet+Xlj5Z83tUmT6PvzFEjxJaAHk/owvDROn8NrGQYreJMK1lC2L43VKGmtBl
         QGgC5kPhvCG7aOGNRYjIzqvynYCiloSBZ2FdIfYw6QrFgN7T3PZYOQ8HARFvIRcjRNgK
         kLh3fju/bFCIpu9UoPRhiLJmUiQc8AvcLZN5ZjRFMIlAr5WKEDeQoIq/wE32jr0F14ap
         w4Cw==
X-Gm-Message-State: ANhLgQ0U+2YCD/nOdYOeBpLFmUwB09K/lqMdxN8rPGzsAVtK+Wb/fwUH
        gLSb+GBaoYfd2B0p84wFyjq6jG4M
X-Google-Smtp-Source: ADFU+vsmH3Lao6Au8/cpqGQ70Pr/Dselyd3LFyRyYU6kFS0ioetBEHhPkfrW1jjDWcGvVjUW2OO6FA==
X-Received: by 2002:a17:906:688f:: with SMTP id n15mr13938258ejr.30.1584813617569;
        Sat, 21 Mar 2020 11:00:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s7sm587465edr.15.2020.03.21.11.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 11:00:17 -0700 (PDT)
Message-Id: <27ed4a3f7a28c66d8185cb4c484e8b0af81b15c6.1584813609.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
        <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Mar 2020 18:00:01 +0000
Subject: [PATCH v2 10/18] sparse-checkout: use new update_sparsity() function
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          | 40 ++++++++----------------------
 t/t1091-sparse-checkout-builtin.sh | 35 +++++++++++++++++++-------
 2 files changed, 36 insertions(+), 39 deletions(-)

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
index 8607a8e6d1a..86ae422ff5c 100755
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
@@ -316,12 +323,22 @@ test_expect_success '.gitignore should not warn about cone mode' '
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
+	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
+	test_i18ngrep "error" err &&
+	test_i18ngrep "Cannot update sparse checkout" err &&
+
+	git -C dirty sparse-checkout disable &&
+	test_i18ngrep "error" err &&
+	test_i18ngrep "Cannot update sparse checkout" err &&
+
 	git -C dirty reset --hard &&
 	git -C dirty sparse-checkout init &&
 	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
-- 
gitgitgadget

