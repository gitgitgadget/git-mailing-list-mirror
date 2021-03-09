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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417A2C43332
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 15:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C7E650DF
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 15:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhCIPD2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 10:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbhCIPCz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 10:02:55 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C68C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 07:02:55 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso6704413wmi.0
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 07:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5iUwlmdX8LXpS0HooM0hDGi+2CF4uiaU2OaAw/pCke8=;
        b=NNLLPl9MBv5LLs+KznbiSI3tZMsjyfXSQ8PAu+RiZW1pgzSOMVIEiZyC1v4G26ejFU
         jZZRSKMJhm5Ufc2Chv0yEbFhVxCWelZ5jvuvKqMGFypVpHvKNlRzKSZOjroOXoc1vRDD
         JcJEb1ZNg/Byu1wbhp80W/oBHbsCoCTqHi6N3Ss2JMGuTH9nvYoq44lNMh54pPL9vZ/1
         F0yXd/tuuWpKrKjpIX5dKPxV7wWcECP3tnifv87gH+w86y4b9xacMh3uuR7eEBYw+d5H
         9hCC27WjYHpiSa/d6w1JHkIfQygGLJxDb71/lQswmjLgiU+pGubq9rd3iMoWhA1qoQ1E
         lr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5iUwlmdX8LXpS0HooM0hDGi+2CF4uiaU2OaAw/pCke8=;
        b=VgzDhUhSej8Et1bnWYMNwHHJnVGOfKRwzub3ab6SubRTMbN+sHF8p20OKu8Cz7hgy4
         99dFTs5zCYgjQLT6FyWnsqz829xKC5J05R2EA34IIX6RLxUjmRQwgTPf6TRqFcSDoUpV
         xQUn0uI8NxCyczRArvF5PhdvUHg/qg+GQxumvD67R80AdwxR9fR5R5p2MwnX3qKXQVnt
         dlm7YqMJRBvqkS15yEmNl7yhGZ4zUaf4Qjgucc6BWSnTB7xe33OMvTI9vowDwcbHBdys
         QrK6Us8A7ULy3u/KZdBtPzf1nn0OahHzOrDAB8SX1A234pl0tXzrgOy4uBO22ZYbNaLf
         7TnA==
X-Gm-Message-State: AOAM530d9p2doWnrj35MgdUEcuzmKnLmfsuqqWila0AQZ0BO+rAxu9pM
        wgMwIsPmVj3FsA9G0APL/+pNi+ZcWRo=
X-Google-Smtp-Source: ABdhPJySwSpNkwsdyLiwYC4573sbL8ci4fdPeRncRABQ4MTQMfwS5tO0vY8/1O8pxNuHNxEhB46FKw==
X-Received: by 2002:a1c:6309:: with SMTP id x9mr4518798wmb.62.1615302169054;
        Tue, 09 Mar 2021 07:02:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7sm24194941wrs.42.2021.03.09.07.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 07:02:48 -0800 (PST)
Message-Id: <af3d13113bc983d78baf10f6d17e54625e13f832.1615302157.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
References: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 15:02:28 +0000
Subject: [PATCH v5 03/12] pkt-line: add PACKET_READ_GENTLE_ON_READ_ERROR
 option
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

Introduce PACKET_READ_GENTLE_ON_READ_ERROR option to help libify the
packet readers.

So far, the (possibly indirect) callers of `get_packet_data()` can ask
that function to return an error instead of `die()`ing upon end-of-file.
However, random read errors will still cause the process to die.

So let's introduce an explicit option to tell the packet reader
machinery to please be nice and only return an error on read errors.

This change prepares pkt-line for use by long-running daemon processes.
Such processes should be able to serve multiple concurrent clients and
and survive random IO errors.  If there is an error on one connection,
a daemon should be able to drop that connection and continue serving
existing and future connections.

This ability will be used by a Git-aware "Builtin FSMonitor" feature
in a later patch series.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 pkt-line.c | 19 +++++++++++++++++--
 pkt-line.h | 11 ++++++++---
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 434da3a0c48d..22775e37a72b 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -305,8 +305,11 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 		*src_size -= ret;
 	} else {
 		ret = read_in_full(fd, dst, size);
-		if (ret < 0)
+		if (ret < 0) {
+			if (options & PACKET_READ_GENTLE_ON_READ_ERROR)
+				return error_errno(_("read error"));
 			die_errno(_("read error"));
+		}
 	}
 
 	/* And complain if we didn't get enough bytes to satisfy the read. */
@@ -314,6 +317,8 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 		if (options & PACKET_READ_GENTLE_ON_EOF)
 			return -1;
 
+		if (options & PACKET_READ_GENTLE_ON_READ_ERROR)
+			return error(_("the remote end hung up unexpectedly"));
 		die(_("the remote end hung up unexpectedly"));
 	}
 
@@ -342,6 +347,9 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 	len = packet_length(linelen);
 
 	if (len < 0) {
+		if (options & PACKET_READ_GENTLE_ON_READ_ERROR)
+			return error(_("protocol error: bad line length "
+				       "character: %.4s"), linelen);
 		die(_("protocol error: bad line length character: %.4s"), linelen);
 	} else if (!len) {
 		packet_trace("0000", 4, 0);
@@ -356,12 +364,19 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 		*pktlen = 0;
 		return PACKET_READ_RESPONSE_END;
 	} else if (len < 4) {
+		if (options & PACKET_READ_GENTLE_ON_READ_ERROR)
+			return error(_("protocol error: bad line length %d"),
+				     len);
 		die(_("protocol error: bad line length %d"), len);
 	}
 
 	len -= 4;
-	if ((unsigned)len >= size)
+	if ((unsigned)len >= size) {
+		if (options & PACKET_READ_GENTLE_ON_READ_ERROR)
+			return error(_("protocol error: bad line length %d"),
+				     len);
 		die(_("protocol error: bad line length %d"), len);
+	}
 
 	if (get_packet_data(fd, src_buffer, src_len, buffer, len, options) < 0) {
 		*pktlen = -1;
diff --git a/pkt-line.h b/pkt-line.h
index 31012b9943bf..80ce0187e2ea 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -68,10 +68,15 @@ int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_ou
  *
  * If options contains PACKET_READ_DIE_ON_ERR_PACKET, it dies when it sees an
  * ERR packet.
+ *
+ * If options contains PACKET_READ_GENTLE_ON_READ_ERROR, we will not die
+ * on read errors, but instead return -1.  However, we may still die on an
+ * ERR packet (if requested).
  */
-#define PACKET_READ_GENTLE_ON_EOF     (1u<<0)
-#define PACKET_READ_CHOMP_NEWLINE     (1u<<1)
-#define PACKET_READ_DIE_ON_ERR_PACKET (1u<<2)
+#define PACKET_READ_GENTLE_ON_EOF        (1u<<0)
+#define PACKET_READ_CHOMP_NEWLINE        (1u<<1)
+#define PACKET_READ_DIE_ON_ERR_PACKET    (1u<<2)
+#define PACKET_READ_GENTLE_ON_READ_ERROR (1u<<3)
 int packet_read(int fd, char **src_buffer, size_t *src_len, char
 		*buffer, unsigned size, int options);
 
-- 
gitgitgadget

