Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 497021FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 09:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754119AbdCFJtm (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 04:49:42 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33857 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752773AbdCFJtk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 04:49:40 -0500
Received: by mail-wm0-f65.google.com with SMTP id u132so4729287wmg.1
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 01:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JRgmv708W8ovIwaaIttawQK3bnm12kxhnjwWkpKloTU=;
        b=ifD/pMaX42pIj6jOEb/86t1bORedN7SA9fGQONoCRLOs9uv4vicZYkbLcT0A4LCfxs
         4P7DBiqjcrnfKDpi5RdyEeOA6Byl/qOw8/FuNc7N45W1SL/JxOERFmaVQIrsqNbi/nZ+
         ly/buq4rsonEY6j/PGG7+la89T5FXbYnYzSlY/wTg/F3Z5XRc1HNgJX6CqQOQxP+Pa84
         t2MI7EzyNefWjCnvTxCdPbljMogzAuTMFZfp5RAOSmQOIGdqgBXvCjbbzcBVuLdummuN
         XFKZ5gDCAun/qdm4QBYuJ4mCS6Ci1lUqb6+sp9SZvmWAq54Scc2GGbi0O+a1W5VgLhop
         hU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JRgmv708W8ovIwaaIttawQK3bnm12kxhnjwWkpKloTU=;
        b=juP8IwHRMpc+0xUKfzpB7t92Y176xR6iZh6Zn1hfxIE/bfHI6LwJ7uPt2Ut4Ge84k5
         7lC6mqSatYBTol9A893VlOaoyTlfVbAttEACKKMV7STTMSNryRyj4N4kT4c7qF1mn0cr
         Lqn1RVil68y4/sn1jfyfWs5bt+w8oc1JJ/Oyf3W9G6E6c1KrHP7y5bFoBz/3KlpqxVwz
         QR9t6RcGU51qzaMRhwILAtwMaDp1Me6TzCYzqPOczxF+P4Pf0GI33jzDKsSGdObnoLsv
         +Q4c0z5tAkSYiQgzjYgBlW61KYa4ePqGaIY0vda7Tv1nBu6JOWjC4H0lMsSyIceZeZbd
         eHZg==
X-Gm-Message-State: AMke39k6smDXgapj0gv/+LNfMdNgJVhajxCLI4xtbXKFnxTq4WNyeW1H/GFUJ/4Wh2829g==
X-Received: by 10.28.95.87 with SMTP id t84mr12682957wmb.35.1488793357141;
        Mon, 06 Mar 2017 01:42:37 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 191sm14144086wmo.21.2017.03.06.01.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 01:42:36 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 14/22] sha1_file: make check_and_freshen_file() non static
Date:   Mon,  6 Mar 2017 10:41:55 +0100
Message-Id: <20170306094203.28250-15-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.206.g74921e51d6.dirty
In-Reply-To: <20170306094203.28250-1-chriscool@tuxfamily.org>
References: <20170306094203.28250-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function will be used in a commit soon, so let's make
it available globally.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h     | 3 +++
 sha1_file.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 0bb9adcd31..a35e9d5187 100644
--- a/cache.h
+++ b/cache.h
@@ -1273,6 +1273,9 @@ extern int has_pack_index(const unsigned char *sha1);
 
 extern void assert_sha1_type(const unsigned char *sha1, enum object_type expect);
 
+/* Helper to check and "touch" a file */
+extern int check_and_freshen_file(const char *fn, int freshen);
+
 extern const signed char hexval_table[256];
 static inline unsigned int hexval(unsigned char c)
 {
diff --git a/sha1_file.c b/sha1_file.c
index 6628f06da3..f02f10189f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -667,7 +667,7 @@ static int freshen_file(const char *fn)
  * either does not exist on disk, or has a stale mtime and may be subject to
  * pruning).
  */
-static int check_and_freshen_file(const char *fn, int freshen)
+int check_and_freshen_file(const char *fn, int freshen)
 {
 	if (access(fn, F_OK))
 		return 0;
-- 
2.12.0.206.g74921e51d6.dirty

