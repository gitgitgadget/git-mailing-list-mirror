Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE7B52098B
	for <e@80x24.org>; Sun, 16 Oct 2016 23:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757035AbcJPXVV (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 19:21:21 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33477 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756917AbcJPXVM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 19:21:12 -0400
Received: by mail-pa0-f65.google.com with SMTP id hh10so8539765pac.0
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 16:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QJ69OdN9IyjWhdItkTwhJzX9iN1XESeF0JRao84JDSQ=;
        b=WZTIPhzW5vNXOmp3cggS7FKg3TszX1+u7udRmB06OgA9Ylt0LbjQ17zdYT5y66RPKy
         BeRmoLXZgv85qJ3J7xkgDCYVzgg0brngY9iIpK6YqtEprt1Esb2mgAR249YIIWEUVV96
         Wgrcf4NAwjopoYKDPwHC/cEOSGJYYJshDo4Eqw8tsuEVsm2Olde2rmemlBZ/rEFxrGD5
         TnyAIODrKbLZh8snFGqsPF/KJJpqVQDgnSTqhx1Flc7C7kzuzSqZa+KE/Z9FYxXc9yl9
         6yKJZhk/Kw0ld5CmPH6djO8wbdWda6XmKSTTpl12S8f7UUAJAcbRimkMy9yaWyq0BqVX
         qiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QJ69OdN9IyjWhdItkTwhJzX9iN1XESeF0JRao84JDSQ=;
        b=gPfnWt84XjDuM7CNElxSRfdwLx8WOWamQjgWqMZWWlA2eXwu38fDPgmzF9sJqlWaKx
         ndIi7w8kGDiCnoOe6OOB0hz9AdcmRqmXYNNmWnkkEFrUXF7EfV2T6HPTfqO/XiN2evu+
         B6YrGLTUj+6PN2l8ox5POdMlGZOQ1i/r68d/nXNeY9MeQDgJYMOThvGpnV5CKVWQNcAK
         kXhXQa8OOPsQwp3bCLEIl+zNSLkNJl1GGQJVQr7kkNuQf9M7Vju6MVv/ElR1Hiz+4SDG
         tTlnkyNUyUIf7JOCcDZOXRVfB91+8+IGd4CL5upe47Rx79SZOTHfF0bQSsN0sXRASPBF
         Pd4Q==
X-Gm-Message-State: AA6/9RlsCkS4Zt8TYU1865uPW1Zwy01RgoZUfQ6tR7BTSCAXeB5tc6PkYn2c7pcjftfboA==
X-Received: by 10.66.175.203 with SMTP id cc11mr28656579pac.102.1476660071286;
        Sun, 16 Oct 2016 16:21:11 -0700 (PDT)
Received: from rem3n8pj12.ads.autodesk.com (adsk-nat-ip4.autodesk.com. [132.188.71.4])
        by smtp.gmail.com with ESMTPSA id cp2sm10325691pad.3.2016.10.16.16.21.10
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 16 Oct 2016 16:21:10 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, tboegi@web.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 07/14] pkt-line: add packet_write_fmt_gently()
Date:   Sun, 16 Oct 2016 16:20:31 -0700
Message-Id: <20161016232038.84951-8-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161016232038.84951-1-larsxschneider@gmail.com>
References: <20161016232038.84951-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

packet_write_fmt() would die in case of a write error even though for
some callers an error would be acceptable. Add packet_write_fmt_gently()
which writes a formatted pkt-line like packet_write_fmt() but does not
die in case of an error. The function is used in a subsequent patch.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pkt-line.c | 34 ++++++++++++++++++++++++++++++----
 pkt-line.h |  1 +
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index e8adc0f..56915f0 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -125,16 +125,42 @@ static void format_packet(struct strbuf *out, const char *fmt, va_list args)
 	packet_trace(out->buf + orig_len + 4, n - 4, 1);
 }
 
+static int packet_write_fmt_1(int fd, int gently,
+			      const char *fmt, va_list args)
+{
+	struct strbuf buf = STRBUF_INIT;
+	ssize_t count;
+
+	format_packet(&buf, fmt, args);
+	count = write_in_full(fd, buf.buf, buf.len);
+	if (count == buf.len)
+		return 0;
+
+	if (!gently) {
+		check_pipe(errno);
+		die_errno("packet write with format failed");
+	}
+	return error("packet write with format failed");
+}
+
 void packet_write_fmt(int fd, const char *fmt, ...)
 {
-	static struct strbuf buf = STRBUF_INIT;
 	va_list args;
 
-	strbuf_reset(&buf);
 	va_start(args, fmt);
-	format_packet(&buf, fmt, args);
+	packet_write_fmt_1(fd, 0, fmt, args);
+	va_end(args);
+}
+
+int packet_write_fmt_gently(int fd, const char *fmt, ...)
+{
+	int status;
+	va_list args;
+
+	va_start(args, fmt);
+	status = packet_write_fmt_1(fd, 1, fmt, args);
 	va_end(args);
-	write_or_die(fd, buf.buf, buf.len);
+	return status;
 }
 
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
diff --git a/pkt-line.h b/pkt-line.h
index 1902fb3..3caea77 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -23,6 +23,7 @@ void packet_flush(int fd);
 void packet_write_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 
 /*
  * Read a packetized line into the buffer, which must be at least size bytes
-- 
2.10.0

