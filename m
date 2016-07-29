Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A2FD1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 16:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbcG2QUG (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 12:20:06 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35356 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130AbcG2QUD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 12:20:03 -0400
Received: by mail-pa0-f67.google.com with SMTP id cf3so5429334pad.2
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 09:20:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vd+LDEAecuYrRtczRYHImUQSMkldOQ6AwKBWkKiobak=;
        b=Tm965DEjTJaP9sfDcuJ7TR9trukrbXqIPeUJf/r0fzuTdTEXwITYPWtUteJOIt5qaC
         d8QQI46gEsneYpMqPxVB7suOBh6j7hUdbBXDQtCTmzWyhdoX7O2v3qRR1vJe1hbaeADb
         E2OlYT491u9935F60fDOFKRhPcVvmegDw1RqBr98IcDpoD8vvLheKh1hnDDCKxdwT2/O
         fqudgJKHOwKG5nTiPtNPi6tjC9Cqwo7dzUpmy7+tomxvGL6STYIvDOQBH+DTXhgK+m7r
         ih1zzTsZ3P0QRuRdgfmSN1w1OYoibgL3rgejXMG871qkkSxrTUF7hyoBTUC4A/3vzhjz
         KLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vd+LDEAecuYrRtczRYHImUQSMkldOQ6AwKBWkKiobak=;
        b=B35HSHxQ6/NDD4xQ/G04KfuuOGx8wwnlX6HccFiqx6ExtyFkGuPPAYdKjAgH5UifZX
         Bhu/NbJ5AHEykBXvfI7o+cr5GknCM88soxceb0sKBEdZkQ+PGn23/yhpRxMcXlPBE+rQ
         WKGuSJOBVftEW93GrW1FZJSI24TLk8Bc1io1xkD8Th4hgMxy2OGQr+U/UGfsFHGeC7Re
         cCp6tX+pIr+EFTH4O/G/07Du8j90sc6xZz7LgjpFFqN+mB3EybImGjmKd1v+IfICNVjp
         e4iLcJ4HIeZerOkWGv7Xd5ghDb2Y9zD1EyraS1yQgAjX3JUiXrJrAYGlh2mSSntbFDKT
         hbkA==
X-Gm-Message-State: AEkooutUSQbIBNdOQbcrTLPbd6BUNoH2MdpvTdjZgsO2m2CYxFryc5VKQfI/JwaBzmFosw==
X-Received: by 10.66.254.39 with SMTP id af7mr69938374pad.37.1469809203127;
        Fri, 29 Jul 2016 09:20:03 -0700 (PDT)
Received: from DESKTOP-SLJ7FNG.northamerica.corp.microsoft.com ([2001:4898:8010:1::5b0])
        by smtp.gmail.com with ESMTPSA id i69sm26193282pfk.30.2016.07.29.09.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 09:20:02 -0700 (PDT)
From:	Kevin Willford <kcwillford@gmail.com>
To:	git@vger.kernel.org
Cc:	Kevin Willford <kewillf@microsoft.com>,
	Kevin Willford <kcwillford@gmail.com>
Subject: [[PATCH v2] 1/4] patch-ids: stop using a hand-rolled hashmap implementation
Date:	Fri, 29 Jul 2016 12:19:17 -0400
Message-Id: <20160729161920.3792-2-kcwillford@gmail.com>
X-Mailer: git-send-email 2.9.2.gvfs.2.42.gb7633a3
In-Reply-To: <20160729161920.3792-1-kcwillford@gmail.com>
References: <20160729161920.3792-1-kcwillford@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Kevin Willford <kewillf@microsoft.com>

This change will use the hashmap from the hashmap.h to keep track of the
patch_ids that have been encountered instead of using an internal
implementation.  This simplifies the implementation of the patch ids.

Signed-off-by: Kevin Willford <kcwillford@gmail.com>
---
 patch-ids.c | 86 +++++++++++++++++++++----------------------------------------
 patch-ids.h |  7 +++--
 2 files changed, 32 insertions(+), 61 deletions(-)

diff --git a/patch-ids.c b/patch-ids.c
index a4d0016..db31fa6 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -16,90 +16,62 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
 	return diff_flush_patch_id(options, sha1);
 }
 
-static const unsigned char *patch_id_access(size_t index, void *table)
+static int patch_id_cmp(struct patch_id *a,
+			struct patch_id *b,
+			void *keydata)
 {
-	struct patch_id **id_table = table;
-	return id_table[index]->patch_id;
+	return hashcmp(a->patch_id, b->patch_id);
 }
 
