Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8B212070F
	for <e@80x24.org>; Thu,  8 Sep 2016 18:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758689AbcIHSVz (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 14:21:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35581 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754561AbcIHSVq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 14:21:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id a6so9029775wmc.2
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 11:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zo9Mw38FTcc0aPgb4rl3mq2k7Vy2w59sVq7+MK5r5cI=;
        b=CgsIaNtjs/NIP9wH8K57Du/6kE2Nc9HEgnoN30K7NAVuyFHR4lenDmd8rcPEX5wwiz
         6bqQYaDHi2UC7fMpVX1Roz6Njbbw7lKIJ/RwMrvffhs8ZAawfZAmQOJR/9NOsOo8wXic
         HJMQWhW598z6VAz58MbWYTUG2XYyT9gRWrrAZUitZTq9LlsC/uHj6Rzc10/gZ5XBYZg0
         JduWZgB91nd4k346xj7Z1UtUwnim9rPqzrfpPv09lUbbp9e4ZVCJAjw6btQoM4EaamMG
         4qEOlnriUom6XFgNCPSwUXHeeCbZd72mJ7L63sVRBVJAG7TsOv9k643lqQ0N/eqIEgsd
         qcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zo9Mw38FTcc0aPgb4rl3mq2k7Vy2w59sVq7+MK5r5cI=;
        b=RsDwWJ1w7aif2l6fEfQRiaku1b2PnkpMeETSGzUHknegNgt5k/2QouHSOrpxiRI/kC
         Y9vgE61F6dRbDBqiv+cQh3ZIuWtXTK0gINvbx4MAP1m0LoAEOKRZYN7wI00lVUibzG+R
         bASar1T3REBOJV0iVpuIjtMzmqFgvovO2Tr/UhQi8Axln/lygO6HieMiaYaRo3cVwRmc
         avjj5Y8V43R0I6QhcbvOFCq2S7KCRcQzLjYdCNFyv7BXioRk/zqlQsVZEzlRiq6aDpVQ
         wG2BUiVxSqlXHwswFLjpYs32mvQQYl0Ta0kr/ZMLZonE5utm8JDnaReNNARwwtEDgPhf
         Wsxw==
X-Gm-Message-State: AE9vXwPmKALUhTKsv90yEyWwfZ40+KSrbaYT4my/VdLgkYmUnqScpf5dgoai/Hdrygv4lw==
X-Received: by 10.28.128.67 with SMTP id b64mr941330wmd.76.1473358904700;
        Thu, 08 Sep 2016 11:21:44 -0700 (PDT)
Received: from slxBook4.local.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id b128sm10967467wmb.21.2016.09.08.11.21.43
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 08 Sep 2016 11:21:44 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        tboegi@web.de, jacob.keller@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v7 05/10] pkt-line: add packet_write_gently()
Date:   Thu,  8 Sep 2016 20:21:27 +0200
Message-Id: <20160908182132.50788-6-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160908182132.50788-1-larsxschneider@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

packet_write_fmt_gently() uses format_packet() which lets the caller
only send string data via "%s". That means it cannot be used for
arbitrary data that may contain NULs.

Add packet_write_gently() which writes arbitrary data and returns `0`
for success and `-1` for an error. This function is used by other
pkt-line functions in a subsequent patch.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 pkt-line.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 37345ca..1d3d725 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -181,6 +181,25 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 	return status;
 }
 
+int packet_write_gently(const int fd_out, const char *buf, size_t size)
+{
+	static char packet_write_buffer[LARGE_PACKET_MAX];
+
+	if (size > sizeof(packet_write_buffer) - 4) {
+		error("packet write failed");
+		return -1;
+	}
+	packet_trace(buf, size, 1);
+	size += 4;
+	set_packet_header(packet_write_buffer, size);
+	memcpy(packet_write_buffer + 4, buf, size - 4);
+	if (write_in_full(fd_out, packet_write_buffer, size) == size)
+		return 0;
+
+	error("packet write failed");
+	return -1;
+}
+
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 {
 	va_list args;
-- 
2.10.0

