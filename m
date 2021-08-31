Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7F8C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1B760ED4
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241218AbhHaUwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhHaUwo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:52:44 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCC1C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:51:49 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id g9so740090ioq.11
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+DRaLVOHAM1ShuPqp6HHxzma3WXLZmd+bPW51wq5EsU=;
        b=bqGI1MkN/yglEu/bxZ5gJD8TdIKVQiNemHDC0EsSQ4HI94ZXf0Ors+/7JMiCIC9gMI
         QXA7olHsQd5lKfH31A6IICXjo0Y/tqmDqoZruw8WAO5Y4U6ZXroNo4WlhP5ju+NoLEfn
         xwzhsmz4KQtlxCZfi0kZinDg1+l5bIB1EXUucPaIGNepieDt9H5KeGqOjXyJI+oylOG8
         INB6v5B9LN19L1615nI1yUv+SeP8e+yUR3iBWKymK7hb/g4oZCzglHd9sB8jqHX9wAjK
         KJz+uxMES3DZ14fJq0WPIbMrLSBGw3l0vQmz0r4D6XE6fEt1aEeVL02gmNHR3zdreL6c
         67dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+DRaLVOHAM1ShuPqp6HHxzma3WXLZmd+bPW51wq5EsU=;
        b=SrQSPwSpGHo6WzlWMIPOSUv0W6c2DphWtWZZG49SHi5HNNpsPiSu8utD9OrAsu34z2
         LXKXXBPLEHVgF51IVpIwwvgf92MZ1dwZva0MW+XIwf85pX5TuaJqm0GnULtzHTmphbP6
         PvO2pD+J2vd0ja7nWKFKJxiPY1/5slpywC0IA+CNi7J7CZ8W70de+AppSJtXdAAlCtg/
         q/Wnw4wFRIzST1LULQoH+2OeknsR3u7E/cPu/HfQOgI6gAqJfwzmx1c5YhIl1+WGjm76
         mXZvEHxEiWrTEQPwZ8ZWFDB5t4pbRFM60yM3bkX/SvYgCtojhPoM0peOacFqzwfGMzFq
         S89A==
X-Gm-Message-State: AOAM531ZpDSreTc1BssGfr0ziKcbcbrZeic2TdoUN21B252i6lzBd9Ts
        KS9oDdezv8fMRBpL2EI7kagTnrbmuX0TUsTA
X-Google-Smtp-Source: ABdhPJzArW0PGFl9atkVEDpUeuH88fB6n5WaPrzGdD+nooZcfPuSdS/eMTmTIEJs1+EMfp5VbaCk1Q==
X-Received: by 2002:a5d:9284:: with SMTP id s4mr24270427iom.131.1630443108545;
        Tue, 31 Aug 2021 13:51:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q12sm10119559ioh.20.2021.08.31.13.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:51:48 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:51:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v5 03/27] pack-bitmap-write.c: free existing bitmaps
Message-ID: <d469c1d8f6ae521621c72fc15d8c4b3a0d7e57cb.1630443072.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing a new bitmap, the bitmap writer code attempts to read the
existing bitmap (if one is present). This is done in order to quickly
permute the bits of any bitmaps for commits which appear in the existing
bitmap, and were also selected for the new bitmap.

But since this code was added in 341fa34887 (pack-bitmap-write: use
existing bitmaps, 2020-12-08), the resources associated with opening an
existing bitmap were never released.

It's fine to ignore this, but it's bad hygiene. It will also cause a
problem for the multi-pack-index builtin, which will be responsible not
only for writing bitmaps, but also for expiring any old multi-pack
bitmaps.

If an existing bitmap was reused here, it will also be expired. That
will cause a problem on platforms which require file resources to be
closed before unlinking them, like Windows. Avoid this by ensuring we
close reused bitmaps with free_bitmap_index() before removing them.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index d374f7884b..142fd0adb8 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -520,6 +520,7 @@ int bitmap_writer_build(struct packing_data *to_pack)
 	clear_prio_queue(&queue);
 	clear_prio_queue(&tree_queue);
 	bitmap_builder_clear(&bb);
+	free_bitmap_index(old_bitmap);
 	free(mapping);
 
 	trace2_region_leave("pack-bitmap-write", "building_bitmaps_total",
-- 
2.33.0.96.g73915697e6

