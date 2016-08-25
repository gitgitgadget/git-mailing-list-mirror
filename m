Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7BB52018E
	for <e@80x24.org>; Thu, 25 Aug 2016 11:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756813AbcHYL0y (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 07:26:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35616 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756376AbcHYL0v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 07:26:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so6969635wmg.2
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 04:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Io14dUmNb0xXcNrALJ9LSQz8DzlLw9JyVBvbJUXurMc=;
        b=FOfm3CvcXdx3KOCNX8NI4CQGDPPDlXEcMWeV2dRWfjupdxs0en6EDZkydCY17XzbEP
         OU7x3IwurtE4YfCNd7yphjh4DxefllgmbrPDNz/U/KWbeQMtaY+5KZ6egSs+5Ivrztfv
         Xh4v6DS5RcD24wbd2N2uzwLStS3tzZmqxkwKRmrellQ+Nx7WxV3xZtZyCnGN1jeOh4R7
         Y28rqMxF+8NqFRcacTXW/oIR3C87U0ymgLHfVdId87XGZJwtLV0khiH04SIZ0hM0clK6
         WC/0x+LxU4Z5CkmqSR2BHCYzek4GcJdc9+koyH5O/fRrqDc5Hy/mKSAvIsvybzso5hJc
         RVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Io14dUmNb0xXcNrALJ9LSQz8DzlLw9JyVBvbJUXurMc=;
        b=KOf5q3the7PN/xff6Y9vMQFn9FphUl9EaelZVKGOtxb7fWr2CV+ZbwIpBCcM+fcudI
         eEIpL05yZzVazi6fHLgsem1KvAzymJGGXWV3RpjweiZV97ze+OI1Uzd764dd17KtEs7e
         WbJAcFVUt4QUa9dH3BULt9zLclAZ8nfdUsGEHKho3GEBkn0htsRldZhQoIYHg0VtG5hA
         J1UMhPfS9RWaghlwqTtHvLPM8lUOAmRh9BwK+z5JGU73bIQa8h8Sr+KkOodynqsa6H6B
         A7eQvDhZ6KoMY72S0tJ6aPIB12CRxynk61o0s26Nm+iDW9MWKQNxkWc9pxwNJeuWMy5p
         rPDQ==
X-Gm-Message-State: AEkoouvogjj1M7F160OuAaa+1+sRPdIbcDEbIlZdG2r/LIEpDO+LQTEQjaWqyctolVUjSg==
X-Received: by 10.194.2.47 with SMTP id 15mr7653173wjr.133.1472123283574;
        Thu, 25 Aug 2016 04:08:03 -0700 (PDT)
Received: from bcnf9f9l32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id p71sm38304839wmf.9.2016.08.25.04.08.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 25 Aug 2016 04:08:03 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v6 05/13] pkt-line: add packet_write_gently()
Date:   Thu, 25 Aug 2016 13:07:44 +0200
Message-Id: <20160825110752.31581-6-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160825110752.31581-1-larsxschneider@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

packet_write_fmt() has two shortcomings. First, it uses format_packet()
which lets the caller only send string data via "%s". That means it
cannot be used for arbitrary data that may contain NULs. Second, it will
always die on error.

Add packet_write_gently() which writes arbitrary data and returns `0`
for success and `-1` for an error. This function is used by other
pkt-line functions in a subsequent patch.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 pkt-line.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index cad26df..7e8a803 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -3,6 +3,7 @@
 #include "run-command.h"
 
 char packet_buffer[LARGE_PACKET_MAX];
+static char packet_write_buffer[LARGE_PACKET_MAX];
 static const char *packet_trace_prefix = "git";
 static struct trace_key trace_packet = TRACE_KEY_INIT(PACKET);
 static struct trace_key trace_pack = TRACE_KEY_INIT(PACKFILE);
@@ -155,6 +156,17 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 	return (write_in_full(fd, buf.buf, buf.len) == buf.len ? 0 : -1);
 }
 
+int packet_write_gently(const int fd_out, const char *buf, size_t size)
+{
+	if (size > sizeof(packet_write_buffer) - 4)
+		return -1;
+	packet_trace(buf, size, 1);
+	memmove(packet_write_buffer + 4, buf, size);
+	size += 4;
+	set_packet_header(packet_write_buffer, size);
+	return (write_in_full(fd_out, packet_write_buffer, size) == size ? 0 : -1);
+}
+
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 {
 	va_list args;
-- 
2.9.2

