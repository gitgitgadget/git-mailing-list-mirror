Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DE1C43333
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFEC76522D
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhCHPHs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhCHPHT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:19 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8FCC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:18 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id l12so11812529wry.2
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Bx4s6ATrka3mqVeBxhUQ+fmxWRFwnOnfjlh/4X0RpU=;
        b=du8uiEAn3+gFPvUpgoImMwrAzkPrY5OOdY+WNVwJo2iiR08G4E4iqjbiqXRLZbcP2t
         0O9C+RJeFk6zoSiQTIXOySpRpn1Pk2JtsBs7X9rwAcBUL23q4aE1Vew3lyhyKGHYEUW3
         i+m4JYWXJK5wKbsIaetRqCn/NFAEoeSIHsYz2XVtgq4/0jSlsyq6Vw8SuNvnjnNdZd8Y
         Li0Z045R71JhYvJWFBxe4OO8X0W2/630+778hx77rf82fWeaRvP2x7ePbYWn9jt+IVT8
         z3XQe0YvEjg+OuvgUhZJRqVKvzJ4OHnFx5PG8wZ3jys8DrkBJvexQd5TIwtJaKtN/kgi
         q/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Bx4s6ATrka3mqVeBxhUQ+fmxWRFwnOnfjlh/4X0RpU=;
        b=K/oYxlh53B+JAZmm1ZBha3LAhLQPB7NiLVC9AkF80X27Fd4qDu3xYvI4HupdRa1k3Q
         ScHrbj3v9cxGWk/xmXY81/wbQBzqEkj883PallmOYHS3kc6WLs5/zWlxevVMPsmQZB8v
         o8A8kaOhZdnXRnOOxn8caA4hKocFY/kvr4rKOk4WbZTgr4JKTeLrBWMdDIRAt6VoPoTR
         mKgxbq/GRaumkXbDJtQWuTIDuH4Xh9meuNceoPfVspXqPIc3RpRjfesx1fpq3A+bx0th
         bW96d6gkqOviXT2AhEvlGx7JMTzDRUPOcOJJOLuz/Gm0S8rGjNIE1YYCxV4ce3GFTxr/
         hfuA==
X-Gm-Message-State: AOAM531r8zXprABtbxfDFQXCwIhMOUWZYdyKw7WUwxkdIskOFAt+vP4T
        tKv6YVN0FfD9hGDRiBymW2wETUEDACQidw==
X-Google-Smtp-Source: ABdhPJx7cdnOJXyTUymmeaJUt39ixAuVzdxqsq5pUNvG5NNlTL4DSr0ptPnRoPLG47MkW6F731ofmQ==
X-Received: by 2002:adf:b1c9:: with SMTP id r9mr23814946wra.51.1615216037133;
        Mon, 08 Mar 2021 07:07:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/30] archive: get rid of 'stage' parameter
Date:   Mon,  8 Mar 2021 16:06:30 +0100
Message-Id: <20210308150650.18626-11-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop passing the "stage" parameter around in archive.c. This parameter
existed because the read_tree_recursive() function used to provide it,
but no longer does. See my in-flight commit to remove it. (tree.h API:
remove "stage" parameter from read_tree_recursive(), 2021-03-06).

As can be seen in 562e25abea9 (archive: centralize archive entry
writing, 2008-07-14) and ed22b4173bd (archive: support filtering paths
with glob, 2014-09-21) it was never used by this code. We simply added
it as a boilerplate, and then later added it to our own "directory
"struct.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/archive.c b/archive.c
index e245c0d5a54..26534a30d3b 100644
--- a/archive.c
+++ b/archive.c
@@ -107,7 +107,6 @@ struct directory {
 	struct object_id oid;
 	int baselen, len;
 	unsigned mode;
-	int stage;
 	char path[FLEX_ARRAY];
 };
 
@@ -140,7 +139,6 @@ static int check_attr_export_subst(const struct attr_check *check)
 static int write_archive_entry(const struct object_id *oid, const char *base,
 			       int baselen, const char *filename,
 			       unsigned mode,
-			       int stage,
 			       void *context)
 {
 	static struct strbuf path = STRBUF_INIT;
@@ -200,7 +198,6 @@ static int write_archive_entry(const struct object_id *oid, const char *base,
 static void queue_directory(const unsigned char *sha1,
 			    struct strbuf *base, const char *filename,
 			    unsigned mode,
-			    int stage,
 			    struct archiver_context *c)
 {
 	struct directory *d;
@@ -209,7 +206,6 @@ static void queue_directory(const unsigned char *sha1,
 	d->up	   = c->bottom;
 	d->baselen = base->len;
 	d->mode	   = mode;
-	d->stage   = stage;
 	c->bottom  = d;
 	d->len = xsnprintf(d->path, len, "%.*s%s/", (int)base->len, base->buf, filename);
 	hashcpy(d->oid.hash, sha1);
@@ -229,7 +225,6 @@ static int write_directory(struct archiver_context *c)
 		write_archive_entry(&d->oid, d->path, d->baselen,
 				    d->path + d->baselen,
 				    d->mode,
-				    d->stage,
 				    c) != READ_TREE_RECURSIVE;
 	free(d);
 	return ret ? -1 : 0;
@@ -241,7 +236,6 @@ static int queue_or_write_archive_entry(const struct object_id *oid,
 					void *context)
 {
 	struct archiver_context *c = context;
-	int stage = 0;
 
 	while (c->bottom &&
 	       !(base->len >= c->bottom->len &&
@@ -265,7 +259,6 @@ static int queue_or_write_archive_entry(const struct object_id *oid,
 			return 0;
 		queue_directory(oid->hash, base, filename,
 				mode,
-				stage,
 				c);
 		return READ_TREE_RECURSIVE;
 	}
@@ -274,7 +267,6 @@ static int queue_or_write_archive_entry(const struct object_id *oid,
 		return -1;
 	return write_archive_entry(oid, base->buf, base->len, filename,
 				   mode,
-				   stage,
 				   context);
 }
 
-- 
2.31.0.rc0.126.g04f22c5b82

