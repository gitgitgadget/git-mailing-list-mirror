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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C96AC433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 531EF64E7A
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhBQVtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhBQVtc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 16:49:32 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73777C061756
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:48:52 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o82so3671175wme.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vUaX6CJSvvP6EgiP8l7AT1SqEY7jKOaixGCmCkgRPvs=;
        b=CSHj9lnyDEW6qHMc7/eyIBkfLzBhMOx6zNiUun8E09WOBogC/oHTHLSXeCbJem++Ve
         s8YaxgeKJrFQoBX5YXTih1W/2TdGrNqE137aIBISRnCMwYjO4/YyPZQ1lsuQd9au02Ak
         Lb8s6EgEf1Ooj/olR3kastQEFT44i8vGT5Pb9TCNPfxBOnnjMp5JA7h8d1j0bAn6EA3H
         QjlTRdESufvCKPpyO0aGq/nxH9TO48ER8OTTN9lHaHA3dX2byHG3+uHIqioXGFCUGS/M
         bPILNIQSo7wH9/FLkBucMYfADCL4E9RxNfkzTnSkXQNSFCSe7uokoi8gqpQORHm+dyn9
         rmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vUaX6CJSvvP6EgiP8l7AT1SqEY7jKOaixGCmCkgRPvs=;
        b=HEEHBmIvNgtVjRUIGCTLR9fRGGH+iDA/hRufPpFzXgc1rjnKIpT5kHLFcARNMA5AB6
         5WxxFperONukI36p1Xgwv1OoZnW+Kpt7m3uzhxw3HNenVrYYIPoa53y7vyjicoyFHFvc
         6uNhjcWxaWWKvO1RswEZ3+4tG5imaZHQQlYjgS+YXakuO+ha2JCxZ8RWqY1GZhrS2BH4
         2nVRS4EV/JM3wZV/iC4v6N9SXouJ0yrvP2gCxpg+FHRytvl6pjSo78kR8ppjAKpehCv0
         TDFMipaZ/xeKkltVI9ceo6FoxLiqg2KYMGvHLZpMIrGDb4cw+/o2el3J8IhJOh3gfgDl
         vr7Q==
X-Gm-Message-State: AOAM532STtzu4SRB6Q6AqsYETCerCD0dU82V4UnzjqJC35ynlt+GX4b1
        RZa77Jk8D/4Okif8T9++KbZbO+VMJB4=
X-Google-Smtp-Source: ABdhPJzTg+EhI/7Dcm2kddCAuWVh1kf9zsJXkuyortRQbDoSryN0AvEY1uLRAq5q6Ix9sNMBEyt1Hg==
X-Received: by 2002:a05:600c:c6:: with SMTP id u6mr720842wmm.176.1613598531143;
        Wed, 17 Feb 2021 13:48:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q15sm5932800wrr.58.2021.02.17.13.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:48:50 -0800 (PST)
Message-Id: <2d6858b1625aa3c96688c6c6a9157c2d2b16f43e.1613598529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
        <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Feb 2021 21:48:37 +0000
Subject: [PATCH v4 01/12] pkt-line: eliminate the need for static buffer in
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

