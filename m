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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA11C433F7
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58CD619D3
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhCWNpK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhCWNor (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 09:44:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45703C061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k128so8686929wmk.4
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UI+eRyRGiD8kv9ARhAds+wlgsXLrX8hcYHQH8XYkEp8=;
        b=A0qo39YYt+YMnbVkQCix6p5jPYDqE8Y/iTTtA3G0TBwbe0PbPGXVjDbnfCRzngwOyR
         Pw9gIAOMoffGEDkxQ/tx3TLbzgaphNrMhnTvRLOu9romrPLbYLO+QaZFx0lb6Zt59R+h
         3kW+GGBklWfOEYPf5j8nqjwFvj70I60iFtP3Ebg9Wgk5mEhn9+owcWLD6sSbbBv8kQ8b
         tbqd6MAzIHqmVvyrxoYRF0H6OJlgbc1zHUbrVg4PaiSrfvmO0OkTXYvJkQpqHWxoxDtw
         oKdqOmc1hfJ4k9ZKghxJhBckyYIfL44wKx1UcTW3p8tsNioaz8QjZaMuOfckXzEx9pQL
         vX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UI+eRyRGiD8kv9ARhAds+wlgsXLrX8hcYHQH8XYkEp8=;
        b=svv0fsyDbrbi1qxEcbeX3bJ7KT8SN/XVrT22tElQX3Q0cQe69s3FIIZwp7y7KFMN66
         dvUHiVp/Nk2CuWWO4zqm/6oENSpMyvJCfggXZeZ+X9AfF9r0H4NRbpBdRw1mtoHLVjRB
         xV45Ee2/WMv0rpFNY59UXcid/Yxv3C3mdTXlNTnKYdDhvaje2rOXSg6cJL5DI9c2Bf21
         FGSapMNuftYGzXvCHhG3wX7C0FYxWaGgL4eHAWzV/NGRJTKsdnTvYHiPmBzYRazBMY56
         gs8gYP7q4yOBvqA5uGe7virYQRyuBHSbjQ5e/8vCtvb+tLW279JVUtEz6iEOiKLw8Txa
         nJXw==
X-Gm-Message-State: AOAM532ZSwCbRhVIxSD8sKUSD283W+YSw9+LGvUoz9ereRPtVNCipYKv
        Y3G+HI3LQKxhaKBFnsgUiPDZlKmmerQ=
X-Google-Smtp-Source: ABdhPJzm3/8ltfk2rBX3SHNJDpcfNdtxwlIc/0uL192bEIj4R7ExrVCkerWmhZzQN6+fojaKmqNamg==
X-Received: by 2002:a7b:c20d:: with SMTP id x13mr3541026wmi.32.1616507086047;
        Tue, 23 Mar 2021 06:44:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8sm2505354wmm.46.2021.03.23.06.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:44:45 -0700 (PDT)
Message-Id: <e7190376b806dacf05a20c9dda921d7e1b223b06.1616507069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
        <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Mar 2021 13:44:27 +0000
Subject: [PATCH v4 19/20] sparse-index: loose integration with
 cache_tree_verify()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The cache_tree_verify() method is run when GIT_TEST_CHECK_CACHE_TREE
is enabled, which it is by default in the test suite. The logic must
be adjusted for the presence of these directory entries.

For now, leave the test as a simple check for whether the directory
entry is sparse. Do not go any further until needed.

This allows us to re-enable GIT_TEST_CHECK_CACHE_TREE in
t1092-sparse-checkout-compatibility.sh. Further,
p2000-sparse-operations.sh uses the test suite and hence this is enabled
for all tests. We need to integrate with it before we run our
performance tests with a sparse-index.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache-tree.c                             | 19 +++++++++++++++++++
 t/t1092-sparse-checkout-compatibility.sh |  3 ---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 950a9615db8f..11bf1fcae6e1 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -808,6 +808,19 @@ int cache_tree_matches_traversal(struct cache_tree *root,
 	return 0;
 }
 
+static void verify_one_sparse(struct repository *r,
+			      struct index_state *istate,
+			      struct cache_tree *it,
+			      struct strbuf *path,
+			      int pos)
+{
+	struct cache_entry *ce = istate->cache[pos];
+
+	if (!S_ISSPARSEDIR(ce->ce_mode))
+		BUG("directory '%s' is present in index, but not sparse",
+		    path->buf);
+}
+
 static void verify_one(struct repository *r,
 		       struct index_state *istate,
 		       struct cache_tree *it,
@@ -830,6 +843,12 @@ static void verify_one(struct repository *r,
 
 	if (path->len) {
 		pos = index_name_pos(istate, path->buf, path->len);
+
+		if (pos >= 0) {
+			verify_one_sparse(r, istate, it, path, pos);
+			return;
+		}
+
 		pos = -pos - 1;
 	} else {
 		pos = 0;
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index f14dc48924d2..d97bf9b64527 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2,9 +2,6 @@
 
 test_description='compare full workdir to sparse workdir'
 
-# The verify_cache_tree() check is not sparse-aware (yet).
-# So, disable the check until that integration is complete.
-GIT_TEST_CHECK_CACHE_TREE=0
 GIT_TEST_SPLIT_INDEX=0
 GIT_TEST_SPARSE_INDEX=
 
-- 
gitgitgadget

