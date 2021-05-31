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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDC6C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F341660231
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhEaRmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhEaRlC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:41:02 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24C4C008754
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:49 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y184-20020a1ce1c10000b02901769b409001so330486wmg.3
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Xnuc8fS23rvtIhv2+Xyh2kDaayBpYUySeIpUKbyOP9s=;
        b=GsCECtByhmw27rF82bm57mLzM1Qs/hjQUVURaGdsBEUeIx8WXPVoF+K5B483ZdFx5k
         qDfAy1hpbY85BVqT7LRHl944hQzIMdyEBoFX8hupgamWox3CeDaYTOKwUtDlya8DylIW
         fGUnbqOns0tEulAA9BToQzlnPulHkScfHd9haqObJl4G3dxpJt8TiXF0dkyiNsRGDZ3y
         3By1hBULvu0m2Ob01lxd+Mr21LKclZ4sfV88svpP80aE/1yO3GvrMC5rEyIR/6/ooWmA
         lzRshgus3Woc+mMeDf1hT/0M9SVzqsnIGksj3z/CtaqF/O7hqVuaf7TM791KMppzBlE4
         +CxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Xnuc8fS23rvtIhv2+Xyh2kDaayBpYUySeIpUKbyOP9s=;
        b=ftCB9oaoHWRD6rLzo+M3NIZlfRqQ/CW5PPRPpDaNQ7a/VPPZMn7oPGxG5atvwowwav
         jaavJYWuqLt3hrMrcA7hFhTGgHl3V1Ynblm+xbkAiQaR7tTlopiIFtq/VtYrbk5wFl0J
         P9rm6u6T3Ln4e/Tvf95jIfaBzd7y4/EeBej2F8AD6c5P5L1DPOXzjgyBPTjJW98gdC8N
         ssZby9+vvuyao7DX5YIJ+cZ+84tTRL5TairFwp17h94zkhzHFdkK1/c09H6tT1GRa1ZR
         pThm1+DTb/6j9wWXJ7ojrEDagy/av+vQC4yoyIYR5eudUi9C2ZkF+n5W8oop5+boeOv8
         lTMQ==
X-Gm-Message-State: AOAM530sXo5ICwXOx4OCjIvMkI0xpbSMQF1GlBaauAUzfC02HXjkEMuD
        Pfu7/ICrhWt2slccgbBCAHq3NkpVbuE=
X-Google-Smtp-Source: ABdhPJyDEi7vpliP1rfIqom2bw3GBnHi/fYrTfcqzjI7fEYKymylud1evMdbec9veSIics0TvIc8tA==
X-Received: by 2002:a05:600c:2248:: with SMTP id a8mr1491102wmm.5.1622480208626;
        Mon, 31 May 2021 09:56:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j18sm15309647wmq.27.2021.05.31.09.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:48 -0700 (PDT)
Message-Id: <c9d199b84499e7b114ba369d7c561cff03ee073d.1622480197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:33 +0000
Subject: [PATCH v3 18/22] t1404: mark tests that muck with .git directly as
 REFFILES.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The packed/loose ref storage is an overlay combination of packed-refs (refs and
tags in a single file) and one-file-per-ref. This creates all kinds of edge
cases related to directory/file conflicts, (non-)empty directories, and the
locking scheme, none of which applies to reftable.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1404-update-ref-errors.sh | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 8b51c4efc135..b729c1f48030 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -189,7 +189,7 @@ test_expect_success 'one new ref is a simple prefix of another' '
 
 '
 
-test_expect_success 'empty directory should not fool rev-parse' '
+test_expect_success REFFILES 'empty directory should not fool rev-parse' '
 	prefix=refs/e-rev-parse &&
 	git update-ref $prefix/foo $C &&
 	git pack-refs --all &&
@@ -199,7 +199,7 @@ test_expect_success 'empty directory should not fool rev-parse' '
 	test_cmp expected actual
 '
 
-test_expect_success 'empty directory should not fool for-each-ref' '
+test_expect_success REFFILES 'empty directory should not fool for-each-ref' '
 	prefix=refs/e-for-each-ref &&
 	git update-ref $prefix/foo $C &&
 	git for-each-ref $prefix >expected &&
@@ -209,14 +209,14 @@ test_expect_success 'empty directory should not fool for-each-ref' '
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
@@ -225,7 +225,7 @@ test_expect_success 'empty directory should not fool verify' '
 	git update-ref --stdin
 '
 
-test_expect_success 'empty directory should not fool 1-arg update' '
+test_expect_success REFFILES 'empty directory should not fool 1-arg update' '
 	prefix=refs/e-update-1 &&
 	git update-ref $prefix/foo $C &&
 	git pack-refs --all &&
