Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4375420281
	for <e@80x24.org>; Tue, 26 Sep 2017 23:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032773AbdIZX4w (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 19:56:52 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:43604 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969099AbdIZX4t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 19:56:49 -0400
Received: by mail-pg0-f51.google.com with SMTP id u18so6785327pgo.0
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 16:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K44t7p6p7GU69Sr1cRo5ANyyGKxgxAx8C4LCZASHbkk=;
        b=BNZ1RTnUfbT83pI4RiNj0etsRk1gJykFLJ+TNPoVeyM2yoqd5y6oVk/9LS+n8kDDEH
         c/GWg57a3oOdt/nnh97nXRL/frrzb1aR5RANI97JuumWRDe+Yx6XkHce9nno1oCxDtZK
         JRyKl3000vPGuR8PJRAMCuMoK0nApZUqsKNrkLgepYAItt+KlkhAsRMVkHDmKz3qwSas
         mxXbRP831Wl98dqWZ84aEMbRSoXm5ShOLIcsw9lNH7i/HwYcWUWWku+7UA7KBn0Gw5FB
         yWZQ5UAmTR1ZsRykMNmhn+hS3RmwDM1n61RYZ+KBlX4Kw1m9oudQx4jirCQNw99kg9gh
         q4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K44t7p6p7GU69Sr1cRo5ANyyGKxgxAx8C4LCZASHbkk=;
        b=BQ2sI7uFfq1gRwgqSzS+SC7LZ2QMK0rcQBWMXwEaByJ3o3jW1X9iLpFhRLbFRHC3h2
         pqG1zifLsU8PYzgh/q6qqtBhYbYBv7+LpuRI5YzloQQu/u+rLzoZelPpqRFqSClE3dQk
         yrSdZvsRzc04RZwNPZ03zw64U7l8xD+PbQKFsT7hoqLuw9zOm8oY5uZenkPcdCJdBeuS
         R4GO4h7Ql6FFHGlMS766ngTF/Z3av87jqGHUkDVqiGanhW39aa3apqjrzqOumqupLBo4
         bR5Grf3/DE3KSk9LPdSS6QxhyhtSo/Vk3gkH5mWoHCaenwxkfj2ay7YioA0FLLXryr2g
         NZUQ==
X-Gm-Message-State: AHPjjUhijjdOzy8fT+SU8sZd1pUACmKQDscVrtxr9zZ8+eBiis9WhM45
        c8Mf14RQpAAXhtLKHowittCBQZVPMXg=
X-Google-Smtp-Source: AOwi7QBrwixoX42ATh8nDK1+tfOSRfLGRSg4woIA4CW+QlZwp41/43W94Pjdt8FI01xYVfAcJq4Ihw==
X-Received: by 10.101.93.132 with SMTP id f4mr12721013pgt.408.1506470208933;
        Tue, 26 Sep 2017 16:56:48 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id j2sm18071699pgn.26.2017.09.26.16.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 16:56:47 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 2/9] pkt-line: add packet_write function
Date:   Tue, 26 Sep 2017 16:56:20 -0700
Message-Id: <20170926235627.79606-3-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.992.g2c7b836f3a-goog
In-Reply-To: <20170926235627.79606-1-bmwill@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170926235627.79606-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function which can be used to write the contents of an arbitrary
buffer.  This makes it easy to build up data in a buffer before writing
the packet instead of formatting the entire contents of the packet using
'packet_write_fmt()'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pkt-line.c | 6 ++++++
 pkt-line.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 647bbd3bc..c025d0332 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -188,6 +188,12 @@ static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 	return 0;
 }
 
+void packet_write(const int fd_out, const char *buf, size_t size)
+{
+	if (packet_write_gently(fd_out, buf, size))
+		die_errno("packet write failed");
+}
+
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 {
 	va_list args;
diff --git a/pkt-line.h b/pkt-line.h
index 66ef610fc..d9e9783b1 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -22,6 +22,7 @@
 void packet_flush(int fd);
 void packet_write_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
+void packet_write(const int fd_out, const char *buf, size_t size);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
-- 
2.14.1.992.g2c7b836f3a-goog

