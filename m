Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478D9C433DB
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 00:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CFC1601FB
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 00:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhBMAKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 19:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhBMAJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 19:09:58 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F222C061574
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 16:09:18 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id 7so1410612wrz.0
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 16:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vUaX6CJSvvP6EgiP8l7AT1SqEY7jKOaixGCmCkgRPvs=;
        b=HL8tW3jtAYf/fPKsAtvWS0WEvGBmoHEcycUshBiUh/i4qm/Vlf24fQuty5BujWvfAV
         2UTqTYDRjNSzygwvDeHou7vgCgllBb3VvwNQsBqnpf484LkXRrCSp1jTpsbc63X+JCSw
         70eU97Gz60RUuaW/2en2iEg3qXj59cpz72YZmayViEhUyTjA/SP6l1Pu0dW7mmAXgeuN
         j7bcdhMCynsBqJf+zB1VaX+NDWBIiAT/zswhcAExP+cOLKl+HTnHCZi+R414qOx96OBn
         Q/pH/pnzD6igedXynIwW5s8RRamOR8urOUw9qAQY36byeoxfl7AhjTjfZnzuydAYpWh6
         hTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vUaX6CJSvvP6EgiP8l7AT1SqEY7jKOaixGCmCkgRPvs=;
        b=FnqcMtZitqkRUOqMJv7LT4OUwvFSNesP7cOeGbbMACo0J3Gied/rudwRE5+3ysn5aO
         GdvzIUpAxWdyBiu7/0AJca97W3QAHh0dpZzs2WZh5lsHT1AfhomVddfLHL/Xchbb+7zc
         xxKvHxSCYptN6CGL1GfArXDPZhfhcy+8P83yN3BxvAtoi8LX415tngW7uVEe4dZxQ8fN
         v1xZAb5ScojPmfCMKVyZHVhkMecHt4zvYI56q7ldte1lxYCgg1ElXoUC3NHEje4a+iYW
         04HoAnVm6UheA05PojRajvXzMzOJ0t09xQw+LTqkoDPfpv9PUv6i+7PC/j0f3rdRNlLK
         SHrQ==
X-Gm-Message-State: AOAM531NLjSisQoFCgOjv5LH/N0sCRSCvE54Ljnz4PmloxSp4l5MdR1P
        20JHv5k+61cVVr/vlVw40iRlSjk0miE=
X-Google-Smtp-Source: ABdhPJy4soyALHjhnH3cqBweN5nt8p8o5KD5s+g8s3PhC62uVw4fgb3KayRtbmzLUTAiUvx2wL0tgw==
X-Received: by 2002:a05:6000:188c:: with SMTP id a12mr6423882wri.105.1613174956753;
        Fri, 12 Feb 2021 16:09:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u4sm12009329wrr.37.2021.02.12.16.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 16:09:16 -0800 (PST)
Message-Id: <2d6858b1625aa3c96688c6c6a9157c2d2b16f43e.1613174954.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
References: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
        <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Feb 2021 00:09:02 +0000
Subject: [PATCH v3 01/12] pkt-line: eliminate the need for static buffer in
 packet_write_gently()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach `packet_write_gently()` to write the pkt-line header and the actual
buffer in 2 separate calls to `write_in_full()` and avoid the need for a
static buffer, thread-safe scratch space, or an excessively large stack
buffer.

Change the API of `write_packetized_from_fd()` to accept a scratch space
argument from its caller to avoid similar issues here.

These changes are intended to make it easier to use pkt-line routines in
a multi-threaded context with multiple concurrent writers writing to
different streams.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 convert.c  |  7 ++++---
 pkt-line.c | 28 +++++++++++++++++++---------
 pkt-line.h | 12 +++++++++---
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/convert.c b/convert.c
index ee360c2f07ce..41012c2d301c 100644
--- a/convert.c
+++ b/convert.c
@@ -883,9 +883,10 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	if (err)
 		goto done;
 
