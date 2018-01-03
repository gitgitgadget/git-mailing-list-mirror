Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC2CD1F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbeACATB (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:19:01 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:36529 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbeACASq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:18:46 -0500
Received: by mail-it0-f65.google.com with SMTP id d16so53176itj.1
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1jDFJ7ibtVX9E1mIufvWqPdD1ZmhJhceIzNWytDXugU=;
        b=LyYtMkH7UUEJtVwV9jYpvnUra2wbm2WTe3GpBqrdP7NLRpT5T6taiiekgbXZnDcfDr
         x//wV6oHnWKoCM497oeUCiEQ4dDI6aF1/fH8riwe4765++XCQPw4RQ1nfKtpiI+V7jKK
         8/Cpxo0UZG3bGbYt2IXEeVgweYzNkYZNi+r/byXw1v0tOtdu+oKMi136MJXSWNbEWM8o
         7RVACJxXR8/xswDz09Nz7Fw/MQq/07H4w1jznEe9qQtHtBqGyZKOY3Y/aSF/XJuK3+rQ
         siW/upXa/eI/2cfrw58LTn1vDNlZYu8Pi3Q3AInM5egI67UEqeTmO5IwITCZEukxU0Gt
         kfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1jDFJ7ibtVX9E1mIufvWqPdD1ZmhJhceIzNWytDXugU=;
        b=jmTYxYKNzDEtAGU5mqE0eR4Rx84B3ay6uEs0mS+osk3nh6YSSDJr/RKEeqa0TuZMy7
         KdPLTM3di5zmUjA/pcPv1NDzTu8UcdTV/ATViTEbdaGjQuYwjo13io2b1LneLRLhpKyw
         p8YAqK9uyjp6IZ24Zn/7JLF8Qb4NS+ndJU2r9xT01rSZR/KEZ8o+wtUgw+xBehv6VnuX
         sxqJebxVBOd5tp6JbCpRQwdVvON7oeyttZhNHMXYOZEgIrabo2qSsJ4xwzT7yPzIvCul
         1JrTiSqz2c2pLdPYAsLzo0ujVpRMlvYq0JCakO46Lsahcp8nQxabOPMpXTjJp22PyAb6
         ZOVg==
X-Gm-Message-State: AKGB3mKGRaXIZ6K0Sww5jiek43gP2OepieqOZCiz0smxgNfpr7trMmg2
        GNjgTHkD/Jk3DA9iyVKJWIy8t2MPtpk=
X-Google-Smtp-Source: ACJfBotNdhq81HCqAIyEJbpQ9KNEIPFpt+mdLjhu3RMH3pkPhMiOGxZU9wLwFnL58txiYTkUts5tjw==
X-Received: by 10.36.245.200 with SMTP id k191mr26947ith.20.1514938724830;
        Tue, 02 Jan 2018 16:18:44 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.18.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:18:44 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 03/26] pkt-line: add delim packet support
Date:   Tue,  2 Jan 2018 16:18:05 -0800
Message-Id: <20180103001828.205012-4-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the design goals of protocol-v2 is to improve the semantics of
flush packets.  Currently in protocol-v1, flush packets are used both to
indicate a break in a list of packet lines as well as an indication that
one side has finished speaking.  This makes it particularly difficult
to implement proxies as a proxy would need to completely understand git
protocol instead of simply looking for a flush packet.

To do this, introduce the special deliminator packet '0001'.  A delim
packet can then be used as a deliminator between lists of packet lines
while flush packets can be reserved to indicate the end of a response.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pkt-line.c | 19 ++++++++++++++++++-
 pkt-line.h |  3 +++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/pkt-line.c b/pkt-line.c
index 98c2d7d68..3159cbe10 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -91,6 +91,12 @@ void packet_flush(int fd)
 	write_or_die(fd, "0000", 4);
 }
 
+void packet_delim(int fd)
+{
+	packet_trace("0001", 4, 1);
+	write_or_die(fd, "0001", 4);
+}
+
 int packet_flush_gently(int fd)
 {
 	packet_trace("0000", 4, 1);
@@ -105,6 +111,12 @@ void packet_buf_flush(struct strbuf *buf)
 	strbuf_add(buf, "0000", 4);
 }
 
+void packet_buf_delim(struct strbuf *buf)
+{
+	packet_trace("0001", 4, 1);
+	strbuf_add(buf, "0001", 4);
+}
+
 static void set_packet_header(char *buf, const int size)
 {
 	static char hexchar[] = "0123456789abcdef";
@@ -297,7 +309,10 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer, size_
 	if (len == 0) {
 		packet_trace("0000", 4, 0);
 		return PACKET_READ_FLUSH;
-	} else if (len >= 1 && len <= 3) {
+	} else if (len == 1) {
+		packet_trace("0001", 4, 0);
+		return PACKET_READ_DELIM;
+	} else if (len >= 2 && len <= 3) {
 		die("protocol error: bad line length character: %.4s", linelen);
 	}
 
@@ -333,6 +348,7 @@ int packet_read(int fd, char **src_buffer, size_t *src_len,
 		break;
 	case PACKET_READ_NORMAL:
 		break;
+	case PACKET_READ_DELIM:
 	case PACKET_READ_FLUSH:
 		pktlen = 0;
 		break;
@@ -445,6 +461,7 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader)
 	case PACKET_READ_NORMAL:
 		reader->line = reader->buffer;
 		break;
+	case PACKET_READ_DELIM:
 	case PACKET_READ_FLUSH:
 		reader->pktlen = 0;
 		reader->line = NULL;
diff --git a/pkt-line.h b/pkt-line.h
index c446e886a..97b6dd1c7 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -20,8 +20,10 @@
  * side can't, we stay with pure read/write interfaces.
  */
 void packet_flush(int fd);
+void packet_delim(int fd);
 void packet_write_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
+void packet_buf_delim(struct strbuf *buf);
 void packet_write(int fd_out, const char *buf, size_t size);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int packet_flush_gently(int fd);
@@ -75,6 +77,7 @@ enum packet_read_status {
 	PACKET_READ_EOF = -1,
 	PACKET_READ_NORMAL,
 	PACKET_READ_FLUSH,
+	PACKET_READ_DELIM,
 };
 enum packet_read_status packet_read_with_status(int fd, char **src_buffer, size_t *src_len,
 						char *buffer, unsigned size, int *pktlen,
-- 
2.15.1.620.gb9897f4670-goog

