Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213C2C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 19:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbhLHTnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 14:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239704AbhLHTnd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 14:43:33 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C22AC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 11:40:01 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso4954245wmr.4
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 11:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qC7INu0Mmhl0d/PVdY5sWbIdLLIsuB827d1moBqyaAU=;
        b=nIXTQIxJ9RiPNOietAlR1/oNduWUdObDNiR7tgAGfqktH//5okD73MAkYbVD2dI/bV
         JGIAl8gdoGAuNSl1irMsv238YeSKd/D+xgIKCACC4iPzX4EompymkFl0tpGdZVsctLeF
         NnV0SL0zLGGN6jIO1SdZCW9rqafMRdvwIxUeFFb0GRHkaZKQ9n/rpEdtNUKJCJbKcfrQ
         /sjL2WEqBwYomrrYG+UKTYCny9A2HqklDsteclk/XxRykRUFtm9eo5Vlssmq2XHogrvq
         VPZnYe3psCnwpaMShpIv0ORT46S+PLS8iU3or0cuRq80lSODV8dD8lMFobNRLZ7zbjWO
         ieSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qC7INu0Mmhl0d/PVdY5sWbIdLLIsuB827d1moBqyaAU=;
        b=nBVtf81qtHinKVUqNAH/sdUK7OZDh2UTJMKjjYiamt5IFap7pLoVHCQi+KRcUTeljL
         RKHN04zHUC9Phmfc1SMjvGf4rURCPzeLQ/qVcjPEahiHFGcbxqVKHwPck9K4k7wVDbma
         d9crghP4hHyJHOf8EzFORprz74/SCZqTlA6ulIkmMl0KQ4f7JRuNL5ldG7Tk2NY9MhQK
         V7t1qCoOywPOHr+dDUFHLV/EwQbs9bO/YxsZ4ZUeCmYPkdMYw7m7hwet3uDB42t3UBeD
         YyYB5Y7yqRQuarQvSTqRMxrG90MsM47c6iGiGqTBWKrQnsPbrvr1DPoqsC1aHlPgYFD1
         jKiw==
X-Gm-Message-State: AOAM533p7/GfTwgiWAWrNa4a/jKuYMGTozdsRgU6CCCajC39Ge0gC4bT
        baz3DF2pPd1o9zu0XVj/pPZUCRZjLvg=
X-Google-Smtp-Source: ABdhPJy8YfMOdeVTH2sL23akL8rGgeFW6aVCKtk7gUsCfyfzKK1C/DaImAc6JtWusXgqdm0p/rWcAQ==
X-Received: by 2002:a1c:23d2:: with SMTP id j201mr1001965wmj.76.1638992399777;
        Wed, 08 Dec 2021 11:39:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p19sm4060650wmq.4.2021.12.08.11.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 11:39:59 -0800 (PST)
Message-Id: <5ffae2a03ae3d00a1f128d7cf2a397081055a2fe.1638992396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
        <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 19:39:53 +0000
Subject: [PATCH v2 3/5] t1092: replace 'read-cache --table' with 'ls-files
 --sparse'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Now that 'git ls-files --sparse' exists, we can use it to verify the
state of a sparse index instead of 'test-tool read-cache table'. Replace
these usages within t1092-sparse-checkout-compatibility.sh.

The important changes are due to the different output format. We need to
use the '--stage' output to get a file mode and OID, but it also
includes a stage value and drops the object type. This leads to some
differences in how we handle looking for specific entries.

Some places where we previously looked for no 'tree' entries, we can
instead directly compare the output across the repository with a sparse
index and the one without.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 29 +++++++++++-------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index bf2c6b169b9..4a6832ea3c5 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -200,45 +200,42 @@ test_sparse_unstaged () {
 test_expect_success 'sparse-index contents' '
 	init_repos &&
 
-	test-tool -C sparse-index read-cache --table >cache &&
+	git -C sparse-index ls-files --sparse --stage >cache &&
 	for dir in folder1 folder2 x
 	do
 		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
-		grep "040000 tree $TREE	$dir/" cache \
+		grep "040000 $TREE 0	$dir/" cache \
 			|| return 1
 	done &&
 
 	git -C sparse-index sparse-checkout set folder1 &&
 
-	test-tool -C sparse-index read-cache --table >cache &&
+	git -C sparse-index ls-files --sparse --stage >cache &&
 	for dir in deep folder2 x
 	do
 		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
-		grep "040000 tree $TREE	$dir/" cache \
+		grep "040000 $TREE 0	$dir/" cache \
 			|| return 1
 	done &&
 
 	git -C sparse-index sparse-checkout set deep/deeper1 &&
 
-	test-tool -C sparse-index read-cache --table >cache &&
+	git -C sparse-index ls-files --sparse --stage >cache &&
 	for dir in deep/deeper2 folder1 folder2 x
 	do
 		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
-		grep "040000 tree $TREE	$dir/" cache \
+		grep "040000 $TREE 0	$dir/" cache \
 			|| return 1
 	done &&
 
 	# Disabling the sparse-index removes tree entries with full ones
 	git -C sparse-index sparse-checkout init --no-sparse-index &&
-
-	test-tool -C sparse-index read-cache --table >cache &&
-	! grep "040000 tree" cache &&
-	test_sparse_match test-tool read-cache --table
+	test_sparse_match git ls-files --stage --sparse
 '
 
 test_expect_success 'expanded in-memory index matches full index' '
 	init_repos &&
-	test_sparse_match test-tool read-cache --expand --table
+	test_sparse_match git ls-files --stage
 '
 
 test_expect_success 'status with options' '
@@ -787,9 +784,9 @@ test_expect_success 'submodule handling' '
 
 	# having a submodule prevents "modules" from collapse
 	test_sparse_match git sparse-checkout set deep/deeper1 &&
-	test-tool -C sparse-index read-cache --table >cache &&
-	grep "100644 blob .*	modules/a" cache &&
-	grep "160000 commit $(git -C initial-repo rev-parse HEAD)	modules/sub" cache
+	git -C sparse-index ls-files --sparse --stage >cache &&
+	grep "100644 .*	modules/a" cache &&
+	grep "160000 $(git -C initial-repo rev-parse HEAD) 0	modules/sub" cache
 '
 
 # When working with a sparse index, some commands will need to expand the
@@ -1079,13 +1076,13 @@ test_expect_success 'reset mixed and checkout orphan' '
 	# the sparse checkouts skip "adding" the other side of
 	# the conflict.
 	test_sparse_match git reset --mixed HEAD~1 &&
-	test_sparse_match test-tool read-cache --table --expand &&
+	test_sparse_match git ls-files --stage &&
 	test_sparse_match git status --porcelain=v2 &&
 
 	# At this point, sparse-checkouts behave differently
 	# from the full-checkout.
 	test_sparse_match git checkout --orphan new-branch &&
-	test_sparse_match test-tool read-cache --table --expand &&
+	test_sparse_match git ls-files --stage &&
 	test_sparse_match git status --porcelain=v2
 '
 
-- 
gitgitgadget

