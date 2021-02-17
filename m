Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4BBC433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D763C64E5F
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhBQVts (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhBQVtd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 16:49:33 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD75C0613D6
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:48:53 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id x4so5457262wmi.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1q5FaxYK9Kc6ZuQx9j/xJ03xM7/gGqa15J7NjF8Uad8=;
        b=nPfo3+HN1WS2AgBS8M1XvjonLHTfFlVQSY5fh0kftj1SLR+a9twH1TqPGLEEoUkUzR
         n6qtD2jV+8bRfmcBekv/6DWSo0N02KyHffzfOKTQqcLvHCcQ57dky1aKuJdtNeFCVlE+
         qIEgbAW1I2YsOuwoYRUGs+AOpdEn7FaNyoDLhar/rlxaFUus23FZAB63sqMkv9lug9dS
         0oKYvgKDTkv39lVh0PjlIpmTh+zDBcHSxEswoReHO+qNKw1m6yhgiQL3lw4fmo/4kIe8
         yJWu00J6YqJ8UU2hcq+uRJS5dBL46jN2o4TuFyVRFWws5KtNVNOw2eHSiHIoXXBG2rhN
         BXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1q5FaxYK9Kc6ZuQx9j/xJ03xM7/gGqa15J7NjF8Uad8=;
        b=ixjnML40Fm7uZi5vo4btsZutsXj5VuuNTjtZGhiv7UWOXUtUwBxY1ZZXb6Pp06S176
         1iY9jA8N+Zpoks+Qx40U+jYVCnbThtsh0jAbF8xHFwjxvwihwoeh6yjW+GIu7nxa8Q8M
         ek161u3y1JPU0PAKosIwWSj10KCaw3SnXsUY3Dr5xopYxeNLQShE0+rNyzeuY4lbNONF
         tjp4mCm8w6Ma2QmRGW7nsId7ecuBmHERmfGKRyxY5hmF/bMw6ZbuvjiwY6L54EfIQAyp
         KaSSH/UQ2zbh7jw+lOa0mE/wI/rNZ9T2Qow2qYGWHecN1ZgIEOqOXRzJ+dhdYj+Sg/ZX
         WoKQ==
X-Gm-Message-State: AOAM532kDD1KTUDsAG72L6C3Ap5CNlabKxQwsBVBCpjYnIsRS4lB/3hl
        yH6sDJexQGNkhZr1wQ8rao+iLKOP3no=
X-Google-Smtp-Source: ABdhPJxBqKAhHYdZCyAS7piVuZaUCEke+OAahEYrW6LBEs+2sp5JZd233p2EqjYLI1mPqrXyWJpvkg==
X-Received: by 2002:a1c:d7:: with SMTP id 206mr756011wma.68.1613598531802;
        Wed, 17 Feb 2021 13:48:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b11sm5619379wrw.68.2021.02.17.13.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:48:51 -0800 (PST)
Message-Id: <91a9f63d66924d14a22feedf7b1d88fe298b90bc.1613598529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
        <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Feb 2021 21:48:38 +0000
Subject: [PATCH v4 02/12] pkt-line: do not issue flush packets in
 write_packetized_*()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Remove the `packet_flush_gently()` call in `write_packetized_from_buf() and
`write_packetized_from_fd()` and require the caller to call it if desired.
Rename both functions to `write_packetized_from_*_no_flush()` to prevent
later merge accidents.

`write_packetized_from_buf()` currently only has one caller:
`apply_multi_file_filter()` in `convert.c`.  It always wants a flush packet
to be written after writing the payload.

However, we are about to introduce a caller that wants to write many
packets before a final flush packet, so let's make the caller responsible
for emitting the flush packet.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 convert.c  |  8 ++++++--
 pkt-line.c | 10 +++-------
 pkt-line.h |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/convert.c b/convert.c
index 41012c2d301c..bccf7afa8797 100644
--- a/convert.c
+++ b/convert.c
@@ -885,9 +885,13 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 
 	if (fd >= 0) {
 		struct packet_scratch_space scratch;
-		err = write_packetized_from_fd(fd, process->in, &scratch);
+		err = write_packetized_from_fd_no_flush(fd, process->in, &scratch);
 	} else
-		err = write_packetized_from_buf(src, len, process->in);
+		err = write_packetized_from_buf_no_flush(src, len, process->in);
+	if (err)
+		goto done;
+
+	err = packet_flush_gently(process->in);
 	if (err)
 		goto done;
 
diff --git a/pkt-line.c b/pkt-line.c
index 4cff2f7a68a5..3602b0d37092 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -250,8 +250,8 @@ void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len)
 	packet_trace(data, len, 1);
 }
 
-int write_packetized_from_fd(int fd_in, int fd_out,
-			     struct packet_scratch_space *scratch)
+int write_packetized_from_fd_no_flush(int fd_in, int fd_out,
+				      struct packet_scratch_space *scratch)
 {
 	int err = 0;
 	ssize_t bytes_to_write;
@@ -266,12 +266,10 @@ int write_packetized_from_fd(int fd_in, int fd_out,
 		err = packet_write_gently(fd_out, scratch->buffer,
 					  bytes_to_write);
 	}
-	if (!err)
-		err = packet_flush_gently(fd_out);
 	return err;
 }
 
-int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
+int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_out)
 {
 	int err = 0;
 	size_t bytes_written = 0;
@@ -287,8 +285,6 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
 		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write);
 		bytes_written += bytes_to_write;
 	}
-	if (!err)
-		err = packet_flush_gently(fd_out);
 	return err;
 }
 
diff --git a/pkt-line.h b/pkt-line.h
index c0722aefe638..a7149429ac35 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -39,8 +39,8 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((f
 void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len);
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
-int write_packetized_from_fd(int fd_in, int fd_out, struct packet_scratch_space *scratch);
-int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
+int write_packetized_from_fd_no_flush(int fd_in, int fd_out, struct packet_scratch_space *scratch);
+int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_out);
 
 /*
  * Read a packetized line into the buffer, which must be at least size bytes
-- 
gitgitgadget

