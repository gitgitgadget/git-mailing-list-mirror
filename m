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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84646C433E9
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B99B23132
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391389AbhALPcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 10:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391374AbhALPcT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 10:32:19 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47537C06179F
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 07:31:39 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q18so2944892wrn.1
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 07:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bSCUea5G8SFvOYZSySp3ABiRylFxJviLeyQ8NHRCvPk=;
        b=UjZqes7x93kFuU1CxLckpjdSoWbUBK0OwnEgQuN9VJ5IYm2+HK4bIiWcRYAI9NEYZv
         koK2PH8LzlYLSt2lYbJhYvvdsylZLDFcmndl+3HOCovqUHGBBSNTaHIpCgzpYYFWMLGX
         sn9I+uO6dMEYWIPmA8yvvsOzN4kVya2cGx0wvg6SvXHriZrZY3wN/HAHyvNUm1QIdjAZ
         YnQrYU/PrbU74WNkQerYvbeaw3Pfez5lIq08flKuUngilSB8bAifo5HonKFy2nU59xvd
         FtDxD0PieKCE5AVCDIaIXUztqfl/ZtUMfpG7LzFBtNbUifZfnaEqhvnF3/x66UQJNUjq
         NTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bSCUea5G8SFvOYZSySp3ABiRylFxJviLeyQ8NHRCvPk=;
        b=pB7ZaBB4NYYyVyCB1rWGrCg3qCzIU3PuhY9oBb/ZTB1hp3nYFuFjWk8A9erZKzzk7s
         3fhIXi5F9QSOd2exvurpOH+d0JPg+gOwoEXWEne/q1iyK6ztViypipy2DjO0f2Fhc3ne
         s+Hfa1FI21iARsBwHXTdyVOqP08v3bu+MVl/RzDT2gBK+b3DO4aQxMdqJZPA5inSpP3a
         emkF56Qbivwnn0bcwejVes9iWF1fnol7IRQ9t6pjjz6h1IiTbEejx/M1H74FtdZrWiDK
         LdZRbxqxwdtb1QDlPXguRTUfgUp5nxkrN8p95JxChbGRS6vGUwwWJd7Vw2bm7r57lSuJ
         O0iQ==
X-Gm-Message-State: AOAM531JpN2y3mRwg7NuaMj+coq1VbCX4+pp8RTBNI/3PXs83YaT9wxs
        edpiUI5QRViPD8lnhf2ZZIFeTnhJRt0=
X-Google-Smtp-Source: ABdhPJy2OYFPZbNQ91NDK8zAGkXxXYrn8m/6UqI8lTVr+sxWatBffymk1AbCHm5SxJeCkrhTmBVV/w==
X-Received: by 2002:adf:f6cc:: with SMTP id y12mr4898376wrp.35.1610465497892;
        Tue, 12 Jan 2021 07:31:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a62sm4034353wmf.7.2021.01.12.07.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 07:31:37 -0800 (PST)
Message-Id: <2f399ac107c40f6fc71805d3dc4f2d602a33c074.1610465493.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.git.1610465492.gitgitgadget@gmail.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 15:31:26 +0000
Subject: [PATCH 04/10] pkt-line: accept additional options in
 read_packetized_to_strbuf()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `read_packetized_to_strbuf()` function reads packets into a strbuf
until a flush packet has been received. So far, it has only one caller:
`apply_multi_file_filter()` in `convert.c`. This caller really only
needs the `PACKET_READ_GENTLE_ON_EOF` option to be passed to
`packet_read()` (which makes sense in the scenario where packets should
be read until a flush packet is received).

We are about to introduce a caller that wants to pass other options
through to `packet_read()`, so let's extend the function signature
accordingly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 convert.c  | 2 +-
 pkt-line.c | 4 ++--
 pkt-line.h | 6 +++++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/convert.c b/convert.c
index 3f396a9b288..175c5cd51d5 100644
--- a/convert.c
+++ b/convert.c
@@ -903,7 +903,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 		if (err)
 			goto done;
 
-		err = read_packetized_to_strbuf(process->out, &nbuf) < 0;
+		err = read_packetized_to_strbuf(process->out, &nbuf, 0) < 0;
 		if (err)
 			goto done;
 
diff --git a/pkt-line.c b/pkt-line.c
index ef83439b9ee..615211819cd 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -437,7 +437,7 @@ char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
 	return packet_read_line_generic(-1, src, src_len, dst_len);
 }
 
-ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
+ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out, int options)
 {
 	int packet_len;
 
@@ -453,7 +453,7 @@ ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
 			 * that there is already room for the extra byte.
 			 */
 			sb_out->buf + sb_out->len, LARGE_PACKET_DATA_MAX+1,
-			PACKET_READ_GENTLE_ON_EOF);
+			options | PACKET_READ_GENTLE_ON_EOF);
 		if (packet_len <= 0)
 			break;
 		sb_out->len += packet_len;
diff --git a/pkt-line.h b/pkt-line.h
index 5b7a0fb8510..02554a20a6c 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -135,8 +135,12 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
 
 /*
  * Reads a stream of variable sized packets until a flush packet is detected.
+ *
+ * The options are augmented by PACKET_READ_GENTLE_ON_EOF and passed to
+ * packet_read.
  */
-ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out);
+ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out,
+				  int options);
 
 /*
  * Receive multiplexed output stream over git native protocol.
-- 
gitgitgadget

