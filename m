Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB4BC20323
	for <e@80x24.org>; Wed, 22 Mar 2017 17:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760927AbdCVRAb (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 13:00:31 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35244 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760918AbdCVRAY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 13:00:24 -0400
Received: by mail-qk0-f193.google.com with SMTP id o135so26880026qke.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 10:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=44OH4Do/XYx6Vo8U7fCxjF1Ktu1AyljJSrCgVGU2D0U=;
        b=T0s93zyAOD3/I4b/GU/N/cHtmlesI9g17pMpBZ4EMhQpYi05KdQPk3AhkGUpZre1ww
         knJ7ZPYv0WhYXiUQKjoytvP54BqmLGIs87G+lKTL4ffuX686j837nGJ36CTttvDl6qMv
         bNO84t9gPAzlDmeQ8FcL4k2mm8jhL7IwwJkEwMGqC0rFR7dIValcDY7rxOS+AnJ+4bvv
         XutUDY+KwpYYPUB+IRN6AJKfv+imq4ebMsqzP5+uHvoqTZlMS9NYHWTSnhgETZ2SZEEP
         g064prWQmoP4KCSipv1fD5rPfDKO/FAbvijhXswJ9VDvO8MISewP+yDpueOCN25nWKXZ
         17yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=44OH4Do/XYx6Vo8U7fCxjF1Ktu1AyljJSrCgVGU2D0U=;
        b=RFFOH0z2g9FygFRx3BdiZhQgXsYlr5MeVqdZp49A+IXBNi+045TTrxbN8/ufFbbAta
         +XLNmLGhFQtGQBDJfVdtckZdfkboXtDUqR8GTFAL3WhlYIj7fn81YHpWU+WjcvWqAzZs
         +Jq6G0bqkMPl+8tdXqTtHRQ6UWHlbS4RkCVbocSWwUwrEuzOeLMlXdq2iVRxuRAsnT6Q
         D8ZoBalCUH84deS966Nda4p9A5nep0ZgD7A5exqZiMo41WXQW/XpoYFTD4vsH/jO8/bc
         rq81Np//aVsG2NtN7gMKOaDGJ2FX3P7JYe3BPjM0yUmpdyMxIAHYGDkobo52sKnqfNLW
         hMmA==
X-Gm-Message-State: AFeK/H0E/jvUHJJTpuKzbBuP+bxfLzGNFRlaT6AFR2edJ+WIeMniCdIo7Uiks3wY3Xt56Q==
X-Received: by 10.55.142.69 with SMTP id q66mr35402596qkd.13.1490201634313;
        Wed, 22 Mar 2017 09:53:54 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t47sm1334588qte.45.2017.03.22.09.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 09:53:53 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com, christian.couder@gmail.com,
        larsxschneider@gmail.com
Subject: [PATCH v1 1/3] pkt-line: add packet_write_list_gently()
Date:   Wed, 22 Mar 2017 12:52:18 -0400
Message-Id: <20170322165220.5660-2-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.gvfs.1.42.g0b7328eac2
In-Reply-To: <20170322165220.5660-1-benpeart@microsoft.com>
References: <20170322165220.5660-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add packet_write_list_gently() which writes multiple lines in a single
call and then calls packet_flush_gently(). This is used later in this
patch series.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 pkt-line.c | 19 +++++++++++++++++++
 pkt-line.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index d4b6bfe076..fccdac1352 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -171,6 +171,25 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 	return status;
 }
 
+int packet_write_list_gently(int fd, const char *line, ...)
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
index 18eac64830..3674d04509 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -25,6 +25,7 @@ void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+int packet_write_list_gently(int fd, const char *line, ...);
 int write_packetized_from_fd(int fd_in, int fd_out);
 int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
 
-- 
2.12.0.gvfs.1.42.g0b7328eac2

