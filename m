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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59556C433F2
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D8E5619C8
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhC3NLr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhC3NLL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 09:11:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B84CC061765
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j7so16228530wrd.1
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zT/KLSMEIY5jvVQ9z2xbPhRiUryKVuorFSgT+6Od1bg=;
        b=lbeHtc1/XMa2y3e0mqj3gkqn/XHLITwQJicXv2HYUgYlb6dYQiwIYihm5AnqSkARIb
         bYqi2aBqj2hPhSqtWAvfisZXSB87VV/i+Cb255GTzieKA9VZXxZuuixMTXIMsdw9Y56B
         QGhHC3S6zeIHoAb7adTBduSkJ1eLnJIpepf5vNPNQTIAOwIvblwcq9tEi2Guy3M5o5vt
         YwfQwrD16/jHpQoDvMIaksQR1WPeOe6ZL7+RbqHOuW+mUVpOOGCoXRjJDKidy+hL+1xN
         zNALj1tKBsLcQe3E+gEtoQNbbCcHxZ97hMguAxOMd7VWLXVUKC4Q+wCIcfKHRViv+H+z
         fneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zT/KLSMEIY5jvVQ9z2xbPhRiUryKVuorFSgT+6Od1bg=;
        b=Dfr5MRQJRFBTDnL3ya5dw9iy+86HmaNCIpSObhydXpOfLT4N1ffl7d4WsDhhqys2Nh
         yrFW8pEIxwfJt34/rXm5n3XxXCmzLp0OvzgE2+NA3C9DcLPuGWtizmUxtUj91ACnxnBu
         MGe7pRQnAe9d2NkAdqpKH/730KBGTzvcOLWUHT5rZpJWMQrXzOQIu0RAjG+3wF5x7nU4
         0fDIFGwYWk3rXd8C7wtApcpr0luI5T9GkpapCrV2Tl3bGmgYDIJpjWiArnzqyd6oIhm8
         tz3AZO76QZT31fDrjXukG8JjKtXbKFTcab1HNEVnKS36xysyd2agiPgyQOtU7KIkWZ3v
         daoA==
X-Gm-Message-State: AOAM530vgj2JL0/vMnwO51bkA/rP94mUrttBLh8ssBdqDLrDxEnW7IeO
        tJuhUwwZNphGIlqujN6Lds/V+ggB20A=
X-Google-Smtp-Source: ABdhPJw5D2FNPAaPY9whDDZsl/K3UvDromw4u+yDlg764+QM+jQGEMsPoCy+U5bMGDppQ/51lqBL/A==
X-Received: by 2002:adf:e5cd:: with SMTP id a13mr33115463wrn.65.1617109868882;
        Tue, 30 Mar 2021 06:11:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j20sm3363396wmp.30.2021.03.30.06.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:11:08 -0700 (PDT)
Message-Id: <437a0f144e57cd4d0811ff652e760cb961b1db1e.1617109864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
References: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
        <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Mar 2021 13:10:46 +0000
Subject: [PATCH v5 03/21] t1092: clean up script quoting
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

