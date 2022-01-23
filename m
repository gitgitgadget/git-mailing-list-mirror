Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDD0C433F5
	for <git@archiver.kernel.org>; Sun, 23 Jan 2022 15:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbiAWPZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jan 2022 10:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbiAWPZF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jan 2022 10:25:05 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CDEC06173B
        for <git@vger.kernel.org>; Sun, 23 Jan 2022 07:25:05 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id l25so9053301wrb.13
        for <git@vger.kernel.org>; Sun, 23 Jan 2022 07:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vrNlv3GyajGDMbHx4OHMbqWYLbKDpOhDsksNp0AGz60=;
        b=nL3aDFx58MWuzhc5+e05XioIcVlRtIb/wZquuHuR5qTkwJk0L4lZ+WHQbEi4kk9t70
         H+Q/CfDMMb4hSJpOXkB7hf1Pjm+7bOMj7fv5oY+7UAYwHsarCJFfQMOgiSw18kXtw/7s
         Wc9GfOMgvzAS4lmPp7hZ1M9lYTjRUzW0+T12SkMIDCIKGwJo8VBhUs4uz1pR47oJ+lh7
         +fYGomhqAf0lNyNeQ39esOxq9Q8v9TQb/E/FoO1CMSpQ1/g6uBi5YWyOpqDDJM9Myey/
         nMgOScdRh5rSbFmrn1ecZaHFfuJ1Hzkh0FxS89e/2UUudvk46cJ0DtCBy24HwieCEwU6
         MKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vrNlv3GyajGDMbHx4OHMbqWYLbKDpOhDsksNp0AGz60=;
        b=3ptVoTU89lP1LN84Twp1HTkWAqBjOUXI+RacckQjdeiX+k95YCqj27SsSSkz0+/qxj
         e4vNGzcfuQKMM/YgmvwMuJmXjMN8R7xqFSiVZGmthy8OMWPkV5DRgI64+s4YmOi28Rri
         VFfFZegAESDEDMnSbmAG0szDCI+i0aVq15pHHkipX6QedPpu9S/qt7Y2FUNYgKoufUyU
         4KDmAxNqd8khAUvzHM6+HVZ+Np7mDiXBGulXn3kZb/kdIhJU7tDJILGrp/ay8k7h0nDd
         nJ7qTYd313eHYT3Ptv8Tdtm4PzPdDE79vQl1eObj/3z2jU/fwDdwsQfdnPVgoxL/pT5V
         w+hA==
X-Gm-Message-State: AOAM531ll69zNO7/5pI5Q6Je4EGr/EnEnduoDNjaH64AlTzmh/3VrTcd
        oLBX7hMQZ6FzMieu4VQ3YSG0GmpNSEtFgtqm
X-Google-Smtp-Source: ABdhPJz5wuDjpSAqDOtbfYYanppkl0HAdwB4LuyRsGinvbqr+9qS1HT3WeIs40No9pvMiuRLPd4LVg==
X-Received: by 2002:a05:6000:1a89:: with SMTP id f9mr4323845wry.251.1642951503900;
        Sun, 23 Jan 2022 07:25:03 -0800 (PST)
Received: from Jessicas-MacBook-Pro.localdomain (global-5-142.nat-2.net.cam.ac.uk. [131.111.5.142])
        by smtp.gmail.com with ESMTPSA id a24sm9929365wmm.31.2022.01.23.07.25.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Jan 2022 07:25:03 -0800 (PST)
Received: by Jessicas-MacBook-Pro.localdomain (Postfix, from userid 501)
        id DAE7DC65465; Sun, 23 Jan 2022 15:25:02 +0000 (GMT)
From:   Jessica Clarke <jrtc27@jrtc27.com>
To:     git@vger.kernel.org
Cc:     Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH v2] mem-pool: Don't assume uintmax_t is aligned enough for all types
Date:   Sun, 23 Jan 2022 15:24:58 +0000
Message-Id: <20220123152458.72540-1-jrtc27@jrtc27.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220105132324.6651-1-jrtc27@jrtc27.com>
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently mem_pool_alloc uses sizeof(uintmax_t) as a proxy for what
should be _Alignof(max_align_t) in C11. On most architectures this is
sufficient (though on m68k it is in fact overly strict, since the
de-facto ABI, which differs from the specified System V ABI, has the
maximum alignment of all types as 2 bytes), but on CHERI, and thus Arm's
Morello prototype, it is insufficient for any type that stores a
pointer, which must be aligned to 128 bits (on 64-bit architectures
extended with CHERI), whilst uintmax_t is a 64-bit integer.

Fix this by introducing our own approximation for max_align_t and a
means to compute _Alignof it without relying on C11. Currently this
union only contains uintmax_t and void *, but more types can be added as
needed.

Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
---
 mem-pool.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/mem-pool.c b/mem-pool.c
index ccdcad2e3d..b373cadd01 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -7,6 +7,22 @@
 
 #define BLOCK_GROWTH_SIZE (1024 * 1024 - sizeof(struct mp_block))
 
+/*
+ * The inner union is an approximation for C11's max_align_t, and the
+ * struct + offsetof computes _Alignof. This can all just be replaced
+ * with _Alignof(max_align_t) if/when C11 is part of the baseline.
+ *
+ * Add more types to the union if the current set is insufficient.
+ */
+struct git_max_alignment {
+	char unalign;
+	union {
+		uintmax_t max_align_uintmax;
+		void *max_align_pointer;
+	} aligned;
+};
+#define GIT_MAX_ALIGNMENT offsetof(struct git_max_alignment, aligned)
+
 /*
  * Allocate a new mp_block and insert it after the block specified in
  * `insert_after`. If `insert_after` is NULL, then insert block at the
@@ -69,9 +85,9 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len)
 	struct mp_block *p = NULL;
 	void *r;
 
-	/* round up to a 'uintmax_t' alignment */
-	if (len & (sizeof(uintmax_t) - 1))
-		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
+	/* round up to a 'GIT_MAX_ALIGNMENT' alignment */
+	if (len & (GIT_MAX_ALIGNMENT - 1))
+		len += GIT_MAX_ALIGNMENT - (len & (GIT_MAX_ALIGNMENT - 1));
 
 	if (pool->mp_block &&
 	    pool->mp_block->end - pool->mp_block->next_free >= len)
-- 
2.33.1

