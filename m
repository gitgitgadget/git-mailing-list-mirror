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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3B5C433E9
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA9E619DA
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhC3NLq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbhC3NLN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 09:11:13 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96FAC061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:12 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so986260wmq.1
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3UfR33i2EmD24Ig4R+PabyKQOjZ/JHxeIKOaa94XMX0=;
        b=m1HJ90YpNhBpO3AGhvuWbwGKF5uh7Ud7/4D7TjBOcuVMgucubeeVqTcBE+GbZWuueH
         S6OVlyDdWfW0f4ei+zt9xovCIfMEfswk6DmPM1TWkxr7a68ELv4qis0VMx83+DNEQdUB
         /d2i3kRwENph1lSqKhfHToTf0ITIdeVFKqqa+Gt+elmIp4IKXsxq06M1LvYz1/kipggL
         rkF37hjR829jRH6TTVQ3ENvTsQUblcZMpiV6mgEDZx+pRsz6ahfImzsg2KJ7Vk0YkN3F
         4ziZw3xcBNmH0s4lZ1Btsfd5ZAKKCGiJNpH/GDyttlJOWzN695rf6lalX1icVdmZmP8s
         RxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3UfR33i2EmD24Ig4R+PabyKQOjZ/JHxeIKOaa94XMX0=;
        b=oG5+q7Xehl9SYaPRNHnQSKfd1txU4Nem46mD2o8NDY7r7jPfM3t79aM40AXndogVhh
         aboSm/f5bCuOaPkol+yv8N2JSsEZZsgxkDMSiF4Rr+JDVsEgUR+45WsbFVbHLNxn5NrV
         O9/i4fB2Yj36NzHaGsCeNm1aBVW+xFeYTUneKp379VilixRCUI2j17GIk0r3Zh1O/+Ak
         B+CfVdL1NxpvjNH3MfLJDJlYBp35M1oqjja7/9u4OiWc27kOpg02Ndv1OHIO9zhNShjj
         jlgRNjm9WYYyERDHKmOFVIuDQSBDCEDunexn40t9emgg5moJPcPpUYRM9XlGKZi12s4x
         QPgg==
X-Gm-Message-State: AOAM532wmrpIo5TKvVbfT3xiYbXKhRjxOvy1OQd8ZsYFjHTNBMg44QEo
        bdzKl8KPljDx3+o5tKC4NUYmxWOwTiM=
X-Google-Smtp-Source: ABdhPJyYl1iJWwZVxCgLklSVi45frxHUjaZOf9mmrnyOM+3i88VifGheFaVQDn+YRICUAGCNwuQ66Q==
X-Received: by 2002:a7b:cd8f:: with SMTP id y15mr4086058wmj.185.1617109871233;
        Tue, 30 Mar 2021 06:11:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o2sm3644424wme.19.2021.03.30.06.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:11:10 -0700 (PDT)
Message-Id: <7bfbfbd17321942f8f3a9b799eeb09bf1c58a947.1617109864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
References: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
        <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Mar 2021 13:10:49 +0000
Subject: [PATCH v5 06/21] t1092: compare sparse-checkout to sparse-index
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

