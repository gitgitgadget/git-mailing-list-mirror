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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31475C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9DDE64DEC
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhBQVtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbhBQVte (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 16:49:34 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFDEC061786
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:48:53 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id x4so5457369wmi.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZrqHdrLvGrETy2dSaKQym4tWVcFDSXunor28gito1nY=;
        b=J8WI1yaAIBzRx2Z1i3cy3b+x0MdJTK+lwD0FclOOV+ehYu/CbYu/SIPs2Pxiut8akD
         GH8MQDlgkjd1YTs0PTrXRhQ02uRW6FmmSNMaJU+Btmtt7xtkMNrVEjxEq1qo3kf0mJ6P
         //sfKJ8aOj64H/g6sRbl/av1s1q/xCINBM6PYvoR9SK9IS7yAm48sFUIO6kx7AuyOocn
         FSHWnxbqkwphpJhNcAZ3d23zAdS1YC8c/FBjncQlKUD2YAEftAfvu7UiHuLIAoMvpxOR
         g3XVWTDdva3NJ57IyLyCXiiXhrH5bias0eFiAmesg+WtzADTOxf+Ppo7afJG+kLwKv+1
         d6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZrqHdrLvGrETy2dSaKQym4tWVcFDSXunor28gito1nY=;
        b=nzPxdBcvH5i8c+AHGlJy9O6bBqgqFFs9AJX3gZ+Fwu497ulOclhiVBM/ANFJHD2IQ9
         9IjckGpyBu5TqFPtVZK0PvOwN/LPf/9t4ea0ZYzzqoLG0F9utYp3qil7iEhb6lQTilu7
         aYWgPDXstKhqsQhR+NDlE+pQjAf/XZ1l18pLAcNgm0iGiwHJLWM+Yk/XV1qv2ye+9GuR
         yDtsT2OTHDQvzMkcwHaMCcP8riQ3B6GO2iT8H6ipHH614rqgmCFtTHzJj0mLnSZU/4lX
         KomBdSyinVJSNoPBgm4cdeG6NMuvhSs45/zGYVjw3mtGQ3geJLikh10CsIfO9nRWnsEl
         9nmA==
X-Gm-Message-State: AOAM531AQLz7yiSvZO4bkTdXVVJ1S7OPB4oi6pau5NP7VHcMyLpbpfc9
        pw83PKcEZjXqQPDO9qibfmUIJRIRbp8=
X-Google-Smtp-Source: ABdhPJzSsIFw68XuMfUbOAqDKGiuh2UTuTbhLSV6zo1ClxiRpDYL8yppr+iEfWMnx/8JN6UlLgmUdw==
X-Received: by 2002:a1c:6802:: with SMTP id d2mr726148wmc.32.1613598532379;
        Wed, 17 Feb 2021 13:48:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16sm5549960wrw.46.2021.02.17.13.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:48:52 -0800 (PST)
Message-Id: <e05467def4e158a5f1cfa3aafffdb5c77097859a.1613598529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
        <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Feb 2021 21:48:39 +0000
Subject: [PATCH v4 03/12] pkt-line: (optionally) libify the packet readers
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

So far, the (possibly indirect) callers of `get_packet_data()` can ask
that function to return an error instead of `die()`ing upon end-of-file.
However, random read errors will still cause the process to die.

So let's introduce an explicit option to tell the packet reader
machinery to please be nice and only return an error.

This change prepares pkt-line for use by long-running daemon processes.
Such processes should be able to serve multiple concurrent clients and
and survive random IO errors.  If there is an error on one connection,
a daemon should be able to drop that connection and continue serving
existing and future connections.

This ability will be used by a Git-aware "Internal FSMonitor" feature
in a later patch series.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 pkt-line.c | 19 +++++++++++++++++--
 pkt-line.h |  4 ++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 3602b0d37092..83c46e6b46ee 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -304,8 +304,11 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 		*src_size -= ret;
 	} else {
 		ret = read_in_full(fd, dst, size);
-		if (ret < 0)
+		if (ret < 0) {
+			if (options & PACKET_READ_NEVER_DIE)
+				return error_errno(_("read error"));
 			die_errno(_("read error"));
+		}
 	}
 
 	/* And complain if we didn't get enough bytes to satisfy the read. */
@@ -313,6 +316,8 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 		if (options & PACKET_READ_GENTLE_ON_EOF)
 			return -1;
 
+		if (options & PACKET_READ_NEVER_DIE)
+			return error(_("the remote end hung up unexpectedly"));
 		die(_("the remote end hung up unexpectedly"));
 	}
 
@@ -341,6 +346,9 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 	len = packet_length(linelen);
 
 	if (len < 0) {
+		if (options & PACKET_READ_NEVER_DIE)
+			return error(_("protocol error: bad line length "
+				       "character: %.4s"), linelen);
 		die(_("protocol error: bad line length character: %.4s"), linelen);
 	} else if (!len) {
 		packet_trace("0000", 4, 0);
@@ -355,12 +363,19 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 		*pktlen = 0;
 		return PACKET_READ_RESPONSE_END;
 	} else if (len < 4) {
+		if (options & PACKET_READ_NEVER_DIE)
+			return error(_("protocol error: bad line length %d"),
+				     len);
 		die(_("protocol error: bad line length %d"), len);
 	}
 
 	len -= 4;
-	if ((unsigned)len >= size)
+	if ((unsigned)len >= size) {
+		if (options & PACKET_READ_NEVER_DIE)
+			return error(_("protocol error: bad line length %d"),
+				     len);
 		die(_("protocol error: bad line length %d"), len);
+	}
 
 	if (get_packet_data(fd, src_buffer, src_len, buffer, len, options) < 0) {
 		*pktlen = -1;
diff --git a/pkt-line.h b/pkt-line.h
index a7149429ac35..2e472efaf2c5 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -75,10 +75,14 @@ int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_ou
  *
  * If options contains PACKET_READ_DIE_ON_ERR_PACKET, it dies when it sees an
  * ERR packet.
+ *
+ * With `PACKET_READ_NEVER_DIE`, no errors are allowed to trigger die() (except
+ * an ERR packet, when `PACKET_READ_DIE_ON_ERR_PACKET` is in effect).
  */
 #define PACKET_READ_GENTLE_ON_EOF     (1u<<0)
 #define PACKET_READ_CHOMP_NEWLINE     (1u<<1)
 #define PACKET_READ_DIE_ON_ERR_PACKET (1u<<2)
+#define PACKET_READ_NEVER_DIE         (1u<<3)
 int packet_read(int fd, char **src_buffer, size_t *src_len, char
 		*buffer, unsigned size, int options);
 
-- 
gitgitgadget

