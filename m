Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCEB71F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754237AbeBGBNV (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:13:21 -0500
Received: from mail-io0-f202.google.com ([209.85.223.202]:38070 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754223AbeBGBNU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:13:20 -0500
Received: by mail-io0-f202.google.com with SMTP id q195so3796382ioe.5
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=06Wipua2WVbPDvUwJxMdSPHMVxrFJ2uhUZ/D/F5AwLw=;
        b=BouItmfA1r5rXvyrEdJvOMS7CSTHoeG2rYPMyU0XXLM1jd1sMOkIOrAehv1Lo4PE5X
         iURLM0NVDGUFplE3fLVXpoG1PverSgpQe8J9zsMwUaCd1YYR/iRV4/fY4TMzIHtQMkbx
         hAbHLQ6APrUVZ8OHwrPppi6/7ifNPlvzkDDmGm9SaM0EQGCQ8TccQELBrzAtOs7P/fIf
         r7IQAqsAfiWYs9jtAurN4/NCpw7lD/QIf9lq7v2moqrmKDNoOSCaXMdUC1b/58o3jnrx
         wzDvcLPbxoKeP8StvERSw3sAVm8EdLv/GYCfDKqK1XjJBxionzilujqohe3n/YjfTDbD
         1zaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=06Wipua2WVbPDvUwJxMdSPHMVxrFJ2uhUZ/D/F5AwLw=;
        b=lBy2YgQw+VHPgXtGYk+9/u1/HMFCXQ0LOH+I9bcFOpceAWzGS+/G0X9XIome0IQNfI
         EMXIUJEvzlRHh2l+diAwfi1F04T4WSojP41B1pFSj4EFhPB4e8p3ynXy1J1GNtTFqMAt
         QtBAXEzYuD+4jowhlZZOrD0pRxcchtF0HfC9VsQZE88GqMq+Td7C7cAxyepbDYOPKKMa
         MGtL6vXpx76STtxSw08EtwGqKj+3g073CXGMYWz7EENLSC//akVe5g/HUnzOeZNz70az
         oaGu/agTAqXYu2l+WvgAyRdRenInH0nJVJYFGDlfIq38AtScWqc8DDl/sl0kUXHC2dLt
         Ub3A==
X-Gm-Message-State: APf1xPC/xZKgXzySCUYU4cLrfq6ZgQn2CJ95Bd/Cg9PTm4cMNOMOeZgc
        sZTHDdrE2JnNeqKUEjDjWnDX0TcIYVXZO5yfA/EGt3bYVVk6b1i7r/ccUT50mgc6fqJ1KM2PNYE
        C/GEK2L8ONGGBuGJ0nlkwI1hcZRKmjRBLn9UBj4Nm9QYX5ib3s13pv7Fp8A==
X-Google-Smtp-Source: AH8x227nnfZsM4sx+pKRkGeoAEG1yo2+Lx/IMrfCzCocfW1VuzeBUG0nXNJaRWMJBmSwi38Wb0xfSsujWYw=
MIME-Version: 1.0
X-Received: by 10.36.81.17 with SMTP id s17mr118230ita.28.1517965999429; Tue,
 06 Feb 2018 17:13:19 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:12:38 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-2-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 01/35] pkt-line: introduce packet_read_with_status
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current pkt-line API encodes the status of a pkt-line read in the
length of the read content.  An error is indicated with '-1', a flush
with '0' (which can be confusing since a return value of '0' can also
indicate an empty pkt-line), and a positive integer for the length of
the read content otherwise.  This doesn't leave much room for allowing
the addition of additional special packets in the future.

To solve this introduce 'packet_read_with_status()' which reads a packet
and returns the status of the read encoded as an 'enum packet_status'
type.  This allows for easily identifying between special and normal
packets as well as errors.  It also enables easily adding a new special
packet in the future.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pkt-line.c | 57 +++++++++++++++++++++++++++++++++++++++++++--------------
 pkt-line.h | 15 +++++++++++++++
 2 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 2827ca772..af0d2430f 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -280,28 +280,33 @@ static int packet_length(const char *linelen)
 	return (val < 0) ? val : (val << 8) | hex2chr(linelen + 2);
 }
 
