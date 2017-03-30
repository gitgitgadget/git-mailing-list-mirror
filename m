Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A84DA20966
	for <e@80x24.org>; Thu, 30 Mar 2017 15:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934214AbdC3Pyc (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 11:54:32 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36464 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933482AbdC3Pyb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 11:54:31 -0400
Received: by mail-qk0-f195.google.com with SMTP id r142so6889404qke.3
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 08:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qcLzqfh2e2/0i+j4OPVV3IuZMufQ5C/UAyI14hbgVjo=;
        b=lVy2uvW4BFN70xUVN/l8VOgqzknM2oLkVsKVymdJvQsSYmt3Y77L7iKkFl97EXJrNl
         RFgG/XN+TV/mKkVFW60fdxlYd83KkheMEfDX0mGMZL80HK+qlmc7FyXUwr7wwJ2r5DUJ
         iMq87n+B++N7bqFZ2XnZZfjisjWf7F5MbePjgVtlT9pwym1a1xzKnMDdiobMqOOlTqep
         i67YjMLoWYHM0i0F5nW3oRnBpjLVagIGkPJq3KSPkwrdONBZwafzAp6fnrT3TiwSZ4lH
         UcJUb1gGK2tgB66tv5I5Nd5nlfkqUOt13UjhADqjiDFLr4YaVZkX/wfd30H+aVtJTdNX
         36Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qcLzqfh2e2/0i+j4OPVV3IuZMufQ5C/UAyI14hbgVjo=;
        b=gdI3ExRUE4/OnjsvZ/qo//PgMyH8ulNXEoZowOXwvkfOybZfbvnJ4VrT3c2f6jAgmC
         OK22DzvrNmUvzB+1Pcgh9mpJPnIuaXjZBuESvExnOrK0RD6uFTvrQmY4jR7Vi2I1PL5b
         wLxITAenKHG7wNIYSUJaraiJy9iVdvxxay1KYHuYgOTyw8GAtr3+V5wVAEO/Frp/kqlL
         Ft0yxSqqlz2ZbfupEu+pnCwph69I5QwMC0r21TrM8hk7Lmrc0eLe8ow4jd+q5AsxaXJV
         M0z8bLU9rrmsDXv2pWxR/rdBAGw9758U79TN3/FB5AYMpsRG8fgPmMkTNIXeRBobRGBu
         q53w==
X-Gm-Message-State: AFeK/H0why7+mrLNA88GQv9tbQLVHNz9uItgekuYSRfUzkMyIB7iZe5xD9xxr3o7ekcN6g==
X-Received: by 10.55.123.66 with SMTP id w63mr362449qkc.301.1490889269785;
        Thu, 30 Mar 2017 08:54:29 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id k5sm1665671qtb.12.2017.03.30.08.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Mar 2017 08:54:29 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v4 2/8] convert: move packet_write_list() into pkt-line as packet_writel()
Date:   Thu, 30 Mar 2017 11:54:10 -0400
Message-Id: <20170330155417.8928-3-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.1.gvfs.1.18.ge47db72
In-Reply-To: <20170330155417.8928-1-benpeart@microsoft.com>
References: <20170330155417.8928-1-benpeart@microsoft.com>
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
2.12.1.gvfs.1.18.ge47db72

