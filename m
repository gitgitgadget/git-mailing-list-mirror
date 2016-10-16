Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03CD32098B
	for <e@80x24.org>; Sun, 16 Oct 2016 23:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757075AbcJPXV0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 19:21:26 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35641 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756898AbcJPXVW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 19:21:22 -0400
Received: by mail-pf0-f193.google.com with SMTP id s8so11496955pfj.2
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 16:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O/9Q/v9hxIqIS2YIr/9vDTJhOS1LfGeml2APWi+Y4U4=;
        b=KKNNT2e3wg4Nh1ambuj1T8Hkvv7g2uajpKjMl+JXgCYky19HRoqfHYTtbJP8bzZKoH
         lRfAFl+Ta4kPBu+J8jtN5R58VC2RFxWiu0V9YHvhXb4GZA7M6w3C8nPaL8k3fpJtmEd9
         xl/RL2rog1+nwz8U+yHw/YXsPqR/kye8V1KcuUb3vXRJ7YIitj67VZkFojOsbtgjEuqx
         0pUDzGBJhLMkhdyTtCUzteT+oVnNTq4moM46vneX3XqVD9i2DagcM2kXKdz4lzoqYNWI
         yFgGwSBSi4puv2sgUYsI2SQ2GtrS5mlJWAzOE+0kFSxYG3tOClzhWh34lkVLsusXDtZX
         GPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O/9Q/v9hxIqIS2YIr/9vDTJhOS1LfGeml2APWi+Y4U4=;
        b=kor2THzKQRzcxjirXAvAtTHIP+cW7L5usPoRtK3d9+4N3lMK9j9aLz1YAtJAZF5LBb
         JvXZpYTmEoeA/ntWHMS3ZVGr3Ji/5qIlLn5XIyHbXzgVflvGkspH3e9G26LPAZiwnh+J
         Y2I67RVv76qUpPSJH7eMSyZ6NLcuEMM9PgUdLjMBdh8qqFscLjK+wpXYdXE7jDfblWxZ
         ZAdhG0UxZ+tdpTr6x+yt85KA0Og9k7GobMNkxn0ZXe6Hx06AajYqUO1NKhCI93qzmUjp
         ybIQGkTivdrDIm9LpCdHk5U2nnWN95Ws0Zz5KMBfvw4WUBMpg45u8wosMqu1v+Da0a0p
         8lGQ==
X-Gm-Message-State: AA6/9RnfrwaO6cpWdSggsvXvSNB87xgjNnAR9XZsnsmrbdFO2Qoe7TqH4lFD27AuI9oClQ==
X-Received: by 10.99.107.130 with SMTP id g124mr27453918pgc.76.1476660081935;
        Sun, 16 Oct 2016 16:21:21 -0700 (PDT)
Received: from rem3n8pj12.ads.autodesk.com (adsk-nat-ip4.autodesk.com. [132.188.71.4])
        by smtp.gmail.com with ESMTPSA id cp2sm10325691pad.3.2016.10.16.16.21.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 16 Oct 2016 16:21:16 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, tboegi@web.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 09/14] pkt-line: add packet_write_gently()
Date:   Sun, 16 Oct 2016 16:20:33 -0700
Message-Id: <20161016232038.84951-10-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161016232038.84951-1-larsxschneider@gmail.com>
References: <20161016232038.84951-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

packet_write_fmt_gently() uses format_packet() which lets the caller
only send string data via "%s". That means it cannot be used for
arbitrary data that may contain NULs.

Add packet_write_gently() which writes arbitrary data and does not die
in case of an error. The function is used by other pkt-line functions in
a subsequent patch.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pkt-line.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 286eb09..dca5a64 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -171,6 +171,23 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 	return status;
 }
 
+static int packet_write_gently(const int fd_out, const char *buf, size_t size)
+{
+	static char packet_write_buffer[LARGE_PACKET_MAX];
+	size_t packet_size;
+
+	if (size > sizeof(packet_write_buffer) - 4)
+		return error("packet write failed - data exceeds max packet size");
+
+	packet_trace(buf, size, 1);
+	packet_size = size + 4;
+	set_packet_header(packet_write_buffer, packet_size);
+	memcpy(packet_write_buffer + 4, buf, size);
+	if (write_in_full(fd_out, packet_write_buffer, packet_size) == packet_size)
+		return 0;
+	return error("packet write failed");
+}
+
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 {
 	va_list args;
-- 
2.10.0

