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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3032C43333
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F1C665117
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbhCPQn4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238865AbhCPQnL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:43:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEB5C061762
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v11so7787118wro.7
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3UfR33i2EmD24Ig4R+PabyKQOjZ/JHxeIKOaa94XMX0=;
        b=l53nmJ7kzJeqt9iWICFrrHeCuHHykmlRvcwUITTXxVgAq86h5SzlJDMedAteR8tKbB
         VE7oAs3rGGrvG//X1n20McZ24ibtf0LolHF8nLbBaNxpd0w8I16Sr0zzNaaYVpasB56G
         lBnXbbfqHeSU8FTNKZHHmZPC/Wv14W5F14vrQhqoHm5baNcWV7+q6U04chBQl4h2klBU
         nJ5tX5tjv4MRdkBxmJpTLEDMX7UaHeUF3Icc8QgqcF0mk3KTnbmNtIy5R6z17zRm/aiN
         A545sQqQpiFzHX1faJuhfFrcx/5lu8TZ9RXM56NZmQo0tpPtaAm8UJGQKzh3YoQvl0PU
         EeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3UfR33i2EmD24Ig4R+PabyKQOjZ/JHxeIKOaa94XMX0=;
        b=QwpNF4keEpsR8wCHW/v3d6hXdvjbHYTTI9esVb/t+gag9IUZcl9RXlIg6DXGdUBHaM
         cjOO9cf44by/9ZAYzqNMIVzSmG+b1DCnORveGIcjtK5HVAwpVkWJOn+v15piIaMxY+3l
         ai8t19dC+VA/DuJ8sCntbKi6pUcPKQ1SVvxfR7wyQms2kGU4ta0s3+DfUzUkLuVWh3AA
         p06YvWqcwXlo2uToUCkLw+mlLFP4WSV9DjYNiMULvQGVENevWTcJYPVGQmFHMIHOC3Wi
         y6OBLmcq/KI88w47oKXBoEGe3klr7R5t+ljuK3hfa2SAB/jS2b7jRm7wpNNy+bW91cnS
         AjYQ==
X-Gm-Message-State: AOAM532pHjaoXYkPAveRYFKl6SIwMK/WGXvF/ytIOZ/DYu70GniRqU3t
        YAb3/tsi91B6GYTmIMdadksCl9oaWnc=
X-Google-Smtp-Source: ABdhPJzL7XIFgrYKXf1HKoOFzgiYJH93s+0+lMITjviG4+geWphZcq+hHg+tpJ/BiUa3KF6jZ7u4Lw==
X-Received: by 2002:a5d:55c4:: with SMTP id i4mr5943820wrw.84.1615912989354;
        Tue, 16 Mar 2021 09:43:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s11sm31869wme.22.2021.03.16.09.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:43:08 -0700 (PDT)
Message-Id: <fae5663a17bb565619a7ac1a2172063a80a86cde.1615912983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
        <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 16:42:49 +0000
Subject: [PATCH v3 06/20] t1092: compare sparse-checkout to sparse-index
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

Add a new 'sparse-index' repo alongside the 'full-checkout' and
'sparse-checkout' repos in t1092-sparse-checkout-compatibility.sh. Also
add run_on_sparse and test_sparse_match helpers. These helpers will be
used when the sparse index is implemented.

Add the GIT_TEST_SPARSE_INDEX environment variable to enable the
sparse-index by default. This can be enabled across all tests, but that
will only affect cases where the sparse-checkout feature is enabled.

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
index 3725d3997e70..de5d8461c993 100755
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
+	run_on_sparse "$@" &&
+	test_cmp sparse-checkout-out sparse-index-out &&
+	test_cmp sparse-checkout-err sparse-index-err
+}
+
 test_expect_success 'status with options' '
 	init_repos &&
 	test_all_match git status --porcelain=v2 &&
-- 
gitgitgadget

