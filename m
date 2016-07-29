Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFFE81F855
	for <e@80x24.org>; Fri, 29 Jul 2016 23:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447AbcG2XiN (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 19:38:13 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34455 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbcG2XiI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 19:38:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so17717322wma.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 16:38:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R1M+5soDJgioLJdeGWGdHLGk78oJ9+x/ZEMrAwtjCGg=;
        b=rC40xbHsO5qEziOy1tmnGwFqenJ35jeCEtNBXo5bmhaHqLVNqqdsEKNV4pEq31xJrQ
         piS3+bmhVsVn24ZRm1/4tm59424NKak2O8NnzxUbTrIfzXEaFXhEfOQRf2Fz4wR4coLl
         bHbgTWs8Oq6/yRx6v16/1XmxBdwVMKcM4xgAb5VJTo6xzChJz552Hlmx/TUELENl4KGo
         L4eine+WrPf7Sil1m+t7YIYfVo8jdmoaK5x5l0dt9WV8cG1T+1rG06YICT09tOrvQiXO
         +oReIZ6FpWlSjagdla631jMDwNG/IwsC6KGWE0adum2UJdhi9lcYFsHRtYbis2t5q8m7
         K/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R1M+5soDJgioLJdeGWGdHLGk78oJ9+x/ZEMrAwtjCGg=;
        b=mIVqkr3e32RAn68NJrwXFUuwM0bzf5JnVEFtVedNO0agOBoJpA6gWMAdoJT5nJyaeF
         V+GvY71b+hl6FSjhi7VAOlAUXdvrMYdM8UMij/4EWFuih0FnI7NqZ89pjwyU54LR93s6
         pAp8okjdbcNxBt+GNmBYP9lZFe3AZmlmPRAK/nUf146S7YaT7dCeLuJiXNBsVoEmnd+0
         fBNXI6YDyoTB3UgA4JAPt/hNUTzSb4tgtAUDNpp0u5TYsTF/qfPbc7p8sE+6Y/vY2xQs
         ZYT2KERxvGJHaoyJF4a9hgXXIORqtvFt/Yczqr79SmsLx7ga4PygAUexGcKY1/SOLKvC
         /sGg==
X-Gm-Message-State: AEkoouthGaX1eaMHMWzlGVmFRrjjuLKTQbnjUmQRT/x7Q/PmE8nPMiTJWG6bgT9iG253/w==
X-Received: by 10.28.158.142 with SMTP id h136mr46549673wme.10.1469835486917;
        Fri, 29 Jul 2016 16:38:06 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB4145.dip0.t-ipconnect.de. [93.219.65.69])
        by smtp.gmail.com with ESMTPSA id i1sm18663212wjl.9.2016.07.29.16.38.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 16:38:06 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v3 02/10] pkt-line: add direct_packet_write() and direct_packet_write_data()
Date:	Sat, 30 Jul 2016 01:37:53 +0200
Message-Id: <20160729233801.82844-3-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160729233801.82844-1-larsxschneider@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Sometimes pkt-line data is already available in a buffer and it would
be a waste of resources to write the packet using packet_write() which
would copy the existing buffer into a strbuf before writing it.

If the caller has control over the buffer creation then the
PKTLINE_DATA_START macro can be used to skip the header and write
directly into the data section of a pkt-line (PKTLINE_DATA_LEN bytes
would be the maximum). direct_packet_write() would take this buffer,
adjust the pkt-line header and write it.

If the caller has no control over the buffer creation then
direct_packet_write_data() can be used. This function creates a pkt-line
header. Afterwards the header and the data buffer are written using two
consecutive write calls.

Both functions have a gentle parameter that indicates if Git should die
in case of a write error (gentle set to 0) or return with a error (gentle
set to 1).

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 pkt-line.c | 30 ++++++++++++++++++++++++++++++
 pkt-line.h |  5 +++++
 2 files changed, 35 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 445b8e1..6fae508 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -135,6 +135,36 @@ void packet_write(int fd, const char *fmt, ...)
 	write_or_die(fd, buf.buf, buf.len);
 }
 
+int direct_packet_write(int fd, char *buf, size_t size, int gentle)
+{
+	int ret = 0;
+	packet_trace(buf + 4, size - 4, 1);
+	set_packet_header(buf, size);
+	if (gentle)
+		ret = !write_or_whine_pipe(fd, buf, size, "pkt-line");
+	else
+		write_or_die(fd, buf, size);
+	return ret;
+}
+
+int direct_packet_write_data(int fd, const char *buf, size_t size, int gentle)
+{
+	int ret = 0;
+	char hdr[4];
+	set_packet_header(hdr, sizeof(hdr) + size);
+	packet_trace(buf, size, 1);
+	if (gentle) {
+		ret = (
+			!write_or_whine_pipe(fd, hdr, sizeof(hdr), "pkt-line header") ||
+			!write_or_whine_pipe(fd, buf, size, "pkt-line data")
+		);
+	} else {
+		write_or_die(fd, hdr, sizeof(hdr));
+		write_or_die(fd, buf, size);
+	}
+	return ret;
+}
+
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 {
 	va_list args;
diff --git a/pkt-line.h b/pkt-line.h
index 3cb9d91..02dcced 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -23,6 +23,8 @@ void packet_flush(int fd);
 void packet_write(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+int direct_packet_write(int fd, char *buf, size_t size, int gentle);
+int direct_packet_write_data(int fd, const char *buf, size_t size, int gentle);
 
 /*
  * Read a packetized line into the buffer, which must be at least size bytes
@@ -77,6 +79,9 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
 
 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
+#define PKTLINE_HEADER_LEN 4
+#define PKTLINE_DATA_START(pkt) ((pkt) + PKTLINE_HEADER_LEN)
+#define PKTLINE_DATA_LEN (LARGE_PACKET_MAX - PKTLINE_HEADER_LEN)
 extern char packet_buffer[LARGE_PACKET_MAX];
 
 #endif
-- 
2.9.0

