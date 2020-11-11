Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9A2C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B800F2087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AueMMHlG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgKKUCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbgKKUCd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:02:33 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DE3C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:32 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id j7so3753157wrp.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h5PnHyptBUWzu+AN7UGcuZ3DQJK/OQ/2tdMdIpZtNLg=;
        b=AueMMHlGLpkED7wAWBz8T6aE4W2w4Z9v9GO9c+WlENUv1UbG+sNF+8tvTOLOLRMQB0
         unerycfegFCCfxiVjAHBXgDT3fHiJRokksrNrvRUgOY+I4puTzSC4v8VUpfcW6fcNmPL
         20/TigoaXR+U1yUZ1pLFHTEMFHAYSjBybOMxQ6HL073fZj0njV5plHPw/V/S+EaIGE0m
         EIh3sdE2KA7oJT8pCq3bTnhJnWjTrWRch50dTn9lpv2WmKh/64S7nkSdi6IWlYTtdJb8
         ovA2WetU0I0IKnaLB0qTpEkMs1LIspKp1XJek+UBnUgUa8pgp5irHYHsSeOHO6DnMJkd
         GVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h5PnHyptBUWzu+AN7UGcuZ3DQJK/OQ/2tdMdIpZtNLg=;
        b=FRKnAR0DTXhIq4HWkPN1Sk8Ie/NQByeUvOJHdZAx7buL0Lky1TXER8cAhC/RDw8S0v
         zGwx/ruunE2O9Df61Ni4M1oBE/QMh1vMt3xhtB/NluFlVyPd/O48ou6jPiMCAdee+ZsA
         tiiQdmZ7Q9a0mmk59j1jY8tQjYrVLb/tFohSQ8Y0AisJ26zEJ+O+suZlMU+l2Hn/Mved
         0WKh7IKDyWydycsZZOXO3DyzRGAxsBEfBKRyYij5xviHNB5TZOQYy6owyEiG+gnuIMCl
         3+gmxFXXlRIqCOFOR9KyJkHHuhX4X3dnl03tNTBvUpsm38zaWNPmMxe/ny3S/spKcI8P
         RPCQ==
X-Gm-Message-State: AOAM532WJzxAwXqLV6khkfsQ89qNn/KFrKTVHguf1ZLfDqnqfi9Y0oUj
        fUhtxSqk1Kxt2ikyDAqOyskomjsGzyc=
X-Google-Smtp-Source: ABdhPJx/4bJ8ZsOH2R8XEELrooVqKp6VmrvBymXqushzvEASjhXj6OfgWDmRKb4nn7VZMgjCVistcg==
X-Received: by 2002:adf:c58f:: with SMTP id m15mr32757047wrg.144.1605124951204;
        Wed, 11 Nov 2020 12:02:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h4sm3617919wrq.3.2020.11.11.12.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:02:30 -0800 (PST)
Message-Id: <f499934f54a2d1d9ac6ffeafcd6388d183d26fa3.1605124942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
References: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
        <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 20:02:15 +0000
Subject: [PATCH v6 09/15] strmap: add functions facilitating use as a
 string->int map
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

Although strmap could be used as a string->int map, one either had to
allocate an int for every entry and then deallocate later, or one had to
do a bunch of casting between (void*) and (intptr_t).

Add some special functions that do the casting.  Also, rename put->set
for such wrapper functions since 'put' implied there may be some
deallocation needed if the string was already found in the map, which
isn't the case when we're storing an int value directly in the void*
slot instead of using the void* slot as a pointer to data.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strmap.c | 11 +++++++
 strmap.h | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

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
index c14fcee148..56a5cdb864 100644
--- a/strmap.h
+++ b/strmap.h
@@ -23,6 +23,10 @@ int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
 			.map = HASHMAP_INIT(cmp_strmap_entry, NULL),  \
 			.strdup_strings = 1,                          \
 		    }
+#define STRINTMAP_INIT { \
+			.map = STRMAP_INIT,   \
+			.default_value = 0,   \
+		       }
 
 /*
  * Initialize the members of the strmap.  Any keys added to the strmap will
@@ -102,4 +106,94 @@ static inline int strmap_empty(struct strmap *map)
 #define strmap_for_each_entry(mystrmap, iter, var)	\
 	hashmap_for_each_entry(&(mystrmap)->map, iter, var, ent)
 
+
+/*
+ * strintmap:
+ *    A map of string -> int, typecasting the void* of strmap to an int.
+ *
+ * Primary differences:
+ *    1) Since the void* value is just an int in disguise, there is no value
+ *       to free.  (Thus one fewer argument to strintmap_clear)
+ *    2) strintmap_get() returns an int, or returns the default_value if the
+ *       key is not found in the strintmap.
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

