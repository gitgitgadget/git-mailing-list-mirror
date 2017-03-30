Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53D8F20969
	for <e@80x24.org>; Thu, 30 Mar 2017 15:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934199AbdC3Pyc (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 11:54:32 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34811 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933443AbdC3Pya (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 11:54:30 -0400
Received: by mail-qk0-f195.google.com with SMTP id 10so6907008qkh.1
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 08:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1ZBh7Om3DjUNaAf7DEnxI1yO9fL7Qt7+jiJPZivfz1o=;
        b=FQuPN1bjv+Or2zgR1G+DI+jWoOJSH5Zbp8xo0Xm6fsSw5DI+wstuyYlSnQupOx6Bb5
         o21htn0dynjjqBlfwbJK8YE0S+pcDfWHAOahdcEpbD2MS5/VxSioTBh+Zs9lUgXpAHW6
         thuemabLYWpqExD5v7ONmp8z3gBG2qfoFxFqkCejB1NEu+xauxpuaTVfs6tk2Lqw65R0
         03xfQ3uzz8DriNQsueJEqWPCMzUpldovzfxkIJsif2HVBrhT5MSKqyXVytIY94aneyFM
         FS47q2Wen36xa2+4ITvR3/cGjIKQnsPzGTohp86HFI2COasv55XevnG9pFTUq18Tkozq
         2+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1ZBh7Om3DjUNaAf7DEnxI1yO9fL7Qt7+jiJPZivfz1o=;
        b=QEpYzvjikz+YJWP1/wZR8aV0ErYTFsxprOP7NuFFUwcDq+yb9RdLm3z4ijBH84+h/9
         1oEZCsBWkEs2sKm9PYhPNIxbARNqXfoLQc2pyv8fiqyqWt29HwrICyAPRisN7rfenhbX
         QzTxit9OuxWNC8/0VN2PttqpUlwovfkh6jw8MBJk4HGuKtHyN0HWgUEaNbsgLtgnKiGe
         dnc3lpSwjXHKPuVeeNbjuQpUQcoVp1GCh1nxLMS36q6tY4P56Mrj6XZlA40N9qnZnFB2
         bt8hi+uKyHW36H0wBEddn7d9mPKmLmimEpgy7eI0rIzlm0Lkd4WqL9bIE9WqgB81QewN
         7rig==
X-Gm-Message-State: AFeK/H2mK/3/1RWQsgm3P7V5Cs81Uiv8qzPV8gjTijNRZhE8lHkgK7JjILV5ruaZerddBg==
X-Received: by 10.55.149.66 with SMTP id x63mr372458qkd.277.1490889268813;
        Thu, 30 Mar 2017 08:54:28 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id k5sm1665671qtb.12.2017.03.30.08.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Mar 2017 08:54:28 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v4 1/8] pkt-line: add packet_read_line_gently()
Date:   Thu, 30 Mar 2017 11:54:09 -0400
Message-Id: <20170330155417.8928-2-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.1.gvfs.1.18.ge47db72
In-Reply-To: <20170330155417.8928-1-benpeart@microsoft.com>
References: <20170330155417.8928-1-benpeart@microsoft.com>
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
2.12.1.gvfs.1.18.ge47db72

