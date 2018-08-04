Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 044081F597
	for <e@80x24.org>; Sat,  4 Aug 2018 05:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeHDHhC (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 03:37:02 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46814 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbeHDHhC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 03:37:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id l16-v6so5508149lfc.13
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 22:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ueVnH6FS/S0c75qa84oj2OfM4eABg1xebfrTDrPrNc=;
        b=IEa+fFxFMyUMQtIKELsJlAwhmMc38ABpLwLYbODZjQfcGc0lZp+SYHvsKNQh7sAf0R
         Zl4l9t0RdhrMumLxe/Z9ESMsthb6GzPi7u209CRj+Mfz2pnvmSacX1KR8LIo0ZWMu/c0
         BBxYqllTtb1R0KhgAGqT3a4h6LxRwmcdu6bLVbFAicLVmMMtm/EFHc155KSZUPoJt5LV
         o+BBqD/gWtN9ayLJWpyFt9tlDAU37ayB832BMWkOUFeNg4hB1I6w071lMRkgmFPVoNJT
         KrtRWcfisYvrLh3XccCzGlSTwYgoxly6AU/6rakVzYrHLZgu3Hc8RlmGUOSh7BUH0pQX
         kcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ueVnH6FS/S0c75qa84oj2OfM4eABg1xebfrTDrPrNc=;
        b=fui99UKBjrCwv7CvnEFZs1B8JhTO+eFQv64imbNgafIcqm8wOIljntx8xIqa+xlNmS
         mR5jSfymbGg22OQi0WydhBBe2zSZg3NwnIvzwnpJbNcRRUqxzj1jV4MqooJh8X4CGnKM
         NmrDh6HdjhPjZWZdoJOz9flJH/WgVPK/tJI75LV0QBI0F1moMsSlmZ45eigNg/Y4ohFR
         txsjuSkFhjBtYO12kpf8DhNd/RRhENen8OwURsCPzBwikk5pDlKpjZFvkRumjkO10cFc
         42YuxphtLEDxfISt48KBq5dSmpvTnn/99tRQT3VJzUOEg7EPW4x2f4yTi57K5oVNdfjN
         iwnQ==
X-Gm-Message-State: AOUpUlEAhSMg9Gln1NDj2wOVQDxyeuaeChZE49/JHfZEMVfJFyCQZGb3
        uSnT4jfNsj7u6VHhvbJjJD/O3jbi
X-Google-Smtp-Source: AAOMgpfogENB+0tEA877/ppzBZLKjhxtLo26oOvN3jK3rjPNyGWt86Tcxxu0LUTr1HYIuhT9IaFIRA==
X-Received: by 2002:a19:12df:: with SMTP id 92-v6mr6022379lfs.80.1533361056153;
        Fri, 03 Aug 2018 22:37:36 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id 85-v6sm1044021lft.76.2018.08.03.22.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 22:37:35 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peartben@gmail.com, peff@peff.net
Subject: [PATCH v3 4/4] unpack-trees: cheaper index update when walking by cache-tree
Date:   Sat,  4 Aug 2018 07:37:23 +0200
Message-Id: <20180804053723.4695-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
In-Reply-To: <20180804053723.4695-1-pclouds@gmail.com>
References: <20180729103306.16403-1-pclouds@gmail.com>
 <20180804053723.4695-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the new cache-tree, we could mostly avoid I/O (due to odb access)
the code mostly becomes a loop of "check this, check that, add the
entry to the index". We could skip a couple checks in this giant loop
to go faster:

- We know here that we're copying entries from the source index to the
  result one. All paths in the source index must have been validated
  at load time already (and we're not taking strange paths from tree
  objects) which means we can skip verify_path() without compromise.

- We also know that D/F conflicts can't happen for all these entries
  (since cache-tree and all the trees are the same) so we can skip
  that as well.

This gives rather nice speedups for "unpack trees" rows where "unpack
trees" time is now cut in half compared to when
traverse_by_cache_tree() is added, or 1/7 of the original "unpack
trees" time.

   baseline      cache-tree    this patch
 --------------------------------------------------------------------
   0.018239226   0.019365414   0.020519621 s: read cache .git/index
   0.052541655   0.049605548   0.048814384 s: preload index
   0.001537598   0.001571695   0.001575382 s: refresh index
   0.168167768   0.049677212   0.024719308 s: unpack trees
   0.002897186   0.002845256   0.002805555 s: update worktree after a merge
   0.131661745   0.136597522   0.134891617 s: repair cache-tree
   0.075389117   0.075422517   0.074832291 s: write index, changed mask = 2a
   0.111702023   0.032813253   0.008616479 s: unpack trees
   0.000023245   0.000022002   0.000026630 s: update worktree after a merge
   0.111793866   0.032933140   0.008714071 s: diff-index
   0.587933288   0.398924370   0.380452871 s: git command: /home/pclouds/w/git/git

Total saving of this new patch looks even less impressive, now that
time spent in unpacking trees is so small. Which is why the next
attempt should be on that "repair cache-tree" line.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h        |  1 +
 read-cache.c   |  3 ++-
 unpack-trees.c | 20 ++++++++++++++++++++
 unpack-trees.h |  1 +
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 8b447652a7..e6f7ee4b64 100644
--- a/cache.h
+++ b/cache.h
@@ -673,6 +673,7 @@ extern int index_name_pos(const struct index_state *, const char *name, int name
 #define ADD_CACHE_JUST_APPEND 8		/* Append only; tree.c::read_tree() */
 #define ADD_CACHE_NEW_ONLY 16		/* Do not replace existing ones */
 #define ADD_CACHE_KEEP_CACHE_TREE 32	/* Do not invalidate cache-tree */
+#define ADD_CACHE_SKIP_VERIFY_PATH 64	/* Do not verify path */
 extern int add_index_entry(struct index_state *, struct cache_entry *ce, int option);
 extern void rename_index_entry_at(struct index_state *, int pos, const char *new_name);
 
diff --git a/read-cache.c b/read-cache.c
index e865254bea..b0b5df5de7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1170,6 +1170,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	int ok_to_add = option & ADD_CACHE_OK_TO_ADD;
 	int ok_to_replace = option & ADD_CACHE_OK_TO_REPLACE;
 	int skip_df_check = option & ADD_CACHE_SKIP_DFCHECK;
+	int skip_verify_path = option & ADD_CACHE_SKIP_VERIFY_PATH;
 	int new_only = option & ADD_CACHE_NEW_ONLY;
 
 	if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
@@ -1210,7 +1211,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 
 	if (!ok_to_add)
 		return -1;
-	if (!verify_path(ce->name, ce->ce_mode))
+	if (!skip_verify_path && !verify_path(ce->name, ce->ce_mode))
 		return error("Invalid path '%s'", ce->name);
 
 	if (!skip_df_check &&
diff --git a/unpack-trees.c b/unpack-trees.c
index c8defc2015..1438ee1555 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -201,6 +201,7 @@ static int do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 
 	ce->ce_flags = (ce->ce_flags & ~clear) | set;
 	return add_index_entry(&o->result, ce,
+			       o->extra_add_index_flags |
 			       ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 }
 
@@ -701,6 +702,24 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
 	if (!o->merge)
 		BUG("We need cache-tree to do this optimization");
 
+	/*
+	 * Try to keep add_index_entry() as fast as possible since
+	 * we're going to do a lot of them.
+	 *
+	 * Skipping verify_path() should totally be safe because these
+	 * paths are from the source index, which must have been
+	 * verified.
+	 *
+	 * Skipping D/F and cache-tree validation checks is trickier
+	 * because it assumes what n-merge code would do when all
+	 * trees and the index are the same. We probably could just
+	 * optimize those code instead (e.g. we don't invalidate that
+	 * many cache-tree, but the searching for them is very
+	 * expensive).
+	 */
+	o->extra_add_index_flags = ADD_CACHE_SKIP_DFCHECK;
+	o->extra_add_index_flags |= ADD_CACHE_SKIP_VERIFY_PATH;
+
 	/*
 	 * Do what unpack_callback() and unpack_nondirectories() normally
 	 * do. But we walk all paths recursively in just one loop instead.
@@ -742,6 +761,7 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
 
 		mark_ce_used(src[0], o);
 	}
+	o->extra_add_index_flags = 0;
 	free(tree_ce);
 	if (o->debug_unpack)
 		printf("Unpacked %d entries from %s to %s using cache-tree\n",
diff --git a/unpack-trees.h b/unpack-trees.h
index c2b434c606..94e1b14078 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -80,6 +80,7 @@ struct unpack_trees_options {
 	struct index_state result;
 
 	struct exclude_list *el; /* for internal use */
+	unsigned int extra_add_index_flags;
 };
 
 extern int unpack_trees(unsigned n, struct tree_desc *t,
-- 
2.18.0.656.gda699b98b3

