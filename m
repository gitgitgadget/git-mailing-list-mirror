Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18588C35257
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2EC9221EB
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+5Jjqqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgJMAlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 20:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgJMAk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 20:40:57 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269DBC0613D1
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 17:40:57 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id d81so19157448wmc.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 17:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ulu1a7Z8URVVgHXrOaVnFTbZaxHFvjABh5GwMGelmWo=;
        b=R+5JjqqezQnEpWBoRP5d8T58oIQMnO5iwWPT06Fr/5SS1pbGwVfNO3R5Am/Jn/SYRq
         fr+SzHd2rUgRv9qJLDupr8lzuv2wAf4OIZ9djARIo2YIkTSElcD+SLR7eZy1EWLhuAlc
         w4P76BuziUCJTLe2PmBqof4vCxy6lvtiAJ2fCDDPyDz+rLQYyzGhnu8sUt8BEZiMHEh+
         mFTi6XJ+qaywLsbn95Ya2xVDaj1Db+/YaOZYEdSfqkOJPU0ff+zF3+av04Q/PYFwj27i
         Dys+4yG2QeWtg/3xCq/DcqPxStYJN4KcOw+IGa2nW6zDmjYBBs5ncUGReWhgyCJQKwU8
         6TdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ulu1a7Z8URVVgHXrOaVnFTbZaxHFvjABh5GwMGelmWo=;
        b=DxzNJ5AP+mGxO4NGbOv9egvKvPvcLjQkNs7y4vQsbYJvSnGI1NX91r4i7TsRKCDxB3
         2uPCBvLrmQuSyruP4slXZvAvtw/5LvT37kc7fgwpVnt9GxNOjn/bHshXgzyNjtbBqufl
         9dD5OVDWeAw9tlCbrdzjNHIcNXfT3sqqzfhPy9fF60p8aK6bKIkRxuHx8Qv0GLQ92wK3
         c4q38SE78+dWZUJz9zUIqngfrExWpS4rg6JR1OYcGGRSu5yAssnqMKvwm7DPMY8ClQoa
         spMlsapYRD1XwinY28Lc+UtP3wF5hJfDX7OSJ2EBSAYPD3LN1bIhQd1iLvX7oJC9Dz4I
         PeSg==
X-Gm-Message-State: AOAM530IKkw5qu4fpsWDDLgWV3iDkDcByJn4a41OU/Gu/FJCeMZgc7/w
        N4f/I5xcA1PkEwA47SKbhOGqzUfcyA0=
X-Google-Smtp-Source: ABdhPJwBBJ95s5Ene/wbJY2Bjdq5YAkGbbuSReqMoH/Ed8rRqTkBt7K868tJSCf3S1d0FKn+LZkgwQ==
X-Received: by 2002:a1c:2e53:: with SMTP id u80mr13131965wmu.58.1602549654401;
        Mon, 12 Oct 2020 17:40:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm17359888wrs.66.2020.10.12.17.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 17:40:53 -0700 (PDT)
Message-Id: <75f17619e964a8a1ab2ecd8267c25c10e5d68bef.1602549650.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
        <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Oct 2020 00:40:42 +0000
Subject: [PATCH v2 02/10] hashmap: adjust spacing to fix argument alignment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

No actual code changes; just whitespace adjustments.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 hashmap.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

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
-- 
gitgitgadget

