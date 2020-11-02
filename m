Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB88C388F9
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F8822268
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uhPN5FZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgKBSzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgKBSzV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 13:55:21 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDFFC061A48
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 10:55:20 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id k18so10512004wmj.5
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 10:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hz04PDbA9UEQiHo/9pZvZ4q4Euew0clND1poGrjjarc=;
        b=uhPN5FZyV1pkfpMasGAV6hIs6WfZHKI6ZSj3Cj0ce7mSV79D/92Oz2XLbBUQkGB0p6
         Y7kXt5fcMpfeCHt4ajTGs0OQu6dEVxt/Sl9MGCxJXDwefcbmLYkxEJBbtYcV3kWXqhbo
         7UAfVydVbwxlkZoxJHLBqwOjKjaREiD+Yy7LYbSYUQb7T/G51YUcJk0AWJ19Klz5dE95
         0IUgSxCHhN2HSE/rpThpZIZsD8KGTg8X2pACDNGSZyYthHP7w9udz8MS+JB6FzjfdYXz
         XarJWOas8AwzLA+d4l29M5gPp5Xp7WBpC2hUt8WW0HnjHbr4CLmsu3seB1ZQMbEFqbzv
         Xd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hz04PDbA9UEQiHo/9pZvZ4q4Euew0clND1poGrjjarc=;
        b=F/wpJbiLd4IdxeS7bLziYS6d5V7HyAsRIwnxglhjrwnmVK0IFLicLhDEtCF2nOLl6L
         Qbx2/Em7x5JblPzSU2VuJiaDjhWtGo19INiV4+XOGt6NeSvy37SYXqo0KFKOC0AdzXr/
         aM1VwFOF01XSQUg/qZxy46rFyicRYNtFkPC1Ucd6fcgnkRGj35+6larzpKVwSDpOqxPz
         Ou5t3u4YGpUZP5gkhOuLtXXXBrdrswrzhgu+8s9zCOW7aNqOt/13JsJKBHcx/5jkkDZt
         3eeuGSLY1Epig0+rq3FFawqSee5+2PZZMQdaYZsgxR9XcaxhhKumwGtGEp/RRHsYXZLQ
         vcfg==
X-Gm-Message-State: AOAM532bJ41aErl6BEjh08ekj64HqfIidHjtvzZEU2tptSXL1B323zUf
        5du9PP7l+zkPZFpnw/kSqQAjbAMSNr8=
X-Google-Smtp-Source: ABdhPJxkueQRgNPtLI/AYkPHvni9PJebmphDeScuSGItJnCP1T7Fr2+OQ8GpI/aAVFzNAD+y+FI36Q==
X-Received: by 2002:a1c:3103:: with SMTP id x3mr19147958wmx.107.1604343319133;
        Mon, 02 Nov 2020 10:55:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4sm24633338wrf.67.2020.11.02.10.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:55:18 -0800 (PST)
Message-Id: <61f1da3c51b521035ba728c025cd6a28397f8051.1604343314.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
References: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
        <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Nov 2020 18:55:04 +0000
Subject: [PATCH v3 04/13] hashmap: introduce a new hashmap_partial_clear()
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

