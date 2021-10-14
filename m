Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06942C433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC70161108
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhJNURX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 16:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbhJNURW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 16:17:22 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC120C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 13:15:16 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g193-20020a1c20ca000000b0030d55f1d984so602886wmg.3
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 13:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mZr+CvY/o6XV9+9qCQGHumCt9fO+SoLDIJLrMTn0tlQ=;
        b=lGI7iHwFDdARWHl0Qncib/ojUR3Lq17zNdO/G2u35Tuqhmu4wmlHjCHhjXXDoQDg/Z
         29O+/BJFOiLo+9FYRvLqaWTVKxNX/3eIk62XrQPR7HDmEEsFPE9gnunmibbgmLQ/w1c6
         qbjNC2nlAS8GXNe+3QMM1NOse/u1VW99WsscknDfsnJwFosJexHS1aBzT/ExJNN7nXc1
         jfxQV1snuUNWDZQVKW2mN5DMcB/xAKPMwDJUlwn/K1QuJuZbObfaXZsixUCVf3qB9nB3
         Raar8FZ/5rhojTohKS54JcbF/GfYBegFiYsYsKC8WWrSZk51kd6R5UNsvztBJIbqKctK
         fZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mZr+CvY/o6XV9+9qCQGHumCt9fO+SoLDIJLrMTn0tlQ=;
        b=QkACMWawTJD3IMSi9mWeoWWlNncUHZ4ljADw7lbeakDyPUA+m/7biroqXA1mLF0vst
         m3VKMsZiSpNT6DJpnbdkZj86EM9lwpDUJtC9KMalIKKyxQSQYXL73LXNnEPruosfhKCj
         gAcMovVSbkS2Vpx0IPHCKWoDswy+80b7RWFXVM9EWlVxNKq9xMtCLtHxfW3jN82oZJs/
         EZKdRs/5u7WMtqrSToW5fndeeojvNBfvP+V+qnBoO16RFsNnF6yGWIemzVi8nb4jiSzS
         aJJ2pVBUVzPCzJo/6YNNbC0HxcgXOQmGjEdfdBVFfg1KPnSt1GPqSozNaK7D4Bf/fWp6
         25lw==
X-Gm-Message-State: AOAM5326si7GV2H493/kcogP3Xgct7/Np1IdM17S9s1abkHaJgTvYSpi
        6oVE6zhXHCzDHzW76txWfxOyN4UADVHQig==
X-Google-Smtp-Source: ABdhPJwN+OM15cPfwNCDOgXYaSGcItctXAMSPAohu9cPc+c2l2lWCmIVYxMexlY97CIRGdf9VGfF/A==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr8269738wmj.146.1634242515300;
        Thu, 14 Oct 2021 13:15:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b19sm9199265wmb.1.2021.10.14.13.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 13:15:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] pkt-line.[ch]: remove unused packet_buf_write_len()
Date:   Thu, 14 Oct 2021 22:15:11 +0200
Message-Id: <patch-1.2-4e90690af51-20211014T201317Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-0.2-00000000000-20211014T201317Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211014T201317Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function was added in f1f4d8acf40 (pkt-line: add
packet_buf_write_len function, 2018-03-15) for use in
0f1dc53f45d (remote-curl: implement stateless-connect command,
2018-03-15).

In a97d00799a1 (remote-curl: use post_rpc() for protocol v2 also,
2019-02-21) that only user of it went away, let's remove it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 pkt-line.c | 16 ----------------
 pkt-line.h |  1 -
 2 files changed, 17 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index de4a94b437e..11e1adc872b 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -289,22 +289,6 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 	va_end(args);
 }
 
-void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len)
-{
-	size_t orig_len, n;
-
-	orig_len = buf->len;
-	strbuf_addstr(buf, "0000");
-	strbuf_add(buf, data, len);
-	n = buf->len - orig_len;
-
-	if (n > LARGE_PACKET_MAX)
-		die(_("protocol error: impossibly long line"));
-
-	set_packet_header(&buf->buf[orig_len], n);
-	packet_trace(data, len, 1);
-}
-
 int write_packetized_from_fd_no_flush(int fd_in, int fd_out)
 {
 	char *buf = xmalloc(LARGE_PACKET_DATA_MAX);
diff --git a/pkt-line.h b/pkt-line.h
index 82b95e4bdd3..beb589a8593 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -29,7 +29,6 @@ void packet_buf_delim(struct strbuf *buf);
 void set_packet_header(char *buf, int size);
 void packet_write(int fd_out, const char *buf, size_t size);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
-void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len);
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int write_packetized_from_fd_no_flush(int fd_in, int fd_out);
-- 
2.33.1.1338.g20da966911a

