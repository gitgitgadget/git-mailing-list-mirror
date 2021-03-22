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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E8BC433E4
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 10:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B73F619A3
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 10:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhCVKac (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 06:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCVK3y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 06:29:54 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56A0C061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 03:29:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j18so16082397wra.2
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 03:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/wnX5m6bv462aJ4/n7oQX2gdwOtnSjSdlOa61NW87Yg=;
        b=KhRBn5DRkrNIBgem+0E4DqkhXgIDHgVV42XHxQVZX2j+3zLGMY2nye+Cn/x70d7IOY
         MyT+rYSS0SY4M2OxP1bpOTFMcefnQaEQ4JYmPpwGssi6zOEuBYJh2behb9c7PFEH+V2p
         u3DqPGoSiqdRuGw+oKq/uiNovTT+uH9gfnvGRpjFhq5BxgY1EicbBH7k843WBo9Ac69e
         i2EV/UVnGiC/EjjZnipWbm7JkpQOCeVspzYvAp0GNZ+r2Ss3R2BZxeT7vB8UhII7lS+T
         BG1KJVJufYACZ9z6bW4BI3kJrINkPnBZ6PpZOXegLCSx1LghvW5bnJMyHVO98bzJvn2w
         zUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/wnX5m6bv462aJ4/n7oQX2gdwOtnSjSdlOa61NW87Yg=;
        b=n0PtnbRAGybMCUyIxufOKgXRuMQVcSVjJPyk+0aaC9Df4FMVTG+k2TE6KwkblEmGWB
         8e4QWZPc6uo2ynp+kx0oVgcEkrB2mT1PQNbttdcFHKnfl2CDyYFPgauttZlG8dC2JcRZ
         7z1ldG9d664ruJnQ0i33mnUjrlKfM9Kn0U33rgXn6BvreCzv3VXkaugcJSN4hHDetQAn
         C/tPRsin5EXbM7crY7mzgAtxEb0jRya3DGn7/AsFjYt7ekJEr9RF4xEiQQWn1qHfMNCH
         l3xYxAJfp97SmgUIrpfKD0sb4S6APwLmAGTQ3nzoI+zff+/cdPqQULTu2TMDdk7I9Fqb
         y5UA==
X-Gm-Message-State: AOAM531wXL46uEwt6O4Q1bxBIbpzdUcxKT/6UddCUpFMkIc3iMtpiDAv
        KrRCreDmt19dHmK9Ci0dKXoqZyU425w=
X-Google-Smtp-Source: ABdhPJypnICLzfDCK/tjiUzHezHvamdaNmm8A5gE9Nq1sG/xIWsaAmdMhwz1WA3YWypJ1odKfe0FDQ==
X-Received: by 2002:a5d:6dcc:: with SMTP id d12mr17031676wrz.136.1616408992726;
        Mon, 22 Mar 2021 03:29:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm22231829wrw.63.2021.03.22.03.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:29:52 -0700 (PDT)
Message-Id: <de11b3036148104308b22a1af39fbdaa5f54b296.1616408989.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v7.git.1616408989.gitgitgadget@gmail.com>
References: <pull.766.v6.git.1615842509.gitgitgadget@gmail.com>
        <pull.766.v7.git.1616408989.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Mar 2021 10:29:38 +0000
Subject: [PATCH v7 02/12] pkt-line: do not issue flush packets in
 write_packetized_*()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Chris Torek <chris.torek@gmail.com>,
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
 convert.c  | 8 ++++++--
 pkt-line.c | 8 ++------
 pkt-line.h | 4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/convert.c b/convert.c
index ee360c2f07ce..976d4905cb3a 100644
--- a/convert.c
+++ b/convert.c
@@ -884,9 +884,13 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 		goto done;
 
 	if (fd >= 0)
-		err = write_packetized_from_fd(fd, process->in);
+		err = write_packetized_from_fd_no_flush(fd, process->in);
 	else
-		err = write_packetized_from_buf(src, len, process->in);
+		err = write_packetized_from_buf_no_flush(src, len, process->in);
+	if (err)
+		goto done;
+
+	err = packet_flush_gently(process->in);
 	if (err)
 		goto done;
 
diff --git a/pkt-line.c b/pkt-line.c
index 66bd0ddfd1d0..bb0fb0c3802c 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -251,7 +251,7 @@ void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len)
 	packet_trace(data, len, 1);
 }
 
-int write_packetized_from_fd(int fd_in, int fd_out)
+int write_packetized_from_fd_no_flush(int fd_in, int fd_out)
 {
 	char *buf = xmalloc(LARGE_PACKET_DATA_MAX);
 	int err = 0;
@@ -267,13 +267,11 @@ int write_packetized_from_fd(int fd_in, int fd_out)
 			break;
 		err = packet_write_gently(fd_out, buf, bytes_to_write);
 	}
-	if (!err)
-		err = packet_flush_gently(fd_out);
 	free(buf);
 	return err;
 }
 
-int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
+int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_out)
 {
 	int err = 0;
 	size_t bytes_written = 0;
@@ -289,8 +287,6 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
 		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write);
 		bytes_written += bytes_to_write;
 	}
-	if (!err)
-		err = packet_flush_gently(fd_out);
 	return err;
 }
 
diff --git a/pkt-line.h b/pkt-line.h
index 8c90daa59ef0..31012b9943bf 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -32,8 +32,8 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((f
 void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len);
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
-int write_packetized_from_fd(int fd_in, int fd_out);
-int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
+int write_packetized_from_fd_no_flush(int fd_in, int fd_out);
+int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_out);
 
 /*
  * Read a packetized line into the buffer, which must be at least size bytes
-- 
gitgitgadget

