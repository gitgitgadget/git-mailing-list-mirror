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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBFCC433E8
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF0EB619BF
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhCWNpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhCWNol (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 09:44:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94504C0613DB
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:37 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 12so11078299wmf.5
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3UfR33i2EmD24Ig4R+PabyKQOjZ/JHxeIKOaa94XMX0=;
        b=igpH0Mh8sWW3cgCKm9LxUqOHUVq2IPZebPr2WqzSflqs+t/VdkDfR5ABUKYZQj3bnQ
         GU6vbMNQ+UxTPaDduW4l9LAuhgmqEEfgWOvrnoOQe/RXawapUIjveZc8jN0URKrcs6EJ
         5+/Y658IS21LhvLjy2w0W/ohdJ8p8dxwacZQBfRoBD1ZSwl8MiFlPrKNjm4FrEoO9bGN
         EIoAZJi/CH2Qg+Vn+Acf6XORxr/w10+Acw1yc0LioQgFARdlNzUl6lFQEkHbbjpsZjG+
         rCZhqjSfrWLnqB+0p5JOKHNH1hwcM69sGbT6N2TmdW5IbBl8LpBWtlM4nqf7yBMCXR4z
         MUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3UfR33i2EmD24Ig4R+PabyKQOjZ/JHxeIKOaa94XMX0=;
        b=F06j2UaOZ5a1gPk4FqE2m1wg78sT9GbR02w9OHW0jhZmg5OcsBsjSL5a5U7Hl9gwIF
         MWbXmYkAmYiEJZwh57AE9Ix9okU/obJ9rj9WpVY/tfCXRES8UKTSJy0jAQ1Wb0oLH4yD
         78pknoNKBL0muYlTVBNf6GUk4YLOa7awtJidVvqPsEaY4uVtRX/5HenN+9juM4IckZh0
         6By9jPBIQlwM1t9qCcN8uTreQQ2LyOlPF9eBtIUvf1XkAmxnyEFWqPqNbongnVEhVnPC
         bg5tQggz8aAvc7LioGDNnwfljizCUFFS0wNkt8i8U48nH2Mc/GkfO2Bi4OReO05D05tU
         FYMA==
X-Gm-Message-State: AOAM530pommkA36k+bIFQmDzKPdD55qtk2LgrVqNwEYIr43Y6T4XW5n9
        U5/UG379uRmk6fZ9fy/3dDEt8x4g0VE=
X-Google-Smtp-Source: ABdhPJxrOZoC7K0286x6ieHmwO/ZdxQuilGXpDKFmy6FJma2LQ1j4U6vAOTGHh4HWVOVQe2yNCoT5w==
X-Received: by 2002:a1c:7d41:: with SMTP id y62mr3631129wmc.48.1616507076311;
        Tue, 23 Mar 2021 06:44:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r10sm2938616wmh.45.2021.03.23.06.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:44:35 -0700 (PDT)
Message-Id: <7f67adba0498d9ff481cae31ac10be9fe228d3d1.1616507069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
        <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Mar 2021 13:44:14 +0000
Subject: [PATCH v4 06/20] t1092: compare sparse-checkout to sparse-index
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

