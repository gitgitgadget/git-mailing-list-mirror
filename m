Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0DEC433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AAAD20748
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqjzGzrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgHUSxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgHUSxG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 14:53:06 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CECC061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 11:53:05 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k8so2789613wma.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 11:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QT9k16JOKNndkpZDiEFnCKJW+UcvNcMp6F+vJeEQnSo=;
        b=QqjzGzrqhXcJ16cPqxL3DB9UQtMS4ATtWLq9UYfJ2BVJAwm5jV6ceTqHjF6WW4R2Nv
         O6CD+cV89mHRVWLjoJKcFsKbxwfDT+36MCgmXOgbE7IpFk4JL2J8AOx/hN+n0agASWy0
         IrJS3+eLUZFzMY2vhE/Hf27ucTPj4Oj9k9QBFyfBz7OVar/Nk5qJRYesu3pIMCyhYuB1
         wqrVzkhNvwsYCjCkGSdWGs2kS5GPiRMq0BHUJYN4qik1sfGVbXLyHFOMXwIM0LfdP6NT
         4J1f2WnKWYjjvv5tlErKHyI6XGoBlHJsK/eYU/+DzAmdC24UGYuwrfjmJS/V8uaCTM3v
         eyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QT9k16JOKNndkpZDiEFnCKJW+UcvNcMp6F+vJeEQnSo=;
        b=bCERP7jf5UYPfk/BUa2tRuQfLiUtOd0rSE9/KOijEv3smTyCqk+z/iBQs+Kss1ctVu
         6gCmeExvvxLMP0+ELaVFIPorcv+7lWkeCeSwg5wCvQdybp6Tl4k5i/ye+glwoS+eF3Cb
         CYQMH+WGh9dgxdbEtVt1V8uLW9U6fie9iRPWrgoOd1aO4UcxS9Bg5q1ib8Yf2H3EXS3i
         1ZEAZ3HnGYpuWhM/TwR8bIrhqpyPFkLvpWiaFKw5k8CNc7Va+gV8CfDTuFlE0uhabG1A
         RsmKYced6ZQ4Mvzd0tDK3iHVx+z6OGzePBX4I3E/PDFcwd/6auWz+ZwQGSv7HNaLQsdo
         5TJw==
X-Gm-Message-State: AOAM530qwDJZuiQt/Q9MvM8UjzvyeqlxL8Gkeww/tpblmEyoDWhYui4c
        wWei4AGO1TQzSqIlV0RCtRVksDCwRRU=
X-Google-Smtp-Source: ABdhPJzSFV4t8yg53uX6y+uW171JtVVJre/sXlxS+UjSmLKRiGLhxRebsKT6yrVj1AMnOCr/8xM2CQ==
X-Received: by 2002:a05:600c:2116:: with SMTP id u22mr5072590wml.35.1598035954295;
        Fri, 21 Aug 2020 11:52:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3sm6942672wme.34.2020.08.21.11.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:52:33 -0700 (PDT)
Message-Id: <b3095d97d8ee9d6576292731cc100492e7c64f13.1598035949.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 18:52:28 +0000
Subject: [PATCH 4/5] strmap: add strdup_strings option
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

Just as it is sometimes useful for string_list to duplicate and take
ownership of memory management of the strings it contains, the same is
sometimes true for strmaps as well.  Add the same flag from string_list
to strmap.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strmap.c | 23 ++++++++++++++++-------
 strmap.h |  9 +++++----
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/strmap.c b/strmap.c
index a4bfffcd8b..03eb6af45d 100644
--- a/strmap.c
+++ b/strmap.c
@@ -22,9 +22,10 @@ static struct str_entry *find_str_entry(struct strmap *map,
 	return hashmap_get_entry(&map->map, &entry, ent, NULL);
 }
 
-void strmap_init(struct strmap *map)
+void strmap_init(struct strmap *map, int strdup_strings)
 {
 	hashmap_init(&map->map, cmp_str_entry, NULL, 0);
+	map->strdup_strings = strdup_strings;
 }
 
 void strmap_free(struct strmap *map, int free_util)
@@ -35,9 +36,10 @@ void strmap_free(struct strmap *map, int free_util)
 	if (!map)
 		return;
 
-	if (free_util) {
+	if (map->strdup_strings || free_util) {
 		hashmap_for_each_entry(&map->map, &iter, e, ent) {
-			free(e->item.string);
+			if (map->strdup_strings)
+				free(e->item.string);
 			if (free_util)
 				free(e->item.util);
 		}
@@ -48,12 +50,11 @@ void strmap_free(struct strmap *map, int free_util)
 void strmap_clear(struct strmap *map, int free_util)
 {
 	strmap_free(map, free_util);
-	strmap_init(map);
+	strmap_init(map, map->strdup_strings);
 }
 
 /*
- * Insert "str" into the map, pointing to "data". A copy of "str" is made, so
- * it does not need to persist after the this function is called.
+ * Insert "str" into the map, pointing to "data".
  *
  * If an entry for "str" already exists, its data pointer is overwritten, and
  * the original data pointer returned. Otherwise, returns NULL.
@@ -69,7 +70,13 @@ void *strmap_put(struct strmap *map, const char *str, void *data)
 	} else {
 		entry = xmalloc(sizeof(*entry));
 		hashmap_entry_init(&entry->ent, strhash(str));
-		entry->item.string = strdup(str);
+		/*
+		 * We won't modify entry->item.string so it really should be
+		 * const, but changing string_list_item to use a const char *
+		 * is a bit too big of a change at this point.
+		 */
+		entry->item.string =
+			map->strdup_strings ? xstrdup(str) : (char *)str;
 		entry->item.util = data;
 		hashmap_add(&map->map, &entry->ent);
 	}
@@ -100,6 +107,8 @@ void strmap_remove(struct strmap *map, const char *str, int free_util)
 	hashmap_entry_init(&entry.ent, strhash(str));
 	entry.item.string = (char *)str;
 	ret = hashmap_remove_entry(&map->map, &entry, ent, NULL);
+	if (map->strdup_strings)
+		free(ret->item.string);
 	if (ret && free_util)
 		free(ret->item.util);
 	free(ret);
diff --git a/strmap.h b/strmap.h
index 45d0a4f714..28a98c5a4b 100644
--- a/strmap.h
+++ b/strmap.h
@@ -6,6 +6,7 @@
 
 struct strmap {
 	struct hashmap map;
+	unsigned int strdup_strings:1;
 };
 
 struct str_entry {
@@ -14,9 +15,10 @@ struct str_entry {
 };
 
 /*
- * Initialize an empty strmap
+ * Initialize the members of the strmap, set `strdup_strings`
+ * member according to the value of the second parameter.
  */
-void strmap_init(struct strmap *map);
+void strmap_init(struct strmap *map, int strdup_strings);
 
 /*
  * Remove all entries from the map, releasing any allocated resources.
@@ -29,8 +31,7 @@ void strmap_free(struct strmap *map, int free_values);
 void strmap_clear(struct strmap *map, int free_values);
 
 /*
- * Insert "str" into the map, pointing to "data". A copy of "str" is made, so
- * it does not need to persist after the this function is called.
+ * Insert "str" into the map, pointing to "data".
  *
  * If an entry for "str" already exists, its data pointer is overwritten, and
  * the original data pointer returned. Otherwise, returns NULL.
-- 
gitgitgadget

