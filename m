Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50C1C2BB40
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B72B423A1D
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgLHAFt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgLHAFs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:05:48 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8765DC061749
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:04:55 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id i7so3635267oot.8
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tgwQSV0Jx2RFdjihG4qsp3emQ8nruJR26Qc29XYgvWk=;
        b=1rTyzAF5kh5uFw97ocA9ZigNbKXPAsOLQcrKOG0rrksaSYXvKMCrzZfF2sJ0vzos4r
         6CkuJw5Nyx0eJvJ9cq6gCO4y4e6c9mlmf8cv/HD/EZvRx988GeeEE2sGpEg7ERpeivph
         q90Jgg3LaqFPYY71DUmdyieucJla3A9SgOttFzmIYX7GIgHerXREC+9WUv62XsIKd0H/
         R2QlVZyDxe3tf4I8MziPqrHy8woAxxAQ5S4SiKGeCYaMTV7tssJy0Vlb4r71BmiTLEsu
         OXrkV/4l3lvw9UEePpmkRcaYuC/P/2eCHFZsg227mWhs+WgGrMtJGspxDexSLrqVB4yf
         CzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tgwQSV0Jx2RFdjihG4qsp3emQ8nruJR26Qc29XYgvWk=;
        b=dRYP6V2Gee2L1+iayEN359N3UBgwYuk9v5BO3VLcS1IDD5HoerCMlbCH41quS3TCjd
         A6UUunRKC6OgyW/CZC1ReJaXgFhs8WCdkHA2VedGVuBCmCW4uqehNonyuIVTc+heyLea
         vlrgYfSckFfg/J5IjNaIHEmoGaxppIVXhtDgbANg1/NqoXoRhDXG+EFeeNP6G1vgKfYO
         +UWV6YKz23Lpyj6kjl0+JTaHgRSRk8DjTuFdwyLekknDEt7jf+jj+x6+7XXaV6zYl30/
         EJgt5Qyz5yMqOtv2/2/kcrka+KBp613NnW8VBrYT3EOZCce2HVMNCsWo07q9o21rpI9C
         o6MA==
X-Gm-Message-State: AOAM530WFFhN33UXujULq8TLfAyYRE2Ktab1Z/GayVvfr7HutSmKGR7K
        4747RyFPFt/Ukb8S/IeyzTWhrJjXXaFnq11M
X-Google-Smtp-Source: ABdhPJyxZEGHsnadsvtvu5FLbuZTMAc+HUjOirWthXAouMWM3Dz8amRUEmPb1vT4uXQG3JG8ZUGWeQ==
X-Received: by 2002:a4a:9b16:: with SMTP id a22mr4542898ook.6.1607385894667;
        Mon, 07 Dec 2020 16:04:54 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 94sm3020477otw.41.2020.12.07.16.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:04:54 -0800 (PST)
Date:   Mon, 7 Dec 2020 19:04:51 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v3 09/24] ewah: add bitmap_dup() function
Message-ID: <fe89f87716739a9a65dca06a9eae6ae1fbfeefea.1607385833.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607385833.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607385833.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

There's no easy way to make a copy of a bitmap. Obviously a caller can
iterate over the bits and set them one by one in a new bitmap, but we
can go much faster by copying whole words with memcpy().

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 7 +++++++
 ewah/ewok.h   | 1 +
 2 files changed, 8 insertions(+)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 0a3502603f..b5f6376282 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -35,6 +35,13 @@ struct bitmap *bitmap_new(void)
 	return bitmap_word_alloc(32);
 }
 
+struct bitmap *bitmap_dup(const struct bitmap *src)
+{
+	struct bitmap *dst = bitmap_word_alloc(src->word_alloc);
+	COPY_ARRAY(dst->words, src->words, src->word_alloc);
+	return dst;
+}
+
 static void bitmap_grow(struct bitmap *self, size_t word_alloc)
 {
 	size_t old_size = self->word_alloc;
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 011852bef1..1fc555e672 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -173,6 +173,7 @@ struct bitmap {
 
 struct bitmap *bitmap_new(void);
 struct bitmap *bitmap_word_alloc(size_t word_alloc);
+struct bitmap *bitmap_dup(const struct bitmap *src);
 void bitmap_set(struct bitmap *self, size_t pos);
 void bitmap_unset(struct bitmap *self, size_t pos);
 int bitmap_get(struct bitmap *self, size_t pos);
-- 
2.29.2.533.g07db1f5344

