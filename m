Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3196B1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964934AbeB1XXV (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:23:21 -0500
Received: from mail-yw0-f202.google.com ([209.85.161.202]:52638 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964912AbeB1XXT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:23:19 -0500
Received: by mail-yw0-f202.google.com with SMTP id y196so2365967ywg.19
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=IlSos3BgVMlHlmcsi5j3RGjeBreIKMl5Xh6LJ2E36Bo=;
        b=JhuM8joaU+rjeVuNg2UG4DsmTfbMxHKjZcMczvCtCeotZLwEXx4zRkDp2lKJE0ZqWb
         EZeB8f16RohMsehYS88dCJ+47LuHdEztqh14pQLGbTe9ZyT2Ml1WWwlUqebU4dTdVzTK
         xzNW6TaGdhOBhWEdAp0B/raz+bjr4/YXrXUDPJ1EYRfpbColPRih4uReIppEGtGYJUk9
         7jMSkQ8yzHkK5QYHKEsfNBIGhw55vA9DHhQwngbG9hk6AHnanOYP3hxGSvTJTJ8cMZt7
         gv4RqEvOpYa592pQ+2wEo4VKUWaMMkuJGrc6jCi2IQ8+1BTPzgU0TvWBJcjwZJHmG3+t
         3g7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=IlSos3BgVMlHlmcsi5j3RGjeBreIKMl5Xh6LJ2E36Bo=;
        b=r8Au3pez7SLxEaB/nEMbimmSgAHljLcchMhE+RHpGFTjjXMNaPzkoWpbOoiMTQ6WSO
         Ujg1kzf7kcUS0YElu5ndQuSUe+vlxY/n6+mNCvq+7K0XNFMEhcVlixvp/89Vxa2X/Et+
         sCCUEPFckK9Kj0egyxVNIsqHeqR/3D24C3Sc9ZNSS3y/hXke4FLlyU1M2POYIvkAPwJ0
         isJfiSOGnO3P5rpXaeO0c5x+6g4CpQocwM3VmVyiLtoAsxBIdYWTN5T+OEAOyFdIQPNl
         6SIpvjND/HRDBOgQZDJlnmQgtlexiG2RynceEYrrgrAj96yTZHL81IZ8UCTA8Y71Ecbd
         6jjg==
X-Gm-Message-State: APf1xPC5MyfEcAZJOdwKsVmxq7LKV85w4sz7sD4pPEOG9NQ756bVyRzT
        I836ASYvaWcXWzMNa02GFrrJd3JU+4iLrwY6iMcgSDryAAt2EGIHnkvpxhrK0Kgjmat6b0ig7WG
        VoiJIHyBsrjlZ9Z3S+wUE9tff5ECvm4h4PxMnkDXaSetFV3enxvwj/HFA1g==
X-Google-Smtp-Source: AG47ELvc6aD5bx+QnIhSKXAiIOr5GVK6ZpQ6k6HeHwOF/T9pcf7hvdE9KldljDsq8sxdmTLuv1tTFfGUgnQ=
MIME-Version: 1.0
X-Received: by 2002:a25:cb0c:: with SMTP id b12-v6mr6614111ybg.76.1519860198204;
 Wed, 28 Feb 2018 15:23:18 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:18 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-2-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 01/35] pkt-line: introduce packet_read_with_status
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
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
 pkt-line.c | 55 ++++++++++++++++++++++++++++++++++++++++--------------
 pkt-line.h | 16 ++++++++++++++++
 2 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 2827ca772..08e5ba44c 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -280,28 +280,34 @@ static int packet_length(const char *linelen)
 	return (val < 0) ? val : (val << 8) | hex2chr(linelen + 2);
 }
 
-int packet_read(int fd, char **src_buf, size_t *src_len,
-		char *buffer, unsigned size, int options)
+enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
+						size_t *src_len, char *buffer,
+						unsigned size, int *pktlen,
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
@@ -309,7 +315,28 @@ int packet_read(int fd, char **src_buf, size_t *src_len,
 
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
+	int pktlen;
+
+	switch (packet_read_with_status(fd, src_buffer, src_len, buffer, size,
+					&pktlen, options)) {
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
index 3dad583e2..0be691116 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -65,6 +65,22 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
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
+enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
+						size_t *src_len, char *buffer,
+						unsigned size, int *pktlen,
+						int options);
+
 /*
  * Convenience wrapper for packet_read that is not gentle, and sets the
  * CHOMP_NEWLINE option. The return value is NULL for a flush packet,
-- 
2.16.2.395.g2e18187dfd-goog

