Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C8EC4742C
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F842083B
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksSmboy+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732889AbgKFAZL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 19:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732858AbgKFAZK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 19:25:10 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6539C0613D4
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 16:25:09 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p1so3736201wrf.12
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 16:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6fFXRL/2noA6OKsC3oWtGYm2yYHcHHD3f5FR5Ikh3Vs=;
        b=ksSmboy+VS9iLkeHrOzW8KM4qxMclP5AM8VOnoZv4ZJhhfG0vXtADvRdcL+aoLJxse
         PjDgvAQ4OAa+/m4aUmBpCZP9O5V0iPBTMGPonHf2l92ViB383vtw5bWbkWic4Y9bagpv
         BxctFyYGQ1MyACDN6l81ITIJPNI3pNkeCNzr7xLiPk4S7WLnq3HjpkbojRxLtwVYU1vv
         JloYskze203yfyXwTYg62PIp2OGMdn0R/MnZFWJxwrLs/hRJZEdx3qnFd97vtF8XfQVq
         BnJQWnDa2i17VxGOtLBg3BGi4TTZYf02Kiyq6BPvQ+7+N8j4jVKPH7qKlDqcAszp+mZp
         WzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6fFXRL/2noA6OKsC3oWtGYm2yYHcHHD3f5FR5Ikh3Vs=;
        b=Nm7wTvjbRuyIgiYNdDkRNwI/yTucOggMfH31tnm1z2DrXeheHKcibHVl0B69g0nZq7
         SLnV0uKMC5VgDP86AqC0XQIzJ065t6UG8UehfJtUg4oG5YbgXoNE16zjwvSnZTaP1HBf
         Tw9IVr9n34p3a+CkEJuzIc1wwhu26jBEcYKL9DDd9De+Kruks5C1MabeqkVpGQxoJeEB
         28qUbfC7wc2aYo2zdzBwVBjbwUupCFxaIYNf2/5EyFIBHcxzjNQuhFI2RlxQoEA4E9Ug
         Y21sMjgVmy9RxRPTZK2//mdiU6yXHQvObk7rN3o7UArUtbmWIQGIkMo1/A0dEuE8UrGK
         DT7Q==
X-Gm-Message-State: AOAM533vpuLM5LSNwm9571wmPsYzYbkUaOpnikSYdP5ZeX+9DIgJyTmA
        TTnxaiQJo9EQcdXTtnfOQN0c1g1Gl8U=
X-Google-Smtp-Source: ABdhPJxrJfuDb22o/Au3zQPZX91vC5l10EplrnSOFghYE+ZRBZY4UL1qDM1mnLwSDk5XYj6uaNNk2w==
X-Received: by 2002:adf:f245:: with SMTP id b5mr5732181wrp.389.1604622308560;
        Thu, 05 Nov 2020 16:25:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15sm5009243wrn.75.2020.11.05.16.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 16:25:08 -0800 (PST)
Message-Id: <3bcceb8cdb1dfd571ac5e0b45f20b3aef8bf553b.1604622299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
References: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
        <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Nov 2020 00:24:53 +0000
Subject: [PATCH v5 10/15] strmap: split create_entry() out of strmap_put()
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

This will facilitate adding entries to a strmap subtype in ways that
differ slightly from that of strmap_put().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strmap.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/strmap.c b/strmap.c
index 0d10a884b5..dc84c57c07 100644
--- a/strmap.c
+++ b/strmap.c
@@ -70,27 +70,36 @@ void strmap_partial_clear(struct strmap *map, int free_values)
 	hashmap_partial_clear(&map->map);
 }
 
+static struct strmap_entry *create_entry(struct strmap *map,
+					 const char *str,
+					 void *data)
+{
+	struct strmap_entry *entry;
+	const char *key = str;
+
+	entry = xmalloc(sizeof(*entry));
+	hashmap_entry_init(&entry->ent, strhash(str));
+
+	if (map->strdup_strings)
+		key = xstrdup(str);
+	entry->key = key;
+	entry->value = data;
+	return entry;
+}
+
 void *strmap_put(struct strmap *map, const char *str, void *data)
 {
 	struct strmap_entry *entry = find_strmap_entry(map, str);
-	void *old = NULL;
 
 	if (entry) {
-		old = entry->value;
+		void *old = entry->value;
 		entry->value = data;
-	} else {
-		const char *key = str;
-
-		entry = xmalloc(sizeof(*entry));
-		hashmap_entry_init(&entry->ent, strhash(str));
-
-		if (map->strdup_strings)
-			key = xstrdup(str);
-		entry->key = key;
-		entry->value = data;
-		hashmap_add(&map->map, &entry->ent);
+		return old;
 	}
-	return old;
+
+	entry = create_entry(map, str, data);
+	hashmap_add(&map->map, &entry->ent);
+	return NULL;
 }
 
 struct strmap_entry *strmap_get_entry(struct strmap *map, const char *str)
-- 
gitgitgadget

