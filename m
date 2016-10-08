Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F217A207EC
	for <e@80x24.org>; Sat,  8 Oct 2016 11:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935086AbcJHLZ4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 07:25:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35536 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932882AbcJHLZo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 07:25:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id f193so6634640wmg.2
        for <git@vger.kernel.org>; Sat, 08 Oct 2016 04:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QJ69OdN9IyjWhdItkTwhJzX9iN1XESeF0JRao84JDSQ=;
        b=eShZYDHNywuN3ZOqkPrys0PfBq5IYZInEhKGvHaINM3CHZ3L6icaLr5tHTqon1gYns
         7fogeh7EiHLSj4ZnknNJ1xTIlMm4LVNHd6dXFSpC1LQpiDRq1MvSXusTrVJKz6bk5q4l
         Qn+Ju6uNUd1+WhZjinQnqUkC7t57kwArU/kf+aooQFP1Wd1KGlAqIhvKmV9Qmom5i3HK
         QxpZjow02A8nzwQprzAOyy4B9/uzC/uGu3l36TGKhW83vmRHbgRWVsRA7c8RiROuX0kA
         KeiWefooEX5dsuHRu4CFjRGHwyRPSXpb6w04qW4b2EJxNGTD4XHr3vBQWyy0710xD1/b
         54Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QJ69OdN9IyjWhdItkTwhJzX9iN1XESeF0JRao84JDSQ=;
        b=Yn9YR8pUbiu/K6DJ1C37V0EF6tPkHnBKWQMIsy83/qxF86VuYin8VxJ1vhcNQqXLHv
         4CC+kK3FQr7z7zlIXVG8yNUCO6/upZz/hAai28vN95gr2iXWU8ufAEJYocbVsL1OK0jL
         y9mqL7fCDZWNH/sN4XF1wT+kBvBujHNsLvjPagU8sUwj6dsmKLdq8B8IzuhQSVXTzeqO
         NIndOqoon6QkNkFlhaEAru1iESgRq7+5zvz/lcnDOVl53WjdS9yjk9/EyGjdMmlaBjWk
         K1GUxN0UPsA8QYpNJNyIaaaFQc7oD7co00Zs0VjE381UfiNIzbCml9TnQNWYaP69XHEj
         Wy0A==
X-Gm-Message-State: AA6/9RkeUX3GXex0551Z5V6yWYVgUv7bTnl/KcWqJJByFdPU9yyPtGkxdPap92l6Xqm1cg==
X-Received: by 10.28.54.39 with SMTP id d39mr2999801wma.11.1475925942598;
        Sat, 08 Oct 2016 04:25:42 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB73B1.dip0.t-ipconnect.de. [93.219.115.177])
        by smtp.gmail.com with ESMTPSA id a1sm24599623wju.41.2016.10.08.04.25.41
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 08 Oct 2016 04:25:41 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v10 07/14] pkt-line: add packet_write_fmt_gently()
Date:   Sat,  8 Oct 2016 13:25:23 +0200
Message-Id: <20161008112530.15506-8-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161008112530.15506-1-larsxschneider@gmail.com>
References: <20161008112530.15506-1-larsxschneider@gmail.com>
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

