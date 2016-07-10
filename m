Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6AB82018F
	for <e@80x24.org>; Sun, 10 Jul 2016 10:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbcGJKnt (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 06:43:49 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35401 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbcGJKns (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 06:43:48 -0400
Received: by mail-lf0-f66.google.com with SMTP id l89so666159lfi.2
        for <git@vger.kernel.org>; Sun, 10 Jul 2016 03:43:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aVZw8qVQAKYv8AHf3Umv3klQIqK2G7eOvyu1g2ozvV0=;
        b=IsbR7Xhdqwbv0JVj2CXHFRmPtFHiqBliGQKFAQDzlHyYPeTiudrQVfk/f0Gueufo3M
         9UJR6eTvQGq+pK9kPUufZnRwXn0nWNHMKszHLrMCrhDdqpGYkoRhpglQfgXGpxiSmNJu
         YEsiUvhcX7YPLn7ZWZ4pEFnxepyMoKydBGjV+Hbl1o9KujZt8AZ0oR0M2qd3XUmFr2d6
         vtO0i9nTTmXnYHV1Rl47m2KgVinmhrGiByO5Z026L1JSJbtS9khDVfUNu+TO1SKsMCji
         YtQ01QF4XAGHfT0QzRiXp0tdOPasPC6Q2CMDF0hkxb1W/ZU55t262AYF5mgQ4DXB7hUl
         JXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aVZw8qVQAKYv8AHf3Umv3klQIqK2G7eOvyu1g2ozvV0=;
        b=DCqgCizRb7Zlj+mQRj8o6FjVk/dupQKNsnQUO1uIlWohwl4Vd/hU72e6G9gbD8BvBK
         35QpGA2EvJLNpez73t6TQbsDoChPOfSQwyTy2aG6ovPPRLb/G7UGcCZI5B0pNq5LFhSr
         LMg+NZmkKOVEbFjt0U3xvW2+r25PVQ5ob4Cad7uXCSX2hiXrpgERLMD2Op6C87WHHRMM
         mzm7j2RbUkHtBUgecEVc2DPfJRZ+lmyS/lROQg4PUQgoMOR2KQ0QsxLYckz8dx0Hrk91
         8BZPXQ2hC7hOC1+2Oz/2Z1/6gZGEAmar0F7lQy3zjJDFT09S2/elNnywuwUt56B1gHxT
         WU0Q==
X-Gm-Message-State: ALyK8tJ29p2MPUBLZfDTEfLcxiyyuFZTjRJx5edhTPxVSfIn7XWiVHwkpyVROAD8G5vJbQ==
X-Received: by 10.25.24.233 with SMTP id 102mr2630386lfy.187.1468147425914;
        Sun, 10 Jul 2016 03:43:45 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g28sm3513957lji.45.2016.07.10.03.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Jul 2016 03:43:43 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, michelbach94@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/5] pack-objects: do not truncate result in-pack object size on 32-bit systems
Date:	Sun, 10 Jul 2016 12:42:51 +0200
Message-Id: <20160710104251.27335-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.537.g0965dd9
In-Reply-To: <20160705170558.10906-1-pclouds@gmail.com>
References: <20160705170558.10906-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

A typical diff will not show what's going on and you need to see full
functions. The core code is like this, at the end of of write_one()

	e->idx.offset = *offset;
	size = write_object(f, e, *offset);
	if (!size) {
		e->idx.offset = recursing;
		return WRITE_ONE_BREAK;
	}
	written_list[nr_written++] = &e->idx;

	/* make sure off_t is sufficiently large not to wrap */
	if (signed_add_overflows(*offset, size))
		die("pack too large for current definition of off_t");
	*offset += size;

Here we can see that the in-pack object size is returned by
write_object (or indirectly by write_reuse_object). And it's used to
calculate object offsets, which end up in the pack index file,
generated at the end.

If "size" overflows (on 32-bit sytems, unsigned long is 32-bit while
off_t can be 64-bit), we got wrong offsets and produce incorrect .idx
file, which may make it look like the .pack file is corrupted.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index df6ecd5..f854ca4 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -341,8 +341,8 @@ static unsigned long write_no_reuse_object(struct sha1file *f, struct object_ent
 }
 
 /* Return 0 if we will bust the pack-size limit */
-static unsigned long write_reuse_object(struct sha1file *f, struct object_entry *entry,
-					unsigned long limit, int usable_delta)
+static off_t write_reuse_object(struct sha1file *f, struct object_entry *entry,
+				unsigned long limit, int usable_delta)
 {
 	struct packed_git *p = entry->in_pack;
 	struct pack_window *w_curs = NULL;
@@ -415,11 +415,12 @@ static unsigned long write_reuse_object(struct sha1file *f, struct object_entry
 }
 
 /* Return 0 if we will bust the pack-size limit */
-static unsigned long write_object(struct sha1file *f,
-				  struct object_entry *entry,
-				  off_t write_offset)
+static off_t write_object(struct sha1file *f,
+			  struct object_entry *entry,
+			  off_t write_offset)
 {
-	unsigned long limit, len;
+	unsigned long limit;
+	off_t len;
 	int usable_delta, to_reuse;
 
 	if (!pack_to_stdout)
@@ -491,7 +492,7 @@ static enum write_one_status write_one(struct sha1file *f,
 				       struct object_entry *e,
 				       off_t *offset)
 {
-	unsigned long size;
+	off_t size;
 	int recursing;
 
 	/*
-- 
2.8.2.537.g0965dd9

