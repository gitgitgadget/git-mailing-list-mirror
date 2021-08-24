Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD02FC4320E
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EBF960F4C
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhHXQQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhHXQQm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:16:42 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BC2C061764
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:15:58 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b7so27064388iob.4
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dj8bSAAyMgcbrNeyMR+hYayZQXjJBIgzVAauMYnE+HQ=;
        b=bEh6mbeofVcfebSzQxKBOP3K2ZHFiJSLlBPwUw/+pjZTIwKI8Z0JAE/q1p+ehn7yLl
         5yYd7XXR2Hc8wy278CgcWr4+AzHYIIwoC44B5unB7bqCzAsfxok0E7sw6tiChSbp2fuG
         tV0xKhe3AoiwTr/nMV1LzfVGymo/3nEmymDH8UkNxpWOrBROg6ys7ByUc9qZ6QnZy2Of
         sWVxHWf3pOZCOpm7jZnE56fGtBI/bZk+yJrUPbcB98wYZfxbc4dX31cOChecGnNzGhN9
         wRRGbaiBAz9O1u48szS6cMUXvVjJIbpc/3r9uGdN0Ap0u4YaKA/uk+zDX/RlJ6REN8f0
         kY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dj8bSAAyMgcbrNeyMR+hYayZQXjJBIgzVAauMYnE+HQ=;
        b=Zo7vv6T6JwRzvkJfMHY4c8HW6R5pXgvXc4fI3ptpiKc3ixffroBmg3KtUQqiK9YLYp
         GX3KZ7qkrBjGX1Wkrx0hSLpI7DzkXdrkHaWZmqzciNnoVQMiJ/LJtiwFdnvNu/IU5ZxX
         VfEpR8p9rDoteuYsj+uTtn3IDeUmmPWpQbM6sa4L9BArwpiAAK4nEK8U1CZw36ozIfCo
         qy2qBrHsPaiBTud8BH9ZlBoHTuWHS/2EMPS1HcPzUYEVeqRtJpSaBatYWmkUGxy8K5GR
         UwlLZ/4QFbFhGL24QemyDUZZJ/LcSuvi3xDTxZ/lEvXbVnfv64KBxz5poqIEGcsoswFQ
         dPbg==
X-Gm-Message-State: AOAM5330g7ujbxFWFqF4s66fK+c8s+mhNUYzDYmBKeVJJ7TFdtwztBuW
        fOjhU+yuVjZGm024ahDr39KEqbdGweXSKisn
X-Google-Smtp-Source: ABdhPJyNUSp6RbpDE0cJb6V0d5Xc/cbJo+KWDiyp/SG6KMJ9WoTmnywhLxMpA1deBDPCufbQQptoTA==
X-Received: by 2002:a05:6638:81:: with SMTP id v1mr22019485jao.11.1629821757951;
        Tue, 24 Aug 2021 09:15:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r18sm10531734ioa.13.2021.08.24.09.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:15:57 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:15:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v4 03/25] pack-bitmap-write.c: free existing bitmaps
Message-ID: <8f00493955662a5c7ec8d50a1b9c9ffe2ef7f343.1629821743.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1629821743.git.me@ttaylorr.com>
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
2.31.1.163.ga65ce7f831

