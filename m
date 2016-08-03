Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B44921F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 16:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758010AbcHCQnF (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:43:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32960 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756622AbcHCQnD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:43:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so37173935wme.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 09:42:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ecUKECkvPa9PwSScHewQHwDQkY5xlN41u1H4aNHxKEA=;
        b=fZe5jI1BqlH2bMctxNuZrUFaqvt6mt68uLDo+RCW3EwrvcYnj8bJDbxT5oxbWTP8Tv
         y8TeE13g4bMgexOYdtyV9jC46n9urjBjfto39tcfpnwYYkGsd0OmuIBhqrolLIUpAQ/v
         B1/w3Kqvl4IHeeUFEuRytfmrndR8uliCI3zMvaKxp3oqn+6XiCbjvGpC/O47lh4kMfzP
         y57SZ0X4VwHMaEbfEpylOWwdr6UL794u7WQpXjkgOcuTkmqm9XRZO6WyvcFqzsk+oAqM
         sd1Dkh/UsTylB/aFvduCErVsebGG5lNI4eVYK9/5i8yDZU7cBPZQIuvxSv2NN01gjKCc
         uekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ecUKECkvPa9PwSScHewQHwDQkY5xlN41u1H4aNHxKEA=;
        b=eBx7Fzsrg15xD6n59hzahrY3ZopQ6zKLh4fs8YBNDE2om78sp4dqA0dWEEt3hLx0cf
         GRe6Td7Qd8WxKdBrvDPZ014DbpE/dpVJe2AkoFetI97Oy6NqoJbupni9KDiHN+p8uq14
         bq0YumDaEGLzuFT+w9xnH3Mudo3iXOTTZbuAkG4ma3jbgzImi6WSui1RRXTbJzY4jzJW
         vpW8QmumUDLRJjn7lUiv23Vf/BkappluOepoaK/23xjQfXBmHurpnrtqomzB9NOl7UpX
         qgcMf5eJRfMRZ1e4INCwSF/ANNdTJivgXTtb/WWJTGR/E+Q5HkN3/tNO5B+PVP/JA8OZ
         CFKQ==
X-Gm-Message-State: AEkoous7U4ZPRirw2gyhOyHdaCmR1AsKFjMy51ovKnunvGcghiXX1gBvcSay896gZ0txpQ==
X-Received: by 10.28.37.194 with SMTP id l185mr53766562wml.82.1470242548513;
        Wed, 03 Aug 2016 09:42:28 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 3sm8959736wms.1.2016.08.03.09.42.27
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 09:42:27 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v4 01/12] pkt-line: extract set_packet_header()
Date:	Wed,  3 Aug 2016 18:42:14 +0200
Message-Id: <20160803164225.46355-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160803164225.46355-1-larsxschneider@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
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
2.9.0

