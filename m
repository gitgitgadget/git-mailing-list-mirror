Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A907BC388F7
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ADAE2083B
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6+fLeny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732931AbgKFAZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 19:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732848AbgKFAZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 19:25:09 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F43AC0613CF
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 16:25:07 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c18so3275467wme.2
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 16:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LohV9wz4XDfYNIAtf11Guo8xRjkzYRDWgPPI+0a6uSM=;
        b=Z6+fLenyd4rzOKeMIFqb9yQG1e5FPbTopvHGdkxdR0875kuHlEa5UWiVWM+YF0IX3k
         dyMPh2kjiY2IxcKrJd8+fU+XAtFpiFWpe6bg9FpLavC94iFqaS8MBZMQ9MIPjDW0QuBH
         zYjjFRwRTJLadsB8kGHCokRaBEzebAD7Ex8ADYW3B6NyoXAledSp5a9yZW8DJEQ8bUYR
         QxLZX8qePQAi1fYmj3IBmt1FBTYMjL8tu357oOerDyP1KjxKeAjfCTFKv2HyunQUgHCJ
         Qvg8g+JWsMjucDULGsPqz6RtaUkmnHOh99fUUQPqKhIJQi57YHmu5bB25A3DO6mBgxPe
         217A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LohV9wz4XDfYNIAtf11Guo8xRjkzYRDWgPPI+0a6uSM=;
        b=DfOSHV3uor2OgTeu9wkbbga8fNWgvbVPOh98ud51oLpzAoUpq7OE2FL4mcf89soVwn
         iTVpVdeJsZgF6n17zdmcnia6p0HwEEOCfRNXSGD/GfPoWKO+7cHW50T7nqgPcxdmhXPc
         twp6s+bh//ki44/vAs6KzosTm6BDi0fRUHRAk7TS+zjMS/NHAIrFU7gNlB54Qja/N45I
         M4EgwbTnkoOjK034Q5kvuCNykLCScS9gHI2mM4CxHAhqq/MylFjFqGHHLxjZpUStu8+z
         zckp1DKlP/D0fQ1b+PdHGUE/8n6Mf+eItQ5piDzUwS6iN4RdD1/2GlNR6TMDQgJ8Yrq8
         WT6A==
X-Gm-Message-State: AOAM531mCXFsOtmgLS/iFxyCTOsDjlRsdfGa66Ng/I97KstuTEh0b9is
        odiHNduHZ7rSCwKjy+OhEmml4Ijyi1o=
X-Google-Smtp-Source: ABdhPJyt+fI1ijLIK89y4kSLxJoIrzOwhA5NdRpefGPZA+DlmRNu7T6tzk1ZhZl/8kbUub2oU3VDTw==
X-Received: by 2002:a1c:f417:: with SMTP id z23mr5022672wma.57.1604622306110;
        Thu, 05 Nov 2020 16:25:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o184sm4895321wmo.37.2020.11.05.16.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 16:25:05 -0800 (PST)
Message-Id: <5e8004c728580589cdaf46d755f2c977feaffb34.1604622299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
References: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
        <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Nov 2020 00:24:50 +0000
Subject: [PATCH v5 07/15] strmap: add more utility functions
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

This adds a number of additional convienence functions I want/need:
  * strmap_get_size()
  * strmap_empty()
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
 strmap.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/strmap.c b/strmap.c
index 53f284eb20..829f1bc095 100644
--- a/strmap.c
+++ b/strmap.c
@@ -87,6 +87,11 @@ void *strmap_put(struct strmap *map, const char *str, void *data)
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
@@ -97,3 +102,18 @@ int strmap_contains(struct strmap *map, const char *str)
 {
 	return find_strmap_entry(map, str) != NULL;
 }
+
+void strmap_remove(struct strmap *map, const char *str, int free_value)
+{
+	struct strmap_entry entry, *ret;
+	hashmap_entry_init(&entry.ent, strhash(str));
+	entry.key = str;
+	ret = hashmap_remove_entry(&map->map, &entry, ent, NULL);
+	if (!ret)
+		return;
+	if (free_value)
+		free(ret->value);
+	if (map->strdup_strings)
+		free((char*)ret->key);
+	free(ret);
+}
diff --git a/strmap.h b/strmap.h
index 96888c23ad..f74bc582e4 100644
--- a/strmap.h
+++ b/strmap.h
@@ -50,6 +50,12 @@ void strmap_clear(struct strmap *map, int free_values);
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
@@ -62,4 +68,32 @@ void *strmap_get(struct strmap *map, const char *str);
  */
 int strmap_contains(struct strmap *map, const char *str);
 
+/*
+ * Remove the given entry from the strmap.  If the string isn't in the
+ * strmap, the map is not altered.
+ */
+void strmap_remove(struct strmap *map, const char *str, int free_value);
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
+ * Return whether the strmap is empty.
+ */
+static inline int strmap_empty(struct strmap *map)
+{
+	return strmap_get_size(map) == 0;
+}
+
+/*
+ * iterate through @map using @iter, @var is a pointer to a type strmap_entry
+ */
+#define strmap_for_each_entry(mystrmap, iter, var)	\
+	hashmap_for_each_entry(&(mystrmap)->map, iter, var, ent)
+
 #endif /* STRMAP_H */
-- 
gitgitgadget

