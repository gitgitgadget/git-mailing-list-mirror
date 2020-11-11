Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D23C56201
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD541208B8
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6ZHDWrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgKKUC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKUC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:02:27 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340FDC0613D4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:27 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c16so3466157wmd.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lfeFxSmzBLKnFekm6mzwPvSqu+S1DEbaBDz97hV1DAw=;
        b=l6ZHDWrFxrGFpRxHsXeCzOEi+kIeflZwY9RpTC3D5JWveFlxX60wPb5RQc5NYZp4pp
         FdvOul9LEsfoepWaho53/BXGz4kKvXi9PgHOsHRR/jDRL9klYFPVVikrcMLry6OOMV1g
         UqqpcjAGrZrETI5qYybkLq7lka9EO2N+fQNdAP82vln1tF+tbD8XvWvnjQl+OeCS/WJI
         mypDtXh3wou8hmXxAso4K+JAPX1gA/t+bKG44mxRUdkqLY+eSs8Kx1sD40SrpLXswuAj
         4BJHl11T6x8RPBI/+rjmX9RGnGYQdzgn0tIw5htAufUoUq+o1b4cziNVUbsRC7JNZzQI
         VAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lfeFxSmzBLKnFekm6mzwPvSqu+S1DEbaBDz97hV1DAw=;
        b=bieC/NUi+aFgSgc7kf6f9viR357NiAZAAnkD6PBQIFNMvzNvAzqnFQIapIyb3rqJU5
         xiKQCI803fA9fjNSEDDj4X6wzRXg4ZXeWvQRxBRUoqecussWI0rXft0Fu8l4RHcgfi3h
         tLaDOMJbSYCY3RIXF0IXGFMC0LsYjpopa8SNEYGVAcFOyocFhx4gYD9jd3DWCZTKlFM7
         CqhFCgvcbZiITDfVbvlmV+p3CemEKDFIlydr/z4hpXoCqH1hB3eSQvmYVHq5kdXJhlH5
         ZTfQy+oPHHir0e7qaILM36RMdvsZ+8n2wEfPJueUQZ1mDNUOqrDWaxcmjMXojcAt7M7a
         cKJA==
X-Gm-Message-State: AOAM531Cshnv9Bbwlyvr8rhUsYqyuSUcJa1RGEz08SCcauxLTdDYeiW7
        BQueXvWgNTYT0WHYeHV48f2mkHCoZf8=
X-Google-Smtp-Source: ABdhPJzBJoYkjTEWZHRJBGKTOTTdls7qx3DaCXdczY+515hSGEaMLnka3UJ3Oevx4T1xyaAMh7AoPg==
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr5981202wmd.139.1605124945643;
        Wed, 11 Nov 2020 12:02:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y20sm3673113wma.15.2020.11.11.12.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:02:25 -0800 (PST)
Message-Id: <591161fd781b7666ddaa45694eb20610cc359741.1605124942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
References: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
        <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 20:02:08 +0000
Subject: [PATCH v6 02/15] hashmap: adjust spacing to fix argument alignment
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

