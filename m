Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AA0B203EA
	for <e@80x24.org>; Wed, 27 Jul 2016 00:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbcG0AGX (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 20:06:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32935 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758183AbcG0AGO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 20:06:14 -0400
Received: by mail-wm0-f66.google.com with SMTP id o80so4045630wme.0
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 17:06:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pWhz17ZhOznvWFCixP6efd3klx9qXsAbKDgL86cDElo=;
        b=ZUEj3u0m2DKImu+MMHwGckLiB+uSQoK34I/jf+X/vpHn7vhWJ13zFI+oADIDTGBMaf
         4YSA/Ju49tw6OijfKQvDHBGH4dORedRtxiKtFVxuwlsaMb3PiHgHOqJSqYwcKwkHpzwa
         BoR9klBDeBZUuXwHmi0kB41FRNx2k1bcrWdKu1grykabEDTe+dAGma4i2Lm0DszXjj+/
         ERDQb/tWIYJlIRMLDgaK2Q4PbPEuqR38xrnkipRJ+r4VR3bq5+A+eOJajVZpuhOhLu7h
         dkguJZyF8baMP14UCAlR9qtPSFCSin7oiS3tiyv2j2ah6HO6cqLtLlZYt0BwIIHAjpuK
         IMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pWhz17ZhOznvWFCixP6efd3klx9qXsAbKDgL86cDElo=;
        b=LHMErh39fhAhBJDztNSjNliE8TGx5TtlofWzAiRWNkSm1VlgUDNhIPXl0WaqsBODpF
         QapPfKgHNsPac5m0FPsFgl97u2LxraOYTJhACrwIj+e++gaLuVP1G5RP5PwGCzC2T9RD
         toNfT04VpLWaqlWKamHgZSJTX3SzLUtN0F4RQhn7JwMJMmakNyBVkZGnkEX9MrPv3zM1
         dXK5m8LZLM0quBtobNQfMEKXy4LJtJsldHOxVq4nSAl75Tk7dUSWZSdSivfvQa3pnFig
         L6X7sdS3HhJXfp2rhetgF89lTvnpgyABAKNsZIL/YvvfCm+F1Vm6h0WfnntpxHZT12IH
         3MWg==
X-Gm-Message-State: ALyK8tLZm/RaFSvqqwYbKdL64WDTghONXEHkGBdaFyUBV1rC+dZ07Hhp+N3Tm1hBMCvP0w==
X-Received: by 10.28.46.204 with SMTP id u195mr47267984wmu.57.1469577972699;
        Tue, 26 Jul 2016 17:06:12 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB772A.dip0.t-ipconnect.de. [93.219.119.42])
        by smtp.gmail.com with ESMTPSA id q137sm35330015wmd.19.2016.07.26.17.06.11
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jul 2016 17:06:11 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, remi.galan-alfonso@ensimag.grenoble-inp.fr,
	pclouds@gmail.com, e@80x24.org, ramsay@ramsayjones.plus.com,
	peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v2 3/5] pkt-line: extract and use `set_packet_header` function
Date:	Wed, 27 Jul 2016 02:06:03 +0200
Message-Id: <20160727000605.49982-4-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160727000605.49982-1-larsxschneider@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160727000605.49982-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

`set_packet_header` converts an integer to a 4 byte hex string. Make
this function publicly available so that other parts of Git can easily
generate a pkt-line.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 pkt-line.c | 15 ++++++++++-----
 pkt-line.h |  1 +
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 62fdb37..6820224 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -98,9 +98,17 @@ void packet_buf_flush(struct strbuf *buf)
 }
 
 #define hex(a) (hexchar[(a) & 15])
-static void format_packet(struct strbuf *out, const char *fmt, va_list args)
+void set_packet_header(char *buf, const int size)
 {
 	static char hexchar[] = "0123456789abcdef";
+	buf[0] = hex(size >> 12);
+	buf[1] = hex(size >> 8);
+	buf[2] = hex(size >> 4);
+	buf[3] = hex(size);
+}
+
+static void format_packet(struct strbuf *out, const char *fmt, va_list args)
+{
 	size_t orig_len, n;
 
 	orig_len = out->len;
@@ -111,10 +119,7 @@ static void format_packet(struct strbuf *out, const char *fmt, va_list args)
 	if (n > LARGE_PACKET_MAX)
 		die("protocol error: impossibly long line");
 
-	out->buf[orig_len + 0] = hex(n >> 12);
-	out->buf[orig_len + 1] = hex(n >> 8);
-	out->buf[orig_len + 2] = hex(n >> 4);
-	out->buf[orig_len + 3] = hex(n);
+	set_packet_header(&out->buf[orig_len], n);
 	packet_trace(out->buf + orig_len + 4, n - 4, 1);
 }
 
diff --git a/pkt-line.h b/pkt-line.h
index 3cb9d91..925c6d3 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -23,6 +23,7 @@ void packet_flush(int fd);
 void packet_write(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+void set_packet_header(char *buf, const int size);
 
 /*
  * Read a packetized line into the buffer, which must be at least size bytes
-- 
2.9.0

