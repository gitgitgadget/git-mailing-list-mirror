Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB2411F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752360AbeCNScZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:32:25 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:53645 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbeCNScX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:32:23 -0400
Received: by mail-yw0-f201.google.com with SMTP id r202so4774405ywg.20
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Ha0YVWd4rnC2opHz27Xl6ysPEbZuVbDGh3Glh7Yy75Y=;
        b=rZSKjzTuye9n1wiaBRSMH3mHIXhh78RgJssErSmATHDkl66Tgqczh3+k8yX2UJTUhs
         qL9txzSiYaslYguqQYjj5p5437oIKhB5GGGulGXXm4svqVMHRQGJUg5RRsoj9LUbMj81
         sAi6OKy8TtJtuBONrb44629eNJiB5OnidQvzXvemU5MYR1l6xD0xpJ4YL9rNmg/vfjYt
         RRXjIWLJb1amokheAoTTM9U3sag6tKi8Y7ahvN8eNPB2VaY6xCETak/fpKp6sfVFCbVJ
         KrAIdg6lT6R7gr87wmA/wwPdyHbSpnVcW4KqIlG//yYXDEupqeyEojkuG2Ojb5YDCiXB
         uR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Ha0YVWd4rnC2opHz27Xl6ysPEbZuVbDGh3Glh7Yy75Y=;
        b=JHHhqtCp7r5spxBnr/NceRx+g+W3DZsS/WDpM+IgqQfvtH/8doj9KLsLv/WsQH1lzV
         F30xudUeq2sTOauNjoJySASyEmHn67rS4gyYGlRnhl9rDVERWpPlmCo34NaY6Qrt/rGe
         RTqyAoBkX3jyyEylgE0YmtAuoXJRMiNh/MuE9Qd6cRjcgBONGbJ2ahG4WaHtj5GUQTCq
         IUiw1sRY9xDAafGYfbRKvHXIC1ggXGIW1OOaQEA66uUlRgTTF4bDwd2Z6TNJOLgdaI4e
         CZhx9lC18l+6g8mW00q8COQN3qj1v22FFq3XRXCo6T+WV+QHBZQF9AGKeT7uylXXyCh1
         GkyA==
X-Gm-Message-State: AElRT7Fr/RfScJgtoqrB1RMhy77dDUf/Z0qnWtlcvHpj38rFIUtyy2+A
        8h5aJXhQ8TvSqYvIZIa6c1rS9PC7ThMZC1MM4uqbh04pzB+eniaXVfUDPjJ+a0L3qvBkC8v3PjA
        VY9hHzObIeX2DWScQBszJDHUWCwTsTIiNq/6/F1vQp2o46UIjlP290MlRpQ==
X-Google-Smtp-Source: AG47ELvz981H7Dk2IdWZL5ZcKBAtFRZaurTFsOXSKO9S+VGtGh/+dtAbJne8VUJmeSz6jS6LZj93riFcPCc=
MIME-Version: 1.0
X-Received: by 2002:a25:69d3:: with SMTP id e202-v6mr2756711ybc.55.1521052342295;
 Wed, 14 Mar 2018 11:32:22 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:31:39 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-3-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 02/35] pkt-line: allow peeking a packet line without
 consuming it
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
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
 pkt-line.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 pkt-line.h | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index db2fb29ac3..1881dc8813 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -400,3 +400,53 @@ ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
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
+	if (reader->status == PACKET_READ_NORMAL)
+		reader->line = reader->buffer;
+	else
+		reader->line = NULL;
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
index 099b26b95f..11b04f026f 100644
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
2.16.2.804.g6dcf76e118-goog

