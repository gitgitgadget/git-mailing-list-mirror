Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C37011FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 15:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966010AbdCXP2R (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 11:28:17 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35399 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965762AbdCXP2C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 11:28:02 -0400
Received: by mail-qt0-f193.google.com with SMTP id r5so836787qtb.2
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 08:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BduZhUViD24M9L4Gccyt2x7FnVFzxP/i6xl2RNB+izY=;
        b=kWrDTKMRzjDfo9TwEyoOp5cdVf2uu/fKj8BC4dcpIS8raVrDjhsR05MoaYxVsrm30g
         WZe7l+nXFiG+BQGAnAtKSYhRXhHLchddXCUclJ0gC2NqR1m9RXNj/gCwomiydQgS0bFb
         slTBh5fvkG8mJbGddTKQc3N4hjVYh/108UUTtZKkOPSG6gk12+P7nzrnQhQVOY+8Wh+S
         dzcIeKwFcOCJ5BoiEWTw0qYKNe5SvkfOCnvH3blU0s7xCF/BCDNwpfRRLp5z4m/RmFm4
         xz3+Z8KSoWPGjrv9WC4B22Mzwhxc0/hFnKGwTJqRz8WJVzscAwCu9JtgO/tyaQTpUS/P
         8Wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BduZhUViD24M9L4Gccyt2x7FnVFzxP/i6xl2RNB+izY=;
        b=gYTeyMP67JEh8m8kfqUEHgdRQLwKLuz675l1CLiA69YaNNJAIvTzY4FRNpA35l6C2L
         nfTGOMkc+mTxK8HJPyd5btb3BLIE0d1OrQem7ceoKq16l0XdDMI0rEC2LrmgPsLi2AL7
         PKDY0MEIB/9XipVUdMzoWnxtRllk9MfrmoSfIi+vnXwdkPaKcGECiHKbzI61/LsOb/od
         Ps455ikJuGuoGo3K60VrBYXYT0tMFJdHubco36W8HKlFNGOLVj3CJT/dQITVPw/wcRRu
         50W+Q7F7ApRff8O8cC+ZW63GnPoKNU39Ni9NCINromtTBJv4INdv9G8EeFbqMd7NgtSF
         wZWw==
X-Gm-Message-State: AFeK/H3yV56ngKpZJe/dT/+6zZpNp8ARgsiHiMeBOKwfq0EJHglBRQisB8XGOHYrJk9p5A==
X-Received: by 10.237.59.91 with SMTP id q27mr8969499qte.193.1490369259796;
        Fri, 24 Mar 2017 08:27:39 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id d23sm1717589qta.32.2017.03.24.08.27.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 08:27:39 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com, christian.couder@gmail.com,
        larsxschneider@gmail.com
Subject: [PATCH v2 1/2] pkt-line: add packet_writel() and packet_read_line_gently()
Date:   Fri, 24 Mar 2017 11:27:21 -0400
Message-Id: <20170324152726.14632-2-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.gvfs.1.43.g876ba2a
In-Reply-To: <20170324152726.14632-1-benpeart@microsoft.com>
References: <20170324152726.14632-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add packet_writel() which writes multiple lines in a single call and
then calls packet_flush_gently(). Add packet_read_line_gently() to
enable reading a line without dying on EOF.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 pkt-line.c | 31 +++++++++++++++++++++++++++++++
 pkt-line.h | 11 +++++++++++
 2 files changed, 42 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index d4b6bfe076..2788aa1af6 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -171,6 +171,25 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 	return status;
 }
 
+int packet_writel(int fd, const char *line, ...)
+{
+	va_list args;
+	int err;
+	va_start(args, line);
+	for (;;) {
+		if (!line)
+			break;
+		if (strlen(line) > LARGE_PACKET_DATA_MAX)
+			return -1;
+		err = packet_write_fmt_gently(fd, "%s\n", line);
+		if (err)
+			return err;
+		line = va_arg(args, const char*);
+	}
+	va_end(args);
+	return packet_flush_gently(fd);
+}
+
 static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 {
 	static char packet_write_buffer[LARGE_PACKET_MAX];
@@ -323,6 +342,18 @@ char *packet_read_line(int fd, int *len_p)
 	return packet_read_line_generic(fd, NULL, NULL, len_p);
 }
 
+int packet_read_line_gently(int fd, int *dst_len, char** dst_line)
+{
+	int len = packet_read(fd, NULL, NULL,
+		packet_buffer, sizeof(packet_buffer),
+		PACKET_READ_CHOMP_NEWLINE|PACKET_READ_GENTLE_ON_EOF);
+	if (dst_len)
+		*dst_len = len;
+	if (dst_line)
+		*dst_line = (len > 0) ? packet_buffer : NULL;
+	return len;
+}
+
 char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
 {
 	return packet_read_line_generic(-1, src, src_len, dst_len);
diff --git a/pkt-line.h b/pkt-line.h
index 18eac64830..cb3eda9695 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -25,6 +25,7 @@ void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+int packet_writel(int fd, const char *line, ...);
 int write_packetized_from_fd(int fd_in, int fd_out);
 int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
 
@@ -74,6 +75,16 @@ int packet_read(int fd, char **src_buffer, size_t *src_len, char
 char *packet_read_line(int fd, int *size);
 
 /*
+ * Convenience wrapper for packet_read that sets the PACKET_READ_GENTLE_ON_EOF
+ * and CHOMP_NEWLINE options. The return value specifies the number of bytes
+ * read into the buffer or -1 on truncated input. if the *dst_line parameter
+ * is not NULL it will return NULL for a flush packet and otherwise points to
+ * a static buffer (that may be overwritten by subsequent calls). If the size
+ * parameter is not NULL, the length of the packet is written to it.
+ */
+int packet_read_line_gently(int fd, int *size, char** dst_line);
+
+/*
  * Same as packet_read_line, but read from a buf rather than a descriptor;
  * see packet_read for details on how src_* is used.
  */
-- 
2.12.0.gvfs.1.43.g876ba2a

