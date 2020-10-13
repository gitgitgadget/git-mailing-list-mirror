Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D18C04EBE
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83271221EB
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMTJ3tgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgJMAk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 20:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgJMAk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 20:40:57 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0A0C0613D2
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 17:40:57 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n6so21402388wrm.13
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 17:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VKYo8iXTDZoQH95nykH7eXsdUtwX/sFVwfZ2qNQJGwE=;
        b=tMTJ3tgWf7KEB/Z7my6I4xidyV9HQt8cjBz1qcMDxKIYga+lLzSXUMMz/NqhrGQ+we
         9UsSfU8ecO40p5d4oHzPaMbp5zjUz5ze5Iz1JiOsP4sp66zvX0YbAk/FbYqZFiD7fIMi
         JxdF4KnsPHx7L9VspyecOwZScnSL8wj1KpYCYPYwZnKdCin7UsQNQ9VGzGB6EMeIlnVP
         Cdz4PWIjsSeOSiNYVakCnUD/WLblGg4deJw+ue7btwgz+OzzzWnndNXYSRFoIyaOLvDp
         BkxaJEcQahst4XuuQ0ycLGsFmRNEmcQSQG5i5QLcVPej2i3EFO3L3ONrekSk7z74cEsD
         uFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VKYo8iXTDZoQH95nykH7eXsdUtwX/sFVwfZ2qNQJGwE=;
        b=HV9wulgXc7S7R9lU3hRmBFX775mr7LtprUFE6oDPdSnU4QfyynkcZMLdsWlB4tbMlt
         cOZahpYjhBpNpGHdIk3ll6Fn7I0dA5Doib/cW+PRBxIa2SXZ3C1VWgHlWA1WwO+yCavS
         UTHGcL3xQL/4tzfyiDxouX2nm/5w2qUnQBmj16s2WtYd9MMLyzTs0zmLp7nrqzbUeGiW
         nlhJTcGXM/1P/3t4hBTeyqRog/8BQj2yxeOjdRTHKQYo/06As2Atd1/pDBpUdK+Tgd4X
         EDJjGZX3FQLkmpj9gp35JlxF2658b+CJukszTZfr8v7iVUeqYbloE6dRR/qPob1BQkRC
         qt0A==
X-Gm-Message-State: AOAM5335hzGe5bJBXEiTLW4Oe05qLEbft37yXaRBo7ggFwkxYcZpPRjt
        tC9uPg4pBYycnpx8j8mf7e1xva2CGdc=
X-Google-Smtp-Source: ABdhPJy5DVEKVo8UHwKDwiqBhCQf0XYkwzyRlwy2gMHMF7N8mHFoGqmP/34UB55KJVwk+yBK6ADYDA==
X-Received: by 2002:adf:82e5:: with SMTP id 92mr31272049wrc.192.1602549656030;
        Mon, 12 Oct 2020 17:40:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x6sm26133530wmb.17.2020.10.12.17.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 17:40:55 -0700 (PDT)
Message-Id: <061ab45a9bdae5352f62fa6e81bb21ae5c94b8df.1602549650.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
        <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Oct 2020 00:40:44 +0000
Subject: [PATCH v2 04/10] hashmap: introduce a new hashmap_partial_clear()
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

merge-ort is a heavy user of strmaps, which are built on hashmap.[ch].
reset_maps() in merge-ort was taking about 12% of overall runtime in my
testcase involving rebasing 35 patches of linux.git across a big rename.
reset_maps() was calling hashmap_free() followed by hashmap_init(),
meaning that not only was it freeing all the memory associated with each
of the strmaps just to immediately allocate a new array again, it was
allocating a new array that wasy likely smaller than needed (thus
resulting in later need to rehash things).  The ending size of the map
table on the previous commit was likely almost perfectly sized for the
next commit we wanted to pick, and not dropping and reallocating the
table immediately is a win.

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
index 2994dc7a9c..056a8cda32 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -232,7 +232,8 @@ void hashmap_init(struct hashmap *map,
 			 const void *equals_function_data,
 			 size_t initial_size);
 
-/* internal function for freeing hashmap */
+/* internal functions for clearing or freeing hashmap */
+void hashmap_partial_clear_(struct hashmap *map, ssize_t offset);
 void hashmap_free_(struct hashmap *map, ssize_t offset);
 
 /*
@@ -265,6 +266,16 @@ void hashmap_free_(struct hashmap *map, ssize_t offset);
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

