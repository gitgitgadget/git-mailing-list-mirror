Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DB6020966
	for <e@80x24.org>; Fri,  7 Apr 2017 12:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933443AbdDGME3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 08:04:29 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33871 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933427AbdDGME0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 08:04:26 -0400
Received: by mail-yb0-f193.google.com with SMTP id m133so2372282ybb.1
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 05:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4gPUSRSVAmNbbzjpBFFanoOsQwEyepfAmujbPkdUAOE=;
        b=RHzJoYjpcOm+kWA6yH0oKX86yjCR7SDmVF4OsujlwVJEJ4ewPX2u+eF+gLyCHqRwAx
         Oai7TwVs0k5HtHz93Wj+if5yLJoy7oDM5uz8GmjCOKNOG8fIglOB9YboqCulney27Zww
         KnbSuiTHSkD6pO0eM8rqGKepC0rSYepiMRdbmx5KIt/lsPeLXSU4Z8vtoWGf5A0jqIMF
         P2CouIW0OmYCprBeG911E2YiZDA2ZfT4EM58aEcZvHcjKrFktcGRZRKI0lalMjERWDQz
         gHw5X50wFQ1dWLEOWogvqVvuRsuJRrJ0PfZ3GZKO1y9by5t4j85tc8t2rxAPJeAun3+s
         JErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4gPUSRSVAmNbbzjpBFFanoOsQwEyepfAmujbPkdUAOE=;
        b=AeQLqhcf4w3KHi+BCg7r7v+5aYtL6vK/qbql31SzNapFZdbd84YKbkVnRFiwkaFoSm
         Tl/1tbzZ9LGrFetH/d7YPKmfOLlad72o2Uv0vCkErlcJlHi1TeRHmWld4ixDrhKtAD9j
         eDZTyGiC7exLc3qjPzco2UoUT1Nhi4WsKDO7ytvDHk8e6iQ55Quwh/yFcaEh/P70CFWX
         9l/fu4c1qsvZ+x8k9fI0IBp+ynbqDRnGU4t7W/bROrHwcivdw3DZg2kiO+Xqw1rV5Bxn
         TgvdzSJJlydUWrkS2ojZGtt5GiikyHFYk5/cDGiq3dzehCjVH+T016+AhVT6KHMFt/IM
         8fMw==
X-Gm-Message-State: AFeK/H1LcAibOLFqsXVcm/f4odSNy4kMjESH4/cf3Ef3RmAQrKWteUYVQY18xU38AC0SBg==
X-Received: by 10.37.73.5 with SMTP id w5mr25655206yba.87.1491566665877;
        Fri, 07 Apr 2017 05:04:25 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id z194sm1874038ywg.73.2017.04.07.05.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Apr 2017 05:04:25 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v5 2/8] convert: move packet_write_list() into pkt-line as packet_writel()
Date:   Fri,  7 Apr 2017 08:03:48 -0400
Message-Id: <20170407120354.17736-3-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.windows.1.33.g243d9b384c
In-Reply-To: <20170407120354.17736-1-benpeart@microsoft.com>
References: <20170407120354.17736-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add packet_writel() which writes multiple lines in a single call and
then calls packet_flush_gently(). Update convert.c to use the new
packet_writel() function from pkt-line.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 convert.c  | 23 ++---------------------
 pkt-line.c | 19 +++++++++++++++++++
 pkt-line.h |  1 +
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/convert.c b/convert.c
index 8d652bf27c..793c29ebfd 100644
--- a/convert.c
+++ b/convert.c
@@ -521,25 +521,6 @@ static struct cmd2process *find_multi_file_filter_entry(struct hashmap *hashmap,
 	return hashmap_get(hashmap, &key, NULL);
 }
 
-static int packet_write_list(int fd, const char *line, ...)
-{
-	va_list args;
-	int err;
-	va_start(args, line);
-	for (;;) {
-		if (!line)
-			break;
-		if (strlen(line) > LARGE_PACKET_DATA_MAX)
-			return -1;
-		err = packet_write_fmt_gently(fd, "%s\n", line);
-		if (err)
-			return err;
-		line = va_arg(args, const char*);
-	}
-	va_end(args);
-	return packet_flush_gently(fd);
-}
-
 static void read_multi_file_filter_status(int fd, struct strbuf *status)
 {
 	struct strbuf **pair;
@@ -616,7 +597,7 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
-	err = packet_write_list(process->in, "git-filter-client", "version=2", NULL);
+	err = packet_writel(process->in, "git-filter-client", "version=2", NULL);
 	if (err)
 		goto done;
 
@@ -632,7 +613,7 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	if (err)
 		goto done;
 
-	err = packet_write_list(process->in, "capability=clean", "capability=smudge", NULL);
+	err = packet_writel(process->in, "capability=clean", "capability=smudge", NULL);
 
 	for (;;) {
 		cap_buf = packet_read_line(process->out, NULL);
diff --git a/pkt-line.c b/pkt-line.c
index 58842544b4..2788aa1af6 100644
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
diff --git a/pkt-line.h b/pkt-line.h
index 12b18991f6..cb3eda9695 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -25,6 +25,7 @@ void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+int packet_writel(int fd, const char *line, ...);
 int write_packetized_from_fd(int fd_in, int fd_out);
 int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
 
-- 
2.12.0.windows.1.31.g1548525701.dirty

