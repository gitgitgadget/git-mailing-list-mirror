Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDEBB1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 23:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070AbcG2XiL (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 19:38:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32924 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbcG2XiH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 19:38:07 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so17700786wme.0
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 16:38:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HnvCjOBh92ni5R+wkCS6VDr4FvnKtJw/miOhvWw6DX8=;
        b=ZP/OMtQ0frHr1NyEAufnKi1xqNwlkk7piFN7TAnt/QALE6Ww+xQYYGb2pzRIC22H2u
         z2MTJA1nJMbokfnsKtW869nSMb0g5GZQVMXue41KAhVtVa+yuuj9I2w70pt6IjmvYM0z
         xjl4BAoAmUuA3/NBSDyYd4lrsvGl+I1xWx2vy8EdxluRKLEGgl+sc8ZxuFAexBWmzPMD
         r6YtQfWUp7OcMXQkm5V3jwjP43ue5lyi7hVX7UaBqiaYL6Hgg0bY0gTo1C2QQN6IrolI
         K72rMEh9OITR+kx2vZpaOoTVqdfgSkrDIfsc+eqkJAkw0gv1KYZ/7/PX+2esPo4KBpVx
         7Wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HnvCjOBh92ni5R+wkCS6VDr4FvnKtJw/miOhvWw6DX8=;
        b=KaLGpEsUxj1f4YgEXQdCJpHBw/vDYhOtm8ip3DBL+QXVMuif5wiGWeyk5wvJeAAgfu
         4QKA69+WY0gX9Yg7+qdmkaukIPlD2xnlzxeBTP1XCyfvD6NxiR/YVZXHYclJHw31CY3v
         gIxw4JK4LljUaoNpd4CPgE2VVlaPasm89x1Ucv1Vz0dic+QiSiCiIRYzAAsNWAmq+UFk
         xPFT3N4bHCPiQFip2ixrwt0nVSmWCyMUWvFdZpoESdF9oU6lCJsCUEbHL4wlsIOwhSDj
         4DVM5hHTyfY91W/QbtCIiMmEtntZnTWLLTgPiAH+Ms7dBQsHqy1QpPK98Q2S6Lf7iTX/
         yadw==
X-Gm-Message-State: AEkoouvHkydggFeqi9BseZSVwHhdGHecLrhbBISzWstxRPgWEoRuM9wEUwGCNvNdxCSMAg==
X-Received: by 10.28.135.133 with SMTP id j127mr47900245wmd.9.1469835485870;
        Fri, 29 Jul 2016 16:38:05 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB4145.dip0.t-ipconnect.de. [93.219.65.69])
        by smtp.gmail.com with ESMTPSA id i1sm18663212wjl.9.2016.07.29.16.38.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 16:38:05 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v3 01/10] pkt-line: extract set_packet_header()
Date:	Sat, 30 Jul 2016 01:37:52 +0200
Message-Id: <20160729233801.82844-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160729233801.82844-1-larsxschneider@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

set_packet_header() converts an integer to a 4 byte hex string. Make
this function locally available so that other pkt-line functions can
use it.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 pkt-line.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 62fdb37..445b8e1 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -98,9 +98,17 @@ void packet_buf_flush(struct strbuf *buf)
 }
 
 #define hex(a) (hexchar[(a) & 15])
-static void format_packet(struct strbuf *out, const char *fmt, va_list args)
+static void set_packet_header(char *buf, const int size)
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
 
-- 
2.9.0

