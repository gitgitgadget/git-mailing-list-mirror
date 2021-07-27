Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0F7C432BE
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 688B560F9C
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhG0VVP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbhG0VVC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:21:02 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969ADC0619E0
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:31 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id c3so662617ilh.3
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dj8bSAAyMgcbrNeyMR+hYayZQXjJBIgzVAauMYnE+HQ=;
        b=CkshxVqKkW4qOHPZh5c08dHUc/vYQHsVO9hEXiiyPcsap3Qg/ZAboj61NKGZRj+8Ls
         7X/6Am2Fuel+xbmOb5yNSx277Pk2ZrUOIm465PLwlrBTWjPM+YkHJvJFmLUAy7t7Muel
         VSyUiPXWCukgN9MFJvkmSv/CWrh9zwSlDJqXbdYbWQ98+iMSVspf2Gz2uP0etWPg97lA
         vdaLGBXej/fAsVd9O43APtWSy6mYC5Cdg4gIASu61rrxJ48yvjeiNbdU3VHvqMfoBg4n
         mj1t4c0hZokfZhbbTdqN8c914n46a9uEt3XVMrJ9CdjPzZUDmWLAr1ZdqWqPonRPNJ15
         JYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dj8bSAAyMgcbrNeyMR+hYayZQXjJBIgzVAauMYnE+HQ=;
        b=trwKyXgw0br68Jvu2UcRI5aU3Vd2gtlufc1bKrr5g3XJ/Xj1jYiaNJXFCiiJB5ivd7
         U5R+6F6jtbn8kchQ7o2Jxy4TClyG77NJ4Fdy+yQohb4kcGKZAKSZL9gT9CT22PCXMBXV
         ynDYw9MRY1W3gEs77xzbBPoOEOnK4oTrYuNiP5rXasW+3nvbBuKzeK1lhzL5x62WndIy
         mTNg3o/GUErfXxFvIOmZeDVf9bp4bmNG88KuL2HtH1oSgBFwaraMkArM3yN7I0DeOdnu
         4NRLX7TBsQ1Ak94YitlKvgduX34y4aXTVnRLdnwknmx1AdO2rc0xAeH5hOqurI9rZjJp
         8F7w==
X-Gm-Message-State: AOAM530BxkNfcnMqCZxWg+rwu3iigt5pfjJZg8uU9SxsEuJ999RHsEP9
        QRF3NT3O4nHPkXXsJoOKt1f4c0PTh4rN/4jz
X-Google-Smtp-Source: ABdhPJyFKdFi+bLx9OyuQzdqmNCh/47EA3r6BP28Oy19Wfn9k/nzSQkADsSTV7uf8ywLKdaVqw7ASA==
X-Received: by 2002:a92:c949:: with SMTP id i9mr212295ilq.19.1627420770950;
        Tue, 27 Jul 2021 14:19:30 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id j20sm2942095ile.17.2021.07.27.14.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:19:30 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:19:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v3 03/25] pack-bitmap-write.c: free existing bitmaps
Message-ID: <2ad513a2300eec4bb4068a88cf63cea9aa6968fe.1627420428.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1627420428.git.me@ttaylorr.com>
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

