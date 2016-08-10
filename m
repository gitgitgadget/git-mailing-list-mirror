Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46D151FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933878AbcHJTL7 (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:11:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35883 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932309AbcHJTLz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:11:55 -0400
Received: by mail-wm0-f68.google.com with SMTP id i138so11383948wmf.3
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 12:11:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CHbS19b05W4FbjactJ1Si4TaGjJZCTnRt62BsYbqvlk=;
        b=zr0O/IjKTkQM2bHVwuUyfvcEIA7VUHQXPGxxriBjZvms35reau/asrQZj3oOsatyed
         fuvLhB443QPc0jDPrARseXXrDQyEtTOpZN7qMl3hppjgCV+6ZFTYHeay2xEqa8f+ZRdI
         qmX4xcSq3YcNUo/cs2goW0qfZLeHffn0pWg4Ef+PHxoaMwmBy59dGIaUSAJqLbH6e3yj
         7rTZKoVj7BVFfubBXKdzdVDswdthogb4DXa3HDNTJ3y8l6hgLZWw0lrFyVu/8mW4nBd0
         PuSEQFadj2VSne4Ul+OSPmoTRzaqR8stkmVHo5qIe2mYkAwrYXk4aR/Y7eXYt35ScJga
         d2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CHbS19b05W4FbjactJ1Si4TaGjJZCTnRt62BsYbqvlk=;
        b=mIRpcWUMrkBz1xm3PBYblX7GxLv5wfyK684/4tDxCHGV/h7RYOMHnytVUFtv44x0lw
         Ub8DtY6i+clYSPd+Hr7XWz40759owbHvj6UnT2/hbuR2ElFys5nwJGcgQcwyFdCCGQsv
         jlsIZK8V5LMak6sfoVsiWuQvYLNqcn4VWUrdnz1+somwTdKGhbGp8X88J2j5lfpaJowk
         EghFNczvdjINmZQ/bOnoKegkISEy8U58iNMzHOwIbLZOaSXUbaxuVBxKXFwx3sToCE0+
         Ne7MBpPhiyBXWuP/GgEBgsCPfvuTdj8LpvxuZCaQYeU5HiO1ImcHJUv+AenPE4ubWCxN
         vm6A==
X-Gm-Message-State: AEkooutzhsNV2oESslT9+DnP0YLIioPZnFjUJZmMIte1xrXsuZn43zFABtQGgLfEBdsmdQ==
X-Received: by 10.194.47.7 with SMTP id z7mr3781207wjm.63.1470834259635;
        Wed, 10 Aug 2016 06:04:19 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p83sm8319899wma.18.2016.08.10.06.04.18
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 06:04:19 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, mlbright@gmail.com,
	e@80x24.org, peff@peff.net, Johannes.Schindelin@gmx.de,
	ben@wijen.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v5 06/15] pkt-line: add packet_flush_gently()
Date:	Wed, 10 Aug 2016 15:04:02 +0200
Message-Id: <20160810130411.12419-7-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160810130411.12419-1-larsxschneider@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

packet_flush() would die in case of a write error even though for some callers
an error would be acceptable. Add packet_flush_gently() which writes a pkt-line
flush packet and returns `0` for success and `-1` for failure.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 pkt-line.c | 6 ++++++
 pkt-line.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index a8207dd..e6a0924 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -92,6 +92,12 @@ void packet_flush(int fd)
 	write_or_die(fd, "0000", 4);
 }
 
+int packet_flush_gently(int fd)
+{
+	packet_trace("0000", 4, 1);
+	return (write_in_full(fd, "0000", 4) == 4 ? 0 : -1);
+}
+
 void packet_buf_flush(struct strbuf *buf)
 {
 	packet_trace("0000", 4, 1);
diff --git a/pkt-line.h b/pkt-line.h
index 82676f4..b6c8bcd 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -23,6 +23,7 @@ void packet_flush(int fd);
 void packet_write(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+int packet_flush_gently(int fd);
 int packet_write_gently_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 
 /*
-- 
2.9.2

