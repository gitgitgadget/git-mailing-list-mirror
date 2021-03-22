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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8084C433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 10:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 746AD6198E
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 10:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhCVK3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 06:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhCVK3x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 06:29:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD1FC061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 03:29:53 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c8so3161526wrq.11
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 03:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a/Oyk2QmXqT5S9k11Fh4Qbmn3snKM0BOK/s/suNSi68=;
        b=rm36yxNqqVlHCTcIG4dsFpPqFAzbYO2fHwaW8ZH1RETKGoBVTjvH/SaY/Ac0/KmCV9
         09dCFg3CGNE8/X4OS8OebPJveI4i1kxS7+gZ5pEy5uNgL6hIEnRW05xmyICKOD7EKRon
         oxBATVPsaRHigfsGXlZjQGeQXxeEaumjTYWh8ABKdIqsJGDVver8yHd1XsPaYA8Vy7cG
         l0tWKYvk7cFHZnk2parAlfzxAUUo9eNhg/68V0tzh6/2IhHlJt3RhvI5OytYSOyqV8Zz
         pPW4qJAkWFv6BtjogOWtZLzTogghPgKM+Lz6n/HshL4sB91rJ7SuZ2NbxPG+i15Cw0cX
         T/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a/Oyk2QmXqT5S9k11Fh4Qbmn3snKM0BOK/s/suNSi68=;
        b=kFyuGJOP5i4gNzpEAXkKW0IcYld2PlDu0IIRfjS5O+wrsd+bmGgPHsM9pUgnlNmu2x
         Y8p5OMI3jBSqN187JR2j90HzTK1gPBXVbRmoPta7R2FiAG9Xo5QjQ90C0F1qeCD3hxf4
         qxzTHdQCqcon04p8druQ+OvouOPvP8c3r3PT6X4JeL/fkbS11+g3N+xfFWypRyEfNR6B
         l5lX1Hi08W8DDlw1nTUI+ZVJcYRiefLwZ5A55unXgzQxDSnRsNcVIECjccvKnyX5CBZh
         ++JrYtbJT/JSt7dbas7zw226gWPOykEs/QDJEbfjHXUAEyVOKngCyP768fTFBMxR6DUA
         aKKQ==
X-Gm-Message-State: AOAM532Xc9OFmKcwsVmpSEiq8xYsAaRFXaq7wDmJJF4CC7DWFcdpL9y/
        9kGoSLXgr4dOAidtzr9hXZao3F1pjXo=
X-Google-Smtp-Source: ABdhPJzSEXBxSdt4J0f0hiTJX6JCTodiE9l273l7XvW4efHp+IQXC9/FjLPRPSXskAKIES6r1JXgOw==
X-Received: by 2002:adf:cd8c:: with SMTP id q12mr17097722wrj.185.1616408992077;
        Mon, 22 Mar 2021 03:29:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h20sm15476085wmp.38.2021.03.22.03.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:29:51 -0700 (PDT)
Message-Id: <fe35dc3d292d0f13802f5ec646a3d4c5071920f2.1616408989.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v7.git.1616408989.gitgitgadget@gmail.com>
References: <pull.766.v6.git.1615842509.gitgitgadget@gmail.com>
        <pull.766.v7.git.1616408989.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Mar 2021 10:29:37 +0000
Subject: [PATCH v7 01/12] pkt-line: eliminate the need for static buffer in
 packet_write_gently()
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
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach `packet_write_gently()` to write the pkt-line header and the actual
buffer in 2 separate calls to `write_in_full()` and avoid the need for a
static buffer, thread-safe scratch space, or an excessively large stack
buffer.

Change `write_packetized_from_fd()` to allocate a temporary buffer rather
than using a static buffer to avoid similar issues here.

These changes are intended to make it easier to use pkt-line routines in
a multi-threaded context with multiple concurrent writers writing to
different streams.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 pkt-line.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index d633005ef746..66bd0ddfd1d0 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -196,17 +196,26 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 
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
+	 * Write the header and the buffer in 2 parts so that we do
+	 * not need to allocate a buffer or rely on a static buffer.
+	 * This also avoids putting a large buffer on the stack which
+	 * might have multi-threading issues.
+	 */
+
+	if (write_in_full(fd_out, header, 4) < 0 ||
+	    write_in_full(fd_out, buf, size) < 0)
 		return error(_("packet write failed"));
 	return 0;
 }
@@ -244,20 +253,23 @@ void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len)
 
 int write_packetized_from_fd(int fd_in, int fd_out)
 {
-	static char buf[LARGE_PACKET_DATA_MAX];
+	char *buf = xmalloc(LARGE_PACKET_DATA_MAX);
 	int err = 0;
 	ssize_t bytes_to_write;
 
 	while (!err) {
-		bytes_to_write = xread(fd_in, buf, sizeof(buf));
-		if (bytes_to_write < 0)
+		bytes_to_write = xread(fd_in, buf, LARGE_PACKET_DATA_MAX);
+		if (bytes_to_write < 0) {
+			free(buf);
 			return COPY_READ_ERROR;
+		}
 		if (bytes_to_write == 0)
 			break;
 		err = packet_write_gently(fd_out, buf, bytes_to_write);
 	}
 	if (!err)
 		err = packet_flush_gently(fd_out);
+	free(buf);
 	return err;
 }
 
-- 
gitgitgadget

