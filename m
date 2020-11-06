Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BFBC388F7
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79CEB2083B
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Da+FFGYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732844AbgKFAZH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 19:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732804AbgKFAZF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 19:25:05 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D82AC0613D2
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 16:25:04 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d142so3270678wmd.4
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 16:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IEPGTilWFeb/gYnUiQHEDPP0R8dCTuzsEUTPxGrkZm8=;
        b=Da+FFGYiCtIv3sITIgLczTOuQ5UaD/PTJCYGnOoDM9I9xlpNBwSjslpDF1Pmxyta8O
         w6Ja0jCjvN0962ndyZS5EZxDPftrxNvmOLdmF0i+nd71myEfnrS0+f7h3ii/KYz1G9Rb
         68Rmtc5nd6rxph+ajHUKU+kTsYh6euD1hSVuEp3y0lwhrN9g/4Ee6K67lBa4gtrffCto
         j8Wo32mcviGTxx+mp259RmbE7gB+qet48b1h3i9DqzUGoD5jT7FkpONjUx0tzJH9JPwy
         JR6p+QBuUROVL/xaAlxPB2SNfeVwDCu3TstD8yz5bk6Z9pGG2d2UceuCLPwrdEhT0rQD
         kNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IEPGTilWFeb/gYnUiQHEDPP0R8dCTuzsEUTPxGrkZm8=;
        b=q8DjVDsJV6aEYaaIrzjaCtfA+hxNXr2xmn36m98iZaxZfH3qdxjb6P9Es5CNY+SVNp
         ORVI1Xt65nEGKECUvIP8ylVQCr5Ka39OveuuGFkaekihM71hZssf4QNDIaMFr3bR70uS
         y/h5PxsV9ufnqzxpuW6oW/A1p0sORCJ/t4gcRfuKntjgcstd5FPaEm1apDjZqiRItKu/
         e86/BqsXqtDpbDmYGu43ugXnFem+GrZ3x1hvW+U3fo12rxY6f2X/eeCcATIaqtbGJhFe
         YSsazUKZzinj0VLrzVdrCzDERjOCRV5TzZlDYlIFsoV9hHzuif4j1N3krnOmmxeXk2ZF
         ZB/Q==
X-Gm-Message-State: AOAM533F7E5+4775hb7GCyfqfsHr/D/9magnpXTFdI7RF5jqiVCvMoY8
        +xNz6O9nl3lM/erGsRgtEFbL0UecZCc=
X-Google-Smtp-Source: ABdhPJyGGSuTZQduJyIKqx5sOF2waYQ9xwClAUosCv8WDi8Bh8Q2fbsPXjDajNSQ0MdtXKS8loaSEg==
X-Received: by 2002:a1c:acc1:: with SMTP id v184mr4939148wme.63.1604622302821;
        Thu, 05 Nov 2020 16:25:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q2sm4698686wrw.40.2020.11.05.16.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 16:25:02 -0800 (PST)
Message-Id: <f2718d036dc5d08c2ed416a5ef98c5730bc38cfc.1604622298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
References: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
        <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Nov 2020 00:24:46 +0000
Subject: [PATCH v5 03/15] hashmap: allow re-use after hashmap_free()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Previously, once map->table had been freed, any calls to hashmap_put(),
hashmap_get(), or hashmap_remove() would cause a NULL pointer
dereference (since hashmap_free_() also zeros the memory; without that
zeroing, calling these functions would cause a use-after-free problem).

Modify these functions to check for a NULL table and automatically
allocate as needed.

Also add a HASHMAP_INIT(fn, data) macro for initializing hashmaps on the
stack without calling hashmap_init().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 hashmap.c | 16 ++++++++++++++--
 hashmap.h |  3 +++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/hashmap.c b/hashmap.c
index e44d8a3e85..bb7c9979b8 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -114,6 +114,7 @@ int hashmap_bucket(const struct hashmap *map, unsigned int hash)
 
 static void rehash(struct hashmap *map, unsigned int newsize)
 {
+	/* map->table MUST NOT be NULL when this function is called */
 	unsigned int i, oldsize = map->tablesize;
 	struct hashmap_entry **oldtable = map->table;
 
@@ -134,6 +135,7 @@ static void rehash(struct hashmap *map, unsigned int newsize)
 static inline struct hashmap_entry **find_entry_ptr(const struct hashmap *map,
 		const struct hashmap_entry *key, const void *keydata)
 {
+	/* map->table MUST NOT be NULL when this function is called */
 	struct hashmap_entry **e = &map->table[bucket(map, key)];
 	while (*e && !entry_equals(map, *e, key, keydata))
 		e = &(*e)->next;
@@ -196,6 +198,8 @@ struct hashmap_entry *hashmap_get(const struct hashmap *map,
 				const struct hashmap_entry *key,
 				const void *keydata)
 {
+	if (!map->table)
+		return NULL;
 	return *find_entry_ptr(map, key, keydata);
 }
 
@@ -211,8 +215,12 @@ struct hashmap_entry *hashmap_get_next(const struct hashmap *map,
 
 void hashmap_add(struct hashmap *map, struct hashmap_entry *entry)
 {
-	unsigned int b = bucket(map, entry);
+	unsigned int b;
+
+	if (!map->table)
+		alloc_table(map, HASHMAP_INITIAL_SIZE);
 
+	b = bucket(map, entry);
 	/* add entry */
 	entry->next = map->table[b];
 	map->table[b] = entry;
@@ -230,7 +238,11 @@ struct hashmap_entry *hashmap_remove(struct hashmap *map,
 				     const void *keydata)
 {
 	struct hashmap_entry *old;
-	struct hashmap_entry **e = find_entry_ptr(map, key, keydata);
+	struct hashmap_entry **e;
+
+	if (!map->table)
+		return NULL;
+	e = find_entry_ptr(map, key, keydata);
 	if (!*e)
 		return NULL;
 
diff --git a/hashmap.h b/hashmap.h
index 904f61d6e1..3b0f2bcade 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -210,6 +210,9 @@ struct hashmap {
 
 /* hashmap functions */
 
+#define HASHMAP_INIT(fn, data) { .cmpfn = fn, .cmpfn_data = data, \
+				 .do_count_items = 1 }
+
 /*
  * Initializes a hashmap structure.
  *
-- 
gitgitgadget

