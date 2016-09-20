Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23B4B209A9
	for <e@80x24.org>; Tue, 20 Sep 2016 19:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932941AbcITTDE (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 15:03:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34693 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932558AbcITTC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 15:02:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id l132so4895388wmf.1
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 12:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X5qj1NsmsMS24A78sxe9oUuNeNOuHB4+aatYGtcaXTA=;
        b=RFkm4Lmc1GIv9oEDQT1S/CwnP7F19h/eZaNkMT1utnrlJASP1uL1qkC+OUe2Gf2WEN
         HlEA0C1fvHi1aMrxkXHcI7FcV6EVH9B5Aqz23PqhKlTFk8BVF839zT8GZuPeFr1jOTnv
         USesJKhTHEceAeRgSAq2KxZmeZnXUvA56Kioi+GxV6SpNDr6mDe5bgsToIxnwTrTfRqT
         N2IZm7YjLSf8NRLrVx6ny7YfMnlx4alfoN4ji9hEyPPy4awO00zc6VNLdgP5/wOeV4Zk
         HjSKp032dKsIT/3URpmTea6OQdKSdfIlHShlW3DT1IqMqy7rb8BMddYLCrC61LadZrNh
         p3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X5qj1NsmsMS24A78sxe9oUuNeNOuHB4+aatYGtcaXTA=;
        b=XGBPYu4I/MYyrdgYOifsxUcW+zV2fJoArMbLbSIEhNXH14BbPiwqwLKVOupBlwhYU8
         e/PuP5FFM37q/zcVsUh2bF9MpLhUotmTFDKDUgM3tnOyITKr2MmzurmnB4EKs/OGlVVs
         DJqTaYnQxfCyDvHBs+TO4dz0l8jUEl/srbuT80b6rsqy+o0Ov+Nt6AQ4pTxctCa222N2
         jE/XbKQ+faYok8mHjzzB4W760wCFO1y5x7SV8z/3Jw6J2pzc0qy2IBx/JuLFfFMvgfca
         5qXozDHb3G2S5R0+mkJxZHEG9nWt4o6vT60H7asErrdKkPpVSlheQQmSpU/49mw+fBth
         sI2g==
X-Gm-Message-State: AE9vXwOsPulPok/i3bTZlNQ+hSUgRoMuQfCPV5VxQTVVpQ/GikI20lR3jAv41qtSVOezsA==
X-Received: by 10.28.234.5 with SMTP id i5mr4450061wmh.128.1474398175358;
        Tue, 20 Sep 2016 12:02:55 -0700 (PDT)
Received: from slxBook4.fritz.box (p508BA5EF.dip0.t-ipconnect.de. [80.139.165.239])
        by smtp.gmail.com with ESMTPSA id gg10sm29820728wjd.4.2016.09.20.12.02.54
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 20 Sep 2016 12:02:54 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        jnareb@gmail.com, mlbright@gmail.com, tboegi@web.de,
        ramsay@ramsayjones.plus.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v8 04/11] pkt-line: add packet_write_fmt_gently()
Date:   Tue, 20 Sep 2016 21:02:40 +0200
Message-Id: <20160920190247.82189-5-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160920190247.82189-1-larsxschneider@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
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
---
 pkt-line.c | 34 ++++++++++++++++++++++++++++++----
 pkt-line.h |  1 +
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index e8adc0f..3b465fd 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -125,16 +125,42 @@ static void format_packet(struct strbuf *out, const char *fmt, va_list args)
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

