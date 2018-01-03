Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E7601F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbeACASr (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:18:47 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:40186 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbeACASo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:18:44 -0500
Received: by mail-it0-f67.google.com with SMTP id f190so39404ita.5
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Faayxk3xR6zRm6CKJzUW3eQ59S3KjHxoGO/o/yFm2tA=;
        b=K62PfCWOxlkZxYNO8OrTD+YTvAA5D43wl17j2UN0Tl84fzJz5XO83sl/H0hq4pJAJs
         gnQiFlns+ycsnBeeN/23NC349pv5l1ory/LUTcOd5QFtRenuM0lUEgsIkOeLHLMOzvC7
         fSc9A8CY/HgYsRAbBQp5d/FljiplAWaNyOPquQUxyyeL99zjiXhSoeSKcj5wITsPHPxe
         jpqUvqbQw6iJR7mOOFiDS5MyIJws2xQ1tJ5rnS/cZjkZYWJUyA45mWqq3By9GV8Y8LG0
         uVTyUmc6fPJm8JdbkUcNpSh4BVg5V58kG+0KF9z49akXsXItQuET1yfL/svHi7OjVoOU
         3Z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Faayxk3xR6zRm6CKJzUW3eQ59S3KjHxoGO/o/yFm2tA=;
        b=BT4YfE8fCCInOvAYS1/C083S+EWngUSlCCADRfEj9zQRg8ksQRYrwv1HXk1opB5hYu
         z2Jf4Z23gDApyZst3VYYMRRI9AJfPVvd4/ajRE4BB6qLdzc8zpkijxVcJDY4lSMlDLTt
         dOt/B3UWyqVGwbNsxjFwIaJzHyimSWAO6qN43d4Ku4jp+dzUvNUBY2Ua7ZgDrGl7G8Vu
         G3z23n9t9JFL7OwWy39uNItm6145m6uwjnsF+Y/AkspNuDYrh+V7TaP3dzmM26CyF2Di
         VTZ7JkHbWBnXm0nVPIDBx6b6zxJC2pHV7gRPElh99hHyXPu/6W6BW+6o1bGbCBKYGyuQ
         fiGQ==
X-Gm-Message-State: AKGB3mJikaH6cHsJjYPebec4jOwyDRJr2N8g0vqJ090q9hg4uXZyeK7D
        Z14Wl3X/EUGpr1/278m7iJ1ePQWxdUk=
X-Google-Smtp-Source: ACJfBouBsagBGfnXGmNC91mW3sGCDJjW+tJCIofQCOM0oSfW2ttvIIMXIOPmsDW/YrsX9OymJyCmPQ==
X-Received: by 10.36.74.194 with SMTP id k185mr5888itb.9.1514938723393;
        Tue, 02 Jan 2018 16:18:43 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:18:42 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 02/26] pkt-line: introduce struct packet_reader
Date:   Tue,  2 Jan 2018 16:18:04 -0800
Message-Id: <20180103001828.205012-3-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
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
 pkt-line.h | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 8d7cd389f..98c2d7d68 100644
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
index 06c468927..c446e886a 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -111,6 +111,63 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
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
+ * Only a single line can be peeked at a time.
+ */
+extern enum packet_read_status packet_reader_peek(struct packet_reader *reader);
+
 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
 #define LARGE_PACKET_DATA_MAX (LARGE_PACKET_MAX - 4)
-- 
2.15.1.620.gb9897f4670-goog

