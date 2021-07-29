Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8D0C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 14:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 597B260EBC
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 14:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237783AbhG2OwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbhG2OwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 10:52:16 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80139C0613D5
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 07:52:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so1584279wms.2
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 07:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JZWrFzVBIfX/W7/g/PdIA7sxwEGWtK+913aI4fIL6IE=;
        b=ep+fqvl0tlWQDZgAqlVs6tke0ohRIHLDTw4lGT1xskW1dI0CMv1HBnFt4KnehDbxyZ
         XqgMJjxhbuQioORDdG6Pe4QKWCEstjALXXNJyvrcZSQjY1YcfVhVTGmHpZCvz0vQMRCZ
         tD0wDIyCytW2PMubnAbyiq9kixIo1Aa0ZNf5k18YrTZrUK19Oga6Nq1c7bSdkMzNiYg2
         OreJhakzdjfj5k+xTSWoAXQGm6SzPsG/Ej/hK8pa6ifOSfMTlNui1klW5+xUKim3S9CQ
         PLqnayk1EGaClpi6mL8LuInDNnFOQtUH/VSROJpoMHvamwHfSDP1KRshgQWnBs9xST01
         J2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JZWrFzVBIfX/W7/g/PdIA7sxwEGWtK+913aI4fIL6IE=;
        b=ggGNzuOLPBe3E0H6fYNurF9Xsp34KWDBre/q9j2VJardXetxEKVxaD4KHcRieWFYIP
         XycpkVMdlOPJh3fAjUpXGumH3luFPO2ugDx1zQbOyGLol32gFHAae07IaSCvO79mRr6J
         A7B5AKYUY040CCpiivzyWl3DZHYdxxppe5TmG4xqzTFZMWqSYTBRokbOA7B8brWz+NFm
         fb6KppwJ2DTY3IzGfD8QEnIwA6DnzRj0cuL2rf5MOSCKtSRK333R/6pxT7CiMvtVpFph
         6hq+HYChCW2o8PDc/1nyVbK+fevM/HF+BD0JutIIRN9MKwqIaXMy3+toXw6ACjb7EqOx
         siYg==
X-Gm-Message-State: AOAM532v+tlLPeYNoUKHwds9AxdKFmDBlwLE5xcX4lrH499Rp8I0OTeT
        9qQdhlW9EqhLDazt3xSAaTFkt0L14Mo=
X-Google-Smtp-Source: ABdhPJzbwEmbc9V9Xsd4jLdyuve6UbVXXMN6mEZZpU65mdkQ3VFNdSPh5h4LHtn/NiNEQQL1XRTTWA==
X-Received: by 2002:a1c:7419:: with SMTP id p25mr14463362wmc.160.1627570331149;
        Thu, 29 Jul 2021 07:52:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6sm3949428wmq.29.2021.07.29.07.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 07:52:10 -0700 (PDT)
Message-Id: <9fc4313c88959cb6eab43b2e34750b4ed889771a.1627570327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.999.v3.git.1627570327.gitgitgadget@gmail.com>
References: <pull.999.v2.git.1627312727.gitgitgadget@gmail.com>
        <pull.999.v3.git.1627570327.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jul 2021 14:52:05 +0000
Subject: [PATCH v3 3/5] pathspec: stop calling ensure_full_index
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

Reviewed-by: Elijah Newren <newren@gmail.com>
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
index 77343cb6d95..dee20db5bb1 100755
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
@@ -652,7 +649,9 @@ test_expect_success 'sparse-index is not expanded' '
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

