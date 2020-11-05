Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38B1C55178
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 00:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71C2920825
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 00:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV5vT8gn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbgKEAYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 19:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731335AbgKEAW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 19:22:56 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C901C0613D2
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 16:22:56 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id x12so55262wrm.8
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 16:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h5PnHyptBUWzu+AN7UGcuZ3DQJK/OQ/2tdMdIpZtNLg=;
        b=QV5vT8gnhRpEBnTPVgbx9ocihiYMbXGReyjxyvgptcvJ8MSMKxr3GAFQDv/jSTOIx3
         27RsyPdBNJFGxcUSWZJl0ts4CR1IDs9PHDKAZE6rUpner3Am3mBtDOwXOoLHhc/RN+sZ
         h2mf/e6Ny974tac8EC1ZJxf1bMd4R8bS71EbfyKBwyHUWTAZxWd/tjR2XJnFT/CLRYjF
         1p/Ef4fUh1lqwPB7q8O+9Q3O/vDwzLDi+vJlNi5J5jzYzlQ++MI0T4j7qc7Q1z7OryO1
         Uggn1NMqRDHunPXepIVgyvzmRXOZWbdpgbrDBGB700HifhmjVPnn276VXR8vclN5/J88
         pNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h5PnHyptBUWzu+AN7UGcuZ3DQJK/OQ/2tdMdIpZtNLg=;
        b=ed25iKswv+T+Y594ws/LTegbOIzT/1UMAyW0TLb6omEJRbyLM59Wp2JsvB8CIK5SPj
         27tsSUAohLDNcneLoAK9h9s00LYb55h9XptroxfRSnDlrbLzvjQSIKV7ponkQ47+nXxg
         8Thd83HEdEvPDnOEylLsEvqaModYfcVJJbLPcdopVECCn+BPUtgPh+RnAZiPG9JZh/gq
         tRjtCj7JohnlKG4TfprdYAAmROZi/VZsPW9+ttoektPYHArtxaDnJWxasj8PlwqDWfeK
         j/MxCXOfI77OXsNBIP+Kg97B0sC5R15iwZrf5h15xcweMv+T02XfsfqOmPooD8TfGUq7
         +pRw==
X-Gm-Message-State: AOAM533IJpTk1DFtnuB8WNvPxkdIaDeMmHP50oUOrYTfGMPHe6v7krFh
        qCcf+3wKohA/y7OUYjVzygvpMjTjiJQ=
X-Google-Smtp-Source: ABdhPJxaSevCcYYCyIh01cpdtfGOVFOwNYTEqWDrGw/FNx/40sdSYXe5W6g7+Wz6LDBwnyKDKQHg8Q==
X-Received: by 2002:adf:c847:: with SMTP id e7mr587422wrh.346.1604535775091;
        Wed, 04 Nov 2020 16:22:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h128sm23176wme.38.2020.11.04.16.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 16:22:54 -0800 (PST)
Message-Id: <f499934f54a2d1d9ac6ffeafcd6388d183d26fa3.1604535766.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
References: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
        <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 05 Nov 2020 00:22:41 +0000
Subject: [PATCH v4 09/13] strmap: add functions facilitating use as a
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

