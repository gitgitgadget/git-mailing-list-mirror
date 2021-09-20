Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617FDC433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE3860F48
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243082AbhITXiw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 19:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbhITXgu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 19:36:50 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0640C0EDAF9
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:44 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g16so32044588wrb.3
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X0Pm/CFSzA9pc11Q83Noz7O4XmovKwzIyujecG2BqZA=;
        b=diBJwMsF7KlYKyqr+vKO++dNVwnr0oyLO4BdaYq2Hv/raP4L7BnjYPLFNiH7JbtoxZ
         ZIDFOH/J4xUmSlhmvNtjjeRfww9YantFlzPfVTCKtHOJfhDkAqsHnsK4Ac3K0Z9k8wNK
         8WLETRO9RoIK/TpBYWTtt2HP5mlbHpyS/LI1FSyHCjjJV6bQ2YPqJpOhBXtbxyyaG+7k
         I6t2ET51ydFdDjZBPQZ+akrEDaOBgwBKaFPO8stoaJTsa0YxpCnHoY6x+2i/KXgfjO+/
         eZKw9L72AQ4z26XEez59J10tJDfRJEtPAwg1Zx+ZKjhHe3WTe/tLLvEv131paD4KGq7r
         ktwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=X0Pm/CFSzA9pc11Q83Noz7O4XmovKwzIyujecG2BqZA=;
        b=4Le/Q584jFsVhCGQ7oMG4FmEqejcM0K8a0nLaZIJOnELYKJikeDRN5gKjERWBcg3Sb
         oPyJINR3/aJZustx49xhOE+8WFo6lS+TxSBCfjpZrxnSHcv+HNdZUzJON2YUSYGfHOhw
         JR6UHq3MCa4Ff7RbcY2S0BYTbkMLP6JzmN4y98DE40F6S0cDd2GOFsKvZMtWdRgnc6W1
         vVskUDPTvAGkTKYSyE3aC/76QTmFqZhSpIbyCOmfk5Dd+fdod6f1ftj4s8lTSA0+4Pqy
         bKlfxCuxUaaRPFNH/H9/UgEGq6tUsBKDV4JbKG8ejGARR61GvDuBgqTm0c3CH9QDMyQp
         cBhQ==
X-Gm-Message-State: AOAM531z7ilaANq+Js4xf8jclJhfbtiHnRtjLP3rfoOPtQIB/90etyXC
        /qn5I78rxmYZjsuAe4vvKvUDiCT6+Ig=
X-Google-Smtp-Source: ABdhPJwpAXM8dEJ1XYTcJUfqb7TkqeFxaRn7IEWGiEeUXacfC6l3qgizA2Nm3PQpIaT6NW5SkRJMPQ==
X-Received: by 2002:a7b:c959:: with SMTP id i25mr258858wml.55.1632159943552;
        Mon, 20 Sep 2021 10:45:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n186sm176341wme.31.2021.09.20.10.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:45:43 -0700 (PDT)
Message-Id: <15039e031e5252179eb16fb04c02ad91fbbe4952.1632159937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
References: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
        <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 17:45:30 +0000
Subject: [PATCH v3 07/14] add: skip tracked paths outside sparse-checkout cone
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When 'git add' adds a tracked file that is outside of the
sparse-checkout cone, it checks the SKIP_WORKTREE bit to see if the file
exists outside of the sparse-checkout cone. This is usually correct,
except in the case of a merge conflict outside of the cone.

Modify add_pathspec_matched_against_index() to be more careful about
paths by checking the sparse-checkout patterns in addition to the
SKIP_WORKTREE bit. This causes 'git add' to no longer allow files
outside of the cone that removed the SKIP_WORKTREE bit due to a merge
conflict.

With only this change, users will only be able to add the file after
adding the file to the sparse-checkout cone. A later change will allow
users to force adding even though the file is outside of the
sparse-checkout cone.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/add.c                            |  4 ++++
 pathspec.c                               |  5 +++--
 t/t1091-sparse-checkout-builtin.sh       |  4 +++-
 t/t1092-sparse-checkout-compatibility.sh | 19 ++++++++++++-------
 t/t3705-add-sparse-checkout.sh           | 12 ++++++++++++
 5 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 8ea9cae0e7a..09c3fad6321 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -94,6 +94,10 @@ static void update_callback(struct diff_queue_struct *q,
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		const char *path = p->one->path;
+
+		if (!path_in_sparse_checkout(path, &the_index))
+			continue;
+
 		switch (fix_unmerged_status(p, data)) {
 		default:
 			die(_("unexpected diff status %c"), p->status);
diff --git a/pathspec.c b/pathspec.c
index 44306fdaca2..ddeeba79114 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -39,7 +39,8 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 		return;
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
-		if (sw_action == PS_IGNORE_SKIP_WORKTREE && ce_skip_worktree(ce))
+		if (sw_action == PS_IGNORE_SKIP_WORKTREE &&
+		    (ce_skip_worktree(ce) || !path_in_sparse_checkout(ce->name, istate)))
 			continue;
 		ce_path_match(istate, ce, pathspec, seen);
 	}
@@ -70,7 +71,7 @@ char *find_pathspecs_matching_skip_worktree(const struct pathspec *pathspec)
 
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
-		if (ce_skip_worktree(ce))
+		if (ce_skip_worktree(ce) || !path_in_sparse_checkout(ce->name, istate))
 		    ce_path_match(istate, ce, pathspec, seen);
 	}
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 71236981e64..af99ae81b1d 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -406,7 +406,7 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with unmerged stat
 	git -C unmerged sparse-checkout disable
 '
 
