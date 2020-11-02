Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62B2C56202
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F7B2225E
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M72sFb/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgKBSzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgKBSzW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 13:55:22 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29183C061A04
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 10:55:22 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id x7so15867288wrl.3
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 10:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oEYc2S4ksSfmtDUY2461bdvZotWwPmh9voOUaSelCBs=;
        b=M72sFb/77Y6ZmuFVCCyRmF7XLt+hfA433cxJejnib0s7C+QarbDRlh0L0ldWXElXC4
         KJF0H00+Zwv0H5zvjeJdB4/PpspyUioOs9aNXKvqXok8uK3U7OwZ+XzJBq/D2nrQuNqN
         T/YywIpOf55548XxLSrEhIE2an8w4IOxpAWKLHhyEGIkEarw2fBJWWW7aMm4yZFh0jhb
         9rXlzi82LPKMVcuAA3kO9YRVwvF3kdLoyltV3JNmHnaKp7BOUrlKqbEmtYfTcM7NbQlu
         phONxcUyxFetEB4UetBFuPvgO8BNYdRnd5wIkdCiALCVRy1sgy4R1aFMs8lrL6bp5Jkn
         gf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oEYc2S4ksSfmtDUY2461bdvZotWwPmh9voOUaSelCBs=;
        b=A+DCRQogq7xvYLoYHTIxAT3iYaKj9WlKaUxRYUfMewRoA9LS7pC3yeL03EdWah5XOt
         krgWIZupHlWmLijpxvqsrHQotNVSH1nXkkLcmQa4Z4j+qd9xgNp/zGETPflkopDKdGYN
         Q59U1ADvRT0uqqKcDcXwVI2/L7wU4zngPWxSy8MExyWdDnKfRyRZaDeVceWHdk2UROng
         oNT+HZ2ATQz19L1/+2dvYUeEMPk8Sm2Oj+NF2GivFBarew9uR8wrmAD+IgheH0JGRsJm
         qerAg0T4lnrIzo9QNYaQ0glD8x/PwFoARxbJ+GStcVR+e4W+OJvzp50u6+7ECmFtf102
         IQzQ==
X-Gm-Message-State: AOAM532cZG9ZLK/sEyvakXwYAopId3ds86R4njdjcTe2Z2Eq2SAh2zJu
        EZiM14BsQF6Cd1IsgP5Gd+g1Ruy/6XM=
X-Google-Smtp-Source: ABdhPJxO1b2vd44mPbc0KsbUBWoruDbCjPFGwr7PP4Z01k3ns+IYFzyD76bDTSsf0Fi9/9QvByxmCQ==
X-Received: by 2002:a05:6000:1050:: with SMTP id c16mr21950966wrx.400.1604343320655;
        Mon, 02 Nov 2020 10:55:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8sm377160wmc.11.2020.11.02.10.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:55:20 -0800 (PST)
Message-Id: <448d3b219ffebbc0daa4ef033d78fd45693c5ccd.1604343314.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
References: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
        <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Nov 2020 18:55:06 +0000
Subject: [PATCH v3 06/13] strmap: new utility functions
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

