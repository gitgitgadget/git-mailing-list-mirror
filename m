Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEFCC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 18:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA4D724953
	for <git@archiver.kernel.org>; Mon,  4 May 2020 18:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVi4gdpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbgEDS1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 14:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730670AbgEDS1r (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 14:27:47 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEE1C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 11:27:47 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v4so637928wme.1
        for <git@vger.kernel.org>; Mon, 04 May 2020 11:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=2XwHznP5JxKxjVzbVnjv9k8CC+i43Pw1Gar/p8EVGp4=;
        b=UVi4gdpIgF16xTl22PL8BiOwqWRVIpTxvdbJOvpnKSuEjxnbujZYkiJmTTk6ZuDPvM
         so9xpOTljQt73pNR/qEZs7BFMab3qkKrsZ7tq3jQL+voZuf9elw2Lh8T8Awh4ynhLwP8
         5dY8+Cf+h+1vDXqlDAcjZIpb65pjOyIX9LCxzbLzSShle3CtobCWvObNXSYO9VpcNPwn
         yL79UBqEvacwg3hFEkbFxCKK2PUd4n4fMnlv8UtaJ454qYshSRMZhkPJ4K2N+qoAd9M9
         ysX+Wsu76/xYaq6RCgOAG7D5mTEJs3BFA0Ps2QWFfvRly+rr1DTg5eDlMX/SuFDLdtOA
         ubQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2XwHznP5JxKxjVzbVnjv9k8CC+i43Pw1Gar/p8EVGp4=;
        b=gUolASFGHdSkAOANpwNXpqKgbSI+ImKnLWGuQ3o6ftM20v3F/2+nzR7FxjOUcIq2ls
         LzDC1pl/5lSRyrB6FSiOfJZhA4Golcspj3hkIijIbLvIzyBxd7cz6kGwdAt08iuOHeEp
         wetsE5olw9vCdwXvLMC8V27HyqoRoLrQCTNbeEfdOlnr0ZLypUlA3V8V4/SWjpHllpxc
         uIVFlAzeVXevfLMotXx+8sJiGFfrDtnM/x0Ibw94plOz7PdCWZ1nYMoRN62ACCnD4BWH
         8K1tNkZQNlPMfqYYUqwVN0hV19+3GnvNmDa83JgXtTZqT5F2w3TSM/DyyphmjHDfImf+
         pl6g==
X-Gm-Message-State: AGi0Puac7ghecZUa4a6MV693Yr2E7yBbqscxegAQST9KIZ85LULEosKr
        WZVLfL9a2kriwjQgc3V577Gxjh/6
X-Google-Smtp-Source: APiQypKpNm/pQzMgnkGqg8spe2Ts2oLlRtlidoYgbQu+TMAgvRD17ry3SL/J5dIdYteXouTGsqyztw==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr15498771wmj.169.1588616865699;
        Mon, 04 May 2020 11:27:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8sm19675490wru.38.2020.05.04.11.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 11:27:44 -0700 (PDT)
Message-Id: <pull.624.git.1588616864222.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 May 2020 18:27:43 +0000
Subject: [PATCH] sparse-checkout: stop blocking empty workdirs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, larsxschneider@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Remove the error condition when updating the sparse-checkout leaves
an empty working directory.

This behavior was added in 9e1afb167 (sparse checkout: inhibit empty
worktree, 2009-08-20). The comment was added in a7bc906f2 (Add
explanation why we do not allow to sparse checkout to empty working
tree, 2011-09-22) in response to a "dubious" comment in 84563a624
(unpack-trees.c: cosmetic fix, 2010-12-22).

With the recent "cone mode" and "git sparse-checkout init [--cone]"
command, it is common to set a reasonable sparse-checkout pattern
set of

	/*
	!/*/

which matches only files at root. If the repository has no such files,
then their "git sparse-checkout init" command will fail.

Now that we expect this to be a common pattern, we should not have the
commands fail on an empty working directory. If it is a confusing
result, then the user can recover with "git sparse-checkout disable"
or "git sparse-checkout set". This is especially simple when using cone
mode.

Reported-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    sparse-checkout: stop blocking empty workdirs
    
    This is based on en/sparse-checkout.
    
    This is something that Lars Schneider discovered working with a repo
    that had no files at root.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-624%2Fderrickstolee%2Fsparse-checkout-allow-empty-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-624/derrickstolee/sparse-checkout-allow-empty-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/624

 t/t1011-read-tree-sparse-checkout.sh | 12 +++++++---
 t/t1091-sparse-checkout-builtin.sh   |  8 +++----
 unpack-trees.c                       | 34 +---------------------------
 3 files changed, 13 insertions(+), 41 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index 63223e13bd1..140f4599773 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -74,13 +74,19 @@ test_expect_success 'read-tree --no-sparse-checkout with empty .git/info/sparse-
 test_expect_success 'read-tree with empty .git/info/sparse-checkout' '
 	git config core.sparsecheckout true &&
 	echo >.git/info/sparse-checkout &&
-	read_tree_u_must_fail -m -u HEAD &&
+	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files --stage >result &&
 	test_cmp expected result &&
 	git ls-files -t >result &&
+	cat >expected.swt <<-\EOF &&
+	S init.t
+	S sub/added
+	S sub/addedtoo
+	S subsub/added
+	EOF
 	test_cmp expected.swt result &&
-	test -f init.t &&
-	test -f sub/added
+	! test -f init.t &&
+	! test -f sub/added
 '
 
 test_expect_success 'match directories with trailing slash' '
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index dee99eeec30..88cdde255cd 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -106,10 +106,8 @@ test_expect_success 'set enables config' '
 		cd empty-config &&
 		test_commit test file &&
 		test_path_is_missing .git/config.worktree &&
-		test_must_fail git sparse-checkout set nothing &&
+		git sparse-checkout set nothing &&
 		test_path_is_file .git/config.worktree &&
-		test_must_fail git config core.sparseCheckout &&
-		git sparse-checkout set "/*" &&
 		test_cmp_config true core.sparseCheckout
 	)
 '
