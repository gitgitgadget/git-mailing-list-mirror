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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E33EC43603
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76CC9650F8
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbhCPP7Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238259AbhCPP6v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:58:51 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206F2C0613DB
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x13so7701986wrs.9
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f4nbLGhI2kyMPM1blKLzInCpiactv6pBIV3uzzH4NVE=;
        b=B96hDKP6gSMR8uIug8zhEIwMW8DTxaiZerfk1FI6nbuPoQzdeJs6ZpmLxkKK2YekWk
         Gkhbq8mlNnUZ2PdGYbFZNFGWBisE7GThH1nyn6DnuYUwVaSgdZ1AENpYDFmJ183zUT/N
         yqsWLmNS5b6u/ugcfzR8eaZQ0bPKVov4LiPnD3X7iZmrJZz8yMD4wlKHSfUPL50QOEEC
         x6bmFMd+QdVPrDlTJ1NCMnwGtTSAyUHu4kIPx2JSbWxRf7Tybbo1tRUFclMjL5V1TPeG
         aOnm0dvX8O/oU1JMOzNsl+Am/m3AQt2u6mMf8VAIctJFPGZCtASuaUB17s5cTsvRiZZo
         WRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f4nbLGhI2kyMPM1blKLzInCpiactv6pBIV3uzzH4NVE=;
        b=oeggTgZsC2AWITFmamEXWx3O+LsO3FTOnfzylACoP6Xrr5jyo1WtN8w6MZ8ZzS4jX4
         yg2CNVdyBxWPjW5quiu/SmjN1/ynRwN10lNAvfHkgwl1S3NzCv3gBWzWx7VCTZ+voJYl
         63Yxj2ETfTejCNS9le3hawk78QMQ/J3Kok0L0X6g+LJfAUnw1wDvI32QYteUcCH2ECg2
         6z8Dehb6ZJM0evLtYOEsMVWt0B5HyqUBgSIVj0OkabSKa/IiN7um470wge/NHgBs3Z9D
         BWCuQ0nex8EogKEMcMvLzuFsSmd5UtwgLGp0DkrYUURHnBV97X8/bNm6dR+WOD02Yk5S
         32kg==
X-Gm-Message-State: AOAM531ji3L8sW9JyVSnW7rV6UDv84dLqS7595h+tm6sugEGn3FczkHE
        YQ/7Sm7EnUiTZEzbw1Vvmw/nMQKGcgTTmA==
X-Google-Smtp-Source: ABdhPJwKWj4kd3ALaRMmZMOJN690cu7JgTactxlpdXxs76gunNhu2nIrJ/6tuRI9BvCTjlciBnvAVg==
X-Received: by 2002:adf:a3d3:: with SMTP id m19mr5753284wrb.24.1615910329556;
        Tue, 16 Mar 2021 08:58:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:58:48 -0700 (PDT)
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
Subject: [PATCH v3 13/32] archive: get rid of 'stage' parameter
Date:   Tue, 16 Mar 2021 16:58:10 +0100
Message-Id: <20210316155829.31242-14-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
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
index 8ff97751c2..529623167c 100644
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
2.31.0.256.gf0ddda3145

