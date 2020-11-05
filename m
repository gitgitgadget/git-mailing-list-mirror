Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C0AC388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 00:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D543020825
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 00:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inc1XOIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbgKEAYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 19:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730630AbgKEAWx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 19:22:53 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECF7C0613D2
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 16:22:52 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id w1so394671wrm.4
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 16:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hz04PDbA9UEQiHo/9pZvZ4q4Euew0clND1poGrjjarc=;
        b=inc1XOIBbKCTEvq5GFbd9Ye3xy2z5feLr4Ce1B+HkyoG50CSsMcbLx4A6mgVCNgTMu
         e6BhM5kBhfQLt42OkhNyv+/O3p7kZIxUp8K1EpQDmvLd+zVna2RaHaPpqEvGM+NKszDF
         LZdoUlrb0lcYyuxh3tgZ3d39J38sRFqiayLR6TLQrIzdTdDq77EBDWw06NYIm5hknQcc
         zp8yE99wvb/VJ5Ptc20I3Kq/X7J9zE5FW7xuUFPUEalADxzpMFiDodleMKZErYTPeVhk
         Y2sSO424FMJB1joNYlmNMh0GNXtzkjACfcIVPvQNlYhnIR6GcYUCC9Rg17zGoB23Mrty
         gOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hz04PDbA9UEQiHo/9pZvZ4q4Euew0clND1poGrjjarc=;
        b=my2bQ6sjFKAcfBir0Vvi3UR6xGoyL0lB2R1akR7W2uPkG5W1nAO66R3hA3+UmnLD/c
         TmVdWbwwAelROkSdndY5fq2om1TQiEnAbHcJXnyWLJmnWmpmbsiqsuIaBpldB+1vmM2U
         6ohXF7rd+6EcqsRqdVtrVfPi8XtXe3xSgOS/eCRwMjCrDQ1Q6KRMaPI7IROMmk5YmQlt
         5kwA7VVnS1RmHRH84ADY1tim7CpyH5czjhY3fl4sD45zNdzdp9CZgyubl7/m30QFg2aL
         s5sLODWlKdhF9ITw0UXV66BnzHCwUWucd1edl/GsGvUYKK/g/jQiZhtfwGQ7V04LR0fB
         K4BA==
X-Gm-Message-State: AOAM530CODJUHCox/UQNu583qfMhoo8kvLiOc/Hm3iIgV6r9y/UW4X6o
        pLRQob82yiex09B8hvdi9R3ClgYkh9k=
X-Google-Smtp-Source: ABdhPJygy0+nokQ9ODHI+KUYUcGQkvzjVMPP+oyVogHI8wM4e7rj6xUHMTovD80aXG33klaXbOTdXw==
X-Received: by 2002:adf:c101:: with SMTP id r1mr542170wre.87.1604535770724;
        Wed, 04 Nov 2020 16:22:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x10sm5006381wrp.62.2020.11.04.16.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 16:22:50 -0800 (PST)
Message-Id: <61f1da3c51b521035ba728c025cd6a28397f8051.1604535765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
References: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
        <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 05 Nov 2020 00:22:36 +0000
Subject: [PATCH v4 04/13] hashmap: introduce a new hashmap_partial_clear()
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

merge-ort is a heavy user of strmaps, which are built on hashmap.[ch].
clear_or_reinit_internal_opts() in merge-ort was taking about 12% of
overall runtime in my testcase involving rebasing 35 patches of
linux.git across a big rename.  clear_or_reinit_internal_opts() was
calling hashmap_free() followed by hashmap_init(), meaning that not only
was it freeing all the memory associated with each of the strmaps just
to immediately allocate a new array again, it was allocating a new array
that was likely smaller than needed (thus resulting in later need to
rehash things).  The ending size of the map table on the previous commit
was likely almost perfectly sized for the next commit we wanted to pick,
and not dropping and reallocating the table immediately is a win.

Add some new API to hashmap to clear a hashmap of entries without
freeing map->table (and instead only zeroing it out like alloc_table()
would do, along with zeroing the count of items in the table and the
shrink_at field).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 hashmap.c | 39 +++++++++++++++++++++++++++------------
 hashmap.h | 13 ++++++++++++-
 2 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/hashmap.c b/hashmap.c
index bb7c9979b8..922ed07954 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -174,22 +174,37 @@ void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
 	map->do_count_items = 1;
 }
 
+static void free_individual_entries(struct hashmap *map, ssize_t entry_offset)
+{
+	struct hashmap_iter iter;
+	struct hashmap_entry *e;
+
+	hashmap_iter_init(map, &iter);
+	while ((e = hashmap_iter_next(&iter)))
+		/*
+		 * like container_of, but using caller-calculated
+		 * offset (caller being hashmap_free_entries)
+		 */
+		free((char *)e - entry_offset);
+}
+
+void hashmap_partial_clear_(struct hashmap *map, ssize_t entry_offset)
+{
+	if (!map || !map->table)
+		return;
+	if (entry_offset >= 0)  /* called by hashmap_clear_entries */
+		free_individual_entries(map, entry_offset);
+	memset(map->table, 0, map->tablesize * sizeof(struct hashmap_entry *));
+	map->shrink_at = 0;
+	map->private_size = 0;
+}
+
 void hashmap_free_(struct hashmap *map, ssize_t entry_offset)
 {
 	if (!map || !map->table)
 		return;
-	if (entry_offset >= 0) { /* called by hashmap_free_entries */
-		struct hashmap_iter iter;
-		struct hashmap_entry *e;
-
-		hashmap_iter_init(map, &iter);
-		while ((e = hashmap_iter_next(&iter)))
-			/*
-			 * like container_of, but using caller-calculated
-			 * offset (caller being hashmap_free_entries)
-			 */
-			free((char *)e - entry_offset);
-	}
+	if (entry_offset >= 0)  /* called by hashmap_free_entries */
+		free_individual_entries(map, entry_offset);
 	free(map->table);
 	memset(map, 0, sizeof(*map));
 }
diff --git a/hashmap.h b/hashmap.h
index 3b0f2bcade..e9430d582a 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -235,7 +235,8 @@ void hashmap_init(struct hashmap *map,
 		  const void *equals_function_data,
 		  size_t initial_size);
 
-/* internal function for freeing hashmap */
+/* internal functions for clearing or freeing hashmap */
+void hashmap_partial_clear_(struct hashmap *map, ssize_t offset);
 void hashmap_free_(struct hashmap *map, ssize_t offset);
 
 /*
@@ -268,6 +269,16 @@ void hashmap_free_(struct hashmap *map, ssize_t offset);
  */
 #define hashmap_free(map) hashmap_free_(map, -1)
 
+/*
+ * Basically the same as calling hashmap_free() followed by hashmap_init(),
+ * but doesn't incur the overhead of deallocating and reallocating
+ * map->table; it leaves map->table allocated and the same size but zeroes
+ * it out so it's ready for use again as an empty map.  As with
+ * hashmap_free(), you may need to free the entries yourself before calling
+ * this function.
+ */
+#define hashmap_partial_clear(map) hashmap_partial_clear_(map, -1)
+
 /*
  * Frees @map and all entries.  @type is the struct type of the entry
  * where @member is the hashmap_entry struct used to associate with @map.
-- 
gitgitgadget

