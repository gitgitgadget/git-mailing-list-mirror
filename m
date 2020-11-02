Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1772AC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B18CC22268
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJ/OtHZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgKBSze (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgKBSzX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 13:55:23 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC280C061A47
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 10:55:22 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id i16so10430444wrv.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 10:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wCvsDyKAwt2mhxtzknMOHiGx7z0ADi24Dwp/8iGpbIo=;
        b=sJ/OtHZcFIFTq4oPl92U5PGf1dZPFzEfdxnJst5IJ9KeH7C3Ku2nJg/kglLseOJA3r
         tVtDiP8D47MY09W0F9VLQsLTJRaPDvt/AbAc4ILoBJ0lEIbU1lAwndlWQKxnvqD1pHN6
         hO/tCv1PLpNsxjyAGoDnxUAOfgnsMXb5r4QZzYWSRI5xgDapu4pw02qPzCrBp4PFR3UK
         XI2MaftEwdPvxfH/eQTrXJDK1Q6tuALxtx1RpqGkxJU1pkm7ejMZPk8iNhpRKFEqb9Uu
         o67t6WAaSk1EiU0qC4cnOjEJ3VWIjOPuVghUAVgjNBxAafAXM26U1K4x086W7ZW19bca
         GFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wCvsDyKAwt2mhxtzknMOHiGx7z0ADi24Dwp/8iGpbIo=;
        b=HrQSrRfYZZY8gFRAGyg+6L7qKkRG3X/tbvmbDML+RrT0pbhU1W5y3nIQDNgFl0mR3e
         m2iEm1zsNcgfDYNtqhJkqaz/DzlV3NIYmliT0sogSjT1SY6XFIWxGhznHqewzf6EZUns
         V0JeZQC/9J5+rAFMgeRO+/HtTQMWTRJXth3qWuiM/MQNLGnIYT8i6udZzjD/dKHf9lX2
         OWc/TsKL5G5Ry4Zjly/Rw35mZYtGAi+UiLN5ADnZ9EsAuR8cCBB/XSjMt3b/jiLR0smE
         q7rjOqc/7Fli1+xZAnX/IzONWz/27lNfVv2iS9cDL02EZK+oMhXccWXvcmFRLVvNGee4
         heYA==
X-Gm-Message-State: AOAM531gfzP9hTC8uGskfBQyiJAN5+9TjkkS+04USFIUbU1QPnPM3XIh
        BoZDCJzhy58yTUvkxsNJE9zvHN2ExF4=
X-Google-Smtp-Source: ABdhPJy+i2P9pGJRABipou9/0Vf/yHyEDIjnP+W6JyvHrIlcQ/ZjMQMb5u4sZeomJvWA0+GuDzBHSA==
X-Received: by 2002:adf:cd01:: with SMTP id w1mr21914575wrm.298.1604343321449;
        Mon, 02 Nov 2020 10:55:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2sm23549565wrq.34.2020.11.02.10.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:55:20 -0800 (PST)
Message-Id: <42633b8d03008a159bc42bde319f50e87ddb00f6.1604343314.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
References: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
        <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Nov 2020 18:55:07 +0000
Subject: [PATCH v3 07/13] strmap: add more utility functions
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
 strmap.h | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

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
index 96888c23ad..ee4307cca5 100644
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
@@ -62,4 +68,34 @@ void *strmap_get(struct strmap *map, const char *str);
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
+	for (var = hashmap_iter_first_entry_offset(&(mystrmap)->map, iter, 0); \
+		var; \
+		var = hashmap_iter_next_entry_offset(iter, 0))
+
 #endif /* STRMAP_H */
-- 
gitgitgadget

