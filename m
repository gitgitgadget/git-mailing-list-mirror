Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916C7C433E3
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 701D120791
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdayLfnt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgHUSwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgHUSwg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 14:52:36 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60462C061574
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 11:52:35 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id p14so2854474wmg.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 11:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LPrFHbpoth+mxJptyUE+TeIv68nOfDNFxY+AnFxUX84=;
        b=MdayLfnt0A/nmXXAQbNwO7098Hnvs5wXMnYg9bBngmUDCCh4EQmgQ9ecO8GyGTKzOU
         YGv5aYIL9XlRTh0F2mRJvAw0eLXPUmCWl38Se1xXlOjSJNGuluF6XBf8haKybBpQF5ga
         fKUiKjb4nJUkvsYgmZi21UabcEr5RBZtFzVpsNPAUgdqJKVQFLe5cQYF36NVqI78WPa9
         Zi1AjbqJOsCLTxaLYfE1JNyjrB3B9Vb4mc3GM5UmYIgzuEJ8+RTWWILfiYXcl4riYu32
         xdpff0gO303zUln6g4Ep/XnPq5Sez6gTkQ9stEORa5L7ZZ7mPVL9/FGseP1INoVhop0i
         kA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LPrFHbpoth+mxJptyUE+TeIv68nOfDNFxY+AnFxUX84=;
        b=UJMy3QQvHNLj8NHsocsne4wv591+kzNVngDSSwTZXfZ6kz2TMriDX/hO9h9MOw1K/+
         GGv1o23Pr95DPRJ5IBfUq018ZdqwN+Sj0fR0dqT/HZFfgro0UAP+grjFt8BiYU8qqYYM
         mkKVDtaSfwrWV/EzFHmdBXDM6h2L5NjgSJV56ryI+/6P9UtZXJuf6Ny9GSgbZrRBpjN3
         Nn85kIMYoNdIHOo3QdoChKh4s4ytyRu45+QNggG5x/P/u2+wNOSHhif2DxhasznSh3Jq
         RlUWYPsesW+HdkZaqM54jnBVWzXF+11Cnhj325EiTEDknx956HG47l7/yoW5xfkB/ype
         fr3g==
X-Gm-Message-State: AOAM532+r52uWBOjlrfXE4bHwP69p445EA4E7dU9/6tPQJMU0g2Hllij
        Q76LULFGQvbcxlXJ3BWj+oxtOimg9dc=
X-Google-Smtp-Source: ABdhPJwuVs8zrFgOTy736B7mV+24xoXE1xp/WAQqi3ghXs1k1CLZZ38VWo6IIwtkWrPWnQmQTj65Zg==
X-Received: by 2002:a1c:61d5:: with SMTP id v204mr4630108wmb.102.1598035953478;
        Fri, 21 Aug 2020 11:52:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h13sm5769163wrx.17.2020.08.21.11.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:52:33 -0700 (PDT)
Message-Id: <5bda171d0c1562573800d4bcbfac4799f01d9c20.1598035949.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 18:52:27 +0000
Subject: [PATCH 3/5] strmap: add more utility functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This adds a number of additional convienence functions I want/need:
  * strmap_empty()
  * strmap_get_size()
  * strmap_remove()
  * strmap_for_each_entry()
  * strmap_free()
  * strmap_get_item()

I suspect the first four are self-explanatory.

strmap_free() differs from strmap_clear() in that the data structure is
not reusable after it is called; strmap_clear() is not sufficient for
the API because without strmap_free() we will leak memory.

strmap_get_item() is similar to strmap_get() except that instead of just
returning the void* value that the string maps to, it returns the
string_list_item that contains both the string and the void* value (or
NULL if the string isn't in the map).  This is helpful because it avoids
multiple lookups, e.g. in some cases a caller would need to call:
  * strmap_contains() to check that the map has an entry for the string
  * strmap_get() to get the void* value
  * <do some work to update the value>
  * strmap_put() to update/overwrite the value
If the void* pointer returned really is a pointer, then the last step is
unnecessary, but if the void* pointer is just cast to an integer then
strmap_put() will be needed.  In contrast, one can call strmap_get_item()
and then:
  * check if the string was in the map by whether the pointer is NULL
  * access the value via item->util
  * directly update item->util
meaning that we can replace two or three hash table lookups with one.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strmap.c | 35 ++++++++++++++++++++++++++++++-----
 strmap.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/strmap.c b/strmap.c
index 1c9fdb3b1e..a4bfffcd8b 100644
--- a/strmap.c
+++ b/strmap.c
@@ -27,7 +27,7 @@ void strmap_init(struct strmap *map)
 	hashmap_init(&map->map, cmp_str_entry, NULL, 0);
 }
 
