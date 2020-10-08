Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC01C04EBE
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 10:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B3F21734
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 10:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVNCipDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgJHKN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 06:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbgJHKNx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 06:13:53 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FCBC061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 03:13:52 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d81so5850958wmc.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 03:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RI/d+s0gn77O8vNnltMe6zcegg4uB0hNZtoIx2DLJik=;
        b=fVNCipDRQXKpmJ2b3oNoBsDhrlLpC36E0H4wZ8yxRuR1rV397bSlmRx4050Lw0kjZF
         +eV4jD+N1azbwxos8XJQZ5UMYwVW3slp20X31vr18cRegNVpxx9lBOL2XPwxzSj+sGWw
         HurR0Y5M/LmyQ+ekweSWUzEO6Bqr7KJthcX7nMgYNwhJmZMvTbq2jAUx1ud8w+dZvW+t
         FZLoZHxW9LBaoyBr7rb1/4e8EbiI67oZAHPIynObbpXxQPtPTEzD3C8f12yJlRz7r+zd
         A/7K48QpMk/M5rMT9ps2PX+/xD/guUu+xz+QTEWj0fOQRMfeA7pF+4VOYKo/k55opl1M
         NERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RI/d+s0gn77O8vNnltMe6zcegg4uB0hNZtoIx2DLJik=;
        b=cHGAsjKOZdkAk8OFtjkZK6RE0P3nADtdhNH4v5MTikRupWVB29D31O+J+XnTeAG4Fk
         4e2mkunpRIh1HwuYAw1on+v16nKtsTT3+9Q/0C1b4Jh2SOY7JvPIoDfgHiuZZril9+C4
         enzGdp4nPjMFGIypwwNEd1uluFuWAoo125OvarqXARptOLuhg+SQSuNBTZlhXsJ/DUmQ
         PLf12TdaTlNKKAs8koLHxRUQnPdMlnBWidyNLgGFy7F9t9eR+NMzKtnKJdsCf6fDXG8u
         ApMRAivisjD6hffN1jSfzwJrxOU8IBvJZA7ARcHXXj7jc5yl2FipWsfmbCF/DZ6viPmt
         2xyQ==
X-Gm-Message-State: AOAM5328/nzMo07H0i+M3bJpVtZCnzUREuQEVtNEukjPTXCYcf9enysO
        7u1XOGu8VJ1MTKpSQ8In2VjRM6PrzQI=
X-Google-Smtp-Source: ABdhPJznofdZfSMRE9xwTFAP0tyGw5TuiKjofodqvrx555kfgJXrFw3mgQ9NvWVO8P8+iPKMopnHMw==
X-Received: by 2002:a1c:40d5:: with SMTP id n204mr7744326wma.148.1602152031077;
        Thu, 08 Oct 2020 03:13:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m11sm6277880wmf.10.2020.10.08.03.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 03:13:50 -0700 (PDT)
Message-Id: <b187571778c2059b853c33637b4e59c5267125f0.1602152027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.743.v2.git.1602152027.gitgitgadget@gmail.com>
References: <pull.743.git.1601888196.gitgitgadget@gmail.com>
        <pull.743.v2.git.1602152027.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 08 Oct 2020 10:13:47 +0000
Subject: [PATCH v2 2/2] tests: avoid using the branch name `main`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the near future, we want to change Git's default branch name to
`main`. In preparation for that, stop using it as a branch name in the
test suite. Replace that branch name by `topic`, the same name we used
to rename variations of `master` in b6211b89eb3 (tests: avoid variations
of the `master` branch name, 2020-09-26).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6012-rev-list-simplify.sh |  8 ++++----
 t/t6400-merge-df.sh          |  8 ++++----
 t/t6409-merge-subtree.sh     | 12 ++++++------
 t/t6430-merge-recursive.sh   |  4 ++--
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index b6fa43ace0..7fc10f8593 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -171,7 +171,7 @@ test_expect_success '--full-diff is not affected by --parents' '
 test_expect_success 'rebuild repo' '
 	rm -rf .git * &&
 	git init &&
-	git switch -c main &&
+	git switch -c topic &&
 
 	echo base >file &&
 	git add file &&
