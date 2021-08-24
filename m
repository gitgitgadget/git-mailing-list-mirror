Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876A6C432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6159161357
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhHXQRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhHXQR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:17:27 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A63DC061764
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:43 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id z2so21096899iln.0
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C5Yl6mIwi9zLmDdBydnpT2kQELkZPYxenRWJSBxoMY8=;
        b=CzxfJ5MEUfsUPke3Ha1nGtnexDcMP2Q81pFwFRsVUvmcWasufeIGEaLWiiKsRIOgkc
         45G4J0K0zFBpt51wGgPobG91glZgHTEtJii9KBHbQWz4oLuorOz6bCZb2PJZ7SfuP8K4
         z10KuULIvcgW+5xCyHqNbH+9miOZDXBMIYY7dovFACmBUKpaIHNTYQhH6cR51QrTgPeb
         iGOYGTh3B3UBggc7F4hLAllvpBrxPY0cof2HJ7qE8cgCYWQF+2ba1PeuWH7kM3umIZjb
         CyzhIxatDiBh19XhVYYH28Y58wIDcsXAXkOtOFJzr5r2cZG3kBqPA2moexbgiSBASUew
         pVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C5Yl6mIwi9zLmDdBydnpT2kQELkZPYxenRWJSBxoMY8=;
        b=JwE5Nj1SABNtUBQ1niP1p7lGWDIeCC6RRfHu31uPv+fYNWfVysKXbZ2b7f1Z/LZ2fG
         ZiqE6zqoKRXiCdv0UG4t7T2SvVmAtRUQpIMGub/UKouO8KBTY4GTr9KBD3qSZ3jBHJAQ
         I+6LjT30MozkRMHyO3CMaUwZl4D+G//vKgWd/NcjotthHirSRFS5TZ/9h4A7tYeH2gR/
         CPi7BJ2ITKgfutxLIlZrVVVlYfH9YKQCamkifUjAyenNgavg9Sr0gcGgdb5ucw26ifVC
         e63q+DyqC/MobyChehKvS9N0agx2hDFregMf3UuqLNlr5+WvaXLzW75mZd+9VGrPR41j
         OeRg==
X-Gm-Message-State: AOAM531Jp9utfCnBanVWKTVFKGWcKhX1A0MByMaxrJnq/LEDrqBHrgRD
        0xGTiWTi9eNprUtnCaQ7NPqkAUjRKm4NqwJG
X-Google-Smtp-Source: ABdhPJykJs8dmVP7qzx35jq9mEne5gVcOZKynApwRjBRDDj4qZviXBs6D+DNiBYw9kwW0rJ51Ma4og==
X-Received: by 2002:a92:d646:: with SMTP id x6mr23011893ilp.280.1629821802468;
        Tue, 24 Aug 2021 09:16:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m1sm10136777ilf.24.2021.08.24.09.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:16:42 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:16:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v4 20/25] t5310: disable
 GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
Message-ID: <4e0d49a2dd6856763486bf7931199494a521d29c.1629821743.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1629821743.git.me@ttaylorr.com>
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

