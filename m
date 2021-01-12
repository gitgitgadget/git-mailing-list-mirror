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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61569C433E6
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B2823138
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391377AbhALPcT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 10:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389699AbhALPcS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 10:32:18 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D87C061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 07:31:37 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c124so2242156wma.5
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 07:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tWoYCWR5F8uv/qAGXMgvUK5xpn65Jh+3gAxndrW7LR0=;
        b=OSDduVgjrVwQPhrWnOGhIkP6mANh6TjiVW3SG49ircuQOZNlg4tMNsWIVC5GbMsYbE
         lFGaXF5nl2rYH5dLzqj1JihS8vne+Pnq1p8GGjnmX5xBA/jpkkwvVRIeJE1IkgrLttE8
         RMikoSld3jYAvJ302NRtSvPhsBThAqaT4OPK4Dp5sVJx+Mu81D6D7im4lKZ4JbJKlThD
         HWfQgzm0XsM67JVmmEt198T9GUbHh3t4Iw+4j4F2xeaDYy3A/PAJz208qoF1Ns7x367N
         /UzpaCr3yr1OkqOBXL2vHgMjo4cGzzIIFMTIrZ+i/2j0pdzQ4Prvgu6NNU6Nv8feVYVL
         X6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tWoYCWR5F8uv/qAGXMgvUK5xpn65Jh+3gAxndrW7LR0=;
        b=nQjx9DgaEIJmOmgOwmWrP7d3MQIsNQlvR3GsiprTmxdrexpQGJ1JrMTEl/+n1mkeOp
         9UBzB8WU7g+DffUT2/PPpCPStNk2IBc5mjUkDUzyR3Wky5F0Xo4af0EtZUX3zrKLSVtP
         UIb9LMv2YykXCQBBn5inbTjIS9ZWavjhPHBkoBK/ymyVU2JmBtlmX4bEhJPH7I/eDRge
         dLiP2XIv0TJzAsWRKREBeIwm+sqCy11tXj8yHEiflQxMt2eV5VYviEn2F9xfsxkTyzYc
         FGUqKnoTk0dL7A7T87LFmDuLENmQTt7rpZiofB7n6MGe+kpy6ZJ1fpuOOgkumsDGyoVh
         h8vg==
X-Gm-Message-State: AOAM533RBcbRpjkibxoRScKNHHSGUhMqtMV32D5wN15i2r4W7bQagr0u
        UEzfTm/b2jdYtrSZSWAex0EwtVdS2Qk=
X-Google-Smtp-Source: ABdhPJxLovnsiT8tNMBif+UPIj9m7/YRk/7k90qBUCVSsDrO4dmp718ef2n6NpNtwN9Fb363cm5dJg==
X-Received: by 2002:a1c:4904:: with SMTP id w4mr4062813wma.140.1610465496159;
        Tue, 12 Jan 2021 07:31:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b7sm5278325wru.33.2021.01.12.07.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 07:31:35 -0800 (PST)
Message-Id: <b7d678bc918addc99a1f5fe76ad33277aa476c33.1610465493.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.git.1610465492.gitgitgadget@gmail.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 15:31:24 +0000
Subject: [PATCH 02/10] pkt-line: (optionally) libify the packet readers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
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
index 98439a2fed0..5c2d86a2f60 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -298,8 +298,11 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
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
@@ -307,6 +310,8 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 		if (options & PACKET_READ_GENTLE_ON_EOF)
 			return -1;
 
+		if (options & PACKET_READ_NEVER_DIE)
+			return error(_("the remote end hung up unexpectedly"));
 		die(_("the remote end hung up unexpectedly"));
 	}
 
@@ -335,6 +340,9 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 	len = packet_length(linelen);
 
 	if (len < 0) {
+		if (options & PACKET_READ_NEVER_DIE)
+			return error(_("protocol error: bad line length "
+				       "character: %.4s"), linelen);
 		die(_("protocol error: bad line length character: %.4s"), linelen);
 	} else if (!len) {
 		packet_trace("0000", 4, 0);
@@ -349,12 +357,19 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
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
index 8c90daa59ef..c1fa245faf8 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -68,10 +68,14 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
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

