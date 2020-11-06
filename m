Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5A5C4742C
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA1022083B
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chuWo6pJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732897AbgKFAZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 19:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732396AbgKFAZM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 19:25:12 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AF4C0613D2
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 16:25:12 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id w14so3743783wrs.9
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 16:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gDPxI4KbSCR3dgp72y0tDa6WsinTjNkrQA/6H8tPuC4=;
        b=chuWo6pJ75rHihub/fUxku3bcIUiOd4r598UqZfMM17/hY6l4d0Xw3Z2zlazjQWXRa
         CalVdEvA7WdzAbLd8zoD5GqXW3YB94NdlkjWqs8uxeJrZBGT4abEhElWDinV+ayPeGLM
         63pjxn6wIjA9cwdLMi0U4xe6RKRnjmZW+5bMi/hZvWhqvG09FUr76jcMJFyUyPHfHbcM
         Tt6zRW5gKH1OKBGz+0cXZMiueWjkYSXEtjOJt2CjuEcuHoTlaoIHkaHw2K1XjxzeUitP
         aiOMfqWaPloL7uL4SgeQGQndB/AQnk79iGtP+asvXbznb/7kGzLJZf6ZYA6nhJaXn2Is
         CQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gDPxI4KbSCR3dgp72y0tDa6WsinTjNkrQA/6H8tPuC4=;
        b=bJRIQSLwTa22fKgCJP8Jr8TueE//g1W2JkRVhdGajocQQkPu83UGnl2VdQsnlbpnqG
         vEDfeqDC3BLvR4jmv7l1xXKaAoXbkWD0FoVb99uXOT07OPQe4mW9FwvTdqu928uvxwCD
         uIc7y3nKIXdXi39BoQKDox/uI8ojD/lDecr5Uhc4BSpxUs/HnK2t+k8zQsyrIHHnFIf3
         fmvgg6lHOJdQ5Yy7mMxnQ6/6CsmoE0HyNibTmbuLCvmnclehvOBs1+NRi8Gk1xANHnHj
         14qK3KRkNVZZzfvY3oNVRRO/6QM6WeC1Gcnd3nFQbLEnMjPkMhbyDAxq+b8wC0PGlBjM
         SntQ==
X-Gm-Message-State: AOAM5338AP+aLQwz7GxtzSh6DNrU9O8s0J5yMp+FZUN7jTaFkP3onO4z
        Phocx9EChiXq4o/mH/oRK2aPSHL7MNQ=
X-Google-Smtp-Source: ABdhPJzA9E/N9cv4fnUQSTmb5brZWjSyFX1EqtfgApA1hk/ozCulR/9ke4WgLP9xBb+d7w2/NeetyQ==
X-Received: by 2002:adf:fd06:: with SMTP id e6mr5814330wrr.206.1604622311006;
        Thu, 05 Nov 2020 16:25:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8sm4363046wmc.11.2020.11.05.16.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 16:25:10 -0800 (PST)
Message-Id: <39ec2fa4118636f4c994735ab11c1d312eb9771d.1604622299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
References: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
        <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Nov 2020 00:24:56 +0000
Subject: [PATCH v5 13/15] strmap: take advantage of FLEXPTR_ALLOC_STR when
 relevant
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
index dda928703d..a99011df25 100644
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

