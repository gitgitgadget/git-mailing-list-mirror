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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC99C43381
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 21:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B39264F0F
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 21:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhCOVIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 17:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbhCOVIe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 17:08:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49988C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 14:08:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id d191so8896201wmd.2
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 14:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Gx2HCnbaUgWpjCcl/3ugpx4J6eD/LX1CndW/0CSddwQ=;
        b=DmiBi+zb8QqXsHpbOzdwt3hjVTZYUvuLNBJiRQmfhr4iTptne5JUy7zqC5F1/XEVaK
         cMwhZ7rfD4iJG5J9QrF6L35fzD/i5uD8kUFWBE7moP8rM+4zXr9b8uTfJ21Y/DOGamgf
         0+8sx2vqiI6pkPyp++KQZcJado0aZg5uE0CUDuNd6sn+4cJ1F2UI6PGquZzHqo7UcQ4g
         66yVg9tRUwDlKdJ4zbKnaZsHrRDErmiPSL8ODCAN3Slwk8PRVP7sM6Jxny1Loqt/nbm0
         PTipEvnIWdFiGT8seSuVVgnxBMPYW1xX7xq5+tJM+0JqB2NFJ4177h9jKwAUmJJLjTtJ
         NjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Gx2HCnbaUgWpjCcl/3ugpx4J6eD/LX1CndW/0CSddwQ=;
        b=RTTVeqVBd4aqoJHbUpOgAFeI5vMxJ3UhJXlKdKuIo0KH+8uaxgxAgUPmBl7KziK75x
         5q+mRltgxvLcE6PmsvtAkl9MBgkU67rGyA1KTj+MUhVVGnDf5l0W09JSuDNwF8wMkxmb
         4VudBiMgMya9sfrdJhTjRJJ6zHWLQKsrp104MZjW42BfxC3LqTtgGKHw7m8ldJWhWjND
         oKFp+CixEmC1p53xWwrqSS3H52arIF/aeAZ/13Li35xgGzAJzu/eeJ+7UoDpfCa4TMbr
         ZsJRHk9RAmFBhayFOswuZdJAuFBhWAeOa3u8dxDh7MaDf8imB1nsf6mlGMnDQNSOweB8
         RvxQ==
X-Gm-Message-State: AOAM532xN0bdeHiCGAmyHr35aaZUHClponUG3a+j4FA3HBrbaVako+Dh
        cnuqSXMMqqZMwL5qs7ja3kmro3VNVQI=
X-Google-Smtp-Source: ABdhPJxvxDq6NUk/Eq+vCjOSG4ZPSizOStIP0vsKCsbRHfuyQ3vaFN0XUersO/aCf3Q4NHH4Pvto5w==
X-Received: by 2002:a05:600c:4112:: with SMTP id j18mr1424329wmi.143.1615842513087;
        Mon, 15 Mar 2021 14:08:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d29sm19490761wra.51.2021.03.15.14.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 14:08:32 -0700 (PDT)
Message-Id: <3718da39da30ffc283e74eb94c942d0110eb9676.1615842509.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v6.git.1615842509.gitgitgadget@gmail.com>
References: <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
        <pull.766.v6.git.1615842509.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Mar 2021 21:08:20 +0000
Subject: [PATCH v6 03/12] pkt-line: add PACKET_READ_GENTLE_ON_READ_ERROR
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
index bb0fb0c3802c..457ac4e151bb 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -306,8 +306,11 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
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
@@ -315,6 +318,8 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 		if (options & PACKET_READ_GENTLE_ON_EOF)
 			return -1;
 
+		if (options & PACKET_READ_GENTLE_ON_READ_ERROR)
+			return error(_("the remote end hung up unexpectedly"));
 		die(_("the remote end hung up unexpectedly"));
 	}
 
@@ -343,6 +348,9 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 	len = packet_length(linelen);
 
 	if (len < 0) {
+		if (options & PACKET_READ_GENTLE_ON_READ_ERROR)
+			return error(_("protocol error: bad line length "
+				       "character: %.4s"), linelen);
 		die(_("protocol error: bad line length character: %.4s"), linelen);
 	} else if (!len) {
 		packet_trace("0000", 4, 0);
@@ -357,12 +365,19 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
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