@@ -302,8 +300,8 @@ test_expect_success 'revert to old sparse-checkout on empty update' '
 		echo >file &&
 		git add file &&
 		git commit -m "test" &&
-		test_must_fail git sparse-checkout set nothing 2>err &&
-		test_i18ngrep "Sparse checkout leaves no entry on working directory" err &&
+		git sparse-checkout set nothing 2>err &&
+		test_i18ngrep ! "Sparse checkout leaves no entry on working directory" err &&
 		test_i18ngrep ! ".git/index.lock" err &&
 		git sparse-checkout set file
 	)
diff --git a/unpack-trees.c b/unpack-trees.c
index b43f3e775ad..9a3ccd9d083 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1677,8 +1677,6 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	}
 
 	if (!o->skip_sparse_checkout) {
-		int empty_worktree = 1;
-
 		/*
 		 * Sparse checkout loop #2: set NEW_SKIP_WORKTREE on entries not in loop #1
 		 * If they will have NEW_SKIP_WORKTREE, also set CE_SKIP_WORKTREE
@@ -1706,19 +1704,6 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 			if (apply_sparse_checkout(&o->result, ce, o))
 				ret = 1;
-
-			if (!ce_skip_worktree(ce))
-				empty_worktree = 0;
-		}
-		/*
-		 * Sparse checkout is meant to narrow down checkout area
-		 * but it does not make sense to narrow down to empty working
-		 * tree. This is usually a mistake in sparse checkout rules.
-		 * Do not allow users to do that.
-		 */
-		if (o->result.cache_nr && empty_worktree) {
-			ret = unpack_failed(o, "Sparse checkout leaves no entry on working directory");
-			goto done;
 		}
 		if (ret == 1) {
 			/*
@@ -1779,7 +1764,7 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
 {
 	enum update_sparsity_result ret = UPDATE_SPARSITY_SUCCESS;
 	struct pattern_list pl;
-	int i, empty_worktree;
+	int i;
 	unsigned old_show_all_errors;
 	int free_pattern_list = 0;
 
@@ -1810,7 +1795,6 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
 
 	/* Then loop over entries and update/remove as needed */
 	ret = UPDATE_SPARSITY_SUCCESS;
-	empty_worktree = 1;
 	for (i = 0; i < o->src_index->cache_nr; i++) {
 		struct cache_entry *ce = o->src_index->cache[i];
 
@@ -1824,28 +1808,12 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
 
 		if (apply_sparse_checkout(o->src_index, ce, o))
 			ret = UPDATE_SPARSITY_WARNINGS;
-
-		if (!ce_skip_worktree(ce))
-			empty_worktree = 0;
-	}
-
-	/*
-	 * Sparse checkout is meant to narrow down checkout area
-	 * but it does not make sense to narrow down to empty working
-	 * tree. This is usually a mistake in sparse checkout rules.
-	 * Do not allow users to do that.
-	 */
-	if (o->src_index->cache_nr && empty_worktree) {
-		unpack_failed(o, "Sparse checkout leaves no entry on working directory");
-		ret = UPDATE_SPARSITY_INDEX_UPDATE_FAILURES;
-		goto done;
 	}
 
 skip_sparse_checkout:
 	if (check_updates(o, o->src_index))
 		ret = UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES;
 
-done:
 	display_warning_msgs(o);
 	o->show_all_errors = old_show_all_errors;
 	if (free_pattern_list)

base-commit: 5644ca28cded68972c74614fc06d6e0e1db1a7de
-- 
gitgitgadget
