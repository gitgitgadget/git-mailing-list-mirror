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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DCFC43381
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9083A64EC4
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhBATr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbhBATqg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 14:46:36 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C705C06178A
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 11:45:56 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j18so342870wmi.3
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 11:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Pbcu3sqHNuJHcnom8abmYvjSL2+3Cp3JrBKFE8pxB10=;
        b=QlKnE8jSqPHTdqAsLnUDubeV0IHkpPiEOBrz8fna554HSH3Bsdga1Fr2YY7OMWSqGf
         ekTZcLYPYED5I/EAOXMKXwqHRPJehL635oATwnyvNg4lVDX+BBDlxRWFs87wZF93pGVx
         MvMY8Esf+GeIUAmUN9ZL1vO5NuzPIex45XtKQSunk+0M8iHZF9wxAdP7mXQDKJCahT/m
         2Jsamu50Lr/5YJzEd+ipCC4TT2V8pr8kGcq8qoWOWmQGrEWTtkZNFENqcoC8BwzE1p3p
         fcoMcDJBcIvT/w7SzmZo+hNxeqdiLlrXN6henTXDN6tnIdDNu4LElKsFeKc97dYM+ek2
         pnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Pbcu3sqHNuJHcnom8abmYvjSL2+3Cp3JrBKFE8pxB10=;
        b=gBnG9wFun2hOoDcbfcjPJyi+PYBVpb4A3yoqdTDEp5LuIlHjEDgJBtBvXUJ0HzBquH
         zCDD1PCUhW2JX7DG0s6DHrI+3rhvsosI/ckYdCD/LMPsrpvVKFUWsyeaz4G466SZi4Zl
         bbu+BpFe/QIxkr3EMRDbi566fZGON10gjI5h9/GvJm1wJ48z2gvd71HZ6YoC8+6xW1ZM
         IPsKeaxtznSy7jD5Jp1NeJj1goQucXNazr3HCeso1INWOkIRqSYUCbs+R1X5SVWoTvrr
         m0l7qs05qwmDExh8wINnpKEeCh0GJi++QSlv+pPqRpvlWapotUDtMsMB/0pW5MqjZi4z
         qt/Q==
X-Gm-Message-State: AOAM530mibAkB6OJwEz9S8FOKVFrioqo+aefpbU64hla+RUPsVBryJPB
        uUFV4tS3dQ4YPbwI/ogCIbpPUHG2e50=
X-Google-Smtp-Source: ABdhPJxkhsMLQuJ+NMlrqjI7Ip5OCPCSE8I8U82ErwnAGdy9ZWshso7D/gjrbT58D0lJH/+6Z8UlQA==
X-Received: by 2002:a1c:4c01:: with SMTP id z1mr396377wmf.159.1612208755081;
        Mon, 01 Feb 2021 11:45:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i7sm3938335wru.49.2021.02.01.11.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:45:54 -0800 (PST)
Message-Id: <6a389a3533512acedfa1769c64296c1e19b16221.1612208747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
        <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 19:45:39 +0000
Subject: [PATCH v2 06/14] pkt-line: accept additional options in
 read_packetized_to_strbuf()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
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
index 528493bca21..f090fc56eef 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -461,7 +461,7 @@ char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
 	return packet_read_line_generic(-1, src, src_len, dst_len);
 }
 
-ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
+ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out, int options)
 {
 	int packet_len;
 
@@ -477,7 +477,7 @@ ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
 			 * that there is already room for the extra byte.
 			 */
 			sb_out->buf + sb_out->len, LARGE_PACKET_DATA_MAX+1,
-			PACKET_READ_GENTLE_ON_EOF);
+			options | PACKET_READ_GENTLE_ON_EOF);
 		if (packet_len <= 0)
 			break;
 		sb_out->len += packet_len;
diff --git a/pkt-line.h b/pkt-line.h
index 7f31c892165..150319a6f00 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -145,8 +145,12 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
 
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

