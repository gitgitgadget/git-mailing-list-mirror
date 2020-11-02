Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3E5C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEDA322268
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBRTIITU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgKBSzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgKBSzU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 13:55:20 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEBEC061A04
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 10:55:18 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id e2so10514102wme.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 10:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lfeFxSmzBLKnFekm6mzwPvSqu+S1DEbaBDz97hV1DAw=;
        b=cBRTIITUjdBIc28SfTElVgoBWeUe/7eqG7emK2+Lo4HfQVYpu+6NVUbxMYEyTuMBsZ
         rbFhiOXStvIgYFK2cv3gysc7tmm6bNtkdVFBlrYeSIkiSADm09YublTZGtmOFVuqzjId
         8dleE/9YUFy823zvwCn0YT8YpGLf6uTUscM8FFLnoof+VwHh8o+I5Wi0UJIu/A72NX45
         yfEGUoyTrKGn0j0S5lr6+1NgYATTT4wVir0+v2ADgDHWvRUGKvPmD31MI+AFWEsZbyw6
         vnP6cfk9z50shiLTgU2Dy/Br/2+WNgCXBxqPakHEcMg21E8jSiGsHoeR9i3L37dGq41u
         6pJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lfeFxSmzBLKnFekm6mzwPvSqu+S1DEbaBDz97hV1DAw=;
        b=fbXCM90L6XvaceR9ivZ+qW9HL921+5PdL97ZHVvHmmmdmsIaniQgF3B4VTThk8lpYD
         N+71AamkVBivZBp5XcWS9Uqol9f+B4E8gwZHLyb5VrebmwX1B/pXOY7bBd/hgV5BpsuP
         qEf3YMaOJcF6Zk9yLBzexFkxKnw8prHY8r2xbrb0baSps/bRIvz8WNhaAUHSeB4TrF0U
         c7GnSEXRXRZUOLwzzQqP6tNWNfpo8vNHAaKGd3R8MDzCMhVa5E+YqgixZhUtkZ6e4OBy
         V6OEL6xeD1JfRwqod7dmJRn6ABKTm8CdRgjfGBm/Tv69H76GFclKcr+EVnBGL6blwlt2
         RflA==
X-Gm-Message-State: AOAM530/k4iEKRS9QTCwSPTfIvXfsqY8/Nn77tuznOGw7QJfoTg70ZwP
        7GHrV83o138bkBmvM09mRrqM3kG/w4g=
X-Google-Smtp-Source: ABdhPJxmy3TGGzzfDpM2w6R1ZyzuFCDHNr5D6ik3yCkhO/8ap7B7FtK08vNgEccC6vW6Hr08EowevA==
X-Received: by 2002:a1c:490b:: with SMTP id w11mr9680533wma.101.1604343317454;
        Mon, 02 Nov 2020 10:55:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c129sm401027wmd.7.2020.11.02.10.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:55:16 -0800 (PST)
Message-Id: <591161fd781b7666ddaa45694eb20610cc359741.1604343314.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
References: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
        <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Nov 2020 18:55:02 +0000
Subject: [PATCH v3 02/13] hashmap: adjust spacing to fix argument alignment
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

