Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723C5C433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 21:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59FD2611C8
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 21:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344278AbhIQVWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 17:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344298AbhIQVWv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 17:22:51 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1320FC061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 14:21:29 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id f6so13995568iox.0
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 14:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YsCedmcBKpsdlQ1Q73IFWLzrfs5d0RaCynG0qBFcgr8=;
        b=33Qt7TuHuhYAIRHek4amDNnjOlHSGtm91P/Bckz9rKw8cxtBKclJT0LA4DMJNJmKT7
         lC90m0+zSroUMGdbX5HNuAgdo+IpMuVZamqS3RcxEtshfp98oNcWTnLZSJ2ZgA++aNWP
         8qDsK1Ez2bADmIDqFvPr/x6cHLmD9YKJl3YlMcA93TzO8TBnAUrML6oDi9yE7CwzmHPK
         Nn+1G+NxpnWU1DaGYetw5KaTqtZkxKhi7QONLaJYoOl/rPf9I2G48f1m2F3URq78LuB9
         K68vOH+EN6ugyPGUAbMOUDEpF8BufD9MVMRxWkU7DP4KxY7cFgqyUZfR04Sxtm6T1l6O
         U1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YsCedmcBKpsdlQ1Q73IFWLzrfs5d0RaCynG0qBFcgr8=;
        b=Tsgd1RnUY45e9SQp4U3Jt/ZjCalH7yQ9fXbTfKArrFoKTNDFGj1BDMq1bh7gU6oivw
         0In0u83l9CGfjRMpmfvnTmXzXz8qKMexC/jiu9HBNYkEbK9QPhZ3PF4+xz1Hm/KolabR
         +XUeJgr7lhvPTGXFD6Og0JFzIor+qg73gCqFP80V5c8wDxdIHOpMnybhLs5u+qvvJuTt
         xZ1qarJWJrkmHalukVQWgaRKBVlE4L4bB3gWAeG8FoSodzoTEa2rptxM1IOuwGWr1r9n
         lEgHHYE56tsK7wYdzeUFvyt9cdLhQ1RGRfp9Fs8EKGyDI3wiE94ngRcdg6QEz62rxaK8
         L4jQ==
X-Gm-Message-State: AOAM531IpKI3XF+QL5pDR08T2Tj7vGrqcsMgOYIwfYA+hI5ojCShdlW6
        OJWzd8t4cWtdkNXwN4n+TWSanqk/CUo2wA76
X-Google-Smtp-Source: ABdhPJx9E8iJurtc8qZrk06YUKfOnsYWwBMArozWIOR5dvhMcGwUDNtozYL0mdDMQbbir7sU+7PZkQ==
X-Received: by 2002:a5d:9693:: with SMTP id m19mr10244686ion.72.1631913688395;
        Fri, 17 Sep 2021 14:21:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y6sm4412922ilv.71.2021.09.17.14.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 14:21:27 -0700 (PDT)
Date:   Fri, 17 Sep 2021 17:21:27 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v3 6/7] p5326: generate pack bitmaps before writing the MIDX
 bitmap
Message-ID: <59b6914ef864f31b53ed7e89f73db5c35b298449.1631913631.git.me@ttaylorr.com>
References: <cover.1631049462.git.me@ttaylorr.com>
 <cover.1631913631.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631913631.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To help test the performance of permuting the contents of the hash-cache
when generating a MIDX bitmap, we need a bitmap which has its hash-cache
populated.

And since multi-pack bitmaps don't add *new* values to the hash-cache,
we have to rely on a single-pack bitmap to generate those values for us.

Therefore, generate a pack bitmap before the MIDX one in order to ensure
that the MIDX bitmap has entries in its hash-cache. Since we don't want
to time generating the pack bitmap, move that to a non-perf test run
before we try to generate the MIDX bitmap.

Likewise, get rid of the pack bitmap afterwords, to make certain that we
are not accidentally using it in the performance tests run later on.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/p5326-multi-pack-bitmaps.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/t/perf/p5326-multi-pack-bitmaps.sh b/t/perf/p5326-multi-pack-bitmaps.sh
index a9c5499537..f2fa228f16 100755
--- a/t/perf/p5326-multi-pack-bitmaps.sh
+++ b/t/perf/p5326-multi-pack-bitmaps.sh
@@ -12,11 +12,18 @@ test_expect_success 'create tags' '
 	git tag --message="tag pointing to HEAD" perf-tag HEAD
 '
 
+test_expect_success 'start with bitmapped pack' '
+	git repack -adb
+'
+
 test_perf 'setup multi-pack index' '
-	git repack -ad &&
 	git multi-pack-index write --bitmap
 '
 
+test_expect_success 'drop pack bitmap' '
+	rm -f .git/objects/pack/pack-*.bitmap
+'
+
 test_full_bitmap
 
 test_expect_success 'create partial bitmap state' '
-- 
2.33.0.96.g73915697e6

