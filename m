Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099EAC2D0A3
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 00:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48D420825
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 00:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gytGdqZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732775AbgKEAYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 19:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731211AbgKEAWy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 19:22:54 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10992C0613CF
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 16:22:54 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 23so29520wmg.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 16:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oEYc2S4ksSfmtDUY2461bdvZotWwPmh9voOUaSelCBs=;
        b=gytGdqZOdyj5WDZYcdMw6RTJk8MJZqd8WfnAcquaBhWK23Cgqm3bg0DpC2TLjpFBaj
         54slrfKFEY3J2IXof6hhpBirm7Cxm2Sgaony3VFiDffuYUc/9opg6biQzXBRLjR8mSuW
         AxNW/7olMivJ9DmZvFe+UkXNyzC0fCgYVXJmNIm0QnbNsQjXV7qJSAx7JazhW2Jf1d5J
         J7UBIVKDhWQG6qeVoCQcSw8ilvXO0d5E95cdVPFMRhgkzAewjb1vkdH+3aUUbDcMB42n
         qKr85xJKdZECu4spy0yChLjfVSa/ckpUzRviaF7Fgu3AX9YnbaRixhwGawNZLTwjfZ2h
         yAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oEYc2S4ksSfmtDUY2461bdvZotWwPmh9voOUaSelCBs=;
        b=Qe/yQqzR8v5nG+qfjZ6N6ff/eojkSbGAbkEUwscDAHifsg3mC5H+jTb8BWYqM9TIGT
         0woZ+oA71W+Odyd8BTktfRHobfEw5DLoZfKEZe2rmg7Oz0vdALFuuuv0KCQ8beUFiI/h
         8yUg6H77wbKayMz/edPEUl3AS5Z+4rsLsgG94oUbpW2XkMNWNqEAhqHG5mEGrpohDwuP
         AdGV2eUGQ3ryxHGmjkeX5HnXRye1mWFHKXPTXGzn4srCr1w7zYsEjd41Pb0cCcGnmERz
         FOhWGWZCWDTU1M/tCERb/Ibo09Ofe9tTmvqnhSTL/NmxTpTuuW9AydLue2T2fJnBHz2I
         s7VA==
X-Gm-Message-State: AOAM532pszX4/JvQiIIHsfT9nHN0IquJ6uc9AcYubCuYJaasU9qN96H/
        11RXguhaDw4yrhPq9kDUgXDpcD6K/b4=
X-Google-Smtp-Source: ABdhPJx03kCnfto/tASPs+bunYO+2OWvp96A11x7p6kNXJ963IYF5pOEcBE1Bz1KKCGrojqBD/SC0w==
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr103909wmk.4.1604535772548;
        Wed, 04 Nov 2020 16:22:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z14sm48982wmc.15.2020.11.04.16.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 16:22:51 -0800 (PST)
Message-Id: <448d3b219ffebbc0daa4ef033d78fd45693c5ccd.1604535766.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
References: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
        <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 05 Nov 2020 00:22:38 +0000
Subject: [PATCH v4 06/13] strmap: new utility functions
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

Add strmap as a new struct and associated utility functions,
specifically for hashmaps that map strings to some value.  The API is
taken directly from Peff's proposal at
https://lore.kernel.org/git/20180906191203.GA26184@sigill.intra.peff.net/

Note that similar string-list, I have a strdup_strings setting.
However, unlike string-list, strmap_init() does not take a parameter for
this setting and instead automatically sets it to 1; callers who want to
control this detail need to instead call strmap_init_with_options().
(Future patches will add additional parameters to
strmap_init_with_options()).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Makefile |  1 +
 strmap.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 strmap.h | 65 +++++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+)
 create mode 100644 strmap.c
 create mode 100644 strmap.h

diff --git a/Makefile b/Makefile
index 95571ee3fc..777a34c01c 100644
--- a/Makefile
+++ b/Makefile
@@ -1000,6 +1000,7 @@ LIB_OBJS += stable-qsort.o
 LIB_OBJS += strbuf.o
 LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
+LIB_OBJS += strmap.o
 LIB_OBJS += strvec.o
 LIB_OBJS += sub-process.o
 LIB_OBJS += submodule-config.o
