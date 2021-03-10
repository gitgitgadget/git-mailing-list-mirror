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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC4CC43332
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB59664FD6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhCJTby (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbhCJTbU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:31:20 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B37C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:20 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so11810215wml.2
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5pUTXKGQuSdTT7ILEy7EmDD3wWlGK1ztMU7gpypslrM=;
        b=Gxa9T7G4XdswJJcpfAlLNaJhmQO9wt8f551DCwNsx0QNuKm0jpeWrLoGvQXuXD+h4d
         AsNSrinRZA+Ia/YXoycbWTkeyClusCS7Bv3AnmoW2O6XCWch6dTZwpEl5z4WCkrOgeHh
         ywbHejKEO/vQ6ecDGkgRrq4cOvbe5x33mEUPCZ2C+rQj8P6JMHv8xCHdBzG1t1GZX2nM
         JiuvqrJgVaqkj573igBmEJF9YH6TP2TsfeFDNh+gqILHu88//E2k4NpV13G6dxwpMruq
         pR6YjTTjY3TjnaKoC3hgF1woO+LbSADqu3l4vXTtXda/4led2s5EZXtrGeUXiFFJ0SvA
         /jZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5pUTXKGQuSdTT7ILEy7EmDD3wWlGK1ztMU7gpypslrM=;
        b=NYk8GkgjDNFQU88FAIXEJ7r4DMb8UCU5wDe22MxYBmZXnsCkWcur2ainAD4wvlcN+9
         N0iDZRfYN1rXhO7g8S55KLsq+xRMowsLn6PJm7C9fVwDuY+az1ci5WF2XvAxdJ+BOg/m
         cC+fCk8s8b654VkqlRgDM3M7YdMBT3iRSQZYtK0r1EB1c/hqo+BfB3bK1UszXIHpaQuB
         ApCgZjxegFumMUMNa0DuBYp7t1udh9Vxb4uwxrMx1ap8Z6AifKKRWO75BSIqlpRxb4o9
         PoFuMM3sii22UVzghrKJN9QQ1isJYx92Oa+zPCrwBYYdvZKOWvJNhL953oE9ehrf9tKz
         Z/PA==
X-Gm-Message-State: AOAM531dk4cj63TE2lvB6eMSUTyEf5Lm9K7+cMdcRwdcRWa9JaeKwslE
        aNsjpuBcFmFq1UKatemaWvgLfM9/32w=
X-Google-Smtp-Source: ABdhPJyM+CcI7MXm2vwmJ22UuVZIRdOCwadzRgFoxDO+nzjADTBbDBPDFMhd5+StvN2IsHMXBrdgQg==
X-Received: by 2002:a1c:cc04:: with SMTP id h4mr4753475wmb.142.1615404678974;
        Wed, 10 Mar 2021 11:31:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l4sm321856wrt.60.2021.03.10.11.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:31:18 -0800 (PST)
Message-Id: <07f34e80609a39f7cf52d21cc8fe0d83ee728fb0.1615404665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
        <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Mar 2021 19:31:02 +0000
Subject: [PATCH v2 19/20] sparse-index: loose integration with
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
        Derrick Stolee <derrickstolee@github.com>,
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

