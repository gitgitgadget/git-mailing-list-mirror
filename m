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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE00C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014A564E5F
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhBQVtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhBQVtf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 16:49:35 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7048DC061788
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:48:54 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id n4so61955wrx.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eKIITmcddPWeE1VBlgWVjIuBS5dmDXJSUzTRMH0h5jc=;
        b=kkAowa8TJcG8uIni/6XwhDp8Iuq3sxQqPZ1V/1cUuOvLEm37rPPznWYlqxCNtIWUZu
         MRxBfLmvBdxWQDCPrEf8HhInvtNfeJg6Y60dgFflqWbu6d7/J/hSEi0w1dEcHHM/1MSD
         q70QX+rHDgH2jfPlR4FqFnwL+PkDJgQztDbLVFTT36CXEgPIBiBEg58rf6NXq8o31Bk6
         U74Eez2s7BrYsMnpk/Opxb4hUyoKbSm+EShG4gldkbvmPS7CB7G6mreUHLpj6a7+5E73
         rIhoURYtm/WIZkbDTvmAPrks4cEU07NRaH8DcvPIRIA4BDvjWCyHls+Eo258ydJIggQz
         QSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eKIITmcddPWeE1VBlgWVjIuBS5dmDXJSUzTRMH0h5jc=;
        b=NeP+Rtl8aoRmZEFZSjiwNcCWRTMjGHy+vbvT0csQo9U/HShHgjKcQN43NtzOMMAxSE
         DCvseMSnaLxC+m2HoVSvNq3rKzL6+uuPbn9KnEf/0ZWQhozij74uNqoAkzfq+/XKydy4
         yzxlu1BuUXymXYGFiw5p8BgMgHRWnocOlAPioi87I9mlwqOzF7GPRy2cLt0IgDaS48MB
         5EGiBEzt2x625gw7areubev/8Xf9Kleq1PHMQdNnLCh2bMVULrjAhBf7mDlwKWgnhhX4
         i7s+AKM/nU6qCsOCMznRxmaz5ZzO2FRfxJoPrY367wXTrIIu95eJXYweNvWYNj0jvtiL
         MaLQ==
X-Gm-Message-State: AOAM532hnTy2r1+yKFfAk+ZS0H8NBTyet0iBU0t+yRl9buI48nA+TiUH
        dgkkmP4PaGRQNhbY6Emo7wp6m6U88zk=
X-Google-Smtp-Source: ABdhPJxp+GJYBSt72z2TJPOoP0oiltxzpcpci2uXjv9HL6MlTGvAmhkG6365aE5ktNrn57L4ojzqhQ==
X-Received: by 2002:adf:bc45:: with SMTP id a5mr1149580wrh.290.1613598533219;
        Wed, 17 Feb 2021 13:48:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y2sm4793766wmg.13.2021.02.17.13.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:48:52 -0800 (PST)
Message-Id: <81e14bed955c6b50e155f6f73cb642d6c9f2fd73.1613598529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
        <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Feb 2021 21:48:40 +0000
Subject: [PATCH v4 04/12] pkt-line: add options argument to
 read_packetized_to_strbuf()
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

Update the calling sequence of `read_packetized_to_strbuf()` to take
an options argument and not assume a fixed set of options.  Update the
only existing caller accordingly to explicitly pass the
formerly-assumed flags.

The `read_packetized_to_strbuf()` function calls `packet_read()` with
a fixed set of assumed options (`PACKET_READ_GENTLE_ON_EOF`).  This
assumption has been fine for the single existing caller
`apply_multi_file_filter()` in `convert.c`.

In a later commit we would like to add other callers to
`read_packetized_to_strbuf()` that need a different set of options.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 convert.c  | 3 ++-
 pkt-line.c | 4 ++--
 pkt-line.h | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/convert.c b/convert.c
index bccf7afa8797..9f44f00d841f 100644
--- a/convert.c
+++ b/convert.c
@@ -908,7 +908,8 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 		if (err)
 			goto done;
 
-		err = read_packetized_to_strbuf(process->out, &nbuf) < 0;
+		err = read_packetized_to_strbuf(process->out, &nbuf,
+						PACKET_READ_GENTLE_ON_EOF) < 0;
 		if (err)
 			goto done;
 
diff --git a/pkt-line.c b/pkt-line.c
index 83c46e6b46ee..18ecad65e08c 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -442,7 +442,7 @@ char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
 	return packet_read_line_generic(-1, src, src_len, dst_len);
 }
 
-ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
+ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out, int options)
 {
 	int packet_len;
 
@@ -458,7 +458,7 @@ ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
 			 * that there is already room for the extra byte.
 			 */
 			sb_out->buf + sb_out->len, LARGE_PACKET_DATA_MAX+1,
-			PACKET_READ_GENTLE_ON_EOF);
+			options);
 		if (packet_len <= 0)
 			break;
 		sb_out->len += packet_len;
diff --git a/pkt-line.h b/pkt-line.h
index 2e472efaf2c5..e347fe46832a 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -142,7 +142,7 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
 /*
  * Reads a stream of variable sized packets until a flush packet is detected.
  */
-ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out);
+ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out, int options);
 
 /*
  * Receive multiplexed output stream over git native protocol.
-- 
gitgitgadget

