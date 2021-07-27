Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478F7C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30D186023F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbhG0VWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbhG0VVo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:21:44 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C73C061A24
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:20:19 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id r5so611665ilc.13
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y1pz591qtESbwQRpXIhoIrr2yRBmXd5hTfuqYXbsVwk=;
        b=GIBnWLlK0+UXqXvxksi7itRT5Q/Q5eD5BMtJ+V4P+n9oqEviSeng01o7dR8MJdnlGf
         burOaOKvky/gmNndFckZUEoCBUffg9vtKSive0Qa3e6im8+VFTy61pVvpToih4PrGjNj
         Hb9ZpeHMGBMhAlctf8EVxCVo1AdpsIHLSPtN+UQDHrSenu2AVWcbKBvWobng5hU05ILK
         LE4axTOkM7gVh/Od4y1CS8mwXO2ETH0IA8+zIfQMofL84cuptnGSa+BVD0ezqXxJWBfY
         3gc7mDMix6Pu1Bt9K9z5GZylvEYsKqU/xeXIcVx16hx/pACGkH4S4TA6ILzKfZXTFvK/
         ikqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y1pz591qtESbwQRpXIhoIrr2yRBmXd5hTfuqYXbsVwk=;
        b=gQLP9Uk5u2Vg34RY1kw3otbHw/Oc2gtNJakXmfehNmjEB0Jv3WWGYIoy/7UHGJPKCQ
         5+XVvtSaWYugtbsii0NgVz/eIiVv4brnfsLMRdSzFzcZx1wixThgZNV8miw2TyXbDsKc
         QnPAabaRXxeSrrDEp8/O3DZ0ZwqJFtLMuCTR9rVWKaAoN+XrVRlHCru1TwOWNSXoZ3C5
         Z09rsrwuu3Lzp6lKwccB+pdclgHST4vjG+83mN1ehCyUHZOGcP1U7stMuUZUM7BMNYNq
         8JJjAbN26lp/BIVtXjNnBNJoPWxwUk83MEJKgNA8bHm/OvAnJFgIqz1xyBxHq1uzYAEt
         5Ulg==
X-Gm-Message-State: AOAM532lXxtQbJTvpf8mlrZvzqkntueLcMAdwbznwpubNvGoyOjHblQF
        B4+8G0oamShV/KPoxqY8/4k5XT+zw8DoiJXq
X-Google-Smtp-Source: ABdhPJwHomkJ6l4PG2GDdaV6ggBtjQuDNfDAdgVh5/yMINHGzFBtpfmpVf7nYnSQkxf6xwH2KyC+rA==
X-Received: by 2002:a05:6e02:dcd:: with SMTP id l13mr18320380ilj.300.1627420819215;
        Tue, 27 Jul 2021 14:20:19 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id j18sm3024141ioa.53.2021.07.27.14.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:20:18 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:20:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v3 21/25] t5319: don't write MIDX bitmaps in t5319
Message-ID: <1eaa744b2411a55f2cc70d4e0b70809351080347.1627420428.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1627420428.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test is specifically about generating a midx still respecting a
pack-based bitmap file. Generating a MIDX bitmap would confuse the test.
Let's override the 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP' variable to
make sure we don't do so.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5319-multi-pack-index.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 1f0a2ae852..7b685957c6 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -504,7 +504,8 @@ test_expect_success 'repack preserves multi-pack-index when creating packs' '
 compare_results_with_midx "after repack"
 
 test_expect_success 'multi-pack-index and pack-bitmap' '
-	git -c repack.writeBitmaps=true repack -ad &&
+	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
+		git -c repack.writeBitmaps=true repack -ad &&
 	git multi-pack-index write &&
 	git rev-list --test-bitmap HEAD
 '
-- 
2.31.1.163.ga65ce7f831

