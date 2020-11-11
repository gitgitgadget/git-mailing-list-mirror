Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78784C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26DA92087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwoQR5wT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgKKUCg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbgKKUCd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:02:33 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73218C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:33 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id a65so3478990wme.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6fFXRL/2noA6OKsC3oWtGYm2yYHcHHD3f5FR5Ikh3Vs=;
        b=KwoQR5wTTE8D952HSVq5XmdxJ8BuJtUwb6dH8u/j2WuE2sEg8ofBWzPrWK3Y+VJyLd
         zOGUwKvdtAVhaX8BytzPgXAj4wk0dk4nxfINZfFAbi4lTCDm1D5sXXyVuZTLJZd84xD6
         ridgycdddlNUqO21jQE+p8cq3dD4ldmtvjKgGirqsRzgpMor41yDFShMVcgvFVYRdrGa
         9oDqNALJNjYAGIf7JM36IQSHJ9q2RgK0TM6CzbmCe36V+uakxQ4rHtzJN6h5esBuGVXq
         AUWDex6VAaOLq7ol00wAgvkTcyzhQ1aq/COZd4dFqjuka4suLoqTgXwJ8kloiD+dIP46
         bqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6fFXRL/2noA6OKsC3oWtGYm2yYHcHHD3f5FR5Ikh3Vs=;
        b=PWDgejGl/rWg1fkghlU8yutb7ISojxElFCTbQAR8BiewULKYqe3uTyF9tUhxmX/uQD
         BAzfl09vGMb+9BUrvxk3uyLKVxPkp8lwHFgKY0DRHN+IC7nlsuDcRSRKbeA4COw4Bhz5
         A91C8N3376XsLWFfK/6ZEr+UzrYK0p7nCWJTjc3lMcChmDmIzCMU1aG7V6sy4S73+J9p
         cxbi75PIVUj0mxrqSNIx712HuFW8qQeVZUDQma53kcGivqq7Df5SYbkxGnU7uU4V463B
         M0cLs4djqZYQ6ObMs6+7X8AfT92hVreNfoHHk+LHQBoXyy+PlzyA4AEvuI/xu+jnuWvj
         OZDQ==
X-Gm-Message-State: AOAM532dE4kZDaR7r33g0sERVVFU7IqT+9hclIFdUY/jvNXFub0Pl5T3
        YdrIfeFFteaMK8rfdizBenHRlqe+0LI=
X-Google-Smtp-Source: ABdhPJyzbnQd3t+779xzcJ2ic7pmiYET1f4fRmWqwC1dJl4QKbjDxO8giOVaTu+kPZIdi0F6wSKC5Q==
X-Received: by 2002:a1c:4346:: with SMTP id q67mr6018820wma.170.1605124952041;
        Wed, 11 Nov 2020 12:02:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21sm9965686wmi.3.2020.11.11.12.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:02:31 -0800 (PST)
Message-Id: <3bcceb8cdb1dfd571ac5e0b45f20b3aef8bf553b.1605124942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
References: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
        <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 20:02:16 +0000
Subject: [PATCH v6 10/15] strmap: split create_entry() out of strmap_put()
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

