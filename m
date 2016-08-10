Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D05A71FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S941366AbcHJTmS (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:42:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35653 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933051AbcHJTmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:42:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so11571250wmg.2
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 12:42:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OyCEuRivIQfA6XCrlRnE+Z1srcO9nIoOHzLVwp4ZwC8=;
        b=THu36XOvBoWk33AMXllJ2x5oLRoYok2jExws6iahdIPKtUt5kcnRyekmQ2L7AZ5Vwc
         tKDuDomfqVgv/BK1j9J4t9J3PI2qNucLi+6+ovUpw1UH3MjDeOndWO4AnS0WXb9/Ui/2
         q+Lhebxt+gghe1mVfxbbPJHzBtXoaISgR1Pb/TYn9WDtYNpbScgLNIRiGYSaI+igsukj
         Fo9tSgk1FJcM+V+I7FxrKLfTYhRn+vv6ncjY16za1UQsu+L0Egk/vy6O3qNTR121W1IV
         RWgrcKCdhOITpZD12pr0AmKP1PZKcmMcFWRLMgfZRz/LCZqxwkQy6SbdINy8TcV4/NpC
         eC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OyCEuRivIQfA6XCrlRnE+Z1srcO9nIoOHzLVwp4ZwC8=;
        b=bRDTlsSOi3eLtOE00xgpIthcgw1Y8KNZl3ZX02U+lq7HAXZwpzRZtAu1p5WXxePr5q
         9pE1KlW5vl0wUNVRx66QlU3FDNistrTggkuQgbrvvW2v/y+ex7w7EMxkpa+5ksEORHYX
         b+2/nIzbZ9HGDlmr/84cM9f48SJoDgKEimS6yt2aYR5gib4PXqvndyZ3xcIYRAabnAvj
         m4l3EzFN76Oo2i7MVtUAvHM8skryXZWsmK2ehejJf9qxYB/52a2Xk1Tvolp2l0DVt3nB
         3d6a4yrfOmuiFehEO7dZx3hBcbqpWW1z+pTjvYMTRXWGjQ8oERG+XYDHartWvEC2SmN6
         4b7g==
X-Gm-Message-State: AEkoouvrL1xa7tkD/cLgNPFWt7skpZcWHuU09cqVQrF00+t3y5sn3aRwiiD4eUY51vqxqQ==
X-Received: by 10.28.50.199 with SMTP id y190mr3027999wmy.61.1470834257928;
        Wed, 10 Aug 2016 06:04:17 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p83sm8319899wma.18.2016.08.10.06.04.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 06:04:17 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, mlbright@gmail.com,
	e@80x24.org, peff@peff.net, Johannes.Schindelin@gmx.de,
	ben@wijen.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v5 04/15] pkt-line: add packet_write_gently()
Date:	Wed, 10 Aug 2016 15:04:00 +0200
Message-Id: <20160810130411.12419-5-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160810130411.12419-1-larsxschneider@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

packet_write() has two shortcomings. First, it uses format_packet() which
lets the caller only send string data via "%s". That means it cannot be
used for arbitrary data that may contain NULs. Second, it will always
die on error.

Add packet_write_gently() which writes arbitrary data and returns `0` for
success and `-1` for an error.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 pkt-line.c | 12 ++++++++++++
 pkt-line.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index e6b8410..4f25748 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -3,6 +3,7 @@
 #include "run-command.h"
 
 char packet_buffer[LARGE_PACKET_MAX];
+char packet_write_buffer[LARGE_PACKET_MAX];
 static const char *packet_trace_prefix = "git";
 static struct trace_key trace_packet = TRACE_KEY_INIT(PACKET);
 static struct trace_key trace_pack = TRACE_KEY_INIT(PACKFILE);
@@ -141,6 +142,17 @@ void packet_write(int fd, const char *fmt, ...)
 	write_or_die(fd, buf.buf, buf.len);
 }
 
+int packet_write_gently(const int fd_out, const char *buf, size_t size)
+{
+	if (size > PKTLINE_DATA_MAXLEN)
+		return -1;
+	packet_trace(buf, size, 1);
+	memmove(packet_write_buffer + 4, buf, size);
+	size += 4;
+	set_packet_header(packet_write_buffer, size);
+	return (write_in_full(fd_out, packet_write_buffer, size) == size ? 0 : -1);
+}
+
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 {
 	va_list args;
diff --git a/pkt-line.h b/pkt-line.h
index 3cb9d91..88584f1 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -77,6 +77,7 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
 
 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
+#define PKTLINE_DATA_MAXLEN (LARGE_PACKET_MAX - 4)
 extern char packet_buffer[LARGE_PACKET_MAX];
 
 #endif
-- 
2.9.2

