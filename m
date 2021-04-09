Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE74EC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87B7661181
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhDISLP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbhDISLL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:11:11 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517C6C061764
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:10:58 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id e8so6827415iok.5
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BupGobCfypnzxGBp5+C0pQPe2do9EyXqzE5iYIKyKII=;
        b=lFVxaCRoDoaBG38mJ8l/fJI02L7Cl83kziuV2Fj+eFauImSRUFT7HBfO2YdwbTufEJ
         rb5+yj8si0yiOAb97krbEtdd5XI29UGbYqFjwtHG7SVmbl5JSm8TldoQrxuGw9zOslsI
         B2gq24M6FTVYjQElABpvvRy73EA82q2XZkPOc1waYzAOm82fO4G6titjDN5brBlGmdWw
         WTFsCVZNRDB4psawoX7Z7JbObe26lGSzW+WFmZFpMtLQJH3hhk9w32qwlfztSK5xUtFy
         Bg4mwwND/cXbIL9PapGXbDtx1Kl0Fg2s4/06Km3Slc1MBVhWuTZdjgkrIdIR4pmi8eB2
         E3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BupGobCfypnzxGBp5+C0pQPe2do9EyXqzE5iYIKyKII=;
        b=URRQ+KScnSfJ99qNNi1WEUvE29n06870GeqQDIt6bMBCmc/rllcHOedMKTerlu3GhJ
         WrVvPvzp776F5uQaLFiyGhhNXwHC5BznAaAmBrIP6hNmzwUdZVU3y6CmvBw8OhJCqB7f
         ix+Z9CejNcv0jGSgKvSprzKbvA/gKmadFyg7z8V/wZCTYgvK7yF35q0iAVXOfRbVLymr
         Tyykv+KIBpdsE8bbHIGfFxsxwyB9bGBolB5oyIm2MlP5VdL+2SzuD8WLN4h8BPUvAuZM
         WC5vstYBAAFBf1ghKwfLvP3/rO9LCrzJmLSQZ6gUTrla1UfVmx+so1pKP/EtSHMSEDlU
         Oh9w==
X-Gm-Message-State: AOAM532G13jFbEIcTiIaB+hvyJKy/wLJDjje+DknkmpNyfynwOqCoi4k
        OU/dz71xh88DmkwgbXSme5ueVPB0oU1+iRkD
X-Google-Smtp-Source: ABdhPJzA+MvnYlvJibxhrGTM2KSAEVAUOUY8d3Md2ZsNjSpPngZdW0Rokazhdl8JrmAMwmkp7cEyKQ==
X-Received: by 2002:a5e:dd03:: with SMTP id t3mr30792iop.199.1617991857599;
        Fri, 09 Apr 2021 11:10:57 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id n11sm1434411ioz.25.2021.04.09.11.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:10:57 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:10:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 03/22] pack-bitmap-write.c: free existing bitmaps
Message-ID: <014c18b8965fda2c5feb4ec5c4fe9d82f213a744.1617991824.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
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
index e829c46649..f90e100e3e 100644
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

