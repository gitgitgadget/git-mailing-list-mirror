Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAE5C55178
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A25152083B
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyER25FD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732820AbgKFAZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 19:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732396AbgKFAZF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 19:25:05 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AFDC0613CF
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 16:25:04 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id w1so3764316wrm.4
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 16:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hz04PDbA9UEQiHo/9pZvZ4q4Euew0clND1poGrjjarc=;
        b=JyER25FDQtBQzEjN6oBOIJrNTPlUTZDlAxXq7tXK/joTXFT+k1JPGdpOiUYpS2V3WT
         WQMMhZ9mywcVcROuiegzIIMA9TAqryU88ArA/WzAX06m6/PkG7iC+V7dfITnn1FWm7S0
         5bSj3te3jvY69xq9JKNowPigPbgzWW7jEnNNNmjimAnu+5Q/5Idoo3vdPtTSq8l4TFcp
         LN5VKDLF62EKbzaxWoHRhkWmnnqNwvJKXNsY4iXBd9ApIEkops6nBeG43oEPiOANroKB
         4kTBhDlR7KtwxyJy9tO4ZmMucglq7E+BidZbDKkYFEdly3l7io9QBAnVBef01Np9wbku
         ArJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hz04PDbA9UEQiHo/9pZvZ4q4Euew0clND1poGrjjarc=;
        b=lo0k7WkOi+m4ZamhCDbXnqrFOk6hyk+CmRU9nOmz2/udPgCKJyhQn8DW4lwlvlHAch
         4SDExEkOvRta5x/iGENRNv5d5tfiRJGb8gj/zT5YDLkHq7CjijbhTF6CtIsYJljVvGFX
         bZqyC+Sml2lkndZ9fkxrMPXGxW1qnLqj4MzspsO6gFpGqihhqWabdaDDdLEMXVPUrJyO
         BZaAnRZ4TOyjts+mEaoXJNDXUVOvqDsVkQG2RSrFNLgLpDj4x1XHvCn178ERLKksyrCH
         /2BmW2Op6UMYAfz96wLxvlrS/UzODkzO8lQYvI28jFNvHHxyf3QzLZ4G9pPfu8JPwbZW
         8K9g==
X-Gm-Message-State: AOAM532suCU7Typel4eUX9Qi9a0E4GUyz0byYoX1HjeJfo948w+P1fEk
        KJxrxdxfvPH+18bBJVq7gQDrgN6W1ko=
X-Google-Smtp-Source: ABdhPJw8ZrCyX7umyfyUYqrlmViTkEFAXVHEj8Srp0BCV1QhrL1BQjGKWA4DCbhZBimjIeHaMB6+Ng==
X-Received: by 2002:adf:b190:: with SMTP id q16mr5967239wra.288.1604622303573;
        Thu, 05 Nov 2020 16:25:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j9sm5117125wrr.49.2020.11.05.16.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 16:25:03 -0800 (PST)
Message-Id: <61f1da3c51b521035ba728c025cd6a28397f8051.1604622298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
References: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
        <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Nov 2020 00:24:47 +0000
Subject: [PATCH v5 04/15] hashmap: introduce a new hashmap_partial_clear()
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

