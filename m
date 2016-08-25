Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E804B2018E
	for <e@80x24.org>; Thu, 25 Aug 2016 11:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757569AbcHYL0x (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 07:26:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34084 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755553AbcHYL0v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 07:26:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so6965162wma.1
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 04:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XZF41fJHVb2A0ncQnbUkKEeNxKqyMswmkTm2Sluk9zE=;
        b=zwnBj/lk+uxNmrHRNDX6CY5wZZcy/Y44ydCVvdt0PIDYbaUakU64C9cxh57HHYkiaQ
         0s3tS73NjCQ42P1vxe/SxCPVBo8vh5lrQSwQI6k1KtlcOeQ0FLYnw7fdH6EszrnkSEb9
         mcg/9Xzo53BWfbtTLJhGQ70UXGONUVrBEWyi3M3vsufRfCeHh8tZsO5+hkiU37YArjgL
         gdiB5HM/h+83Xy4lL+dFRntlZAsPpbHwM8Oscm9dQFCZRUhtAnhrW2ySld2GYUo9vc1y
         RKFWlIenZRgyuVKcAu3G2+LfsdPEXyWx3agWVHnHfTJ+RmW9rr7jAlZISODgYImmBLDP
         ApgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XZF41fJHVb2A0ncQnbUkKEeNxKqyMswmkTm2Sluk9zE=;
        b=bhuWf9SNuoulbA88oa16+D0K2C0xogtQS4vBlEm53pe5d2o6xDJUDdciqU/06dFc3c
         E3BkV2HWkENme0PwEC+bOuuDLK9Pz4AfAc7T8IcMJlJ+ydBoSVTfSGJD9vpKBxJdj/d/
         oSUNUSFXnP8IqQ5CutCWDOwJkefjr/ZzKP6XvROx9tbwEzNQrbrJzuYKlS33rgUNkF7F
         rUUNwxB1uLsRz+DyGgS1sm5a1LXcf/IH4yAb6xR2nUgjZruPuZl6q7AFrcVssZcBHT4P
         8+wX7/YFo9giexclMOMyhyUkRoQ66SyLL5/PZsc3ro3mcUkkHM3/0OXuQo6AIaIXWF1k
         mNjg==
X-Gm-Message-State: AE9vXwNaOxz3xBdfRH3UnyqGHar6K14xOSGAhob31ug24VGunk4js2RwV0naZ39chBm1KQ==
X-Received: by 10.28.46.134 with SMTP id u128mr7792394wmu.41.1472123279441;
        Thu, 25 Aug 2016 04:07:59 -0700 (PDT)
Received: from bcnf9f9l32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id p71sm38304839wmf.9.2016.08.25.04.07.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 25 Aug 2016 04:07:58 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v6 02/13] pkt-line: extract set_packet_header()
Date:   Thu, 25 Aug 2016 13:07:41 +0200
Message-Id: <20160825110752.31581-3-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160825110752.31581-1-larsxschneider@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

set_packet_header() converts an integer to a 4 byte hex string. Make
this function locally available so that other pkt-line functions can
use it.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 pkt-line.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 0a9b61c..e8adc0f 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -97,10 +97,20 @@ void packet_buf_flush(struct strbuf *buf)
 	strbuf_add(buf, "0000", 4);
 }
 
-#define hex(a) (hexchar[(a) & 15])
-static void format_packet(struct strbuf *out, const char *fmt, va_list args)
+static void set_packet_header(char *buf, const int size)
 {
 	static char hexchar[] = "0123456789abcdef";
+
+	#define hex(a) (hexchar[(a) & 15])
+	buf[0] = hex(size >> 12);
+	buf[1] = hex(size >> 8);
+	buf[2] = hex(size >> 4);
+	buf[3] = hex(size);
+	#undef hex
+}
+
+static void format_packet(struct strbuf *out, const char *fmt, va_list args)
+{
 	size_t orig_len, n;
 
 	orig_len = out->len;
@@ -111,10 +121,7 @@ static void format_packet(struct strbuf *out, const char *fmt, va_list args)
 	if (n > LARGE_PACKET_MAX)
 		die("protocol error: impossibly long line");
 
-	out->buf[orig_len + 0] = hex(n >> 12);
-	out->buf[orig_len + 1] = hex(n >> 8);
-	out->buf[orig_len + 2] = hex(n >> 4);
-	out->buf[orig_len + 3] = hex(n);
+	set_packet_header(&out->buf[orig_len], n);
 	packet_trace(out->buf + orig_len + 4, n - 4, 1);
 }
 
-- 
2.9.2