diff --git a/strmap.c b/strmap.c
new file mode 100644
index 0000000000..53f284eb20
--- /dev/null
+++ b/strmap.c
@@ -0,0 +1,99 @@
+#include "git-compat-util.h"
+#include "strmap.h"
+
+int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
+		     const struct hashmap_entry *entry1,
+		     const struct hashmap_entry *entry2,
+		     const void *keydata)
+{
+	const struct strmap_entry *e1, *e2;
+
+	e1 = container_of(entry1, const struct strmap_entry, ent);
+	e2 = container_of(entry2, const struct strmap_entry, ent);
+	return strcmp(e1->key, e2->key);
+}
+
+static struct strmap_entry *find_strmap_entry(struct strmap *map,
+					      const char *str)
+{
+	struct strmap_entry entry;
+	hashmap_entry_init(&entry.ent, strhash(str));
+	entry.key = str;
+	return hashmap_get_entry(&map->map, &entry, ent, NULL);
+}
+
+void strmap_init(struct strmap *map)
+{
+	strmap_init_with_options(map, 1);
+}
+
+void strmap_init_with_options(struct strmap *map,
+			      int strdup_strings)
+{
+	hashmap_init(&map->map, cmp_strmap_entry, NULL, 0);
+	map->strdup_strings = strdup_strings;
+}
+
+static void strmap_free_entries_(struct strmap *map, int free_values)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+
+	if (!map)
+		return;
+
+	/*
+	 * We need to iterate over the hashmap entries and free
+	 * e->key and e->value ourselves; hashmap has no API to
+	 * take care of that for us.  Since we're already iterating over
+	 * the hashmap, though, might as well free e too and avoid the need
+	 * to make some call into the hashmap API to do that.
+	 */
+	hashmap_for_each_entry(&map->map, &iter, e, ent) {
+		if (free_values)
+			free(e->value);
+		if (map->strdup_strings)
+			free((char*)e->key);
+		free(e);
+	}
+}
+
+void strmap_clear(struct strmap *map, int free_values)
+{
+	strmap_free_entries_(map, free_values);
+	hashmap_clear(&map->map);
+}
+
+void *strmap_put(struct strmap *map, const char *str, void *data)
+{
+	struct strmap_entry *entry = find_strmap_entry(map, str);
+	void *old = NULL;
+
+	if (entry) {
+		old = entry->value;
+		entry->value = data;
+	} else {
+		const char *key = str;
+
+		entry = xmalloc(sizeof(*entry));
+		hashmap_entry_init(&entry->ent, strhash(str));
+
+		if (map->strdup_strings)
+			key = xstrdup(str);
+		entry->key = key;
+		entry->value = data;
+		hashmap_add(&map->map, &entry->ent);
+	}
+	return old;
+}
+
+void *strmap_get(struct strmap *map, const char *str)
+{
+	struct strmap_entry *entry = find_strmap_entry(map, str);
+	return entry ? entry->value : NULL;
+}
+
+int strmap_contains(struct strmap *map, const char *str)
+{
+	return find_strmap_entry(map, str) != NULL;
+}
diff --git a/strmap.h b/strmap.h
new file mode 100644
index 0000000000..96888c23ad
--- /dev/null
+++ b/strmap.h
@@ -0,0 +1,65 @@
+#ifndef STRMAP_H
+#define STRMAP_H
+
+#include "hashmap.h"
+
+struct strmap {
+	struct hashmap map;
+	unsigned int strdup_strings:1;
+};
+
+struct strmap_entry {
+	struct hashmap_entry ent;
+	const char *key;
+	void *value;
+};
+
+int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
+		     const struct hashmap_entry *entry1,
+		     const struct hashmap_entry *entry2,
+		     const void *keydata);
+
+#define STRMAP_INIT { \
+			.map = HASHMAP_INIT(cmp_strmap_entry, NULL),  \
+			.strdup_strings = 1,                          \
+		    }
+
+/*
+ * Initialize the members of the strmap.  Any keys added to the strmap will
+ * be strdup'ed with their memory managed by the strmap.
+ */
+void strmap_init(struct strmap *map);
+
+/*
+ * Same as strmap_init, but for those who want to control the memory management
+ * carefully instead of using the default of strdup_strings=1.
+ */
+void strmap_init_with_options(struct strmap *map,
+			      int strdup_strings);
+
+/*
+ * Remove all entries from the map, releasing any allocated resources.
+ */
+void strmap_clear(struct strmap *map, int free_values);
+
+/*
+ * Insert "str" into the map, pointing to "data".
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

