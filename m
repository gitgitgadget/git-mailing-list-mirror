Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E07791F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754260AbeBGBNY (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:13:24 -0500
Received: from mail-oi0-f74.google.com ([209.85.218.74]:44190 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754223AbeBGBNW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:13:22 -0500
Received: by mail-oi0-f74.google.com with SMTP id w135so1851725oie.11
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=LbJMlIMyc6KlQKERjWKxRE4r4P4rOxFjjeHAPZ88US4=;
        b=opZk3ES3Rz1ntBK9ufdio64rY8F6/TfHVRWbPbMY21vnuCBTXWCISzQoY3zx9PqkWX
         +Y5UNl1g/wJLLdse9cEKB6//QaQ5WhyyR4OceWx7rPCo9VQUKehK2rEu/vaRBg8U9ZdW
         xCutiWY3pi5b8+K/SXcllnjbLw9A+uBimbcPNgHrdXT7mz1ZlBHMf3UxULmB79XRPiCZ
         hlmuindMjvSilBY667dN+/7GqvJBc8vyJzZDqOO440fZ6mUVEJz54mXd114LZTpedB96
         72FGJsXgrsvkWCsT52O427q75y3TGqONHkjwACciiTLuPGaM90mT+1Ut9vP0579npqDi
         /JOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=LbJMlIMyc6KlQKERjWKxRE4r4P4rOxFjjeHAPZ88US4=;
        b=t+h4NOaPfqkiLUDg2R58faRD0qREWJqd1IZX93vkQcGI17W5/zc/f9fPAKWE1EfJRQ
         alx0Ro0024dPhfTX4ACl2cV0u6VR30gjbpPCNJE6PmM/BLbshPZdqXIieoKe2Wp1DKHe
         cqubpApFDqu2oBwAGJXb81GhdjVmhl7+LgtdqA8SVnksjy2tGNfo++EtviIFTu6SdYKL
         gF3LaT05HrHtoE1MUa7YhbRJvFR9pim408AUmdVrTyM2TV+tbYwt3Ory8dUhPE0OzV0O
         qM0Y6XwIloqfQ293znkHPYbh6fJj8HkYuXgAqW4kCudMMB8bo74OB3vLLRDl1WroXiGW
         iyIg==
X-Gm-Message-State: APf1xPDq1VR/OONrwL9iILJjXkExKFwkjSRxlGMfhUgEX7z6MnHO964Y
        okbF6KjLWxjp6deCTOcUovS5v5QjvcjuoOU5GsEAN7lEfncjKMc2RmUXv6ms1XHSp16ERUTohEF
        4bGoi0MS8nOQ0b0SAlJJF9R80KFOH+xqbeAObWwJ06q0aN0kBgINbDcqmGw==
X-Google-Smtp-Source: AH8x226Zsv1TZZdFT8LyhOyiws7AWoKD2B2wnlMy2ME543d7LSg38hN552nk6WA21Qh+0h8S/EQN5DlLfWw=
MIME-Version: 1.0
X-Received: by 10.157.19.36 with SMTP id f33mr2201716ote.36.1517966001660;
 Tue, 06 Feb 2018 17:13:21 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:12:39 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-3-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 02/35] pkt-line: introduce struct packet_reader
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

Sometimes it is advantageous to be able to peek the next packet line
without consuming it (e.g. to be able to determine the protocol version
a server is speaking).  In order to do that introduce 'struct
packet_reader' which is an abstraction around the normal packet reading
logic.  This enables a caller to be able to peek a single line at a time
using 'packet_reader_peek()' and having a caller consume a line by
calling 'packet_reader_read()'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pkt-line.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 pkt-line.h | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index af0d2430f..4fc9ad4b0 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -406,3 +406,62 @@ ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
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
index 06c468927..7d9f0e537 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -111,6 +111,64 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
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
2.16.0.rc1.238.g530d649a79-goog

