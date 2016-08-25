Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 017DD1FD99
	for <e@80x24.org>; Thu, 25 Aug 2016 11:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757312AbcHYLUK (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 07:20:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36087 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbcHYLUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 07:20:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id i138so6927150wmf.3
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 04:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SrLSH9gbFvXaPwsj2WTpGVYdX0vql1FT6sNwvfCXVsY=;
        b=zyQE2AjzxdBmLLnx6S2uUUZFS51oXtUwMr6CHHSjAsGssoG7sw6g+6ieWMKiztu6hY
         4RJN4Sssa50UGF0T4cT+QHcKVGLawzUk2zCqaWvH+nE3vO3iifDol23E+OrPlSqeun//
         +BXqDYpXWh+OcCDa5XVsdho1B1L2nY6yHLYjSC0Ag5LnVF/Km1WVobwf1EmgKrGuj0IO
         GnW46CZ9mI8kgJc4pU1C34fkN2zK34ICkekiqIm3MpHlDoaGRvHhn30hSVYCabYnpsQG
         gFBNHLi0Tog7kiYbPV81XHzoFoRd1SpUQ/hXb8YKy2FxQnTA234N/qqiZdr8jXFhrgB3
         pUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SrLSH9gbFvXaPwsj2WTpGVYdX0vql1FT6sNwvfCXVsY=;
        b=dwo2iMkRivV1DWmXeG/NCh5WVKI8xi5AyK4edKLV1RuR/y8bYR5mo6iGyhqgygaz1Q
         7IRTbiH1c4/wUQeZ/qaRQUjMFAKfY8fPdteJLgrhYQWkxH4ZFeAc7/lCYNI6IfqsbpSe
         M68laupB167C18U5dEkiicg949V1+Vw0emiBc0V3fid7IIXlZ0QGTMgEipe3mS/Q7R9u
         d/zQy/G8M3+0odlWUq2zvth/RK6Oa9fHNemrES3Z2M1oifTsqvkgHdQepxw3H7rJft6Y
         h8n1LEI+k/Ku34Ei9tMo5IoDplWuOQQ0JSMIvB565KaJxJVmYWs9wOgWhln4iia0vi9B
         nvgw==
X-Gm-Message-State: AEkoout5dSFK+KQuophTFIMiRGJyc1fiNA4F0L/DMybICVaBG+0fEHAhJt5YlPAxkt/Reg==
X-Received: by 10.194.106.36 with SMTP id gr4mr6897163wjb.107.1472123280850;
        Thu, 25 Aug 2016 04:08:00 -0700 (PDT)
Received: from bcnf9f9l32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id p71sm38304839wmf.9.2016.08.25.04.07.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 25 Aug 2016 04:08:00 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v6 03/13] pkt-line: add packet_write_fmt_gently()
Date:   Thu, 25 Aug 2016 13:07:42 +0200
Message-Id: <20160825110752.31581-4-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160825110752.31581-1-larsxschneider@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

packet_write_fmt() would die in case of a write error even though for
some callers an error would be acceptable. Add packet_write_fmt_gently()
which writes a formatted pkt-line and returns `0` for success and `-1`
for an error.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 pkt-line.c | 12 ++++++++++++
 pkt-line.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index e8adc0f..3e8b2fb 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -137,6 +137,18 @@ void packet_write_fmt(int fd, const char *fmt, ...)
 	write_or_die(fd, buf.buf, buf.len);
 }
 
+int packet_write_fmt_gently(int fd, const char *fmt, ...)
+{
+	static struct strbuf buf = STRBUF_INIT;
+	va_list args;
+
+	strbuf_reset(&buf);
+	va_start(args, fmt);
+	format_packet(&buf, fmt, args);
+	va_end(args);
+	return (write_in_full(fd, buf.buf, buf.len) == buf.len ? 0 : -1);
+}
+
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 {
 	va_list args;
diff --git a/pkt-line.h b/pkt-line.h
index 1902fb3..3caea77 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -23,6 +23,7 @@ void packet_flush(int fd);
 void packet_write_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 
 /*
  * Read a packetized line into the buffer, which must be at least size bytes
-- 
2.9.2