@@ -234,7 +234,7 @@ test_expect_success 'empty directory should not fool 1-arg update' '
 	git update-ref --stdin
 '
 
-test_expect_success 'empty directory should not fool 2-arg update' '
+test_expect_success REFFILES 'empty directory should not fool 2-arg update' '
 	prefix=refs/e-update-2 &&
 	git update-ref $prefix/foo $C &&
 	git pack-refs --all &&
@@ -243,7 +243,7 @@ test_expect_success 'empty directory should not fool 2-arg update' '
 	git update-ref --stdin
 '
 
-test_expect_success 'empty directory should not fool 0-arg delete' '
+test_expect_success REFFILES 'empty directory should not fool 0-arg delete' '
 	prefix=refs/e-delete-0 &&
 	git update-ref $prefix/foo $C &&
 	git pack-refs --all &&
@@ -252,7 +252,7 @@ test_expect_success 'empty directory should not fool 0-arg delete' '
 	git update-ref --stdin
 '
 
-test_expect_success 'empty directory should not fool 1-arg delete' '
+test_expect_success REFFILES 'empty directory should not fool 1-arg delete' '
 	prefix=refs/e-delete-1 &&
 	git update-ref $prefix/foo $C &&
 	git pack-refs --all &&
@@ -466,7 +466,7 @@ test_expect_success 'incorrect old value blocks indirect no-deref delete' '
 	test_cmp expected output.err
 '
 
-test_expect_success 'non-empty directory blocks create' '
+test_expect_success REFFILES 'non-empty directory blocks create' '
 	prefix=refs/ne-create &&
 	mkdir -p .git/$prefix/foo/bar &&
 	: >.git/$prefix/foo/bar/baz.lock &&
@@ -485,7 +485,7 @@ test_expect_success 'non-empty directory blocks create' '
 	test_cmp expected output.err
 '
 
-test_expect_success 'broken reference blocks create' '
+test_expect_success REFFILES 'broken reference blocks create' '
 	prefix=refs/broken-create &&
 	mkdir -p .git/$prefix &&
 	echo "gobbledigook" >.git/$prefix/foo &&
@@ -504,7 +504,7 @@ test_expect_success 'broken reference blocks create' '
 	test_cmp expected output.err
 '
 
-test_expect_success 'non-empty directory blocks indirect create' '
+test_expect_success REFFILES 'non-empty directory blocks indirect create' '
 	prefix=refs/ne-indirect-create &&
 	git symbolic-ref $prefix/symref $prefix/foo &&
 	mkdir -p .git/$prefix/foo/bar &&
@@ -524,7 +524,7 @@ test_expect_success 'non-empty directory blocks indirect create' '
 	test_cmp expected output.err
 '
 
-test_expect_success 'broken reference blocks indirect create' '
+test_expect_success REFFILES 'broken reference blocks indirect create' '
 	prefix=refs/broken-indirect-create &&
 	git symbolic-ref $prefix/symref $prefix/foo &&
 	echo "gobbledigook" >.git/$prefix/foo &&
@@ -543,7 +543,7 @@ test_expect_success 'broken reference blocks indirect create' '
 	test_cmp expected output.err
 '
 
-test_expect_success 'no bogus intermediate values during delete' '
+test_expect_success REFFILES 'no bogus intermediate values during delete' '
 	prefix=refs/slow-transaction &&
 	# Set up a reference with differing loose and packed versions:
 	git update-ref $prefix/foo $C &&
@@ -600,7 +600,7 @@ test_expect_success 'no bogus intermediate values during delete' '
 	test_must_fail git rev-parse --verify --quiet $prefix/foo
 '
 
-test_expect_success 'delete fails cleanly if packed-refs file is locked' '
+test_expect_success REFFILES 'delete fails cleanly if packed-refs file is locked' '
 	prefix=refs/locked-packed-refs &&
 	# Set up a reference with differing loose and packed versions:
 	git update-ref $prefix/foo $C &&
@@ -616,7 +616,7 @@ test_expect_success 'delete fails cleanly if packed-refs file is locked' '
 	test_cmp unchanged actual
 '
 
-test_expect_success 'delete fails cleanly if packed-refs.new write fails' '
+test_expect_success REFFILES 'delete fails cleanly if packed-refs.new write fails' '
 	# Setup and expectations are similar to the test above.
 	prefix=refs/failed-packed-refs &&
 	git update-ref $prefix/foo $C &&
-- 
gitgitgadget

