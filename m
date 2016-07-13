Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 758352018F
	for <e@80x24.org>; Wed, 13 Jul 2016 15:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbcGMPo5 (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 11:44:57 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34138 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbcGMPo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 11:44:56 -0400
Received: by mail-lf0-f65.google.com with SMTP id a10so3970496lfb.1
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 08:44:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mA1NlssqJCYzdmFeNds49CXTMtSBJ8zmBK7Qv4SjcvI=;
        b=QYFOHgzcHISFxVWBRaocIz91hD0wPUWMSUg1yPG49bkHuUg2IJRJGd6FPmqoa/w8lb
         DV3bVqo14YmjHB7evZsziWZ8BiW9iMWmphb2NpVE24Dj4khCRTJ73oMlst9bC85xQUgA
         EtoxiMYGLe5GLGi0CjJPJgjtICFUJtHPlr3gjGCAf7dvgfqJKU96h3CVbeGY/WZHrc4q
         zapDKAYRCxLqJJKgda0FRmTwEFdZNJdfzxlxWjofgF5A48q5S+s8HZVZdk+XKByF9Zgn
         QsuM3jlgeYzavX4/qmW6VgrRlkeZOGjN484/QJQ0gYCH6Mr1RsYLrnh3q4MuxjTgfRI7
         Ywng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mA1NlssqJCYzdmFeNds49CXTMtSBJ8zmBK7Qv4SjcvI=;
        b=ex1phAIZvrrzSYvRiPcRaN/ntWApWa9NqBvA+6sMIuahqhoG/Qw2gEMa/Yn2R9180Z
         pb52A12YltKzE7zpbYr8fNdJWkbYB15k1/EB3Gwt96iwC4N6nYkagh8Zj4y+DWHMmfAT
         vniiHaFoaXuw3R4/C+rrhGxj5UQg+pQnY+rVmHP/eBctBVhS7i5J6mpxdAVJ8BQwFdNN
         MnugaGtR/Zl6WQFm3XyLMma5XkCNU0KER+L5ruiA8Hbt8bhNPQnNypgFF8+tNdpoCMmj
         hXMjaPjoL6ui98JimWQOl9kGMfS+A9VkqY3LxA//YyN49InKzJwQ0uuTqJGJQveHmB4Y
         JY9A==
X-Gm-Message-State: ALyK8tK4ioPWmH2mvozs1jpOAGNrDqfE8K/dv+kPS9E5ss2Sac/OFAiIzkpTx66gW27kOQ==
X-Received: by 10.25.143.149 with SMTP id r143mr4926085lfd.165.1468424659719;
        Wed, 13 Jul 2016 08:44:19 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 90sm2575484lfw.30.2016.07.13.08.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jul 2016 08:44:18 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, michelbach94@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 6/7] pack-objects: do not truncate result in-pack object size on 32-bit systems
Date:	Wed, 13 Jul 2016 17:44:03 +0200
Message-Id: <20160713154404.22909-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.9.1.564.gb2f7278
In-Reply-To: <20160713154404.22909-1-pclouds@gmail.com>
References: <20160705170558.10906-1-pclouds@gmail.com>
 <20160713154404.22909-1-pclouds@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-objects.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a3a98c5..ac7a3a5 100644
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
2.9.1.564.gb2f7278

