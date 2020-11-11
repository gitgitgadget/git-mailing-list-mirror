Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AD8C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BCCB2087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT4M+fRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgKKUCb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbgKKUC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:02:29 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6230C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:28 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a3so3443797wmb.5
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hz04PDbA9UEQiHo/9pZvZ4q4Euew0clND1poGrjjarc=;
        b=ZT4M+fRy6KORs+1LA+LzHUEBMYAazuWFOdNctJwVqW+SIhn44v9H71Vlscq+Kpz/gg
         FIUA4P5RCsZf9L09sWC7sVYajQjy3a+gAh0cP3R5o7kelMglP96Sd+YNO+JU2EEI4Xut
         nCl5x47y90uK0T+cGhgho9t/L6umvE7PAyd13zy675hW7DaT6NJTjLI7VAYE2DgUUOFj
         kY6zCC0gW6yiDLR0zDgqdQx5H6rbhGXFozDK++KLyJIo7h38Xt7r0SPD/rkiAq6DTkt2
         y7AhiggWA8EGsWtoAayHtO8f7PMN6KelGiR8sUL5KTbmynz0kL7gZ+yB5jCWxCZyolCL
         5oOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hz04PDbA9UEQiHo/9pZvZ4q4Euew0clND1poGrjjarc=;
        b=Eiv3gvCPjk9m+0+ROXshd6MtuKCLz+xnU1jUgKci68o67hpGCdmtSlb5JRz2kYV2iH
         ZWbqkWJBor9py2gbGkSoJmznzWL3v7ELMeCfkeJ/EjS9iQir1y2sdMVrr/JUznvdgLpT
         zLxMfJFezE8cPs3DZgFgBAonbdtqezFPnN+4RgzEbpE0+DMm2rbYluv4QFculETrqKx0
         FV0bhfGNADatTWmIyMCZb0c/sRA/tu3pwLDoebdSqZcAEjetlLifiwt32wN+mT0LjESo
         syIQQ6SLFvUlf0f/Q7KBNx/btjftd6x0aE5NOYoRnkF7ABf+Na6tQqoFAOGrYObciQoy
         awJw==
X-Gm-Message-State: AOAM533NeOqio3X1azfX/iGWlDRZ+hDLh3TutUIbsf+wX6mO5a3MqOs7
        yqr9B0penSC8+VIxkVVVpFSY66J+Cos=
X-Google-Smtp-Source: ABdhPJwSNKPR9h6WEJ+LXPNjYIl7wCr1vje8xD0k0ei+VyNVnetGa84SjgSa9tmvj/FLxbhEWgYNrQ==
X-Received: by 2002:a1c:2cd7:: with SMTP id s206mr5609855wms.182.1605124947413;
        Wed, 11 Nov 2020 12:02:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t5sm3810676wmg.19.2020.11.11.12.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:02:26 -0800 (PST)
Message-Id: <61f1da3c51b521035ba728c025cd6a28397f8051.1605124942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
References: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
        <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 20:02:10 +0000
Subject: [PATCH v6 04/15] hashmap: introduce a new hashmap_partial_clear()
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

