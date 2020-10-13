Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC369C64E7D
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0828221FC
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWcld43Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgJMAlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 20:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgJMAk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 20:40:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C022C0613D5
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 17:40:58 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x7so13096746wrl.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 17:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FSkI+YRnzw8N9JfxGoq51vnU7tj3nFNTaQeR4NXfo1M=;
        b=MWcld43Ym3IvV5RAEO7AQRK4kI/lao6+A+R7ozq+9ED7wC4TqyHRjSefkQh4VFcXbl
         AUB/1Ph06rjv+yjMUUTOj6lk8WfFR/Hm2WN6jplwf/robww/2g7o93iR6rIKkLIHoyKK
         AFgeMSZuqoiyV2M3Tj25yvsaAk1caDUTsOJ3Gk6Yh+jlRsSwuvORNbR06IzutYloDQif
         7vUL7XQKJiI7YRiyXmFAVHKjOvnBCZ/RIOr7LEbjwgXHlftccQJ+OmKwjO2G3XHrTPwp
         UNUtTTGsHHEQ4WElBnO6KjGoOO/U6e1j6aOgr/0RH63qriyL7t3V6qSHydk2hlZD/Omk
         5j4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FSkI+YRnzw8N9JfxGoq51vnU7tj3nFNTaQeR4NXfo1M=;
        b=egdmwaNsoL/NOG20v9ZWwgMzbFBqOQw3uEMS7Vc6CkRCH/sXJgGnolFIkf6Zl8rHrO
         BuZNLw07ooXHJEd5nukk8nP9tm9DGNx8utlDu5u3CQt/OH5akUy+FGsS0nYTIoXZj7pc
         gM86IQbs7wIInvyAHbPorU5Q4mDMhvsskZ/uGeVPwu+zqu4lJ5C6z2Qu20Xiw4oaqt0G
         vPbXVceMIHdUSmX/OFpFbtXBwzezV6OOWZorGPSLv7dQVtl+hTDFg21kbYSehVCceRg9
         XqBoLaSNj3+oplDCaQ7fgtYluRK8Mw3YVEB+xmpnedQjurwN8EOyDYoWaPEx3gGnGN3E
         29aQ==
X-Gm-Message-State: AOAM533ALjaXvec8efkO9vM4uFdQqXHSrop2IZmPvQsXVzGe58jDueFH
        JzTzCNDGVno6m5NvCrtddxqNXawR1Rk=
X-Google-Smtp-Source: ABdhPJwU8U0pXopovZhVcLHHec1KoYB6ywpbiQeYJbJbRqdo8XXEqdEUEp8B4W6gXZ4q6YVFMaJxVg==
X-Received: by 2002:a5d:6681:: with SMTP id l1mr31197379wru.356.1602549656955;
        Mon, 12 Oct 2020 17:40:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e7sm27757100wrm.6.2020.10.12.17.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 17:40:56 -0700 (PDT)
Message-Id: <5c7507f55b09e24c0bfe87cc3df06213cfd1235b.1602549650.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
        <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Oct 2020 00:40:45 +0000
Subject: [PATCH v2 05/10] strmap: new utility functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Add strmap as a new struct and associated utility functions,
specifically for hashmaps that map strings to some value.  The API is
taken directly from Peff's proposal at
https://lore.kernel.org/git/20180906191203.GA26184@sigill.intra.peff.net/

A couple of items of note:

  * Similar to string-list, I have a strdup_strings setting.  However,
    unlike string-list, strmap_init() does not take a parameter for this
    setting and instead automatically sets it to 1; callers who want to
    control this detail need to instead call strmap_ocd_init().

  * I do not have a STRMAP_INIT macro.  I could possibly add one, but
      #define STRMAP_INIT { { NULL, cmp_str_entry, NULL, 0, 0, 0, 0, 0 }, 1 }
    feels a bit unwieldy and possibly error-prone in terms of future
    expansion of the hashmap struct.  The fact that cmp_str_entry needs to
    be in there prevents us from passing all zeros for the hashmap, and makes
    me worry that STRMAP_INIT would just be more trouble than it is worth.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Makefile |   1 +
 strmap.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 strmap.h |  57 +++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+)
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
index 0000000000..4b48d64274
--- /dev/null
+++ b/strmap.c
@@ -0,0 +1,102 @@
+#include "git-compat-util.h"
+#include "strmap.h"
+
+static int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
+			    const struct hashmap_entry *entry1,
+			    const struct hashmap_entry *entry2,
+			    const void *keydata)
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
+	strmap_ocd_init(map, 1);
+}
+
+void strmap_ocd_init(struct strmap *map,
+		     int strdup_strings)
+{
+	hashmap_init(&map->map, cmp_strmap_entry, NULL, 0);
+	map->strdup_strings = strdup_strings;
+}
+
+static void strmap_free_entries_(struct strmap *map, int free_util)
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
+		if (free_util)
+			free(e->value);
+		if (map->strdup_strings)
+			free((char*)e->key);
+		free(e);
+	}
+}
+
+void strmap_clear(struct strmap *map, int free_util)
+{
+	strmap_free_entries_(map, free_util);
+	hashmap_free(&map->map);
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
+		/*
+		 * We won't modify entry->key so it really should be const.
+		 */
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
index 0000000000..493d19cbc0
--- /dev/null
+++ b/strmap.h
@@ -0,0 +1,57 @@
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
+/*
+ * Initialize the members of the strmap.  Any keys added to the strmap will
+ * be strdup'ed with their memory managed by the strmap.
+ */
+void strmap_init(struct strmap *map);
+
+/*
+ * Same as strmap_init, but for those who want to control the memory management
+ * carefully instead of using the default of strdup_strings=1.
+ * (OCD = Obsessive Compulsive Disorder, a joke that those who use this function
+ * are obsessing over minor details.)
+ */
+void strmap_ocd_init(struct strmap *map,
+		     int strdup_strings);
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

