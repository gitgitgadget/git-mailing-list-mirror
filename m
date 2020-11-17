Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8842CC2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D56241A7
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="I+3YWqrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgKQVrq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgKQVrq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:47:46 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5EBC0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:47:45 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id k4so12429652qko.13
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g49Z2A6JCu5TR/TsL2TYsryee1VVppQfQySl90waqeY=;
        b=I+3YWqrUJMKBHFdN4p0E+5Ioh1SrLkh5NjZ4rGboORRkRRnGqQv5vKoTAzOXY3j5J0
         Sk4tS8Z/1OesjeTzBa4Cgnu/R5lIhzLKScHZI8moyQqdFmwh5wQkuBLKqR1DFfXyPfak
         HYs+Qo/qMqOlfkPXUNURKpjcd1wj1dOIMWvISD4hKkJ1Ja9mGBFhJlumIq8czD+BKEAd
         9oWmYsfwv/1+wmcAU0FJzBOsl1O4vzPHXtgJNGt2V27rhAmhgsTvIaCGxzLqywbZGiqP
         1DsD+h454/mee4SSzDS2+kjAHsejJDRbCZgPb9xMMYolmvObkc52hZqe/6CS+siXHGyu
         X0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g49Z2A6JCu5TR/TsL2TYsryee1VVppQfQySl90waqeY=;
        b=J+AQaVshMIlwpHkJiKhdDF2ENnupmLib4g/Hp7MqRtH8QQL7ZidMCR06eTaqdnXN7p
         Qe07a9pvJfh6cQFOj1Ic37Um5Aa/rAnNSUQP30xTNFm9wqniGoPD5xh3SlT/aUNCenz2
         3s+e1BedtHSmuHUeoJxvDS2X8XkPsuqR5P2w8ZjnJhHUtskPuykhMp9vjmVxLYXh70cw
         m6JTCK83GzFG+1zw088ocoe4+eD1e56sBp6lZ5F/B1UFVjxQTECTAtf4yr347ea2gJsk
         j6AkiYMemb2V+Ku5UR6kkZGJ7WB3ZPj8/uZgUvMrq2BgZLQqzkXlJqK8r19o0nUzSNDt
         vuVw==
X-Gm-Message-State: AOAM53179gkVjDJS28W3RA68Iu9WM4wCjFoDm0eC7v6pjLFCXpmU7KpL
        zFayze0cW3nwttpC/rJ/h//uSaneumuP2wRn
X-Google-Smtp-Source: ABdhPJyP9VVHQUh6bhAyySgXUFRgMa1v0CZGYaWjz3mQ3ONq/ct0jxvcxRUv5ZxxpIarc4Bb+BbZzw==
X-Received: by 2002:a37:7cb:: with SMTP id 194mr1732198qkh.289.1605649664663;
        Tue, 17 Nov 2020 13:47:44 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id 131sm15385555qkh.115.2020.11.17.13.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:47:44 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:47:41 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v2 15/24] t5310: add branch-based checks
Message-ID: <8b5d23933301988e42ddd57687e0535f8749367f.1605649533.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605649533.git.me@ttaylorr.com>
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
2.29.2.312.gabc4d358d8

