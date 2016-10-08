Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B37AF207EC
	for <e@80x24.org>; Sat,  8 Oct 2016 11:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934642AbcJHL0B (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 07:26:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33086 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935054AbcJHLZq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 07:25:46 -0400
Received: by mail-wm0-f67.google.com with SMTP id i130so6638203wmg.0
        for <git@vger.kernel.org>; Sat, 08 Oct 2016 04:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O/9Q/v9hxIqIS2YIr/9vDTJhOS1LfGeml2APWi+Y4U4=;
        b=tp4JKuTkk/0FucDzBIWITeCc69UvPsN8KW01gVAM/QFBFGHyEVZO3FNr/sgBYu5cOQ
         9hpybyPAaa3F3oPr7vgK6+ujCYMA165Kgs18RPRsF50vk7a/0gigTorb7ShgB2OViu/V
         oKjV3fpM5jFvhRjGE52KwKVcAi/orFm9RPxaEmjnDvWgvNDIKUWGzFjvLEs2yA8hcf5s
         gNx6lIz6GHx6XXP4uUjX1HoYnX2x2pJjLWVvUpYpLBECM2NYvPsMPgXrJZpiEj9sVssM
         anH9bSTsJGPcI8CyYXTmYi6wD6CJ9AXeIHSJu+VCFvZuUyW9VjDshHjvHE5k/WNRuUHa
         oXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O/9Q/v9hxIqIS2YIr/9vDTJhOS1LfGeml2APWi+Y4U4=;
        b=NNvUp1U6KGFa0qURQk7POFfvRqt/xsSuv6gLvvwwnmdnRhiU5dyuUO2CGNFrykiJgP
         c45MsMjbIf8H2LWR4kf7OORWmiWaRmKoOXmiSJsfUwEoClrr77eA2eh0FSOnCD1zYB7X
         /eoK/Mk2LrZyRl6OzrER6r2FSASXSXEByQaqoUDrNDBniB1FTt/jeOiO1bqcZMrdetBG
         d3yZflrr+XwAWkNT47dVRSsH7NisjrsA7qn3NA43O4sV2K5uWcT0gEhEjULYcRMpnd5U
         7Grt7kDKcdDr58aWbKkapevfUX6dfyhD+NQ8T26KbEIIovIPq9DfXbUOkMIe9vLRk94n
         GmBw==
X-Gm-Message-State: AA6/9RnfDeoV7Ua0s3ALtImtH4+RLf8qT9GmEa7vBchgQJmqmN91ZG8z+e26tacHUbs0sw==
X-Received: by 10.28.220.212 with SMTP id t203mr2998192wmg.102.1475925944865;
        Sat, 08 Oct 2016 04:25:44 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB73B1.dip0.t-ipconnect.de. [93.219.115.177])
        by smtp.gmail.com with ESMTPSA id a1sm24599623wju.41.2016.10.08.04.25.43
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 08 Oct 2016 04:25:44 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v10 09/14] pkt-line: add packet_write_gently()
Date:   Sat,  8 Oct 2016 13:25:25 +0200
Message-Id: <20161008112530.15506-10-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161008112530.15506-1-larsxschneider@gmail.com>
References: <20161008112530.15506-1-larsxschneider@gmail.com>
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

