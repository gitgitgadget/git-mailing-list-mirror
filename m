Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA17C433E0
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 19:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE6F961A0D
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 19:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhCZTMZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 15:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhCZTMM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 15:12:12 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5265C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 12:12:11 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j18so6671717wra.2
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 12:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BVwcer8G45SVw3k2ODhyytLuUTwZTSE61cy6zHBS6u0=;
        b=J8hCqfWp2yTYB6gf7tZDKErSQTWdFfC0DGvncBH00POFuashzbR/cEAd+x4JDuV3DN
         TNYkfkO6ZG8u4TNFXBs9QnBXNwfYY+GC9jnimN+9nLaqqP+9gYkfgXlmTk/DsA+sMy/p
         3J5hTkDCbmSRnKtmp2AF3HauXGNLwPrX+raKhvWLOlRRR/X03qot7FNDSXBOYnZsu/v5
         dKRb1vVOqreR+YXTWhPl16icghPkHxbxni4KhUwDaOVoHLx24hIgtwV9UvYDtXM81pDT
         9DxyK4fI2hEKW0TVB2rIdDKWD2GaxlUNj1Eo/HHXIkDzGNggmNZ6OnfKVA8rKkzCl9SE
         MjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BVwcer8G45SVw3k2ODhyytLuUTwZTSE61cy6zHBS6u0=;
        b=ktFM4hcSj1tt7A0GqOFnt1tySVnmff/cyFFJaDqgb1wb+xqPssZj7qy/Qap3qeU1os
         lc40gtmIBNeyyqGVtXyOp0uDyvUVmVAd4tOhUGSeGnXXi+XPIF1WxsRMXtuGHirgmoYG
         15wni8De8Jnl+cJFOF/KkpWsMZNZlqxJRCAaydrob+C2GMP3H4czW5y3Q/Xw6xTDmgwF
         AttPszw5j0NVEzJHLEHHLafi1eqSq9Owmx1RMCFgr7nPimk55vGnvx3keW2YZluO5mXZ
         PKCZ8jCxhyP26jITLcqIyMio80iQGqlUijmHh9855aUbaTZa+j/IshNZytaAgqtILzWc
         auNg==
X-Gm-Message-State: AOAM531YRO3hFe5JWNcsh1yWmDqsc0tQ32lqy3Hb/dDebJPntMM7XJtt
        /8c/oPROMjrWbMuGeqEPk5qbcpTm3g8=
X-Google-Smtp-Source: ABdhPJzhmkzUhjD1hA6FJMEemgHbEsCcyY5/bA5gf9k0/ZpybtAjVOIEapJoLAwkfSrHo9wD1KUbHw==
X-Received: by 2002:adf:dd0a:: with SMTP id a10mr16438039wrm.145.1616785930537;
        Fri, 26 Mar 2021 12:12:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14sm14423542wrw.91.2021.03.26.12.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 12:12:10 -0700 (PDT)
Message-Id: <0eca529766fcbe70147bc28ce7f0692e645fd118.1616785928.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.916.git.1616785928.gitgitgadget@gmail.com>
References: <pull.916.git.1616785928.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Mar 2021 19:12:05 +0000
Subject: [PATCH 1/3] csum-file: add nested_hashfile()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, stolee@gmail.com,
        git@jeffhostetler.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The index writing code in do_write_index() uses a custom set of hashing
code, in part because it was introduced before the hashfile API. But
also, the End of Index Entries extension computes a hash of just the
extension data, not the entire file preceding that extension.

Before converting the index writing code to use the hashfile API, create
a concept of a "nested hashfile". By adding a 'base' member to 'struct
hashfile', we indicate that any writes to this hashfile should be passed
along to the base hashfile, too.

In the next change, the index code will use this to create a new
hashfile wose base is the hashfile for the index. The outer hashfile
will compute the hash just for the extension details. Thus, it will
finalize earlier than the base hashfile, hence there is no modification
to finalize_hashfile() here.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 csum-file.c | 22 ++++++++++++++++++++++
 csum-file.h |  9 +++++++++
 2 files changed, 31 insertions(+)

diff --git a/csum-file.c b/csum-file.c
index 0f35fa5ee47c..e73b35316e66 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -13,6 +13,9 @@
 
 static void flush(struct hashfile *f, const void *buf, unsigned int count)
 {
+	if (f->base)
+		return;
+
 	if (0 <= f->check_fd && count)  {
 		unsigned char check_buffer[8192];
 		ssize_t ret = read_in_full(f->check_fd, check_buffer, count);
@@ -116,6 +119,9 @@ void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
 		}
 		f->offset = offset;
 	}
+
+	if (f->base)
+		hashwrite(f->base, buf, count);
 }
 
 struct hashfile *hashfd(int fd, const char *name)
@@ -150,6 +156,7 @@ struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp
 	f->name = name;
 	f->do_crc = 0;
 	the_hash_algo->init_fn(&f->ctx);
+	f->base = NULL;
 	return f;
 }
 
@@ -184,3 +191,18 @@ uint32_t crc32_end(struct hashfile *f)
 	f->do_crc = 0;
 	return f->crc32;
 }
+
+struct hashfile *nested_hashfile(struct hashfile *f)
+{
+	struct hashfile *n = xmalloc(sizeof(*f));
+	n->fd = -1;
+	n->check_fd = -1;
+	n->offset = 0;
+	n->total = 0;
+	n->tp = NULL;
+	n->name = NULL;
+	n->do_crc = 0;
+	the_hash_algo->init_fn(&n->ctx);
+	n->base = f;
+	return n;
+}
diff --git a/csum-file.h b/csum-file.h
index e54d53d1d0b3..b8785e7ecb46 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -16,6 +16,7 @@ struct hashfile {
 	const char *name;
 	int do_crc;
 	uint32_t crc32;
+	struct hashfile *base;
 	unsigned char buffer[8192];
 };
 
@@ -42,6 +43,14 @@ void hashflush(struct hashfile *f);
 void crc32_begin(struct hashfile *);
 uint32_t crc32_end(struct hashfile *);
 
+/*
+ * A nested hashfile uses the same interface as a hashfile, and computes
+ * a hash for the input bytes while passing them to the base hashfile
+ * instead of writing them to its own file. This is useful for computing
+ * a hash of a region within a file during the write.
+ */
+struct hashfile *nested_hashfile(struct hashfile *f);
+
 /*
  * Returns the total number of bytes fed to the hashfile so far (including ones
  * that have not been written out to the descriptor yet).
-- 
gitgitgadget

