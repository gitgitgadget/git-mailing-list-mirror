Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01F491F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeCNScW (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:32:22 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:43701 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbeCNScU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:32:20 -0400
Received: by mail-vk0-f73.google.com with SMTP id b144so2592317vke.10
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=dwLdF7gCWRCq56ihEV9zAAWdWYmhZhEs+fCNZXwY3cE=;
        b=QammBD5sOkqz/bX1LZ1Hh0plMdX69xtQIcDXXVIEYTpfaqeBl19HeQwYhV0j82QmgM
         pVePo7nVJhPMfg6jMoXbBDfKNtHTHoN2dmkN/7gyuQgvEMl6bLMCSJFfOjnII25LTUn7
         32k8+VqW/YhZDnvkZYQeIaoyCTpnRqk+wBsjMsSKCGmPGey8E8l16eaL/H1YWuF1tgJR
         KkGF9wxAsx/1SO0rjZvNqCFdcO8IOzU8KTq9qv00xUa7PhZUayQdjExKh6r8hADHffSj
         3wyqHHgZ60udZKsCpF/vgNxdlwEfKLzC1A1xLAUym/w53fh8WD5QoVKUerZ1hPNnZjqH
         EVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=dwLdF7gCWRCq56ihEV9zAAWdWYmhZhEs+fCNZXwY3cE=;
        b=ZHn9dQf6VONVTMR7kDd0/g+jd2uaEkKLIShAlN9KdkwY4+O2kAHknwHKYRFtRWgIlc
         6zXyXiEbbCshr45Eovv1f92thTDGqixXCbk/FZsijyunmY1QFoOuB99XL6rp0c8lRPAx
         4KyUnxI5hy7RdhdaBErbsZs92SBklR4cL8PeZ+KwKNL4ZnRknzbQP8fw3qEamuY1iQWd
         p3esQwLcPNtumMki/bqJA+RpDm63yQdYLbnPA/2J2hgUhuw9c/Y+mwoRdxLBw/AYGCi9
         5kcjGOtw0bLHFjDQtN/pUpTvh2y70XC6dnrBlbLvxNEaYAYVobPVp3my9a8xs+AUuklr
         Q6lg==
X-Gm-Message-State: AElRT7HHtBEBeiNwicboVIeHyYI+OMSrkQsd/3eAlU23Y8QhCUUi9qj0
        64mZ1pJKMxVcf1p8cyYPsiixWDyjroo3yy0B9NkZn2YNlt7WJ2rb0pzMZJSFQ1mE0JFdsSROIju
        BsH7uei2qMjcRIfvnJ2O190WHtM/62MJxe2GxUOoYKZiRHb03RZwsoMaw8Q==
X-Google-Smtp-Source: AG47ELvlwj06IJR47Kc/nf8sLEJ1HIZNFguseGNy7CcJXevIgyA1Q6FasUodybZw8z80JIy7pcV3pG/6TCA=
MIME-Version: 1.0
X-Received: by 10.31.124.9 with SMTP id x9mr2542616vkc.118.1521052339930; Wed,
 14 Mar 2018 11:32:19 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:31:38 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-2-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 01/35] pkt-line: introduce packet_read_with_status
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

