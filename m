Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47478C433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 10:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352202AbiDOKYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 06:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244303AbiDOKYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 06:24:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82348BB0AB
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 03:21:41 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so4799817wmn.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 03:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q+1T/ef2N0zaYNteYeTbZpBUkd9ZmLAnaSHtBqwAV9Q=;
        b=c5VALwXhv32gTJn7uR1VAWZku+6Hgm2nGbm0/sZBKICRyjpSjanT/smNEvDiTtGLoh
         HcMXvE9k9CFQTrsJKOyveI6oxwiI5QZS4ZMkNBncQBmdwVQh/vRaV5R2YY9pJFZz9Fnc
         PJEMBaVNCaGdB8My6JNNNjgKLDwjpRajS1z8dB3WDSnPGPfwmPms1FwvdAdVSedL6OT3
         i6Yrc3rEHL6JujOvixd3NHPKOn9JobET2m7I78PDoG4qPC5MEhRgy2B8s+wJzajHVNXS
         //1wqLQqh9WLEkAwT8KwKRVotWgkphHK3OV1coZvoSpAsYQWrMrHrHL6+3sUSsaOJ1wU
         a81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q+1T/ef2N0zaYNteYeTbZpBUkd9ZmLAnaSHtBqwAV9Q=;
        b=K/b2mmVIQRU5n1bjoJuRdd4ZMvuMIOYVuzaJnNBlSgBUE1fYeZPU73WE/EwNkwqXwF
         iRMt8cXuLoNWl5y/DGrjrXNpzWoRxBPYtUPDcK+Z29SFGknUt6Lc8+jXoV75t11jpSbT
         oJGWNKxzDcSz8DyCHuQeN+Zgu8MwX3oIdOwbAoE85p29vubxJDubVXMnUjx83nebyfyE
         f4EwsoEMl633BZqm0tARu3mSr56cgY9OBeGf5r71VZ/aMlSCwlVbeUi/tneVkU6kJx6+
         Q62h2BRBmNuuKvrT+9xnn9+PxcNy8p7wr+T5rVvcaDBMEgwl7FGkQz4qCh3+wLZFyKgr
         7WnQ==
X-Gm-Message-State: AOAM530XfvvnkdmJIE4Ub6MyKuWMtrl9hqhZT0ZdAGX3rlh7x2J/wcBL
        MKiahs8ZSgNObc6UT4soJP76jllDwXQ=
X-Google-Smtp-Source: ABdhPJw8R8BryRVxTAbWTT2iQEsj9+YhMXzeg/kBi60op3JTwM496l6rC6qU4XHyV2T3ui5mR7BDQQ==
X-Received: by 2002:a1c:3587:0:b0:381:50ff:cbd with SMTP id c129-20020a1c3587000000b0038150ff0cbdmr2724700wma.140.1650018099837;
        Fri, 15 Apr 2022 03:21:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c186-20020a1c35c3000000b0038e6c6fc860sm4585791wma.37.2022.04.15.03.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 03:21:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 1/2] reftable: remove the "return_block" abstraction
Date:   Fri, 15 Apr 2022 12:21:35 +0200
Message-Id: <RFC-patch-1.2-76ed86bf88c-20220415T101740Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.863.gfc2c14e3b91
In-Reply-To: <RFC-cover-0.2-00000000000-20220415T101740Z-avarab@gmail.com>
References: <20220415083058.29495-1-carenas@gmail.com> <RFC-cover-0.2-00000000000-20220415T101740Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This abstraction added in 1214aa841bc (reftable: add blocksource, an
abstraction for random access reads, 2021-10-07) has the caller
provide a "blockp->data", so there's not point in having the vtable
have a custom free() function.

In addition this had what looked like a poor man's SANITIZE=address
doing a memset() to 0xff just before the data was free'd.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 reftable/block.c                |  4 +---
 reftable/blocksource.c          | 28 +---------------------------
 reftable/reftable-blocksource.h |  2 --
 3 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 34d4d073692..bb17cc32372 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -442,9 +442,7 @@ void block_writer_release(struct block_writer *bw)
 
 void reftable_block_done(struct reftable_block *blockp)
 {
-	struct reftable_block_source source = blockp->source;
-	if (blockp && source.ops)
-		source.ops->return_block(source.arg, blockp);
+	FREE_AND_NULL(blockp->data);
 	blockp->data = NULL;
 	blockp->len = 0;
 	blockp->source.ops = NULL;
diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 2605371c28d..d9e47cc316b 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -13,12 +13,6 @@ license that can be found in the LICENSE file or at
 #include "reftable-blocksource.h"
 #include "reftable-error.h"
 
-static void strbuf_return_block(void *b, struct reftable_block *dest)
-{
-	memset(dest->data, 0xff, dest->len);
-	reftable_free(dest->data);
-}
-
 static void strbuf_close(void *b)
 {
 }
@@ -42,7 +36,6 @@ static uint64_t strbuf_size(void *b)
 static struct reftable_block_source_vtable strbuf_vtable = {
 	.size = &strbuf_size,
 	.read_block = &strbuf_read_block,
-	.return_block = &strbuf_return_block,
 	.close = &strbuf_close,
 };
 
@@ -54,19 +47,7 @@ void block_source_from_strbuf(struct reftable_block_source *bs,
 	bs->arg = buf;
 }
 
-static void malloc_return_block(void *b, struct reftable_block *dest)
-{
-	memset(dest->data, 0xff, dest->len);
-	reftable_free(dest->data);
-}
-
-static struct reftable_block_source_vtable malloc_vtable = {
-	.return_block = &malloc_return_block,
-};
-
-static struct reftable_block_source malloc_block_source_instance = {
-	.ops = &malloc_vtable,
-};
+static struct reftable_block_source malloc_block_source_instance = { 0 };
 
 struct reftable_block_source malloc_block_source(void)
 {
@@ -83,12 +64,6 @@ static uint64_t file_size(void *b)
 	return ((struct file_block_source *)b)->size;
 }
 
-static void file_return_block(void *b, struct reftable_block *dest)
-{
-	memset(dest->data, 0xff, dest->len);
-	reftable_free(dest->data);
-}
-
 static void file_close(void *b)
 {
 	int fd = ((struct file_block_source *)b)->fd;
@@ -115,7 +90,6 @@ static int file_read_block(void *v, struct reftable_block *dest, uint64_t off,
 static struct reftable_block_source_vtable file_vtable = {
 	.size = &file_size,
 	.read_block = &file_read_block,
-	.return_block = &file_return_block,
 	.close = &file_close,
 };
 
diff --git a/reftable/reftable-blocksource.h b/reftable/reftable-blocksource.h
index 5aa3990a573..7b7cb280b73 100644
--- a/reftable/reftable-blocksource.h
+++ b/reftable/reftable-blocksource.h
@@ -35,8 +35,6 @@ struct reftable_block_source_vtable {
 	   beyond the end of the block */
 	int (*read_block)(void *source, struct reftable_block *dest,
 			  uint64_t off, uint32_t size);
-	/* mark the block as read; may return the data back to malloc */
-	void (*return_block)(void *source, struct reftable_block *blockp);
 
 	/* release all resources associated with the block source */
 	void (*close)(void *source);
-- 
2.36.0.rc2.863.gfc2c14e3b91

