Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8767320987
	for <e@80x24.org>; Tue,  4 Oct 2016 13:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754119AbcJDNAC (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 09:00:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32958 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbcJDNAA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 09:00:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id p138so19571285wmb.0
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 05:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QJ69OdN9IyjWhdItkTwhJzX9iN1XESeF0JRao84JDSQ=;
        b=KoQyVygtRpR8cTVK0Zo4M0DjzXDZaVMujT1y7ty9XjZk9zsVTHCBF6ByT+bnqsRPIS
         60Fl1SFdJhr9h/aiDSkmNi4BeBaFQ1ocIh3jHMZAzC60DWJbQAQD+uDnBTLaHvcs1yTX
         hC4grlScZFbqB4ISiTh9UFB8D1tNZy4j6mRadgT+osmOjrhq8G93/AkrRtiUTjN7uAKn
         2Gqy/O6/YT0qXRLUxDc2QYtE1IGbKm1u60g8zvNsveqrEluoYyWkehYO4DN1wmB1oKXP
         9M4HSfX18oep3YHHZnI1qhTIwFZqlUr5h9Hi/qCivBJo2VorM+l4D7v7x8JFqRSZUqNL
         Qf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QJ69OdN9IyjWhdItkTwhJzX9iN1XESeF0JRao84JDSQ=;
        b=NcCg6dt7W34E3kFawBD6otNMzF6Vls+klBB4uzu6Q4OlEKCutiR7/RIhW/SYX+Ep6k
         cnIYLL2dbhyycmVBEJedXbVMOiO9JrcGzcYxi7jb+CataYy2ZIv/I5Vh3o+6Jg97YBaI
         sRzufzcmUnYLtJT+xf06LbwDfvlbEnEo9d+SoKDVgtf1BO93oC0sxSqIJ8/PzPz59d6o
         de1R09jdMa1Nk0umY3kkSlCHNPt+nvbQK7I0eWvizo7Bjbh0oipORMhxsJWga1Uy+nmU
         jqotN3Ip+HG70CJy1PsUXBmdmL+6KdAW9x5LhkJP7S6UEgJqFSZjKy0AQabHt0vijmXa
         +/yQ==
X-Gm-Message-State: AA6/9RmLXJmyV2M883rOJ7uMngwhOqiE9kwHodGXw5zZ3Cg6QsSUzMUJUEq4rvL0n/ZNDg==
X-Received: by 10.194.58.175 with SMTP id s15mr2948830wjq.97.1475585999046;
        Tue, 04 Oct 2016 05:59:59 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id qo8sm3426934wjc.46.2016.10.04.05.59.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 04 Oct 2016 05:59:58 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     ramsay@ramsayjones.plus.com, jnareb@gmail.com, gitster@pobox.com,
        j6t@kdbg.org, tboegi@web.de, peff@peff.net, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v9 07/14] pkt-line: add packet_write_fmt_gently()
Date:   Tue,  4 Oct 2016 14:59:40 +0200
Message-Id: <20161004125947.67104-8-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161004125947.67104-1-larsxschneider@gmail.com>
References: <20161004125947.67104-1-larsxschneider@gmail.com>
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

