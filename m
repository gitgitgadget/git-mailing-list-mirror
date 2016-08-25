Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C0F42018E
	for <e@80x24.org>; Thu, 25 Aug 2016 12:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753343AbcHYMrW (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 08:47:22 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36737 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752567AbcHYMrV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 08:47:21 -0400
Received: by mail-wm0-f44.google.com with SMTP id q128so237694154wma.1
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 05:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jfqw123V2ectRYsITEAMBV0ojTDwJ34Wvo3OsgWWtjY=;
        b=GfsEktiYpzaqUtVxI7CBkDY2wY3c4nl2Qm1Iyx2B06E9M4eipsAFgb79o9nob6Drem
         5qou//bt2yQeVTwBB0FfKDpRNjg8KN4XV+FFeb9HkpvgUb/frPo4qZ7GSJ6OgirNuA9r
         p9n1SeSq6cBC2Uo5y0/TEyMC+lSxToGWa4c5Cm4BHFWbixIUGD04a7/ugbQw9uENrEqP
         Oeva2g82HFcAoPFn+TyUyU5pCVlvItVx/9NPVovDYkLrC3uRC73CdTsTUbFhXcsBnwc8
         I9z0OurZBikBfvVe0ZlN6o2eRq9CSVwSORHb/oQOkS1tHQT98aXiZ7KHUPqm8O+YrtCw
         CojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jfqw123V2ectRYsITEAMBV0ojTDwJ34Wvo3OsgWWtjY=;
        b=bRJ4qUbl9mFuNsOrJ1sWU5VQ7CScW4R3mLoSLjxzgq8gyil/8LTtiOCwY5CMMnhU3P
         LKOYcKb3JAsLxCMJmQl7G2MOA6SCUuoibZlm0lV+TWDsN6oJSvO5hv8i9X0HnE/zaZ5r
         JRh1rjOE9SLNkMWVvkoppC91tl2QsFoVBb9f6N9TzyCBK9kJP+TlbyA81EK6SzmV9mkd
         umcrbEQOAaA5tTYm/zLzSlxCT4XDyofITUiVQqQo0G4vPGzzhsf3PLi5z/Q8zQtfbSh6
         TRqQDefQuRqZp36TKz+QoKJkswdeMXCjaRdNIF9WSsWNUl24EVDyqX0AP7aFkvWU5FBn
         QpLg==
X-Gm-Message-State: AEkoouvaMyZhNsn3KYxHDzslVbBIUsB5EjJvb72P326XtpCw49v8GSAPPU2zhEbN0KakNw==
X-Received: by 10.194.62.70 with SMTP id w6mr6902154wjr.130.1472123282160;
        Thu, 25 Aug 2016 04:08:02 -0700 (PDT)
Received: from bcnf9f9l32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id p71sm38304839wmf.9.2016.08.25.04.08.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 25 Aug 2016 04:08:01 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v6 04/13] pkt-line: add packet_flush_gently()
Date:   Thu, 25 Aug 2016 13:07:43 +0200
Message-Id: <20160825110752.31581-5-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160825110752.31581-1-larsxschneider@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com>
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
 pkt-line.c | 6 ++++++
 pkt-line.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 3e8b2fb..cad26df 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -91,6 +91,12 @@ void packet_flush(int fd)
 	write_or_die(fd, "0000", 4);
 }
 
+int packet_flush_gently(int fd)
+{
+	packet_trace("0000", 4, 1);
+	return (write_in_full(fd, "0000", 4) == 4 ? 0 : -1);
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
2.9.2

