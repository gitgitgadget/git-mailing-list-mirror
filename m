Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E57C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 10:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A461610E9
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 10:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbhHZKKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 06:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbhHZKKa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 06:10:30 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D3CC061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 03:09:43 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u3so4976375ejz.1
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 03:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a4w3yeW+/95eIzmS1csDT83uvsjpgObceYkw3P6sDfM=;
        b=B+JU664QXA3dZC8oidcPJw8Ru9Vrwc1qtXSIVFxbxtVuWt6J5FjvSauEvU4JzcsA/h
         JUKSY9HJNq/8Sms0F23o/ha2GFcS72A3Ks/wZ+G+VyYLQ2n1Uc7Vizr7UTKOIVspJsFy
         LXioivfvy3HG75I1wQhDh5hDfjDOeMPHw41K0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a4w3yeW+/95eIzmS1csDT83uvsjpgObceYkw3P6sDfM=;
        b=K/EpuTdk6TbBLoFAIzjL+7IZbTScMJjrq5vboCGO3Q+F9PgaiBuK7+/5y0W6DURipi
         +ZILRvk3DTJJoYDV9jH4FTA01ySHMAmfOLQ4bU8BBQCfDJvcA9/GldrCKVIwY7Mki/gF
         WhC24fWo2vYmkQJsnPREm+uOdvJNnXUUJtIpywOXDovD0yUr1bD5UESYjrVv6YWPA6G8
         otj5pJ54z10KRRsB+pwSeV3Cn/oBEbzr7wBqjQDA+J6SZ+FTrcs8GMszVtDAtUTH+20a
         /R5QVyv7veYAv08y/10YEe421VyoMI1ISy8H9NIj48GrcsW6q5Vvb5AZHnypv2ufapDV
         NGng==
X-Gm-Message-State: AOAM531iuq600YcvMlD4vD/4O8DTKkI/CGrAJJF8inuxkvBSd/VJlKnx
        4rOKnt2sxYUXMMfEk/jfMmBKN/81IPFwlg==
X-Google-Smtp-Source: ABdhPJxRZ2TXtqSn1EiQlC+1cjS2nhhpeWC8YmyjKZb43p2idGN3zersp5fcSUuGhNlmWF8TQUeH+Q==
X-Received: by 2002:a17:906:4cc1:: with SMTP id q1mr3539186ejt.415.1629972581656;
        Thu, 26 Aug 2021 03:09:41 -0700 (PDT)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id bt24sm1132649ejb.77.2021.08.26.03.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 03:09:41 -0700 (PDT)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     peff@peff.net, me@ttaylorr.com, git@vger.kernel.org,
        gitster@pobox.com, ps@pks.im
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH 1/2] pkt-line: add packet_fwrite
Date:   Thu, 26 Aug 2021 12:06:47 +0200
Message-Id: <20210826100648.10333-1-jacob@gitlab.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <CADMWQoMpURczcnZne=0cr2vavoLm_VT5eEMg4FCu3VeSg_UJaQ@mail.gmail.com>
References: <CADMWQoMpURczcnZne=0cr2vavoLm_VT5eEMg4FCu3VeSg_UJaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds a new function packet_fwrite which works like packet_write,
except it writes to a stdio stream.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
---
 cache.h        |  1 +
 pkt-line.c     | 16 ++++++++++++++++
 pkt-line.h     |  1 +
 write-or-die.c |  6 ++++++
 4 files changed, 24 insertions(+)

diff --git a/cache.h b/cache.h
index bd4869beee..fbefe0927b 100644
--- a/cache.h
+++ b/cache.h
@@ -1736,6 +1736,7 @@ extern const char *git_mailmap_blob;
 void maybe_flush_or_die(FILE *, const char *);
 __attribute__((format (printf, 2, 3)))
 void fprintf_or_die(FILE *, const char *fmt, ...);
+void fwrite_or_die(FILE *f, const void *buf, size_t count);
 
 #define COPY_READ_ERROR (-2)
 #define COPY_WRITE_ERROR (-3)
diff --git a/pkt-line.c b/pkt-line.c
index 9f63eae2e6..244b326708 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -243,6 +243,22 @@ void packet_write(int fd_out, const char *buf, size_t size)
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
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 {
 	va_list args;
diff --git a/pkt-line.h b/pkt-line.h
index 5af5f45687..c9cb5e1719 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -28,6 +28,7 @@ void packet_buf_flush(struct strbuf *buf);
 void packet_buf_delim(struct strbuf *buf);
 void set_packet_header(char *buf, int size);
 void packet_write(int fd_out, const char *buf, size_t size);
+void packet_fwrite(FILE *f, const char *buf, size_t size);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len);
 int packet_flush_gently(int fd);
diff --git a/write-or-die.c b/write-or-die.c
index d33e68f6ab..d82ef54f90 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -70,3 +70,9 @@ void write_or_die(int fd, const void *buf, size_t count)
 		die_errno("write error");
 	}
 }
+
+void fwrite_or_die(FILE *f, const void *buf, size_t count)
+{
+	if (fwrite(buf, count, 1, f) != 1)
+		die_errno("write error");
+}
-- 
2.32.0

