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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02D0C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9431561C99
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhF2CHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhF2CH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:07:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C17C061766
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:05:02 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j11-20020a05600c1c0bb02901e23d4c0977so739991wms.0
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y16povR6Bo5qH6HHskkHnqLCNjqmRRpyNxlrBNS/WXw=;
        b=hEqou1q55CYtfOp6uHsZASUFRnMG3511eRpDOEc5IjMOIvkaCyY+bLlH4jrmX4czyg
         E4ZamItGTNlF2Im0URtfL/hSg7IIQinpqcGwSpwAVznLmznOwMrKTcSC/102BGsbiKxa
         GtpSLAt1kuDjvlfwCPs2GKG2NkCrnMj7neQy2ELAzAsKqY+TbprN8CTOa1v9rZHhUsip
         ctb+gpm4itEH1LII+1441GBvsL/3DcqY1LeRjlmYLQpGdtwZhkRdaEYemsoF7Q3iYB2P
         iM7zAxXOIP2I9p+zg2SW3i1Ij4iHaiqhC5IZsd0kWw0hv88M/X2J0Flo97yeKxh8EAJp
         zIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y16povR6Bo5qH6HHskkHnqLCNjqmRRpyNxlrBNS/WXw=;
        b=Z3B81TQ2VFt/zdg5Xs4wwIJ7Vi9Gr+lYvx00sirxdcW0M6KWGEoKKl8Lcjor6oYNMN
         OTV5VTloU8KZM0YXjZ7WBbqeluAlnTj+zuWP9wejYZHUC8yr/ZLBFVcy+9sYepg94X1c
         pcp/OCdkZkUqVb2DPKqjMRvLALrhDI8CmLu/ajJJz5SqLkaX3wAeol6lm6R+pGSatEz3
         vpnBxhzyX8LroAXdO/dyyWAxrKpB3i0S7N4Q8pYOj7ouSZvHB3VTkKIL3qGdfyWIgPRI
         mZ43oj9vKsOZYgivpxtec/j5FNUzoXOvBg27x0FOSH4bhncUxZSSeRw1fNnPi2D7jBXc
         RkMA==
X-Gm-Message-State: AOAM532Sr6EyCql2XRWq1kxkzOJr1JyijCUsytrKJgaAsYxlzNOMNGGO
        qv4ztLgNzVn/Du0/piLY1g5j6xAE/mU=
X-Google-Smtp-Source: ABdhPJyj7nqVqGo9U2nQQVm83U5LwxeJYx4gpY2qKf8Kqv20r+m01m5uzakzt+piHfbhihSQZ1vxdA==
X-Received: by 2002:a05:600c:3b28:: with SMTP id m40mr29151338wms.99.1624932300788;
        Mon, 28 Jun 2021 19:05:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10sm8409496wmb.40.2021.06.28.19.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 19:05:00 -0700 (PDT)
Message-Id: <9f31c691af6780f0ea48bdcb5ff6d56b628f1a81.1624932294.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
        <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 02:04:47 +0000
Subject: [PATCH v7 10/16] unpack-trees: handle dir/file conflict of sparse
 entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 25 ++++++++++++++++++++++--
 unpack-trees.c                           |  5 ++++-
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 3f61e5686b5..4e6446e7545 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -95,6 +95,19 @@ test_expect_success 'setup' '
 		git add . &&
 		git commit -m "rename deep/deeper1/... to folder1/..." &&
 
+		git checkout -b df-conflict base &&
+		rm -rf folder1 &&
+		echo content >folder1 &&
+		git add . &&
+		git commit -m df &&
+
+		git checkout -b fd-conflict base &&
+		rm a &&
+		mkdir a &&
+		echo content >a/a &&
+		git add . &&
+		git commit -m fd &&
+
 		git checkout -b deepest base &&
 		echo "updated deepest" >deep/deeper1/deepest/a &&
 		git commit -a -m "update deepest" &&
@@ -325,7 +338,11 @@ test_expect_success 'diff --staged' '
 test_expect_success 'diff with renames and conflicts' '
 	init_repos &&
 
-	for branch in rename-out-to-out rename-out-to-in rename-in-to-out
+	for branch in rename-out-to-out \
+		      rename-out-to-in \
+		      rename-in-to-out \
+		      df-conflict \
+		      fd-conflict
 	do
 		test_all_match git checkout rename-base &&
 		test_all_match git checkout $branch -- .&&
@@ -338,7 +355,11 @@ test_expect_success 'diff with renames and conflicts' '
 test_expect_success 'diff with directory/file conflicts' '
 	init_repos &&
 
-	for branch in rename-out-to-out rename-out-to-in rename-in-to-out
+	for branch in rename-out-to-out \
+		      rename-out-to-in \
+		      rename-in-to-out \
+		      df-conflict \
+		      fd-conflict
 	do
 		git -C full-checkout reset --hard &&
 		test_sparse_match git reset --hard &&
diff --git a/unpack-trees.c b/unpack-trees.c
index d141dffbd94..e63b2dcacbc 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2617,7 +2617,10 @@ int twoway_merge(const struct cache_entry * const *src,
 			 same(current, oldtree) && !same(current, newtree)) {
 			/* 20 or 21 */
 			return merged_entry(newtree, current, o);
-		} else
+		} else if (current && !oldtree && newtree &&
+			   S_ISSPARSEDIR(current->ce_mode) != S_ISSPARSEDIR(newtree->ce_mode))
+			return merged_entry(newtree, current, o);
+		else
 			return reject_merge(current, o);
 	}
 	else if (newtree) {
-- 
gitgitgadget

