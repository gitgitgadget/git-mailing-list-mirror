Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E2A61F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751158AbeACASo (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:18:44 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:36206 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751134AbeACASm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:18:42 -0500
Received: by mail-io0-f194.google.com with SMTP id i143so472096ioa.3
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9SU7gk/YT/8fVWO3lYQoHK5il+vWJjbJeSjbtHRz/hQ=;
        b=Y0CYZFzUdj5120C/I357theR3dy6GkLtmhrmrJFiUNzQGZ6TM+MQgXfFBXVqEg43ao
         5o1QLVS9jDZjHGveXwUHa2YWiHFD56zfUZr2jC3NB+2RlW3y5TExQcIuJTiDNQHlN7nA
         8fRsgYzRydVo7l9p6LopDLQKdKzML77ugsIPYiYlCnYg3WCptMRWIaXCTyOJEPG+gLoJ
         m93uwas/gPLyXp7a2T4OFCzOhBBj+sNoiFRUzT82I/6lz5LcHQHd8pof0y45+uEfumgs
         3OWd5RGGGJ7Fx/+WPHm+/P/NF4SrTGL28wMnj84W1kjv2CLgDgJbmQ4ArKGEu4lQN8nA
         KtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9SU7gk/YT/8fVWO3lYQoHK5il+vWJjbJeSjbtHRz/hQ=;
        b=dfJSzTrSObFIZVb3kqmgUAdGGia9fRhTHLoCy0xCii/ZKH9cT1k1sw/0iX05FE6/dz
         TDnQoJdpRPW/gZx2U0T1p3NUz4vCSPfQllmfErhp/D1IsmKCKeq0l+WTWrjvN6cUTcj1
         u3FoYQXc0pS1XgOp42CbZiEoPY+J+LSAPjQFX3hXzJ4dwU5j+OKoCuk+33hpPHeSjSME
         LO9sQVWhLFx6jp/sAMeX4cf/LUGV30lLYX2orRMWwRMEc5SP0OUbyESLc2GjqmqTAB22
         RxqYvbKbsw0K1IW2/E8qEBBvD1z1PA/QPGosLbonOMaqCfW35dzFHFBqT9+Utmz48CGl
         4Vkw==
X-Gm-Message-State: AKGB3mKGPwxEQ7kzQN1sE7TD7TjK6nmWAmEgUWgUSo6R2OVpS917HuEm
        ejGEGntgKekRKpHPfRFNn++i4Dya8H0=
X-Google-Smtp-Source: ACJfBovjwyc7EVSWygytJMi2VFie+/cyp6chb4FQQurUCMdkpb57JbmgN5Pow4DrerUPHD1PbNoyDA==
X-Received: by 10.107.169.194 with SMTP id f63mr27670208ioj.190.1514938721677;
        Tue, 02 Jan 2018 16:18:41 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:18:40 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 01/26] pkt-line: introduce packet_read_with_status
Date:   Tue,  2 Jan 2018 16:18:03 -0800
Message-Id: <20180103001828.205012-2-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
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
 pkt-line.c | 55 ++++++++++++++++++++++++++++++++++++++++++-------------
 pkt-line.h | 15 +++++++++++++++
 2 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 2827ca772..8d7cd389f 100644
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
 	if (len < 0)
 		die("protocol error: bad line length character: %.4s", linelen);
-	if (!len) {
+
+	if (len == 0) {
 		packet_trace("0000", 4, 0);
-		return 0;
+		return PACKET_READ_FLUSH;
+	} else if (len >= 1 && len <= 3) {
+		die("protocol error: bad line length character: %.4s", linelen);
 	}
+
 	len -= 4;
-	if (len >= size)
+	if ((len < 0) || ((unsigned)len >= size))
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
2.15.1.620.gb9897f4670-goog

