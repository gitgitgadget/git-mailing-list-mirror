Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1BAF1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964973AbeB1XXZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:23:25 -0500
Received: from mail-yb0-f201.google.com ([209.85.213.201]:45502 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964912AbeB1XXW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:23:22 -0500
Received: by mail-yb0-f201.google.com with SMTP id w1-v6so2360155ybm.12
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=MIi1D2KxnKV9r62Zkjt8ZnXC7zwWIwQmDbKixAbYflQ=;
        b=tlnCh14f1JhIWGGIH0MeGmxd7H+h3VSt/IlU9HtsNrSWG+VxziOVVAQ+DMDE1bcboV
         r6lvM0TmkzR8INoC+gwy0GGRjUGTmb2GYLtmHYpWTUkFZEKGyjT7wvW1RZq2cHpFhQ/d
         J7Rc3dNSn8UOHRe9UBGVvY4iaQKtMNs9WDcamtBZq1SHA5gtZ9W7adoOlY2zc9Om8Cbh
         evJ4wQGKXQq6OTYoXLpvJXs+B9Cbohvw7rUWEIY5165UkwjIANFlzuow3eK3++eXajia
         dS38BilRKQOEBOSzpopfyb0ZYBq45yKYaATQVYNX1CcsvzKeaabofqqvYNcL2w/abh/X
         hB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=MIi1D2KxnKV9r62Zkjt8ZnXC7zwWIwQmDbKixAbYflQ=;
        b=MhqswU/TDFqHoZ0Nj/AWshXxZdSWQqgi3qTfRB6eiRnA4IyHdyI3aNrXyqZ5J8wxg6
         xQEGGf+x7lw4qiXDkLskbK9G/M57LfOMtIvUn9ZWMmOBepSFd1bYX3l1JLtp5B6CIsnz
         d3ejLstgQeFkCZYQs2RSawaurAk/jV8xp+r0IrpJGjBfYeoKczQHRnPyc5lPqbjl1TCZ
         e6roQzJ0F0SAcFFvmfdMM6fp6Xhdm9Dmhad/+9naAPaH8N5IvT8iL6mdKhukBdtOTYYd
         rrIgSd5ewYtJtN+yONAK96NCu7Ht0Np+xDRS8f3mw+oLJYEZTPj3ESLLiYD/6SMhqLUN
         s0Kg==
X-Gm-Message-State: APf1xPB7gyBxMtSGaQUbQooJTUi9WNGWMizE77REtXjU1sucfpnW4jEp
        qokdXDX750AeSdlnGwhGbhXMKTCWE37PiUD97G4S5qNcGGapsRooomWO4UERsLLaQ+TX2jowm5Q
        oI0tzlhkoOFvqB3SlVZkbOiglvvyoGrFZ07s8osMrLwmJb5BsPFRLrDrf/g==
X-Google-Smtp-Source: AH8x225nTBnKx9MQ1ZE6p2aEDIVLoMdd3QV9w41weLnZHkzW9bENp8w3QGBl2hcCNIs+kJ6SI3ilGB/meRs=
MIME-Version: 1.0
X-Received: by 10.13.247.133 with SMTP id h127mr10060923ywf.113.1519860201014;
 Wed, 28 Feb 2018 15:23:21 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:19 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-3-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 02/35] pkt-line: allow peeking a packet line without
 consuming it
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

Sometimes it is advantageous to be able to peek the next packet line
without consuming it (e.g. to be able to determine the protocol version
a server is speaking).  In order to do that introduce 'struct
packet_reader' which is an abstraction around the normal packet reading
logic.  This enables a caller to be able to peek a single line at a time
using 'packet_reader_peek()' and having a caller consume a line by
calling 'packet_reader_read()'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pkt-line.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 pkt-line.h | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 08e5ba44c..6307fa4a3 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -404,3 +404,62 @@ ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
 	}
 	return sb_out->len - orig_len;
 }
