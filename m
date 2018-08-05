Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DABA208E9
	for <e@80x24.org>; Sun,  5 Aug 2018 17:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbeHETbD (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 15:31:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44340 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeHETbD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 15:31:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so10115626wrt.11
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 10:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B4qRewWJTrmbgvkzXZPwvBqLt6ZoS9eBP5ditFIHVjg=;
        b=QjVW+8gFAClS3b+U3YK8ZRxF03gkzUf8WXc4jB4lt++pkFcKTnnEXsmjZnPI2wlKRj
         dJ43Dq4IggeOWcuLGGscY4sr0sHJKmnOgKDpjtd3WaWn2GyJq0XGawJL2AgpsJEsTxHV
         KDHEUIb04B3vCZnwgpYDXP6mYzopnoIlViimG3SP4YHMBtSt+IhLapDLt9q3IJ7a5eUW
         dquE7CDoCCQ3FW64FboeGhdjihNmvphQ9X9rzaBZ5ddy3h1SWyFzuAIQxmjRG9fO1+CM
         ITmZcO1xyaYbMFGlvm25+HFhYGsHDYFxXCH29WFNsGfN6Fq77CH1x1RU7W8kLuEdl8M7
         BFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B4qRewWJTrmbgvkzXZPwvBqLt6ZoS9eBP5ditFIHVjg=;
        b=AHvYR4giwLjB4gIqhg7LZcfsCMzs2Ut0nE8dJ/ulKpB0y3hlQVZSJloLWoakelJIsz
         893zvAQQD9ke8ISITPX3NO3qKmU6RCuSvj65DZzix92NdN2z6jeoOTMSHml/njyd++vY
         4gaXYf8I/SPBztc2wrWlsknv4H9emSTKZwkoPCSyzZtpKHljKN4Zk15IzaSkXXQB+wHY
         kqtpXiO7MA4UmU0Ga5opLIIXYgUx5LDNp81kbnQUdns97Y/M1tE2G54CtaFqp6dJfGIV
         WmnQy0Zu6zu70gXjSRFcaC2Q03xisUkYGjEq+dvXG2wP//lzkwyvdNaZ9bupp/jltzeK
         NxKw==
X-Gm-Message-State: AOUpUlFXO3zGnVatwyiu2GPjqBPQmO5z2kLqSNaZNzZT2LWD9OcR/hAU
        kfqY0ty8Ts+L2Fr5fNEoyTNH9To0
X-Google-Smtp-Source: AAOMgpdhXgTWQ23JE63bpbgURBDiVt97G8X77omNFJdadylouWA/w5gbOLeUEnT4eU4837BsAtBmJw==
X-Received: by 2002:adf:ba12:: with SMTP id o18-v6mr8004646wrg.249.1533489944294;
        Sun, 05 Aug 2018 10:25:44 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id x62-v6sm7523228wmg.1.2018.08.05.10.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 10:25:43 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/6] packfile: make get_delta_base() non static
Date:   Sun,  5 Aug 2018 19:25:20 +0200
Message-Id: <20180805172525.15278-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.327.ga7d188ab43
In-Reply-To: <20180805172525.15278-1-chriscool@tuxfamily.org>
References: <20180805172525.15278-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

As get_delta_base() will be used outside 'packfile.c' in
a following commit, let's make it non static and let's
declare it in 'packfile.h'.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 packfile.c | 10 +++++-----
 packfile.h |  7 +++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/packfile.c b/packfile.c
index 7cd45aa4b2..4646bff5ff 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1037,11 +1037,11 @@ const struct packed_git *has_packed_and_bad(const unsigned char *sha1)
 	return NULL;
 }
 
-static off_t get_delta_base(struct packed_git *p,
-				    struct pack_window **w_curs,
-				    off_t *curpos,
-				    enum object_type type,
-				    off_t delta_obj_offset)
+off_t get_delta_base(struct packed_git *p,
+		     struct pack_window **w_curs,
+		     off_t *curpos,
+		     enum object_type type,
+		     off_t delta_obj_offset)
 {
 	unsigned char *base_info = use_pack(p, w_curs, *curpos, NULL);
 	off_t base_offset;
diff --git a/packfile.h b/packfile.h
index cc7eaffe1b..1265fd9b06 100644
--- a/packfile.h
+++ b/packfile.h
@@ -126,6 +126,13 @@ extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsig
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
 
+/*
+ * Return the offset of the object that is the delta base of the object at curpos.
+ */
+extern off_t get_delta_base(struct packed_git *p, struct pack_window **w_curs,
+			    off_t *curpos, enum object_type type,
+			    off_t delta_obj_offset);
+
 extern void release_pack_memory(size_t);
 
 /* global flag to enable extra checks when accessing packed objects */
-- 
2.18.0.327.ga7d188ab43

