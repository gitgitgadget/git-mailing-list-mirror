Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E2CC433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 21:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 390F461212
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 21:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343772AbhIQVWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 17:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343668AbhIQVWt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 17:22:49 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82628C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 14:21:26 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id x2so11675869ila.11
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 14:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dViVSMM9wxtKjXJwwl3RE2HtW0ysTkcAVhFYfSvCLx8=;
        b=aK23balUOV5Uiofc+MqA3iJzcQaStd/Hw+yrDzWbS4VqARMvr6w/l5Uy7OXjQJgMv6
         FnlAO0+lYT4O0F36rk8LNvBN6MX+XZCON/gOb9FQ2rN2uC5Bfcso5a4ZG6RCbLOMfgEM
         vEVZbymGQg/VrEXL2WdkC9H4vsNBaz6OSYhyXjPH1omQ0Gjc9q5oiCtddydMPy8LkQ3b
         LCgqHWg5zPivya1o2o7jeSO+cDzXbPfgO2tRNJkXdOf8d6BRxmTUi91hMzLI8GzxoU/G
         2Ix36k3GQxiqvBfBzmHWzWPW2W5qc2MddhoFjoxVdx0JTqiB2D2HcK/PhsmZvXbyiOse
         NYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dViVSMM9wxtKjXJwwl3RE2HtW0ysTkcAVhFYfSvCLx8=;
        b=auqSDPebAjbGLgQvLHK9DD6rvpbHIm1FSE6Ljvhwp1Jpml4+sh7QiWl3YLwbKmMuVs
         ASh9wYxAKIIXMbEIMoeUi2iIl7MiZPtn/Za/XSY4eA+BprxYn3WQy9hiVCT9zpIEVGlX
         7ikUCsHqNTOHNoQINpXpeB/xQo7IxDazmimE5VzCmDiZK7+ANfEM4RK83pmO/PinmtCJ
         KmLLeej8MygO7PpDUxSejcpSut9PyWVBttQFY1dj6ycWUtaPHkQzmQyo94s2Mrc5JlNj
         tmoS4mYjREjuv3JAN9oZcpf7vKi2bIQL/jeSxi40CCHbYZSRsX7ECzSsucVgQjF8nKqw
         GyRg==
X-Gm-Message-State: AOAM532gkM5W441rOMlRU2g7938DWxWPwBu3Quqm3BCg0fNfBGmpjrDi
        adUYgM+J4Upo2MrvFxcCb8Ojs1Y3pQk2BAw3
X-Google-Smtp-Source: ABdhPJy6Q+rBTIjDhYpFCvbRZ1SQysoGriOpi+kI2BlHasIdQnM27XiEHo3d75u79mc4HEdQRHkWXw==
X-Received: by 2002:a92:de0e:: with SMTP id x14mr9613907ilm.259.1631913685837;
        Fri, 17 Sep 2021 14:21:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k14sm4283278ili.35.2021.09.17.14.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 14:21:25 -0700 (PDT)
Date:   Fri, 17 Sep 2021 17:21:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v3 5/7] p5326: don't set core.multiPackIndex unnecessarily
Message-ID: <191922c8f28c338ab3aa4faa57d75770a9eccd02.1631913631.git.me@ttaylorr.com>
References: <cover.1631049462.git.me@ttaylorr.com>
 <cover.1631913631.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631913631.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When this performance test was originally written, `core.multiPackIndex`
was not the default and thus had to be enabled. But now that we have
18e449f86b (midx: enable core.multiPackIndex by default, 2020-09-25), we
no longer need this.

Drop the unnecessary setup (even though it's not hurting anything, it is
unnecessary at best and confusing at worst).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/p5326-multi-pack-bitmaps.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/t/perf/p5326-multi-pack-bitmaps.sh b/t/perf/p5326-multi-pack-bitmaps.sh
index 51b5636259..a9c5499537 100755
--- a/t/perf/p5326-multi-pack-bitmaps.sh
+++ b/t/perf/p5326-multi-pack-bitmaps.sh
@@ -6,10 +6,6 @@ test_description='Tests performance using midx bitmaps'
 
 test_perf_large_repo
 
-test_expect_success 'enable multi-pack index' '
-	git config core.multiPackIndex true
-'
-
 # we need to create the tag up front such that it is covered by the repack and
 # thus by generated bitmaps.
 test_expect_success 'create tags' '
-- 
2.33.0.96.g73915697e6

