Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B93C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 901512087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s57JhnuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgKKUC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKUC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:02:28 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0965C0613D4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:27 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id k2so3754537wrx.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IEPGTilWFeb/gYnUiQHEDPP0R8dCTuzsEUTPxGrkZm8=;
        b=s57JhnuQZ8XzkDarvLj4St4go/vw+RLWRNy6kmKB8zYl4HHaH3st2SxRZhe5BPZCrU
         k/FMHuF0bC0ZqB0vcjLGNWOTrwzZgySGKAH4nU9QW9OadlayOlsOVozG62rrEUkgeL3h
         aZKAK53ULjmQQl0KKUG8Wj7QkzYX+emt3OuYx/kcggM0EL/MbJkwbue1shk5T/JyVTsG
         0GMvbCYxHwNdbN3WEwqDmwekzTW3NUSBYm8h4r78//L6yrmThN6osxYylqZoWYKK84kF
         z+mePJB7KtjAgV4w3hHisdS1oTKtDCpbeCJ374MTsnrIq6tQYNFjt8zyuXCVeyAznKRV
         Jz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IEPGTilWFeb/gYnUiQHEDPP0R8dCTuzsEUTPxGrkZm8=;
        b=Cp1j4lLWH8ARQZMGJVgvsw33yM1RU/CuuZmG9e1m3IYDYOXBzuB9gZgvsejBhsNCEk
         WCS07fpOa/QH4ss9U7+ovvnCOXOAq4ye+ll5OOMq+OfDE7PemIP+lPJyN+5EhBIbNNDC
         RBW/9HgO49u2E6eE04/UWXwj25WMFEg8CIxBWsEDZ0wyyuBzUf9R1nuqiCXzOK3pA3jN
         /L+ycXU6QBvmM4D3oklvBhjvZXRujy0KI8ZsMQ75Ru45EuQQdFaczr6jMAHVAWAJsE/6
         4Nz6WEPL1qKss3zv65sPnuFkSbjznLnx+kKgOEa0gGAHJEFpUiebzZpOhcEmzHhyVFo5
         RNMw==
X-Gm-Message-State: AOAM533u484idfDMVyb1KfzvS1CYRaUd1EbcUUOwcSz5mAgHIUTSIeDs
        BVdmKZOkPc8Y5A8V4LYU9zAJ5q/2nCM=
X-Google-Smtp-Source: ABdhPJw5D/m+hHm91s6f5d50t+B0yeaCSeCaNHyLfoAU9P/w0XSuyIBYnztSWReGowDcj2FVEMRfeg==
X-Received: by 2002:a5d:51cd:: with SMTP id n13mr21657481wrv.87.1605124946473;
        Wed, 11 Nov 2020 12:02:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j127sm4102448wma.31.2020.11.11.12.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:02:26 -0800 (PST)
Message-Id: <f2718d036dc5d08c2ed416a5ef98c5730bc38cfc.1605124942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
References: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
        <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 20:02:09 +0000
Subject: [PATCH v6 03/15] hashmap: allow re-use after hashmap_free()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
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

