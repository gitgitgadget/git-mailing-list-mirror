Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F349C432C3
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F5D164F6D
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbhCDUSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238871AbhCDUSL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 15:18:11 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2F5C061760
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 12:17:30 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o2so10403100wme.5
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 12:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S3vMbr7sXGxNc3QwnwhgIQUEMCfjPHLMGes9bBUrxPc=;
        b=O03dUvA/z5cYeJ1XqJMSyDe87c37yaw9F3DLXjOeOfTvuay+jUqUJsWYVuzxblXWNo
         JZXrKtidraGDH9CVYEbC1ZuSwAAXGKV1cYs4S0g1n6wdQ9u1RsbFWp4iFJOgVShZi9d2
         SUGUfnI7QyuPoK1HgYQOS2fkIceLYPKBfJRuqHtLyejvHtb9+COo2hUojkkEMhsO1ZpR
         67bhgXZgg+VjsRNvV07wWOXOjuvboqBAnJ++N62dsXrWE1aXMilB0mO35gY4BEHkbS6y
         SEUuh2ks8QLTj3ECOMggIqc+S5XoLRXxTFb2Oofjmi52ig+JNb99uKsVYqQ5lxja4r0z
         /zAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S3vMbr7sXGxNc3QwnwhgIQUEMCfjPHLMGes9bBUrxPc=;
        b=WjNCCDoORpiNbe85Q7lVRAL7G6OkzM8H33xOBYInjrs7VQjgpU7dp3ZH+v4CDOSX6G
         fjRAJgSIyvnqxd5XqsFQd69d3oBFShBlijk7oAqKJ25Vy7KVKmeijyA7ro3qMWOQTPtu
         FYb0KbIHAbLXOOVJiR+PPvEd9GV4RJwrALmcndkKk6LsG6AyDTjxepLOEyizDMq0vioB
         ap31bF77gp92yzVtun1ZfEJm/G+m9g4okCXtmfYEzHzOZpn2zpC/9AJVu2nVkbPYHceA
         vCHIaga/SzMCSbMSP6YLVtnFLUN9plhu6HEBgBy/K6rZtjpti+OfFHOln7CurrgbNVp8
         qXfg==
X-Gm-Message-State: AOAM530MJad6AIveaLYY7alsDnwUlaDltGD67RN9rXR7AGaRKFVZFIUt
        JHncU4F2eHw3cq07P8dOgl1GS+zS9sY=
X-Google-Smtp-Source: ABdhPJwaqzIEudOBvvqSxfHPF5LdPS+ktqOjnyDUhvt7VIHsquzkzFqd+pE6NX2G6ox27LWhZU+euw==
X-Received: by 2002:a1c:318b:: with SMTP id x133mr5605426wmx.154.1614889049410;
        Thu, 04 Mar 2021 12:17:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i3sm561922wra.66.2021.03.04.12.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 12:17:29 -0800 (PST)
Message-Id: <d6ea7688dfb2536312b627f7ed47ff7f42091f60.1614889047.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.893.git.1614889047.gitgitgadget@gmail.com>
References: <pull.893.git.1614889047.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Mar 2021 20:17:20 +0000
Subject: [PATCH 1/8] pkt-line: remove buffer arg from
 write_packetized_from_fd_no_flush()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Remove the scratch buffer argument from `write_packetized_from_fd_no_flush()`
and allocate a temporary buffer within the function.

In 3e4447f1ea (pkt-line: eliminate the need for static buffer in
packet_write_gently(), 2021-02-13) we added the argument in order to
get rid of a static buffer to make the routine safe in multi-threaded
contexts and to avoid putting a very large buffer on the stack.  This
delegated the problem to the caller who has more knowledge of the use
case and can best decide the most efficient way to provide such a
buffer.

However, in practice, the (currently, only) caller just created the
buffer on the stack, so we might as well just allocate it within the
function and restore the original API.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 convert.c  |  7 +++----
 pkt-line.c | 19 +++++++++++--------
 pkt-line.h |  6 +-----
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/convert.c b/convert.c
index 9f44f00d841f..516f1095b06e 100644
--- a/convert.c
+++ b/convert.c
@@ -883,10 +883,9 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	if (err)
 		goto done;
 
-	if (fd >= 0) {
-		struct packet_scratch_space scratch;
-		err = write_packetized_from_fd_no_flush(fd, process->in, &scratch);
-	} else
+	if (fd >= 0)
+		err = write_packetized_from_fd_no_flush(fd, process->in);
+	else
 		err = write_packetized_from_buf_no_flush(src, len, process->in);
 	if (err)
 		goto done;
diff --git a/pkt-line.c b/pkt-line.c
index 18ecad65e08c..c933bb95586d 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -250,22 +250,25 @@ void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len)
 	packet_trace(data, len, 1);
 }
 
-int write_packetized_from_fd_no_flush(int fd_in, int fd_out,
-				      struct packet_scratch_space *scratch)
+int write_packetized_from_fd_no_flush(int fd_in, int fd_out)
 {
 	int err = 0;
 	ssize_t bytes_to_write;
+	char *buf = xmalloc(LARGE_PACKET_DATA_MAX);
 
 	while (!err) {
-		bytes_to_write = xread(fd_in, scratch->buffer,
-				       sizeof(scratch->buffer));
-		if (bytes_to_write < 0)
-			return COPY_READ_ERROR;
+		bytes_to_write = xread(fd_in, buf, LARGE_PACKET_DATA_MAX);
+		if (bytes_to_write < 0) {
+			err = COPY_READ_ERROR;
+			break;
+		}
 		if (bytes_to_write == 0)
 			break;
-		err = packet_write_gently(fd_out, scratch->buffer,
-					  bytes_to_write);
+		err = packet_write_gently(fd_out, buf, bytes_to_write);
 	}
+
+	free(buf);
+
 	return err;
 }
 
diff --git a/pkt-line.h b/pkt-line.h
index e347fe46832a..54eec72dc0af 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -8,10 +8,6 @@
 #define LARGE_PACKET_MAX 65520
 #define LARGE_PACKET_DATA_MAX (LARGE_PACKET_MAX - 4)
 
-struct packet_scratch_space {
-	char buffer[LARGE_PACKET_DATA_MAX]; /* does not include header bytes */
-};
-
 /*
  * Write a packetized stream, where each line is preceded by
  * its length (including the header) as a 4-byte hex number.
@@ -39,7 +35,7 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((f
 void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len);
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
-int write_packetized_from_fd_no_flush(int fd_in, int fd_out, struct packet_scratch_space *scratch);
+int write_packetized_from_fd_no_flush(int fd_in, int fd_out);
 int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_out);
 
 /*
-- 
gitgitgadget

