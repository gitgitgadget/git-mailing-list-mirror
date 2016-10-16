Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8D302098B
	for <e@80x24.org>; Sun, 16 Oct 2016 23:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756992AbcJPXVU (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 19:21:20 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33112 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756972AbcJPXVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 19:21:16 -0400
Received: by mail-pf0-f194.google.com with SMTP id i85so8093678pfa.0
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 16:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o6Lg0Z6S9nQOfGaApobmqUYu6f/1vq5DjfcUkP1rQKY=;
        b=SlEDshnC4ysNJfTV8ohzYGl3yB6mhVVFBG8NlikpYejwsQgxZ9L6vAFJznjnHIUt85
         OcWxZElffx4exaSzZwXSE3nTCjwedf+X+RcMvGtPAD+vIl/ojHdOv8/DlK52au1n1d2/
         m2Yq8/2XFJja0M0eB2I32mjUmUJhZjfZl/Ur+mxfdCm3Lh9uaXZ/wCJeZ1UHQ4p/lYzX
         jMdOVcin1zTNqPnedIZ2xYX5jQaEpMS1yrspk7ppd7xG0my4r42feDPI4PQU/ApInZQW
         i4DRoGolk2VM6nu4FaSh2latKsVVOh/JMU/jPQFXAUKP/jbqV88Szf+/C1qsUq0+vgK9
         9MBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o6Lg0Z6S9nQOfGaApobmqUYu6f/1vq5DjfcUkP1rQKY=;
        b=MckXU6X5fqYDk8W/rCl2RbwtdlNJMhQvcHJtLZbvNuCnchqma+zIL4UZG+f3jtIHEW
         NCAKOmHrQAYCPNgJLQXYf93Rb5M4HuMeauMuxjloAV1IRziU4SYxsUOHEGQhV0KWHH3o
         UbqtRODzklx+xnO0veOQMKWtVF6OFJF1N/J7svOf3P+pKl7jnKuu+2kOpkBc446dBDJu
         gPkS3cBgibsJkQGcqA8LnW6biw58v8WAJhwPYk6oNK3/ZTNYX3v1uWXp2o7NDS9mXT3m
         7fuAEBoL8PEfFBLsGQZh5Jw4FLH4IQiDCBiDraWIxtzIdJHksTqtOcwgqZfqNq7lSE8Y
         RmXw==
X-Gm-Message-State: AA6/9Rmz0rwHoDu/eoj4zoKdoKz6ZzGoTO/XQixqg8VNSkYHw6Uo0P9O2O9GnVW4vl/7mw==
X-Received: by 10.99.153.17 with SMTP id d17mr27882638pge.122.1476660075418;
        Sun, 16 Oct 2016 16:21:15 -0700 (PDT)
Received: from rem3n8pj12.ads.autodesk.com (adsk-nat-ip4.autodesk.com. [132.188.71.4])
        by smtp.gmail.com with ESMTPSA id cp2sm10325691pad.3.2016.10.16.16.21.11
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 16 Oct 2016 16:21:11 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, tboegi@web.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 08/14] pkt-line: add packet_flush_gently()
Date:   Sun, 16 Oct 2016 16:20:32 -0700
Message-Id: <20161016232038.84951-9-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161016232038.84951-1-larsxschneider@gmail.com>
References: <20161016232038.84951-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

packet_flush() would die in case of a write error even though for some
callers an error would be acceptable. Add packet_flush_gently() which
writes a pkt-line flush packet like packet_flush() but does not die in
case of an error. The function is used in a subsequent patch.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pkt-line.c | 8 ++++++++
 pkt-line.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 56915f0..286eb09 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -91,6 +91,14 @@ void packet_flush(int fd)
 	write_or_die(fd, "0000", 4);
 }
 
+int packet_flush_gently(int fd)
+{
+	packet_trace("0000", 4, 1);
+	if (write_in_full(fd, "0000", 4) == 4)
+		return 0;
+	return error("flush packet write failed");
+}
+
 void packet_buf_flush(struct strbuf *buf)
 {
 	packet_trace("0000", 4, 1);
diff --git a/pkt-line.h b/pkt-line.h
index 3caea77..3fa0899 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -23,6 +23,7 @@ void packet_flush(int fd);
 void packet_write_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 
 /*
-- 
2.10.0

