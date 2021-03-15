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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F75C433E9
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 21:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80D6964F46
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 21:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhCOVIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 17:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhCOVIf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 17:08:35 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D902DC06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 14:08:34 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id d191so8896222wmd.2
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 14:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iwMQ+JSvS6tvCRXxs4LuTI2qdYUXF8krnXVw3yWlkS0=;
        b=kFamE2HXjzz6l7v0j15nC7KpceqY3nLOtgKLAwLq4lnst2amRtug7tExO+pYvBKAOp
         SCyBfkKvcC/SBDwWzhobfD2JeAHdtgaAmG5OF1nidSP0RGl0KV1I0pjRlE50LB4vrqmC
         5GCqMVW0NTPiFN8EN5Ezy0JdLGEi02gqhtC/7MtE4RDEGCVb/d83fqR4iqnvK87NrWnz
         mxKEhiCWMYssWurolXsGnNe4NQnPGLCzvXz2WwQ8NdQ2hzXxvZEvC87/4NYyIvC3AVqm
         EyvpBFciQjsh+cwvyAZ9lyn0ZgP99JYHIGFn3S7bnWUbZ1y+5iEVhXaaSfKwDsypVSD/
         gNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iwMQ+JSvS6tvCRXxs4LuTI2qdYUXF8krnXVw3yWlkS0=;
        b=E7gho6oOHKX9zGiZE15Xo5l2yflpPOMuehuZlkArTZVfXhymjonSwxnlLxmlu5gGbU
         93w5rIlyS+1QyhVu6VhxelvJ+KNuwVCSnmXB07klRhjYo0JxFYe2E2jZP3JX2tPocNIT
         DqP2y+6A0aV8/nqIjRexwtnvc5rQuia/lKpP52s64WgMaMb68tTU823h6KSenSqarubp
         77eNvxomf6YtnRjDxdd8IIj1wWD3FRWeZob8RvBCt9Uc/ssxRnjT0heK3WwM726aXFCx
         0RouIwff17hZiomBTv+RTApP2BPxrz3+xuAbzOhTQP/QJdOtDAoKBeDQlO8TE6r0rtNM
         PY/A==
X-Gm-Message-State: AOAM530l8h2LSODz72qJOVXgf8f1KIaAFetHnS+0sQ6n7mZxdItvx2MF
        ruiT/iJvuvhMUy1nMq4dFMrGe8e5nA0=
X-Google-Smtp-Source: ABdhPJxOtUnlLZ2YIIsUNvdyx6zTNXNbHeHIBy/wiZsX9ypLftrVJ7I276z4SnwFnU8PxwBjjMJKJA==
X-Received: by 2002:a1c:65c2:: with SMTP id z185mr1516446wmb.2.1615842513625;
        Mon, 15 Mar 2021 14:08:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2sm20573629wrq.34.2021.03.15.14.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 14:08:33 -0700 (PDT)
Message-Id: <b43df7ad0b7a8afb686baf166a118432305154ba.1615842510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v6.git.1615842509.gitgitgadget@gmail.com>
References: <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
        <pull.766.v6.git.1615842509.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Mar 2021 21:08:21 +0000
Subject: [PATCH v6 04/12] pkt-line: add options argument to
 read_packetized_to_strbuf()
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
index 976d4905cb3a..516f1095b06e 100644
--- a/convert.c
+++ b/convert.c
@@ -907,7 +907,8 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 		if (err)
 			goto done;
 
-		err = read_packetized_to_strbuf(process->out, &nbuf) < 0;
+		err = read_packetized_to_strbuf(process->out, &nbuf,
+						PACKET_READ_GENTLE_ON_EOF) < 0;
 		if (err)
 			goto done;
 
diff --git a/pkt-line.c b/pkt-line.c
index 457ac4e151bb..0194137528c3 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -444,7 +444,7 @@ char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
 	return packet_read_line_generic(-1, src, src_len, dst_len);
 }
 
-ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
+ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out, int options)
 {
 	int packet_len;
 
@@ -460,7 +460,7 @@ ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
 			 * that there is already room for the extra byte.
 			 */
 			sb_out->buf + sb_out->len, LARGE_PACKET_DATA_MAX+1,
-			PACKET_READ_GENTLE_ON_EOF);
+			options);
 		if (packet_len <= 0)
 			break;
 		sb_out->len += packet_len;
diff --git a/pkt-line.h b/pkt-line.h
index 80ce0187e2ea..5af5f4568768 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -136,7 +136,7 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
 /*
  * Reads a stream of variable sized packets until a flush packet is detected.
  */
-ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out);
+ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out, int options);
 
 /*
  * Receive multiplexed output stream over git native protocol.
-- 
gitgitgadget

