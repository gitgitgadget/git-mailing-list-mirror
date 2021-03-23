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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BE3C433E1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 672DB619C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhCWNoz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhCWNoh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 09:44:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF63C0613D8
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v11so20815030wro.7
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zT/KLSMEIY5jvVQ9z2xbPhRiUryKVuorFSgT+6Od1bg=;
        b=uvLDpFGqoZskE+Jx3zNOlvp262dU/TxwSW2sk9bUSmOI6UeJAbkur09Cj9iLL8bMc6
         wfX2hRW9tco6K1Ucnr0JdMy5acZtKVNu5xAUSJab+T++W5p3rvq5/EPDpI79ofiRGSZR
         yXrueTZNwE3akfVX8Ee7tpiYN6nlfNf+tB6kdGn2WIaKatwqzb9Mtq+J2/NRrPfdhl3P
         qVE75gXZ04RuJOv9t5P79vCUinTmGPo4r9G6bwkSuqRAXEEbx/vZ+KPeR7Gsey0NZn0I
         aDhsvcNnIUKUNEf8SlSYtZOprZbjKR43c7kIDf2t+g4t/TIzqVwAtBzLcqIHxzU4oFq5
         bSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zT/KLSMEIY5jvVQ9z2xbPhRiUryKVuorFSgT+6Od1bg=;
        b=YsQd230hW1Ga+wttTiU4dH49hdxfR9tYCeD2ex/L6bqCM6ob9SLNTOMP0ONpv4C1jy
         eGO8gbRmwuIAYCm3Z/wpd7kggkvFQbntkEJ0CctFLwYfVHiv4GLpgJCjCKlSbLASL9iA
         f/NUmeEph6TD0BEn1TcE8UejJk4E1my6uZ6TVd6G9uLhrNpO/ZQCoCXla8fQ80jZgAIO
         w/vxsV3ZSohYlPWshUOk7tROF/WJQrtiqDF3T7cJfGjwI0mUdQVkPasRlKkOEjLGa4n8
         S3LlFD4mpRpu4Bnr8xYrKYNuphMQR2GkeYfy2unSUifhSn9kfRiUmtdcubw5sL4paqqN
         rJPg==
X-Gm-Message-State: AOAM532V/QNJnalYhQAr0tfEhC+SLHY+WvCJdJOHIWJUvFYTcENrod1v
        X4C9GWpaAQbaJZUjfyFrUnDKueVnpQQ=
X-Google-Smtp-Source: ABdhPJzcH/0uhEmJNTgyKySz36a+SEpEyUGSoB07va/vO1VXo/B//+nqfolIJNZoqYvNfa2IojOdJA==
X-Received: by 2002:adf:e0d1:: with SMTP id m17mr4092687wri.90.1616507073917;
        Tue, 23 Mar 2021 06:44:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q4sm2577056wma.20.2021.03.23.06.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:44:33 -0700 (PDT)
Message-Id: <c9e21d78ecba46988e9e98ffecca96f1fcca6e79.1616507069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
        <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Mar 2021 13:44:11 +0000
Subject: [PATCH v4 03/20] t1092: clean up script quoting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This test was introduced in 19a0acc83e4 (t1092: test interesting
sparse-checkout scenarios, 2021-01-23), but it contains issues with quoting
that were not noticed until starting this follow-up series. The old
mechanism would drop quoting such as in

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

