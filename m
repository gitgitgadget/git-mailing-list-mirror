Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1892C56201
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C9CD2087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYEpKMRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgKKUCm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbgKKUCh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:02:37 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79033C0613D4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:37 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 33so3730248wrl.7
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/m8cQExWBEWxoRtNoB5eAbuRwvA8C0BdwF9qLyUY+84=;
        b=tYEpKMRwB6wxX1ouX14vuvy5Fv92lx/0aurwHid8iy0xybFEQrDEcP+4FWswzuX16F
         3j2dXVzD6Q1a3Jh31Zx5b0R66j6gp8UpMOyAGAhs9ihKJfjSu/qpROGVrXUGA09rE7Lp
         CK6qh4g+Y7/hA0woZ5nbH1tO+qU8410QDwIRlIdwL9VFKlzC7S3c3Ec8W0RiwEYMetEz
         7ky9weX4Je09PgiZCH1Kz4HiE7P36UmvR7j5270oKLvQd3ztk+32okln8JODte3hUS0k
         JHayMc/rNNyeYU/TsK6e0z1k4tjnr7LtgJW4TW4raCdTznJ5uceMLUcbpVlLyc6/S4iV
         hKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/m8cQExWBEWxoRtNoB5eAbuRwvA8C0BdwF9qLyUY+84=;
        b=JM9D3CHNb5lDvEpH4110iyY/eaSEZfWBgEs5Aij53pu+d4Z178mACpftBsPKVp/+58
         wfAopAy0uq9SGDjhRONCzO6sUkSAcZMELOR2gUFiF1SIPBjh6vUmYFi1vlfqswk1D7m1
         auAxLx2vtmqoZJFrky9lQZD7bRQ4wfLtxl6zyp/a8+7Qab9qX4Q3KPWSWH9ek3d8jZu5
         Scl7NB5pY8+kgyMnEzSKJF7FwsGohpmfgtxobbEvi+qd/685lM6XPQwFQbw2AAMOLu6x
         LHqKEdkXvEyofDyqfrwgJK0wGg040RWuUS0NnJiILAt2c/zsl+RbV8phBXurvN+QWpSJ
         m9Fg==
X-Gm-Message-State: AOAM5328zy26LAhe8QWpUhYYJzgU3pGQ0TWCgXJ4E4TOGEVHB3epHUm+
        zB83Yqu1p4zWSql49eJsXlLQCCUZfbM=
X-Google-Smtp-Source: ABdhPJx7Xz7l1fAFLNe/hwE5ZxCO/pkNEs7Cmx6joZ8lboiQc+KbL9pO4meaZJSXCqM6oEIHYMMOtA==
X-Received: by 2002:adf:c58f:: with SMTP id m15mr32757466wrg.144.1605124956134;
        Wed, 11 Nov 2020 12:02:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t13sm3827880wru.67.2020.11.11.12.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:02:35 -0800 (PST)
Message-Id: <9b494c26c18e5a5b4f2561e30546d3bf3e82ef11.1605124942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
References: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
        <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 20:02:21 +0000
Subject: [PATCH v6 15/15] shortlog: use strset from strmap.h
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/shortlog.c | 61 +++-------------------------------------------
 1 file changed, 4 insertions(+), 57 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 83f0a739b4..c52e4ccd19 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -10,6 +10,7 @@
 #include "shortlog.h"
 #include "parse-options.h"
 #include "trailer.h"
+#include "strmap.h"
 
 static char const * const shortlog_usage[] = {
 	N_("git shortlog [<options>] [<revision-range>] [[--] <path>...]"),
@@ -169,60 +170,6 @@ static void read_from_stdin(struct shortlog *log)
 	strbuf_release(&oneline);
 }
 
-struct strset_item {
-	struct hashmap_entry ent;
-	char value[FLEX_ARRAY];
-};
-
-struct strset {
-	struct hashmap map;
-};
-
-#define STRSET_INIT { { NULL } }
-
-static int strset_item_hashcmp(const void *hash_data,
-			       const struct hashmap_entry *entry,
-			       const struct hashmap_entry *entry_or_key,
-			       const void *keydata)
-{
-	const struct strset_item *a, *b;
-
-	a = container_of(entry, const struct strset_item, ent);
-	if (keydata)
-		return strcmp(a->value, keydata);
-
-	b = container_of(entry_or_key, const struct strset_item, ent);
-	return strcmp(a->value, b->value);
-}
-
-/*
- * Adds "str" to the set if it was not already present; returns true if it was
- * already there.
- */
-static int strset_check_and_add(struct strset *ss, const char *str)
-{
-	unsigned int hash = strhash(str);
-	struct strset_item *item;
-
-	if (!ss->map.table)
-		hashmap_init(&ss->map, strset_item_hashcmp, NULL, 0);
-
-	if (hashmap_get_from_hash(&ss->map, hash, str))
-		return 1;
-
-	FLEX_ALLOC_STR(item, value, str);
-	hashmap_entry_init(&item->ent, hash);
-	hashmap_add(&ss->map, &item->ent);
-	return 0;
-}
-
-static void strset_clear(struct strset *ss)
-{
-	if (!ss->map.table)
-		return;
-	hashmap_clear_and_free(&ss->map, struct strset_item, ent);
-}
-
 static void insert_records_from_trailers(struct shortlog *log,
 					 struct strset *dups,
 					 struct commit *commit,
@@ -253,7 +200,7 @@ static void insert_records_from_trailers(struct shortlog *log,
 		if (!parse_ident(log, &ident, value))
 			value = ident.buf;
 
-		if (strset_check_and_add(dups, value))
+		if (!strset_add(dups, value))
 			continue;
 		insert_one_record(log, value, oneline);
 	}
@@ -291,7 +238,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 				      log->email ? "%aN <%aE>" : "%aN",
 				      &ident, &ctx);
 		if (!HAS_MULTI_BITS(log->groups) ||
-		    !strset_check_and_add(&dups, ident.buf))
+		    strset_add(&dups, ident.buf))
 			insert_one_record(log, ident.buf, oneline_str);
 	}
 	if (log->groups & SHORTLOG_GROUP_COMMITTER) {
@@ -300,7 +247,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 				      log->email ? "%cN <%cE>" : "%cN",
 				      &ident, &ctx);
 		if (!HAS_MULTI_BITS(log->groups) ||
-		    !strset_check_and_add(&dups, ident.buf))
+		    strset_add(&dups, ident.buf))
 			insert_one_record(log, ident.buf, oneline_str);
 	}
 	if (log->groups & SHORTLOG_GROUP_TRAILER) {
-- 
gitgitgadget
