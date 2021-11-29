Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1C7C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 19:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352130AbhK2Ti6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 14:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238675AbhK2Tg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 14:36:57 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA83FC0617A5
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 07:52:47 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso17200377wml.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 07:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BOiihwKfyp8h1ZPOwc/Ncb03jmtRWNTQQAMmoxR9+V4=;
        b=QuNdrwxrrie9yYqutw2LaD/Pc+vqFO7D53yCw/WUpnq9PgXMDFRzc/54Eanb8jLtpe
         GHZMTZhrY3KrNjcXG1GoFT6qrd0qEjqKb4esSA+Cx9YpkqmKZULVR5rckFeQQHSYjWSX
         wG7iVmZb+Vg/5Xjln1EtrC6L3pDc71W37N7DM2IANa+7dgF/C3uyAJeZ3U4uHULaOj/R
         1lpylzbbevWRSstWMbE2Fodk2yYMZMUo0ifNDgcsZ+Fititt8ZP6PX4DyI5ENY/GZPro
         Am2MsIK/4fx+mxeJmadHY3WzJZeBm3umL2YKJsXpaf9nivnS2wwKBy+BpKbr+tO2qQoc
         SgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BOiihwKfyp8h1ZPOwc/Ncb03jmtRWNTQQAMmoxR9+V4=;
        b=EPcIDxHbsiupfj/izJM14emTXfPJGFw8L9u4Ol82Fmx4e3nbRZ7/3UKKYOanSDEgKr
         npnD2YoEdPv3QCI6yxFnX8SUmmnY3OabNq7Nh8h+v3Gw/biWp3YXHm1uRsKmfpgm0elR
         b60cAugteYjfe3g8mQrO5qowZNZmtWj0CEbxFrCmj1oANjwiymKAySo7G4CM9oHmorxW
         a2/q4ZFUHZkyNnkQevHU360vv00LRTMw0dKta1SZj75CHNOhXbaIAMgM2EsNgRHB03+F
         PPNS1NFAADnFl6YW6sjQqk70ZeVoBGiv6AUm5HKzV8ylGPGHgHebPbVPN//BJ1EQ7WM6
         w8dA==
X-Gm-Message-State: AOAM5330Zgd8xjcIn6Sb6/GJlB/TJYZQLxe+FGC2FWhTCI3Q3T8MzIj0
        +648zmRuzel/bRiMzl/LUfNEUo6IeNE=
X-Google-Smtp-Source: ABdhPJyIbs+ryPeAN62aPbfejtmxOHSzQO1i7Xr4X2t407Fqoi2wopZ/6NWWwdSg3SMqcMw+Jfy6wg==
X-Received: by 2002:a1c:9851:: with SMTP id a78mr37060500wme.116.1638201166268;
        Mon, 29 Nov 2021 07:52:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s63sm16185979wme.22.2021.11.29.07.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 07:52:45 -0800 (PST)
Message-Id: <b221b00b7e06a3b135b9f68ce87cffaa7d782581.1638201164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v6.git.1638201164.gitgitgadget@gmail.com>
References: <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
        <pull.1048.v6.git.1638201164.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 15:52:37 +0000
Subject: [PATCH v6 2/8] reset: preserve skip-worktree bit in mixed reset
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Change `update_index_from_diff` to set `skip-worktree` when applicable for
new index entries. When `git reset --mixed <tree-ish>` is run, entries in
the index with differences between the pre-reset HEAD and reset <tree-ish>
are identified and handled with `update_index_from_diff`. For each file, a
new cache entry in inserted into the index, created from the <tree-ish> side
of the reset (without changing the working tree). However, the newly-created
entry must have `skip-worktree` explicitly set in either of the following
scenarios:

1. the file is in the current index and has `skip-worktree` set
2. the file is not in the current index but is outside of a defined sparse
   checkout definition

Not setting the `skip-worktree` bit leads to likely-undesirable results for
a user. It causes `skip-worktree` settings to disappear on the
"diff"-containing files (but *only* the diff-containing files), leading to
those files now showing modifications in `git status`. For example, when
running `git reset --mixed` in a sparse checkout, some file entries outside
of sparse checkout could show up as deleted, despite the user never deleting
anything (and not wanting them on-disk anyway).

