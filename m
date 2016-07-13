Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05D332018F
	for <e@80x24.org>; Wed, 13 Jul 2016 15:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbcGMPo0 (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 11:44:26 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33488 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbcGMPoY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 11:44:24 -0400
Received: by mail-lf0-f67.google.com with SMTP id f93so3977848lfi.0
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 08:44:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GgTbg+suWSUpNHUyQy8b0qaAVBYcMaZQ6KAd/yJuT9I=;
        b=UomNc165/H5Cdju6+6SLF3Tr/nTcC6W/e2gJUW+/lhPHNRFS++02bKv/z/lbzXF2Jl
         CFgWTE8COZx64RyREP8g+fp/qFMAcgEiOa1vW2yGUyH2RuqwO6vka3qeLz72qXZr+2aF
         uyQUbF9J9Mxz7MqjLHgOI+em8ri/C218xZPTf/6Pz998a7e1s4ZK9tNVvQ5D7NiHUJlU
         RwyLVqo7kIgVK3KofM48scscYo95H8ihsrumMdV3C0V4ChWionOnIm+1h8U+eXoSyM9M
         OsMff7Ai2MXEajgdIcQk2bZrPJDmUqRr0vEEYZkE5FmRO2PgfNztV2oSx4O8WTGYDpDu
         CBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GgTbg+suWSUpNHUyQy8b0qaAVBYcMaZQ6KAd/yJuT9I=;
        b=RUljAEu5y+w16ZHDJsVwDCeQs3s13T+4ingt6TbLG3Gb1nAlU4hs/a74FlAouhJhY6
         81SG7b14T4fTanaXA90wXSV9ZSsTygBpzCOR8e3KWl8ViEBsYICaQE8i3+jt/oLFJZyo
         uIt5+76wBMLBOvov+0d14K/WqTqzPmNOgMb1zK45jl5UYH8QH+FrboFCkAHt7VjaujGr
         M6AjzbPiMVMZgMmLsu70fmXlYp+TkWM/XgadRfS8dIPgxjquWrLUbolY2VXNiP5GbRow
         DNs5HGJoGdo/79JRXHmys6e7iUkxpPXVTZVLRIv25A1NI/tsuOKmTAYG/073hidqbrWr
         wZKA==
X-Gm-Message-State: ALyK8tIjkp1ASaDhWJwy93nsMTMpalw+tC0sZWXK6nx6Mig+bzatSYdxAAcphATcnmPKDA==
X-Received: by 10.25.148.136 with SMTP id w130mr4368718lfd.2.1468424656745;
        Wed, 13 Jul 2016 08:44:16 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 90sm2575484lfw.30.2016.07.13.08.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jul 2016 08:44:15 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, michelbach94@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/7] index-pack: report correct bad object offsets even if they are large
Date:	Wed, 13 Jul 2016 17:44:01 +0200
Message-Id: <20160713154404.22909-5-pclouds@gmail.com>
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

Use the right type for offsets in this case, off_t, which makes a
difference on 32-bit systems with large file support, and change
formatting code accordingly.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/index-pack.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index cafaab7..e2d8ae4 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -338,10 +338,10 @@ static void parse_pack_header(void)
 	use(sizeof(struct pack_header));
 }
 
-static NORETURN void bad_object(unsigned long offset, const char *format,
+static NORETURN void bad_object(off_t offset, const char *format,
 		       ...) __attribute__((format (printf, 2, 3)));
 
-static NORETURN void bad_object(unsigned long offset, const char *format, ...)
+static NORETURN void bad_object(off_t offset, const char *format, ...)
 {
 	va_list params;
 	char buf[1024];
@@ -349,7 +349,8 @@ static NORETURN void bad_object(unsigned long offset, const char *format, ...)
 	va_start(params, format);
 	vsnprintf(buf, sizeof(buf), format, params);
 	va_end(params);
-	die(_("pack has bad object at offset %lu: %s"), offset, buf);
+	die(_("pack has bad object at offset %"PRIuMAX": %s"),
+	    (uintmax_t)offset, buf);
 }
 
 static inline struct thread_local *get_thread_data(void)
-- 
2.9.1.564.gb2f7278

