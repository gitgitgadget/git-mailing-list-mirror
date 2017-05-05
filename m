Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD9E9207B3
	for <e@80x24.org>; Fri,  5 May 2017 15:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753888AbdEEP2m (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 11:28:42 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33957 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752410AbdEEP2j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 11:28:39 -0400
Received: by mail-qt0-f193.google.com with SMTP id l39so1237167qtb.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 08:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M+B6kMgCkjTFAKl9neHJry4vzvSEzVLlEDsQ9E/Wtk4=;
        b=C1UtXm4yMmxhsbDHINLt8YraV68de7XqIoMxRb5W9Gl+U6GtpUaSQNp+TkTQ7jaLeG
         g7G6lRdfkDBLK/xeiw6WZ+X7+W0sE8eDIi8jDqAdzddff5MCGEzJsQJ0GuCrSVpiimZI
         b1cWfGF/joWaJHlNTFCytSFa44ITlaKGRmLDEVlGOy2uDfkBk7guINXoO7TpeHeqNHB8
         6eFxbpTs44pxdlk7aBU6w7/LWzqXp0vVDxAHFdmymtewax44pdkdmLuzGq0MMneyLeTC
         G4YUEf7ymIiyqX1xIVkUe8gfay5jNj6OwRl14fuRSTPSC75KrXJRzICE5BJ2Lv7hZ41A
         9j2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M+B6kMgCkjTFAKl9neHJry4vzvSEzVLlEDsQ9E/Wtk4=;
        b=ZHAxjvgHSY9eCjixMSi5vOSJUT3H6kAzWDuhBOgHpafJjCMgqQKSJleU40rRexurJw
         rbPsd52WRBWWfuDKlga0as0t0JQ+VMPUGj0W0ajS+W3su+M4Agabk0S5mpUfNEc7yQVb
         M8y1LCSwKPDxBIlv80mQ2N8j7HPVAVnjhJJJM9cvN6DnL96SfBT06/QFbEt55BUe7sJM
         CE70MjWZl13qcP5O9lC2Q5GjYQtJa4uweQnsc4Qej1TiSPWJg9fDOQN8jxINe73x1zco
         z7MBONHESGMGPm3eHqiS31sP9G2rEGjak7r1OVGzAAjyT21iq+vVeSyvbO68C85S7mGl
         nezw==
X-Gm-Message-State: AN3rC/7Xz8gGVC5tpelyfakt83wxpv33mFMpKz0rPriMcX5dWeUFlYq8
        9o2Y/B3JBJiC3Q==
X-Received: by 10.200.36.131 with SMTP id s3mr47164830qts.289.1493998119057;
        Fri, 05 May 2017 08:28:39 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t68sm3392792qkc.44.2017.05.05.08.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 08:28:38 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com, peff@peff.net
Subject: [PATCH v7 03/10] pkt-line: add packet_read_line_gently()
Date:   Fri,  5 May 2017 11:27:55 -0400
Message-Id: <20170505152802.6724-4-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.2.gvfs.2.20.g3624a68d62.dirty
In-Reply-To: <20170505152802.6724-1-benpeart@microsoft.com>
References: <20170505152802.6724-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add packet_read_line_gently() to enable reading a line without dying on
EOF.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 pkt-line.c | 12 ++++++++++++
 pkt-line.h | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 6f05b1a4a8..7db9119573 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -323,6 +323,18 @@ char *packet_read_line(int fd, int *len_p)
 	return packet_read_line_generic(fd, NULL, NULL, len_p);
 }
 
+int packet_read_line_gently(int fd, int *dst_len, char **dst_line)
+{
+	int len = packet_read(fd, NULL, NULL,
+			      packet_buffer, sizeof(packet_buffer),
+			      PACKET_READ_CHOMP_NEWLINE|PACKET_READ_GENTLE_ON_EOF);
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
index 18eac64830..66ef610fc4 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -74,6 +74,17 @@ int packet_read(int fd, char **src_buffer, size_t *src_len, char
 char *packet_read_line(int fd, int *size);
 
 /*
+ * Convenience wrapper for packet_read that sets the PACKET_READ_GENTLE_ON_EOF
+ * and CHOMP_NEWLINE options. The return value specifies the number of bytes
+ * read into the buffer or -1 on truncated input. If the *dst_line parameter
+ * is not NULL it will return NULL for a flush packet or when the number of
+ * bytes copied is zero and otherwise points to a static buffer (that may be
+ * overwritten by subsequent calls). If the size parameter is not NULL, the
+ * length of the packet is written to it.
+ */
+int packet_read_line_gently(int fd, int *size, char **dst_line);
+
+/*
  * Same as packet_read_line, but read from a buf rather than a descriptor;
  * see packet_read for details on how src_* is used.
  */
-- 
2.12.2.gvfs.2.20.g3624a68d62.dirty

