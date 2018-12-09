Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21C7920A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 20:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbeLIUFF (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 15:05:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41287 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeLIUFF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 15:05:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so8431220wrs.8
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 12:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FWZv98vQTtRzPGDVRi4ZffwSeHjhvEhAhSPCTlImz8Q=;
        b=J1j5QCtsuAUtJqUaijVqBiDIndKzHI6RMXgT4Bqg2jfReKADIafmeHwiknEks9EmAh
         ptvIoA5woNjss/hlPldCkg51LSXHXhbV14ybXKvsspkeG1LGr28/QEvdGoid5Wr3ieLB
         GOWHnGVzo5kPEKRdHVpz70tg9uxONF4s3mlufVm2LTFz4984H3UiRT3Aq8OSEaaxKOKn
         VOnyE8JgdBiOYx77m8HetivO65e10cXkfDLNz2pYtpyYWduJ4/uO6Acjdti7S9smCBWN
         /Dxgdxvp8G5wQw0U/fllf7cgKn+hAgCL3C+yAoVKlrGVzwvF7RgwYUeQ9ygdIIIgAkEW
         f33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FWZv98vQTtRzPGDVRi4ZffwSeHjhvEhAhSPCTlImz8Q=;
        b=qKhwCKc2v3COD4zyqD75PiNE1Q5+ZKdOeJZ7fh5zq289HVEcndHpEyEvY0Jugwlmwi
         zjpxWWCfTxbMt0g+FqzIZl4iiZMGl/KL4eyeAjo7+alvFqiUrye/eIC6ci6wXMpRYDcF
         vykaK6R058FkPeBccPbKb/ThqFBMvQbcEXLwrTjrYoyqsIHLACXD3i2obTbAUSxTvQKm
         ruXmYYTUaOPTfiwRUln4t8GKMuZIxZUxXEy6TVVgve+yV7ZCrUB87umIFUT+9RCYDqtX
         F2ugTUV/4oDWPnluMPAasj8l1maBJO53FP/9G1RHfatUo/KCZ5S/PXb2GnO7jYpWOAFn
         cEQw==
X-Gm-Message-State: AA+aEWb3m19mmf8+F065gQSgnhyzjgFPRupxDcqaZaJHYbg/y6a92fyO
        VN81Nxfj4KBfZHbqHaKeM6nASFiq
X-Google-Smtp-Source: AFSGD/WovncDlwt9G6jIu90q7cA/C8LdFkLLVDbgCv13AUbv7IAhXzNyULhpSr2GZD/l/v/xNG3chQ==
X-Received: by 2002:a5d:448f:: with SMTP id j15mr7265386wrq.108.1544385902843;
        Sun, 09 Dec 2018 12:05:02 -0800 (PST)
Received: from localhost ([2.24.105.121])
        by smtp.gmail.com with ESMTPSA id u204sm20523249wmu.30.2018.12.09.12.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 12:05:02 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 4/8] read-cache: add invalidate parameter to remove_marked_cache_entries
Date:   Sun,  9 Dec 2018 20:04:45 +0000
Message-Id: <20181209200449.16342-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <20181209200449.16342-1-t.gummerer@gmail.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When marking cache entries for removal, and later removing them all at
once using 'remove_marked_cache_entries()', cache entries currently
have to be invalidated manually in the cache tree and in the untracked
cache.

Add an invalidate flag to the function.  With the flag set, the
function will take care of invalidating the path in the cache tree and
in the untracked cache.

This will be useful in a subsequent commit.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

For the two current callsites, unpack-trees seems to do this
invalidation itself internally.  I don't quite understand why we don't
need it in split-index mode though.  I assume it's because the cache
tree in the main index would already have been invalidated?  I didn't
have much time to dig, but couldn't produce any failures with it
either, so I assume not invalidating paths is the right thing to do
here.

 cache.h        | 2 +-
 read-cache.c   | 8 +++++++-
 split-index.c  | 2 +-
 unpack-trees.c | 2 +-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index c1c953e810..1deee48f5b 100644
--- a/cache.h
+++ b/cache.h
@@ -751,7 +751,7 @@ extern void rename_index_entry_at(struct index_state *, int pos, const char *new
 /* Remove entry, return true if there are more entries to go. */
 extern int remove_index_entry_at(struct index_state *, int pos);
 
-extern void remove_marked_cache_entries(struct index_state *istate);
+extern void remove_marked_cache_entries(struct index_state *istate, int invalidate);
 extern int remove_file_from_index(struct index_state *, const char *path);
 #define ADD_CACHE_VERBOSE 1
 #define ADD_CACHE_PRETEND 2
diff --git a/read-cache.c b/read-cache.c
index 4ca81286c0..d86a06acba 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -590,13 +590,19 @@ int remove_index_entry_at(struct index_state *istate, int pos)
  * CE_REMOVE is set in ce_flags.  This is much more effective than
  * calling remove_index_entry_at() for each entry to be removed.
  */
-void remove_marked_cache_entries(struct index_state *istate)
+void remove_marked_cache_entries(struct index_state *istate, int invalidate)
 {
 	struct cache_entry **ce_array = istate->cache;
 	unsigned int i, j;
 
 	for (i = j = 0; i < istate->cache_nr; i++) {
 		if (ce_array[i]->ce_flags & CE_REMOVE) {
+			if (invalidate) {
+				cache_tree_invalidate_path(istate,
+							   ce_array[i]->name);
+				untracked_cache_remove_from_index(istate,
+								  ce_array[i]->name);
+			}
 			remove_name_hash(istate, ce_array[i]);
 			save_or_free_index_entry(istate, ce_array[i]);
 		}
diff --git a/split-index.c b/split-index.c
index 5820412dc5..8aebc3661b 100644
--- a/split-index.c
+++ b/split-index.c
@@ -162,7 +162,7 @@ void merge_base_index(struct index_state *istate)
 	ewah_each_bit(si->replace_bitmap, replace_entry, istate);
 	ewah_each_bit(si->delete_bitmap, mark_entry_for_delete, istate);
 	if (si->nr_deletions)
-		remove_marked_cache_entries(istate);
+		remove_marked_cache_entries(istate, 0);
 
 	for (i = si->nr_replacements; i < si->saved_cache_nr; i++) {
 		if (!ce_namelen(si->saved_cache[i]))
diff --git a/unpack-trees.c b/unpack-trees.c
index e8d1a6ac50..8e6afa924d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -392,7 +392,7 @@ static int check_updates(struct unpack_trees_options *o)
 				unlink_entry(ce);
 		}
 	}
-	remove_marked_cache_entries(index);
+	remove_marked_cache_entries(index, 0);
 	remove_scheduled_dirs();
 
 	if (should_update_submodules() && o->update && !o->dry_run)
-- 
2.20.0.405.gbc1bbc6f85

