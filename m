Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8777C20966
	for <e@80x24.org>; Fri,  7 Apr 2017 12:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932939AbdDGME1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 08:04:27 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33869 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933147AbdDGMEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 08:04:25 -0400
Received: by mail-yb0-f193.google.com with SMTP id m133so2372264ybb.1
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 05:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LMveWIC0CWiw3SfMKmoRR6zSLlSDVsxE7BtGYH5CXAs=;
        b=s1qj4EcBBy7bQMoZFThDhZe0/vp/y6fHxfeW9LF/DljlJivRcVmx2JrBIhs5YLejEI
         YALGXem4bCmzTuR0zueqKYJv5pohAPuyG/LuJOZlMbzvOlDHzF8XrRjZQcMY0hHfTSY5
         vP0ntAZyvdzj3k1ZQqalkR+6/HaMd+O7AXEvpC/fbp53Yemswup7vVRpnk1X32enpiA2
         G+4UJ5uwHEsBv+6YruSOOe6znZs2SDUXoYn6yjAjzTHeh3p04nu3ZOwphoCK0bA6sfi8
         27+Ze12Di4kql5XQqt1/RG5w5dYxWJZoZ3sUZtKj38Hw8S6TWfHU13GOz+qi7LnC9XGB
         UOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LMveWIC0CWiw3SfMKmoRR6zSLlSDVsxE7BtGYH5CXAs=;
        b=CoXezP829noS5Q3Gjj23z846oRGjPCT13ppz43ccdX74zcEW9hBl/Dm9gxIxIUnZWd
         8u0P31g1UYPUGnqYTYC5+sgvfikcSlxSfMWfHrwdZO9bhGP+iO0U0CnlTejE6JC8/sxd
         d3ead/ih9WCWS9iZAKfA9FT7g0mvLXB+0Ro9fVXbtQAlQRK2TS19OZGd9e+/wxXCCWWE
         ZuX/p+GibwU8cT/GC15sp2ErMR0AcyAyqxKwxTKG11O5oDtqD5jkD5NPkeV0A1kAWup5
         aW2/rKX3QemgQtK1RLC8Ru7St0pjMqjuCOvXjhBTxY6V/Fq7D2wnO7usaygmvFWpNygC
         jh0w==
X-Gm-Message-State: AFeK/H0lU9mNWTnbTXmnfDTKaEG7RBJbQqSUhXBhRw5KFOjZMJZ4EOgMLXUYlcgfQRRzdg==
X-Received: by 10.37.214.2 with SMTP id n2mr26604973ybg.67.1491566664699;
        Fri, 07 Apr 2017 05:04:24 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id z194sm1874038ywg.73.2017.04.07.05.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Apr 2017 05:04:24 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v5 1/8] pkt-line: add packet_read_line_gently()
Date:   Fri,  7 Apr 2017 08:03:47 -0400
Message-Id: <20170407120354.17736-2-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.windows.1.33.g243d9b384c
In-Reply-To: <20170407120354.17736-1-benpeart@microsoft.com>
References: <20170407120354.17736-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add packet_read_line_gently() to enable reading a line without dying on
EOF.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 pkt-line.c | 12 ++++++++++++
 pkt-line.h | 10 ++++++++++
 2 files changed, 22 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index d4b6bfe076..58842544b4 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -323,6 +323,18 @@ char *packet_read_line(int fd, int *len_p)
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
index 18eac64830..12b18991f6 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -74,6 +74,16 @@ int packet_read(int fd, char **src_buffer, size_t *src_len, char
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
2.12.0.windows.1.31.g1548525701.dirty

