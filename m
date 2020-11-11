Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA00C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9580F2087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="p8C3bHAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgKKTnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgKKTnq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:43:46 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD80C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:43:46 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g15so2158057qtq.13
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7JAF9xt14K8KYQ7q4EBRpopn6x8URZ3ztlGC19fCCI4=;
        b=p8C3bHAoMZPdUU/jDKZcaclR/uSeXp8P1iPbmYQsVgcLvqAyS9+MRAQcbBrNWJxDwH
         K+66b1rSuRi8DQKofJ65EKX/P36jw9EGPQ/oz7CjNIlXTdPgvIcHUapHUYJ0MorTVZl7
         KwewtzmD9Jr2RgAn1vZx/qPcydGjmalkDTlX0YKj+kpMwN/HFutbw+jHwEXe5zF85QHI
         lvZLAOw/sJkCEOmTskUnIG/4zzkRl4iDZ+0d+yBCl1BJaYW0kwZeKeyVOQ5hLJZLMU62
         OSmapRWJIOXXEuADX2/LJ/DGl64Smg3/qAdycqKbsWD1TEFar1TvBrB39kVShcNsYTWS
         X4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7JAF9xt14K8KYQ7q4EBRpopn6x8URZ3ztlGC19fCCI4=;
        b=mZgCm5YqDzXiSJpmWIOEAw0LUgXaBn9/fpfFJOe1Gj74/uabKW9g0Ia2bQV/j6nsTz
         nng8eW4u8662DbLwDztk2FIht4kTbZMeVWQjpd9/XuAE4LNgHORZH2/ZO0Nsy3Dx8MnJ
         /b/gtxLyym/0aQFX1N7YWgHc0P3CMfqVI2WDpIEi7fHVPyneFMT4C/vDUDSv9xww+mvh
         Px27KATBJTRln9k/5iAvTtEwwRVVmAzIEsIJkmAwABfLiQE80KTYwzndjUfBXmgXvdFC
         +NKE9bpfpJ8/4o/VjoxRoVKk1+a0HsWiCqe8Ry4bcuds42AYEKKWaOG8EtX0T22cSuWN
         2iRQ==
X-Gm-Message-State: AOAM531xtZaB/h8840+nijRu0cZmZXqiRnDD3FrwawrEtSJ5t5o/WKdk
        ueOUOcYijFj6EdolMmGnurdXgqPTGG4inxWi
X-Google-Smtp-Source: ABdhPJxPxpOnxYqlEvHM4lewwkiKrVhfnBHroqXhaZRFqp+64+tdisyNm+asQlfRsmrUABOHAiOpOQ==
X-Received: by 2002:aed:3383:: with SMTP id v3mr25132344qtd.353.1605123824133;
        Wed, 11 Nov 2020 11:43:44 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7ccc:9a51:1ad:2057])
        by smtp.gmail.com with ESMTPSA id q189sm3147890qkd.41.2020.11.11.11.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:43:43 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:43:41 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 15/23] t5310: add branch-based checks
Message-ID: <9ab4b94b3573346b31e710486799ab3d95bade8e.1605123653.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The current rev-list tests that check the bitmap data only work on HEAD
instead of multiple branches. Expand the test cases to handle both
'master' and 'other' branches.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5310-pack-bitmaps.sh | 61 +++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 70a4fc4843..6bf68fee85 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -41,63 +41,70 @@ test_expect_success 'rev-list --test-bitmap verifies bitmaps' '
 	git rev-list --test-bitmap HEAD
 '
 
-rev_list_tests() {
-	state=$1
-
-	test_expect_success "counting commits via bitmap ($state)" '
-		git rev-list --count HEAD >expect &&
-		git rev-list --use-bitmap-index --count HEAD >actual &&
+rev_list_tests_head () {
+	test_expect_success "counting commits via bitmap ($state, $branch)" '
+		git rev-list --count $branch >expect &&
+		git rev-list --use-bitmap-index --count $branch >actual &&
 		test_cmp expect actual
 	'
 
-	test_expect_success "counting partial commits via bitmap ($state)" '
-		git rev-list --count HEAD~5..HEAD >expect &&
-		git rev-list --use-bitmap-index --count HEAD~5..HEAD >actual &&
+	test_expect_success "counting partial commits via bitmap ($state, $branch)" '
+		git rev-list --count $branch~5..$branch >expect &&
+		git rev-list --use-bitmap-index --count $branch~5..$branch >actual &&
 		test_cmp expect actual
 	'
 
-	test_expect_success "counting commits with limit ($state)" '
-		git rev-list --count -n 1 HEAD >expect &&
-		git rev-list --use-bitmap-index --count -n 1 HEAD >actual &&
+	test_expect_success "counting commits with limit ($state, $branch)" '
+		git rev-list --count -n 1 $branch >expect &&
+		git rev-list --use-bitmap-index --count -n 1 $branch >actual &&
 		test_cmp expect actual
 	'
 
-	test_expect_success "counting non-linear history ($state)" '
+	test_expect_success "counting non-linear history ($state, $branch)" '
 		git rev-list --count other...master >expect &&
 		git rev-list --use-bitmap-index --count other...master >actual &&
 		test_cmp expect actual
 	'
 
-	test_expect_success "counting commits with limiting ($state)" '
-		git rev-list --count HEAD -- 1.t >expect &&
-		git rev-list --use-bitmap-index --count HEAD -- 1.t >actual &&
+	test_expect_success "counting commits with limiting ($state, $branch)" '
+		git rev-list --count $branch -- 1.t >expect &&
+		git rev-list --use-bitmap-index --count $branch -- 1.t >actual &&
 		test_cmp expect actual
 	'
 
-	test_expect_success "counting objects via bitmap ($state)" '
-		git rev-list --count --objects HEAD >expect &&
-		git rev-list --use-bitmap-index --count --objects HEAD >actual &&
+	test_expect_success "counting objects via bitmap ($state, $branch)" '
+		git rev-list --count --objects $branch >expect &&
+		git rev-list --use-bitmap-index --count --objects $branch >actual &&
 		test_cmp expect actual
 	'
 
-	test_expect_success "enumerate commits ($state)" '
-		git rev-list --use-bitmap-index HEAD >actual &&
-		git rev-list HEAD >expect &&
+	test_expect_success "enumerate commits ($state, $branch)" '
+		git rev-list --use-bitmap-index $branch >actual &&
+		git rev-list $branch >expect &&
 		test_bitmap_traversal --no-confirm-bitmaps expect actual
 	'
 
-	test_expect_success "enumerate --objects ($state)" '
-		git rev-list --objects --use-bitmap-index HEAD >actual &&
-		git rev-list --objects HEAD >expect &&
+	test_expect_success "enumerate --objects ($state, $branch)" '
+		git rev-list --objects --use-bitmap-index $branch >actual &&
+		git rev-list --objects $branch >expect &&
 		test_bitmap_traversal expect actual
 	'
 
-	test_expect_success "bitmap --objects handles non-commit objects ($state)" '
-		git rev-list --objects --use-bitmap-index HEAD tagged-blob >actual &&
+	test_expect_success "bitmap --objects handles non-commit objects ($state, $branch)" '
+		git rev-list --objects --use-bitmap-index $branch tagged-blob >actual &&
 		grep $blob actual
 	'
 }
 
+rev_list_tests () {
+	state=$1
+
+	for branch in "master" "other"
+	do
+		rev_list_tests_head
+	done
+}
+
 rev_list_tests 'full bitmap'
 
 test_expect_success 'clone from bitmapped repository' '
-- 
2.29.2.156.gc03786897f

