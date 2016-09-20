Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98933209A9
	for <e@80x24.org>; Tue, 20 Sep 2016 19:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932914AbcITTC6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 15:02:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33459 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932825AbcITTCy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 15:02:54 -0400
Received: by mail-wm0-f66.google.com with SMTP id w84so4915697wmg.0
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 12:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oxErh74cjPFwjV+Dv6pSdxAEpX1yzl4B8+RSy/8Qfuc=;
        b=aLPRvv2iO8E9d3iqA+cZ3KLExJp8sB4Av8f9rJnMcqUMdDu5WEmSEQpoI9RQHhvKcr
         5x3+YClnGZu35hwugR4vb365LFDiBbIb5zErcfVvluWxzRT4gsMd+ApE3cTg+Dgt3OXO
         Z5Aob1P/UpfNchNHFElw2rv+1aq86G5NnuSRdOF8LT1JTJZvvXpFgG25IR9WH6MCKN4r
         KbX5zIblkw8ykD1P1vKTPChiwvfn4Vj+wZRQh96YqfyaGNLrObAgzwV2UsakpySXG7XR
         lYMOTXj+rzgl7ykUrSd//eQZ0eTWfuFXhoDbzAsTwkDo1SbdXPW1QgEHqC4XqYqZs3wi
         lJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oxErh74cjPFwjV+Dv6pSdxAEpX1yzl4B8+RSy/8Qfuc=;
        b=bI66vMgHSZl97LlcbVsJr3+b/vQtOZBfnQ86K36D1vg97nMouftzJ3wJsIvKEw7m7W
         Xbk35ZStvX4J17PcqtzItp+Rd4GibMHzxE19QI/pxsds4kY7++QaHrvfZsTrWXDMAOkr
         7jhN0XK8nVOsTBI0uO3cw9cMt0aBX+6Qe9Mttv6I1GicDrwihcBTGX/212vokVNNGT/0
         ngqPWQ8LUOTDunZ7YWfTRv/EWQN2lLEZrT+kXzBj//MHicOyccJF0I3ywp692GazVbOx
         u7hlDel+wvGvMeCrCqWzuGy3DDrUYoV0ciz8IQqQPsACRn10RFh6ToaxSa80nssFU8Wf
         sYlA==
X-Gm-Message-State: AE9vXwOGQnZQsdzWch5gODip0t9xjZO3mvU+A1YnYW32ZJjki90RSaI9i4eFazEXtqRzLQ==
X-Received: by 10.194.172.42 with SMTP id az10mr29234716wjc.178.1474398172920;
        Tue, 20 Sep 2016 12:02:52 -0700 (PDT)
Received: from slxBook4.fritz.box (p508BA5EF.dip0.t-ipconnect.de. [80.139.165.239])
        by smtp.gmail.com with ESMTPSA id gg10sm29820728wjd.4.2016.09.20.12.02.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 20 Sep 2016 12:02:52 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        jnareb@gmail.com, mlbright@gmail.com, tboegi@web.de,
        ramsay@ramsayjones.plus.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v8 02/11] pkt-line: extract set_packet_header()
Date:   Tue, 20 Sep 2016 21:02:38 +0200
Message-Id: <20160920190247.82189-3-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160920190247.82189-1-larsxschneider@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

set_packet_header() converts an integer to a 4 byte hex string. Make
this function locally available so that other pkt-line functions can
use it.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
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

