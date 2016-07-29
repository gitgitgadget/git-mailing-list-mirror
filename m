Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A8BF1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 23:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498AbcG2XiV (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 19:38:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34475 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979AbcG2XiK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 19:38:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so17717445wma.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 16:38:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zl/PXyufBeJKdeBHHw4trUp2naM6V8WzBiBN/h1Ki/Q=;
        b=ZN8c4wedHccovh6BSWOz1UrPBAJlpFtIKXiFM9hi9FgEQYNUKVPhwniPBxeq96NGy1
         YoELyYjp+ldts9T2Dj0RAVdag2GUaNiF3fI9+fdmz8crIiB7mUb6OaAAZEBcpV0DtUeJ
         4y/k9ok0EUCTq5ua1zD0eAZ0rviCPeyKR1clWcgq5Z5EhnSVwDdgYilV8JuG85wSENCs
         fXB0gb2+Jn2ZaTJ7hhopAEQBASLYQq9pvfT7HAN68vtA5PWqa/9ujr1P4q9MEKtaAegI
         inf0m7w3603xTa020PqhqVsmIjyEsea7n72TZQ1wGBDb3vEogBJkomzpOf+yg85qM8pX
         JJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zl/PXyufBeJKdeBHHw4trUp2naM6V8WzBiBN/h1Ki/Q=;
        b=Mc8AkMDJFTjnertx7reCSJM2qaHNDV8+utgxJ7cl6P4iMup5PiRW9Yrzf1+chHZO8I
         XbU80Z3WOpAFXnhnbaEN+Sth9fik+MU73T5QIFsMUoGWPNGUfDzPT7mRoIufXFIuA9ZC
         N2b98urZLV5qM+UN6xjMsIRKHZJo5batL1JSuOnvYxJcVgeThUYBm0XSTMKVsY/ISgcH
         RzdefHZuCPhnvRodS/2UDpR/83bpOL0JUxX85x+LbwpVntj+moXsm/fdvUnTccU8Vwsa
         j5GvEKAsiFPDfzvrXVN0FZd02aZSzIdJaVVc/e5sej8f/kEgpldZqNmeFeGk82xN8Sdx
         k2mg==
X-Gm-Message-State: AEkoouvpqF8qYmHw1PCw/rswKDZ2vHW3mrfY7/ASjWs+Rv5yy/3HhV3Q4pXerZyw1JMQcg==
X-Received: by 10.28.86.65 with SMTP id k62mr3387849wmb.53.1469835489302;
        Fri, 29 Jul 2016 16:38:09 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB4145.dip0.t-ipconnect.de. [93.219.65.69])
        by smtp.gmail.com with ESMTPSA id i1sm18663212wjl.9.2016.07.29.16.38.08
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 16:38:08 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v3 04/10] pkt-line: call packet_trace() only if a packet is actually send
Date:	Sat, 30 Jul 2016 01:37:55 +0200
Message-Id: <20160729233801.82844-5-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160729233801.82844-1-larsxschneider@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

The packet_trace() call is not ideal in format_packet() as we would print
a trace when a packet is formatted and (potentially) when the packet is
actually send. This was no problem up until now because format_packet()
was only used by one function. Fix it by moving the trace call into the
function that actally sends the packet.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 pkt-line.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pkt-line.c b/pkt-line.c
index 1728690..32c0a34 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -126,7 +126,6 @@ static void format_packet(struct strbuf *out, const char *fmt, va_list args)
 		die("protocol error: impossibly long line");
 
 	set_packet_header(&out->buf[orig_len], n);
-	packet_trace(out->buf + orig_len + 4, n - 4, 1);
 }
 
 void packet_write(int fd, const char *fmt, ...)
@@ -138,6 +137,7 @@ void packet_write(int fd, const char *fmt, ...)
 	va_start(args, fmt);
 	format_packet(&buf, fmt, args);
 	va_end(args);
+	packet_trace(buf.buf + 4, buf.len - 4, 1);
 	write_or_die(fd, buf.buf, buf.len);
 }
 
-- 
2.9.0

