Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F18511F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeCORby (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:31:54 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:47314 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeCORbw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:31:52 -0400
Received: by mail-yw0-f201.google.com with SMTP id i204so7651514ywb.14
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Ha0YVWd4rnC2opHz27Xl6ysPEbZuVbDGh3Glh7Yy75Y=;
        b=UkkNNBmrCM4eGy28SmAm5MFHVNqITRgB62biPI7vOx2QYxB+IrdD49ObffKz50Luzb
         0j7LyNpewNEEC7/pEORl16BDFk5P56yaQDdei8+pq3jGXVuPrUq8G6pnE+78nfJR3ari
         VzNpfTkwB2PaJNbucUvyk1hwqkcw5EBn4B8CxgDLWipKTWU+fj98IW0amzypoglyScDK
         DPRd8JqkbeRE1Potlpp229KQkg7yaKkMzykC6T44nptf6LtpLbDHxSpmwxcK3OKcNc3R
         CLvWOMLFclwaAZCLCjNbXXCz3jDNezglzTkt5yPr4fqebXniOcM6JFV5ui4qwQYjM/wD
         656w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Ha0YVWd4rnC2opHz27Xl6ysPEbZuVbDGh3Glh7Yy75Y=;
        b=Eb/aTkdkJAzN6hpQgyFkU5QY0rh76N5cmsB8jUuai9QdmikGEDXfkQD7/kBUSCHXhi
         /qRencGMcwlZU688gKQMjY9knbCE4Gdl8ysUGVNYbgGOiRAWsIqpcYrWJkbYAyT9IwmH
         4YTxky7H47g34al5tv/S+a4UeX5+cIHf3x1BtBuAlHWhGG1nAkIaq3KpXZZLxQY1CNi3
         TBzMxAwcrvbL1K7VvEA0mrLtANPnZ0Pu6VHQpTq5jwVTmgOrdbB1vQPG2yDUSSTELyIA
         L9u0atTcqo/oE1qtfNIB0z3FwAgfa6btqx9rMCzD3za0zVxNhlyqV1eIDKFiqoWfqt1i
         inwA==
X-Gm-Message-State: AElRT7ES7xPAecO6XQQOBahkxei+Pr/6bTlXiTSyAypNQUDyyi9Ex1Do
        LnCjvMCJQiGJP8HnGs0Q6hQ2ifQXdLV3Jl3rLfnuks8iKRq0SrssOzRTEUuxjwu1bNkmh/N8/z3
        QbbsaIXYZ0Z0dZKzTVbS8jhpn/sUDmn6bY78NYgzOO+JOWSN61gd/RmVcJw==
X-Google-Smtp-Source: AG47ELvqC5ciKBI4zELXatXq4oUZD3QcGpANj6eSVxXVk/gECIQPQti/xX8nCCZ5q7+usKnblRPdsC98F4U=
MIME-Version: 1.0
X-Received: by 2002:a25:bad0:: with SMTP id a16-v6mr4236401ybk.72.1521135111624;
 Thu, 15 Mar 2018 10:31:51 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:09 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-3-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 02/35] pkt-line: allow peeking a packet line without
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

