Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA8EF2018E
	for <e@80x24.org>; Wed, 10 Aug 2016 18:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938914AbcHJS5G (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:57:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35901 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938900AbcHJS5E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:57:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id i138so11307129wmf.3
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 11:57:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0JrcXa0OVg5JQuEpcPzqHatfLAiRw8JJyKKEIOUjAhU=;
        b=H9RTAE8KEtFX9ffFcEe1eZIw1pfjb+17eOa6RXfftkz5OWR1tr8KJ9D4MxiAbcW5CO
         ZgLC8Yb+lgFrv+1+GJygHc8yuNqYlVjplLFKbYuGXqaVYbRBdNmngSXYULpd48g20bcD
         NZyoIPEjSidGLxQsvTRJCzWhuLE4pqQIcyFlQCvW7LZqTb24ZbP/VJdWBJX2L54hRTXM
         yY/BpnOtG8taPRdU6KFFpwdRveP1Os+jHBbY38TJhua2LWAt0l6/HcmSRfvlMloeRtjD
         idGpeU51I3Gf3lEfpp8GUledGxmNTvWjOCoAIU4RyyAL1phm4grroasbPmP6Ct4lk6nA
         5h2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0JrcXa0OVg5JQuEpcPzqHatfLAiRw8JJyKKEIOUjAhU=;
        b=k7AkWlQSzLT2AGFWf6HpH1vA/8qtGqHgK7SWTvyPBuyFG9gFGoZx8VzkKqbavRs8G/
         D0XnY13PP3n+twONsbrlsif6EASTsIpvyuysDBMj/UA54qGdAbxyAxbs9SVHS7QD7z7d
         4Szt6sjFuBNVqroxJQoxNn1907WRzI7h0AKfJQS7q+P5ZbLshg0Hk9YPdY9GErAn0YCP
         zeOSR77cvBGS925rvxp2Pi5kEhvWFxYeMCQDfX0QK85yTvjMqkn1/vOgX1IIv3eGBMtG
         fboO9xXwM/5aVDrLwrRyuPf+/XQHYjr0V5BI6cZc1tUZkP354LmyIbOnQtF1Zpfptpos
         rV+A==
X-Gm-Message-State: AEkoouvbn6H4qFwCxrptRab8AnRiO71mpJ2fmCe/XvVKUgWQRN2HiLre3WBiKxEGB7+ftA==
X-Received: by 10.195.11.104 with SMTP id eh8mr3906392wjd.128.1470834258784;
        Wed, 10 Aug 2016 06:04:18 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p83sm8319899wma.18.2016.08.10.06.04.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 06:04:18 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, mlbright@gmail.com,
	e@80x24.org, peff@peff.net, Johannes.Schindelin@gmx.de,
	ben@wijen.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v5 05/15] pkt-line: add packet_write_gently_fmt()
Date:	Wed, 10 Aug 2016 15:04:01 +0200
Message-Id: <20160810130411.12419-6-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160810130411.12419-1-larsxschneider@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

packet_write() would die in case of a write error even though for some callers
an error would be acceptable. Add packet_write_gently_fmt() which writes a
formatted pkt-line and returns `0` for success and `-1` for an error.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 pkt-line.c | 13 +++++++++++++
 pkt-line.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 4f25748..a8207dd 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -142,6 +142,19 @@ void packet_write(int fd, const char *fmt, ...)
 	write_or_die(fd, buf.buf, buf.len);
 }
 
+int packet_write_gently_fmt(int fd, const char *fmt, ...)
+{
+	static struct strbuf buf = STRBUF_INIT;
+	va_list args;
+
+	strbuf_reset(&buf);
+	va_start(args, fmt);
+	format_packet(1, &buf, fmt, args);
+	va_end(args);
+	packet_trace(buf.buf + 4, buf.len - 4, 1);
+	return (write_in_full(fd, buf.buf, buf.len) == buf.len ? 0 : -1);
+}
+
 int packet_write_gently(const int fd_out, const char *buf, size_t size)
 {
 	if (size > PKTLINE_DATA_MAXLEN)
diff --git a/pkt-line.h b/pkt-line.h
index 88584f1..82676f4 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -23,6 +23,7 @@ void packet_flush(int fd);
 void packet_write(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+int packet_write_gently_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 
 /*
  * Read a packetized line into the buffer, which must be at least size bytes
-- 
2.9.2

