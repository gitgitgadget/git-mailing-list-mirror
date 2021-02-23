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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABC4C433E6
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58DE064EBB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbhBWUSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbhBWUQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 15:16:29 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3DEC061222
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:43 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c7so7109654wru.8
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5pUTXKGQuSdTT7ILEy7EmDD3wWlGK1ztMU7gpypslrM=;
        b=PSiGGkHr6jOgQguqVsr2GgYm01+2XBkyZXKJeOnv0nDrI5JZu0qukRzfVsdqVXiUCE
         W+CwMgYZCSg9J6DF++2aR9Tn/ZbIQAiNJ2ajkKzkHjUAwewjuwpEOE5z6148xUDtwXlz
         vyDfx90wL9xVYnIw7r0NhIwTGu6wAHICNnn4a079lkps7JfCbItUbqH0RdrB2P9Vxq+A
         SDWQBaH7zKBRkupP0tAPGCNoP8Rrkh7nYIMi3K5k+hMB2FnDB2KwqKPZyFOpvFqxPgS5
         +e9heEsXotl2HNtcQirpun4yC2pVe2q4RypWDotzTPeGdY9rnjYzGkSYXXavS9K3tzBH
         nhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5pUTXKGQuSdTT7ILEy7EmDD3wWlGK1ztMU7gpypslrM=;
        b=aQdA3VJSNI4afCRPrGYs0NmSV6gG7Ib3zWTNBMGDzuFXpsVokaPrxUg8sW5JqQrDPt
         v9AIbVluAxY4pw7+CNWxbaKl6KE9PvGUGrF0+Sz7wEEuyxDJMvrHJO2ze3qKIa3YxRaM
         053LFkqIARqEC4DMFhIfzwgamzNts+PX32bLkPqBP9jUgETVDxyCheMmPM9HKai6fdh1
         FN2SsIrP1wY3aBghWqmDfu3wo3bn5xHq8QE4bUy/3N6QXycZ7haL8EY/DDZ+Zl/IOEzb
         FtNuk7QLfcJzfB6GdBFeXOgM7sVLZU/YYh9fCYWqm3kKevmEy/oTpchRhKLuqsu5jLXK
         qsGA==
X-Gm-Message-State: AOAM530AuMfnC3KCJny8BVwkwQogqyUYkL+UhTnbLHZw21M8C5GZjIG4
        sPCKkS2GEJVRQlIJSLTeaBYdfmtdghw=
X-Google-Smtp-Source: ABdhPJzJ5tLcu869lQTb+coCfYIBs2c2aq0hkEMWWyQvYEYlKnCVJbel7nGqXtHZ132zwQmWU138yQ==
X-Received: by 2002:a5d:4848:: with SMTP id n8mr11501033wrs.241.1614111282492;
        Tue, 23 Feb 2021 12:14:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d29sm27203649wra.51.2021.02.23.12.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 12:14:42 -0800 (PST)
Message-Id: <2be4981fe6987db02b7694b099b1026f2a6defba.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.git.1614111270.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 20:14:28 +0000
Subject: [PATCH 19/20] sparse-index: loose integration with
 cache_tree_verify()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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
 t/t1092-sparse-checkout-compatibility.sh |  1 -
 2 files changed, 19 insertions(+), 1 deletion(-)

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
index 9c2bc4d25f66..c2624176c2e0 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2,7 +2,6 @@
 
 test_description='compare full workdir to sparse workdir'
 
-GIT_TEST_CHECK_CACHE_TREE=0
 GIT_TEST_SPLIT_INDEX=0
 GIT_TEST_SPARSE_INDEX=
 
-- 
gitgitgadget

