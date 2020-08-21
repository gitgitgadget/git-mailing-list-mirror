Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8607C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B661420791
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUx+CKpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgHUSws (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgHUSwi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 14:52:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED64C061575
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 11:52:37 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id x5so2841949wmi.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 11:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XJYIWhbGYgy2LI4WVg5fpvlWd/v+EMmGDc4kl64UhnA=;
        b=NUx+CKpV2tcXqPS3+3fV7FZ9bUehIaNBr/fp5zm0KwtxQqNk+HCUhF5XspXoctXuwL
         FwMieVvfIenTGC1HmpvcG28svne4TV4eOTYimFUb1dmFdaCAog6uwHDa+2RSqJSyaBgd
         ZiSoYOAsh2XYQOktjaYavlB8lvsmIa0fWqOyNFjtMtl0o3pJP5sinXYb/ZDJ7qbKow6p
         acy7dywp7pURxSuSDTF6CoQEhXYZROVYdJhiaMx5b7lgvtCF6t7m36cBGeRnkIgLuklz
         uLYNA3MxlJj1AXQNrzUzeusbW9t09pkBhA+Xn51R61SHrtoxT3kW0kfRvKRsx/CI2jMK
         zP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XJYIWhbGYgy2LI4WVg5fpvlWd/v+EMmGDc4kl64UhnA=;
        b=fNceaS+pfKzkXK8rTKox9/Qjl9qA1G/wCfm6zijMVETmejYOI9TM9tOHPRIC3EsVir
         UWVl6V8tb8d1acX6PpiDGuUqqs7avM0hr4KwmruT9l1oF4N0h/ZvgVQRZJW3MQNulaLy
         mXq/wGN7sVnpfwBOQth+BxocsGpB1FKB3Zm0UHV/luX/5AoDqTORAAFJi50ZtgEJl/1x
         HuTSBVAsSZ+K8Ahk0LJ5Z4r2rjIidizhW2rk90R/8mIWcloccBnA1fGLpk/wi5k819of
         ZPSb2XJ9a01e895EJUL89NzRIRuFlSLcMEGWI9UNwTQGEky0U4ETpZuUJGWyUXnXWIFX
         mKAQ==
X-Gm-Message-State: AOAM530kxr2SwTt3/bmxn75xsqfGAilP4/M0Q31W4taleFFr9ogbCfkj
        5WbvE4I8FCxP4gXJbsuyw9k7xMdtOJc=
X-Google-Smtp-Source: ABdhPJzKp1fP+BM5BqiMHHmwQZf35v3WU2xeG/TTl8PZzHd9GJ2fB0bH171nMMKyaaY5ZYzGFE85lQ==
X-Received: by 2002:a1c:1f88:: with SMTP id f130mr4721903wmf.154.1598035952682;
        Fri, 21 Aug 2020 11:52:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k4sm6632994wrd.72.2020.08.21.11.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:52:32 -0700 (PDT)
Message-Id: <a86fd5fdcc47baf85046eb07257f4db9f9498084.1598035949.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 18:52:26 +0000
Subject: [PATCH 2/5] strmap: new utility functions
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

Add strmap as a new struct and associated utility functions,
specifically for hashmaps that map strings to some value.  The API is
taken directly from Peff's proposal at
https://lore.kernel.org/git/20180906191203.GA26184@sigill.intra.peff.net/

Peff only included the header, not the implementation, so it isn't clear what
the structure was he was going to use for the hash entries.  Instead of having
my str_entry struct have three subfields (the hashmap_entry, the string, and
the void* value), I made it only have two -- the hashmap_entry and a
string_list_item, for two reasons:

  1) a strmap is often the data structure we want where string_list has
     been used in the past.  Using the same building block for
     individual entries in both makes it easier to adopt and reuse
     parts of the string_list API in strmap.

  2) In some cases, after doing lots of other work, I want to be able
     to iterate over the items in my strmap in sorted order.  hashmap
     obviously doesn't support that, but I wanted to be able to export
     the strmap to a string_list easily and then use its functions.
     (Note: I do not need the data structure to both be sorted and have
     efficient lookup at all times.  If I did, I might use a B-tree
     instead, as suggested by brian in response to Peff in the thread
     noted above.  In my case, most strmaps will never need sorting, but
     in one special case at the very end of a bunch of other work I want
     to iterate over the items in sorted order without doing any more
     lookups afterward.)

Also, I removed the STRMAP_INIT macro, since it cannot be used to
correctly initialize a strmap; the underlying hashmap needs a call to
hashmap_init() to allocate the hash table first.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Makefile |  1 +
 strmap.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 strmap.h | 47 ++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 strmap.c
 create mode 100644 strmap.h

