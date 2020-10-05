Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850A2C4727E
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B7AE20796
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMTajaze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgJEI4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgJEI4k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 04:56:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A1AC0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 01:56:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z1so8587014wrt.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 01:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Yj1zqNMdHeggohychXFKVqJMwKP4BeVwpR6QHBw/MW8=;
        b=CMTajazeK1CJTUO6UXofxGoZrDQOHWvEaICVKbtJ8sGXhn7SWHoaqvPtdiIPYCOPn9
         nDvyOJuXYbhp1/Trwrkt87I2qRncV9ZqeclnTDzmmMUopsH0VNy9n9tku3C0wwaAtudE
         N7cDOvUjhDDM/UTh0YCdd3xjpSPaQAF7UwSLOJSTchVoHvxdX2yw5Zh/BZG/xu98AxVz
         EwkXEzRZ6K6Zg/IfD3AAOIc1p9V9DIKXxpUoveRCMwVuUBs97Hphs/kmeAjdNM8y5T0C
         kCPJTguq312LAwKeXbq/T9athaAEdXnpcJSk89MS16eSvntnVOhOqklXcJV5ZZ6zF99T
         rcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Yj1zqNMdHeggohychXFKVqJMwKP4BeVwpR6QHBw/MW8=;
        b=tgyL91f/byOsbNuJ36v8FPln3ImKMz1zb9fc+h56VCfOuhSQR4M8jxTHmGc5NIhP1k
         /JcLa0OdOOtSSR95nQi3GKkGuzFS82P1sgaSx5ZHnMkNlbO9R5owsY3XEqdoA1cU4ioO
         eq8aO2U4KMiWFzAbrb6XQ65YiFAy6NJZqmVTlSW2V97jwnClXddKkiqSIy/zOVIzb2ht
         Hyd1lgKoJaH/dzUAyOLjLt7DsX7GLJ9zFpH+SDPnCVUzNjlxzAz/E2wfUoBJnRgNpgs/
         IfSDD+ygtbATypvWwdlgVwQVVUwWN/4rbHX3S06q8o6i9CIm03oQYFJlEUWx4MQZ5MAY
         3PwQ==
X-Gm-Message-State: AOAM532Ucqf2vlI/TEcKOAzCFYp3AryMP7T0lKPtFQwLUF3xxbHXehUm
        Vd0NrzpggTS1BzoxRplb/qn8HHqEZNE=
X-Google-Smtp-Source: ABdhPJxc56sXs33uNQiS9pPzHoSQU4bHQ5JepQaXKAY9B6WjeGPZEh6hOfibgD29kYnmTwXn5VmVfQ==
X-Received: by 2002:adf:97cb:: with SMTP id t11mr10983724wrb.292.1601888199171;
        Mon, 05 Oct 2020 01:56:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15sm11748613wmh.29.2020.10.05.01.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 01:56:38 -0700 (PDT)
Message-Id: <6045ceb938836355b7d43bc2088ca2504b05dde4.1601888196.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.743.git.1601888196.gitgitgadget@gmail.com>
References: <pull.743.git.1601888196.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Oct 2020 08:56:36 +0000
Subject: [PATCH 2/2] tests: avoid using the branch name `main`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the near future, we want to change Git's default branch name to
`main`. In preparation for that, stop using it as a branch name in the
test suite. Replace that branch name by `primary`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6012-rev-list-simplify.sh |  8 ++++----
 t/t6400-merge-df.sh          |  8 ++++----
 t/t6409-merge-subtree.sh     | 12 ++++++------
 t/t6430-merge-recursive.sh   |  4 ++--
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index b6fa43ace0..f1296c29e6 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -171,7 +171,7 @@ test_expect_success '--full-diff is not affected by --parents' '
 test_expect_success 'rebuild repo' '
 	rm -rf .git * &&
 	git init &&
-	git switch -c main &&
+	git switch -c primary &&
 
 	echo base >file &&
 	git add file &&
