Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3443C209AA
	for <e@80x24.org>; Tue, 20 Sep 2016 19:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932973AbcITTDI (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 15:03:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36493 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932904AbcITTC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 15:02:59 -0400
Received: by mail-wm0-f65.google.com with SMTP id b184so4913292wma.3
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 12:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9QTSO1HVpgE/HG3xYkwiwhzgKuHHIlkZvSgzRP/sXvE=;
        b=eFqICqC2iEHfZVv57tN6AAV/sSZ8BtmTDVxnW8QiyfiGyEVsE6sbNESEuYA2x3JExG
         xB9cbNgmkhoQ+KCN3lB61x+HDHwo81KxYzIugIvxXoM6YoXvALppGb4cDk8lhCWF4/xG
         ixgWAH0dL2R40bg8HhEelZbqTR7YM+yNu+/VFpS1Zgil02T//fMXxRBy7/llq4zIuFvI
         JfgLjJEJGPUZS82huqmqi+RqRKz05TDYUNIlsJL9Iw8pox3ijeVuBMH7hXqghJgFXYHv
         E3+wFA8RjmqQZTWOKo0H4BKOuau7N+OEQv8IuDGhigOBW3C4Ds5fEnRKTC69CYN79frq
         hyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9QTSO1HVpgE/HG3xYkwiwhzgKuHHIlkZvSgzRP/sXvE=;
        b=dOGoxIU20hkVwSxn9NZGrsdVFisH3/NAzWEfRb2dij8MtINQ1qke4kJwEuM2aCJlgG
         FPdkZJIbA5U1M3zgfoKnjkNSCGJ504iWSWLu+DJuSoWo+YCNXvzPvC0T69BhYwXqq5dq
         0oygfTdLiT7L0PJN7xqHjhGCId8un2eIKaJExq7PlMoX6hXztkX2/7To4ivaYcwxgA+r
         bMhe42vmAG/S0sgtIjbhtn+QiBX3fKA1qMqwg880KC3uQ0oq0XFJ5/5aKu7ku2ht4FZt
         x1SxfDmZvbsC+j/mmXuUNv/zVTFDNrAnv5TuhzS7JkZ45MgQzKdpFMUjgbGc/2cbGbFH
         vT+A==
X-Gm-Message-State: AE9vXwPrxf5pn+i3/xJYA4q0brk9tR7rOZsmIgyepApIxHqhiBJYGwQntjl39/c6tnxBWw==
X-Received: by 10.194.112.68 with SMTP id io4mr29062347wjb.1.1474398177695;
        Tue, 20 Sep 2016 12:02:57 -0700 (PDT)
Received: from slxBook4.fritz.box (p508BA5EF.dip0.t-ipconnect.de. [80.139.165.239])
        by smtp.gmail.com with ESMTPSA id gg10sm29820728wjd.4.2016.09.20.12.02.56
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 20 Sep 2016 12:02:57 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        jnareb@gmail.com, mlbright@gmail.com, tboegi@web.de,
        ramsay@ramsayjones.plus.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v8 06/11] pkt-line: add packet_write_gently()
Date:   Tue, 20 Sep 2016 21:02:42 +0200
Message-Id: <20160920190247.82189-7-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160920190247.82189-1-larsxschneider@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
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
---
 pkt-line.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 19f0271..fc0ac12 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -171,6 +171,22 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 	return status;
 }
 
+static int packet_write_gently(const int fd_out, const char *buf, size_t size)
+{
+	static char packet_write_buffer[LARGE_PACKET_MAX];
+
+	if (size > sizeof(packet_write_buffer) - 4) {
+		return error("packet write failed - data exceeds max packet size");
+	}
+	packet_trace(buf, size, 1);
+	size += 4;
+	set_packet_header(packet_write_buffer, size);
+	memcpy(packet_write_buffer + 4, buf, size - 4);
+	if (write_in_full(fd_out, packet_write_buffer, size) == size)
+		return 0;
+	return error("packet write failed");
+}
+
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 {
 	va_list args;
-- 
2.10.0

