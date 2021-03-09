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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E845C4321A
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 15:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 561A465243
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 15:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhCIPDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 10:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhCIPC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 10:02:56 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACC2C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 07:02:55 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l22so2271805wme.1
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 07:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JrdLG9DDE9Ey8zhfz5XO6em3Et4AbBQeVSVWWN+CJU0=;
        b=vajWjFp8nR6dk5xoHiWoaOYooEfE/qVR38XeWWtfPoZEmv5twm+Loxe7olcma7IYv/
         i0tBfGfTPL1YCWaNfyi0pO7MD++hgYpxcyr3/9JKNKa16oYQaKBK2ZdbruvtHJXLuYBR
         MJ3DUPLLMxCN/ZG/wvTmJQZzvHfC7qIadGEig68AftD7wxy6aYo5lceFywRzCuZXo/al
         i5oQhVQWsi+j7+SPLE4m6jDUX36gsDlNgvhLmNn6zSZNCaDMkYHS4dEaFZLsprENieGK
         sefrH9+YthgJmqvLXa30BbyBr58CFCzBBDyfIdLVeMjLwhQ0RjpGwPc3R9qgIOjMS5t4
         pXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JrdLG9DDE9Ey8zhfz5XO6em3Et4AbBQeVSVWWN+CJU0=;
        b=ZNTp3e2Mb9os1Fv0f+IqKtp4XkvuGV4ANFfUaTD9Vt8cPYt814ONtc15Km+4R8PK/4
         1hBXyUDRfjA/r+PzyVaxwkxtI0BkOo1vKVrLL1zYcZsKV2EpFFpmHtI45rsP+hU6Tc+9
         LVEmwMNdDTTxU7YpnNathNBVJ7F3CcoGePJHLII2nxu95QalBCc4a7fK7XO75hNGvTnm
         cQWRE3CZ9p36Y5yf8dRDsnDhmRR61F+hI3nEg3aq0JsjRV4fsReVrGKdewIAw9Tw8GEA
         kaoH132L5f2OsPMCOmaz6f9Ri9u4xv/jdu8Mpbo+/6bTHmngOJ3iNFm39ABGmjvw1DXy
         PCsQ==
X-Gm-Message-State: AOAM530c42a2ZewOD0WsCviCsrYUkbsCdzsTOtXb4KfAsm3wxpeE0U5F
        oOB5fvUlgk6jH+n0stHeu6FLygNrGhs=
X-Google-Smtp-Source: ABdhPJzPLHlg/eShs3/+6rXb+sCcyFZGYIyTt7rZGJVBJAuBb/OwTe6WuAmv8TRV5WzukhU39tr2dg==
X-Received: by 2002:a1c:c206:: with SMTP id s6mr4448059wmf.77.1615302169619;
        Tue, 09 Mar 2021 07:02:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 3sm27534030wry.72.2021.03.09.07.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 07:02:49 -0800 (PST)
Message-Id: <b73e66a69b61d5787511ae20826e58459fabee0c.1615302157.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
References: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 15:02:29 +0000
Subject: [PATCH v5 04/12] pkt-line: add options argument to
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
index 22775e37a72b..695ea37b9d30 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -443,7 +443,7 @@ char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
 	return packet_read_line_generic(-1, src, src_len, dst_len);
 }
 
-ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
+ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out, int options)
 {
 	int packet_len;
 
@@ -459,7 +459,7 @@ ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
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

