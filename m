Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD6721F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 16:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758048AbcHCQnH (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:43:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35018 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756955AbcHCQnD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:43:03 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so37207171wmg.2
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 09:42:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zd4B02wvvuGPPvqsTKdr+VeNMccwmywHlpn3pDXcpwk=;
        b=T+wQYuZAJ+yV5Bd56qMmcizlWL3ZKhlG4lgkf7yf6gUho0rgmqXyAXj41bHbWv8ltu
         jk8zJdbNEnl64ZUblSwbWOHIKHEGGoQuNCmRgHTyx/6vYWWHiWS4FAgFv1hIV8iLKes6
         cKjwShbymPEOui2MtIWjmYn4ySr8/L17XpyLJIQd7KMJ+hOYU1+d8qE7p0Si1QModiKK
         n3zFvLbC8otxyq3UcSdZ893TpntgrWy4V+PFuvIdU2xO+0p3ZcYyUJzMpgE5zADD3eIy
         i7DrP3Zd4fDJsWxo4JO+eWCqYs1PsRgyq9FrADBXapwPrPJQbjzn27EHHyrKMU3CaSVO
         pGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zd4B02wvvuGPPvqsTKdr+VeNMccwmywHlpn3pDXcpwk=;
        b=FDwsB1U4BrbocuBUv6h2VW04/mvV9J/j9IsgYV9VScjS1fAhpIfTu9Q2OdowElyKYF
         SY6dP4N6ofsOctAJ+g0VIWjDV8G4EvtZXAat4jZ9LWUCiRk3ewTSXpfjlouckmPJfhBp
         fwCL+n1j+TrKyI9rW3SMygT6lcYX5ypYApcdszShD0IcoygzbgeRDcE2eaEa0Uixnuah
         1AZbZvge1iTEXs4m146hfvpeT+Ti5YNPoo5NCtATFdp9AYxiUvXCa3vAcADna3ZtDGK/
         hNxpfxF/ZmtiG3tHMKp35jVBdBNmEYgqNkrAngUMaGVrFsLy5eyIdBo4jIuFvmaLKQMo
         OO0w==
X-Gm-Message-State: AEkooutSSdUh14baev9CFc4ynkdAYvlJ+f6gSDyvy8/34xFpVv3Czo/8qysW05pftMTcmw==
X-Received: by 10.194.27.202 with SMTP id v10mr69007377wjg.140.1470242549765;
        Wed, 03 Aug 2016 09:42:29 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 3sm8959736wms.1.2016.08.03.09.42.28
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 09:42:29 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v4 02/12] pkt-line: add direct_packet_write() and direct_packet_write_data()
Date:	Wed,  3 Aug 2016 18:42:15 +0200
Message-Id: <20160803164225.46355-3-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160803164225.46355-1-larsxschneider@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
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
 pkt-line.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 pkt-line.h |  5 +++++
 2 files changed, 47 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 177dc73..aa158ba 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -136,6 +136,48 @@ void packet_write(int fd, const char *fmt, ...)
 	write_or_die(fd, buf.buf, buf.len);
 }
 
+int direct_packet_write(int fd, char *buf, size_t size, int gentle)
+{
+	int ret = 0;
+	if (size > LARGE_PACKET_MAX) {
+		if (gentle)
+			return 0;
+		else
+			die("protocol error: impossibly long line");
+	}
+	packet_trace(buf + 4, size - 4, 1);
+	set_packet_header(buf, size);
+	if (gentle)
+		ret = !write_or_whine_pipe(fd, buf, size, "pkt-line");
+	else
+		write_or_die(fd, buf, size);
+	return ret;
+}
+
+int direct_packet_write_data(int fd, const char *data, size_t size, int gentle)
+{
+	int ret = 0;
+	char hdr[PKTLINE_HEADER_LEN];
+	if (size > PKTLINE_DATA_MAXLEN) {
+		if (gentle)
+			return 0;
+		else
+			die("protocol error: impossibly long line");
+	}
+	set_packet_header(hdr, PKTLINE_HEADER_LEN + size);
+	packet_trace(data, size, 1);
+	if (gentle) {
+		ret = (
+			!write_or_whine_pipe(fd, hdr, PKTLINE_HEADER_LEN, "pkt-line header") ||
+			!write_or_whine_pipe(fd, data, size, "pkt-line data")
+		);
+	} else {
+		write_or_die(fd, hdr, PKTLINE_HEADER_LEN);
+		write_or_die(fd, data, size);
+	}
+	return ret;
+}
+
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 {
 	va_list args;
diff --git a/pkt-line.h b/pkt-line.h
index 3cb9d91..ed64511 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -23,6 +23,8 @@ void packet_flush(int fd);
 void packet_write(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+int direct_packet_write(int fd, char *buf, size_t size, int gentle);
+int direct_packet_write_data(int fd, const char *data, size_t size, int gentle);
 
 /*
  * Read a packetized line into the buffer, which must be at least size bytes
@@ -77,6 +79,9 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
 
 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
+#define PKTLINE_HEADER_LEN 4
+#define PKTLINE_DATA_START(pkt) ((pkt) + PKTLINE_HEADER_LEN)
+#define PKTLINE_DATA_MAXLEN (LARGE_PACKET_MAX - PKTLINE_HEADER_LEN)
 extern char packet_buffer[LARGE_PACKET_MAX];
 
 #endif
-- 
2.9.0

