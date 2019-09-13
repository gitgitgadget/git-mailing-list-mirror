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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EACC1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 13:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbfIMNC4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 09:02:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35037 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388177AbfIMNCz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 09:02:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id f24so9363802edv.2
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 06:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c435ouO4rFUck2s9Wz+ve8vT5VdFElRswz0pkOdLSpY=;
        b=J1GEaYNcl6o2CkCnW0OvJ0FPS67AYLFo/8XffmOHVcXK7HZuxBLEZdeSxHXSqXbDlV
         GBseJjERoyv6N6UnsY5XGrSAyIWbYZaILaZT9AkFKVG3Tdu9LjtLPhkZtb8jufvXMIl1
         HkukT3El5hVXY9BDGTZLhG3PiNI36iA/5jWoXLI6WvNscig6AiN6LJEHpR7mwWwoHu3p
         PeakTTC3QCYksZwZkigSFyH1Ao+m8GXaBczvaFTjMbtJvVX+Knz8UtslegPWlyEB+SeQ
         TtdWODYQr1x3ddDot5vevyJ/bh2fqvvW2d6RYZNgxXaBq+1P0S1kGF6PjUWoyFwftteH
         8wxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c435ouO4rFUck2s9Wz+ve8vT5VdFElRswz0pkOdLSpY=;
        b=ElyEox5SAJ3vMoxgS/VeZLTBcU6xt5A2sHCb9IbqE8a01S1Gimu4RGb8JMMeAKb1L2
         AofwtYr7KF/en392tuHSiXC+EQW66qtPGSLpVPfyfjLgUPCcoMHwEa+qv5ofJr2vlh2a
         XQcWUetZ4olTQ64rEJBi5q96Ir+5cb8mI7qng/RGm2CIMDZmFqw3/E5VCzrP4qvoIMWc
         mDBfzXi+OAoy9dNoRPy2N3vJcfTPZr6BKbUroaX7DcT6tdii/De4d+MJLvEB+oxjzseO
         5V/azHrLlnbrDaWCjp/EMuFRmizxfN5doVJOJKHbPAiXRoO6osL1O9I4vW0Zac8AMLcK
         ZPbg==
X-Gm-Message-State: APjAAAVlBEYj0nyBh+Tc9PI9jFFgk/ZhZ4h+OGHvXxgb9i2iodfCtXoP
        tkOjO9rLuZASCjckTfmHFKYHJXOZ
X-Google-Smtp-Source: APXvYqxklacZmwB/wR8cASkj0KDH7/wwymVQnIW/EQ9Azpzyvpm1D2N4AJHHlqNYb2r4dvwxHdV++w==
X-Received: by 2002:a50:e806:: with SMTP id e6mr46388012edn.162.1568379772071;
        Fri, 13 Sep 2019 06:02:52 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id c14sm2846570ejx.31.2019.09.13.06.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 06:02:51 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH 04/10] ewah/bitmap: always allocate 2 more words
Date:   Fri, 13 Sep 2019 15:02:20 +0200
Message-Id: <20190913130226.7449-5-chriscool@tuxfamily.org>
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

In a following patch we will allocate a variable number
of words in some bitmaps. When iterating over the words we
will need a mark to tell us when to stop iterating. Let's
always allocate 2 more words, that will always contain 0,
as that mark.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 ewah/bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 143dc71419..eac05485f1 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -41,7 +41,7 @@ void bitmap_set(struct bitmap *self, size_t pos)
 
 	if (block >= self->word_alloc) {
 		size_t old_size = self->word_alloc;
-		self->word_alloc = block * 2;
+		self->word_alloc = (block + 1) * 2;
 		REALLOC_ARRAY(self->words, self->word_alloc);
 		memset(self->words + old_size, 0x0,
 			(self->word_alloc - old_size) * sizeof(eword_t));
-- 
2.23.0.46.gd213b4aca1.dirty

