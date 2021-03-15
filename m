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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC559C433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 21:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A3D464F0F
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 21:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbhCOVIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 17:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhCOVId (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 17:08:33 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112DCC06175F
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 14:08:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 12so3894408wmf.5
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 14:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a/Oyk2QmXqT5S9k11Fh4Qbmn3snKM0BOK/s/suNSi68=;
        b=W266X6mKrCXDw9VQ5ofRNR3OjJaW1A/dYaPjWYgnt5/v0xKJD+cWz6VElWT9VefiC5
         bpkYjco20uGDXeQepj1IzT0OQ/uXF4mSj2FNUWjRQc+iYAotlRxy46GwBiDsaeoDBqcH
         fzKL9eCowc0yh3EAmjHeOhA7B+0/JcWXgTnY4P53hbf7Evrl/f7xs523bSKxFDSxvveL
         EUvt5Qmpv4wt+Tx2bQDeJx8fqOB9T4CLc4dZthBX8752EUPFg/KCvown0PNdIbRrazeg
         pjRNMYY9CCCqe80W/hSX+hGtom056ZBil29//r4fim58DpsJy0craZZrEqK5HOD0VK5P
         TeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a/Oyk2QmXqT5S9k11Fh4Qbmn3snKM0BOK/s/suNSi68=;
        b=CabAkpEYXQAJaeBgvMuevvokZHoKEMuuI/Kz54xdIvM+EuBJiboO7YjDblX0hBKwvO
         Q7QUCpS4AhwpRGZLNfqIs0/CGPFzomv66r1wBQeavYPQ+b7AkEbqgMsB4nqZflRTyAOL
         sjD/EWsF/5mrAr9juoTiIIYAogtwcvFQxfjk3ccb4rdikYeGUCKuF3rn7AtRBQQS1I9F
         1hhK7CXPKBgVBROKFfWLu1SvUojj/KsbLgfDhK+UCf4bXBeAovHgx43Etv9RQGdq7GvS
         IZoRkGA1UrcnLpClD5L7j3EpsaxaPZpkQL0cN/301BWv7qd0wYdcVtLsZpDbZ9FGXukx
         3/1A==
X-Gm-Message-State: AOAM530q4NO9x0QvupNH+aRxHBrL5yX2oW4NnPwNKNHI76UCx2jpgue8
        35K7MXqSE/5aQJj23fzY/7h72T4JJ5E=
X-Google-Smtp-Source: ABdhPJwuUQjHjjmdhjOoAiABh2gRFEgoA93HZz+dlaxvaTGZ9XNUleM5HnWw5IEUwXZeCBUKfxlYXQ==
X-Received: by 2002:a7b:cb90:: with SMTP id m16mr1459853wmi.162.1615842511865;
        Mon, 15 Mar 2021 14:08:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a131sm813950wmc.48.2021.03.15.14.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 14:08:31 -0700 (PDT)
Message-Id: <fe35dc3d292d0f13802f5ec646a3d4c5071920f2.1615842509.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v6.git.1615842509.gitgitgadget@gmail.com>
References: <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
        <pull.766.v6.git.1615842509.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Mar 2021 21:08:18 +0000
Subject: [PATCH v6 01/12] pkt-line: eliminate the need for static buffer in
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

