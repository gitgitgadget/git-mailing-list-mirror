Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8D4A20705
	for <e@80x24.org>; Thu,  8 Sep 2016 18:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758655AbcIHSV5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 14:21:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33974 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758423AbcIHSVo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 14:21:44 -0400
Received: by mail-wm0-f66.google.com with SMTP id w12so9036360wmf.1
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 11:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JW1b57kgAS2JKOwcjc5VyGruoC1Tr/T/8TXCcgflKS0=;
        b=lcr7QKIEPZjSVJmnRgsaSqc0k/9iXNuMZyCnQpYxyAM0G8I5r/2SyxNegKlVruzczK
         zNKAKtiyV8Rp6A/gUNjndWWQtwFvc7lzP2RzVzScYerxayNtQVXxrOxhym1rHDJvhhvW
         ANx8uXOyHt48O2NlYKvYHqen1vORzhI5e5IQn7UVx/6ikkmmW57//aXs1/nI7indCPEc
         6AafFwCQKThh3LFh9eWMq3q02VR/2fBmSoswUxEak31ER/wjxTHmpyiq2qdxQ33HLd97
         ohbsg7LO/Vt/GtCNQMGg8UKzuy5bcxQKYPNPjUs1vqMvyXh/FtKB/83HQDDkLeVEftDh
         1arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JW1b57kgAS2JKOwcjc5VyGruoC1Tr/T/8TXCcgflKS0=;
        b=Id1osl7DXDtwV+JPxj1M6+6Bqq2UncTCIQIHu4GPcPaTQB9s3nM+njyaf8OpW7vWCj
         CQH2l3LfjMkGnC+s/2tNWKdRTTMHfD9td+qs8VljqPLEhZFxWN0ZgkAX2rOwuoyZXj2T
         xCkdRbYzLXlfWkEYTgWfN8tIprbEPr25cyGeKdP+hKs3G/oKGhOcglvWxXXfZyZW45EP
         cg3sc3nROd10gT7B6wxh/VCReTor09O+CBnHcW/Lq0lcQE9Jey9kOTRFe3jsFGy5d2uw
         QSFlU4QEPwntE6cd2+aH6GMoN9iRqe5xqwwisTf+KpzG2WXHgzLLen4OrPW2TtrcUcxr
         GMoA==
X-Gm-Message-State: AE9vXwP9dBu4sgsPeDaGyK5LEvEJ/jhZBm3oNoyUqYw/ZxSroVKxyn5NPMS0/OGeY3eKag==
X-Received: by 10.28.147.69 with SMTP id v66mr952454wmd.70.1473358903240;
        Thu, 08 Sep 2016 11:21:43 -0700 (PDT)
Received: from slxBook4.local.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id b128sm10967467wmb.21.2016.09.08.11.21.41
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 08 Sep 2016 11:21:42 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        tboegi@web.de, jacob.keller@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v7 04/10] pkt-line: add packet_flush_gently()
Date:   Thu,  8 Sep 2016 20:21:26 +0200
Message-Id: <20160908182132.50788-5-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160908182132.50788-1-larsxschneider@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

packet_flush() would die in case of a write error even though for some
callers an error would be acceptable. Add packet_flush_gently() which
writes a pkt-line flush packet and returns `0` for success and `-1` for
failure.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 pkt-line.c | 9 +++++++++
 pkt-line.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 3824d05..37345ca 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -91,6 +91,15 @@ void packet_flush(int fd)
 	write_or_die(fd, "0000", 4);
 }
 
+int packet_flush_gently(int fd)
+{
+	packet_trace("0000", 4, 1);
+	if (write_in_full(fd, "0000", 4) == 4)
+		return 0;
+	error("flush packet write failed");
+	return -1;
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

