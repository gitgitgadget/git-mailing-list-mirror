Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AE4C8300B
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B632F221FF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hs8hJlmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgJMAlG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 20:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbgJMAlB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 20:41:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0354C0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 17:41:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x7so13096889wrl.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 17:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fSoV1INTQ09lAoLPXCoEd4scIa7g6B+DTa5en96mUT8=;
        b=hs8hJlmLPTAhlp4YvWcmZrjKpI25Ts50lpuM1UDwC6kVw9y8dZNHyl6wEbA7auahDe
         2T6L8MccgDqSGvg1w/K24Jic0U17FnXp+jLAaJ2Sdw8EBoWp9UQej26gNgzAUaHhgyjm
         c5bY0RpqnhB3FXkP0Cbc+/tA68LG/wBzNY5O0QOH4VyrfhZIkL2QKdgRwZYjlXn1kB1S
         mzm99eXTIWIDIVHdMj8kUo3DJ4pawTaAWnbWrGk0cROdMfyPGJTB1Sk3+sr4EJKZViyr
         gDgIBPYSzDAAa9qi1PP/pT66A7lvI8Ca0Zo8ScgbIGAAQzUy68oCz8WLN1pI6qs//qS2
         f35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fSoV1INTQ09lAoLPXCoEd4scIa7g6B+DTa5en96mUT8=;
        b=W2Wo3sC6zUhYCaNN5dxCZc4opcuV1zUs9o0KUoJrJ3CPylkL7lcKsEk/SyjGME715I
         b6Sm1jKGAC2PoJGTm4Z7yyUoJrQR7O4MimPI+6STZlmaaOzF53HJtaGEhTp6upQf5/o9
         bBkuLRgwEQcWdw7a2w5ptutYfifkUI6pBMPYQKJGCAFT4MMdZ1DAntdQeQ2XCWUb0bHh
         QH3Ize+15VGPB/LcoTPTzqgPjsUr5d73/AFisQ+Q5OhHHsPimJcZWctRQ2GKMl3HG7HA
         YOhjrySuurdrFEou+YLzRnNjZqopPqxy/E/Q1iTRh3sIF/wVOjhJSFM5vc1M7QlP6HvW
         /clw==
X-Gm-Message-State: AOAM531NL5cmxTqpCn2I7azgMJ2eScB4wvEP581nopPv/dfYOy9GBmVR
        S0tvBLz9EgB3Y4xRnIubto01fV5XesQ=
X-Google-Smtp-Source: ABdhPJxfvy5+yTGCBfPRqvi+HFu5hRSRUXHUWmHLWOduMQzqD4ooZrsPqQKGwevMWBIbgVgUc7d0PQ==
X-Received: by 2002:adf:fcc3:: with SMTP id f3mr3112151wrs.336.1602549659326;
        Mon, 12 Oct 2020 17:40:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i10sm8501715wrq.27.2020.10.12.17.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 17:40:58 -0700 (PDT)
Message-Id: <cc8d702f98f94fd9202d227d19be43a912467e84.1602549650.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
        <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Oct 2020 00:40:48 +0000
Subject: [PATCH v2 08/10] strmap: add functions facilitating use as a
 string->int map
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

Although strmap could be used as a string->int map, one either had to
allocate an int for every entry and then deallocate later, or one had to
do a bunch of casting between (void*) and (intptr_t).

Add some special functions that do the casting.  Also, rename put->set
for such wrapper functions since 'put' implied there may be some
deallocation needed if the string was already found in the map, which
isn't the case when we're storing an int value directly in the void*
slot instead of using the void* slot as a pointer to data.

A note on the name: if anyone has a better name suggestion than
strintmap, I'm happy to take it.  It seems slightly unwieldy, but I have
not been able to come up with a better name.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strmap.c | 11 ++++++++
 strmap.h | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/strmap.c b/strmap.c
index 47cbf11ec7..d5003a79e3 100644
--- a/strmap.c
+++ b/strmap.c
@@ -126,3 +126,14 @@ void strmap_remove(struct strmap *map, const char *str, int free_util)
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
+		strintmap_set(map, str, amt);
+}
diff --git a/strmap.h b/strmap.h
index 5bb7650d65..fe15e74b78 100644
--- a/strmap.h
+++ b/strmap.h
@@ -98,4 +98,84 @@ static inline unsigned int strmap_get_size(struct strmap *map)
 		var = hashmap_iter_next_entry_offset(iter, \
 						     OFFSETOF_VAR(var, ent)))
 
+
+/*
+ * strintmap:
+ *    A map of string -> int, typecasting the void* of strmap to an int.
+ *
+ * Primary differences:
+ *    1) Since the void* value is just an int in disguise, there is no value
+ *       to free.  (Thus one fewer argument to strintmap_clear)
+ *    2) strintmap_get() returns an int; it also requires an extra parameter to
+ *       be specified so it knows what value to return if the underlying strmap
+ *       has not key matching the given string.
+ *    3) No strmap_put() equivalent; strintmap_set() and strintmap_incr()
+ *       instead.
+ */
+
+struct strintmap {
+	struct strmap map;
+};
+
+#define strintmap_for_each_entry(mystrmap, iter, var)	\
+	strmap_for_each_entry(&(mystrmap)->map, iter, var)
+
+static inline void strintmap_init(struct strintmap *map)
+{
+	strmap_init(&map->map);
+}
+
+static inline void strintmap_ocd_init(struct strintmap *map,
+				      int strdup_strings)
+{
+	strmap_ocd_init(&map->map, strdup_strings);
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
+static inline int strintmap_get(struct strintmap *map, const char *str,
+				int default_value)
+{
+	struct strmap_entry *result = strmap_get_entry(&map->map, str);
+	if (!result)
+		return default_value;
+	return (intptr_t)result->value;
+}
+
+static inline void strintmap_set(struct strintmap *map, const char *str,
+				 intptr_t v)
+{
+	strmap_put(&map->map, str, (void *)v);
+}
+
+void strintmap_incr(struct strintmap *map, const char *str, intptr_t amt);
+
 #endif /* STRMAP_H */
-- 
gitgitgadget

