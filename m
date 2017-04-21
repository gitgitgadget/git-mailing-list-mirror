Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B20207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 18:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161295AbdDUST4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 14:19:56 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34932 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1041697AbdDUSTx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 14:19:53 -0400
Received: by mail-qt0-f193.google.com with SMTP id o36so12899962qtb.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 11:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VI6Ciu0n0OUnY9NPUh/PX210zIn4LNV0wTuLRBkGEpo=;
        b=LzALOfwkJ01w3eu3U8ev77onz03QN3Ih7bqvdhC6thD1o/f/mm++LqyQANELZQ3zoL
         BTYS7UeUWal7o+8QkZdb2C4xrTslgM+HrNVUvgozH13D9eKYQZigg0vfR/Am/nFVOKG2
         755bH30DUSbeZfnyK/jC143Oo6sgt9PYXUenBbpdpKA9bkwawZTzK2b5CYuYm0uzpVIK
         nKrHf4zmgzI8bGPYfj8QjdqforAgk7BrSM/rXRp6Qb2uVBFd2Ww+RdHVPJtuLF3zn0X9
         Pi6TMoPrGPB7XRifB1evPPCUwjWIk4bG1jVFpb9YGujkDZZBFkQwpHdNNqASu/0OwC9w
         mZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VI6Ciu0n0OUnY9NPUh/PX210zIn4LNV0wTuLRBkGEpo=;
        b=BxAhB4o7qlX9EWlj1uQ6097es+Per07Mwxgz+cU28obE0/WqMQ+atUOlEwDXg2jUDl
         v7JLrIcTvbxkmggNKkGfgR3tPyVFLNRdVcnDB0HGEdk/pDPA0y4+hLfw+VGL6MdBJnPw
         lleLplehxK/YRB4r96hgxp1fSskQ+hJVhDzQP6xjxZ2n1+/X1d/oFkXy2I2cmtYhuPT5
         oLJbhRsqP+EFO98niNU9inZGNQ8JJqGIEdE6zveoE9Y7K0CcbaLgzBB1qk29WF0yWIzq
         pQgRmrGt+LTj1j3SGa7U0jdBevwLfvYGV6mnqr1WDPPs6Npv3w+Cxq3zoVZz2tafGi9f
         E+Bg==
X-Gm-Message-State: AN3rC/6po5HvgUdMA9UgqFHHqNciUva3mJoJFgdvu8DVQVtAOqIQ34aC
        G4hNbmed3vanmX8JRHc=
X-Received: by 10.200.2.168 with SMTP id p40mr13914054qtg.18.1492795605339;
        Fri, 21 Apr 2017 10:26:45 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id g66sm6700551qkb.55.2017.04.21.10.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Apr 2017 10:26:43 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v6 1/8] pkt-line: add packet_read_line_gently()
Date:   Fri, 21 Apr 2017 13:26:04 -0400
Message-Id: <20170421172611.12152-2-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.windows.1.33.g243d9b384c
In-Reply-To: <20170421172611.12152-1-benpeart@microsoft.com>
References: <20170421172611.12152-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add packet_read_line_gently() to enable reading a line without dying on
EOF.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 pkt-line.c | 14 +++++++++++++-
 pkt-line.h | 10 ++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/pkt-line.c b/pkt-line.c
index d4b6bfe076..bfdb177b34 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -315,7 +315,7 @@ static char *packet_read_line_generic(int fd,
 			      PACKET_READ_CHOMP_NEWLINE);
 	if (dst_len)
 		*dst_len = len;
-	return len ? packet_buffer : NULL;
+	return (len > 0) ? packet_buffer : NULL;
 }
 
 char *packet_read_line(int fd, int *len_p)
@@ -323,6 +323,18 @@ char *packet_read_line(int fd, int *len_p)
 	return packet_read_line_generic(fd, NULL, NULL, len_p);
 }
 
+int packet_read_line_gently(int fd, int *dst_len, char** dst_line)
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
index 18eac64830..ad30db101a 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -74,6 +74,16 @@ int packet_read(int fd, char **src_buffer, size_t *src_len, char
 char *packet_read_line(int fd, int *size);
 
 /*
+ * Convenience wrapper for packet_read that sets the PACKET_READ_GENTLE_ON_EOF
+ * and CHOMP_NEWLINE options. The return value specifies the number of bytes
+ * read into the buffer or -1 on truncated input. If the *dst_line parameter
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
2.12.0.windows.1.33.g243d9b384c

