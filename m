Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49459C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E40FD2087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9zCYs3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgKKUCo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgKKUCb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:02:31 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250AEC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:31 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h62so3464298wme.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LohV9wz4XDfYNIAtf11Guo8xRjkzYRDWgPPI+0a6uSM=;
        b=C9zCYs3BpmEQ6Lq78RjYDWBcUQ3ILzbZxWnMbBX4EwHBhBffSJONMKrsXjhYlKkFFq
         Jk3x9Z3iQ+VUBmUoe87dkKtYhKSxxL5ukRGC7pSrattajdg5TaTOjI+Lw7k6eAFNFM95
         18j95xR6hM7hngxEP+8HRTgSTyGiqZcvGYluDMwaopRoH9/DrtUVzeulif6tFrZLzFJf
         JyGbMeGUFssUoEjjj1NP6NVk1HUUGT+pPyB33zvNWCQwjNctSfP7UrK9XdPhDhKpSblF
         CONWWyKWThu4tTHfrhkMHa4KSzsjE5lbYdazEgwROfYAuHtmTITpEdXWc7W9Iq1IMDjk
         qJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LohV9wz4XDfYNIAtf11Guo8xRjkzYRDWgPPI+0a6uSM=;
        b=kH4xxbFqMDztbrKI7/J4XYELtxWB0QLJTujVlJd5+Zh/DPy+FVrwxsKipyHUiAo10F
         tfY0M/LK2w+GTrBfTK8Z7MFOLu9aEbkMFFpNZ0W3DXcvgeHUmfW0jXEKpBrSXHu0PeWb
         fRfG36AjpW9nPXQRKgw1OGCaF1dMKx/taXXXWST+uGMaNUK1WogyNrGcbpHOOq0tVMV7
         JyAlJKT+ts/WfPHfoPPt2U8lro4yZ5XciB2414PYnQwcFL/qpM/9Vr1CgLg8hyS80UVR
         5ptyWfYRwme1pkBW1hbmznLaOJORM+xA62UFRPjRmmzbmAoT0P4/q7kalnZ1SNGsR/PJ
         RieA==
X-Gm-Message-State: AOAM533DlKZYkCTfqUdSDm6tyi04wjBuEgeENeKW++lCXk3VVW0P5IrH
        DaGcfIiYx5mJ+7j/rLZtDSPJeEXubtk=
X-Google-Smtp-Source: ABdhPJzSY9sGpcQVS4doozlYAkEHL3dRVaBSPOUecl03pKxdKKws5/1Qi/TFyFIxVwLWr0S5xLx7jA==
X-Received: by 2002:a1c:20c6:: with SMTP id g189mr6200783wmg.6.1605124949716;
        Wed, 11 Nov 2020 12:02:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t11sm3695357wmf.35.2020.11.11.12.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:02:29 -0800 (PST)
Message-Id: <5e8004c728580589cdaf46d755f2c977feaffb34.1605124942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
References: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
        <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 20:02:13 +0000
Subject: [PATCH v6 07/15] strmap: add more utility functions
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