-static int patch_pos(struct patch_id **table, int nr, const unsigned char *id)
-{
-	return sha1_pos(id, table, nr, patch_id_access);
-}
-
-#define BUCKET_SIZE 190 /* 190 * 21 = 3990, with slop close enough to 4K */
-struct patch_id_bucket {
-	struct patch_id_bucket *next;
-	int nr;
-	struct patch_id bucket[BUCKET_SIZE];
-};
-
 int init_patch_ids(struct patch_ids *ids)
 {
 	memset(ids, 0, sizeof(*ids));
 	diff_setup(&ids->diffopts);
 	DIFF_OPT_SET(&ids->diffopts, RECURSIVE);
 	diff_setup_done(&ids->diffopts);
+	hashmap_init(&ids->patches, (hashmap_cmp_fn)patch_id_cmp, 256);
 	return 0;
 }
 
 int free_patch_ids(struct patch_ids *ids)
 {
-	struct patch_id_bucket *next, *patches;
-
-	free(ids->table);
-	for (patches = ids->patches; patches; patches = next) {
-		next = patches->next;
-		free(patches);
-	}
+	hashmap_free(&ids->patches, 1);
 	return 0;
 }
 
-static struct patch_id *add_commit(struct commit *commit,
-				   struct patch_ids *ids,
-				   int no_add)
+static int init_patch_id_entry(struct patch_id *patch,
+			       struct commit *commit,
+			       struct patch_ids *ids)
 {
-	struct patch_id_bucket *bucket;
-	struct patch_id *ent;
-	unsigned char sha1[20];
-	int pos;
-
-	if (commit_patch_id(commit, &ids->diffopts, sha1))
-		return NULL;
-	pos = patch_pos(ids->table, ids->nr, sha1);
-	if (0 <= pos)
-		return ids->table[pos];
-	if (no_add)
-		return NULL;
-
-	pos = -1 - pos;
+	if (commit_patch_id(commit, &ids->diffopts, patch->patch_id))
+		return -1;
 
-	bucket = ids->patches;
-	if (!bucket || (BUCKET_SIZE <= bucket->nr)) {
-		bucket = xcalloc(1, sizeof(*bucket));
-		bucket->next = ids->patches;
-		ids->patches = bucket;
-	}
-	ent = &bucket->bucket[bucket->nr++];
-	hashcpy(ent->patch_id, sha1);
-
-	ALLOC_GROW(ids->table, ids->nr + 1, ids->alloc);
-	if (pos < ids->nr)
-		memmove(ids->table + pos + 1, ids->table + pos,
-			sizeof(ent) * (ids->nr - pos));
-	ids->nr++;
-	ids->table[pos] = ent;
-	return ids->table[pos];
+	hashmap_entry_init(patch, sha1hash(patch->patch_id));
+	return 0;
 }
 
 struct patch_id *has_commit_patch_id(struct commit *commit,
 				     struct patch_ids *ids)
 {
-	return add_commit(commit, ids, 1);
+	struct patch_id patch;
+
+	memset(&patch, 0, sizeof(patch));
+	if (init_patch_id_entry(&patch, commit, ids))
+		return NULL;
+
+	return hashmap_get(&ids->patches, &patch, NULL);
 }
 
 struct patch_id *add_commit_patch_id(struct commit *commit,
 				     struct patch_ids *ids)
 {
-	return add_commit(commit, ids, 0);
+	struct patch_id *key = xcalloc(1, sizeof(*key));
+
+	if (init_patch_id_entry(key, commit, ids)) {
+		free(key);
+		return NULL;
+	}
+
+	hashmap_add(&ids->patches, key);
+	return key;
 }
diff --git a/patch-ids.h b/patch-ids.h
index eeb56b3..9569ee0 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -2,15 +2,14 @@
 #define PATCH_IDS_H
 
 struct patch_id {
-	unsigned char patch_id[20];
+	struct hashmap_entry ent;
+	unsigned char patch_id[GIT_SHA1_RAWSZ];
 	char seen;
 };
 
 struct patch_ids {
+	struct hashmap patches;
 	struct diff_options diffopts;
-	int nr, alloc;
-	struct patch_id **table;
-	struct patch_id_bucket *patches;
 };
 
 int commit_patch_id(struct commit *commit, struct diff_options *options,
-- 
2.9.2.gvfs.2.42.gb7633a3

