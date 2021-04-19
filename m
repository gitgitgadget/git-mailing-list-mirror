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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14566C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D63F761166
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbhDSKy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 06:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238194AbhDSKxq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 06:53:46 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78999C06138E
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w4so29782103wrt.5
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cJBNVo4/7xaNwI7HkTYVfC2QG9mtSrqhCWXilZ5Qaws=;
        b=igkTX281PMC+NB6qEDCdRzXCsT4RhNw2RPL6Oy+3lFqbHh1j7I5QryYO1WkY0PrCjj
         AyJil+X3T+sE5Mlqmqtnj6VSonFa6Rrl+pryhyTDw27K/BQG1RRPWEkf9H7PPxEwFL9n
         6Rz8vimw19di3hUdFHO4ARBHbCzbDNQNruMSfi3nhpXEwyQRaloIiqTRFNnjWqnu2iPb
         9wYFmVp3eJoNYy4X4Q0XS5/UMdkOl53DxwjQjtJaNTqjLN0QoMf04SZDgHP1sADI92zq
         5YfJK2q+4QGuiIflSOphGfSAwG7sRHgy6JZ/Nky0i3AfgAUJziKTzX7rUuDR4r5j8G8L
         6u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cJBNVo4/7xaNwI7HkTYVfC2QG9mtSrqhCWXilZ5Qaws=;
        b=Aw78slucrcfAG0AeQBKgMcC4F1zJUyHNTLoyOB3o7hVD8mbQae7zqv0dUl1hg8kgwa
         mSu/7BT8PfAI5GJisda54srn1duohKtdYLyWwCKYHm0ZoyyvW7x0lkO+AhyBJRvnCIcM
         vHvMaSS/hjYkkedS+K/L/1FZ8veHXLwMNAdxrYkhftMSbQ8++mpYldq2ie2oWvT/xS58
         3tBhpbqXttTWT4+9VQEEdEIu+WLc/yPK7DAr1PnukBwyVRZUE57f3y0m4ZhtD0+fUlH4
         8yhYta1cFZ5Mjf81QylL5+qxRRPIgRvWsnjM1SbDQ93jTwOuAB2wLA64tbOuV2TPcVij
         fIiw==
X-Gm-Message-State: AOAM5331Obqtx5TMZIOpQ9ygnwAe6eoPY0O3bx5bovj+tflySjoCNL9K
        3BcebsZOdIekK8dGDS+l1+vqJIv5Y40=
X-Google-Smtp-Source: ABdhPJxlcgZIQct23vJQjg83SIpFgsSOsDZbBULcvtJ7RH/OPFrJSNdi/SW91mcFi7+MSMDX16srFQ==
X-Received: by 2002:a5d:66cf:: with SMTP id k15mr13929282wrw.404.1618829592275;
        Mon, 19 Apr 2021 03:53:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y8sm7426388wru.27.2021.04.19.03.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 03:53:12 -0700 (PDT)
Message-Id: <a3abc4f70e7d6bd833024f2c9b42ff731896e14d.1618829583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 10:52:59 +0000
Subject: [PATCH 14/18] t1404: mark tests that muck with .git directly as
 REFFILES.
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

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
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

