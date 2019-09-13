Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45FF71F463
	for <e@80x24.org>; Fri, 13 Sep 2019 13:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388191AbfIMNCz (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 09:02:55 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:44050 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387714AbfIMNCz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 09:02:55 -0400
Received: by mail-ed1-f47.google.com with SMTP id p2so25761883edx.11
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 06:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QYPNFBHT1ek2V+d9R1QZYL+nVum/w0iFSuFz73KLjMc=;
        b=pVCw3wRo53TVcAjP+9CCJ1wiabVYIbBXqmDlgXW6j2USN0tn/xZAaNwzhti59afTuX
         DGJ66sClPjGTgkwlz2OsyJDHzlKGSpxrDN32POrCn+BGurX1BlHX0fSBtuhMdcxsh3Ht
         lPLGsWdfIsgu7oCDL2NvMCF4g6sEZhANPtGDBYALJhFOQDE/UiOWI3iIO+2rUDGa9snA
         Kx+9DRERBQf/YDBB4jpXxDWc3bIkaegTqTeVCFHTtM84XVeGxu+RUPry/Kb7//NyT07H
         aFXQMRpp+XSkTl2TgR5U5lomrFvHyAGxuym8Ks0ws7ygzYJS3FaAsKzLK29GCha3bci9
         i8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QYPNFBHT1ek2V+d9R1QZYL+nVum/w0iFSuFz73KLjMc=;
        b=Ea6Yppk49QOV7tSfBvI2aqy9uSki/Ll6UoCT9zXZx3XjaKA6CUQ2dWMxqstZTdBxZG
         MgGN3SsF6bDu4P2ALkaQ4Q9bm6uja3243VMnhDqP5SslaLdQVoU3D1KgnXTJcNj54x9G
         XQAlypG1VYun2sKnhzXM0xh1rpWaqKP0QhBEd+Ng3KdR9X+4sab9MhoXUP7d6Hkm80CG
         X10WmMP6KoP/CH2SfnfULaCTkPjGqp5rPKn8kD3ojINMKy/v/fcB8k+XoA1OpmT76ZRx
         uyjGSl4TguYAZ9R4Hk3kr3K9nvQGgMdf8LSmsjPxb3HOvTs7w+Utrb4dEllMhizoXaex
         nfLg==
X-Gm-Message-State: APjAAAVjf2vPY8eDmsZofoM/BbfOH73evNZnpYdJCbW1D96Yg7bVksGA
        hipEp+AV01m+6lFWwqTOoa9YHbLG
X-Google-Smtp-Source: APXvYqwDLXWjGbTdZyU0irINPjhWWGTNAG3zTad5ema2lcOqdx6TRP19wVaYPsc4KgY+xySjzHOJdA==
X-Received: by 2002:a17:906:d9d9:: with SMTP id qk25mr40536479ejb.275.1568379771429;
        Fri, 13 Sep 2019 06:02:51 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id c14sm2846570ejx.31.2019.09.13.06.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 06:02:50 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH 03/10] ewah/bitmap: introduce bitmap_word_alloc()
Date:   Fri, 13 Sep 2019 15:02:19 +0200
Message-Id: <20190913130226.7449-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.23.0.46.gd213b4aca1.dirty
In-Reply-To: <20190913130226.7449-1-chriscool@tuxfamily.org>
References: <20190913130226.7449-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

In a following patch we will need to allocate a variable
number of bitmap words, instead of always 32, so let's add
bitmap_word_alloc() for this purpose.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 ewah/bitmap.c | 11 ++++++++---
 ewah/ewok.h   |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 52f1178db4..143dc71419 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -22,14 +22,19 @@
 #define EWAH_MASK(x) ((eword_t)1 << (x % BITS_IN_EWORD))
 #define EWAH_BLOCK(x) (x / BITS_IN_EWORD)
 
-struct bitmap *bitmap_new(void)
+struct bitmap *bitmap_word_alloc(size_t word_alloc)
 {
 	struct bitmap *bitmap = xmalloc(sizeof(struct bitmap));
-	bitmap->words = xcalloc(32, sizeof(eword_t));
-	bitmap->word_alloc = 32;
+	bitmap->words = xcalloc(word_alloc, sizeof(eword_t));
+	bitmap->word_alloc = word_alloc;
 	return bitmap;
 }
 
+struct bitmap *bitmap_new(void)
+{
+	return bitmap_word_alloc(32);
+}
+
 void bitmap_set(struct bitmap *self, size_t pos)
 {
 	size_t block = EWAH_BLOCK(pos);
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 84b2a29faa..1b98b57c8b 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -172,6 +172,7 @@ struct bitmap {
 };
 
 struct bitmap *bitmap_new(void);
+struct bitmap *bitmap_word_alloc(size_t word_alloc);
 void bitmap_set(struct bitmap *self, size_t pos);
 int bitmap_get(struct bitmap *self, size_t pos);
 void bitmap_reset(struct bitmap *self);
-- 
2.23.0.46.gd213b4aca1.dirty

