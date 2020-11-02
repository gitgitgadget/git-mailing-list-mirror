Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC4BC388F9
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE172225E
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7nDxDLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgKBSz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgKBSz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 13:55:26 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D5CC061A48
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 10:55:24 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 33so5051805wrl.7
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 10:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xYsZusN3B7Ocz/+8CSNj5PLz4D9pdVqEn3wjc3y9pYs=;
        b=Y7nDxDLEUMUOaEnOo/qQbwopr8/7B+7uTk/yicx4Vx44YMNx5dLcavCbjH7LDvOBad
         j7y8ZuwG28OaMTcpO85QIFtaxsuEuHY3cT7C4hxmM5z6EBnXPq0YVQThmUb5q1oxhzix
         AqM46Vn0iLODtmVU1+6uHKEFDTLUws5r6J/zDMAsNt6BtjCO3DZqz+SXhPR99J05Fhtd
         KGw9rfAQxu9GUU5MUg0QutfLURbZBH2rRUE7AOtODb3NYr3iYlz1bGO00ljpM25BB4HD
         L/YiTzqYhffu/+1vhJ6tEwSkfTERMeslkGFf54oIEYvz3OENOOr55glDDlL8zMRQxycI
         1rIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xYsZusN3B7Ocz/+8CSNj5PLz4D9pdVqEn3wjc3y9pYs=;
        b=L43VwzRKq49rrT5kdLhEPs7ISc7G4GtRkSy+1pKN/ErSSrHRYZPI8sxQdhfmG2hnho
         rj0wMh6CTb/kcx9/2FgO6JhRWsh6eL8FHaoLFE9u/jlFg3UsbuQpH7WlqASCsDAkzwVM
         T4tiZeykrmnM/vRHjYv4qwr47aJ18qu4HyTwqgognWIS4l+htFty0Xt6TnfLtIjt3kdV
         vB/J/pOmSVIycW6YAREss4pz/I9wO2WyxoD8Fg4+OluejZJrQqFtOHytDxVwYVkK7YMq
         By2h5qehE0vr1kLxGtYgbdsK4/b0OibpCAGz7E4oc6wRBBlLlq6BtJZSSpqhnRQDPSFF
         WdXQ==
X-Gm-Message-State: AOAM533HnsFGwuIY2xz3tJe2fX7bOc86VByRvWEFuIURw/sm4qMVqXUg
        Ij1lLv4eqNlzmfl2yI8bzn0mXS7kJio=
X-Google-Smtp-Source: ABdhPJwhGhMSlfPLB2ksqaBxgsxbo8ULF9uG4J/mlOUZj/RHz0ZCwmr772dz5QIYvxxxr1PSx7p07g==
X-Received: by 2002:a5d:6783:: with SMTP id v3mr21244478wru.385.1604343323046;
        Mon, 02 Nov 2020 10:55:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm22512394wru.15.2020.11.02.10.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:55:22 -0800 (PST)
Message-Id: <c1d217217180cff0b048d5dbac57b8e363db7848.1604343314.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
References: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
        <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Nov 2020 18:55:09 +0000
Subject: [PATCH v3 09/13] strmap: add functions facilitating use as a
 string->int map
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

Although strmap could be used as a string->int map, one either had to
allocate an int for every entry and then deallocate later, or one had to
do a bunch of casting between (void*) and (intptr_t).

Add some special functions that do the casting.  Also, rename put->set
for such wrapper functions since 'put' implied there may be some
deallocation needed if the string was already found in the map, which
isn't the case when we're storing an int value directly in the void*
slot instead of using the void* slot as a pointer to data.

A note on the name: if anyone has a better name suggestion than
strintmap, I'm happy to take it.  It seems slightly unwieldy, but I have
not been able to come up with a better name.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strmap.c | 11 +++++++
 strmap.h | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/strmap.c b/strmap.c
index c410c5241a..0d10a884b5 100644
--- a/strmap.c
+++ b/strmap.c
@@ -123,3 +123,14 @@ void strmap_remove(struct strmap *map, const char *str, int free_value)
 		free((char*)ret->key);
 	free(ret);
 }
