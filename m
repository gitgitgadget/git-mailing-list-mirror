Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0856BC4742C
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5BF220A8B
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoywFgUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732946AbgKFAZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 19:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732906AbgKFAZO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 19:25:14 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A2BC0613D3
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 16:25:14 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id k18so3273911wmj.5
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 16:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/m8cQExWBEWxoRtNoB5eAbuRwvA8C0BdwF9qLyUY+84=;
        b=LoywFgUdaHT4wS1n3KRdI7su0gc8hzJuGF6fWuFxEOXudOVdlo8O222r/5x5j55IAI
         HnRnO39E9FV07QPSYayprAtFk3WGKJCFy+hqUfeuOCRudbtRAJUhdDxzDA+3smIdwK3l
         t0z6XcpAYFmqYUc5WBOG/Z1yWInJYhpjrP8whC3143CSAlw1c6rWfGxowJSA/JILeFgz
         7GPyiqSqk3vxv4AdozLNPxQ5bqR5aCPHWdf9jDDlkQix24VcJ79EXg1ktK/PmpTcauFS
         5uEDWe3GPoYrFfvf3sp5Hpyu+xZH12BKk9LsxebXGkW7CjlYlG2UUnAa5rqTUZ/Efy+p
         LCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/m8cQExWBEWxoRtNoB5eAbuRwvA8C0BdwF9qLyUY+84=;
        b=fzgvbg2J1Ud4QfqcM/WFLgeehP0wU4Z/xsIGCCEeG/h9Dw2xS1hE38PbDLM72QPnKP
         HP4MmK0fi6k30ws4xFmkjemZQRB/VyFr8WpBaOA/68crlrj1Fq4zVReINx/XY+1ZaUrD
         +uxDSSZ2iCu8iQrZ0iIl8KQFWudFkUcznVkFQyRUkqXUIBIwj250k+vF4nov1DzqlZ+j
         2Nd92TerF0E/kRwkdhP6e++4aqMnupQqqZ7/I/921og2YuZ/mSTJ8BLAbrEHYVOGSmly
         PO53nsNWr02TMTWHJYO9Kt+KEUoJa878r/YirI+/HwywZ3CmC3Ft8zzxQ3W70Sj0YYzj
         Qv8w==
X-Gm-Message-State: AOAM530p2YKHI9bopzOWf6lbAm2BPGs39ngpu5gx7A+iQhmcSwzkw312
        gdjs40xwKh9pBEz2Pk+aC0UBXStDbPw=
X-Google-Smtp-Source: ABdhPJyKJBIpR+YCSaKKJ97h65JsqvKAahxUdkZmmgDRrhw55tFcmFNwlNiwWPKsiAQe4ykeSAH6Zg==
X-Received: by 2002:a7b:cbc3:: with SMTP id n3mr5339035wmi.68.1604622312738;
        Thu, 05 Nov 2020 16:25:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c64sm4672865wmd.41.2020.11.05.16.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 16:25:12 -0800 (PST)
Message-Id: <24e5ce60f5e945239ba23b823c8e69640265e531.1604622299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
References: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
        <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Nov 2020 00:24:58 +0000
Subject: [PATCH v5 15/15] shortlog: use strset from strmap.h
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
