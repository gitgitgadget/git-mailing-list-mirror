Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8631CC5517A
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33EB32083B
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJEqD/yj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732794AbgKFAZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 19:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732396AbgKFAZE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 19:25:04 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BABBC0613CF
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 16:25:03 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id g12so3743065wrp.10
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 16:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lfeFxSmzBLKnFekm6mzwPvSqu+S1DEbaBDz97hV1DAw=;
        b=OJEqD/yjCmF+RcF79pwEw5AuMPpwXC9Yy62gLygc6CoqMHTea1FHEd/RR0hnf0lFBN
         WDIedTLWxUUe2K55en71gREEJtwjrjHb9UTX4sm8FVtn1ZQW2aIfiTvmIOg1tiEveHQH
         V70y5C60839Q1pSjmYf3VYWwsqYOsbxbqVzu+PJ736EstoTjwrQTzbT7+MZgxbqHd83J
         Pc6Dk/jyP3Mu5QzWt7TLPZ7y0Mxyf3RkX7gQJlo+Ms4nC3PIFuFtQiV+PvrybNicaZtS
         ZAkx/O5WiDzatuYcvufTdP3EWCjIz/2NOQJd99SoLOoQz1azA6d1R8U9b0rDgMN9pFyP
         ej1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lfeFxSmzBLKnFekm6mzwPvSqu+S1DEbaBDz97hV1DAw=;
        b=KbH/nbugABxRXcvol3gWBL5xNvCNih/LTb7KyDp7mbZNlzoi07bi4dUOOY+bTse5LI
         4wP/MWTJTKnoeF1XkppF5oF4fKD+l4GmK8R99ASX9+GqPZfT3V7Jvp+GT920+DtRbG/L
         Pgxl/Vvrls8Lfc9cVuvyB+pttnW5sgJMM5e0yhEiytyXKyDQJkzBv41kbNagErIDKtLu
         ytABLVMMdWHSzYEf9Lg2rx0Y2/U5XJ6uXarvtLUIrF5cvTFkrM6E+Jz0r2A9uJpsNBae
         rS6y172kLKHDKd/cvaquu3z/qTc4LCcM15By49knqQm02gwGI9PT1R73ReE2uKOGNt30
         R9ew==
X-Gm-Message-State: AOAM533ISa2xwjj1k9LnY7McDAsyM/dAHGNK4ZoMArlzSLoG4hqPM9JU
        wdWrxi2rDmXTdV103gmOEw2YhvPixo8=
X-Google-Smtp-Source: ABdhPJx9fVzMdvrhkKz4bZk3uYS7w82HqtMp3vtetKtIw9ilkTPu8q8tNGJnx4gitQbwuRvUg9RQNA==
X-Received: by 2002:adf:84a5:: with SMTP id 34mr5640776wrg.8.1604622301932;
        Thu, 05 Nov 2020 16:25:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm5007927wrw.87.2020.11.05.16.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 16:25:01 -0800 (PST)
Message-Id: <591161fd781b7666ddaa45694eb20610cc359741.1604622298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
References: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
        <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Nov 2020 00:24:45 +0000
Subject: [PATCH v5 02/15] hashmap: adjust spacing to fix argument alignment
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

No actual code changes; just whitespace adjustments.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 hashmap.c | 17 +++++++++--------
 hashmap.h | 22 +++++++++++-----------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/hashmap.c b/hashmap.c
