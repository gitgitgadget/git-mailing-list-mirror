Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15E3720986
	for <e@80x24.org>; Tue,  4 Oct 2016 13:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754077AbcJDNAW (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 09:00:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35668 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754111AbcJDNAB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 09:00:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id f193so14972801wmg.2
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 06:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o6Lg0Z6S9nQOfGaApobmqUYu6f/1vq5DjfcUkP1rQKY=;
        b=swnQFl04zNzv6g1JxM/BYmNZn3bHbJuqo3AWNtxmCmdMRJF7HwChwKDuZZ7L+h/dMy
         Jz/OX5djTeeZBApWX8zOeNmDTWJcYCBQVy4t46meGsV7fgoYmYMomHWbpS0CV3Yl9YPb
         wu0wJfySXJLLXF91H5EVtXZ38gVjmlnrK3PbTkX1t997Q/CWNWkUHnIpXwNgBUd2zj6r
         LmkkZozY8+xvXHI1EmeHFhBuzwaYFB7+nvUPLto3S1h/1xGbyQtw6LYcUAPYpa8jNM/2
         o87Y23pDcuMe7jOpA4ynQ61i+VK0SV/GSCcuA+Vgr74SecvtDrASukQL7w0X/PF09P8i
         qtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o6Lg0Z6S9nQOfGaApobmqUYu6f/1vq5DjfcUkP1rQKY=;
        b=jYy3aNnPmOeTm+uKWbvTCA17EBRgGVi0RlgHCH6EOhmQwsgYKAP1GA3KNnOLK+8bE5
         CSaKnNe8MOCJo07qazuzTBlSXDB0Rg25uwqnPDsZ+u2A4pGkc/86/frjjdEol/G2E+4q
         x07IbD7p0DJSnZOxgc1srSraV/yFQIcKtUwOSUryJxzGaco4Ez02dVIZKWxaO8Qpgto7
         70QwIJUIfnTJEg8D95VY7uHwGFJubySKGEDYZngTB5jS7iiSf0f24QuAzBQKAI2mBuDx
         DJ4vXYzHP77LGtCnrP+yYqqTstBHmTnOUJCg4xs7FKYdJutSMhlgOoQjkiSIMHL0Mne7
         r2Pg==
X-Gm-Message-State: AA6/9RmvBr+fbyq+hC2Y3vAbgPeZRG+8PRxysPuzDogjPWSP+0A5TLqmKuhV6F4NcgBGnA==
X-Received: by 10.28.131.199 with SMTP id f190mr16646769wmd.30.1475585999874;
        Tue, 04 Oct 2016 05:59:59 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id qo8sm3426934wjc.46.2016.10.04.05.59.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 04 Oct 2016 05:59:59 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     ramsay@ramsayjones.plus.com, jnareb@gmail.com, gitster@pobox.com,
        j6t@kdbg.org, tboegi@web.de, peff@peff.net, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v9 08/14] pkt-line: add packet_flush_gently()
Date:   Tue,  4 Oct 2016 14:59:41 +0200
Message-Id: <20161004125947.67104-9-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161004125947.67104-1-larsxschneider@gmail.com>
References: <20161004125947.67104-1-larsxschneider@gmail.com>
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