diff --git a/Makefile b/Makefile
index 65f8cfb236..0da15a9ee5 100644
--- a/Makefile
+++ b/Makefile
@@ -988,6 +988,7 @@ LIB_OBJS += strbuf.o
 LIB_OBJS += strvec.o
 LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
+LIB_OBJS += strmap.o
 LIB_OBJS += sub-process.o
 LIB_OBJS += submodule-config.o
 LIB_OBJS += submodule.o
diff --git a/strmap.c b/strmap.c
new file mode 100644
index 0000000000..1c9fdb3b1e
--- /dev/null
+++ b/strmap.c
@@ -0,0 +1,81 @@
+#include "git-compat-util.h"
+#include "strmap.h"
+
+static int cmp_str_entry(const void *hashmap_cmp_fn_data,
+			 const struct hashmap_entry *entry1,
+			 const struct hashmap_entry *entry2,
+			 const void *keydata)
+{
+	const struct str_entry *e1, *e2;
+
+	e1 = container_of(entry1, const struct str_entry, ent);
+	e2 = container_of(entry2, const struct str_entry, ent);
+	return strcmp(e1->item.string, e2->item.string);
+}
+
+static struct str_entry *find_str_entry(struct strmap *map,
+					const char *str)
+{
+	struct str_entry entry;
+	hashmap_entry_init(&entry.ent, strhash(str));
+	entry.item.string = (char *)str;
+	return hashmap_get_entry(&map->map, &entry, ent, NULL);
+}
+
+void strmap_init(struct strmap *map)
+{
+	hashmap_init(&map->map, cmp_str_entry, NULL, 0);
+}
+
+void strmap_clear(struct strmap *map, int free_util)
+{
+	struct hashmap_iter iter;
+	struct str_entry *e;
+
+	if (!map)
+		return;
+
+	hashmap_for_each_entry(&map->map, &iter, e, ent /* member name */) {
+		free(e->item.string);
+		if (free_util)
+			free(e->item.util);
+	}
+	hashmap_free_entries(&map->map, struct str_entry, ent);
+	strmap_init(map);
+}
+
+/*
+ * Insert "str" into the map, pointing to "data". A copy of "str" is made, so
+ * it does not need to persist after the this function is called.
+ *
+ * If an entry for "str" already exists, its data pointer is overwritten, and
+ * the original data pointer returned. Otherwise, returns NULL.
+ */
+void *strmap_put(struct strmap *map, const char *str, void *data)
+{
+	struct str_entry *entry = find_str_entry(map, str);
+	void *old = NULL;
+
+	if (entry) {
+		old = entry->item.util;
+		entry->item.util = data;
+	} else {
+		entry = xmalloc(sizeof(*entry));
+		hashmap_entry_init(&entry->ent, strhash(str));
+		entry->item.string = strdup(str);
+		entry->item.util = data;
+		hashmap_add(&map->map, &entry->ent);
+	}
+	return old;
+}
+
+void *strmap_get(struct strmap *map, const char *str)
+{
+	struct str_entry *entry = find_str_entry(map, str);
+	return entry ? entry->item.util : NULL;
+}
+
+int strmap_contains(struct strmap *map, const char *str)
+{
+	return find_str_entry(map, str) != NULL;
+}
diff --git a/strmap.h b/strmap.h
new file mode 100644
index 0000000000..eb5807f6fa
--- /dev/null
+++ b/strmap.h
@@ -0,0 +1,47 @@
+#ifndef STRMAP_H
+#define STRMAP_H
+
+#include "hashmap.h"
+#include "string-list.h"
+
+struct strmap {
+	struct hashmap map;
+};
+
+struct str_entry {
+	struct hashmap_entry ent;
+	struct string_list_item item;
+};
+
+/*
+ * Initialize an empty strmap
+ */
+void strmap_init(struct strmap *map);
+
+/*
+ * Remove all entries from the map, releasing any allocated resources.
+ */
+void strmap_clear(struct strmap *map, int free_values);
+
+/*
+ * Insert "str" into the map, pointing to "data". A copy of "str" is made, so
+ * it does not need to persist after the this function is called.
+ *
+ * If an entry for "str" already exists, its data pointer is overwritten, and
+ * the original data pointer returned. Otherwise, returns NULL.
+ */
+void *strmap_put(struct strmap *map, const char *str, void *data);
+
+/*
+ * Return the data pointer mapped by "str", or NULL if the entry does not
+ * exist.
+ */
+void *strmap_get(struct strmap *map, const char *str);
+
+/*
+ * Return non-zero iff "str" is present in the map. This differs from
+ * strmap_get() in that it can distinguish entries with a NULL data pointer.
+ */
+int strmap_contains(struct strmap *map, const char *str);
+
+#endif /* STRMAP_H */
-- 
gitgitgadget

