Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4191C4741F
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 00:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5827520825
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 00:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rd4IDFvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbgKEAYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 19:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731324AbgKEAW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 19:22:56 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3AAC0613CF
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 16:22:54 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id n15so403244wrq.2
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 16:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LohV9wz4XDfYNIAtf11Guo8xRjkzYRDWgPPI+0a6uSM=;
        b=rd4IDFvH9Nah1LkaOAhsanb0d/eeTLGqbLhh3PNsBXOzdSgLR1zPh02OUuX5YCSy4e
         C8GAQ/VGBD8oS02E2IOL4bb1HeJlGw9rfwyFoqqkO9HUJf7Z9fUNvF24G2bgtfMbvctR
         /hakk+b+CGn2P3Q8PRjEbquj5qgkdkX1NhWMqnlza0OeEgg5glCB08kSn83DsuuD2uvN
         6oCKiWJ2lPahLF7JxL+PfqAO6yCDbcLEq7pTMf7suO+FoRPADX11/WKgoEs9POFNXmn/
         zRW0KQ4CqyTsXPcH/nyAEwoE0sVt9c/80Ah8yahNzIYJfVpC0O0hHXVH7hMdzPxf7A8j
         7nEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LohV9wz4XDfYNIAtf11Guo8xRjkzYRDWgPPI+0a6uSM=;
        b=WyWahaKBblyxGec3HHB1qQWglhd07XTPlXAOvyyJeI2w7SRL7MHypHgc7o+I4Ba4gT
         6BTKD8hFm9Z+GJ/0b4eNjX6wHUX7OHGGs7tK1zaAxufZ0l4camOnS2We1JyyXXud5OPV
         GIq1gIFc5UsZZET6CvzwezHJPmUORzxE8Kw0bw3bcrPa1BcmAa5/DRMdgdGiApyHeWh1
         F6Wyq5RpmuTZ8Y5Qd7nSNsmR/x8rdybsFaCL8kagJKUgSSfxGk/5PmDe/BpRYC11Hb5C
         0AtUfo9lcG18NJixLSL9kJcAKRiQ04EPD5ygaQyNtMOMptMNJnXtqt5Ag/4oM00QKFQk
         K0Yw==
X-Gm-Message-State: AOAM531JZFCsrL43R5WvqcYKrvBoc/Nf9vCk4M4q3HtnM7DHpyCXH4b+
        y/GWdxKaQbbgPYPud6Fc36xpw5/Ueq4=
X-Google-Smtp-Source: ABdhPJzIMuAmoCA+sNqk0XsNO3Lj8oh+q8BwHEmp62I4pTIULcDyM8jVR5d+ro+bTYg5QL+irWUBcw==
X-Received: by 2002:adf:ce12:: with SMTP id p18mr608540wrn.52.1604535773415;
        Wed, 04 Nov 2020 16:22:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm5343117wrb.53.2020.11.04.16.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 16:22:52 -0800 (PST)
Message-Id: <5e8004c728580589cdaf46d755f2c977feaffb34.1604535766.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
References: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
        <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 05 Nov 2020 00:22:39 +0000
Subject: [PATCH v4 07/13] strmap: add more utility functions
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