@@ -186,7 +186,7 @@ test_expect_success 'rebuild repo' '
 	git add file &&
 	test_commit B &&
 
-	git switch main &&
+	git switch primary &&
 	test_must_fail git merge -m "M" B &&
 	echo A >file &&
 	echo B >>file &&
@@ -207,7 +207,7 @@ test_expect_success 'rebuild repo' '
 	git merge -m R -Xtheirs X &&
 	note R &&
 
-	git switch main &&
+	git switch primary &&
 	git merge -m N R &&
 	note N &&
 
@@ -221,7 +221,7 @@ test_expect_success 'rebuild repo' '
 	git add z &&
 	test_commit Z &&
 
-	git switch main &&
+	git switch primary &&
 	git merge -m O Z &&
 	note O &&
 
diff --git a/t/t6400-merge-df.sh b/t/t6400-merge-df.sh
index 400a4cd139..15f540aae3 100755
--- a/t/t6400-merge-df.sh
+++ b/t/t6400-merge-df.sh
@@ -124,7 +124,7 @@ test_expect_success 'Simple merge in repo with interesting pathnames' '
 		git add . &&
 		git commit -m initial &&
 
-		git branch main &&
+		git branch primary &&
 		git branch other &&
 
 		git checkout other &&
@@ -132,10 +132,10 @@ test_expect_success 'Simple merge in repo with interesting pathnames' '
 		git add -u &&
 		git commit -m other &&
 
-		git checkout main &&
-		echo main >foo/bar/baz &&
+		git checkout primary &&
+		echo primary >foo/bar/baz &&
 		git add -u &&
-		git commit -m main &&
+		git commit -m primary &&
 
 		git merge other &&
 		git ls-files -s >out &&
diff --git a/t/t6409-merge-subtree.sh b/t/t6409-merge-subtree.sh
index 793f0c8bf3..c236180238 100755
--- a/t/t6409-merge-subtree.sh
+++ b/t/t6409-merge-subtree.sh
@@ -35,11 +35,11 @@ test_expect_success 'setup branch sub' '
 	test_commit foo
 '
 
-test_expect_success 'setup branch main' '
-	git checkout -b main master &&
+test_expect_success 'setup branch primary' '
+	git checkout -b primary master &&
 	git merge -s ours --no-commit --allow-unrelated-histories sub &&
 	git read-tree --prefix=dir/ -u sub &&
-	git commit -m "initial merge of sub into main" &&
+	git commit -m "initial merge of sub into primary" &&
 	test_path_is_file dir/foo.t &&
 	test_path_is_file hello
 '
@@ -49,9 +49,9 @@ test_expect_success 'update branch sub' '
 	test_commit bar
 '
 
-test_expect_success 'update branch main' '
-	git checkout main &&
-	git merge -s subtree sub -m "second merge of sub into main" &&
+test_expect_success 'update branch primary' '
+	git checkout primary &&
+	git merge -s subtree sub -m "second merge of sub into primary" &&
 	test_path_is_file dir/bar.t &&
 	test_path_is_file dir/foo.t &&
 	test_path_is_file hello
diff --git a/t/t6430-merge-recursive.sh b/t/t6430-merge-recursive.sh
index d48d211a95..900e5c63a7 100755
--- a/t/t6430-merge-recursive.sh
+++ b/t/t6430-merge-recursive.sh
@@ -663,7 +663,7 @@ test_expect_failure 'merge-recursive rename vs. rename/symlink' '
 
 test_expect_success 'merging with triple rename across D/F conflict' '
 	git reset --hard HEAD &&
-	git checkout -b main &&
+	git checkout -b primary &&
 	git rm -rf . &&
 
 	echo "just a file" >sub1 &&
@@ -682,7 +682,7 @@ test_expect_success 'merging with triple rename across D/F conflict' '
 	test_tick &&
 	git commit -a -m changesimplefile &&
 
-	git checkout main &&
+	git checkout primary &&
 	git rm sub1 &&
 	git mv sub2 sub1 &&
 	test_tick &&
-- 
gitgitgadget
