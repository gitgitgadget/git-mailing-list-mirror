Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E349C209A9
	for <e@80x24.org>; Sun, 16 Oct 2016 23:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757042AbcJPXVW (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 19:21:22 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35610 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756898AbcJPXVL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 19:21:11 -0400
Received: by mail-pf0-f194.google.com with SMTP id s8so11496723pfj.2
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 16:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kIC8By4pmiqU3y9AajtksPZWvst7S+B7n8pWHpbtFW0=;
        b=b2AuFoVL/Icp1Q9EkxP6N4037n35wN+NTOcSRlng9HagWMjMH/cCzE0B5ujAQAd6ox
         oaIZryv+yoK9spwDifC14c6gOZC2poytPNllfrcm3HCQJLlozvTL7J0SXPALjpOs4UmK
         MoV77j/QxEcu4xr/mn/MKVXIqzFmsWY/RKSUJrAUCk4c5SWNOf7+LkPLRZKAdchWsLXI
         0DKX3BScsgU2JcdKOwZKHnmk+erV1yqhiU9lVpiiyvP2BWNwxou+ZQ6nAn8XHjYHgU8B
         G9ObS2VMei1S+bxFviBWVZuRee5H5P1JSgN4xH0593X92PyHSAoWYYw5adQdYHXhYxk0
         ORCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kIC8By4pmiqU3y9AajtksPZWvst7S+B7n8pWHpbtFW0=;
        b=R94ljXIlZFzUJMdJVWks7lSbrgYJ/89y6Pmo/zTB7z4hg7N5BtEx6xYalwflca2G4a
         mxwU0xLY62Y0gaJiQqo/S+/qZcYUOwbpuRHJewXcryYr/IkSOHsJNebP7SlbE5Jonrbj
         6J5j0AkK+TiNLi+dkT4fpy41mHM5acjKHEEboqz9FYtq6wRyzsV+vNnyW1FYJPRvi1/f
         i/99Cl8IGAVmgWMzX7/s/EAhnK1uaKsgzABlLfoLNo3h3jBKqoAwKn9+wmgYemTggQPQ
         RWrx/weoJ+Wc8hT91NZ4Wgyp6XgNd+61abmpT3wJ1RdTmAsL3D2LxeDh4vwGw79gYLvm
         jfsA==
X-Gm-Message-State: AA6/9RnnJ4RfY6Q6gBV2ENb/m8cJTIMw+sYpbbQQzZUGSCGHf9/1SXN+E7n8vWwd3TSYLg==
X-Received: by 10.99.116.76 with SMTP id e12mr27970308pgn.20.1476660070102;
        Sun, 16 Oct 2016 16:21:10 -0700 (PDT)
Received: from rem3n8pj12.ads.autodesk.com (adsk-nat-ip4.autodesk.com. [132.188.71.4])
        by smtp.gmail.com with ESMTPSA id cp2sm10325691pad.3.2016.10.16.16.21.03
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 16 Oct 2016 16:21:05 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, tboegi@web.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 06/14] pkt-line: extract set_packet_header()
Date:   Sun, 16 Oct 2016 16:20:30 -0700
Message-Id: <20161016232038.84951-7-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161016232038.84951-1-larsxschneider@gmail.com>
References: <20161016232038.84951-1-larsxschneider@gmail.com>
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

