Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D9601F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 16:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585AbcHCQnb (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:43:31 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36497 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757127AbcHCQnD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:43:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id x83so37152974wma.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 09:42:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=57PoMFs9GOzIAExE7FK7tkgUQwWPyKU9QBCKO8HmzhI=;
        b=HqYfnRKkugKbyC57wd6iquX5a6zdBply5jfMRxl/xSTI77Q7gOAhlXHBybSKsqMfEJ
         0oqb9YyQIQ6HspCa0X6wpwfiB93rqm4YcBb259FheVBxGwl7tUGHOpLM8OdKtoLXFOQ0
         /RUM34FTLzsvDmHG18RtEgO/Y4yaYGKA2zSytbpnkz+7HYYlD1/olA/PVfTHFz4Pbg1i
         r2oJ9n1Jz7i+FBZbfF9JQm8Sw4KKkw2xOLN8W0djHxj06zRLKXG6zanGBrdVZ2uzfhnC
         iicvAh02NHQSxT0YYeoipWtCUAV/4O5XwCbx1IXq1ss3ARvA3M5w1DhvKP8tBPBVMGWv
         h8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=57PoMFs9GOzIAExE7FK7tkgUQwWPyKU9QBCKO8HmzhI=;
        b=AWSxNnfBWun4Dwwo6wxwJnIQjyKp/YsGJpeK08PVdIIBMMypJ3K0ts9272BHMPJ+kH
         A/9CpNRIWr+IGproPknosCzID/nZ/EWbTOhoNxF8tK5lkyn/Ov0BEKXil/R3tQBMHO2u
         kxQqzQ1ru73TTiyY6sL9uua8KryKGDxAbCU+a9j34cSjsOFJbj8P5pqE0R4KFOlWGjjB
         u7m1BD3Jbi0QFydb9zO2wGpK40lc7Q23xvRyz1Z2wXDG3eT2wd85gcKyP1RbHvwh6Uk9
         12doptt5XmylzjrpnunyYEwsMgnAjQghnkLHu86JW6jRQ87mzw34UJzIS0SW5DSZ6FWO
         n08A==
X-Gm-Message-State: AEkoouvyL6N5ER/D0S8qZvt5BjCLhVGrEFrUbirUQUfcZumqgNDd1VePVloZnbq97TxYMQ==
X-Received: by 10.194.110.229 with SMTP id id5mr68837232wjb.23.1470242551583;
        Wed, 03 Aug 2016 09:42:31 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 3sm8959736wms.1.2016.08.03.09.42.30
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 09:42:31 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v4 04/12] pkt-line: call packet_trace() only if a packet is actually send
Date:	Wed,  3 Aug 2016 18:42:17 +0200
Message-Id: <20160803164225.46355-5-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160803164225.46355-1-larsxschneider@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
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
index c8a052a..d1368e6 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -127,7 +127,6 @@ static void format_packet(struct strbuf *out, const char *fmt, va_list args)
 		die("protocol error: impossibly long line");
 
 	set_packet_header(&out->buf[orig_len], n);
-	packet_trace(out->buf + orig_len + 4, n - 4, 1);
 }
 
 void packet_write(int fd, const char *fmt, ...)
@@ -139,6 +138,7 @@ void packet_write(int fd, const char *fmt, ...)
 	va_start(args, fmt);
 	format_packet(&buf, fmt, args);
 	va_end(args);
+	packet_trace(buf.buf + 4, buf.len - 4, 1);
 	write_or_die(fd, buf.buf, buf.len);
 }
 
-- 
2.9.0

