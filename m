Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A51261F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbeCORbw (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:31:52 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:42615 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeCORbu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:31:50 -0400
Received: by mail-vk0-f74.google.com with SMTP id j9so4742784vke.9
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=dwLdF7gCWRCq56ihEV9zAAWdWYmhZhEs+fCNZXwY3cE=;
        b=tDQPo4ElUFCL/2dx8xAJhqwIeVGZ1befntY1PZdlmoLltJS07EZ7MAr/kyqdcwgLX0
         0AHSJEn+kaVWu5XKeJjUMn2mf9E2k3xt35fNdVlPK0qPkNrn7wJcJNxG2VmFpeit+5ez
         d48rIdQ4cq3jIQCi8IfUMj4JAYjHqOImRLm/uzSQJtns54kk+4N9oXKFFJJUYtoi0PHC
         QoyCCG2CRaA5grvPbslWOq++NqbJbW+Us874Sr1gXh+CBaRIMxxAys+niFephUtcGBPI
         fimQsfqIah7Gn2Idv+HyesV71cZ8m/VRKTTjwL/TqldVQw4JiegWjcVPwjiwcCeKuSaU
         1JsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=dwLdF7gCWRCq56ihEV9zAAWdWYmhZhEs+fCNZXwY3cE=;
        b=LyW/1ODOgyq+YTcflhcvj4l4EWR8MeZ8GduOjwQepFeR0fBcFvk5PbIjsm1gqN902c
         Q8Cjx2AJ21wTtTkxoKryZ62yOQcU681fE08MYRvozTglxRGitA3gz5JQq7qQCfK2FXb9
         6ZuIr6YqQF+GUda29dIk7mMFs62x+gXFrBQw1SIk+40F+csCrIzz3xAxer5ErOR0QLje
         50yFxNV3AezeRmdMYUsSYSiJW42yHt0p3MdMvjLfk07VxM+7ow0etgpmShWNc1rN0yXu
         NTWsngnya81QtOblgQyfEz4zGBRFfTaB59kEMw+F2ntBjCB6ejc9hGUrzT+pOLIAymp1
         didg==
X-Gm-Message-State: AElRT7E7go9bx3b/UYMD37811i1LuCfl/9DyB+kZwt94CJVvR73B4/zh
        rt87zHvuoX5PC6+8gSFyla2/50byHEh4Q8q/S8mO99W4vwTO8DBD4gVOTpggCQ9v0aG7Vg+DPHn
        YdoqmxxyfTIzmWbP5DYdeioZi9SqzavkvXPcP9aK+EAi74ubBT5akkasxHw==
X-Google-Smtp-Source: AG47ELv8xU6FoEOCJfIbSb5AKkIMLPXjYeEYZ9DHRczVJI1eTQwUZRSNN8WHfrQfgR/+S3Qfv814XXuR/N0=
MIME-Version: 1.0
X-Received: by 10.176.85.203 with SMTP id w11mr4015090uaa.67.1521135109328;
 Thu, 15 Mar 2018 10:31:49 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:08 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-2-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 01/35] pkt-line: introduce packet_read_with_status
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
 pkt-line.c | 51 +++++++++++++++++++++++++++++++++++++--------------
 pkt-line.h | 16 ++++++++++++++++
 2 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 2827ca772a..db2fb29ac3 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -280,28 +280,39 @@ static int packet_length(const char *linelen)
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
+	if (get_packet_data(fd, src_buffer, src_len, linelen, 4, options) < 0) {
+		*pktlen = -1;
+		return PACKET_READ_EOF;
+	}
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
+		*pktlen = 0;
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
+	if (get_packet_data(fd, src_buffer, src_len, buffer, len, options) < 0) {
+		*pktlen = -1;
+		return PACKET_READ_EOF;
+	}
 
 	if ((options & PACKET_READ_CHOMP_NEWLINE) &&
 	    len && buffer[len-1] == '\n')
@@ -309,7 +320,19 @@ int packet_read(int fd, char **src_buf, size_t *src_len,
 
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
+	int pktlen = -1;
+
+	packet_read_with_status(fd, src_buffer, src_len, buffer, size,
+				&pktlen, options);
+
+	return pktlen;
 }
 
 static char *packet_read_line_generic(int fd,
diff --git a/pkt-line.h b/pkt-line.h
index 3dad583e2d..099b26b95f 100644
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
+	PACKET_READ_EOF,
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
2.16.2.804.g6dcf76e118-goog

