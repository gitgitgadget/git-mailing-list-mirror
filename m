Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0ABC2021D
	for <e@80x24.org>; Fri, 29 Jul 2016 23:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbcG2XiQ (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 19:38:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35216 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbcG2XiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 19:38:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so17707942wmg.2
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 16:38:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=svEffWz4dN+c+6p7UZTC5p+1McJChkVbRaefWJX2AsY=;
        b=qGJBC7y+0+fJgoqiAaw3gbwJXKpCfFNcbCi5Wfs8WR2VoYQL2gDltp/YC40UOdjYJa
         yhGADXIiWpCJh4ubMTfATZTJ5Em2wjKy1QmvEieKr/Ofn3xE/RtIkHYPN5GDCcsl1qx1
         QMBrqXZDQre8xzxGCJEFSPv6g6wGnBsu/v1bVWbMWfqkfUiDyz2SyDdIq69A+51f6pG/
         7hlViuNLzDYHqzMf52Nlc6pObvqEKbybs9AbL6TlWNLMdK6SdVYr+ioONSGohJGXTU2y
         qyw+bWTcUYyta4lg+qwgm/Ul322+YJF+be2bP0evLgiQX0AjJoSKSZeFl6ziSKBOzqnb
         t7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=svEffWz4dN+c+6p7UZTC5p+1McJChkVbRaefWJX2AsY=;
        b=QS7ld4nt4SMk0L8k78iFmIj66Z5pg4/CdzZJR6iMIZuml0ZQ9fYPQAUz0V4FeRIwTp
         v3u4qIhK+PW6G9VRKRJEFvSmcXdCsq0MdUy5f6nSbf0N0O1sdrOzy6nCEMQJE+Hr2rzQ
         4xIP8vabrLiwQLpN4hA9OGpOd9fPt4UYdk7zFp3zjEaeOS9v3cEe05XznK2HJu/VjfWJ
         O8EB2mGdE1J/d4HEWu+EuCDHkTKYB6WJnGAJI+m99QlDI9OB2SofEk+2TFta3UbfFDJC
         I3Mhc5T9GqcAIIXppEKxXHzl8kwSNHFxhxOkoMiz448A0C9klY2wk+OM6l/05/eWecM1
         SPTA==
X-Gm-Message-State: AEkoouvy03uWZvgxTxmeybsJRZrihmSXQlp+dvrYfY8nHIC8Kcwn85S2J09gA4nMKbCD6A==
X-Received: by 10.28.155.212 with SMTP id d203mr46550797wme.103.1469835487966;
        Fri, 29 Jul 2016 16:38:07 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB4145.dip0.t-ipconnect.de. [93.219.65.69])
        by smtp.gmail.com with ESMTPSA id i1sm18663212wjl.9.2016.07.29.16.38.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 16:38:07 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v3 03/10] pkt-line: add packet_flush_gentle()
Date:	Sat, 30 Jul 2016 01:37:54 +0200
Message-Id: <20160729233801.82844-4-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160729233801.82844-1-larsxschneider@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
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
index 6fae508..1728690 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -91,6 +91,12 @@ void packet_flush(int fd)
 	write_or_die(fd, "0000", 4);
 }
 
+int packet_flush_gentle(int fd)
+{
+	packet_trace("0000", 4, 1);
+	return !write_or_whine_pipe(fd, "0000", 4, "flush packet");
+}
+
 void packet_buf_flush(struct strbuf *buf)
 {
 	packet_trace("0000", 4, 1);
diff --git a/pkt-line.h b/pkt-line.h
index 02dcced..3953c98 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -23,6 +23,7 @@ void packet_flush(int fd);
 void packet_write(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+int packet_flush_gentle(int fd);
 int direct_packet_write(int fd, char *buf, size_t size, int gentle);
 int direct_packet_write_data(int fd, const char *buf, size_t size, int gentle);
 
-- 
2.9.0

