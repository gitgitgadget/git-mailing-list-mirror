Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E9261F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbeCNSda (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:33:30 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:50841 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbeCNSdX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:33:23 -0400
Received: by mail-qt0-f201.google.com with SMTP id q19so644771qta.17
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=/lrtx29gmdJUFMTurBz7wRhSLe64sCzb4mIOvMwTaBc=;
        b=qG3FBnBPiJeDdQjjCIoEoeXagr6IaRHLbEcBqL9ANWk/6IKR+LOXKOgZU8kmdqMrnQ
         wAlZu6m62IFkT66Br9NwASdXF3ijbl7riK2AJ7XENID3uLLRw3nh3wKpdJhG85qSRjAZ
         A4BXD9fkqP9ro6NoDJD4D6UfEkgIr6v4Vf36e7NsjdnJPfo7CzQ+STK3lrnI1NKeNbIo
         UW+mypc7Jg4W0n0jvInUmTXSSfBpM3u6jJ57MXUMTd5GNu6qp0+n7ZjGjZlMJ16TXztL
         pinbSEg0KXVmPpEDADWqrCUJXfSSVEIZ9i0Oi+xD1RhwZucZ9ZfZDtPPJmZ01ZeFUq5E
         yo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=/lrtx29gmdJUFMTurBz7wRhSLe64sCzb4mIOvMwTaBc=;
        b=jTSTkjr6H4/L567OSQWsrW2aRdITOcCu4LrHQ2z2nnZ2hF8ea10EwySSLB0es5GEY4
         Kxb0tIpGi/oTyLOaykJi8sdfGujmEqHobBAA+ufLS5puRVrJdqIYS6FXZQp8E/WuWFCG
         gthq0aCab59sZCOhw9RaVQ99XSOq+TARPrnwKLtUhQQ9Hq0O32lf2f78JfoykmRmJm/p
         WHB4+Y/aR6tKyOkOL1nXPmuDeVDxifJc9OpH1ZY3kEsZtfqOxTNPigNtMbaMXxt3DNbI
         TBckxFkUcHBdBRGaThtcZIZwqRu4gVzew2GmSvWHal6pA0cos8ykWrM6QLsEMfXT9OUv
         OugQ==
X-Gm-Message-State: AElRT7FqCt9v9VPLKyOral3QYnubresJjK/71eXEyvOCEdSN5wi4AGDP
        YoidTA9WAa3G+qj6zaNfkjeq9eiuCIccDLsdVOjxYWayCurxIR18L9k09SMy+z/Q5Bj2D9GIUCY
        qc3lfXmHjXxCh4kzVZ/aiN6wUJruciHg2ASgw4UrpOb3zHewb4Yc6+7pq3A==
X-Google-Smtp-Source: AG47ELu9yU9N80ijRub36YewOPcrS1XFiZFW7PtQ+GE63SFJH0dUyqaxNSm7S2Je4UnMXYeDPSwg4yWNJSw=
MIME-Version: 1.0
X-Received: by 10.200.18.66 with SMTP id g2mr3622647qtj.27.1521052402273; Wed,
 14 Mar 2018 11:33:22 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:32:05 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-29-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 28/35] pkt-line: add packet_buf_write_len function
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the 'packet_buf_write_len()' function which allows for writing an
arbitrary length buffer into a 'struct strbuf' and formatting it in
packet-line format.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pkt-line.c | 16 ++++++++++++++++
 pkt-line.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 7296731cf3..555eb2a507 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -215,6 +215,22 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 	va_end(args);
 }
 
+void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len)
+{
+	size_t orig_len, n;
+
+	orig_len = buf->len;
+	strbuf_addstr(buf, "0000");
+	strbuf_add(buf, data, len);
+	n = buf->len - orig_len;
+
+	if (n > LARGE_PACKET_MAX)
+		die("protocol error: impossibly long line");
+
+	set_packet_header(&buf->buf[orig_len], n);
+	packet_trace(data, len, 1);
+}
+
 int write_packetized_from_fd(int fd_in, int fd_out)
 {
 	static char buf[LARGE_PACKET_DATA_MAX];
diff --git a/pkt-line.h b/pkt-line.h
index 9570bd7a0a..5b28d43472 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -26,6 +26,7 @@ void packet_buf_flush(struct strbuf *buf);
 void packet_buf_delim(struct strbuf *buf);
 void packet_write(int fd_out, const char *buf, size_t size);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len);
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int write_packetized_from_fd(int fd_in, int fd_out);
-- 
2.16.2.804.g6dcf76e118-goog

