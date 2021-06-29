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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BD8C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3159C61CD5
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhF2ByY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhF2ByP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:54:15 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3879C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p10-20020a05600c430ab02901df57d735f7so686653wme.3
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Yb2PnTjyl04QScNrCyVgl4dORDLdN86qbe9qCleSmYI=;
        b=dseMkZtjQ0fRuIJUEDWZeizu+ZfsZYyb18KRzujCu16TEROWX0GU0r7yO62zj4Gk1+
         GvVTm/UpVvwXy3yge5EAjVffo0p9AiQ6hft2xK+nQaq78sJrLMuxUDK3V+CjTph2+DRm
         1elYJO/TuuIEBYd1IQDxIF+qtS1MFFce3tsnxY9CUw0DZ+oRfmWD4zwZfBbOx9VKhY8w
         SnkV6g1J+8EVgR4vTadMxsr3A+AYAF8YZsKQvs8Q/IWA3y1hyBKr8MT3D9RRhanax5fm
         bCw0K+J8lefH08bLe6JqBdM8yGkmHla9zH+T5nZOJZD2PbKX5IWr2v206F+X7WJDmrx8
         dDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Yb2PnTjyl04QScNrCyVgl4dORDLdN86qbe9qCleSmYI=;
        b=TdrqjT5h642lNyFXS2EiUKtn0ho81aDykBYNo0+hOw1RnsNnauk4G+dZ4h75fvJx7B
         q8xjVxUJAYuSLBQnGB5OWVGx+EBwoF7cM9wS/1K0HQTpY+VLtMiw9qxSYiwq3HQWnFAv
         ktEmETKsn1Q5E63N3Ozr7z7aKMaKbGtvwEqbLPL2zoM1hjifgWoiFTYzwWaSy13dO7YD
         V1K/oxKwq64lFFqKR57ILIwQonf8OS5MuRutjTCTDV7lRl0Kg1KivRYwQ1DAEQyESJLb
         S6QS2Sk0fc7dOX8lu2MRKhJIYcVNtB/+5OmeExJpFwzi4uEjeMFehKV0FnxsXcUZWAjd
         j42A==
X-Gm-Message-State: AOAM5329AwXcEeMYs+F94Lw/DeZXdC4N6Q025Ru1mNgdzl1YLbZu/fVz
        Zd21xjh61FK4g6zrXNmhLyY784kP87M=
X-Google-Smtp-Source: ABdhPJxg7J8GGoFcOMUUe4jiSmRXYQ4xAEmLPeOpC3BgZ6nhgClO9MxdYzYdT7L2wd284Qnn55H/0Q==
X-Received: by 2002:a05:600c:2482:: with SMTP id 2mr29274474wms.67.1624931506284;
        Mon, 28 Jun 2021 18:51:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p7sm4115605wrr.68.2021.06.28.18.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 18:51:46 -0700 (PDT)
Message-Id: <44a940211b2fedc4a65b6dc2379e99c29cc5b64f.1624931502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
References: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
        <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 01:51:32 +0000
Subject: [PATCH v6 04/14] t1092: expand repository data shape
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

As more features integrate with the sparse-index feature, more and more
special cases arise that require different data shapes within the tree
structure of the repository in order to demonstrate those cases.

Add several interesting special cases all at once instead of sprinkling
them across several commits. The interesting cases being added here are:

* Add sparse-directory entries on both sides of directories within the
  sparse-checkout definition.

* Add directories outside the sparse-checkout definition who have only
  one entry and are the first entry of a directory with multiple
  entries.

Later tests will take advantage of these shapes, but they also deepen
the tests that already exist.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 39 ++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index ebbba044f77..4a7b48e8d3f 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -17,7 +17,7 @@ test_expect_success 'setup' '
 		echo "after folder1" >g &&
 		echo "after x" >z &&
 		mkdir folder1 folder2 deep x &&
-		mkdir deep/deeper1 deep/deeper2 &&
+		mkdir deep/deeper1 deep/deeper2 deep/before deep/later &&
 		mkdir deep/deeper1/deepest &&
 		echo "after deeper1" >deep/e &&
 		echo "after deepest" >deep/deeper1/e &&
@@ -25,10 +25,20 @@ test_expect_success 'setup' '
 		cp a folder2 &&
 		cp a x &&
 		cp a deep &&
+		cp a deep/before &&
 		cp a deep/deeper1 &&
 		cp a deep/deeper2 &&
+		cp a deep/later &&
 		cp a deep/deeper1/deepest &&
 		cp -r deep/deeper1/deepest deep/deeper2 &&
+		mkdir deep/deeper1/0 &&
+		mkdir deep/deeper1/0/0 &&
+		touch deep/deeper1/0/1 &&
+		touch deep/deeper1/0/0/0 &&
+		cp -r deep/deeper1/0 folder1 &&
+		cp -r deep/deeper1/0 folder2 &&
+		echo >>folder1/0/0/0 &&
+		echo >>folder2/0/1 &&
 		git add . &&
 		git commit -m "initial commit" &&
 		git checkout -b base &&
@@ -56,11 +66,17 @@ test_expect_success 'setup' '
 		mv folder1/a folder2/b &&
 		mv folder1/larger-content folder2/edited-content &&
 		echo >>folder2/edited-content &&
+		echo >>folder2/0/1 &&
+		echo stuff >>deep/deeper1/a &&
 		git add . &&
 		git commit -m "rename folder1/... to folder2/..." &&
 
 		git checkout -b rename-out-to-in rename-base &&
 		mv folder1/a deep/deeper1/b &&
+		echo more stuff >>deep/deeper1/a &&
+		rm folder2/0/1 &&
+		mkdir folder2/0/1 &&
+		echo >>folder2/0/1/1 &&
 		mv folder1/larger-content deep/deeper1/edited-content &&
 		echo >>deep/deeper1/edited-content &&
 		git add . &&
@@ -68,6 +84,9 @@ test_expect_success 'setup' '
 
 		git checkout -b rename-in-to-out rename-base &&
 		mv deep/deeper1/a folder1/b &&
+		echo >>folder2/0/1 &&
+		rm -rf folder1/0/0 &&
+		echo >>folder1/0/0 &&
 		mv deep/deeper1/larger-content folder1/edited-content &&
 		echo >>folder1/edited-content &&
 		git add . &&
@@ -262,13 +281,29 @@ test_expect_success 'diff --staged' '
 	test_all_match git diff --staged
 '
 
-test_expect_success 'diff with renames' '
+test_expect_success 'diff with renames and conflicts' '
 	init_repos &&
 
 	for branch in rename-out-to-out rename-out-to-in rename-in-to-out
 	do
 		test_all_match git checkout rename-base &&
 		test_all_match git checkout $branch -- .&&
+		test_all_match git status --porcelain=v2 &&
+		test_all_match git diff --staged --no-renames &&
+		test_all_match git diff --staged --find-renames || return 1
+	done
+'
+
+test_expect_success 'diff with directory/file conflicts' '
+	init_repos &&
+
+	for branch in rename-out-to-out rename-out-to-in rename-in-to-out
+	do
+		git -C full-checkout reset --hard &&
+		test_sparse_match git reset --hard &&
+		test_all_match git checkout $branch &&
+		test_all_match git checkout rename-base -- . &&
+		test_all_match git status --porcelain=v2 &&
 		test_all_match git diff --staged --no-renames &&
 		test_all_match git diff --staged --find-renames || return 1
 	done
-- 
gitgitgadget

