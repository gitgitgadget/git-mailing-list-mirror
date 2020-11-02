Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9B6C2D0A3
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63DAE22268
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmVpuPlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgKBSzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgKBSzV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 13:55:21 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29E4C061A47
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 10:55:19 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id b3so9926937wrx.11
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 10:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IEPGTilWFeb/gYnUiQHEDPP0R8dCTuzsEUTPxGrkZm8=;
        b=MmVpuPltKb7eA6tjoT/JFGHI30J3q6pQzrOvYQyU1alDdeD0r5Egsla351n7/Zv8kl
         mhshrusduW/DAkf1hmKb+zel5q5xD0aBsuBl5h20pKyVbdrGoIR54h/SctqX2OucBiIC
         Dc1yygq+EldB7j9FeL9kBGE13IXaSeUhvJ32TSEcOSNtlhG2gDhBEq1G8TT2glPIf8Jh
         AlbEoN6bI5+i9mEuqnrXMbONj+6VCLwG6hrtiH9NX2iCcmqFtgfbRFZ9wIYWNrRAijvK
         IPS5fpGkK4MMEnV8+Zhk2vIkLQvFAt0l/aDZuOCPDUtuJzCNS0wlbih3hAb0WDrpQJZV
         SbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IEPGTilWFeb/gYnUiQHEDPP0R8dCTuzsEUTPxGrkZm8=;
        b=X6bghLz/DFfpZ5/tTcqR/jxzHW+a7FT/PhqQ3zHnY0SCH27feGVgoWTnqHjQ0Ptg0c
         +B7/lbIev/RVV6/Ul6sAfSBp5N8KyStwSkluX1fMBhFQOqN5OOhXBH0Gq0DV2rBHoAMM
         ceYcQJ/JPKwn2d0bjcD3dfUf4XHpAdm6aAUuE8D8YqyVwvzXHYCXpEYRTK07pakDwdE+
         blOVF7+CU2YqGYo65K1nuxVnMhBIAHZP+kdA26BykA+jA463zvres7qq6t4U9gY83lk+
         4CHrzzpvcdL10o7V+hpZBHS8k9/o8viHPIBL9uFjwXOxYEzjt28OvXYo+h+7jlx1SS5t
         0Hag==
X-Gm-Message-State: AOAM533MRP+570pEBqPuLE7G7UY31oJtXGFjI6APxkhGwNHceEmRjVSv
        RrufcobUc+npIVQDazcbrQ/ogaCWP4c=
X-Google-Smtp-Source: ABdhPJw7xCAmEQXjQJJmOSQa9FZK8C6deNx1wGda0zAcxcIN4Qy6fAAup/Qvi+J2st9RkbhFlV23xA==
X-Received: by 2002:adf:fc07:: with SMTP id i7mr16712331wrr.223.1604343318334;
        Mon, 02 Nov 2020 10:55:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13sm23930021wrp.12.2020.11.02.10.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:55:17 -0800 (PST)
Message-Id: <f2718d036dc5d08c2ed416a5ef98c5730bc38cfc.1604343314.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
References: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
        <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Nov 2020 18:55:03 +0000
Subject: [PATCH v3 03/13] hashmap: allow re-use after hashmap_free()
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

