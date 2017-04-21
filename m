Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FFFA207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 19:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424591AbdDUTLz (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 15:11:55 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34954 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424559AbdDUTLx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 15:11:53 -0400
Received: by mail-qk0-f194.google.com with SMTP id k139so13543062qke.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 12:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KnMlG/+arludWJ5pfUp0vWN0Xj0xkR62Z5+YisOnezQ=;
        b=KJLPOQhGi0bZkY03ok5n/2m2pB9KDqz5fifxgh5WFnpPtOKXb3LcUehAPDAoYM2zjx
         F+QjT4nyKgNqTGkKK62BWIXmQXyInk14QVnrx3SDxpUsYAu4XqZTw0J2a0Bs8xyOM7ys
         eJoUwU1c/EQoh33tBlyYtWQXytZusCnvr72AAVcp4cEFTJlNJ7naGqsgB4xQBiOccpkw
         97GzqY/WpAYoAPAzrQHA4T0Zs424sxT5gcJv4EJrIVZ+nDP4y2F/uwOBmdmDVrOYodzC
         CieGZdegC7a73Zg06G+f+YyVcrIC+TBrUcaO7WGaoHowPEDGiAvdtG0i2vatmvhUHqIm
         FXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KnMlG/+arludWJ5pfUp0vWN0Xj0xkR62Z5+YisOnezQ=;
        b=Ija7/+NIVeAFKx3ruK+FCZSMgr50Pw4cMjkMiVeRqJNwrKEXtgnkD0eEFWMVtuQUil
         dGhNt2mB8hVlNL8AYMd6lsU/Qg3A9w91SXXS+sKtsaZbHjm/eameZcFYyZjGtaE38O+U
         d2WbUOctIQrOD2EDCmDG6x478o0PZDkl36hkdJaw0TLIBCaOg3G7H6rVcZk78x8P//XC
         vS2o39cTTQUX6Bvzy8HSOSoNuqqCwj8MFlqyVCdO0Qn7VvUutjoqYkD0v8Hcow8zjIXa
         tXdwahBEUIpu511UJ/WnQfGCBLKlLqMntNLNTHKiLKZyyv5Q3dTC7bi9LmxAwK7RiMsx
         RAJA==
X-Gm-Message-State: AN3rC/6meIE0XjMlp0zcBURXXZdvKXLjG8V0c/flROw34l2Sjx69+RVY
        CCbjbBIZXm2mIyQVWz4=
X-Received: by 10.55.93.193 with SMTP id r184mr13186401qkb.221.1492795607378;
        Fri, 21 Apr 2017 10:26:47 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id g66sm6700551qkb.55.2017.04.21.10.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Apr 2017 10:26:46 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v6 2/8] convert: move packet_write_list() into pkt-line as packet_writel()
Date:   Fri, 21 Apr 2017 13:26:05 -0400
Message-Id: <20170421172611.12152-3-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.windows.1.33.g243d9b384c
In-Reply-To: <20170421172611.12152-1-benpeart@microsoft.com>
References: <20170421172611.12152-1-benpeart@microsoft.com>
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
index bfdb177b34..756410d2f6 100644
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
index ad30db101a..957b9a5fa3 100644
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
2.12.0.windows.1.33.g243d9b384c