-void strmap_clear(struct strmap *map, int free_util)
+void strmap_free(struct strmap *map, int free_util)
 {
 	struct hashmap_iter iter;
 	struct str_entry *e;
@@ -35,12 +35,19 @@ void strmap_clear(struct strmap *map, int free_util)
 	if (!map)
 		return;
 
-	hashmap_for_each_entry(&map->map, &iter, e, ent /* member name */) {
-		free(e->item.string);
-		if (free_util)
-			free(e->item.util);
+	if (free_util) {
+		hashmap_for_each_entry(&map->map, &iter, e, ent) {
+			free(e->item.string);
+			if (free_util)
+				free(e->item.util);
+		}
 	}
 	hashmap_free_entries(&map->map, struct str_entry, ent);
+}
+
+void strmap_clear(struct strmap *map, int free_util)
+{
+	strmap_free(map, free_util);
 	strmap_init(map);
 }
 
@@ -69,6 +76,13 @@ void *strmap_put(struct strmap *map, const char *str, void *data)
 	return old;
 }
 
+struct string_list_item *strmap_get_item(struct strmap *map,
+					 const char *str)
+{
+	struct str_entry *entry = find_str_entry(map, str);
+	return entry ? &entry->item : NULL;
+}
+
 void *strmap_get(struct strmap *map, const char *str)
 {
 	struct str_entry *entry = find_str_entry(map, str);
@@ -79,3 +93,14 @@ int strmap_contains(struct strmap *map, const char *str)
 {
 	return find_str_entry(map, str) != NULL;
 }
+
+void strmap_remove(struct strmap *map, const char *str, int free_util)
+{
+	struct str_entry entry, *ret;
+	hashmap_entry_init(&entry.ent, strhash(str));
+	entry.item.string = (char *)str;
+	ret = hashmap_remove_entry(&map->map, &entry, ent, NULL);
+	if (ret && free_util)
+		free(ret->item.util);
+	free(ret);
+}
diff --git a/strmap.h b/strmap.h
index eb5807f6fa..45d0a4f714 100644
--- a/strmap.h
+++ b/strmap.h
@@ -21,6 +21,11 @@ void strmap_init(struct strmap *map);
 /*
  * Remove all entries from the map, releasing any allocated resources.
  */
+void strmap_free(struct strmap *map, int free_values);
+
+/*
+ * Same as calling strmap_free() followed by strmap_init().
+ */
 void strmap_clear(struct strmap *map, int free_values);
 
 /*
@@ -32,6 +37,12 @@ void strmap_clear(struct strmap *map, int free_values);
  */
 void *strmap_put(struct strmap *map, const char *str, void *data);
 
+/*
+ * Return the string_list_item mapped by "str", or NULL if there is not such
+ * an item in map.
+ */
+struct string_list_item *strmap_get_item(struct strmap *map, const char *str);
+
 /*
  * Return the data pointer mapped by "str", or NULL if the entry does not
  * exist.
@@ -44,4 +55,36 @@ void *strmap_get(struct strmap *map, const char *str);
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
+ * iterate through @map using @iter, @var is a pointer to a type str_entry
+ */
+#define strmap_for_each_entry(mystrmap, iter, var)	\
+	for (var = hashmap_iter_first_entry_offset(&(mystrmap)->map, iter, \
+						   OFFSETOF_VAR(var, ent)); \
+		var; \
+		var = hashmap_iter_next_entry_offset(iter, \
+						OFFSETOF_VAR(var, ent)))
+
 #endif /* STRMAP_H */
-- 
gitgitgadget

