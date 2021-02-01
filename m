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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D4CC433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 614AD64ECA
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhBATtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbhBATqc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 14:46:32 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6142C0613D6
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 11:45:52 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id c12so17947673wrc.7
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 11:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pSbgX86qfVOFV+DYuqgTNYqm4NtxhzBOQZKnL/QDvHQ=;
        b=s0B3P3HvFLOT4xe+ivSV3jbEs6SBNToylxkOuNjYRgOWDZDv/3H+DHFJU0HD/VCk4l
         Fq1MIRDJieFN8wRxPmTC8QeNIVbkWO+//pidjjnpMokTVuoJv6C3kUKV46Riq9AYfy5v
         IbKYqi/cXlXd0dF2f2Sz7FeKhAOi2QPnO8JvxwV0f9omHzSK57nwMSgJHi+y6KqN6Ma1
         6zIXhvJTPtKOwt/a07jDB+ECpnPT03h8v7pgOGOl7FmrHKpKTzvpcjAkJlU7dm4oF5GW
         3ZgXDbHRg7hV8PhFUw6Rga26mjNNYPyU+pGmjhGLrS0s2B2nEuzXManJPgUKo/BBSOjB
         fyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pSbgX86qfVOFV+DYuqgTNYqm4NtxhzBOQZKnL/QDvHQ=;
        b=suMWKdpj56pRHmvs9Op8z8DD1mUxD2sZlU+w4erVDXC7XCI+jV6OH1xRsSgud2T6uT
         Eb0AHf5zKvX/C4MjRuzd7mLONV5CTp6N548v278wV7jpMzFLT74hadAlv0x3YHFud+xH
         7b3IiQIN+Lk5pa9KKIaBOsTIea2l64M7Ewa1ursSstMMxYWdt8qkFoX7ZlkgSIgw5erI
         9gAWodGqSh6q6U2OmEnZpahXrEtDgzTsMNZbb0Jwx1YcAUnFnfbiuH3m6wdMzZpKxXfd
         4/UivRB/IApsXvk+ZxcJHwp0HkfQrPt5hwecdcE79cS2s90QfcmzrsChCcGCgwS3PsTV
         7BCA==
X-Gm-Message-State: AOAM530Qw3J4aZgcrCoHBB47JCj9SlyfyEmXZlJ/mR9madV6U+iUeOC8
        9PQem6WYzMo+hS3dj5+8cYz0UwY2aCk=
X-Google-Smtp-Source: ABdhPJwm5mvFDCnMghsa5wRlMJRcYtY0zlTIp8ECCpgeLFNyNg1bSnXy6CXDp2zUEqZ9KqccRlggOw==
X-Received: by 2002:adf:e38d:: with SMTP id e13mr19454044wrm.231.1612208751399;
        Mon, 01 Feb 2021 11:45:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h207sm320409wme.18.2021.02.01.11.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:45:50 -0800 (PST)
Message-Id: <3b03a8ff7a72c101f82a685cc6f34a5dd37a9c4b.1612208747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
        <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 19:45:35 +0000
Subject: [PATCH v2 02/14] pkt-line: promote static buffer in
 packet_write_gently() to callers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Move the static buffer used in `packet_write_gently()` to its callers.
This is a first step to make packet writing more thread-safe.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 pkt-line.c | 33 ++++++++++++++++++++++++---------
 pkt-line.h | 10 ++++++++--
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index d633005ef74..14af049cd9c 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -194,26 +194,34 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 	return status;
 }
 
-static int packet_write_gently(const int fd_out, const char *buf, size_t size)
+/*
+ * Use the provided scratch space to build a combined <hdr><buf> buffer
+ * and write it to the file descriptor (in one write if possible).
+ */
+static int packet_write_gently(const int fd_out, const char *buf, size_t size,
+			       struct packet_scratch_space *scratch)
 {
-	static char packet_write_buffer[LARGE_PACKET_MAX];
 	size_t packet_size;
 
-	if (size > sizeof(packet_write_buffer) - 4)
+	if (size > sizeof(scratch->buffer) - 4)
 		return error(_("packet write failed - data exceeds max packet size"));
 
 	packet_trace(buf, size, 1);
 	packet_size = size + 4;
-	set_packet_header(packet_write_buffer, packet_size);
-	memcpy(packet_write_buffer + 4, buf, size);
-	if (write_in_full(fd_out, packet_write_buffer, packet_size) < 0)
+
+	set_packet_header(scratch->buffer, packet_size);
+	memcpy(scratch->buffer + 4, buf, size);
+
+	if (write_in_full(fd_out, scratch->buffer, packet_size) < 0)
 		return error(_("packet write failed"));
 	return 0;
 }
 
 void packet_write(int fd_out, const char *buf, size_t size)
 {
-	if (packet_write_gently(fd_out, buf, size))
+	static struct packet_scratch_space scratch;
+
+	if (packet_write_gently(fd_out, buf, size, &scratch))
 		die_errno(_("packet write failed"));
 }
 
@@ -244,6 +252,12 @@ void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len)
 
 int write_packetized_from_fd(int fd_in, int fd_out)
 {
+	/*
+	 * TODO We could save a memcpy() if we essentially inline
+	 * TODO packet_write_gently() here and change the xread()
+	 * TODO to pass &buf[4].
+	 */
+	static struct packet_scratch_space scratch;
 	static char buf[LARGE_PACKET_DATA_MAX];
 	int err = 0;
 	ssize_t bytes_to_write;
@@ -254,7 +268,7 @@ int write_packetized_from_fd(int fd_in, int fd_out)
 			return COPY_READ_ERROR;
 		if (bytes_to_write == 0)
 			break;
-		err = packet_write_gently(fd_out, buf, bytes_to_write);
+		err = packet_write_gently(fd_out, buf, bytes_to_write, &scratch);
 	}
 	if (!err)
 		err = packet_flush_gently(fd_out);
@@ -263,6 +277,7 @@ int write_packetized_from_fd(int fd_in, int fd_out)
 
 int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
 {
+	static struct packet_scratch_space scratch;
 	int err = 0;
 	size_t bytes_written = 0;
 	size_t bytes_to_write;
@@ -274,7 +289,7 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
 			bytes_to_write = len - bytes_written;
 		if (bytes_to_write == 0)
 			break;
-		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write);
+		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write, &scratch);
 		bytes_written += bytes_to_write;
 	}
 	if (!err)
diff --git a/pkt-line.h b/pkt-line.h
index 8c90daa59ef..4ccd6f88926 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -5,6 +5,13 @@
 #include "strbuf.h"
 #include "sideband.h"
 
+#define LARGE_PACKET_MAX 65520
+#define LARGE_PACKET_DATA_MAX (LARGE_PACKET_MAX - 4)
+
+struct packet_scratch_space {
+	char buffer[LARGE_PACKET_MAX];
+};
+
 /*
  * Write a packetized stream, where each line is preceded by
  * its length (including the header) as a 4-byte hex number.
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

