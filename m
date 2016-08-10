Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62A0A1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbcHJTrn (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:47:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33640 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932253AbcHJTrj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:47:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id o80so11603772wme.0
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 12:47:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tw/Rjg2osn/pyXkGNl6f/yo1d4IzC/RhcMPv6sWOzIE=;
        b=pcwrkwNK1mlhnvXCXnjSjlDmhbCHJ026M2tABlKaCZ9agmQlRrNz8AKpQMiUO1VY5e
         tf74D1XCqb/yshacT2F6GOcFYnVWVjqoDDCzJN4OAKTlDSd09u5DshEtm9KqRhY3yqKO
         agPaYSJCDm6kSgGsgTgn26+qa71wWylxfxJYjPIHkBdFkMDbLu2EpMFgotS0gKtfYSLH
         KevrtU7FqWyb5mRfxGL17weeyQM1i4VdCBavSk+eZNoejzJanE3NrAN39CYvCMPyq/HX
         Zwez+a+ntebA71xbbOqdArnU1NMuk2EXG/V5kZ9utHTs1ldi42GaWuPTCPJvPQZvwQ+O
         +1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tw/Rjg2osn/pyXkGNl6f/yo1d4IzC/RhcMPv6sWOzIE=;
        b=hLyebAMCUQF+aTiXaQCVLOD7B2d7Oufxgw2ELS1Dx0IKIiVyq31cfkVgif1jyi0shG
         vBwO48v2i1xqILdE7d9b3XOkD9D2m58U5JSgKirScHE5eGRMTAlIH7bM3hWkoynivnBu
         DES6EMxUgt0MfY24fVyM9ERXUTnfDXXrckLAJB+ev+rGkmmRXEa9pVHYOWN/oo0f8zxg
         mwdkkcUv8tlLvsgZbTNyQ7eONgx55Xvwvgm3dPp2dzrqXUdb+kzEvp2lNlZDRBd6sHVx
         jScdG/9tIvX9FsEcX8Dks9cslipga9DxNFmSCObFCPG9wrbkbeq5kFekaDg68pyv41ug
         k8mQ==
X-Gm-Message-State: AEkoouv/genfG1dGYOpT55DqjoRo3sumaExk89iLgvo/Sca4FirsdQnXsO/TfEtwkXRCQA==
X-Received: by 10.194.238.170 with SMTP id vl10mr4019035wjc.18.1470834257115;
        Wed, 10 Aug 2016 06:04:17 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p83sm8319899wma.18.2016.08.10.06.04.16
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 06:04:16 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, mlbright@gmail.com,
	e@80x24.org, peff@peff.net, Johannes.Schindelin@gmx.de,
	ben@wijen.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v5 03/15] pkt-line: add `gentle` parameter to format_packet()
Date:	Wed, 10 Aug 2016 15:03:59 +0200
Message-Id: <20160810130411.12419-4-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160810130411.12419-1-larsxschneider@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

format_packet() dies if the caller wants to format a packet larger than
LARGE_PACKET_MAX. Certain callers might prefer an error response instead.

Add a parameter `gentle` to define if the function should signal an error
with the return value (gentle=1) or die (gentle=0).

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 pkt-line.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 9400b47..e6b8410 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -108,7 +108,7 @@ static void set_packet_header(char *buf, const int size)
 	#undef hex
 }
 
-static void format_packet(struct strbuf *out, const char *fmt, va_list args)
+static int format_packet(int gentle, struct strbuf *out, const char *fmt, va_list args)
 {
 	size_t orig_len, n;
 
@@ -117,10 +117,15 @@ static void format_packet(struct strbuf *out, const char *fmt, va_list args)
 	strbuf_vaddf(out, fmt, args);
 	n = out->len - orig_len;
 
-	if (n > LARGE_PACKET_MAX)
-		die("protocol error: impossibly long line");
+	if (n > LARGE_PACKET_MAX) {
+		if (gentle)
+			return -1;
+		else
+			die("protocol error: impossibly long line");
+	}
 
 	set_packet_header(&out->buf[orig_len], n);
+	return 0;
 }
 
 void packet_write(int fd, const char *fmt, ...)
@@ -130,7 +135,7 @@ void packet_write(int fd, const char *fmt, ...)
 
 	strbuf_reset(&buf);
 	va_start(args, fmt);
-	format_packet(&buf, fmt, args);
+	format_packet(0, &buf, fmt, args);
 	va_end(args);
 	packet_trace(buf.buf + 4, buf.len - 4, 1);
 	write_or_die(fd, buf.buf, buf.len);
@@ -141,7 +146,7 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 	va_list args;
 
 	va_start(args, fmt);
-	format_packet(buf, fmt, args);
+	format_packet(0, buf, fmt, args);
 	va_end(args);
 }
 
-- 
2.9.2

