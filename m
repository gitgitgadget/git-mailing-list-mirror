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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731F0C636C9
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A8260FED
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhGTQ2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 12:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhGTQYb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 12:24:31 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83F2C0613DE
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:05:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f8-20020a1c1f080000b029022d4c6cfc37so1894320wmf.5
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yyG7ptp3kPeTvu91jaJSIgDSemxiR1k8pmNU3KvV//Y=;
        b=vXQ45p/d6Vwavx6HcH24mUTcT5zlZ9VvBrebSehM6cm09xEpwDsyoRuneLVhGFR+8b
         aTsGWWcrOb60x7iDsZ/OMrx0e+9OvPtAwflmb/P6Mgn9zZG1062TCkFZKnLAhxwEVGPh
         ZRFazBlV8rFZENpYEd7ZTD2+/rO3l/VquDEqSA+3X/1Pe8j/Ez3BQ/WRlA9t67o4HmV3
         45I3WBfSxWsgYCnDGynhfEIpvAzv8CzFgw1ag9Qbq8IgHbO1eTevXNXC4jvbuy+QgwPd
         DlePidOgAPDdIE0xfzuVugsZVx24sYArSLtVxLZOpNie75EHzMV13/yN4lxOsZpibu73
         rxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yyG7ptp3kPeTvu91jaJSIgDSemxiR1k8pmNU3KvV//Y=;
        b=g6JjFjk9Wo203ZpYcN5BQtoLm7fc7DTRJiktS/5cd/RcjlX8y1/5DiOf6vueGHu9f9
         4wbyIv78eC1ExvlLl2sLDjA4rfWxb3PTo0a/QA25eV3IYWJnghfN6oqtdcUnZeOXc73N
         yarSPjUw+kIXhVfJBBTQY0A+5lOYZYweoinaSEDZvZA1q6jx9L8lVALCEw1dzqD89ZOz
         lEqznZSA+3Q926X0t3HmmBkUUKhu0lRNTpGW4GWXNznwaoDfY7KVapt7fUOPqbMKaswL
         pOqhmr8ydnuC9Ol3cVlxVz5PvZTwYdnA4AUKkrkvtuEQEWwiGMOZ8+hAoXDryAIUDkyH
         PFEQ==
X-Gm-Message-State: AOAM533/9xQWehzzx5JXtM1oLiDdxROwMeR7/8smEWXuW6IZcl9vxkea
        oi0gsCaJ4E0oKHrPsdltARVxNolgW2I=
X-Google-Smtp-Source: ABdhPJwIeKz2vheyEFMCZEkiie2Q+7pQjh/gfhjXg9BRjclqWcpuiCkD/nLKaWk9VYQwTvRDpG8HvQ==
X-Received: by 2002:a7b:c4d3:: with SMTP id g19mr32416849wmk.78.1626800704361;
        Tue, 20 Jul 2021 10:05:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2sm19876446wmg.6.2021.07.20.10.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 10:05:04 -0700 (PDT)
Message-Id: <f0a528b9ece4ec964f7698843613ae025f2b5f5d.1626800687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 17:04:45 +0000
Subject: [PATCH 25/26] t1404: annotate test cases with REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

* Reftable for now lacks detailed error messages for directory/file conflicts.
  Skip message comparisons.

* Mark tests that muck with .git directly as REFFILES.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1404-update-ref-errors.sh | 56 +++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index b729c1f4803..811d5bb56d4 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -27,7 +27,9 @@ test_update_rejected () {
 	fi &&
 	printf "create $prefix/%s $C\n" $create >input &&
 	test_must_fail git update-ref --stdin <input 2>output.err &&
-	test_i18ngrep -F "$error" output.err &&
+	if test_have_prereq REFFILES ; then
+		test_i18ngrep -F "$error" output.err
+	fi &&
 	git for-each-ref $prefix >actual &&
 	test_cmp unchanged actual
 }
@@ -101,7 +103,9 @@ df_test() {
 		printf "%s\n" "delete $delname" "create $addname $D"
 	fi >commands &&
 	test_must_fail git update-ref --stdin <commands 2>output.err &&
-	test_cmp expected-err output.err &&
+	if test_have_prereq REFFILES ; then
+		test_cmp expected-err output.err
+	fi &&
 	printf "%s\n" "$C $delref" >expected-refs &&
 	git for-each-ref --format="%(objectname) %(refname)" $prefix/r >actual-refs &&
 	test_cmp expected-refs actual-refs
@@ -336,7 +340,9 @@ test_expect_success 'missing old value blocks update' '
 	EOF
 	printf "%s\n" "update $prefix/foo $E $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success 'incorrect old value blocks update' '
@@ -347,7 +353,9 @@ test_expect_success 'incorrect old value blocks update' '
 	EOF
 	printf "%s\n" "update $prefix/foo $E $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success 'existing old value blocks create' '
@@ -358,7 +366,9 @@ test_expect_success 'existing old value blocks create' '
 	EOF
 	printf "%s\n" "create $prefix/foo $E" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success 'incorrect old value blocks delete' '
@@ -369,7 +379,9 @@ test_expect_success 'incorrect old value blocks delete' '
 	EOF
 	printf "%s\n" "delete $prefix/foo $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success 'missing old value blocks indirect update' '
@@ -380,7 +392,9 @@ test_expect_success 'missing old value blocks indirect update' '
 	EOF
 	printf "%s\n" "update $prefix/symref $E $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success 'incorrect old value blocks indirect update' '
@@ -392,7 +406,9 @@ test_expect_success 'incorrect old value blocks indirect update' '
 	EOF
 	printf "%s\n" "update $prefix/symref $E $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success 'existing old value blocks indirect create' '
@@ -404,7 +420,9 @@ test_expect_success 'existing old value blocks indirect create' '
 	EOF
 	printf "%s\n" "create $prefix/symref $E" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success 'incorrect old value blocks indirect delete' '
@@ -416,7 +434,9 @@ test_expect_success 'incorrect old value blocks indirect delete' '
 	EOF
 	printf "%s\n" "delete $prefix/symref $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success 'missing old value blocks indirect no-deref update' '
@@ -427,7 +447,9 @@ test_expect_success 'missing old value blocks indirect no-deref update' '
 	EOF
 	printf "%s\n" "option no-deref" "update $prefix/symref $E $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success 'incorrect old value blocks indirect no-deref update' '
@@ -439,7 +461,9 @@ test_expect_success 'incorrect old value blocks indirect no-deref update' '
 	EOF
 	printf "%s\n" "option no-deref" "update $prefix/symref $E $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success 'existing old value blocks indirect no-deref create' '
@@ -451,7 +475,9 @@ test_expect_success 'existing old value blocks indirect no-deref create' '
 	EOF
 	printf "%s\n" "option no-deref" "create $prefix/symref $E" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success 'incorrect old value blocks indirect no-deref delete' '
@@ -463,7 +489,9 @@ test_expect_success 'incorrect old value blocks indirect no-deref delete' '
 	EOF
 	printf "%s\n" "option no-deref" "delete $prefix/symref $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success REFFILES 'non-empty directory blocks create' '
-- 
gitgitgadget