index 09813e1a46..e44d8a3e85 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -92,8 +92,9 @@ static void alloc_table(struct hashmap *map, unsigned int size)
 }
 
 static inline int entry_equals(const struct hashmap *map,
-		const struct hashmap_entry *e1, const struct hashmap_entry *e2,
-		const void *keydata)
+			       const struct hashmap_entry *e1,
+			       const struct hashmap_entry *e2,
+			       const void *keydata)
 {
 	return (e1 == e2) ||
 	       (e1->hash == e2->hash &&
@@ -101,7 +102,7 @@ static inline int entry_equals(const struct hashmap *map,
 }
 
 static inline unsigned int bucket(const struct hashmap *map,
-		const struct hashmap_entry *key)
+				  const struct hashmap_entry *key)
 {
 	return key->hash & (map->tablesize - 1);
 }
@@ -148,7 +149,7 @@ static int always_equal(const void *unused_cmp_data,
 }
 
 void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
-		const void *cmpfn_data, size_t initial_size)
+		  const void *cmpfn_data, size_t initial_size)
 {
 	unsigned int size = HASHMAP_INITIAL_SIZE;
 
@@ -199,7 +200,7 @@ struct hashmap_entry *hashmap_get(const struct hashmap *map,
 }
 
 struct hashmap_entry *hashmap_get_next(const struct hashmap *map,
-			const struct hashmap_entry *entry)
+				       const struct hashmap_entry *entry)
 {
 	struct hashmap_entry *e = entry->next;
 	for (; e; e = e->next)
@@ -225,8 +226,8 @@ void hashmap_add(struct hashmap *map, struct hashmap_entry *entry)
 }
 
 struct hashmap_entry *hashmap_remove(struct hashmap *map,
-					const struct hashmap_entry *key,
-					const void *keydata)
+				     const struct hashmap_entry *key,
+				     const void *keydata)
 {
 	struct hashmap_entry *old;
 	struct hashmap_entry **e = find_entry_ptr(map, key, keydata);
@@ -249,7 +250,7 @@ struct hashmap_entry *hashmap_remove(struct hashmap *map,
 }
 
 struct hashmap_entry *hashmap_put(struct hashmap *map,
-				struct hashmap_entry *entry)
+				  struct hashmap_entry *entry)
 {
 	struct hashmap_entry *old = hashmap_remove(map, entry, NULL);
 	hashmap_add(map, entry);
diff --git a/hashmap.h b/hashmap.h
index 2994dc7a9c..904f61d6e1 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -228,9 +228,9 @@ struct hashmap {
  * prevent expensive resizing. If 0, the table is dynamically resized.
  */
 void hashmap_init(struct hashmap *map,
-			 hashmap_cmp_fn equals_function,
-			 const void *equals_function_data,
-			 size_t initial_size);
+		  hashmap_cmp_fn equals_function,
+		  const void *equals_function_data,
+		  size_t initial_size);
 
 /* internal function for freeing hashmap */
 void hashmap_free_(struct hashmap *map, ssize_t offset);
@@ -288,7 +288,7 @@ void hashmap_free_(struct hashmap *map, ssize_t offset);
  * and if it is on stack, you can just let it go out of scope).
  */
 static inline void hashmap_entry_init(struct hashmap_entry *e,
-					unsigned int hash)
+				      unsigned int hash)
 {
 	e->hash = hash;
 	e->next = NULL;
@@ -330,8 +330,8 @@ static inline unsigned int hashmap_get_size(struct hashmap *map)
  * to `hashmap_cmp_fn` to decide whether the entry matches the key.
  */
 struct hashmap_entry *hashmap_get(const struct hashmap *map,
-				const struct hashmap_entry *key,
-				const void *keydata);
+				  const struct hashmap_entry *key,
+				  const void *keydata);
 
 /*
  * Returns the hashmap entry for the specified hash code and key data,
@@ -364,7 +364,7 @@ static inline struct hashmap_entry *hashmap_get_from_hash(
  * call to `hashmap_get` or `hashmap_get_next`.
  */
 struct hashmap_entry *hashmap_get_next(const struct hashmap *map,
-			const struct hashmap_entry *entry);
+				       const struct hashmap_entry *entry);
 
 /*
  * Adds a hashmap entry. This allows to add duplicate entries (i.e.
@@ -384,7 +384,7 @@ void hashmap_add(struct hashmap *map, struct hashmap_entry *entry);
  * Returns the replaced entry, or NULL if not found (i.e. the entry was added).
  */
 struct hashmap_entry *hashmap_put(struct hashmap *map,
-				struct hashmap_entry *entry);
+				  struct hashmap_entry *entry);
 
 /*
  * Adds or replaces a hashmap entry contained within @keyvar,
@@ -406,8 +406,8 @@ struct hashmap_entry *hashmap_put(struct hashmap *map,
  * Argument explanation is the same as in `hashmap_get`.
  */
 struct hashmap_entry *hashmap_remove(struct hashmap *map,
-					const struct hashmap_entry *key,
-					const void *keydata);
+				     const struct hashmap_entry *key,
+				     const void *keydata);
 
 /*
  * Removes a hashmap entry contained within @keyvar,
@@ -449,7 +449,7 @@ struct hashmap_entry *hashmap_iter_next(struct hashmap_iter *iter);
 
 /* Initializes the iterator and returns the first entry, if any. */
 static inline struct hashmap_entry *hashmap_iter_first(struct hashmap *map,
-		struct hashmap_iter *iter)
+						       struct hashmap_iter *iter)
 {
 	hashmap_iter_init(map, iter);
 	return hashmap_iter_next(iter);
-- 
gitgitgadget

