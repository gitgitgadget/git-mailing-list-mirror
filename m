Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 045BD1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 16:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758108AbcHCQna (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:43:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32974 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757023AbcHCQnD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:43:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so37174030wme.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 09:42:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UUA68dG1v8I8waH/jMqYTaQvDVf/fS77nsUD2frxX44=;
        b=AdN+kZu3sMb44j+mp5onwilub58rKvCcUp2oecjg7s6cLIiuXiNg0FsOPjXnkPugJ+
         2fsQVeUpvqYyRr2CIrxukzJneQv+zfIRV2r10X5n5erNfwQEho0wqmj8PSppXuHtX6v1
         66k4naD6z7LFaIF5m2kOxAQt/0m3R7n4JyqfKZlH5nhZoMgodVuFkmF9QF2/LCPQO/jH
         6mTc0GGO2z8jHxPapcJjqxAKG1p89YmxgoVdectHuTaJmWHsEgAixM04izc57EfpPVTI
         BsidQspAZX3MnAu5WLpR73ZH1hLhRrh64qqmsA8p1XGQ5GItSImAKjFw/J1IL+UwPB9Z
         7BYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UUA68dG1v8I8waH/jMqYTaQvDVf/fS77nsUD2frxX44=;
        b=ieD/l1MKmQFwNPilKwrpAefZs/vCLka58OZNWBwqLpqVyOsWrYdg3/8d/uea/y9/H0
         bqhVnZIHBWpxXU94WUbSaKV0WQ2OLm4q6j9uZdbMYmECygT2/0MrpeI2x6Q8zPqQC89t
         dSbCuctxO/lFzYgko1Nay3x2QNKEWpqXjOoi8ze0xiYTuo+C8X+mj9QsUOtnb+yzvruh
         4J03eemyXrWBC1JM8W9xMIdG6KyK0nJK1dQD2M/xdvUD5zV20wDUmDn0akuk7T8frNct
         YS5hQSvrUlWe1/iibQpLqHE3Ze+KCVsgVNX3iv9+5pDQxawQ65UhIsJ1GwE0pYsIynZv
         0Z1w==
X-Gm-Message-State: AEkoousfm4xixh2yTF3ez6+miLKFS5XToORzKDb2j1oGnJBmcQmX8OY0f+8Pf8Qonvesuw==
X-Received: by 10.28.150.146 with SMTP id y140mr26033851wmd.32.1470242550700;
        Wed, 03 Aug 2016 09:42:30 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 3sm8959736wms.1.2016.08.03.09.42.29
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 09:42:30 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v4 03/12] pkt-line: add packet_flush_gentle()
Date:	Wed,  3 Aug 2016 18:42:16 +0200
Message-Id: <20160803164225.46355-4-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160803164225.46355-1-larsxschneider@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

packet_flush() would die in case of a write error even though for some callers
an error would be acceptable. Add packet_flush_gentle() which writes a pkt-line
flush packet and returns `0` for success and `1` for failure.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 pkt-line.c | 6 ++++++
 pkt-line.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index aa158ba..c8a052a 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -91,6 +91,12 @@ void packet_flush(int fd)
 	write_or_die(fd, "0000", 4);
 }
 
+int packet_flush_gently(int fd)
+{
+	packet_trace("0000", 4, 1);
+	return !write_or_whine_pipe(fd, "0000", 4, "flush packet");
+}
+
 void packet_buf_flush(struct strbuf *buf)
 {
 	packet_trace("0000", 4, 1);
diff --git a/pkt-line.h b/pkt-line.h
index ed64511..2fbaee9 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -23,6 +23,7 @@ void packet_flush(int fd);
 void packet_write(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+int packet_flush_gently(int fd);
 int direct_packet_write(int fd, char *buf, size_t size, int gentle);
 int direct_packet_write_data(int fd, const char *data, size_t size, int gentle);
 
-- 
2.9.0

