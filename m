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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F87C07E9A
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F0F061206
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbhGLR6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbhGLR6u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:58:50 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ABCC0613E5
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r11so21535396wro.9
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s5F2jg1ozuHBE0uTDnrtvT8FkKzIZbq7avOJxWE7f/I=;
        b=qECFr/xvwoEvgS839ulEV+btGNnfl+CJhaI6R8PtCjw9cKtI7qNuMJKRdsj0yIaunU
         gdqcZ4ySjVx5/LF5fJu1xkZolOEXP5ZPDChNd9+Zd9SGqv6X4fsTR507XTz+VVTj8uSg
         ulNbZjZ6N1iVM6Ieyz1JLrrbkqT9M8NsbWGUTHnDX/INT1Zah55dAZq8d09X4F5U86iz
         1jox+JHEioMGXFzJUsDpq+U/5mBKKwwTYXz6J+9+ZJ/aNqsthdXYuKUsOUk9xR1Z0Hk4
         Yt7FtpnxO/ja6fFZ4z/TFkpCIdYBFsDV/sAHDg5/4sjJR/6wp3uIVGJEak7e4orC/+BT
         GdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s5F2jg1ozuHBE0uTDnrtvT8FkKzIZbq7avOJxWE7f/I=;
        b=snp9DK/D0VQTVhNfmThuShF8l+jIZfybkLcnE8fUzB+i6o7fW7+lYHQ9Uhtvc4Dv5W
         qfRXOH0zEw5fu9hmCOi19AjxcXfqQea9OzwAkSjjxYIYVH+tePF5pgQf9N1wl7SO9Wm1
         BX7QFmEUL5kWHWj5+hO51Vn28KlyGc6+nKkdLbYPWsxgcscWPEjrjqW22jtZxdtFfYIP
         SrJLWZOTWqEViRFnTJSyEhgzUFlhZItPQKqM2vbKFR4HRqZIP6/LfYnhcDFH0LZzyUj9
         CRLISlHJwuRCtqFTirpTfNK8LuaOFFFqhN/x4TGWmt5Jrxrd78HFDEfFMywrVK+VSI9B
         kR+Q==
X-Gm-Message-State: AOAM532RYx8CmvAcLtpd0PcDxAHZmZ0bjzdnHjIzyH2/C+OES0t5HNrB
        6c9nZqbTE2s/Lgu2r1gxKAT0lqYpYSU=
X-Google-Smtp-Source: ABdhPJybxCtBclEUoall4T+jK/E/fTSGx9JbZUGu2V0ycGPaq07fRUa7TZOY/SS0CWs4oxG4PDBAiA==
X-Received: by 2002:adf:c44d:: with SMTP id a13mr220594wrg.65.1626112560686;
        Mon, 12 Jul 2021 10:56:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q5sm13036602wmc.0.2021.07.12.10.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:56:00 -0700 (PDT)
Message-Id: <d38b66e9ee4607b22c0473f23243a979e4880ab5.1626112556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
References: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
        <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 17:55:45 +0000
Subject: [PATCH v8 04/15] t1092: expand repository data shape
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