@@ -186,7 +186,7 @@ test_expect_success 'rebuild repo' '
 	git add file &&
 	test_commit B &&
 
-	git switch main &&
+	git switch topic &&
 	test_must_fail git merge -m "M" B &&
 	echo A >file &&
 	echo B >>file &&
@@ -207,7 +207,7 @@ test_expect_success 'rebuild repo' '
 	git merge -m R -Xtheirs X &&
 	note R &&
 
-	git switch main &&
+	git switch topic &&
 	git merge -m N R &&
 	note N &&
 
@@ -221,7 +221,7 @@ test_expect_success 'rebuild repo' '
 	git add z &&
 	test_commit Z &&
 
-	git switch main &&
+	git switch topic &&
 	git merge -m O Z &&
 	note O &&
 
diff --git a/t/t6400-merge-df.sh b/t/t6400-merge-df.sh
index 400a4cd139..f1b84617af 100755
--- a/t/t6400-merge-df.sh
+++ b/t/t6400-merge-df.sh
@@ -124,7 +124,7 @@ test_expect_success 'Simple merge in repo with interesting pathnames' '
 		git add . &&
 		git commit -m initial &&
 
-		git branch main &&
+		git branch topic &&
 		git branch other &&
 
 		git checkout other &&
@@ -132,10 +132,10 @@ test_expect_success 'Simple merge in repo with interesting pathnames' '
 		git add -u &&
 		git commit -m other &&
 
-		git checkout main &&
-		echo main >foo/bar/baz &&
+		git checkout topic &&
+		echo topic >foo/bar/baz &&
 		git add -u &&
-		git commit -m main &&
+		git commit -m topic &&
 
 		git merge other &&
 		git ls-files -s >out &&
diff --git a/t/t6409-merge-subtree.sh b/t/t6409-merge-subtree.sh
index 793f0c8bf3..8b11e00ded 100755
--- a/t/t6409-merge-subtree.sh
+++ b/t/t6409-merge-subtree.sh
@@ -35,11 +35,11 @@ test_expect_success 'setup branch sub' '
 	test_commit foo
 '
 
-test_expect_success 'setup branch main' '
-	git checkout -b main master &&
+test_expect_success 'setup topic branch' '
+	git checkout -b topic master &&
 	git merge -s ours --no-commit --allow-unrelated-histories sub &&
 	git read-tree --prefix=dir/ -u sub &&
-	git commit -m "initial merge of sub into main" &&
+	git commit -m "initial merge of sub into topic" &&
 	test_path_is_file dir/foo.t &&
 	test_path_is_file hello
 '
@@ -49,9 +49,9 @@ test_expect_success 'update branch sub' '
 	test_commit bar
 '
 
-test_expect_success 'update branch main' '
-	git checkout main &&
-	git merge -s subtree sub -m "second merge of sub into main" &&
+test_expect_success 'update topic branch' '
+	git checkout topic &&
+	git merge -s subtree sub -m "second merge of sub into topic" &&
 	test_path_is_file dir/bar.t &&
 	test_path_is_file dir/foo.t &&
 	test_path_is_file hello
diff --git a/t/t6430-merge-recursive.sh b/t/t6430-merge-recursive.sh
index d48d211a95..a328260d42 100755
--- a/t/t6430-merge-recursive.sh
+++ b/t/t6430-merge-recursive.sh
@@ -663,7 +663,7 @@ test_expect_failure 'merge-recursive rename vs. rename/symlink' '
 
 test_expect_success 'merging with triple rename across D/F conflict' '
 	git reset --hard HEAD &&
-	git checkout -b main &&
+	git checkout -b topic &&
 	git rm -rf . &&
 
 	echo "just a file" >sub1 &&
@@ -682,7 +682,7 @@ test_expect_success 'merging with triple rename across D/F conflict' '
 	test_tick &&
 	git commit -a -m changesimplefile &&
 
-	git checkout main &&
+	git checkout topic &&
 	git rm sub1 &&
 	git mv sub2 sub1 &&
 	test_tick &&
-- 
gitgitgadget
