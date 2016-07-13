Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EFF320196
	for <e@80x24.org>; Wed, 13 Jul 2016 15:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbcGMPpI (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 11:45:08 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36446 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbcGMPpF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 11:45:05 -0400
Received: by mail-lf0-f67.google.com with SMTP id 33so3970402lfw.3
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 08:45:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8yIKwz81qnf/fb0uPBiLbJ7V0dlD1+Lo00ErBp52yu8=;
        b=cqbJ5irG7fDGtmILUnn2LKjZ//IHRaBqnpXs2d65+9iagZ3Hh1jXL1jhel/Yr5fizS
         7HBQfoXGo747x88ntgjFoRbfZZg6M7iis4RzXSRynEX6RlpOWQzzDA3SSOIONumo0zYe
         nZO2wsGW9ku+CtXl8AGU10qNj6Pe4xS5pnhn9MGHPUpV5HzMSGSnx7y1P4WS/eS4GDhb
         wfsJuLMo27c7WvHoKcpEVYBmsgJj/jGNwmaLXH8JigI8I91/h0f/yOaxy1EolHG8s98l
         CAsw3q9ANOrFfEue7WRgwTo9eBtpuJ693nDakcGxZRqtozkCWTI26GXEXkHFaqF0k40Q
         t9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8yIKwz81qnf/fb0uPBiLbJ7V0dlD1+Lo00ErBp52yu8=;
        b=Yp5gJMxCVIZStjNzC1EL3hl6/Bcg9DkAFiWjeTU4z4yDNRzdK/h9yd3G6RB6JoBA/G
         agpV2IYYAZbTOZcD3DBOyGs0/HPPsG8Krln44ZC82tYQHR+uvrmRQshMveMHxmVsGeBh
         p/j5abB4lbBqH/xvI/T6YZCn6gzdOSQ+tbE+BzTwtHT0FshIrHCybZ9BeMHB+xZJv7lC
         YdV48w3b1jWLB+y7NApAggcu/tsit2+Wd1Uh4lLXSLQ6/1jMYvcksBSHZBOPoLE/bSx5
         6ZGkYDh+dK+am/EV+YMBNXzPeoW9mS60WYo/X6Qs6rJQaieYGy5pcP5mLW04dAw38/Cl
         B1DQ==
X-Gm-Message-State: ALyK8tLMDeckhUGHzZTvIMhDs+7GXPX1fBXc5uE0YDG771g81GpLTQQLRAc3G28hd8jnOg==
X-Received: by 10.46.9.76 with SMTP id 73mr4567704ljj.61.1468424653006;
        Wed, 13 Jul 2016 08:44:13 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 90sm2575484lfw.30.2016.07.13.08.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jul 2016 08:44:11 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, michelbach94@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/7] pack-objects: pass length to check_pack_crc() without truncation
Date:	Wed, 13 Jul 2016 17:43:58 +0200
Message-Id: <20160713154404.22909-2-pclouds@gmail.com>
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

On 32 bit systems with large file support, unsigned long is 32-bit
while the two offsets in the subtraction expression (pack-objects has
the exact same expression as in sha1_file.c but not shown in diff) are
in 64-bit. If an in-pack object is larger than 2^32 len/datalen is
truncated and we get a misleading "error: bad packed object CRC for
..." as a result.

Use off_t for len and datalen. check_pack_crc() already accepts this
argument as off_t and can deal with 4+ GB.

Noticed-by: Christoph Michelbach <michelbach94@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-objects.c | 2 +-
 sha1_file.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b6664ce..a3a98c5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -349,7 +349,7 @@ static unsigned long write_reuse_object(struct sha1file *f, struct object_entry
 	struct revindex_entry *revidx;
 	off_t offset;
 	enum object_type type = entry->type;
-	unsigned long datalen;
+	off_t datalen;
 	unsigned char header[10], dheader[10];
 	unsigned hdrlen;
 
diff --git a/sha1_file.c b/sha1_file.c
index d0f2aa0..cd9b560 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2282,7 +2282,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 
 		if (do_check_packed_object_crc && p->index_version > 1) {
 			struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
-			unsigned long len = revidx[1].offset - obj_offset;
+			off_t len = revidx[1].offset - obj_offset;
 			if (check_pack_crc(p, &w_curs, obj_offset, len, revidx->nr)) {
 				const unsigned char *sha1 =
 					nth_packed_object_sha1(p, revidx->nr);
-- 
2.9.1.564.gb2f7278

