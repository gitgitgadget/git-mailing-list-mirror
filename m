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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAA1C433E9
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE57564E22
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhBWUPT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbhBWUPP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 15:15:15 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA04C06178A
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:34 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v1so23848499wrd.6
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Sr8T60pvjyaHGo05oWI6Lye8k/6nZgW5k/6ArV7rGJ8=;
        b=X+WVmnQ72yidjc12yefFuwRavCyQnpJFf8HKjn2TvkYFRXN60V/sWlYcWvMcLrvR+J
         zxNP3sGnvRzx8xaXCX3CpmJPI21EuknXyQ10bSgINg0l3bcjC0BQr2t/hTeEdZa0rqu1
         pqCAIHxCuCPbO4ENqj/3WjFH8ITiOHaSvw6d6UEXj0Q3L4R9n5lKx52wvXbSz1MfPr/R
         zValdRxrByAt7/D3BxGkASP+OEZlm1lgUy8l60WWHbWuAE+AHG6qTNBIMGukK1F9grVQ
         KgPFpWoj6LxaHiPz5ApdSH2eehiJRpJYsQBeIgPmKznU6VvhyvHtXo/WPhpwOxSVhnzN
         aR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Sr8T60pvjyaHGo05oWI6Lye8k/6nZgW5k/6ArV7rGJ8=;
        b=aIwHqbYR2pc3j5HjEMN4V9t92h5jBj5RY+B90lej18t3UnIoK/jNHHFPu5ng0yD3Qd
         ldv+7+TjCx9jOWqxQfLNqC0BJXedM7Wq5SXK+2ISJrJjpA+a4aUgeRzd7r83WyB9cEYW
         bOvsF1+repthS2haiP9V4z4K137I51zwadzOSCv173NuwbqEzu9YNI4YkE5UOVDLxatV
         qEN+vnSYcAwP99acXHv4iMo/I8/jpFlko56A179yo97uyCSgAQLTao5Soq3nu9hK2Cll
         jR4I4tZA+AMwith1y/QhucjTfGjerOTe11wXKM2ssCOmQU4jBeSuE/7Ys+66UK5efcOZ
         qjWA==
X-Gm-Message-State: AOAM5321358PV5o8S493hErBFRfnwJXazPBRpX0evGln25+l/+mBMtYB
        HmMyK+SMPfdH6fbMj/GcpOLzAdNUw6o=
X-Google-Smtp-Source: ABdhPJyb0+30sI7moX6UGZs5lv3ehn3q1DTv0kHc7DRgb8ug/s9jVyxJ+Bzld0hr/abyaNBK6d0N0A==
X-Received: by 2002:adf:dd52:: with SMTP id u18mr9284537wrm.175.1614111273004;
        Tue, 23 Feb 2021 12:14:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m24sm3911013wmc.18.2021.02.23.12.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 12:14:32 -0800 (PST)
Message-Id: <6e783c88821e3b86f6ce976e5673dc1df8992c8f.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.git.1614111270.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 20:14:12 +0000
Subject: [PATCH 03/20] t1092: clean up script quoting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This test was introduced in 19a0acc83e4 (t1092: test interesting
sparse-checkout scenarios, 2021-01-23), but these issues with quoting
were not noticed until starting this follow-up series. The old mechanism
would drop quoting such as in

   test_all_match git commit -m "touch README.md"

The above happened to work because README.md is a file in the
repository, so 'git commit -m touch REAMDE.md' would succeed by
accident.

Other cases included quoting for no good reason, so clean that up now.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 8cd3e5a8d227..3725d3997e70 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -96,20 +96,20 @@ init_repos () {
 run_on_sparse () {
 	(
 		cd sparse-checkout &&
-		$* >../sparse-checkout-out 2>../sparse-checkout-err
+		"$@" >../sparse-checkout-out 2>../sparse-checkout-err
 	)
 }
 
 run_on_all () {
 	(
 		cd full-checkout &&
-		$* >../full-checkout-out 2>../full-checkout-err
+		"$@" >../full-checkout-out 2>../full-checkout-err
 	) &&
-	run_on_sparse $*
+	run_on_sparse "$@"
 }
 
 test_all_match () {
-	run_on_all $* &&
+	run_on_all "$@" &&
 	test_cmp full-checkout-out sparse-checkout-out &&
 	test_cmp full-checkout-err sparse-checkout-err
 }
@@ -119,7 +119,7 @@ test_expect_success 'status with options' '
 	test_all_match git status --porcelain=v2 &&
 	test_all_match git status --porcelain=v2 -z -u &&
 	test_all_match git status --porcelain=v2 -uno &&
-	run_on_all "touch README.md" &&
+	run_on_all touch README.md &&
 	test_all_match git status --porcelain=v2 &&
 	test_all_match git status --porcelain=v2 -z -u &&
 	test_all_match git status --porcelain=v2 -uno &&
@@ -135,7 +135,7 @@ test_expect_success 'add, commit, checkout' '
 	write_script edit-contents <<-\EOF &&
 	echo text >>$1
 	EOF
-	run_on_all "../edit-contents README.md" &&
+	run_on_all ../edit-contents README.md &&
 
 	test_all_match git add README.md &&
 	test_all_match git status --porcelain=v2 &&
@@ -144,7 +144,7 @@ test_expect_success 'add, commit, checkout' '
 	test_all_match git checkout HEAD~1 &&
 	test_all_match git checkout - &&
 
-	run_on_all "../edit-contents README.md" &&
+	run_on_all ../edit-contents README.md &&
 
 	test_all_match git add -A &&
 	test_all_match git status --porcelain=v2 &&
@@ -153,7 +153,7 @@ test_expect_success 'add, commit, checkout' '
 	test_all_match git checkout HEAD~1 &&
 	test_all_match git checkout - &&
 
-	run_on_all "../edit-contents deep/newfile" &&
+	run_on_all ../edit-contents deep/newfile &&
 
 	test_all_match git status --porcelain=v2 -uno &&
 	test_all_match git status --porcelain=v2 &&
@@ -186,7 +186,7 @@ test_expect_success 'diff --staged' '
 	write_script edit-contents <<-\EOF &&
 	echo text >>README.md
 	EOF
-	run_on_all "../edit-contents" &&
+	run_on_all ../edit-contents &&
 
 	test_all_match git diff &&
 	test_all_match git diff --staged &&
@@ -280,7 +280,7 @@ test_expect_success 'clean' '
 	echo bogus >>.gitignore &&
 	run_on_all cp ../.gitignore . &&
 	test_all_match git add .gitignore &&
-	test_all_match git commit -m ignore-bogus-files &&
+	test_all_match git commit -m "ignore bogus files" &&
 
 	run_on_sparse mkdir folder1 &&
 	run_on_all touch folder1/bogus &&
-- 
gitgitgadget

