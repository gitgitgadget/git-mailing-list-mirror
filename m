Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F15C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 09:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25AC660F12
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 09:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbhHaJgW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 05:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhHaJgU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 05:36:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C811AC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 02:35:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id dm15so25808526edb.10
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 02:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1GvsfGnDEHDyJjNqpJCyfdmpKOhY5fJIwe9Gm521Pzg=;
        b=Biz0aK3ycdZ3CvCSRN/clZpA0e1VkI7GNU7Bj0o0iy8Ln118yMKQG8U8wUZa49HNte
         4K4GxYj4dth/amgNWhiRngJubZ85izWCQK+QieHTfLGYs6ERyYfE8hOZzJipH5Pb5YUg
         0m1dBDaP89mKd9vs0BV3GRovfo2AewRiO4EYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1GvsfGnDEHDyJjNqpJCyfdmpKOhY5fJIwe9Gm521Pzg=;
        b=nRua12x08oPY27P3rqBdzWVo4ofn9A1y8/cK95LKt8b4sdv7kp9IwdfOlBSBPhLF+O
         sii5Dhlt84A0s3GkyodMx47AYjs02UCUkDb2oHAvghgF7yrpiGNZ/UceDGn4crSY8cNt
         smdyarl8TT9Dd/ro/ggISKNJq5Ghc+5+/nz0m5XiQMxxesq0g4G8GU9IcTVqRlIdjgd8
         Og4e84//cC4BQQSIuuyuGqCxmQJcpcVvKRYmuNGgNHvuMA4sIV6lF2zSK4it4NsJuM3A
         I2xS+J1jWiSzLRLXhiEtjtpCkk7V9I+oVwg2XBjm/EmUU7e2suPvH2xDxz6xv2n220Oh
         UeDA==
X-Gm-Message-State: AOAM532tX4MHR1m50RZTdzrkRbq1cIw9Xdqd6KOMeqil9YikZ0gbsOdq
        f5g/gFM/EHxyxc5eW6EEsn2agQ==
X-Google-Smtp-Source: ABdhPJw03Ld1pnuTeS6e9PfC7jO1qAj1XROuweF+zcqPWnzq6PZqLdCVJDJ5FjbWSdAEgCCKWNXSqQ==
X-Received: by 2002:a05:6402:d6f:: with SMTP id ec47mr28376457edb.95.1630402522984;
        Tue, 31 Aug 2021 02:35:22 -0700 (PDT)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id n15sm9000318edw.70.2021.08.31.02.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 02:35:22 -0700 (PDT)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     gitster@pobox.com, peff@peff.net, me@ttaylorr.com,
        git@vger.kernel.org, ps@pks.im
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH v3 1/2] pkt-line: add stdio packet write functions
Date:   Tue, 31 Aug 2021 11:34:43 +0200
Message-Id: <20210831093444.28199-2-jacob@gitlab.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210831093444.28199-1-jacob@gitlab.com>
References: <xmqqbl5ic19t.fsf@gitster.g>
 <20210831093444.28199-1-jacob@gitlab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds three new functions to pkt-line.c: packet_fwrite,
packet_fwrite_fmt and packet_fflush. Besides writing a pktline flush
packet, packet_fflush also flushes the stdio buffer of the stream.

Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
---
 cache.h        |  2 ++
 pkt-line.c     | 37 +++++++++++++++++++++++++++++++++++++
 pkt-line.h     | 11 +++++++++++
 write-or-die.c | 12 ++++++++++++
 4 files changed, 62 insertions(+)

diff --git a/cache.h b/cache.h
index bd4869beee..dcf2454c3b 100644
--- a/cache.h
+++ b/cache.h
@@ -1736,6 +1736,8 @@ extern const char *git_mailmap_blob;
 void maybe_flush_or_die(FILE *, const char *);
 __attribute__((format (printf, 2, 3)))
 void fprintf_or_die(FILE *, const char *fmt, ...);
+void fwrite_or_die(FILE *f, const void *buf, size_t count);
+void fflush_or_die(FILE *f);
 
 #define COPY_READ_ERROR (-2)
 #define COPY_WRITE_ERROR (-3)
diff --git a/pkt-line.c b/pkt-line.c
index 9f63eae2e6..de4a94b437 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -243,6 +243,43 @@ void packet_write(int fd_out, const char *buf, size_t size)
 		die("%s", err.buf);
 }
 
+void packet_fwrite(FILE *f, const char *buf, size_t size)
+{
+	size_t packet_size;
+	char header[4];
+
+	if (size > LARGE_PACKET_DATA_MAX)
+		die(_("packet write failed - data exceeds max packet size"));
+
+	packet_trace(buf, size, 1);
+	packet_size = size + 4;
+
+	set_packet_header(header, packet_size);
+	fwrite_or_die(f, header, 4);
+	fwrite_or_die(f, buf, size);
+}
+
+void packet_fwrite_fmt(FILE *fh, const char *fmt, ...)
+{
+       static struct strbuf buf = STRBUF_INIT;
+       va_list args;
+
+       strbuf_reset(&buf);
+
+       va_start(args, fmt);
+       format_packet(&buf, "", fmt, args);
+       va_end(args);
+
+       fwrite_or_die(fh, buf.buf, buf.len);
+}
+
+void packet_fflush(FILE *f)
+{
+	packet_trace("0000", 4, 1);
+	fwrite_or_die(f, "0000", 4);
+	fflush_or_die(f);
+}
+
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 {
 	va_list args;
diff --git a/pkt-line.h b/pkt-line.h
index 5af5f45687..0a38a68d15 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -35,6 +35,17 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format
 int write_packetized_from_fd_no_flush(int fd_in, int fd_out);
 int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_out);
 
+/*
+ * Stdio versions of packet_write functions. When mixing these with fd
+ * based functions, take care to call fflush or packet_fflush before
+ * doing fd writes or closing the fd.
+ */
+void packet_fwrite(FILE *f, const char *buf, size_t size);
+void packet_fwrite_fmt(FILE *f, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+
+/* packet_fflush writes a flush packet and flushes the stdio buffer of f */
+void packet_fflush(FILE *f);
+
 /*
  * Read a packetized line into the buffer, which must be at least size bytes
  * long. The return value specifies the number of bytes read into the buffer.
diff --git a/write-or-die.c b/write-or-die.c
index d33e68f6ab..7a2f84e2ee 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -70,3 +70,15 @@ void write_or_die(int fd, const void *buf, size_t count)
 		die_errno("write error");
 	}
 }
+
+void fwrite_or_die(FILE *f, const void *buf, size_t count)
+{
+	if (fwrite(buf, count, 1, f) != 1)
+		die_errno("fwrite error");
+}
+
+void fflush_or_die(FILE *f)
+{
+	if (fflush(f))
+		die_errno("fflush error");
+}
-- 
2.32.0