-int packet_read(int fd, char **src_buf, size_t *src_len,
-		char *buffer, unsigned size, int options)
+enum packet_read_status packet_read_with_status(int fd, char **src_buffer, size_t *src_len,
+						char *buffer, unsigned size, int *pktlen,
+						int options)
 {
-	int len, ret;
+	int len;
 	char linelen[4];
 
-	ret = get_packet_data(fd, src_buf, src_len, linelen, 4, options);
-	if (ret < 0)
-		return ret;
+	if (get_packet_data(fd, src_buffer, src_len, linelen, 4, options) < 0)
+		return PACKET_READ_EOF;
+
 	len = packet_length(linelen);
-	if (len < 0)
+
+	if (len < 0) {
 		die("protocol error: bad line length character: %.4s", linelen);
-	if (!len) {
+	} else if (!len) {
 		packet_trace("0000", 4, 0);
-		return 0;
+		return PACKET_READ_FLUSH;
+	} else if (len < 4) {
+		die("protocol error: bad line length %d", len);
 	}
+
 	len -= 4;
-	if (len >= size)
+	if ((unsigned)len >= size)
 		die("protocol error: bad line length %d", len);
-	ret = get_packet_data(fd, src_buf, src_len, buffer, len, options);
-	if (ret < 0)
-		return ret;
+
+	if (get_packet_data(fd, src_buffer, src_len, buffer, len, options) < 0)
+		return PACKET_READ_EOF;
 
 	if ((options & PACKET_READ_CHOMP_NEWLINE) &&
 	    len && buffer[len-1] == '\n')
@@ -309,7 +314,31 @@ int packet_read(int fd, char **src_buf, size_t *src_len,
 
 	buffer[len] = 0;
 	packet_trace(buffer, len, 0);
-	return len;
+	*pktlen = len;
+	return PACKET_READ_NORMAL;
+}
+
+int packet_read(int fd, char **src_buffer, size_t *src_len,
+		char *buffer, unsigned size, int options)
+{
+	enum packet_read_status status;
+	int pktlen;
+
+	status = packet_read_with_status(fd, src_buffer, src_len,
+					 buffer, size, &pktlen,
+					 options);
+	switch (status) {
+	case PACKET_READ_EOF:
+		pktlen = -1;
+		break;
+	case PACKET_READ_NORMAL:
+		break;
+	case PACKET_READ_FLUSH:
+		pktlen = 0;
+		break;
+	}
+
+	return pktlen;
 }
 
 static char *packet_read_line_generic(int fd,
diff --git a/pkt-line.h b/pkt-line.h
index 3dad583e2..06c468927 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -65,6 +65,21 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
 int packet_read(int fd, char **src_buffer, size_t *src_len, char
 		*buffer, unsigned size, int options);
 
+/*
+ * Read a packetized line into a buffer like the 'packet_read()' function but
+ * returns an 'enum packet_read_status' which indicates the status of the read.
+ * The number of bytes read will be assigined to *pktlen if the status of the
+ * read was 'PACKET_READ_NORMAL'.
+ */
+enum packet_read_status {
+	PACKET_READ_EOF = -1,
+	PACKET_READ_NORMAL,
+	PACKET_READ_FLUSH,
+};
+enum packet_read_status packet_read_with_status(int fd, char **src_buffer, size_t *src_len,
+						char *buffer, unsigned size, int *pktlen,
+						int options);
+
 /*
  * Convenience wrapper for packet_read that is not gentle, and sets the
  * CHOMP_NEWLINE option. The return value is NULL for a flush packet,
-- 
2.16.0.rc1.238.g530d649a79-goog

