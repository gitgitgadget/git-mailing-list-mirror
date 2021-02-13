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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3423C433E0
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 00:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD2664D5D
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 00:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhBMAKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 19:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhBMAKA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 19:10:00 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD1EC061756
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 16:09:19 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id x4so1370690wmi.3
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 16:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1q5FaxYK9Kc6ZuQx9j/xJ03xM7/gGqa15J7NjF8Uad8=;
        b=hTaR02SlWXIp7XBxJVIJL2ag4ds4nUaX7fJb5R4RHxg6acsVs7SH+R9zfZX7tDRbDX
         Pmt0X3cy1E/Z71m1asxUd8fjBHIewaLschTyS7M1mghKewn8isdmvnQOKR4BQ9Sk/sdY
         uwoRZ4CIU2dkx5bw/osURtaF5R24hfHjiI08bmwvvh6XN+eSdsl0UQkdzU+I5i5YL4Xt
         Q5SXqP0tU3yFZKjpV7C0euVouNMBAtiTkCD40M6vRsSgHb9MfeBlqprGZdtsRxk43b1f
         1U/e5E+LAr4tnqNKDPMPOFwYf+NSxX9SX1BJYVUYwWCEWsSyvnctfv9d/4sSGWRgJYY6
         SsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1q5FaxYK9Kc6ZuQx9j/xJ03xM7/gGqa15J7NjF8Uad8=;
        b=kYUrksBx9ohFPlAFxP77EyS/U7bs9q4lwZSkC522+gUW+IPoAXcYks7/+nOn2Yy10o
         z19WPBro3opNuz3p50CBtN2FvlMd8blBkP5PJmRmYliP4Q3a74ze8YC90T3kJ0KnUiXJ
         kDAmHOjqdUXGisq27GteE20cfhtfEBsoX3KaI7sfGQFKKy4I5vZdVNwFMUPkp3qLLVTr
         uzadFAn5eXDDbPguAnZO/8jsHNLqHB3noj4R25taCXTLgs7Qe13GxRLCRl8HTd+WNxY6
         vv57sPNgJvlL2F2AZqqHBQlzld3/HHSZXhenLquKQCqR3vUaa+c9TRndY/CotNNZkK5b
         ds+Q==
X-Gm-Message-State: AOAM532PkW0I+NRXr2AAD5sxnz9f4BW2VZLfVd+7jrVkvxSqtIBBw6cG
        T5jzSWb0j9qVg3zxkX36TOergLJxhxU=
X-Google-Smtp-Source: ABdhPJwnzufvMHQP5KbQ7A+FpqsMZjcvIzv1sKTaD7fVrD+k+W8hWqHgyrjsZ/o7QoLu0XYYqRCtAw==
X-Received: by 2002:a1c:545d:: with SMTP id p29mr4616437wmi.77.1613174957394;
        Fri, 12 Feb 2021 16:09:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i1sm1478425wmq.12.2021.02.12.16.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 16:09:17 -0800 (PST)
Message-Id: <91a9f63d66924d14a22feedf7b1d88fe298b90bc.1613174954.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
References: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
        <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Feb 2021 00:09:03 +0000
Subject: [PATCH v3 02/12] pkt-line: do not issue flush packets in
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

