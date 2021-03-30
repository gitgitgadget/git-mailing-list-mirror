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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6C8C4345A
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A815619F2
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhC3NLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbhC3NLX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 09:11:23 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D37AC061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:23 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so8390943wmj.1
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cRKY7qS/L3cDx5v3IYkxLha7hUdGoCFJcKbxvG3W5xM=;
        b=NyBLzCy2e4XQ2KUDg1SzwZR511ADEUlhW98nStixmywzeeWQ5svd3jbdlUvMqhsX2V
         NQeA1aH7DyFKZyrY1d2mWfKPgBqQ8SVRRyFtGLdiy9ilcrn8Tp7pqSLB09S6xYJXpycA
         PeqhPjKm/tfJykDMkaky7JsgmAdhm0ySdjoZzVLEVUKK/BbGsgVE8KVC6cLMgfBbur6Z
         ylT37e8KeKboAW6YLP5OD5H7iiriTnuqp9t9KLF46Po95n+vTUowB8PyOWjSdunEruru
         cz9wdX/PPbkBEEMQnpNXQmHv+7TAQT3rmkxPMqJXsgN3h9nZJFiQsnSxYzj4M83daBj5
         GBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cRKY7qS/L3cDx5v3IYkxLha7hUdGoCFJcKbxvG3W5xM=;
        b=mdTHAmzpIpTfsUXMVKsaKgSl4SY7/BRDXH+tENXr+sB68rj9fSOjYoobpZPatKT7Qs
         NJTxUeC+PYEVH6kj+cmLuEjHRlJbFZC74NOGk61BLMgkt3PhCFirWItOUCUwQYn/y9Ys
         /3toeZCcuwMC3fcdmDEJYeAjUtS7PrvzgF1uc8+rAQpZNjs9AjHWqF7/52u+TMFWWv9v
         QVlBOiUDxenMW47wUxcubSqRX+/pzUJ7MIqQSAw7utaKPqJndBbt71VbnKIetFS06dUd
         9Xz+wk2v8Y/DzgCCzAYVuDv5oond2uyHyLMEj821p9fGPrFjffxE2ZhwpyY8LsfpZKmX
         NvVg==
X-Gm-Message-State: AOAM530y9UoqNRkVfBMMo5NlWJFr4q7VVOVwda15NZUpGsJ5W4feB6CU
        /3gS9xXYma/aOVj1/TDie67CZdofFDk=
X-Google-Smtp-Source: ABdhPJzweIbqv9Fvlr3SFqJxlJ7I8JNAIjL0CpH2naobai00YtrxITwjrNlNXhtUTQwZYxnyuKQnpA==
X-Received: by 2002:a1c:bb0b:: with SMTP id l11mr4178650wmf.150.1617109881862;
        Tue, 30 Mar 2021 06:11:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c131sm3614305wma.37.2021.03.30.06.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:11:21 -0700 (PDT)
Message-Id: <9b068c458898edfc5267c06e37563f66fac148cf.1617109865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
References: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
        <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Mar 2021 13:11:03 +0000
Subject: [PATCH v5 20/21] sparse-index: loose integration with
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
index 472c5337de1b..12e6c453024f 100755
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

