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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAB4C433E6
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 00:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CED664D5D
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 00:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhBMAKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 19:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhBMAKA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 19:10:00 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08772C061786
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 16:09:19 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id n8so1316706wrm.10
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 16:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eKIITmcddPWeE1VBlgWVjIuBS5dmDXJSUzTRMH0h5jc=;
        b=lnJVM0a5BdC+Qi1SMa83Rdckn7NWG/hPBm6/vsLcDpm6Pnj6pN9c+1jiZYx7mH+9mv
         wIIMsoCw35YmhuiRD8a0Kf49m76xg70LqQ8lEkEX2/3zudBOo3gMzV/GshPh3ubkaH2I
         6q2cXR1r6Vn2M/rt2KhDEh5ETuqDDj/sM/rfkVcZPAf2wnzx6ziISqj/wWTm1bkBDx8u
         A3M+y5wgAE61rtdmRtwjQghCiIcGVCAvxfOgU38T2LXTfCXrnTZAKqgFTjK7EASA3145
         fHtnuBJBsx7+nfkm15Cps/8fjbncz4HJdqEVSvQjAqoaNGCXY9Bb4dVjVGz5hSyesHXT
         jaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eKIITmcddPWeE1VBlgWVjIuBS5dmDXJSUzTRMH0h5jc=;
        b=N7uhmB3kh+K7wcV2198FwdLoEqkfC2an8pMLqSD0V2yc7npSin9RX6TyG4MyVu7+5p
         Nxl+ujg4b2ahFBv4bH9IzAdrx5m+eaHbGuaGOcz1sksFQl5Fzf6dWn15PfV6lUsdY4et
         y5bvL1ApPGZMspFwK6X3j4/0sEpGu0TaYSCBh4CPEF9c7koAp6ita4Skh0aBSjVp9pKB
         5cEFMvHs781qElW3hKSABsRFBuFrRQ86gYwJRdQWYiY2MVGfu9eWDpZn2BSRmbnWhycb
         4u968t0TfQAtW5UgPcEJJ1cRG3JUIdglj3SJ+q6m/QKu1pvSubkj38SguebVTGtBmVcD
         xcHw==
X-Gm-Message-State: AOAM5323vynsNCqmceix5ZUtiTGengvnWuG9lda/lPE/WMALjNIBc9oH
        ZmgUFQZM/GSXb2d4H7hAbf7ogwlWG7s=
X-Google-Smtp-Source: ABdhPJyWUc7fV/JimDM7ex0pEZc4in16d5vOGXBa7UwnIzn9mwMNlIHhSrHvHVeMc+pExIqm0SL/jw==
X-Received: by 2002:a5d:61d0:: with SMTP id q16mr6161981wrv.387.1613174958578;
        Fri, 12 Feb 2021 16:09:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7sm12302185wrn.11.2021.02.12.16.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 16:09:18 -0800 (PST)
Message-Id: <81e14bed955c6b50e155f6f73cb642d6c9f2fd73.1613174954.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
References: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
        <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Feb 2021 00:09:05 +0000
Subject: [PATCH v3 04/12] pkt-line: add options argument to
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

