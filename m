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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8789BC433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 20:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F4E922D2B
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 20:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbhAWUAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 15:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbhAWT7y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 14:59:54 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38344C0617AA
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 11:58:30 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m187so7165318wme.2
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 11:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Fd4Sbf4d9wD8PELSckZVtEysWcgj+yON4Sw1N6mXQgA=;
        b=AbPQlk+4GbxZ7owkVPSjsWgvduJchpvT5QXD/sNy52i+glvnfrcTXSGQqRZgMJa9dH
         qPWUQj3ataTOgQyi4f9bfjTEFa5XicIsKLKIjwuF1/She970rFs2wuc0ReG+UnaNau8h
         pmGtKa8cTFQO/ZuQprNIC6deE4YUpyiayKknh4jqv8VmSsCwQuAOCHhsuTQfOwLPgb5q
         rHGs2bOvcTiAEq3DMtLv2yFfqwEiY7AMOj91i4n0oXpI7U3Afs7IGvq6bniX7idDo/OK
         IlirRawHERhprUddX8wv0Dm5ZSyywvPRiuBfnHUqknuqmZFAz6YGWorM/2JA4/v5qFNj
         ShjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Fd4Sbf4d9wD8PELSckZVtEysWcgj+yON4Sw1N6mXQgA=;
        b=twwwrKwGNnsmTnmapj1kOW84nFwb+H5N8RULfUHMTWt2OPLxY4vWeR7do/w+cpD7Tc
         6yimoiQL2EsYQJOQxehvDNXnXuO68Cx9kBz2E8mkxZ9RwWS1pXgMxQdAanAdH0YvxQUk
         ufZUwwEYv1/ugstXB2gxQaXQvXfQy7iZygnYsGh822I3WP8Rrzzr6WVmKfcRxlsvG89z
         MmBgJtLnJM8yYjROfwmylN+AQgeNsgjitgoGnSOFhJMOpd9dqX9jo9aeI1ah7WtGICdo
         B00hT5c7h2qB+Oo1MiB46KXYPX8iOs7uhJDDOCKffTg3/Q+0UM8mxUPRFGYViMWgbRK/
         m89A==
X-Gm-Message-State: AOAM530XyxvPAn1P825n7aiHf3uze7y0CmbMa5+9/epjukWmc8HZYe7E
        tAYXzRn5ZGNd+B4+PjRA+ndW/unDelE=
X-Google-Smtp-Source: ABdhPJxBr7CD4+46Dt5OQJUgy8fXpI9iULyUqOwUEzG3foKoYl6oAAKioWmXkcOr4qMgKH8NtAud/Q==
X-Received: by 2002:a1c:3185:: with SMTP id x127mr1144138wmx.117.1611431908690;
        Sat, 23 Jan 2021 11:58:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u142sm8471547wmu.3.2021.01.23.11.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 11:58:28 -0800 (PST)
Message-Id: <72f925353d3f3992ab6a98df2b0752c019d11338.1611431900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
References: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
        <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Jan 2021 19:58:19 +0000
Subject: [PATCH v3 9/9] t1092: test interesting sparse-checkout scenarios
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <stolee@gmail.com>,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

These also document some behaviors that differ from a full checkout, and
possibly in a way that is not intended.

The test is designed to be run with "--run=1,X" where 'X' is an
interesting test case. Each test uses 'init_repos' to reset the full and
sparse copies of the initial-repo that is created by the first test
case. This also makes it possible to have test cases leave the working
directory or index in unusual states without disturbing later cases.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 301 +++++++++++++++++++++++
 1 file changed, 301 insertions(+)
 create mode 100755 t/t1092-sparse-checkout-compatibility.sh

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
new file mode 100755
index 00000000000..8cd3e5a8d22
--- /dev/null
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -0,0 +1,301 @@
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
+		echo "after x" >z &&
+		mkdir folder1 folder2 deep x &&
+		mkdir deep/deeper1 deep/deeper2 &&
+		mkdir deep/deeper1/deepest &&
+		echo "after deeper1" >deep/e &&
+		echo "after deepest" >deep/deeper1/e &&
+		cp a folder1 &&
+		cp a folder2 &&
+		cp a x &&
+		cp a deep &&
+		cp a deep/deeper1 &&
+		cp a deep/deeper2 &&
+		cp a deep/deeper1/deepest &&
+		cp -r deep/deeper1/deepest deep/deeper2 &&
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
+		test_all_match git diff --staged --no-renames &&
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
