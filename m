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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BEF71F463
	for <e@80x24.org>; Fri, 13 Sep 2019 13:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388205AbfIMNC5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 09:02:57 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43933 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388196AbfIMNC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 09:02:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id c19so26921650edy.10
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 06:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=feuJkzJI/SWfV7q4mtYOBaQBB5fBDWpeiqXQ3Lw+ILY=;
        b=HE8xia3O13wOYxUZ9JcjjJX4GdGkg0SFvzSielw3m0z4XbqpKFxlYX7wDB2/sTuh2P
         20hVR5N5A2rZwRkouSDKjZmYMK9d6SbeFvJhNYvOrAnAgGPS7Shi/MXymNl3PqzSLewv
         MMucDrAbTngey2oQBeC2sm4KlpP32XGqRpmOgZ+4T13y+W4mO24FTjGipZiOJRzUFsBB
         6WFpOQY7K22jC8a4okmz3brGml/UDmL/3eK51WOlDg4v81XTSuR7/YiD6NDbNElzBhHY
         MjO/ah0vRHc1mzFzP7mndTifpiU/tAUZ10yGfEZUNtiAExznjEJ1Sz6zEeIwyJHzXWFj
         Zyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=feuJkzJI/SWfV7q4mtYOBaQBB5fBDWpeiqXQ3Lw+ILY=;
        b=WlpR0Cmzahk95nole7IBESQV5M2Bq1Nm84Gh+X34+PIJRY9Yaw/QkViU4UOfU0FIhy
         6MwfNnnTQsBP/WCCXrsZ7QJADjvp9380LwP0/m+DOIEv8fDgDyPshIylyBHl+mcX2/ST
         B6WRYiTkjeXXACo6oxd3hIE+BWd2siy2HSCRYXoXNWuJ5qr8Wtg+rB8IwlfQ2J0D5o7S
         AIfjcK68aWcpcRzYIbPRK+hUshVLuJO76jgySrBl4bh1fHpKsWydCj9LMiTvkVWiy/6s
         vRFcK0tzUvsFdyv6UNvyJfrJij9xbI/z3uetu+zNIuSdKdo1XsSgF1BTcmlHHcYiDpBf
         8qoQ==
X-Gm-Message-State: APjAAAWYtU5KoYSDR7A7SsOeLEW47oo6sK7+4GXLFxcgWUJb4Rrr+Pcq
        Y2L3N+M8XkPs/oF/uYOQcr3HpLgj
X-Google-Smtp-Source: APXvYqzqT5yrIV/zzlA42J9tsaW9je/oRwi9maOjoMX6sWsdQIBoB+z7KeHzkImuO8BP3u8QZfK25Q==
X-Received: by 2002:a50:9734:: with SMTP id c49mr48057458edb.93.1568379774506;
        Fri, 13 Sep 2019 06:02:54 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id c14sm2846570ejx.31.2019.09.13.06.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 06:02:53 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH 07/10] csum-file: introduce hashfile_total()
Date:   Fri, 13 Sep 2019 15:02:23 +0200
Message-Id: <20190913130226.7449-8-chriscool@tuxfamily.org>
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

We will need this helper function in a following patch
to give us total number of bytes fed to the hashfile so far.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 csum-file.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/csum-file.h b/csum-file.h
index a98b1eee53..f9cbd317fb 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -42,6 +42,15 @@ void hashflush(struct hashfile *f);
 void crc32_begin(struct hashfile *);
 uint32_t crc32_end(struct hashfile *);
 
+/*
+ * Returns the total number of bytes fed to the hashfile so far (including ones
+ * that have not been written out to the descriptor yet).
+ */
+static inline off_t hashfile_total(struct hashfile *f)
+{
+	return f->total + f->offset;
+}
+
 static inline void hashwrite_u8(struct hashfile *f, uint8_t data)
 {
 	hashwrite(f, &data, sizeof(data));
-- 
2.23.0.46.gd213b4aca1.dirty

