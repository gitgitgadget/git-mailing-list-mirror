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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE0FC433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8678561164
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbhD0KkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238406AbhD0KjS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:39:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD56AC06175F
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l2so6600849wrm.9
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VpBZen3Lth4dlmvnI2tC+wR6jk3nO8w4XkcRci+SeGU=;
        b=IgLot5WpNociIWGly3TFyp8gNtgtpte/zwdvDsLOzowyHjPqgQUpWnzFyy6vmd+agJ
         WOVTx5YgLJYcaKCFE/ABMkyvNP5LKnKovMp0gqZhnCj2nqfN/P5S9XeM/aCjhlo3J4UI
         MMQPBHju/xDCh17EPVwqdDmodsPF+DyyiuTwSYqIvAssBklLbi5GrAIrgRKCZ8/2AHMd
         od0cMvETEafyZS6Hm2+nnn0aKbWwlgLHK85ml/V62CxMNAfiGpxcHnuWPNenfzlkCAqD
         rXZjN6sp6Xm9f92GoagKjvwDkxwuFoggxGP8+YSELpaAnFwo9EZ3t6Z62rkQPyeDpi6f
         Es6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VpBZen3Lth4dlmvnI2tC+wR6jk3nO8w4XkcRci+SeGU=;
        b=cgAOKRg3VX/ok85l3tZsmXjwmOmIiOkhLqSsLjEFCaDsVnEzpVyG2TkcV7IWVGcwx2
         bfHammAciYOvy8BGclsbjTVY+q/mDAspQAvHaaV0WDyfD3KoJvy7y+kAWy3h1GaIMjtg
         gEkQU/9pNkXvVqlKTg1HKe9LDlN2otLJiG+3n852AVHTXFyhIjEShoIN4da0uiQV9OYr
         IVRTgR8MpGvsd19GfX/+Fq/1O1DS/XW5cMIzKTndkXOygm+WbnXe4/yM3prLu6vCPu+5
         UHKVCHnmhkKPnVh5RK1MQ/WYFgmmjikqxfMp1ljSeTHi4Ipu1ZbNh3AMZVqnb4N+36pz
         x5Vw==
X-Gm-Message-State: AOAM531hlJhxXnuxeLfXpr/e80H3s2/+jLWA82JX3fIsSC6EgPpwW9jb
        wrQDhyHXygfJCuNaP8I8N59G9GrPou4=
X-Google-Smtp-Source: ABdhPJx0KQnhBX7S+u45Lqw/RZQUhJAljpW0WpEh5XjP7tubUaONwA60/QZLSKvknfO53XTuJuEsvQ==
X-Received: by 2002:a05:6000:114e:: with SMTP id d14mr28316871wrx.281.1619519913730;
        Tue, 27 Apr 2021 03:38:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17sm3404109wrd.89.2021.04.27.03.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:38:33 -0700 (PDT)
Message-Id: <fcc2b714dd5067732fa822c9ef3347636fe2138d.1619519903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 10:38:18 +0000
Subject: [PATCH v2 17/21] t1404: mark tests that muck with .git directly as
 REFFILES.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
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

