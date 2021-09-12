Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A43EC433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35DAF61056
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbhILNY6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 09:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbhILNYw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 09:24:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD783C061757
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:37 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d21so2565236wra.12
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=091FOS3cmDpnHLPChu5bX9sOuJNv/DvCABY/jg3a3ts=;
        b=lk5HUr2Sj82nWG2nvuPDPfNQpXXVvgtQ0zvS/CT6iIQkgBmYd8c3fDLMXtys/8u9lI
         i+VKNtzuDsa+vkD2E11KlANday8fthrhZrNE5HWpH+MxMUvjmuZDg+FIsfRfzTKNppsu
         2s05xxMviNjbc3ZBmWMMLSKmBCOB87Tj8vJSPCvVdPYSqrSUEekxG0XJUVGeRh7q6oNG
         cqxkn004huACf1SylaWqZ5eVawMHJhGdoUTbAeE9qG2d3BoeYbkArUXK5zBxh5Tj7MMY
         562mvFdoCS+7/O1h6N/bfwZyDMjfODY18vWM3Tte+oQS8NFQtx0c+wF0nGknUZdbL4AF
         WVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=091FOS3cmDpnHLPChu5bX9sOuJNv/DvCABY/jg3a3ts=;
        b=4sH9rJmuDx7jgYO5wMpNpDVo5YcfBq5k8ft/96KICaj4+udnPvPRWRU5wu1U/IRapg
         4PMkPm5w8f1Km4XN58RpwmpOC83EBG9HKVcwDf6/gcTF79D5CoOCng7KTmQinsbQjuxw
         q7Hiq3MV05cTELY0IK4NkDVFUE1DZClQ6wnKKoy4PwQRerPYYLLDkbZ+zst3hLHWbJqX
         7w8mDqybLZiDoRjMxYwlycXM5XWy5vyWSevj0T+kFbosJHPP8Owg0C4nQvs4zgHRFj0D
         KtRLnSarbgs+V++nGdxmY2ViSvz05UfgxGYK2vIqAjifA4emfeNOTLr2Q63COJc0wDel
         RZkA==
X-Gm-Message-State: AOAM5301N6SA8pGM2TfXPMjU+gS4srxfL/xZu4N3+R7bCyL3ftSDP2Vn
        DtnOuEuvv+PnunavafAP1oTK7lBCwrk=
X-Google-Smtp-Source: ABdhPJwof5Hcrrl6eMaQxLoxuwMCGNfB/opAbdTtNJ1rMqmjRGPBNi4Bp4JpAL5JfNHDSfjAx7ahOw==
X-Received: by 2002:adf:f2c4:: with SMTP id d4mr7687693wrp.434.1631453016445;
        Sun, 12 Sep 2021 06:23:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13sm1853897wri.53.2021.09.12.06.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 06:23:36 -0700 (PDT)
Message-Id: <d4706e17cae03d68d5c9108b3570f7fd9d2500d7.1631453010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
        <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 12 Sep 2021 13:23:23 +0000
Subject: [PATCH v2 07/14] add: skip tracked paths outside sparse-checkout cone
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
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
 t/t1092-sparse-checkout-compatibility.sh | 21 ++++++++++++++-------
 t/t3705-add-sparse-checkout.sh           | 12 ++++++++++++
 5 files changed, 36 insertions(+), 10 deletions(-)

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
index 997442b13e3..0fdc5c7098c 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -546,10 +546,10 @@ test_expect_failure 'merge with conflict outside cone' '
 	test_all_match git status --porcelain=v2 &&
 
 	# 2. Add the file with conflict markers
-	# NEEDSWORK: Even though the merge conflict removed the
-	# SKIP_WORKTREE bit from the index entry for folder1/a, we should
-	# warn that this is a problematic add.
-	test_all_match git add folder1/a &&
+	test_sparse_match test_must_fail git add folder1/a &&
+	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_sparse_unstaged folder1/a &&
+	test_all_match git add --sparse folder1/a &&
 	test_all_match git status --porcelain=v2 &&
 
 	# 3. Rename the file to another sparse filename and
@@ -558,7 +558,10 @@ test_expect_failure 'merge with conflict outside cone' '
 	# NEEDSWORK: This mode now fails, because folder2/z is
 	# outside of the sparse-checkout cone and does not match an
 	# existing index entry with the SKIP_WORKTREE bit cleared.
-	test_all_match git add folder2 &&
+	test_sparse_match test_must_fail git add folder2 &&
+	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_sparse_unstaged folder2/z &&
+	test_all_match git add --sparse folder2 &&
 	test_all_match git status --porcelain=v2 &&
 
 	test_all_match git merge --continue &&
@@ -586,7 +589,9 @@ test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
 		# NEEDSWORK: Even though the merge conflict removed the
 		# SKIP_WORKTREE bit from the index entry for folder1/a, we should
 		# warn that this is a problematic add.
-		test_all_match git add folder1/a &&
+		test_sparse_match test_must_fail git add folder1/a &&
+		test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
+		test_sparse_unstaged folder1/a &&
 		test_all_match git status --porcelain=v2 &&
 
 		# 3. Rename the file to another sparse filename and
@@ -595,7 +600,9 @@ test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
 		# outside of the sparse-checkout cone and does not match an
 		# existing index entry with the SKIP_WORKTREE bit cleared.
 		run_on_all mv folder2/a folder2/z &&
-		test_all_match git add folder2 &&
+		test_sparse_match test_must_fail git add folder2 &&
+		test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
+		test_sparse_unstaged folder2/z &&
 		test_all_match git status --porcelain=v2 &&
 
 		test_all_match git $OPERATION --continue &&
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index af81b4b6846..678be1acbf9 100755
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