-	if (fd >= 0)
-		err = write_packetized_from_fd(fd, process->in);
-	else
+	if (fd >= 0) {
+		struct packet_scratch_space scratch;
+		err = write_packetized_from_fd(fd, process->in, &scratch);
+	} else
 		err = write_packetized_from_buf(src, len, process->in);
 	if (err)
 		goto done;
diff --git a/pkt-line.c b/pkt-line.c
index d633005ef746..4cff2f7a68a5 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -196,17 +196,25 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 
 static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 {
-	static char packet_write_buffer[LARGE_PACKET_MAX];
+	char header[4];
 	size_t packet_size;
 
-	if (size > sizeof(packet_write_buffer) - 4)
+	if (size > LARGE_PACKET_DATA_MAX)
 		return error(_("packet write failed - data exceeds max packet size"));
 
 	packet_trace(buf, size, 1);
 	packet_size = size + 4;
-	set_packet_header(packet_write_buffer, packet_size);
-	memcpy(packet_write_buffer + 4, buf, size);
-	if (write_in_full(fd_out, packet_write_buffer, packet_size) < 0)
+
+	set_packet_header(header, packet_size);
+
+	/*
+	 * Write the header and the buffer in 2 parts so that we do not need
+	 * to allocate a buffer or rely on a static buffer.  This avoids perf
+	 * and multi-threading issues.
+	 */
+
+	if (write_in_full(fd_out, header, 4) < 0 ||
+	    write_in_full(fd_out, buf, size) < 0)
 		return error(_("packet write failed"));
 	return 0;
 }
@@ -242,19 +250,21 @@ void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len)
 	packet_trace(data, len, 1);
 }
 
-int write_packetized_from_fd(int fd_in, int fd_out)
+int write_packetized_from_fd(int fd_in, int fd_out,
+			     struct packet_scratch_space *scratch)
 {
-	static char buf[LARGE_PACKET_DATA_MAX];
 	int err = 0;
 	ssize_t bytes_to_write;
 
 	while (!err) {
-		bytes_to_write = xread(fd_in, buf, sizeof(buf));
+		bytes_to_write = xread(fd_in, scratch->buffer,
+				       sizeof(scratch->buffer));
 		if (bytes_to_write < 0)
 			return COPY_READ_ERROR;
 		if (bytes_to_write == 0)
 			break;
-		err = packet_write_gently(fd_out, buf, bytes_to_write);
+		err = packet_write_gently(fd_out, scratch->buffer,
+					  bytes_to_write);
 	}
 	if (!err)
 		err = packet_flush_gently(fd_out);
diff --git a/pkt-line.h b/pkt-line.h
index 8c90daa59ef0..c0722aefe638 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -5,6 +5,13 @@
 #include "strbuf.h"
 #include "sideband.h"
 
+#define LARGE_PACKET_MAX 65520
+#define LARGE_PACKET_DATA_MAX (LARGE_PACKET_MAX - 4)
+
+struct packet_scratch_space {
+	char buffer[LARGE_PACKET_DATA_MAX]; /* does not include header bytes */
+};
+
 /*
  * Write a packetized stream, where each line is preceded by
  * its length (including the header) as a 4-byte hex number.
@@ -32,7 +39,7 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((f
 void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len);
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
-int write_packetized_from_fd(int fd_in, int fd_out);
+int write_packetized_from_fd(int fd_in, int fd_out, struct packet_scratch_space *scratch);
 int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
 
 /*
@@ -213,8 +220,7 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader);
 enum packet_read_status packet_reader_peek(struct packet_reader *reader);
 
 #define DEFAULT_PACKET_MAX 1000
-#define LARGE_PACKET_MAX 65520
-#define LARGE_PACKET_DATA_MAX (LARGE_PACKET_MAX - 4)
+
 extern char packet_buffer[LARGE_PACKET_MAX];
 
 struct packet_writer {
-- 
gitgitgadget

