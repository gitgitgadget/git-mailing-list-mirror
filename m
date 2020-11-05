Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E254C55178
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 00:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACFB620825
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 00:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obWQVHBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732830AbgKEAYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 19:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbgKEAWv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 19:22:51 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAFCC0613D2
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 16:22:51 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id s13so27745wmh.4
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 16:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IEPGTilWFeb/gYnUiQHEDPP0R8dCTuzsEUTPxGrkZm8=;
        b=obWQVHBM05L2iGmhR1E5lditq9cEjKzG83HrRcnvlogtnS9mEOo+j167/Hi1dcEzak
         P9YHpPl9c14VOVqzTYQ1BzQLF3XthyCnN7ScVC9NIOHb7FXShcnYJzJ/Om2LZi9CKi1w
         ttyl98y94E9tVtpO6ur31gdnMOKxP9/2d/KTi49ZLGudlvXZ6vbn2y3wyG4X+XhqCXjC
         d56A5egJi45lmNDx7ha4o/wHtt+G221QJ077dJxJEzIE/gsVNPWLIAqIysBpWH5MxTj8
         aMBJnctQ+cAWzVxlWodZvZO3C7ANfixz8g0vh1wgnkGF1Ao7datCwOJEYk3TqBnCijGQ
         eEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IEPGTilWFeb/gYnUiQHEDPP0R8dCTuzsEUTPxGrkZm8=;
        b=fLeGb3uhMTsI4mOoKOHz5uY28sJLS5KNiQHbwtt9WUWpJVCuFnm++OV79U3dzFcyha
         sdEHoCfuOjxAFyYv++8zesd8JyLgfiH3/n3dbTzYQreK+UWJ0lBHcNdJNBaGV36l7wyz
         zB9ujyZEw1XMjxVmTUYTgZDfEOxXoMKOU4m0OWQEReC4w+H7oRJJPaqSTLp2f2SU8OJH
         P3n8dyLkM0LQykZVyHPwdkyjmfFydg99UO47HUzIVqeZU2T2cVAPuxYXRGRYVaaPOpoO
         EdAGTWGc5HtHtSK+LQe05hvaInHGO+qPztzccmBw27Y8GNBF99tE5HJw/GzIPsN9ievl
         Na9w==
X-Gm-Message-State: AOAM532y7Ilc+PExpJw/d1AED7vM9xrTkNKhaUIcD60Dupt8p/ZGI+zB
        MQ1Og2+zFSkZa5tLr378h1dNhjjJskg=
X-Google-Smtp-Source: ABdhPJxiGUEJBB8qykQLyqMTBPBnmrpKydVjeTEMmI/esCeJgxE5HSdWSJFpHBhL1Kltcv487FIvXQ==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr77803wmc.5.1604535769921;
        Wed, 04 Nov 2020 16:22:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o63sm6421wmo.2.2020.11.04.16.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 16:22:49 -0800 (PST)
Message-Id: <f2718d036dc5d08c2ed416a5ef98c5730bc38cfc.1604535765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
References: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
        <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 05 Nov 2020 00:22:35 +0000
Subject: [PATCH v4 03/13] hashmap: allow re-use after hashmap_free()
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

