Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1621C4167B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E34223B54
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730726AbgLHWEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730698AbgLHWEs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:04:48 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69DEC06138C
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 14:03:49 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id s2so230485oij.2
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 14:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bsuIqyXlLj77HI6Jh/NOCqFh+idsp+iFSjpkcZnqfL8=;
        b=NMgc3IS/5LpOalCHIkhuudbDn/wV2TXvI1cRQzmU97HVVmxBaakIt+77GL97+/cwKD
         AFNzGRZdUdh3zYz6Kz2KgwneXd7BYr3zb0/tPvWnW771G/8DkfJjG0h3ojLEbS4hM7+s
         LuEiampXEdW3Dhqzw1CE0Ij9r0YI5OeLcNp/+oL9CFDvtrr3i99VMhzzjtQS9BlUbxuC
         zsTeDBJtfLQYKqBMK5xna93vnMgxXwFTYnx43tiR9JuI2WUwicYuQcyFLVyFtWbQ3lBk
         Ncs+uJJg8T1cW0YfYlAITRtLZmwGufNgoSoj32T6KEhF4KUtFE0Mi41MXdNRHBLft4DK
         XTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bsuIqyXlLj77HI6Jh/NOCqFh+idsp+iFSjpkcZnqfL8=;
        b=B90LjeZlx/vPGTw0KP+fBY99sG6Ac0qg7qan+J0I2/tmNkf6gG2epa3O9QIYp6sx5r
         FI3Em8FV0ggQbcVHnjqRS4Yoe5KSxnh8ueBGw/PmxxND93iH9rgWEQDy5HO20vXNTtPG
         I497AisySzQTotuuFntayolLo6955lf5ZQsjwIGmkmTkbnPy9vH8nUlf2o5wY5x+/Aue
         JuqvZ6AQhJO5bqXLygTMZ86bVMmuOvhNNtLQJgQ/J25hegLQPYqM/EpM/w03N+bInhQK
         1MPsfKJBy5ZxWLGGLoCaz2zsrY5lhQ2C8jSd7b1HR5WBUESbgswXwt5X3oPl1A2LBF+6
         5p+Q==
X-Gm-Message-State: AOAM531WMR23G7+/BMHkKKwsD8kLLPtLF8XPchOI/Xh0P83NTX/Zmjnx
        KTtTfAcHsyRrSuCmG0wCEzujUKjW0UV/xUZO
X-Google-Smtp-Source: ABdhPJzsJgh5AyExeMDo91cKpRnILWKIh+xPiVytEVxrSFiaZl5/pwQQwaX/FMifbvch/BFDPrf8og==
X-Received: by 2002:a05:6808:9b7:: with SMTP id e23mr4406850oig.167.1607465028850;
        Tue, 08 Dec 2020 14:03:48 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id q4sm67298ooo.1.2020.12.08.14.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:03:48 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:03:46 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v4 08/24] ewah: implement bitmap_or()
Message-ID: <04bf0de4742386b2c5bce7bbfdb07cbaefc637c8.1607464775.git.me@ttaylorr.com>
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

We have a function to bitwise-OR an ewah into an uncompressed bitmap,
but not to OR two uncompressed bitmaps. Let's add it.

Interestingly, we have a public header declaration going back to
e1273106f6 (ewah: compressed bitmap implementation, 2013-11-14), but the
function was never implemented. That was all OK since there were no
users of 'bitmap_or()', but a first caller will be added in a couple of
patches.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 6f9e5c529b..0a3502603f 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -122,6 +122,15 @@ void bitmap_and_not(struct bitmap *self, struct bitmap *other)
 		self->words[i] &= ~other->words[i];
 }
 
+void bitmap_or(struct bitmap *self, const struct bitmap *other)
+{
+	size_t i;
+
+	bitmap_grow(self, other->word_alloc);
+	for (i = 0; i < other->word_alloc; i++)
+		self->words[i] |= other->words[i];
+}
+
 void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other)
 {
 	size_t original_size = self->word_alloc;
-- 
2.29.2.533.g07db1f5344

