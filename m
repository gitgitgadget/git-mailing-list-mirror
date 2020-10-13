Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43379C64EBC
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 072E7221FC
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0ZLVpqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgJMAlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 20:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgJMAk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 20:40:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB21C0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 17:40:56 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a72so8562455wme.5
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 17:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QqL4DlqJj9z09lyFJN7Icv/rtGGcEz0/flSRFpTZtL0=;
        b=Z0ZLVpqUrZKrW1jqu8FHWJhdgMwNqSo8/hrwCMWvi34R66Lvh8NLEH+hlAmtZQs9N5
         s5HI9HEF6Jw1xe90/1pc84K/hIBGQm7sA5JjpWVbgLTvd8QkDvkjaAyjQPZpwPYtIEIz
         Tmm1wSP/pnDWEp81+zQsSMQlYW0WJSpzqYaoYzDnVDIGazBwW8G0nik4Kc5+VVf1o8JJ
         vuddWP0typj909hRHPyLEwJpEsmG4Ogp0qPZvGHGVFaVxC1Z/IQIJSmyBUweV8/Tejx0
         AAwr5iaTPSIw3ymMJXzJDtZ9sC52rgpcGBecj61MwpuapaflyggM5m6RNZkNqCgb21/Y
         C95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QqL4DlqJj9z09lyFJN7Icv/rtGGcEz0/flSRFpTZtL0=;
        b=ctogi0+7+FKTAchJGbUkgvBthcy7xvf/tL1t4bszkMnwze3aRPRL9TrgQBXG2psinJ
         2fdVo3TmvoDNnMUMqt2VIe6vAvneKgZd+pTmhqaplhJ7OOCo9D20D3W8tc2SEJA20cwB
         6ihSzW3DSmPcRWRRsHe4I9LOEBAGTT3pCU9KowI7bquVN3B+JCkN+Umhuj38vD+ET9d4
         aupXClKLKSMBuoH2bxydIbgbDhf37mzO55m6cpXk94qeZHVL1ctF3Y2vw1GwKXTJyFOq
         bbirkLER95qE3tzdQznX8AIFv8DGBDiEbldrfGuwS9G6vmLzNzgq9q9Zpjd+BxnwfReT
         dAOw==
X-Gm-Message-State: AOAM533Ro6otqzY5Dbq55dpgmK81qBlE/YZ+uad5DugBg6rUGmlREt46
        /ZqUknikCaMBsAc3MrdIQ3+ddoi/Nfs=
X-Google-Smtp-Source: ABdhPJxE5fbjjoD9gM+vzVrEEfuQbYpRMQaAOnfTKTEWdkg9BgCHSvAh88CR7CUaHkDME0IiswuEtw==
X-Received: by 2002:a7b:c0c8:: with SMTP id s8mr12619987wmh.78.1602549655296;
        Mon, 12 Oct 2020 17:40:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a81sm27624788wmf.32.2020.10.12.17.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 17:40:54 -0700 (PDT)
Message-Id: <a686d0758a2652c91363dcf68da7726093d00c23.1602549650.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
        <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Oct 2020 00:40:43 +0000
Subject: [PATCH v2 03/10] hashmap: allow re-use after hashmap_free()
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

Previously, once map->table had been freed, any calls to hashmap_put(),
hashmap_get(), or hashmap_remove() would cause a NULL pointer
dereference (since hashmap_free_() also zeros the memory; without that
zeroing, calling these functions would cause a use-after-free problem).

Modify these functions to check for a NULL table and automatically
allocate as needed.

I also thought about creating a HASHMAP_INIT macro to allow initializing
hashmaps on the stack without calling hashmap_init(), but virtually all
uses of hashmap specify a usecase-specific equals_function which defeats
the utility of such a macro.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 hashmap.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

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
 
-- 
gitgitgadget

