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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D10C43333
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 15:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E72BC65275
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 15:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhCIPD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 10:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbhCIPCy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 10:02:54 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F285C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 07:02:54 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo6704334wmq.4
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 07:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SS6RmAcnSB5VJw5WOLHH8st7lD6Lox9WL7ROYnrwGjc=;
        b=uM3Zvf6v0shvYVwLS+1noWbQgmBiNE+mtu63toXM5iu2Cr36D+CkvPukY6A/mT2MQ8
         1hHoe3kkd7mBsljgUckSnTGiBgilb4INpbf8VoTsTwAJHnSNJ88XbWITZkVwmQBBtK+T
         luKaU/RAxF8laFccRbBdbVBMAR7I4XMKANNxIn1hMBO+OBtwL6sj3RWzFx8PZvW+xs8B
         TnXk3mhsKfATJ3vHFog8aUoVnKC7ZdD7gfzv+nFCdH5fdLE0jzX3rMr7Ftjd7Q1DW+K0
         jleYg25U1PE+qfLP/NpCcSo0fr/tk9kSCyBHa0bc747fLGo+0Rz4CT14xvV5DzsCW9c4
         i/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SS6RmAcnSB5VJw5WOLHH8st7lD6Lox9WL7ROYnrwGjc=;
        b=WVfrJX4tNGkhMxy4OYnD29EIj0ECl89lH6GoSouqo/N9z7qjIwH6lH1FNzpVF52AhA
         +T/4in85qPQ0G8mT8vYnkicDqScd3+iMsNH0sO47bHMysm2G1j2NYr240XI8AR56K2oc
         lRkWGFLk0XiJsuFua7rJm6ZqIfU5tHKKPlzWAPHYGIQyU/WW3i+ofb/RfzywFYIH4z+J
         5vhMQ5+0nevXyogyjcHa1UhEXdSotWzRMI9z3Sdy4X5YR7nCQQCWlVFKM2N2tFM1FuTZ
         vzPz+x7ZGeE4QuwdpG3nSqVyU8yczOh4ZUAzzCIXw29GP9IEZjGLiZ4uNj0YT8DRoNeN
         gAgg==
X-Gm-Message-State: AOAM5336rCm9GvysUtfreBtf65TOU3kqFmoY4RSdqUMszMui2+ckWWLP
        D9WAJQZnJE9t9zz+P2v85NrJC+TTrmE=
X-Google-Smtp-Source: ABdhPJylTcTZt0NxEmgE6rwZMisEm+ZUG7JW4LthwAewC99dNW/g9yV0/w1VkaW4K1okL5HojBdNTA==
X-Received: by 2002:a1c:3b42:: with SMTP id i63mr4588415wma.124.1615302160523;
        Tue, 09 Mar 2021 07:02:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y8sm4414660wmi.46.2021.03.09.07.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 07:02:40 -0800 (PST)
Message-Id: <25157c1f48734eb96026e0c770d24874e4bf0503.1615302157.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
References: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 15:02:27 +0000
Subject: [PATCH v5 02/12] pkt-line: do not issue flush packets in
 write_packetized_*()
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
 convert.c  | 8 ++++++--
 pkt-line.c | 8 ++------
 pkt-line.h | 4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/convert.c b/convert.c
index ee360c2f07ce..976d4905cb3a 100644
--- a/convert.c
+++ b/convert.c
@@ -884,9 +884,13 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 		goto done;
 
 	if (fd >= 0)
-		err = write_packetized_from_fd(fd, process->in);
+		err = write_packetized_from_fd_no_flush(fd, process->in);
 	else
-		err = write_packetized_from_buf(src, len, process->in);
+		err = write_packetized_from_buf_no_flush(src, len, process->in);
+	if (err)
+		goto done;
+
+	err = packet_flush_gently(process->in);
 	if (err)
 		goto done;
 
diff --git a/pkt-line.c b/pkt-line.c
index 8b3512190442..434da3a0c48d 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -250,7 +250,7 @@ void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len)
 	packet_trace(data, len, 1);
 }
 
-int write_packetized_from_fd(int fd_in, int fd_out)
+int write_packetized_from_fd_no_flush(int fd_in, int fd_out)
 {
 	char *buf = xmalloc(LARGE_PACKET_DATA_MAX);
 	int err = 0;
@@ -266,13 +266,11 @@ int write_packetized_from_fd(int fd_in, int fd_out)
 			break;
 		err = packet_write_gently(fd_out, buf, bytes_to_write);
 	}
-	if (!err)
-		err = packet_flush_gently(fd_out);
 	free(buf);
 	return err;
 }
 
-int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
+int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_out)
 {
 	int err = 0;
 	size_t bytes_written = 0;
@@ -288,8 +286,6 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
 		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write);
 		bytes_written += bytes_to_write;
 	}
-	if (!err)
-		err = packet_flush_gently(fd_out);
 	return err;
 }
 
diff --git a/pkt-line.h b/pkt-line.h
index 8c90daa59ef0..31012b9943bf 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -32,8 +32,8 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((f
 void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len);
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
-int write_packetized_from_fd(int fd_in, int fd_out);
-int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
+int write_packetized_from_fd_no_flush(int fd_in, int fd_out);
+int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_out);
 
 /*
  * Read a packetized line into the buffer, which must be at least size bytes
-- 
gitgitgadget

