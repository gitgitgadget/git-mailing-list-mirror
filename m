Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71AC92079F
	for <e@80x24.org>; Tue,  6 Dec 2016 12:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752475AbcLFMyV (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 07:54:21 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34122 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752657AbcLFMyS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 07:54:18 -0500
Received: by mail-pf0-f193.google.com with SMTP id y68so18720760pfb.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 04:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fkV95VMsQL3jeBBv3zaAuDiT+YinCNePNGRhwzmtmQw=;
        b=ja/9OCJhIfgU5uxHl2ScmEixxlKyXKaxP1ubQC4GZMxZQiTzIHvz5Lrb1vbp5nzd58
         rRFH0/7sSqGj/F+tQ5/EPKb283iNJDKJLwoXHWwSJk2cCqdy/sx81Gt+GNE2B6ZvhllR
         t2xrh/YP0/rvPlNDpj7MjvqB4xK+BnCARcqIheGHqEc6QS5eBCnHDcQxbd3GV+ckRUO5
         oY83SD0b6FwqKsOpjW5B7Ey1mGie4dB7UclkbC3BKL+fZ0EBPH5hjPR8B5/YZ7NexRkT
         AdIr8NY0fpusV/03xpTVlZ+jG5BtWXCeCK7eAQQgDW/KAyCLYcU2zWx4DUm1lRezUfp0
         kcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fkV95VMsQL3jeBBv3zaAuDiT+YinCNePNGRhwzmtmQw=;
        b=Dib+r2WjnpLGk7Z9oGASnqdZn+ZtJ2dyGkXJCi3vspNJPmWgCXLrMYhiGasnXX1lME
         wwZeHZikEZP2ztKJa9HDWeKC7fjxvs2poMLtZNs/GOsyw//Xhd5CF3rwPWdZx3m43JVn
         BNaM63WCj+MHX4BQDsMk0Id5H25avIH10P01W4y3wDVVX1QElpvge8mzJC0jNUBPViML
         Yr/tSK4jLkOthXFZgIrGEmKhmIBUFp9ZPWYctNRR6g4QsKi/vMyio94eYhWSPceZ2yjz
         A6i/uHtdQ+PkHiGQn/dd1Rbbvx8nv3OGp1SvCDY+JQlsBKcIUU9y2tEKn/gDrJVT1vZI
         G9Lw==
X-Gm-Message-State: AKaTC03JurIcFDjIOg1hvWixtH8Z6A5C6P9UsI/pQ2W0FPKp/UMXSDshTdIz790qgitX8g==
X-Received: by 10.84.164.162 with SMTP id w31mr136599553pla.9.1481028857879;
        Tue, 06 Dec 2016 04:54:17 -0800 (PST)
Received: from ash ([115.73.166.29])
        by smtp.gmail.com with ESMTPSA id y15sm34946752pgc.43.2016.12.06.04.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2016 04:54:17 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 06 Dec 2016 19:54:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     rv@rasmusvillemoes.dk, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 5/6] shallow.c: bit manipulation tweaks
Date:   Tue,  6 Dec 2016 19:53:38 +0700
Message-Id: <20161206125339.16803-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161206125339.16803-1-pclouds@gmail.com>
References: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
 <20161206125339.16803-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rasmus Villemoes <rv@rasmusvillemoes.dk>

First of all, 1 << 31 is technically undefined behaviour, so let's just
use an unsigned literal.

If i is 'signed int' and gcc doesn't know that i is positive, gcc
generates code to compute the C99-mandated values of "i / 32" and "i %
32", which is a lot more complicated than simple a simple shifts/mask.

The only caller of paint_down actually passes an "unsigned int" value,
but the prototype of paint_down causes (completely well-defined)
conversion to signed int, and gcc has no way of knowing that the
converted value is non-negative. Just make the id parameter unsigned.

In update_refstatus, the change in generated code is much smaller,
presumably because gcc is smart enough to see that i starts as 0 and is
only incremented, so it is allowed (per the UD of signed overflow) to
assume that i is always non-negative. But let's just help less smart
compilers generate good code anyway.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 shallow.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/shallow.c b/shallow.c
index 719f699..beb967e 100644
--- a/shallow.c
+++ b/shallow.c
@@ -467,7 +467,7 @@ static uint32_t *paint_alloc(struct paint_info *info)
  * all walked commits.
  */
 static void paint_down(struct paint_info *info, const unsigned char *sha1,
-		       int id)
+		       unsigned int id)
 {
 	unsigned int i, nr;
 	struct commit_list *head = NULL;
@@ -479,7 +479,7 @@ static void paint_down(struct paint_info *info, const unsigned char *sha1,
 	if (!c)
 		return;
 	memset(bitmap, 0, bitmap_size);
-	bitmap[id / 32] |= (1 << (id % 32));
+	bitmap[id / 32] |= (1U << (id % 32));
 	commit_list_insert(c, &head);
 	while (head) {
 		struct commit_list *p;
@@ -653,11 +653,11 @@ static int add_ref(const char *refname, const struct object_id *oid,
 
 static void update_refstatus(int *ref_status, int nr, uint32_t *bitmap)
 {
-	int i;
+	unsigned int i;
 	if (!ref_status)
 		return;
 	for (i = 0; i < nr; i++)
-		if (bitmap[i / 32] & (1 << (i % 32)))
+		if (bitmap[i / 32] & (1U << (i % 32)))
 			ref_status[i]++;
 }
 
-- 
2.8.2.524.g6ff3d78

