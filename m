Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9534D20705
	for <e@80x24.org>; Thu,  8 Sep 2016 18:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758582AbcIHSVw (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 14:21:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33767 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758376AbcIHSVn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 14:21:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id b187so5010101wme.0
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 11:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jSmRF6Q4cd4rAHwZ6LwvhtvhNs5GDMJzHQWYM9LfN7s=;
        b=OCp5B3MNVP4g60xQ41qwZVTyXBzBy8wxEz0v5L0D6w4QJ6f8yFQ3Gbe7tABjEcicUJ
         g7KO+4ANmRf1/2wQ4DuvfN2LgHj2vbtldqwFzJRBI+lfm3n/7naOM36Zfzub4ROClZxF
         jl+c5m74mU2i6YPZ1U7NQo296zDJaQr3lHWuAxfdFtBOeGNI1mI4gjC7LZf3XJi9jveh
         0GPIpAMtHvaqbLUjGTJAz3KIjKO41AcX4/Gt4hiv1qV3N89pdx5yNj4l5f5MwBJARLG5
         5HouFOwXJhmkDRVhDOaXnisl0Qj1clZe9vPbHQ0cH3G90eGCn7LjX4n+TRVeHMae0QWT
         9NTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jSmRF6Q4cd4rAHwZ6LwvhtvhNs5GDMJzHQWYM9LfN7s=;
        b=Z7mRb4RW5mPJnSqsBT6IJx5uIG3k2bxNzNWN0btnXDIFGsZUCA8caBCDBRusei1a/t
         hXxGvFz6iPF4KW8mM+g6tIlIortm4lEguXFrULkN3VJtji+AAwjjaiFcJrIRbpq3bCYm
         k6p+HoMLeIkcpUZI7+bsbmRe08oW80IhNmqPIigPOvwhY/IeLU2lEh8xIq/WL8lPSHHg
         V+UXu1bNdVcHpOjL1VZaPG11LWKJkD9aBYEc6QDRTBRtDPiZmkMpbsaq5XxEixxtgDpR
         ADqVZMDu6QdI6mCfx+5nMQC9V51D59cchgwopeeKvVk6suo10Tr74gTrV3K5ghAaDx8W
         2CwQ==
X-Gm-Message-State: AE9vXwPPsDscrjKrPyJum6dF/oxOja4JI62nkOB/eHOK4D80EQjEK4tX3XyU8lC/vFsROA==
X-Received: by 10.194.191.162 with SMTP id gz2mr886598wjc.182.1473358901797;
        Thu, 08 Sep 2016 11:21:41 -0700 (PDT)
Received: from slxBook4.local.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id b128sm10967467wmb.21.2016.09.08.11.21.40
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 08 Sep 2016 11:21:41 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        tboegi@web.de, jacob.keller@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v7 03/10] pkt-line: add packet_write_fmt_gently()
Date:   Thu,  8 Sep 2016 20:21:25 +0200
Message-Id: <20160908182132.50788-4-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160908182132.50788-1-larsxschneider@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

packet_write_fmt() would die in case of a write error even though for
some callers an error would be acceptable. Add packet_write_fmt_gently()
which writes a formatted pkt-line and returns `0` for success and `-1`
for an error.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 pkt-line.c | 43 +++++++++++++++++++++++++++++++++++++++----
 pkt-line.h |  1 +
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index e8adc0f..3824d05 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -125,16 +125,51 @@ static void format_packet(struct strbuf *out, const char *fmt, va_list args)
 	packet_trace(out->buf + orig_len + 4, n - 4, 1);
 }
 
+static int packet_write_fmt_1(int fd, int gently,
+                              const char *fmt, va_list args)
+{
+	struct strbuf buf = STRBUF_INIT;
+	size_t count;
+
+	format_packet(&buf, fmt, args);
+	count = write_in_full(fd, buf.buf, buf.len);
+	if (count == buf.len)
+		return 0;
+
+	if (!gently) {
+		if (errno == EPIPE) {
+			if (in_async())
+				async_exit(141);
+
+			signal(SIGPIPE, SIG_DFL);
+			raise(SIGPIPE);
+			/* Should never happen, but just in case... */
+			exit(141);
+		}
+		die_errno("packet write error");
+	}
+	error("packet write failed");
+	return -1;
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

