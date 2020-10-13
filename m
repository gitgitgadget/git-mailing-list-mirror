Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C11C64E90
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E8DD221FF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSur9O4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgJMAlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 20:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgJMAk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 20:40:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4738FC0613D6
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 17:40:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b8so8485860wrn.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 17:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KEnjSmKih4lWnAW0mb4Dt4TMKpeMKIrQtliv1GGUO54=;
        b=KSur9O4p3UwBeV8pAbSUv/PAKSU5Ax1cHnCjS7I9SfLJ/i0KpBUqfERzfpy4Q6/rG/
         n5WtjjYDXGnKY76oQCzXqr0i5w2eDEGAAaY/Y3LuRMs8L1RM+fTij6NJGAV0ya2eXnrs
         BkBVq17PW4PI0X5Er2y1Hef7/+KY1OoeJ5lJye+R2q2AV+WrOkUyv3CXtabk5ifzQoMB
         JVp+hHNPKIbTl9zccSQlvLoSbiAe21niupyux8Qj/AxTQBYXMR/r6DdN3geaYrYedkrf
         cAc2lyWJWxk/upqmsADol9KjhC9TLfcbVYkMEMPgR4LK4MtIY21e/HQ8/X84gw6tCOjB
         iIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KEnjSmKih4lWnAW0mb4Dt4TMKpeMKIrQtliv1GGUO54=;
        b=NM0BPqGw/Apm/yJC3RiLSKISlP2cwxNWQ/ribq2aULm2el/DeobWcvjh3aNC2H7kSB
         pyx22UnX9znnBtDvHpEbYMWQ0ridFGyMjm2uE2CdVuWP/AFiXsJ858pj/v57rUNu8Ow8
         Gp6sx41VhZkyx0CqsSq6OkNn+9C6evh7RTOkNOZJii9t7lk9zUayuT1j+4McInY5JTTK
         YwX/+6Lp8IfIHPf3Valp1KBC0li1DQA703VrO6nove8TfEO0nONRCQ9Sb4Xj22JbQTW6
         S4km0gOhNbYu/ihGwtNHT844sBDU4nHtPzSy/nLVyoZ+58bQ7IKNTBEguNbShxfcE+1b
         ApFQ==
X-Gm-Message-State: AOAM533AFjfHg8V37Oq/+V5S2qIFwbqAanFn0JCXnxcIMxf9PAfcfdHf
        MnbsdA87/5yBCRy3VPmMtL5kVZoWeSk=
X-Google-Smtp-Source: ABdhPJxIhPCJ+UIKhOLEViVANPtmsmcfYMGD+RlRUQH/7md5/2dzjCuYtAAOOhNSmB4ALzqHPoP7tw==
X-Received: by 2002:adf:f7ca:: with SMTP id a10mr32236039wrq.321.1602549657786;
        Mon, 12 Oct 2020 17:40:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15sm27838288wrq.24.2020.10.12.17.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 17:40:57 -0700 (PDT)
Message-Id: <61b5bf11103a7bd12de8fd066e128c469da3a0a4.1602549650.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
        <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Oct 2020 00:40:46 +0000
Subject: [PATCH v2 06/10] strmap: add more utility functions
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

This adds a number of additional convienence functions I want/need:
  * strmap_empty()
  * strmap_get_size()
  * strmap_remove()
  * strmap_for_each_entry()
  * strmap_get_entry()

I suspect the first four are self-explanatory.

strmap_get_entry() is similar to strmap_get() except that instead of just
returning the void* value that the string maps to, it returns the
strmap_entry that contains both the string and the void* value (or
NULL if the string isn't in the map).  This is helpful because it avoids
multiple lookups, e.g. in some cases a caller would need to call:
  * strmap_contains() to check that the map has an entry for the string
  * strmap_get() to get the void* value
  * <do some work to update the value>
  * strmap_put() to update/overwrite the value
If the void* pointer returned really is a pointer, then the last step is
unnecessary, but if the void* pointer is just cast to an integer then
strmap_put() will be needed.  In contrast, one can call strmap_get_entry()
and then:
  * check if the string was in the map by whether the pointer is NULL
  * access the value via entry->value
  * directly update entry->value
meaning that we can replace two or three hash table lookups with one.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strmap.c | 20 ++++++++++++++++++++
 strmap.h | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/strmap.c b/strmap.c
index 4b48d64274..909b9fbedf 100644
--- a/strmap.c
+++ b/strmap.c
@@ -90,6 +90,11 @@ void *strmap_put(struct strmap *map, const char *str, void *data)
 	return old;
 }
 
+struct strmap_entry *strmap_get_entry(struct strmap *map, const char *str)
+{
+	return find_strmap_entry(map, str);
+}
+
 void *strmap_get(struct strmap *map, const char *str)
 {
 	struct strmap_entry *entry = find_strmap_entry(map, str);
@@ -100,3 +105,18 @@ int strmap_contains(struct strmap *map, const char *str)
 {
 	return find_strmap_entry(map, str) != NULL;
 }
+
+void strmap_remove(struct strmap *map, const char *str, int free_util)
+{
+	struct strmap_entry entry, *ret;
+	hashmap_entry_init(&entry.ent, strhash(str));
+	entry.key = str;
+	ret = hashmap_remove_entry(&map->map, &entry, ent, NULL);
+	if (!ret)
+		return;
+	if (free_util)
+		free(ret->value);
+	if (map->strdup_strings)
+		free((char*)ret->key);
+	free(ret);
+}
diff --git a/strmap.h b/strmap.h
index 493d19cbc0..e49d020970 100644
--- a/strmap.h
+++ b/strmap.h
@@ -42,6 +42,12 @@ void strmap_clear(struct strmap *map, int free_values);
  */
 void *strmap_put(struct strmap *map, const char *str, void *data);
 
+/*
+ * Return the strmap_entry mapped by "str", or NULL if there is not such
+ * an item in map.
+ */
+struct strmap_entry *strmap_get_entry(struct strmap *map, const char *str);
+
 /*
  * Return the data pointer mapped by "str", or NULL if the entry does not
  * exist.
@@ -54,4 +60,36 @@ void *strmap_get(struct strmap *map, const char *str);
  */
 int strmap_contains(struct strmap *map, const char *str);
 
+/*
+ * Remove the given entry from the strmap.  If the string isn't in the
+ * strmap, the map is not altered.
+ */
+void strmap_remove(struct strmap *map, const char *str, int free_value);
+
+/*
+ * Return whether the strmap is empty.
+ */
+static inline int strmap_empty(struct strmap *map)
+{
+	return hashmap_get_size(&map->map) == 0;
+}
+
+/*
+ * Return how many entries the strmap has.
+ */
+static inline unsigned int strmap_get_size(struct strmap *map)
+{
+	return hashmap_get_size(&map->map);
+}
+
+/*
+ * iterate through @map using @iter, @var is a pointer to a type strmap_entry
+ */
+#define strmap_for_each_entry(mystrmap, iter, var)	\
+	for (var = hashmap_iter_first_entry_offset(&(mystrmap)->map, iter, \
+						   OFFSETOF_VAR(var, ent)); \
+		var; \
+		var = hashmap_iter_next_entry_offset(iter, \
+						     OFFSETOF_VAR(var, ent)))
+
 #endif /* STRMAP_H */
-- 
gitgitgadget