Additionally, add a test to `t7102` to ensure `skip-worktree` is preserved
in a basic `git reset --mixed` scenario and update a failure-documenting
test from 19a0acc (t1092: test interesting sparse-checkout scenarios,
2021-01-23) with new expected behavior.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/reset.c                          | 14 ++++++++++++++
 t/t1092-sparse-checkout-compatibility.sh | 22 ++++++++--------------
 t/t7102-reset.sh                         | 17 +++++++++++++++++
 3 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index d3695ce43c4..e441b6601b9 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -25,6 +25,7 @@
 #include "cache-tree.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "dir.h"
 
 #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
 
@@ -130,6 +131,7 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 	int intent_to_add = *(int *)data;
 
 	for (i = 0; i < q->nr; i++) {
+		int pos;
 		struct diff_filespec *one = q->queue[i]->one;
 		int is_in_reset_tree = one->mode && !is_null_oid(&one->oid);
 		struct cache_entry *ce;
@@ -141,6 +143,18 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 
 		ce = make_cache_entry(&the_index, one->mode, &one->oid, one->path,
 				      0, 0);
+
+		/*
+		 * If the file 1) corresponds to an existing index entry with
+		 * skip-worktree set, or 2) does not exist in the index but is
+		 * outside the sparse checkout definition, add a skip-worktree bit
+		 * to the new index entry.
+		 */
+		pos = cache_name_pos(one->path, strlen(one->path));
+		if ((pos >= 0 && ce_skip_worktree(active_cache[pos])) ||
+		    (pos < 0 && !path_in_sparse_checkout(one->path, &the_index)))
+			ce->ce_flags |= CE_SKIP_WORKTREE;
+
 		if (!ce)
 			die(_("make_cache_entry failed for path '%s'"),
 			    one->path);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 886e78715fe..c7449afe965 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -459,26 +459,20 @@ test_expect_failure 'blame with pathspec outside sparse definition' '
 	test_all_match git blame deep/deeper2/deepest/a
 '
 
-# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
-# in this scenario, but it shouldn't.
-test_expect_failure 'checkout and reset (mixed)' '
+test_expect_success 'checkout and reset (mixed)' '
 	init_repos &&
 
 	test_all_match git checkout -b reset-test update-deep &&
 	test_all_match git reset deepest &&
-	test_all_match git reset update-folder1 &&
-	test_all_match git reset update-folder2
-'
-
-# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
-# in this scenario, but it shouldn't.
-test_expect_success 'checkout and reset (mixed) [sparse]' '
-	init_repos &&
 
-	test_sparse_match git checkout -b reset-test update-deep &&
-	test_sparse_match git reset deepest &&
+	# Because skip-worktree is preserved, resetting to update-folder1
+	# will show worktree changes for folder1/a in full-checkout, but not
+	# in sparse-checkout or sparse-index.
+	git -C full-checkout reset update-folder1 >full-checkout-out &&
 	test_sparse_match git reset update-folder1 &&
-	test_sparse_match git reset update-folder2
+	grep "M	folder1/a" full-checkout-out &&
+	! grep "M	folder1/a" sparse-checkout-out &&
+	run_on_sparse test_path_is_missing folder1
 '
 
 test_expect_success 'merge, cherry-pick, and rebase' '
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 601b2bf97f0..d05426062ec 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -472,6 +472,23 @@ test_expect_success '--mixed refreshes the index' '
 	test_cmp expect output
 '
 
+test_expect_success '--mixed preserves skip-worktree' '
+	echo 123 >>file2 &&
+	git add file2 &&
+	git update-index --skip-worktree file2 &&
+	git reset --mixed HEAD >output &&
+	test_must_be_empty output &&
+
+	cat >expect <<-\EOF &&
+	Unstaged changes after reset:
+	M	file2
+	EOF
+	git update-index --no-skip-worktree file2 &&
+	git add file2 &&
+	git reset --mixed HEAD >output &&
+	test_cmp expect output
+'
+
 test_expect_success 'resetting specific path that is unmerged' '
 	git rm --cached file2 &&
 	F1=$(git rev-parse HEAD:file1) &&
-- 
gitgitgadget

