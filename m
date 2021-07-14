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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655F9C07E9C
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F24D613B7
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbhGNNPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 09:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239391AbhGNNPj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 09:15:39 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE11C061760
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l7so3158161wrv.7
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B8FGwEK6KjUlN9sU4yUJdCj10hN1ChnekZBvV7+eHZ0=;
        b=SBJGUYcIpGY7wiIO1iexxpVZoOPWmjmzqxPqEVQyfDzPYt4f15dRNNpoMPXN9rLJf4
         hiVqXhzkzbX9+v2ztISCcwgehqXul8PMhb2ePdLLrfb6cvuU3GdTSoAf4u0lmjFGycXm
         GGB0WQzsEENkPgO/99hqR9QgiyvfYLZG2M3TTwNmkAANayRvDkwJihlEey49rYYNZeiA
         lMfHPF/l9Uox1v0z5daPaoFAoJ5uF6xedhcqctSL5X1WCIrmZE1JIsUzjr8DlvWysvOJ
         8jbzCeIzVyv7UvnhAsyJ09pVi6cqME9LN9ocgDGtVn5fV4N2Su7X5lDXkXnFxPGwOsV7
         RatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B8FGwEK6KjUlN9sU4yUJdCj10hN1ChnekZBvV7+eHZ0=;
        b=ddGjg/n+bz55/qoiA9OY83etfs0FrGAQfzXJ5eBcN9d7GFuXYAwU+hMch1533cpBIs
         ZWZaWH+N9G+TxvmGIj72vI8U98Pm2vzSw8Z8wLkcyURNbQwBzMIF+HvWJzSLR9sg/VDI
         XzbnVA7+C0A9yg90uY7bYI4lmw8yP5TaAxfFrp7CYMsAIirsgZ3K6YEAWK6Yv/nczSy2
         X50x/uyQRJwB/PyiUL6/UmUPC69wyjhMvLKhSL8JVpf6Ue8rXpfRiOKQvp++PZ8bVyI/
         dJWaCpVaaBzwXraNSSOrGVROG+3Gj+NePwuQ1+IijbliO8ozxl1mf6oCFFEgk0tCYAPi
         WllQ==
X-Gm-Message-State: AOAM530/S+4+aGX8UNDOGXE7ZDbH+8FaX0VTKFMR/vbrJnINURUqKeel
        f8RbTFiGX37yUWrcKKz85OaGo68ZeKE=
X-Google-Smtp-Source: ABdhPJwKRv+ORgZcTNgl+FDmnujHuo5nc7eFRTo2uemBMTS+PXTzRbExNLQFVp4FBvN5d8fZ8VrkAw==
X-Received: by 2002:a5d:638b:: with SMTP id p11mr13071518wru.380.1626268365347;
        Wed, 14 Jul 2021 06:12:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s24sm2983077wra.33.2021.07.14.06.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 06:12:45 -0700 (PDT)
Message-Id: <4d06d97291105093c768a42e35b455d59ec791ab.1626268360.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
References: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
        <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 13:12:28 +0000
Subject: [PATCH v9 04/16] t1092: expand repository data shape
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de, Bagas Sanjaya <bagasdotme@gmail.com>,
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

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 42 ++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 87f1014a1c9..0e71a623619 100755
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
 		test_all_match git checkout $branch -- . &&
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

