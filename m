Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0057209A9
	for <e@80x24.org>; Tue, 20 Sep 2016 19:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932953AbcITTDH (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 15:03:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34701 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932887AbcITTC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 15:02:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id l132so4895453wmf.1
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 12:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2+MY+gXh8enjP9ehZz7N90xwXJvliUyArUE6N8NXo44=;
        b=m0FEkm3E3q/cxEp6DToJ5lpJ0J7CJ+xjz32rQSIxt01sgRKzcbVE3MH/CDYijDcSr2
         4OiiWQ9cpXMnXUn2FpnJucqV5RUKW0VQxFhLuxovT+qBb94Ky0gzj34Qjil4+8RbuuFj
         r46U0Kf6u3CFUb1EWkarzEji+WBuMCTrDoYZw2fvH6oHmqYHdh4X/KLRPCPf3i5d7orj
         io3I4ZgHiOIM2B4e5hILw3kNX9JJbHstZMKKfzVxrUVP7PPIszUW2mU/eckAlcFEUxcV
         17HEZxnhU+LEy/BVQXlMAYefMaSoNWHG9JbjkLCN/wkHYnexGjrxLaonb2Tho4T8qtUi
         /3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2+MY+gXh8enjP9ehZz7N90xwXJvliUyArUE6N8NXo44=;
        b=DZp2K+3RXdzAWJPnqp3Z7xoj9cpebpGOM+1Uc0GAVe2wwfXT8R5+GTLHO2E33PMFhg
         gBQiQwpCUr8X6i8JDoXy4emUr2nQ52pSnhoNFteysVcnQnSm9eqDvigXsLcyfMIm0Wa5
         evTt26eGZ+YBxTuRHHbeeujrKib/+WvyXz6B3KVUSTru2ViMOC5MQtIMTbO7YUzEw1VA
         MKe8ZQLhyl0ZqFdUOM1Ld3bzE9IgzQjzXRu7oZlPP0shqOly3I5gZ3DN1z74ttYzD4hX
         fRy3uiab2FVjEggCPDOn1HfbGzDB9hH9uXUF/ZblXBihAsqd6V057qg+XZBZLnR+Oiag
         2Vhg==
X-Gm-Message-State: AE9vXwPPEfIFzNuTA87Cxq8CkNEuBlZ5mQX1WUb98R9ah64WcRwz1yAwSuCrYlpXZz/LqA==
X-Received: by 10.194.206.68 with SMTP id lm4mr31269520wjc.106.1474398176557;
        Tue, 20 Sep 2016 12:02:56 -0700 (PDT)
Received: from slxBook4.fritz.box (p508BA5EF.dip0.t-ipconnect.de. [80.139.165.239])
        by smtp.gmail.com with ESMTPSA id gg10sm29820728wjd.4.2016.09.20.12.02.55
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 20 Sep 2016 12:02:56 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        jnareb@gmail.com, mlbright@gmail.com, tboegi@web.de,
        ramsay@ramsayjones.plus.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v8 05/11] pkt-line: add packet_flush_gently()
Date:   Tue, 20 Sep 2016 21:02:41 +0200
Message-Id: <20160920190247.82189-6-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160920190247.82189-1-larsxschneider@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
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
---
 pkt-line.c | 8 ++++++++
 pkt-line.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 3b465fd..19f0271 100644
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

