Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ACFC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A52EC207F7
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwBfcCui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgKKUCn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgKKUCg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:02:36 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC980C0613D6
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:35 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j7so3753289wrp.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IO3ISdeushRI00Yi2X+meRNtIymPkMni8juDUTbuRMA=;
        b=PwBfcCuiLSCltiGcHy9u/9upmroKwyO0kF16EpHmKG5ZOyyWuWhFlgMiuW19/Oejfv
         QzkcnHeQX5XRf6ZtnVBk4zExaHaTs9gp0lc96CZE7bLjZGlAGNiil4amUIKg4/3jg5yn
         khuAuS/j2h9wQOVzRNVp6GzHuXf1ZR83hFn4r6zd4QEu3zJwg5vb3xDi6/UvuOuNrdaN
         Ut+570lMPwm7WARZBiYMWIIhEznShLyknpD4Dz/IyRnAt+yGGqzTzgFMClrYyUvYWwlO
         6eynB2iDob1q1E+ZiWc+7BvsE/K7WhufkVZv8j7l52DfKrttoBt7CZlTvPyAMjbpVWNu
         l9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IO3ISdeushRI00Yi2X+meRNtIymPkMni8juDUTbuRMA=;
        b=J50Tjg8SaOq/nTtb58RPEQ+PcbJditHigJJ9jbzOhriilsTGuBKP+5Rue8kfBRlXR0
         hRbLRQYa7iiXD5V6NOwBTL1C/CAZk+npfVE2h13dmm/k6RNwVo/b+wp0lwLcYIPgixi2
         eazHW9gRyjxK9OoKqrbnk1hWHV6+uPR/H5RUarWjc5AZ+SqkOh7vFwrZpYskYjlz515m
         9akM/gYe6iMQ45HUiiPpDBoVB11VPrU6SNbX+pIbrdyOF7JoWLB8uQB45JX5F6KwjN7v
         qQVB4y2ni8bO7WwDZGW/PURy3LPyUJTGDvAQ44T0smVO70uODSddovsrpxEsvwiJ+34p
         T27Q==
X-Gm-Message-State: AOAM533OodQLmH6sKT8bgvdHV6YhBCP8Hr28DbjZbOwU9LneoyONs0HW
        8d90unzc3kshZGaf0VBr+npBtICmwZw=
X-Google-Smtp-Source: ABdhPJz8B6VlAacqOnEVKvGk599yccLfwCk4HEdELYv0QgTW0e+1ICpPM/9GYBoR+0BBHN3AGQeaBQ==
X-Received: by 2002:adf:dc0f:: with SMTP id t15mr4474056wri.29.1605124954419;
        Wed, 11 Nov 2020 12:02:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m20sm4349712wrg.81.2020.11.11.12.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:02:34 -0800 (PST)
Message-Id: <562595224b56ff8b3dc3b97baa713e47d18e2126.1605124942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
References: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
        <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 20:02:19 +0000
Subject: [PATCH v6 13/15] strmap: take advantage of FLEXPTR_ALLOC_STR when
 relevant
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

By default, we do not use a mempool and strdup_strings is true; in this
case, we can avoid both an extra allocation and an extra free by just
over-allocating for the strmap_entry leaving enough space at the end to
copy the key.  FLEXPTR_ALLOC_STR exists for exactly this purpose, so
make use of it.

Also, adjust the case when we are using a memory pool and strdup_strings
is true to just do one allocation from the memory pool instead of two so
that the strmap_clear() and strmap_remove() code can just avoid freeing
the key in all cases.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strmap.c | 35 +++++++++++++++++++----------------
 strmap.h |  1 +
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/strmap.c b/strmap.c
index 139afb9d4b..4fb9f6100e 100644
--- a/strmap.c
+++ b/strmap.c
@@ -59,11 +59,8 @@ static void strmap_free_entries_(struct strmap *map, int free_values)
 	hashmap_for_each_entry(&map->map, &iter, e, ent) {
 		if (free_values)
 			free(e->value);
-		if (!map->pool) {
-			if (map->strdup_strings)
-				free((char*)e->key);
+		if (!map->pool)
 			free(e);
-		}
 	}
 }
 
@@ -84,16 +81,25 @@ static struct strmap_entry *create_entry(struct strmap *map,
 					 void *data)
 {
 	struct strmap_entry *entry;
-	const char *key = str;
 
-	entry = map->pool ? mem_pool_alloc(map->pool, sizeof(*entry))
-			  : xmalloc(sizeof(*entry));
+	if (map->strdup_strings) {
+		if (!map->pool) {
+			FLEXPTR_ALLOC_STR(entry, key, str);
+		} else {
+			size_t len = st_add(strlen(str), 1); /* include NUL */
+			entry = mem_pool_alloc(map->pool,
+					       st_add(sizeof(*entry), len));
+			memcpy(entry + 1, str, len);
+			entry->key = (void *)(entry + 1);
+		}
+	} else if (!map->pool) {
+		entry = xmalloc(sizeof(*entry));
+	} else {
+		entry = mem_pool_alloc(map->pool, sizeof(*entry));
+	}
 	hashmap_entry_init(&entry->ent, strhash(str));
-
-	if (map->strdup_strings)
-		key = map->pool ? mem_pool_strdup(map->pool, str)
-				: xstrdup(str);
-	entry->key = key;
+	if (!map->strdup_strings)
+		entry->key = str;
 	entry->value = data;
 	return entry;
 }
@@ -139,11 +145,8 @@ void strmap_remove(struct strmap *map, const char *str, int free_value)
 		return;
 	if (free_value)
 		free(ret->value);
-	if (!map->pool) {
-		if (map->strdup_strings)
-			free((char*)ret->key);
+	if (!map->pool)
 		free(ret);
-	}
 }
 
 void strintmap_incr(struct strintmap *map, const char *str, intptr_t amt)
diff --git a/strmap.h b/strmap.h
index 8745b7ceb1..c4c104411b 100644
--- a/strmap.h
+++ b/strmap.h
@@ -14,6 +14,7 @@ struct strmap_entry {
 	struct hashmap_entry ent;
 	const char *key;
 	void *value;
+	/* strmap_entry may be allocated extra space to store the key at end */
 };
 
 int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
-- 
gitgitgadget

