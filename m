Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F11C4320E
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 15:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3212E60F55
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 15:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbhGZOin (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 10:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbhGZOiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 10:38:25 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0F7C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 08:18:53 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id d131-20020a1c1d890000b02902516717f562so230886wmd.3
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 08:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aU4ldpjK0Tx5Ez2WDHqvYUwk/EaPbybiuDakOe7VSrs=;
        b=nQYrgKcq1LmqnjCgTmeJIJI1gFjQVO6r0v+26iknW/M6ZIa4VNRIIlCJZ+NMHVYeOF
         MSg7FqVM6nRH8fXqGcxscUbdEgbUKp7KKIZjsPN2g6HF/p+l89pMT/wRDLM5Q95Z8wqR
         QAQemZvf8ft3W+QNVEgUzOeG1a9Q6y6ItCLts2KW/ondoFpnoVjxfPPxkj+qzwukcQjO
         fHVojA7GEnJ+k8I0a1w4m8kQDAK5XbKotXwU3yujlynhuOEKkuqgchHsn3gyq8U2kVc2
         dse0xEzsGPaj8EGCbY3W71jsCi24wcE1nXJ3s1y1uzV0dYw5bjx/ZKJ77YVuLuYCzxYU
         i5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aU4ldpjK0Tx5Ez2WDHqvYUwk/EaPbybiuDakOe7VSrs=;
        b=i5oQIAk+G2OA7i4jA7KaTMaHj+Nd0fBkqtDzo80Gzg8vWf0QbqIQR/lLkxnQKLUVZS
         SWVGGkpJQ+vTM32HmTNJ1rADDArcRUCrYYPhR1rv/6Y6eJlT8/o9/rMMTDAWe6NeP7sy
         2c5b4Wy+tUx0vqSWBYwJHM9Voo7XNIPG1ZtgEKI2GtXW9TbOvdRDXo3psfwl9hR77lbn
         R5vi+k72XzDDovzpYLSfgnR4hCYEHFFscSotFpkUgUg7A1ydFS1U6v6fBPNWfwQxYT/z
         BpZIJUuf6zGRQeMdZTvYPTnsv+uwaWGX+6rkzlxjGjpbw9J+IN3j/ni0ROE/iyqsBPfG
         lXlw==
X-Gm-Message-State: AOAM530PXDo+EsZV/S9x2QuuzvZeEBgpCPF7ASu7s1HrkZqeXZ4PU09r
        +lPQID8X7kS3FIvHg67n6rua0AFXrS0=
X-Google-Smtp-Source: ABdhPJwHUrTUVB2ZJ2WgfRDsbu62e4M0DacPjd+MO3MhiNoDrNjd6WpuXXo4REg+sZlMvhmpIupnTw==
X-Received: by 2002:a1c:a510:: with SMTP id o16mr14824010wme.176.1627312731711;
        Mon, 26 Jul 2021 08:18:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 125sm12939419wmb.12.2021.07.26.08.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 08:18:51 -0700 (PDT)
Message-Id: <2ae91e0af29bcc5ba118cba4ba051deefd3b9764.1627312727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.999.v2.git.1627312727.gitgitgadget@gmail.com>
References: <pull.999.git.1626901619.gitgitgadget@gmail.com>
        <pull.999.v2.git.1627312727.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jul 2021 15:18:45 +0000
Subject: [PATCH v2 3/5] pathspec: stop calling ensure_full_index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The add_pathspec_matches_against_index() focuses on matching a pathspec
to file entries in the index. This already works correctly for its only
use: checking if untracked files exist in the index.

The compatibility checks in t1092 already test that 'git add <dir>'
works for a directory outside of the sparse cone. That provides coverage
for removing this guard.

This finalizes our ability to run 'git add .' without expanding a sparse
index to a full one. This is evidenced by an update to t1092 and by
these performance numbers for p2000-sparse-operations.sh:

Test                                    HEAD~1            HEAD
--------------------------------------------------------------------------------
2000.10: git add . (full-index-v3)      0.37(0.28+0.07)   0.36(0.27+0.06) -2.7%
2000.11: git add . (full-index-v4)      0.33(0.26+0.06)   0.32(0.28+0.05) -3.0%
2000.12: git add . (sparse-index-v3)    0.57(0.53+0.07)   0.06(0.06+0.07) -89.5%
2000.13: git add . (sparse-index-v4)    0.57(0.53+0.07)   0.05(0.03+0.09) -91.2%

While the ~90% improvement is shown by the test results, it is worth
noting that expanding the sparse index was adding overhead in previous
commits. Comparing to the full index case, we see the performance go
from 0.33s to 0.05s, an 85% improvement.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 pathspec.c                               | 2 --
 t/t1092-sparse-checkout-compatibility.sh | 7 +++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 08f8d3eedc3..44306fdaca2 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -37,8 +37,6 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 			num_unmatched++;
 	if (!num_unmatched)
 		return;
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
 		if (sw_action == PS_IGNORE_SKIP_WORKTREE && ce_skip_worktree(ce))
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 19d38f18ed6..50dce0e0f99 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -322,9 +322,6 @@ test_expect_success 'commit including unstaged changes' '
 test_expect_success 'status/add: outside sparse cone' '
 	init_repos &&
 
-	# adding a "missing" file outside the cone should fail
-	test_sparse_match test_must_fail git add folder1/a &&
-
 	# folder1 is at HEAD, but outside the sparse cone
 	run_on_sparse mkdir folder1 &&
 	cp initial-repo/folder1/a sparse-checkout/folder1/a &&
@@ -647,7 +644,9 @@ test_expect_success 'sparse-index is not expanded' '
 	echo >>sparse-index/README.md &&
 	ensure_not_expanded add -A &&
 	echo >>sparse-index/extra.txt &&
-	ensure_not_expanded add extra.txt
+	ensure_not_expanded add extra.txt &&
+	echo >>sparse-index/untracked.txt &&
+	ensure_not_expanded add .
 '
 
 # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
-- 
gitgitgadget

