Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB2BC43460
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA3A61178
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbhDISM0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbhDISMW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:12:22 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1867AC061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:12:08 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id x17so6827317iog.2
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C5Yl6mIwi9zLmDdBydnpT2kQELkZPYxenRWJSBxoMY8=;
        b=VoZVf3tnBvzAYm0NhNA5kOAe3FMOqSbel9SiYhDlaUMsz5K6UQn6FM1otTNj8Dij6J
         +5sOe5pFmZk76DOhApIfiBxlAhfR3I5AeCY/datEg5aX9TYnAx709sSI5/hKI5nOyrHn
         24Cw/8sFWeWI8eX7hpJsBJdu37Vk9asmm+L6yMbkHvtF2/gH1iyzG0VQapiInL7YD5Hq
         dM3/dLb9x6dZHuyXW4K5AqU1tcnyc8DZRhQbUpz7EmrwP7nYz8Tna7cQ3m6w+HzWH1Pn
         u8tQanzfiGrxrOMS17pbe7ELesBlNd70G7662Wj7QAm5UkEGjKGF9HfJtclK+j0gKEtp
         0QYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C5Yl6mIwi9zLmDdBydnpT2kQELkZPYxenRWJSBxoMY8=;
        b=RtG9A7qrL8FCoe6onkzMcmYssmU1F5vE/V8xWYgF6+9G8LUXkgCWg2Moax0NFCqgHk
         ydrHZ8YbS9WVBLoYteISdCvT84gE/IhaaWcjA1R1p9XssTTAxCv1aKc3gzEZw7cSo39Z
         8MQFFU1kbzzhkn9RBOJw20a+JQJyHs1Hu1f4O03NjnMZjzzURMJR1E8+6S8ptFKYqDzD
         zm0crV6lc5j5XYjfTkeH1B6JB7VbgNhxBVZgrRzingRd+msasCAlfxKVR5mf0E9cz8Ey
         vZNYslc+MSPO1sjxBpJbQaG2oDwzs070/tsNjVy1PUvk8PMS4lJ2IDJSdHheYwnpCVSD
         xfxQ==
X-Gm-Message-State: AOAM533qDFxUhNFt1qt7RyIcqmycVZAkWAd2urIKTNro8DaYq5TbLB2Y
        fBXivn6/KttnyBW86ix6uh7/BusoAPsKEjH1
X-Google-Smtp-Source: ABdhPJwzFTVm8+kPUcjwp442F0DgKwzJ9bd9gVwy7R9uVA4kgMcYewlb+VaOCo7UAWmwdpctV3kl4Q==
X-Received: by 2002:a05:6638:d4e:: with SMTP id d14mr16059466jak.103.1617991927333;
        Fri, 09 Apr 2021 11:12:07 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id c19sm1505680ilk.42.2021.04.09.11.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:12:06 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:12:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 17/22] t5310: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
Message-ID: <8f328bb5bc46149bd05860c29be032fe219951a4.1617991824.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Generating a MIDX bitmap confuses many of the tests in t5310, which
expect to control whether and how bitmaps are written. Since the
relevant MIDX-bitmap tests here are covered already in t5326, let's just
disable the flag for the whole t5310 script.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5310-pack-bitmaps.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 4318f84d53..673baa5c3c 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -8,6 +8,10 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . "$TEST_DIRECTORY"/lib-bundle.sh
 . "$TEST_DIRECTORY"/lib-bitmap.sh
 
+# t5310 deals only with single-pack bitmaps, so don't write MIDX bitmaps in
+# their place.
+GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
+
 objpath () {
 	echo ".git/objects/$(echo "$1" | sed -e 's|\(..\)|\1/|')"
 }
-- 
2.31.1.163.ga65ce7f831

