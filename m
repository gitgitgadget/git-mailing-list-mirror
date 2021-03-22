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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC61C433E9
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 10:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 833A7619BB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 10:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhCVKae (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 06:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhCVK3z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 06:29:55 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD7EC061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 03:29:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id d191so9158759wmd.2
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 03:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iwMQ+JSvS6tvCRXxs4LuTI2qdYUXF8krnXVw3yWlkS0=;
        b=vfgXSYJfzLIMAKPosVZ10qI/BP1Y8iYXrGCqJwUA3EpgT3IQFj0UBnmdLdgvf15SPz
         Nr9qrVQn2Uvq+2RC84N4h0w2M9j7Ev+7kOM6KgBvl0UJ1gYT+FuqHVcrUKo/zE/vxPTY
         7uxsQ7Ng5pP9ho7x3BWXUcNJv1YGL3X22Q0/h89PWsDEp4ofNFTwDFqf6NuZbJs8n6a/
         fEIkAKctyryorSW8sIzG3x5bfzMoYaBzNCdEYYLYPMbu8ziwryNX5khEnG72vu5g7HDU
         AOKKl7aazqMlcSv9Aq9+0c74t07m5TD1FGqc92phLRLYTCjVgXBI/LrXcJEja51lq1/y
         cH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iwMQ+JSvS6tvCRXxs4LuTI2qdYUXF8krnXVw3yWlkS0=;
        b=OvT2L3PEZ0EYDhhdwFceuuAfbUGyZ8ufCDh+L6a5iSZwzVGbfGw02Pr1bpDanRfcgd
         +j9BcZYVk9dNdlAc8jRMGWDQt5icBuDu9g6YZoxwqVlabws0Ib8kRIK3T2QkJpdZrXVR
         jeAyNjTlmiYu7lcfv0JDFpRsPq0Y7ZPkrZCrtW5kdrtyQlJRE5EduBa+iCfVToGzCqBq
         IEAnnfCdqq3FL/I2SOazrTzyOj5J6e/Xauk8u1ylbASxLMssyZZIdyQtrOUVKGlfdCTU
         2nOWc4WEea+R/6Wdsk5Vj//3x0Sotn3N21S4A7b+fR0mghohS8RZWfkumeuhzKwMUlzA
         nlJQ==
X-Gm-Message-State: AOAM53162+qLZMRB1Kgjvpu5OPj5DJGsXJUYKFr7GX180ziKq7QTVIoC
        jNpWnTwWoMedASidjx66G7uqJLQs0ak=
X-Google-Smtp-Source: ABdhPJyjMfO3xyg9Y4LTzzvYigNgkc38CC4hRLTtCUui/CzyPyO7Eom68FciWb7VuTTGB6IPXWktwg==
X-Received: by 2002:a1c:a5c7:: with SMTP id o190mr15527362wme.172.1616408994076;
        Mon, 22 Mar 2021 03:29:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3sm15793180wmd.21.2021.03.22.03.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:29:53 -0700 (PDT)
Message-Id: <b43df7ad0b7a8afb686baf166a118432305154ba.1616408989.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v7.git.1616408989.gitgitgadget@gmail.com>
References: <pull.766.v6.git.1615842509.gitgitgadget@gmail.com>
        <pull.766.v7.git.1616408989.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Mar 2021 10:29:40 +0000
Subject: [PATCH v7 04/12] pkt-line: add options argument to
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

