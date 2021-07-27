Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B67C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A4E860BD3
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbhG0VWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbhG0VVo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:21:44 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0D1C061A1E
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:20:17 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id f11so430765ioj.3
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C5Yl6mIwi9zLmDdBydnpT2kQELkZPYxenRWJSBxoMY8=;
        b=pIBa5LbrcD03Cekba/x7kbpaXr4InjV2tlamzh2DGrkHw0HHa48qZMJq4FYq2HzRxh
         aUGOsQJ99Stn/c3DxZHC18JVQNAaoXkRv5ck70ifoAoglQHUhqFRLb8w4Rt5WYS+nrOx
         8hxwwhA8AJMSlV9EYegCaoZmHuWuQ3KcamZtV+O+EX2ATYirMBcWF034VRN+lHVljCGb
         psGh8mzguGJduvLi8rDLzKjS6kFrWHANpofnHIxXcBrcYTQ6H+b9xtVTpFSWH9+wcruz
         PU6R617MsKzzoWM6S54RzpOPQQqiMJROBq4wl6o91kDlO9OpvnqjHMWbuI9AVqD6K16x
         3KQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C5Yl6mIwi9zLmDdBydnpT2kQELkZPYxenRWJSBxoMY8=;
        b=SbMAP2JA9iuhET78E3lmShebdujLGLi/xFtB7n2Sbet/R8J3u2c6h7KBb6wEh+f4Pa
         mDXzkgxZ1MvJ+fTvL5hQ8tnxZX7WMtlz2BMhyGRuyr88weY/A+WQGhxsGmPTzYzUrbao
         RHzLnsYf5yo6EeFRb9SPuvO1gk+OsH2xwc8iY0C4oduv8vqcZNu7u+BH+SOEtK2sZNWG
         vr2+oH0mCRJANgDtbWVMC+0XPW2JHBfngb4XRP1YcfpRkAcRnOHt0aedAE8mwdqCKJWw
         yCL0cC29nP6FuwwwAWeMa2kwDJAr45xbUnGGZ9mHuWCf1WZI3RCNgEI/l5z/17EJHg3C
         ppbA==
X-Gm-Message-State: AOAM531YM99NGNTPKaxZQdKjOd6qAWZwXhFT1SO/Ol6byAX0xto/jYau
        NchCLYo4eZz5v6pFNGxi80asgP0mt1zoqzqQ
X-Google-Smtp-Source: ABdhPJyIdBFwDgKQ4+2dUk3Dch4iGxa1dl9Pzb+gUMe8kc383A5EN48vVNKl1L1Wek4A1J6hu78Xsg==
X-Received: by 2002:a02:c496:: with SMTP id t22mr23631858jam.80.1627420816537;
        Tue, 27 Jul 2021 14:20:16 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id x10sm2314786ill.26.2021.07.27.14.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:20:16 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:20:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v3 20/25] t5310: disable
 GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
Message-ID: <6a708858b1048f83c6165c452ab238cb017b7713.1627420428.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1627420428.git.me@ttaylorr.com>
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

