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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF62C43381
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 219EA65111
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238914AbhCPQnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238862AbhCPQnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:43:09 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603A9C061756
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:08 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id g8so10477710wmd.4
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Sr8T60pvjyaHGo05oWI6Lye8k/6nZgW5k/6ArV7rGJ8=;
        b=q9BXhli9Hsg8kOgzjIO02tvw1kGNhAD9gmFjGUjlGRPkChu9v0bDP4SlK+fdgJur9i
         u/GOKMz28XN9EMRKX1Brmv0O1r7S19eBPhTA4xwt+hXBflo3QdGC9CZ6X+zT6USWkCe6
         lAEfPeDyJe++d96egE7sclF71FzjEMA8MvP/DFaHA6Gko2EGSssm7xvgxFgUaq77FCDd
         PBxVUwINTtC3OFAP91FmlZdMzGC5En3qwbJDGP8vPDClag0axiz+C8cXObcSJ5o6b72O
         LM47PBeK1IIhVTDaEPmAUXEMWwJwIa0eH+HJkOdwtiymvcYU/H4Zgsz9zbUaDAmSFp10
         8uqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Sr8T60pvjyaHGo05oWI6Lye8k/6nZgW5k/6ArV7rGJ8=;
        b=TRm1H/pkv1ALDVMscp2/Qc4/KS/l94eaHAnd1paNEC3MnCTqcIfCq53kjY5EklEKQk
         xpNmt21QIwkeKN/YYSCReBzfi2Ov5eiZc5Tw15cczj96yYdkl76kBkCMEJBrMdMYMnr8
         xv2cpMZu/ahtpolIlgimSh2UNq7OBB8++3cyq6VJ7ta+yfSuAOeEdCLnSq5oSncb9gEI
         liwo0GH7hnuPD3UOouH2k8IfoEgkZPWOZqFnduOxW0qvKQao3We2TVB7f92fnP9qUNh4
         9OrVfSSll8NCYv0cNW0hjwdZosSgdwSbTa0VVym4wF0rTUqD6iyqlFzFVkM4t3dZkVMZ
         8yNQ==
X-Gm-Message-State: AOAM532zt2rPjXunQ1BUb/FRgA8THmeNlSa4VMTzU+d1S+piBlTeepvz
        cpWFb4Xu3hr9ShZMFsMI/4r3q71vfDI=
X-Google-Smtp-Source: ABdhPJwDFg7nTkPNh7wyyuenSyTavJkd61qNN2PVAUhyaFqCtZlegjNDeiLqmw0AVP5K6YPjnEmw5w==
X-Received: by 2002:a05:600c:1553:: with SMTP id f19mr470641wmg.33.1615912987192;
        Tue, 16 Mar 2021 09:43:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s20sm12571wmj.36.2021.03.16.09.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:43:06 -0700 (PDT)
Message-Id: <d3cfd34b84184bef42fe0892790d80091c9ca01b.1615912983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
        <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 16:42:46 +0000
Subject: [PATCH v3 03/20] t1092: clean up script quoting
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

