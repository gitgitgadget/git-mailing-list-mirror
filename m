Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03E6C19437
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D6323AC4
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbgLHWEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730697AbgLHWEs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:04:48 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49603C061282
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 14:03:54 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id o11so255543ote.4
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 14:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tgwQSV0Jx2RFdjihG4qsp3emQ8nruJR26Qc29XYgvWk=;
        b=oDWgLk2eutaDLo36krbya8wCZEvFHPhyPDejQJVfqZ8UZFRzwmPeE9wC25nhWimTx5
         2NqBnZaK9skVuS9LfMwTPuzEH+XNT2tslkHFv17SQjvgXBmrqa2VWV/Wm0n6HwAPOVPT
         sxkMbAJQf+3Vag4kd0qS+BalrZJOJiI5IntnRYAKgkPr6I05tc6vUZP0nAGovXcaLzm1
         jbyuJLgTIc+1H4VIWOfKaFeMHMRAqNuLiInC6AUmUVZIjGish4BX3CqbpWNEITaTa9JD
         0eEEp5rWDxNAI7ll7RFnboYT7u1oNqSheKoZ4rm5y9v7folZsdJl6V1Ltu60r8rpPZ3R
         L9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tgwQSV0Jx2RFdjihG4qsp3emQ8nruJR26Qc29XYgvWk=;
        b=rMPCDUPwIy8lCK1fvLADKfFQ4MVlwAyci90p3U3+A5kJ+SJuwlya5fGud75NcqZTEX
         KzDOML22ZZm191kveLKf1NDqyEbIdo3Abb3rfJ1QgBkw0QqvLk5XFtVKPP0a9aS3QXX7
         8vhE5O+BCcug0uwBpqdlvTo1Va3clsGiGaM/gzA6U5Lcr5OjdZSoizaWdPf6VdlvDHIw
         ab/Tk5onIBsY4ywb80WtSkzj9xsiNVlTYT2uw8Abu8qxrQy4lR08Ql4fikVdgYJxTtrr
         Lxq3xO7tNEHFqV9IEtA+9Ed7DPeAWeMkOLMqPdOtMoaLEWQq1OrCzjnIFQDAptA/S04G
         MVrw==
X-Gm-Message-State: AOAM530WQ+W5oD/4Gba2ggtQNC1BdTzvvNSC5YoI7u8xaGiKvwX7yXcQ
        JeMl0jBSzqqkDMz7ax1PgJIHT7SgPK8ygvhv
X-Google-Smtp-Source: ABdhPJxlI/MRTD6NlzPCWOVIsKxqCL/m6ORPvwHJAHUBfQ6VGRyt1xIZ4sWiemls0yHUjvgN6UMjrA==
X-Received: by 2002:a9d:39f5:: with SMTP id y108mr129616otb.63.1607465033396;
        Tue, 08 Dec 2020 14:03:53 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id l1sm55670ooi.48.2020.12.08.14.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:03:52 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:03:50 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v4 09/24] ewah: add bitmap_dup() function
Message-ID: <c8bd4ed5fa83212d119e2cac21fda1bd93fb1561.1607464775.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607464775.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607464775.git.me@ttaylorr.com>
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

