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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4209C433E0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 986C264EF6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhCJTbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbhCJTbM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:31:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CC2C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:12 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a18so24601623wrc.13
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5iigrqOwj76r5bXCKC1LYHTsGQ9spzO+EGwZyXD+2fQ=;
        b=UNfiwf9+JUoLiJXU+9NX/clSLXfzDKXtA9qIc4WDd/N4R6bkmmG9qXQB44NXj4+K6a
         HgNW4lx9vDJTq2kjYuBtVIuXxSTlwkxBKEeBDyTY/KI1OBDdkjJtrAN7Nsa9zEJ38caK
         uzStMBMATkUeJeC4bOORpXdUx4c9/1k3tJRHdHchlcP2gHpNewfe89hklIIQoTXHiHDe
         WHIX9K/QTsmh20d75Ri+p5tHZioWs05kAmZDwj5R74TIn0z1oSKY4bbJZlp3W0RhFCQn
         GYu7TT3lN0iotwm9zqz84x63UqIJRcJCS7r+a+3yMa0vB/Y5pfPp4oxYuhv8zyG4Vrld
         yQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5iigrqOwj76r5bXCKC1LYHTsGQ9spzO+EGwZyXD+2fQ=;
        b=DTXcQSOyxHgpk+75KY42PJi5QTX9dlbSQdfVgZ/XmAMsge9xDd78XpYlvmX7EaRmWj
         MJr+KlmwWtYilSobn0DK7AYVet+uqfNGNqaVfr5hT/m2dUtRlVsP4J2FrHSkMKk0sJ14
         fAIqQm4/Hrl09slCyFFRB24yw6WQ3Uhg7lEAMI8ZmP8lF2mWxBTzuRGsH4d5bh8Tm0Qi
         v17WUGsqCfXRMt0hE3cVY5n3hfRATGrulpZbutkJw5JH3sRao5OBeqfnXXGSlGhGl2lo
         dIkh+fJ7SF5YHo7vp/eN2ENrO4kNlo7LKIFhbXBUUWVMk0oCAOVnd0kF5iOrGdfb6Uhe
         41gw==
X-Gm-Message-State: AOAM533HLcZDjCeiX5xnns5yUEAP//wvM9eH2mZoiXvPPjNXWQQs60qk
        k0KMuSFHwGW4FBXBS5IkOugUvcPJG1Q=
X-Google-Smtp-Source: ABdhPJz5gCVYdc44OLEWv7Hwr44oNwJDurppaMCAF9D2UsV/QDdk8wRe/ajKGhcuqfcHNEvD6fTryw==
X-Received: by 2002:adf:f351:: with SMTP id e17mr5033249wrp.416.1615404671012;
        Wed, 10 Mar 2021 11:31:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d13sm359931wro.23.2021.03.10.11.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:31:10 -0800 (PST)
Message-Id: <eac2db5efc2297cffa9aba227e964bcc952d04ff.1615404665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
        <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Mar 2021 19:30:49 +0000
Subject: [PATCH v2 06/20] t1092: compare sparse-checkout to sparse-index
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
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add a new 'sparse-index' repo alongside the 'full-checkout' and
'sparse-checkout' repos in t1092-sparse-checkout-compatibility.sh. Also
add run_on_sparse and test_sparse_match helpers. These helpers will be
used when the sparse index is implemented.

Add GIT_TEST_SPARSE_INDEX environment variable to enable the
sparse-index by default. This will be intended to use across the entire
test suite, except that it will only affect cases where the
sparse-checkout feature is enabled.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/README                                 |  3 +++
 t/t1092-sparse-checkout-compatibility.sh | 24 ++++++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/t/README b/t/README
index 593d4a4e270c..b98bc563aab5 100644
--- a/t/README
+++ b/t/README
@@ -439,6 +439,9 @@ and "sha256".
 GIT_TEST_WRITE_REV_INDEX=<boolean>, when true enables the
 'pack.writeReverseIndex' setting.
 
+GIT_TEST_SPARSE_INDEX=<boolean>, when true enables index writes to use the
+sparse-index format by default.
+
 Naming Tests
 ------------
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 3725d3997e70..71d6f9e4c014 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -7,6 +7,7 @@ test_description='compare full workdir to sparse workdir'
 test_expect_success 'setup' '
 	git init initial-repo &&
 	(
+		GIT_TEST_SPARSE_INDEX=0 &&
 		cd initial-repo &&
 		echo a >a &&
 		echo "after deep" >e &&
@@ -87,23 +88,32 @@ init_repos () {
 
 	cp -r initial-repo sparse-checkout &&
 	git -C sparse-checkout reset --hard &&
-	git -C sparse-checkout sparse-checkout init --cone &&
+
+	cp -r initial-repo sparse-index &&
+	git -C sparse-index reset --hard &&
 
 	# initialize sparse-checkout definitions
-	git -C sparse-checkout sparse-checkout set deep
+	git -C sparse-checkout sparse-checkout init --cone &&
+	git -C sparse-checkout sparse-checkout set deep &&
+	GIT_TEST_SPARSE_INDEX=1 git -C sparse-index sparse-checkout init --cone &&
+	GIT_TEST_SPARSE_INDEX=1 git -C sparse-index sparse-checkout set deep
 }
 
 run_on_sparse () {
 	(
 		cd sparse-checkout &&
-		"$@" >../sparse-checkout-out 2>../sparse-checkout-err
+		GIT_TEST_SPARSE_INDEX=0 "$@" >../sparse-checkout-out 2>../sparse-checkout-err
+	) &&
+	(
+		cd sparse-index &&
+		GIT_TEST_SPARSE_INDEX=1 "$@" >../sparse-index-out 2>../sparse-index-err
 	)
 }
 
 run_on_all () {
 	(
 		cd full-checkout &&
-		"$@" >../full-checkout-out 2>../full-checkout-err
+		GIT_TEST_SPARSE_INDEX=0 "$@" >../full-checkout-out 2>../full-checkout-err
 	) &&
 	run_on_sparse "$@"
 }
@@ -114,6 +124,12 @@ test_all_match () {
 	test_cmp full-checkout-err sparse-checkout-err
 }
 
+test_sparse_match () {
+	run_on_sparse $* &&
+	test_cmp sparse-checkout-out sparse-index-out &&
+	test_cmp sparse-checkout-err sparse-index-err
+}
+
 test_expect_success 'status with options' '
 	init_repos &&
 	test_all_match git status --porcelain=v2 &&
-- 
gitgitgadget