+
+void strintmap_incr(struct strintmap *map, const char *str, intptr_t amt)
+{
+	struct strmap_entry *entry = find_strmap_entry(&map->map, str);
+	if (entry) {
+		intptr_t *whence = (intptr_t*)&entry->value;
+		*whence += amt;
+	}
+	else
+		strintmap_set(map, str, map->default_value + amt);
+}
diff --git a/strmap.h b/strmap.h
index 10b4642860..31474f781e 100644
--- a/strmap.h
+++ b/strmap.h
@@ -23,6 +23,11 @@ int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
 			.map = HASHMAP_INIT(cmp_strmap_entry, NULL),  \
 			.strdup_strings = 1,                          \
 		    }
+#define STRINTMAP_INIT { \
+			.map.map = HASHMAP_INIT(cmp_strmap_entry, NULL),  \
+			.map.strdup_strings = 1,                          \
+			.default_value = 0,                               \
+		    }
 
 /*
  * Initialize the members of the strmap.  Any keys added to the strmap will
@@ -104,4 +109,95 @@ static inline int strmap_empty(struct strmap *map)
 		var; \
 		var = hashmap_iter_next_entry_offset(iter, 0))
 
+
+/*
+ * strintmap:
+ *    A map of string -> int, typecasting the void* of strmap to an int.
+ *
+ * Primary differences:
+ *    1) Since the void* value is just an int in disguise, there is no value
+ *       to free.  (Thus one fewer argument to strintmap_clear)
+ *    2) strintmap_get() returns an int; it also requires an extra parameter to
+ *       be specified so it knows what value to return if the underlying strmap
+ *       has not key matching the given string.
+ *    3) No strmap_put() equivalent; strintmap_set() and strintmap_incr()
+ *       instead.
+ */
+
+struct strintmap {
+	struct strmap map;
+	int default_value;
+};
+
+#define strintmap_for_each_entry(mystrmap, iter, var)	\
+	strmap_for_each_entry(&(mystrmap)->map, iter, var)
+
+static inline void strintmap_init(struct strintmap *map, int default_value)
+{
+	strmap_init(&map->map);
+	map->default_value = default_value;
+}
+
+static inline void strintmap_init_with_options(struct strintmap *map,
+					       int default_value,
+					       int strdup_strings)
+{
+	strmap_init_with_options(&map->map, strdup_strings);
+	map->default_value = default_value;
+}
+
+static inline void strintmap_clear(struct strintmap *map)
+{
+	strmap_clear(&map->map, 0);
+}
+
+static inline void strintmap_partial_clear(struct strintmap *map)
+{
+	strmap_partial_clear(&map->map, 0);
+}
+
+static inline int strintmap_contains(struct strintmap *map, const char *str)
+{
+	return strmap_contains(&map->map, str);
+}
+
+static inline void strintmap_remove(struct strintmap *map, const char *str)
+{
+	return strmap_remove(&map->map, str, 0);
+}
+
+static inline int strintmap_empty(struct strintmap *map)
+{
+	return strmap_empty(&map->map);
+}
+
+static inline unsigned int strintmap_get_size(struct strintmap *map)
+{
+	return strmap_get_size(&map->map);
+}
+
+/*
+ * Returns the value for str in the map.  If str isn't found in the map,
+ * the map's default_value is returned.
+ */
+static inline int strintmap_get(struct strintmap *map, const char *str)
+{
+	struct strmap_entry *result = strmap_get_entry(&map->map, str);
+	if (!result)
+		return map->default_value;
+	return (intptr_t)result->value;
+}
+
+static inline void strintmap_set(struct strintmap *map, const char *str,
+				 intptr_t v)
+{
+	strmap_put(&map->map, str, (void *)v);
+}
+
+/*
+ * Increment the value for str by amt.  If str isn't in the map, add it and
+ * set its value to default_value + amt.
+ */
+void strintmap_incr(struct strintmap *map, const char *str, intptr_t amt);
+
 #endif /* STRMAP_H */
-- 
gitgitgadget