+
+/* Packet Reader Functions */
+void packet_reader_init(struct packet_reader *reader, int fd,
+			char *src_buffer, size_t src_len,
+			int options)
+{
+	memset(reader, 0, sizeof(*reader));
+
+	reader->fd = fd;
+	reader->src_buffer = src_buffer;
+	reader->src_len = src_len;
+	reader->buffer = packet_buffer;
+	reader->buffer_size = sizeof(packet_buffer);
+	reader->options = options;
+}
+
+enum packet_read_status packet_reader_read(struct packet_reader *reader)
+{
+	if (reader->line_peeked) {
+		reader->line_peeked = 0;
+		return reader->status;
+	}
+
+	reader->status = packet_read_with_status(reader->fd,
+						 &reader->src_buffer,
+						 &reader->src_len,
+						 reader->buffer,
+						 reader->buffer_size,
+						 &reader->pktlen,
+						 reader->options);
+
+	switch (reader->status) {
+	case PACKET_READ_EOF:
+		reader->pktlen = -1;
+		reader->line = NULL;
+		break;
+	case PACKET_READ_NORMAL:
+		reader->line = reader->buffer;
+		break;
+	case PACKET_READ_FLUSH:
+		reader->pktlen = 0;
+		reader->line = NULL;
+		break;
+	}
+
+	return reader->status;
+}
+
+enum packet_read_status packet_reader_peek(struct packet_reader *reader)
+{
+	/* Only allow peeking a single line */
+	if (reader->line_peeked)
+		return reader->status;
+
+	/* Peek a line by reading it and setting peeked flag */
+	packet_reader_read(reader);
+	reader->line_peeked = 1;
+	return reader->status;
+}
diff --git a/pkt-line.h b/pkt-line.h
index 0be691116..f2edfae9a 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -112,6 +112,64 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
  */
 ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out);
 
+struct packet_reader {
+	/* source file descriptor */
+	int fd;
+
+	/* source buffer and its size */
+	char *src_buffer;
+	size_t src_len;
+
+	/* buffer that pkt-lines are read into and its size */
+	char *buffer;
+	unsigned buffer_size;
+
+	/* options to be used during reads */
+	int options;
+
+	/* status of the last read */
+	enum packet_read_status status;
+
+	/* length of data read during the last read */
+	int pktlen;
+
+	/* the last line read */
+	const char *line;
+
+	/* indicates if a line has been peeked */
+	int line_peeked;
+};
+
+/*
+ * Initialize a 'struct packet_reader' object which is an
+ * abstraction around the 'packet_read_with_status()' function.
+ */
+extern void packet_reader_init(struct packet_reader *reader, int fd,
+			       char *src_buffer, size_t src_len,
+			       int options);
+
+/*
+ * Perform a packet read and return the status of the read.
+ * The values of 'pktlen' and 'line' are updated based on the status of the
+ * read as follows:
+ *
+ * PACKET_READ_ERROR: 'pktlen' is set to '-1' and 'line' is set to NULL
+ * PACKET_READ_NORMAL: 'pktlen' is set to the number of bytes read
+ *		       'line' is set to point at the read line
+ * PACKET_READ_FLUSH: 'pktlen' is set to '0' and 'line' is set to NULL
+ */
+extern enum packet_read_status packet_reader_read(struct packet_reader *reader);
+
+/*
+ * Peek the next packet line without consuming it and return the status.
+ * The next call to 'packet_reader_read()' will perform a read of the same line
+ * that was peeked, consuming the line.
+ *
+ * Peeking multiple times without calling 'packet_reader_read()' will return
+ * the same result.
+ */
+extern enum packet_read_status packet_reader_peek(struct packet_reader *reader);
+
 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
 #define LARGE_PACKET_DATA_MAX (LARGE_PACKET_MAX - 4)
-- 
2.16.2.395.g2e18187dfd-goog

