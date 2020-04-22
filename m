Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6871EC54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 16:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38FB62082E
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 16:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPL0NJJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgDVQeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgDVQeR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 12:34:17 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E70FC03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 09:34:16 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v8so5371686wma.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 09:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QHbA49AFZ8up68n6D9WDvEEIJtXL7+xWdoevVXGio0s=;
        b=mPL0NJJ1oGbNx89iZ1Indn58nLtyRjiv+9BYGD4iECiAQWJ8qQxmThCTCwckHBik50
         VWqHvJDQ1SqvihmtyeaHflLpI0gU+aX1An/xm+nfDUDarEgVU3cgRqcBbyT9EZkp0xrZ
         2yIj8M3/0npMZ9GBGqcVz5nyu1uId1wlRrwiFaxm1XAoBF9BlR/7p7820HHGLjjO9bx4
         XqKGQbD67cs92F1zUvNVQSLvrAAdFM+5OFKLDFttcZ+ng8Aun6b3hyh4XJ+8AUPBSIWT
         XUs925PXP7bCao5tlK5a0a+hbHh6grpClniKJsoAC2q/RJ8SZEGw+k88OXF2cPi4o1e6
         +sKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QHbA49AFZ8up68n6D9WDvEEIJtXL7+xWdoevVXGio0s=;
        b=JuOcuPx8V8YQbWZ50qDNtVXPwQSrRusFGNLeBECqtbN33JxU9QcO+8qM3lwvSJAYhc
         CKZlKWUoUcAzmSlEiigfngycpwvqLqpyphMbktPx0LgtxFBIG8Df4nGVRlNrXNZTTRYi
         INh9C6K0w1hr+cBY+ZZqaqJ2DcWqDFcZqgES6VPcdk6dS8oVQCxNfBg3IdXithPNhXFJ
         POvI9qjDH8+fvtmmyPVJhTBGxSVrayYT2BXze0B2Du2tVa1XjZeB5uYDJxcSjAE2vtBd
         POfIGMrzxX6qWg5bl6i5cpBRhhnECRYiVuSPJtkxFksqDx8TUsnE8f1N2ZVo6UV8nvjH
         xRIQ==
X-Gm-Message-State: AGi0PuarrFCYIo2aESkUpHYYSxbIathGuLcD8o/aEB5Q8It86H0+IMzH
        Fuu8vZoJ9I8cyRHCueonF0fPy0+gtBQ=
X-Google-Smtp-Source: APiQypJ8Nsy8Mtmw7pFPXTv6SEgB/Kc7eK/WkWo20ODT1oCgSR81Txf4ybYEgyFHQ9DSPNK3nGQopA==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr10828366wmh.141.1587573254655;
        Wed, 22 Apr 2020 09:34:14 -0700 (PDT)
Received: from localhost.localdomain ([185.228.229.73])
        by smtp.gmail.com with ESMTPSA id c190sm8809214wme.10.2020.04.22.09.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 09:34:13 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC PATCH] fetch-pack: try harder to read an ERR packet
Date:   Wed, 22 Apr 2020 18:33:57 +0200
Message-Id: <20200422163357.27056-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the server has hung up after sending an ERR packet to the
client, the client might still be writing, for example a "done"
line. Therefore the client might get a write error before reading
the ERR packet.

When fetching this could result in the client displaying a
"Broken pipe" error, instead of the more useful error sent by
the server in the ERR packet.

Instead of immediately die()ing after write_in_full() returned an
error, fetch should first try to read all incoming packets in the hope
that the remote did send an ERR packet before it died, and then die
with the error in that packet, or fall back to the current generic
error message if there is no ERR packet (e.g. remote segfaulted or
something similarly horrible).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
This just formats the following patch from SZEDER Gábor:

https://lore.kernel.org/git/20190830121005.GI8571@szeder.dev/

I haven't tried to implement some suggestions discussed later
in the above thread like:

  - renaming send_request()
  - covering more code pathes
  - avoid blocking indefinitely by looking for an ERR packet
    only if the write() resulted in ECONNRESET or EPIPE
  - first printing an error message with error_errno() before
    going on to look for an ERR packet
  - implementing a timeout

as it seems to me that there was no consensus about those.

It follows up from discussions in this thread:

https://lore.kernel.org/git/cover.1584477196.git.me@ttaylorr.com/

 fetch-pack.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 1734a573b0..63e8925e2b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -185,14 +185,27 @@ static enum ack_type get_ack(struct packet_reader *reader,
 }
 
 static void send_request(struct fetch_pack_args *args,
-			 int fd, struct strbuf *buf)
+			 int fd, struct strbuf *buf,
+			 struct packet_reader *reader)
 {
 	if (args->stateless_rpc) {
 		send_sideband(fd, -1, buf->buf, buf->len, LARGE_PACKET_MAX);
 		packet_flush(fd);
 	} else {
-		if (write_in_full(fd, buf->buf, buf->len) < 0)
+		if (write_in_full(fd, buf->buf, buf->len) < 0) {
+			int save_errno = errno;
+			/*
+			 * Read everything the remote has sent to us.
+			 * If there is an ERR packet, then the loop die()s
+			 * with the received error message.
+			 * If we reach EOF without seeing an ERR, then die()
+			 * with a generic error message, most likely "Broken
+			 * pipe".
+			 */
+			while (packet_reader_read(reader) != PACKET_READ_EOF);
+			errno = save_errno;
 			die_errno(_("unable to write to remote"));
+		}
 	}
 }
 
@@ -349,7 +362,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 		const char *arg;
 		struct object_id oid;
 
-		send_request(args, fd[1], &req_buf);
+		send_request(args, fd[1], &req_buf, &reader);
 		while (packet_reader_read(&reader) == PACKET_READ_NORMAL) {
 			if (skip_prefix(reader.line, "shallow ", &arg)) {
 				if (get_oid_hex(arg, &oid))
@@ -372,7 +385,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 			die(_("expected shallow/unshallow, got %s"), reader.line);
 		}
 	} else if (!args->stateless_rpc)
-		send_request(args, fd[1], &req_buf);
+		send_request(args, fd[1], &req_buf, &reader);
 
 	if (!args->stateless_rpc) {
 		/* If we aren't using the stateless-rpc interface
@@ -395,7 +408,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 			int ack;
 
 			packet_buf_flush(&req_buf);
-			send_request(args, fd[1], &req_buf);
+			send_request(args, fd[1], &req_buf, &reader);
 			strbuf_setlen(&req_buf, state_len);
 			flushes++;
 			flush_at = next_flush(args->stateless_rpc, count);
@@ -470,7 +483,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 	trace2_region_leave("fetch-pack", "negotiation_v0_v1", the_repository);
 	if (!got_ready || !no_done) {
 		packet_buf_write(&req_buf, "done\n");
-		send_request(args, fd[1], &req_buf);
+		send_request(args, fd[1], &req_buf, &reader);
 	}
 	print_verbose(args, _("done"));
 	if (retval != 0) {
-- 
2.17.1

