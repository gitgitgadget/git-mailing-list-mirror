Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF3CE1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938920AbcHJTIg (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:08:36 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32980 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932926AbcHJTId (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:08:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so11402691wme.0
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 12:08:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SgagOjEcj6ft2IAebJ7xdCBjmGA+lIwpTT9DCcmLZa8=;
        b=BEPtqQkZ2wMxqdP+FxQCjNrnIy8DUQMsL8c/GQEvi/87G2KHBCx4fOuA9XFvr6Thu0
         Xchh9nSPZ/LxCnAFmv52MOMjCZ9ZAyG0AakSvA/RE1vxqvpX5gTXHj7aeyFz/PyHRcRm
         c4ruafP0KzmSrcdx+dZI94SU9Pa3ic2bc4oDPIJm2K0SUlWcT1BShVVOUZLhWjQ5g3sf
         g2DjnTLmxMyArvieQsQR+a8r6VjPgOzi0gBIYRnsZal8gtJRohqP0jCkKHysei5CZmpa
         6Zwe3sTSLsyQj1UqLYDfR71k5UfdXUEo0Dj45WrtkzDvutANG6K9DFcvzcyTZ/TVN7jW
         +V2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SgagOjEcj6ft2IAebJ7xdCBjmGA+lIwpTT9DCcmLZa8=;
        b=halOSWJTjUga3S2X5CfDoJxTkshLG98h+/9uWkpmkcMgFDkqnywuqN1CeDe6dQHQc3
         pHvWJEZjP0BH/024PjceZAKsUp0l22lhbaRc0hsyiLrTk+vT3+4vBueMFX/bVzpSiCT1
         lrh6oY3fUUmXa/EXBlioebSADTo8DnM8FjfBKzB8bTNNLHKj7H3ZLJBjNMrtIZ038PLw
         Z8gQfK8Wt+TkXZ9D60gX3tSGG5Oh7yuGp26Ne/j3w4SCm+kzoW0qM94Z/eIt9/x2w+SC
         0ZViF+M68dnpSq8MvkKl+V3bQ58UsLK+JiV3dSTocF3ef7Yz1To2oW5fHJo6cuBgpIl1
         ZUfA==
X-Gm-Message-State: AEkoouvNpzqXrgPSxdlSKLlGnk1dw+L697e8UfzmMs2IiiNy6KdVyPxCLPjcXw94Zo3ZtQ==
X-Received: by 10.194.16.65 with SMTP id e1mr4420493wjd.143.1470834255420;
        Wed, 10 Aug 2016 06:04:15 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p83sm8319899wma.18.2016.08.10.06.04.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 06:04:14 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, mlbright@gmail.com,
	e@80x24.org, peff@peff.net, Johannes.Schindelin@gmx.de,
	ben@wijen.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v5 01/15] pkt-line: extract set_packet_header()
Date:	Wed, 10 Aug 2016 15:03:57 +0200
Message-Id: <20160810130411.12419-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160810130411.12419-1-larsxschneider@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com>
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
 pkt-line.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 62fdb37..177dc73 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -97,10 +97,19 @@ void packet_buf_flush(struct strbuf *buf)
 	strbuf_add(buf, "0000", 4);
 }
 
-#define hex(a) (hexchar[(a) & 15])
-static void format_packet(struct strbuf *out, const char *fmt, va_list args)
+static void set_packet_header(char *buf, const int size)
 {
 	static char hexchar[] = "0123456789abcdef";
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
@@ -111,10 +120,7 @@ static void format_packet(struct strbuf *out, const char *fmt, va_list args)
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

