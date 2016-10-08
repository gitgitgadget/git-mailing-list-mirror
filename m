Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2CFB207EC
	for <e@80x24.org>; Sat,  8 Oct 2016 11:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935096AbcJHL0E (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 07:26:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34624 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935053AbcJHLZq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 07:25:46 -0400
Received: by mail-wm0-f67.google.com with SMTP id b201so6642206wmb.1
        for <git@vger.kernel.org>; Sat, 08 Oct 2016 04:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kIC8By4pmiqU3y9AajtksPZWvst7S+B7n8pWHpbtFW0=;
        b=Ctk3zb6uMHwi4iqypFm5S60/rBRctEz4hLOr3Lkcx5imhkbtm8v2nVjCoe/awB1Dhy
         qaGNV+xGAnbe4s2McXrYseLtvtcwbBb6HN8lfh+MjXrNOzb/OiNjOAeAKLzYgQe0ORN+
         fCjny6St2Nci/D9ILxtsZPtUZnuJ+k7srKl2z/2lUiBMHwjtME8CmPl8nbh+f/HAI5ke
         nETrCfhqOiBPKfqs1kKjK3zzLnpmATmvB/tYitZqvakyQglZtfRBKl2GsKfLJm8urrM6
         lPZuk79IYfuIXCZDaDWpxchIVrv0jNg0EqkGpDExL5EPKftpXpMyWzz7dWvlRPUpd2CW
         tw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kIC8By4pmiqU3y9AajtksPZWvst7S+B7n8pWHpbtFW0=;
        b=TUjY51IBSljzKKk+Uy6uB3A/D6Y9c8aVbq1zCDT3MYBufvaKr4jpZG77kwTAvphmGv
         Av4bF4NPggX6Vck0mRm6H90fCrWGN2ATwBaUUACAHcf4QUT2y2bsczdHT4CYPu8kF9wN
         elThjma7M6AosHbuEQHJitFaBIoVyhqipNHy/cBF2sl3+4nKc3XYAHYPn9eaAhDRQay4
         PJAB5/gwCf7vJ/fle8guuh2F//tcyvjt9PeIODZiLuNvAsmpiUPTO8gQWZWKEzbJP+rm
         +SdcfuP8r1L6D7o90GAp+dx0bO+6vWMUryI9Qy5o47xu4HyjiDcrCQ6Di+tUSo5IAzWq
         Hdcg==
X-Gm-Message-State: AA6/9RkbH/i6Mx+52nGZtnsaE/emCRELRntwZRNuvoK4zj5guv4H0CyzEWYJa5ftiphsZg==
X-Received: by 10.28.56.195 with SMTP id f186mr2490232wma.71.1475925941084;
        Sat, 08 Oct 2016 04:25:41 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB73B1.dip0.t-ipconnect.de. [93.219.115.177])
        by smtp.gmail.com with ESMTPSA id a1sm24599623wju.41.2016.10.08.04.25.40
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 08 Oct 2016 04:25:40 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v10 06/14] pkt-line: extract set_packet_header()
Date:   Sat,  8 Oct 2016 13:25:22 +0200
Message-Id: <20161008112530.15506-7-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161008112530.15506-1-larsxschneider@gmail.com>
References: <20161008112530.15506-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Extracted set_packet_header() function converts an integer to a 4 byte
hex string. Make this function locally available so that other pkt-line
functions could use it.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.10.0

