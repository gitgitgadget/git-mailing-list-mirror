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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD23C433E6
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 17:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0E323406
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 17:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404053AbhATQ4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404078AbhATQz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 11:55:27 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBDCC061794
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:54:10 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c124so3425382wma.5
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FUR1qhEno0jN9qHglBXligxueyjQTu+pgLMgDz4ijZ0=;
        b=lm+17dZXSu1sbOpJMwlQxomeWyOikQO/z87J4hSN58aoA6vcueq/cywilYX5Lut38g
         tETABjLS4oDC83T1GLvUIOn6J4d0x3dw5GjeKYMHGIXYSbwVk4HuYiyjS3pNuOfKmLOG
         Vb7WaY8UoJv967bxTTeGmDL1UGsXvDJ2frQFOzgJUJlmHAem8OJpGb4i+frCzLO3T67z
         ajYdkGLYiKHRCzjAZi5KIVrrE2db5RQJxnn3Can4CpUQY4L5gb/DsXavLmhsiT1xjH3C
         2zq6jb4iqghZx272TUrQbCXUNd+cewhffSQxBBI2Lxa7cHVAigYCM5gEQRLSy/zGS3EX
         1t2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FUR1qhEno0jN9qHglBXligxueyjQTu+pgLMgDz4ijZ0=;
        b=kqIyayUfxzWr+oa2nGQRVWNjMUkjMr7IXt3ieWrx6co7HYZMwCUO/2uBRca2LPiy2c
         2cj6RS1OGa/znUR3hzCOqrjOTYxya72H4ayk+t+lznuh0PdpSonEfL9Tol0lZNzEAc9g
         0t7jyPPWV9RglF6ZUac0sA5+7zmj9qRmjjOqCcZ5+tGvqVCvRQfDBDh/PZYqURZwmkWo
         tstWdbjYB/83GEPpBkWfoL9cY3qIjCT72HvnxE2ZaHLGEjMycpdqhjm3UW7kMNp0izwh
         7WAaZUkzrdd5rv5GwGieRUPRs/bxdue2qiTxkAuXI97qew2p0AFVAF5GdaSgX/LDRtBZ
         e5Jw==
X-Gm-Message-State: AOAM5302YL26j7oHQnh72sEm0cT5KBAD85jrl6RxYu3SskMh5g0x3xbY
        dtDaon9BD0SaJLnD+DF78/IfsFvzE54=
X-Google-Smtp-Source: ABdhPJzLR2Y5OwDRbNJxU8Xn1eTG1WGAIL7JKVzfAuM55GFskJpvTQ4Sy92IPImtgvrES9n/9KtYRQ==
X-Received: by 2002:a1c:4b14:: with SMTP id y20mr5354853wma.166.1611161649010;
        Wed, 20 Jan 2021 08:54:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v65sm5186272wme.23.2021.01.20.08.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:54:08 -0800 (PST)
Message-Id: <555e210dc03e3966d39b84d5fd5d409038422c40.1611161639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.git.1611161639.gitgitgadget@gmail.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jan 2021 16:53:59 +0000
Subject: [PATCH 9/9] t1092: test interesting sparse-checkout scenarios
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

