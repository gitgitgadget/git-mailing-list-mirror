Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9102E1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751651AbeAYX6u (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:58:50 -0500
Received: from mail-oi0-f74.google.com ([209.85.218.74]:52989 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbeAYX6t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:58:49 -0500
Received: by mail-oi0-f74.google.com with SMTP id r65so5361459oih.19
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=LbJMlIMyc6KlQKERjWKxRE4r4P4rOxFjjeHAPZ88US4=;
        b=q+kRSXE26gbH3ogrXhUGO0H0w87dSmH1hzUQAoLTF0G3cFhh1aNJ6Ma3mMMk+uyNqy
         Ya+MT/276GQmSeg++yww3nRYRnQWZH2j1UFwk3I1Q23RRbPvI5yDc/1d6V87bdsOdrXz
         VqoHRF8IHZEd+sOKjydC6JghTb4APwbXVq4bzhDO0j/UIp/XeQ1bBQG/SQhJY+tvM0w8
         OE1iPu9sYnD8sB7LsKhqnC0LzGE2yhNZaUGZ3T96x3lziOpt4xHQjkrePHvrcf/UdhCU
         v4KU8xieAL2BqPOt8p0gOWkDTwBe8lJME5M2nyJkMQ6bC1B5etVQLRobxJ3ncLBbMhV9
         npYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=LbJMlIMyc6KlQKERjWKxRE4r4P4rOxFjjeHAPZ88US4=;
        b=e0fBapsfzWAYbTNxRBrXmfZJ8vDfEqtBBME217j43lZzYKmvOTk2zCvRlR1TRgZSVD
         Vmgz31ThcRMtkcCwf4frkbkDs4l86pAv5wCNEExbayLwuFoWUVHLi6ZZ6qFNpLcfLrAG
         JxsTEpcZq2VVyQZiX8aNVrHUm5mkBduN0mPlCYZRSaMwYlcYlk6Rpfx0Hvg1D36Pb5xS
         9dzvbKSAnQkQW5fQzxsN8ZAIiGTVXjAW2X4XkqTyhVNz0Zi6BFsDadr4qihR2NOZQwb+
         dNYVgWalSb9kSS4NAfvD8XM6/nLX8PpMJZ03wuggz82Xy+MzgGibOP0E9fKhRDGBDCGy
         iGpQ==
X-Gm-Message-State: AKwxytdOVGAVKcw2FFuY0AegllvU8qsz3BNHLn4Y221EWncnU1eO/Ci6
        YDY4dhkn0rhyKQiqQVKlEzx/dGhdd2lmR4YfG0jsl/Dg9ZQP17shmmIcJ76D7/NV0g2bbZ/zn7Y
        DkwSeVSLHWKUkD9GV4FNCtMbUabN9aTRI4I6O8BXnH1CZBiAixSKioNB4cw==
X-Google-Smtp-Source: AH8x227vcMzErqUFDFbcFc/bkdkKf5UjvV60alnJiRZcwqYlEVrxoFi5BLymW5HUbE78eQVJVrvhO1CNHmo=
MIME-Version: 1.0
X-Received: by 10.157.26.104 with SMTP id u37mr10466946otu.36.1516924728270;
 Thu, 25 Jan 2018 15:58:48 -0800 (PST)
Date:   Thu, 25 Jan 2018 15:58:13 -0800
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Message-Id: <20180125235838.138135-3-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v2 02/27] pkt-line: introduce struct packet_reader
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
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

