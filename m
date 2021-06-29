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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D918C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1248F61CE5
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhF2CH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhF2CH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:07:26 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF324C061767
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:04:58 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u8so10418309wrq.8
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uPipHskTT++x5mo1IyP2Wqx3KuP5iqrfQ6d15OcP7qY=;
        b=ptfjLTULbA26FFJAJOPHu3oSsPNug5vZUwp2gSBuLn1Vj2fmg0WK7kmVXvc8sky+ab
         eUXwB/tZiW9UNEiX+m3woW1rUhj1O2nopBmVVsi5xM/Dta8H77xnA2aacIqpb0ZhknXg
         ZvmeDuGhcp4Nu19Bc4ySEiMJed9DvvMYGbkp623gKKhjhZuTraAfW+vTXvd4XJwxoR5y
         xbFulUrSh6fJhbg5dnzmZ0OkDbhFIbRg0llY+K78E5uixsLS/CIUqFgE8KiTRQewVhfu
         3rdE4eTaXA5T001ioz38HkQEU1gaxcw8DDb5yGfLh0gtAOT/IQgavQrua9yp25C5vLHZ
         k7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uPipHskTT++x5mo1IyP2Wqx3KuP5iqrfQ6d15OcP7qY=;
        b=N78DKi0my82LBt8bcTJKaCB8nOMdwNJtQ5j5LjWGtbp0XDndVF6TLjGxJR81jElUaV
         M/yrkb6UULw8PDRde2SIpvBEST5K8/g3XKc3fWQJl3cDxG08IE8IKXdwekrrIpLBmDeu
         oqfb3hE8cADE1WvZbogBl51kSx5KtqiRPPcm6I4bOok7gZILKIoVg68csLvTsmyY84WJ
         9fXl3lTanBTVE1IFU/BM6fTVmRkG6zE1BO7L0ee65Lfy+e+YPfG5lcUKgwYavxrbdmQi
         hGLIMyntJO03FZPfUa5Wq6oIPBbIc5rgwjlHfrqjgWHHw+AN056nlkc+KP9yIYl1qI+Y
         /E0w==
X-Gm-Message-State: AOAM5327CTViEwG/AIPax3YnhUzp4e5fL0P7FObkEi59pwEMHTeSL7D/
        bRtFf3sCs/InYgG8TgwQWGd7cyIZi1k=
X-Google-Smtp-Source: ABdhPJwjRNw4bH+S8U4HYcIQ36DAiS9NSGu4CTOHO5JSNoHbncZjPx4JA2kuAYAGymlc+l5/xcGK1w==
X-Received: by 2002:a5d:5919:: with SMTP id v25mr29386377wrd.319.1624932297291;
        Mon, 28 Jun 2021 19:04:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u12sm16693710wrr.40.2021.06.28.19.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 19:04:57 -0700 (PDT)
Message-Id: <e10fa11cfdb79071099e41c5f4328590e535ac1d.1624932293.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
        <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 02:04:41 +0000
Subject: [PATCH v7 04/16] t1092: expand repository data shape
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

* Add filenames adjacent to a sparse directory entry that sort before
  and after the trailing slash.

Later tests will take advantage of these shapes, but they also deepen
the tests that already exist.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 42 ++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index ebbba044f77..363d605c209 100755
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
@@ -25,10 +25,23 @@ test_expect_success 'setup' '
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
+		>folder1- &&
+		>folder1.x &&
+		>folder10 &&
+		cp -r deep/deeper1/0 folder1 &&
+		cp -r deep/deeper1/0 folder2 &&
+		echo >>folder1/0/0/0 &&
+		echo >>folder2/0/1 &&
 		git add . &&
 		git commit -m "initial commit" &&
 		git checkout -b base &&
@@ -56,11 +69,17 @@ test_expect_success 'setup' '
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
@@ -68,6 +87,9 @@ test_expect_success 'setup' '
 
 		git checkout -b rename-in-to-out rename-base &&
 		mv deep/deeper1/a folder1/b &&
+		echo >>folder2/0/1 &&
+		rm -rf folder1/0/0 &&
+		echo >>folder1/0/0 &&
 		mv deep/deeper1/larger-content folder1/edited-content &&
 		echo >>folder1/edited-content &&
 		git add . &&
@@ -262,13 +284,29 @@ test_expect_success 'diff --staged' '
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