These also document some behaviors that differ from a full checkout, and
possibly in a way that is not intended.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 323 +++++++++++++++++++++++
 1 file changed, 323 insertions(+)
 create mode 100755 t/t1092-sparse-checkout-compatibility.sh

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
new file mode 100755
index 00000000000..46f9dc2cdf3
--- /dev/null
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -0,0 +1,323 @@
+#!/bin/sh
+
+test_description='compare full workdir to sparse workdir'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	git init initial-repo &&
+	(
+		cd initial-repo &&
+		echo a >a &&
+		echo "after deep" >e &&
+		echo "after folder1" >g &&
+		mkdir folder1 folder2 deep x &&
+		mkdir deep/deeper1 deep/deeper2 &&
+		mkdir deep/deeper1/deepest &&
+		echo "after deeper1" >deep/e &&
+		echo "after deepest" >deep/deeper1/e &&
+		cp a folder1 &&
+		cp a folder2 &&
+		cp a deep &&
+		cp a deep/deeper1 &&
+		cp a deep/deeper2 &&
+		cp a deep/deeper1/deepest &&
+		git add . &&
+		git commit -m "initial commit" &&
+		git checkout -b base &&
+		for dir in folder1 folder2 deep
+		do
+			git checkout -b update-$dir &&
+			echo "updated $dir" >$dir/a &&
+			git commit -a -m "update $dir" || return 1
+		done &&
+
+		git checkout -b rename-base base &&
+		echo >folder1/larger-content <<-\EOF &&
+		matching
+		lines
+		help
+		inexact
+		renames
+		EOF
+		cp folder1/larger-content folder2/ &&
+		cp folder1/larger-content deep/deeper1/ &&
+		git add . &&
+		git commit -m "add interesting rename content" &&
+
+		git checkout -b rename-out-to-out rename-base &&
+		mv folder1/a folder2/b &&
+		mv folder1/larger-content folder2/edited-content &&
+		echo >>folder2/edited-content &&
+		git add . &&
+		git commit -m "rename folder1/... to folder2/..." &&
+
+		git checkout -b rename-out-to-in rename-base &&
+		mv folder1/a deep/deeper1/b &&
+		mv folder1/larger-content deep/deeper1/edited-content &&
+		echo >>deep/deeper1/edited-content &&
+		git add . &&
+		git commit -m "rename folder1/... to deep/deeper1/..." &&
+
+		git checkout -b rename-in-to-out rename-base &&
+		mv deep/deeper1/a folder1/b &&
+		mv deep/deeper1/larger-content folder1/edited-content &&
+		echo >>folder1/edited-content &&
+		git add . &&
+		git commit -m "rename deep/deeper1/... to folder1/..." &&
+
+		git checkout -b deepest base &&
+		echo "updated deepest" >deep/deeper1/deepest/a &&
+		git commit -a -m "update deepest" &&
+
+		git checkout -f base &&
+		git reset --hard
+	)
+'
+
+init_repos () {
+	rm -rf full-checkout sparse-checkout sparse-index &&
+
+	# create repos in initial state
+	cp -r initial-repo full-checkout &&
+	git -C full-checkout reset --hard &&
+
+	cp -r initial-repo sparse-checkout &&
+	git -C sparse-checkout reset --hard &&
+	git -C sparse-checkout sparse-checkout init --cone &&
+
+	# initialize sparse-checkout definitions
+	git -C sparse-checkout sparse-checkout set deep
+}
+
+run_on_sparse () {
+	(
+		cd sparse-checkout &&
+		$* >../sparse-checkout-out 2>../sparse-checkout-err
+	)
+}
+
+run_on_all () {
+	(
+		cd full-checkout &&
+		$* >../full-checkout-out 2>../full-checkout-err
+	) &&
+	run_on_sparse $*
+}
+
+test_all_match () {
+	run_on_all $* &&
+	test_cmp full-checkout-out sparse-checkout-out &&
+	test_cmp full-checkout-err sparse-checkout-err
+}
+
+test_expect_success 'status with options' '
+	init_repos &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git status --porcelain=v2 -z -u &&
+	test_all_match git status --porcelain=v2 -uno &&
+	run_on_all "touch README.md" &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git status --porcelain=v2 -z -u &&
+	test_all_match git status --porcelain=v2 -uno &&
+	test_all_match git add README.md &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git status --porcelain=v2 -z -u &&
+	test_all_match git status --porcelain=v2 -uno
+'
+
+test_expect_success 'add, commit, checkout' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>README.md
+	EOF
+	run_on_all "../edit-contents" &&
+
+	test_all_match git add README.md &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git commit -m "Add README.md" &&
+
+	test_all_match git checkout HEAD~1 &&
+	test_all_match git checkout - &&
+
+	run_on_all "../edit-contents" &&
+
+	test_all_match git add -A &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git commit -m "Extend README.md" &&
+
+	test_all_match git checkout HEAD~1 &&
+	test_all_match git checkout -
+'
+
+test_expect_success 'add, commit, checkout' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+	run_on_all "../edit-contents README.md" &&
+
+	test_all_match git add README.md &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git commit -m "Add README.md" &&
+
+	test_all_match git checkout HEAD~1 &&
+	test_all_match git checkout - &&
+
+	run_on_all "../edit-contents README.md" &&
+
+	test_all_match git add -A &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git commit -m "Extend README.md" &&
+
+	test_all_match git checkout HEAD~1 &&
+	test_all_match git checkout - &&
+
+	run_on_all "../edit-contents deep/newfile" &&
+
+	test_all_match git status --porcelain=v2 -uno &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git add . &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git commit -m "add deep/newfile" &&
+
+	test_all_match git checkout HEAD~1 &&
+	test_all_match git checkout -
+'
+
+test_expect_success 'checkout and reset --hard' '
+	init_repos &&
+
+	test_all_match git checkout update-folder1 &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git checkout update-deep &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git checkout -b reset-test &&
+	test_all_match git reset --hard deepest &&
+	test_all_match git reset --hard update-folder1 &&
+	test_all_match git reset --hard update-folder2
+'
+
+test_expect_success 'diff --staged' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>README.md
+	EOF
+	run_on_all "../edit-contents" &&
+
+	test_all_match git diff &&
+	test_all_match git diff --staged &&
+	test_all_match git add README.md &&
+	test_all_match git diff &&
+	test_all_match git diff --staged
+'
+
+test_expect_success 'diff with renames' '
+	init_repos &&
+
+	for branch in rename-out-to-out rename-out-to-in rename-in-to-out
+	do
+		test_all_match git checkout rename-base &&
+		test_all_match git checkout $branch -- .&&
+		test_all_match git diff --staged &&
+		test_all_match git diff --staged --find-renames || return 1
+	done
+'
+
+test_expect_success 'log with pathspec outside sparse definition' '
+	init_repos &&
+
+	test_all_match git log -- a &&
+	test_all_match git log -- folder1/a &&
+	test_all_match git log -- folder2/a &&
+	test_all_match git log -- deep/a &&
+	test_all_match git log -- deep/deeper1/a &&
+	test_all_match git log -- deep/deeper1/deepest/a &&
+
+	test_all_match git checkout update-folder1 &&
+	test_all_match git log -- folder1/a
+'
+
+test_expect_success 'blame with pathspec inside sparse definition' '
+	init_repos &&
+
+	test_all_match git blame a &&
+	test_all_match git blame deep/a &&
+	test_all_match git blame deep/deeper1/a &&
+	test_all_match git blame deep/deeper1/deepest/a
+'
+
+# TODO: blame currently does not support blaming files outside of the
+# sparse definition. It complains that the file doesn't exist locally.
+test_expect_failure 'blame with pathspec outside sparse definition' '
+	init_repos &&
+
+	test_all_match git blame folder1/a &&
+	test_all_match git blame folder2/a &&
+	test_all_match git blame deep/deeper2/a &&
+	test_all_match git blame deep/deeper2/deepest/a
+'
+
+# TODO: reset currently does not behave as expected when in a
+# sparse-checkout.
+test_expect_failure 'checkout and reset (mixed)' '
+	init_repos &&
+
+	test_all_match git checkout -b reset-test update-deep &&
+	test_all_match git reset deepest &&
+	test_all_match git reset update-folder1 &&
+	test_all_match git reset update-folder2
+'
+
+test_expect_success 'merge' '
+	init_repos &&
+
+	test_all_match git checkout -b merge update-deep &&
+	test_all_match git merge -m "folder1" update-folder1 &&
+	test_all_match git rev-parse HEAD^{tree} &&
+	test_all_match git merge -m "folder2" update-folder2 &&
+	test_all_match git rev-parse HEAD^{tree}
+'
+
+test_expect_success 'merge with outside renames' '
+	init_repos &&
+
+	for type in out-to-out out-to-in in-to-out
+	do
+		test_all_match git reset --hard &&
+		test_all_match git checkout -f -b merge-$type update-deep &&
+		test_all_match git merge -m "$type" rename-$type &&
+		test_all_match git rev-parse HEAD^{tree} || return 1
+	done
+'
+
+test_expect_success 'clean' '
+	init_repos &&
+
+	echo bogus >>.gitignore &&
+	run_on_all cp ../.gitignore . &&
+	test_all_match git add .gitignore &&
+	test_all_match git commit -m ignore-bogus-files &&
+
+	run_on_sparse mkdir folder1 &&
+	run_on_all touch folder1/bogus &&
+
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git clean -f &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git clean -xf &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git clean -xdf &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_path_is_dir sparse-checkout/folder1
+'
+
+test_done
-- 
gitgitgadget
