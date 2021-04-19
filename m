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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0267C43460
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F0BE61221
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbhDSLln (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238770AbhDSLiw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 07:38:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7B2C061760
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:19 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o9-20020a1c41090000b029012c8dac9d47so10975941wma.1
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2a9vWWut/GjDiVw6KZDMDxp5aQXJRJ4XYMy52A0DJkE=;
        b=RG7C1xD2bvdSNdk2Z2v9Cp4n5aob1M4Ysczau9CXgi237NDKfHHTh+yXMua74+sXCS
         EBi5m0mp77bkD9hmAFnwKmz5wCDpuOZw0lGI69vCXkSXcI4RZ+mjFXxyFqFLSQ+rG5oT
         JxWtmQfgK6cefOAcIY7wkWQVGJIAhcJ9TjTueiVxK4Ub76VrzzRQYC44o/9y0ybX3S1s
         4tODRSp7rm+1Qycx7a0RvJRfSBSXnmLNDkso/XlKkaz0xVEet/KkraZFKhAKkiWVELIp
         bAiEqLTiqWOZYIVBhufPwTfVG2ThGioSPFRYyKp27lcjIK3mZ5Za3OWdM9db/LsTgVot
         wgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2a9vWWut/GjDiVw6KZDMDxp5aQXJRJ4XYMy52A0DJkE=;
        b=q5jaipNSW5xo588jvm0RTYeVtdyL8COTQpK2Og43MILrc9Qmkyxo6bVQeUDNvim/rG
         twOrluIx36euXYMwE/a/+GJn6uc+lwEJZKyS7ywzppZgjMdzzJhCHKSajF0DugiutmK/
         4sursqcW9hRjfjUVtNGkdtyr1qn6ahB4P7K9GA/1UXLfSCGgdsFHZrBc4pjuFhAapE2R
         QGDMCBNLIrmwlLA4EEoJt0k+kfkXb9Rj3inWOT58cOVF+GYKO1sk+X2rncWtyNVFI5O+
         PQFmPzvEJ7TOMGIoXIhP+Yb6g4CX+2+IsvWM7sY9GTDpRHoIcz0QF5EkwmrJRLmfUfzk
         rftA==
X-Gm-Message-State: AOAM531VIKzDs3racOrdJB/YpvxbC1gXH+Rv4R8m4e/wyamiVAeCyLwU
        AVcZoyg3q/i2T+sXxAQmSDcdk8KeYfs=
X-Google-Smtp-Source: ABdhPJzwTQ0GL3hKIP/JYUNDmFZgzcM0dpG2DlQjp8vFT4D5vjLy4smFMvpWs+9Xuh3zIxRSRLfqDQ==
X-Received: by 2002:a1c:2786:: with SMTP id n128mr21596451wmn.82.1618832298087;
        Mon, 19 Apr 2021 04:38:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m14sm2844427wmq.44.2021.04.19.04.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:38:17 -0700 (PDT)
Message-Id: <dd8ffbf53157bde0c8dcc7d778b6f8d5849499fd.1618832277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 11:37:56 +0000
Subject: [PATCH v7 28/28] t1404: annotate test cases with REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys g <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
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
 t/t1404-update-ref-errors.sh | 86 ++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 29 deletions(-)

diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 8b51c4efc135..811d5bb56d41 100755
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
@@ -189,7 +193,7 @@ test_expect_success 'one new ref is a simple prefix of another' '
 
 '
 
-test_expect_success 'empty directory should not fool rev-parse' '
+test_expect_success REFFILES 'empty directory should not fool rev-parse' '
 	prefix=refs/e-rev-parse &&
 	git update-ref $prefix/foo $C &&
 	git pack-refs --all &&
@@ -199,7 +203,7 @@ test_expect_success 'empty directory should not fool rev-parse' '
 	test_cmp expected actual
 '
 
-test_expect_success 'empty directory should not fool for-each-ref' '
+test_expect_success REFFILES 'empty directory should not fool for-each-ref' '
 	prefix=refs/e-for-each-ref &&
 	git update-ref $prefix/foo $C &&
 	git for-each-ref $prefix >expected &&
@@ -209,14 +213,14 @@ test_expect_success 'empty directory should not fool for-each-ref' '
 	test_cmp expected actual
 '
 
-test_expect_success 'empty directory should not fool create' '
+test_expect_success REFFILES 'empty directory should not fool create' '
 	prefix=refs/e-create &&
 	mkdir -p .git/$prefix/foo/bar/baz &&
 	printf "create %s $C\n" $prefix/foo |
 	git update-ref --stdin
 '
 
-test_expect_success 'empty directory should not fool verify' '
+test_expect_success REFFILES 'empty directory should not fool verify' '
 	prefix=refs/e-verify &&
 	git update-ref $prefix/foo $C &&
 	git pack-refs --all &&
@@ -225,7 +229,7 @@ test_expect_success 'empty directory should not fool verify' '
 	git update-ref --stdin
 '
 
-test_expect_success 'empty directory should not fool 1-arg update' '
+test_expect_success REFFILES 'empty directory should not fool 1-arg update' '
 	prefix=refs/e-update-1 &&
 	git update-ref $prefix/foo $C &&
 	git pack-refs --all &&
@@ -234,7 +238,7 @@ test_expect_success 'empty directory should not fool 1-arg update' '
 	git update-ref --stdin
 '
 
-test_expect_success 'empty directory should not fool 2-arg update' '
+test_expect_success REFFILES 'empty directory should not fool 2-arg update' '
 	prefix=refs/e-update-2 &&
 	git update-ref $prefix/foo $C &&
 	git pack-refs --all &&
@@ -243,7 +247,7 @@ test_expect_success 'empty directory should not fool 2-arg update' '
 	git update-ref --stdin
 '
 
-test_expect_success 'empty directory should not fool 0-arg delete' '
+test_expect_success REFFILES 'empty directory should not fool 0-arg delete' '
 	prefix=refs/e-delete-0 &&
 	git update-ref $prefix/foo $C &&
 	git pack-refs --all &&
@@ -252,7 +256,7 @@ test_expect_success 'empty directory should not fool 0-arg delete' '
 	git update-ref --stdin
 '
 
-test_expect_success 'empty directory should not fool 1-arg delete' '
+test_expect_success REFFILES 'empty directory should not fool 1-arg delete' '
 	prefix=refs/e-delete-1 &&
 	git update-ref $prefix/foo $C &&
 	git pack-refs --all &&
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
@@ -463,10 +489,12 @@ test_expect_success 'incorrect old value blocks indirect no-deref delete' '
 	EOF
 	printf "%s\n" "option no-deref" "delete $prefix/symref $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
-test_expect_success 'non-empty directory blocks create' '
+test_expect_success REFFILES 'non-empty directory blocks create' '
 	prefix=refs/ne-create &&
 	mkdir -p .git/$prefix/foo/bar &&
 	: >.git/$prefix/foo/bar/baz.lock &&
@@ -485,7 +513,7 @@ test_expect_success 'non-empty directory blocks create' '
 	test_cmp expected output.err
 '
 
-test_expect_success 'broken reference blocks create' '
+test_expect_success REFFILES 'broken reference blocks create' '
 	prefix=refs/broken-create &&
 	mkdir -p .git/$prefix &&
 	echo "gobbledigook" >.git/$prefix/foo &&
@@ -504,7 +532,7 @@ test_expect_success 'broken reference blocks create' '
 	test_cmp expected output.err
 '
 
-test_expect_success 'non-empty directory blocks indirect create' '
+test_expect_success REFFILES 'non-empty directory blocks indirect create' '
 	prefix=refs/ne-indirect-create &&
 	git symbolic-ref $prefix/symref $prefix/foo &&
 	mkdir -p .git/$prefix/foo/bar &&
@@ -524,7 +552,7 @@ test_expect_success 'non-empty directory blocks indirect create' '
 	test_cmp expected output.err
 '
 
-test_expect_success 'broken reference blocks indirect create' '
+test_expect_success REFFILES 'broken reference blocks indirect create' '
 	prefix=refs/broken-indirect-create &&
 	git symbolic-ref $prefix/symref $prefix/foo &&
 	echo "gobbledigook" >.git/$prefix/foo &&
@@ -543,7 +571,7 @@ test_expect_success 'broken reference blocks indirect create' '
 	test_cmp expected output.err
 '
 
-test_expect_success 'no bogus intermediate values during delete' '
+test_expect_success REFFILES 'no bogus intermediate values during delete' '
 	prefix=refs/slow-transaction &&
 	# Set up a reference with differing loose and packed versions:
 	git update-ref $prefix/foo $C &&
@@ -600,7 +628,7 @@ test_expect_success 'no bogus intermediate values during delete' '
 	test_must_fail git rev-parse --verify --quiet $prefix/foo
 '
 
-test_expect_success 'delete fails cleanly if packed-refs file is locked' '
+test_expect_success REFFILES 'delete fails cleanly if packed-refs file is locked' '
 	prefix=refs/locked-packed-refs &&
 	# Set up a reference with differing loose and packed versions:
 	git update-ref $prefix/foo $C &&
@@ -616,7 +644,7 @@ test_expect_success 'delete fails cleanly if packed-refs file is locked' '
 	test_cmp unchanged actual
 '
 
-test_expect_success 'delete fails cleanly if packed-refs.new write fails' '
+test_expect_success REFFILES 'delete fails cleanly if packed-refs.new write fails' '
 	# Setup and expectations are similar to the test above.
 	prefix=refs/failed-packed-refs &&
 	git update-ref $prefix/foo $C &&
-- 
gitgitgadget
