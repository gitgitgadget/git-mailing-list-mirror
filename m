Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB50C433E0
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 00:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7F5601FB
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 00:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhBMAKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 19:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhBMAKA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 19:10:00 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C73C0613D6
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 16:09:19 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id 7so1410646wrz.0
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 16:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZrqHdrLvGrETy2dSaKQym4tWVcFDSXunor28gito1nY=;
        b=pb/6g7RTW4Y9rRzwWU6bOmB5mawRuVHqm8JdbOvnHLAcc5c+GlHZoUwdgbNs0wfsg3
         mLRCGCRtqziO0X6CtH5Khc8+IWBbBeQ6liRuoYERLxnR6YLRV6tMS8he47ORY6MdzxG7
         aFwsjl1jqKqH+UsJqiX5RZ+cSYh9s6rQ2KO5xwnjElA4KPCvWYjZtSJejK+mJSHhUPyu
         22IKeFhrjx3aCpoz0so6CGNh7iOQGxKAJzZsAH3gna5xmyWJ+8LYnnBvNGnfGIeCdodi
         NPuQL+zXOTXJWpU4mWjXuBwz++Yb8OS39mOXcMjF8OyMS8lQn2htIrOLQos7SlAMmjc+
         5ZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZrqHdrLvGrETy2dSaKQym4tWVcFDSXunor28gito1nY=;
        b=Yi49VnWsM9TmxtC5qx+LAPE9dwdefaZz3gd7h2Kz6ysTb1Yf/Ozcc+FI5OSY5AMFq6
         6x2DU4m6O/t0gut9V0pKdSO2aVW8ELV7bnse0wEXB5waXmVkEatEpu98WGMrqbZqWjA9
         D2LBdn2mf1EZJM4+RT+II8ulDL5ZFLH9Qr19g7DUgKYqQn2QpgHCYBUzVx9xGpYvNiYx
         mzCxD16X29DKTs3sWyp0chMTM24WvXF6dXAK0WDJXogokC5WRM61+PfO2coksHz3w1e0
         vxvbjqa5ThxW/LXW+6FRECD5GbUCnPpHotlmnNdH7rVDUDS6kHkU4Y/THLIXgroLMEHw
         QZ6w==
X-Gm-Message-State: AOAM5301dB0YCnfwLXL3ljx9KtO5uwq2/SRGNkSRzb8HyCd3peQiFkwO
        MoE4pwttNbA/TxKhTe11mZEeM27xD+Y=
X-Google-Smtp-Source: ABdhPJzShGU/hwfgPQXmCBs13aPhy1s5yU2euJqXMBkgrWuMYJ4YefleZEK8jP0gKHrduxLEyIl8Tw==
X-Received: by 2002:a5d:618e:: with SMTP id j14mr5937061wru.377.1613174957963;
        Fri, 12 Feb 2021 16:09:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u14sm13279326wro.10.2021.02.12.16.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 16:09:17 -0800 (PST)
Message-Id: <e05467def4e158a5f1cfa3aafffdb5c77097859a.1613174954.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
References: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
        <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Feb 2021 00:09:04 +0000
Subject: [PATCH v3 03/12] pkt-line: (optionally) libify the packet readers
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

