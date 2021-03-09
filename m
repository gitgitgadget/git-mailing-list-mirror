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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E57AC433E9
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 15:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C65C865285
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 15:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhCIPCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 10:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbhCIPCo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 10:02:44 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079CFC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 07:02:44 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u14so16252759wri.3
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 07:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pmUXaavv7FyrYbfOAaazVw9zi9ECyGMcN9P5XFP1SSY=;
        b=vQm/bDEoWR2/U1SSTRb+prClvqNQ5NFnXHRbnPJhCOnMX03MqeJzR4IqXqXaiM4BTZ
         L20n8d/85BZYjIz0ISVox3yhTy8leVI5NHKCjmWinnOjRdCqGN0epjM+BoE/nuG9W/Il
         Dde2m7JSpk01a+EcXrO0NHYTfZoKmGv1nLdKAddXsnOUTNhQikQULETaMTQ9QCjfNTU0
         llvnWE2SQY4OZb9Cu4A25227o1YdkMwHozhJvbpQzK8B8GmoqSdS/Y+EswllXnNe5rb/
         N685EpkgS8lPirlQmhRUC4lok0eX2mIgHqQOmYN8vhf/h4wrczaPLUY4WqgFtOL/KiF5
         /H5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pmUXaavv7FyrYbfOAaazVw9zi9ECyGMcN9P5XFP1SSY=;
        b=H7rfLkaXhZDxaKTD9qymxRHVGtXqYN5vvH3ShrQvQlAF4633AejVdGrlftMB9BSHji
         usn+Iv5MKpXwkY//13LGC25fljyJvdDRO6mVMKwzrzZYaMU2SKMqM9H0GMys2qZD+Iz1
         h9WivcN28U+yalAiPEivIZVnnHczXhnma4wCgPfDT/ab1ZNeN6S9sl6lDccHAwBKr/EI
         lKFGAADr6DnTCzPi6ruftEueGOA13zG3mavQaXSJr9Q4TRVCkznwW6zBkTS2at5BknEX
         5toQFWA8lG3GY0AmsFA7JdyC3MQqFOu+6AulZLtY2PmuNfT7LSO1gwLNOKuTo7XNyzqt
         WERw==
X-Gm-Message-State: AOAM532eJZ3TQX0p5OIcB5A8GyyCczokVaxZP4r/AeuGr5SP23XhFsGR
        GZg9uYQTjJ/J2YxOTV6/bMbuBbRVCS8=
X-Google-Smtp-Source: ABdhPJxF3rxZTL//CcO0gobw2lalpui0BHV/PZHPuPL4ibrmhXvfjBdVLNao4By/mYR4kJAvPZ32ag==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr28585263wrn.174.1615302159658;
        Tue, 09 Mar 2021 07:02:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm27200071wrm.36.2021.03.09.07.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 07:02:39 -0800 (PST)
Message-Id: <311ea4a5cd71c5dd2407348ad4608d2f7dd77ce5.1615302157.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
References: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 15:02:26 +0000
Subject: [PATCH v5 01/12] pkt-line: eliminate the need for static buffer in
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
 pkt-line.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index d633005ef746..8b3512190442 100644
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
@@ -244,20 +252,23 @@ void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len)
 
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