-test_expect_success 'sparse-checkout reapply' '
+test_expect_failure 'sparse-checkout reapply' '
 	git clone repo tweak &&
 
 	echo dirty >tweak/deep/deeper2/a &&
@@ -438,6 +438,8 @@ test_expect_success 'sparse-checkout reapply' '
 	test_i18ngrep "warning.*The following paths are unmerged" err &&
 	test_path_is_file tweak/folder1/a &&
 
+	# NEEDSWORK: We are asking to update a file outside of the
+	# sparse-checkout cone, but this is no longer allowed.
 	git -C tweak add folder1/a &&
 	git -C tweak sparse-checkout reapply 2>err &&
 	test_must_be_empty err &&
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index be8f6f1399e..ba2483732ff 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -546,10 +546,9 @@ test_expect_failure 'merge with conflict outside cone' '
 	test_all_match git status --porcelain=v2 &&
 
 	# 2. Add the file with conflict markers
-	# NEEDSWORK: Even though the merge conflict removed the
-	# SKIP_WORKTREE bit from the index entry for folder1/a, we should
-	# warn that this is a problematic add.
-	test_all_match git add folder1/a &&
+	test_sparse_match test_must_fail git add folder1/a &&
+	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_sparse_unstaged folder1/a &&
 	test_all_match git status --porcelain=v2 &&
 
 	# 3. Rename the file to another sparse filename and
@@ -558,7 +557,9 @@ test_expect_failure 'merge with conflict outside cone' '
 	# NEEDSWORK: This mode now fails, because folder2/z is
 	# outside of the sparse-checkout cone and does not match an
 	# existing index entry with the SKIP_WORKTREE bit cleared.
-	test_all_match git add folder2 &&
+	test_sparse_match test_must_fail git add folder2 &&
+	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_sparse_unstaged folder2/z &&
 	test_all_match git status --porcelain=v2 &&
 
 	test_all_match git merge --continue &&
@@ -586,7 +587,9 @@ test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
 		# NEEDSWORK: Even though the merge conflict removed the
 		# SKIP_WORKTREE bit from the index entry for folder1/a, we should
 		# warn that this is a problematic add.
-		test_all_match git add folder1/a &&
+		test_sparse_match test_must_fail git add folder1/a &&
+		grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+		test_sparse_unstaged folder1/a &&
 		test_all_match git status --porcelain=v2 &&
 
 		# 3. Rename the file to another sparse filename and
@@ -595,7 +598,9 @@ test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
 		# outside of the sparse-checkout cone and does not match an
 		# existing index entry with the SKIP_WORKTREE bit cleared.
 		run_on_all mv folder2/a folder2/z &&
-		test_all_match git add folder2 &&
+		test_sparse_match test_must_fail git add folder2 &&
+		grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+		test_sparse_unstaged folder2/z &&
 		test_all_match git status --porcelain=v2 &&
 
 		test_all_match git $OPERATION --continue &&
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index e202a2ff74a..5899f270d02 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -158,6 +158,18 @@ test_expect_success 'do not warn when pathspec matches dense entries' '
 	git ls-files --error-unmatch dense_entry
 '
 
+test_expect_success 'git add fails outside of sparse-checkout definition' '
+	test_when_finished git sparse-checkout disable &&
+	test_commit a &&
+	git sparse-checkout init &&
+	git sparse-checkout set a &&
+	echo >>sparse_entry &&
+
+	git update-index --no-skip-worktree sparse_entry &&
+	test_must_fail git add sparse_entry &&
+	test_sparse_entry_unstaged
+'
+
 test_expect_success 'add obeys advice.updateSparsePath' '
 	setup_sparse_entry &&
 	test_must_fail git -c advice.updateSparsePath=false add sparse_entry 2>stderr &&
-- 
gitgitgadget

