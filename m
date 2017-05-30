Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E57D2027C
	for <e@80x24.org>; Tue, 30 May 2017 17:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751266AbdE3RcE (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:32:04 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35560 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdE3RcC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:32:02 -0400
Received: by mail-pf0-f171.google.com with SMTP id n23so78344572pfb.2
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dai+J2IILTKP/lh5yc7gJxosi1Jx2o5L9OPplk6SYPA=;
        b=mBko5sGlxuTgNzPaWkTYEuOW46MPhSGSA8d71Je7vyl7DabOjmvx9A8XRckFb0s2XH
         yKGu4JrRbuudw1Yx7aeOqy77IvA10cP9YDm0Re/4c7IvLs6zlBaRrMhG18DBvIZDpBQP
         LZYAhfJDZz5TZBi3iTezTHgOXfUGKAKOiB74Kla3u3OvDVDVWj9K0O7ylymgZRwOlXvC
         pbHdNlQD71GhdFhvRomhezDY4axgxjFcWQLed2p1lqw1rafo7l96xuYZ04snMqMGlTra
         YLJzm+ZkoISlYEWXcYqauNc6renK6CRsYLHf2MS8NchdBjS+6p+w2r39agJ+bSr8UEWt
         TzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dai+J2IILTKP/lh5yc7gJxosi1Jx2o5L9OPplk6SYPA=;
        b=L6QtCxrQ//wHwYxIv2f3cO83WTEnQ8U0fJX9ODU5aEL8NPDGD+eX0ELcgMYN83FnIW
         rQyGbfy+A3wOPJxP3kaDQVashQ/tgr4HHkU+OtOxAcwqj2ax9yZynzCddgoz7BuC4bbI
         maOBA8nwiXhOS/o3rH42AlNMG72jQKt0TxaNRPMj4O8FNRRSJ+pGT5vYdtGwA1AE2tGi
         NDzKsYuXI3hE79KWViDx7VVXsKiutO7AoDWggcI2OzGghDQjYzZUBhYFvddZ5mudIVTZ
         iFrgeWik3QrwJmB9Nr0EAgC5P0bvc/l/T9AGOB8CZ/4Bb5AqR6eZGQgMjWIFhQtrqSbs
         FCjQ==
X-Gm-Message-State: AODbwcDHog1/TZ9FVz4hkmS2e2HDF7jXB/Xf1mtaMOJFGw/3mRas9J58
        hp6QkHXcvNhlCy5D
X-Received: by 10.84.254.70 with SMTP id a6mr84157841pln.64.1496165522005;
        Tue, 30 May 2017 10:32:02 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:32:00 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 30/33] tree-diff: convert diff_tree_paths to struct object_id
Date:   Tue, 30 May 2017 10:31:06 -0700
Message-Id: <20170530173109.54904-31-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Brandon Williams <bmwill@google.com>
---
 combine-diff.c | 10 +++++-----
 diff.h         |  4 ++--
 tree-diff.c    | 63 +++++++++++++++++++++++++++++-----------------------------
 3 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 04c4ae856..ec9d93044 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1364,22 +1364,22 @@ static struct combine_diff_path *find_paths_multitree(
 	struct diff_options *opt)
 {
 	int i, nparent = parents->nr;
-	const unsigned char **parents_sha1;
+	const struct object_id **parents_oid;
 	struct combine_diff_path paths_head;
 	struct strbuf base;
 
-	ALLOC_ARRAY(parents_sha1, nparent);
+	ALLOC_ARRAY(parents_oid, nparent);
 	for (i = 0; i < nparent; i++)
-		parents_sha1[i] = parents->oid[i].hash;
+		parents_oid[i] = &parents->oid[i];
 
 	/* fake list head, so worker can assume it is non-NULL */
 	paths_head.next = NULL;
 
 	strbuf_init(&base, PATH_MAX);
-	diff_tree_paths(&paths_head, oid->hash, parents_sha1, nparent, &base, opt);
+	diff_tree_paths(&paths_head, oid, parents_oid, nparent, &base, opt);
 
 	strbuf_release(&base);
-	free(parents_sha1);
+	free(parents_oid);
 	return paths_head.next;
 }
 
diff --git a/diff.h b/diff.h
index e0b503460..0d0c14f28 100644
--- a/diff.h
+++ b/diff.h
@@ -210,8 +210,8 @@ const char *diff_line_prefix(struct diff_options *);
 extern const char mime_boundary_leader[];
 
 extern struct combine_diff_path *diff_tree_paths(
-	struct combine_diff_path *p, const unsigned char *sha1,
-	const unsigned char **parent_sha1, int nparent,
+	struct combine_diff_path *p, const struct object_id *oid,
+	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt);
 extern int diff_tree_oid(const struct object_id *old_oid,
 			 const struct object_id *new_oid,
diff --git a/tree-diff.c b/tree-diff.c
index 29e3f6144..6a960f569 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -26,11 +26,12 @@
 } while(0)
 
 static struct combine_diff_path *ll_diff_tree_paths(
-	struct combine_diff_path *p, const unsigned char *sha1,
-	const unsigned char **parents_sha1, int nparent,
+	struct combine_diff_path *p, const struct object_id *oid,
+	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt);
-static int ll_diff_tree_sha1(const unsigned char *old, const unsigned char *new,
-			     struct strbuf *base, struct diff_options *opt);
+static int ll_diff_tree_oid(const struct object_id *old_oid,
+			    const struct object_id *new_oid,
+			    struct strbuf *base, struct diff_options *opt);
 
 /*
  * Compare two tree entries, taking into account only path/S_ISDIR(mode),
@@ -183,7 +184,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 {
 	unsigned mode;
 	const char *path;
-	const unsigned char *sha1;
+	const struct object_id *oid;
 	int pathlen;
 	int old_baselen = base->len;
 	int i, isdir, recurse = 0, emitthis = 1;
@@ -193,7 +194,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 
 	if (t) {
 		/* path present in resulting tree */
-		sha1 = tree_entry_extract(t, &path, &mode)->hash;
+		oid = tree_entry_extract(t, &path, &mode);
 		pathlen = tree_entry_len(&t->entry);
 		isdir = S_ISDIR(mode);
 	} else {
@@ -208,7 +209,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 		pathlen = tree_entry_len(&tp[imin].entry);
 
 		isdir = S_ISDIR(mode);
-		sha1 = NULL;
+		oid = NULL;
 		mode = 0;
 	}
 
@@ -220,7 +221,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 	if (emitthis) {
 		int keep;
 		struct combine_diff_path *pprev = p;
-		p = path_appendnew(p, nparent, base, path, pathlen, mode, sha1);
+		p = path_appendnew(p, nparent, base, path, pathlen, mode, oid ? oid->hash : NULL);
 
 		for (i = 0; i < nparent; ++i) {
 			/*
@@ -229,7 +230,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 			 */
 			int tpi_valid = tp && !(tp[i].entry.mode & S_IFXMIN_NEQ);
 
-			const unsigned char *sha1_i;
+			const struct object_id *oid_i;
 			unsigned mode_i;
 
 			p->parent[i].status =
@@ -239,16 +240,16 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 						DIFF_STATUS_ADDED;
 
 			if (tpi_valid) {
-				sha1_i = tp[i].entry.oid->hash;
+				oid_i = tp[i].entry.oid;
 				mode_i = tp[i].entry.mode;
 			}
 			else {
-				sha1_i = NULL;
+				oid_i = &null_oid;
 				mode_i = 0;
 			}
 
 			p->parent[i].mode = mode_i;
-			hashcpy(p->parent[i].oid.hash, sha1_i ? sha1_i : null_sha1);
+			oidcpy(&p->parent[i].oid, oid_i);
 		}
 
 		keep = 1;
@@ -273,21 +274,20 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 	}
 
 	if (recurse) {
-		const unsigned char **parents_sha1;
+		const struct object_id **parents_oid;
 
-		FAST_ARRAY_ALLOC(parents_sha1, nparent);
+		FAST_ARRAY_ALLOC(parents_oid, nparent);
 		for (i = 0; i < nparent; ++i) {
 			/* same rule as in emitthis */
 			int tpi_valid = tp && !(tp[i].entry.mode & S_IFXMIN_NEQ);
 
-			parents_sha1[i] = tpi_valid ? tp[i].entry.oid->hash
-						    : NULL;
+			parents_oid[i] = tpi_valid ? tp[i].entry.oid : NULL;
 		}
 
 		strbuf_add(base, path, pathlen);
 		strbuf_addch(base, '/');
-		p = ll_diff_tree_paths(p, sha1, parents_sha1, nparent, base, opt);
-		FAST_ARRAY_FREE(parents_sha1, nparent);
+		p = ll_diff_tree_paths(p, oid, parents_oid, nparent, base, opt);
+		FAST_ARRAY_FREE(parents_oid, nparent);
 	}
 
 	strbuf_setlen(base, old_baselen);
@@ -312,7 +312,7 @@ static void skip_uninteresting(struct tree_desc *t, struct strbuf *base,
 
 
 /*
- * generate paths for combined diff D(sha1,parents_sha1[])
+ * generate paths for combined diff D(sha1,parents_oid[])
  *
  * Resulting paths are appended to combine_diff_path linked list, and also, are
  * emitted on the go via opt->pathchange() callback, so it is possible to
@@ -404,8 +404,8 @@ static inline void update_tp_entries(struct tree_desc *tp, int nparent)
 }
 
 static struct combine_diff_path *ll_diff_tree_paths(
-	struct combine_diff_path *p, const unsigned char *sha1,
-	const unsigned char **parents_sha1, int nparent,
+	struct combine_diff_path *p, const struct object_id *oid,
+	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt)
 {
 	struct tree_desc t, *tp;
@@ -422,8 +422,8 @@ static struct combine_diff_path *ll_diff_tree_paths(
 	 *   diff_tree_oid(parent, commit) )
 	 */
 	for (i = 0; i < nparent; ++i)
-		tptree[i] = fill_tree_descriptor(&tp[i], parents_sha1[i]);
-	ttree = fill_tree_descriptor(&t, sha1);
+		tptree[i] = fill_tree_descriptor(&tp[i], parents_oid[i]->hash);
+	ttree = fill_tree_descriptor(&t, oid->hash);
 
 	/* Enable recursion indefinitely */
 	opt->pathspec.recursive = DIFF_OPT_TST(opt, RECURSIVE);
@@ -548,11 +548,11 @@ static struct combine_diff_path *ll_diff_tree_paths(
 }
 
 struct combine_diff_path *diff_tree_paths(
-	struct combine_diff_path *p, const unsigned char *sha1,
-	const unsigned char **parents_sha1, int nparent,
+	struct combine_diff_path *p, const struct object_id *oid,
+	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt)
 {
-	p = ll_diff_tree_paths(p, sha1, parents_sha1, nparent, base, opt);
+	p = ll_diff_tree_paths(p, oid, parents_oid, nparent, base, opt);
 
 	/*
 	 * free pre-allocated last element, if any
@@ -617,7 +617,7 @@ static void try_to_follow_renames(const struct object_id *old_oid,
 	diff_opts.break_opt = opt->break_opt;
 	diff_opts.rename_score = opt->rename_score;
 	diff_setup_done(&diff_opts);
-	ll_diff_tree_sha1(old_oid->hash, new_oid->hash, base, &diff_opts);
+	ll_diff_tree_oid(old_oid, new_oid, base, &diff_opts);
 	diffcore_std(&diff_opts);
 	clear_pathspec(&diff_opts.pathspec);
 
@@ -676,15 +676,16 @@ static void try_to_follow_renames(const struct object_id *old_oid,
 	q->nr = 1;
 }
 
-static int ll_diff_tree_sha1(const unsigned char *old, const unsigned char *new,
-			     struct strbuf *base, struct diff_options *opt)
+static int ll_diff_tree_oid(const struct object_id *old_oid,
+			    const struct object_id *new_oid,
+			    struct strbuf *base, struct diff_options *opt)
 {
 	struct combine_diff_path phead, *p;
 	pathchange_fn_t pathchange_old = opt->pathchange;
 
 	phead.next = NULL;
 	opt->pathchange = emit_diff_first_parent_only;
-	diff_tree_paths(&phead, new, &old, 1, base, opt);
+	diff_tree_paths(&phead, new_oid, &old_oid, 1, base, opt);
 
 	for (p = phead.next; p;) {
 		struct combine_diff_path *pprev = p;
@@ -706,7 +707,7 @@ int diff_tree_oid(const struct object_id *old_oid,
 	strbuf_init(&base, PATH_MAX);
 	strbuf_addstr(&base, base_str);
 
-	retval = ll_diff_tree_sha1(old_oid->hash, new_oid->hash, &base, opt);
+	retval = ll_diff_tree_oid(old_oid, new_oid, &base, opt);
 	if (!*base_str && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename())
 		try_to_follow_renames(old_oid, new_oid, &base, opt);
 
-- 
2.13.0.219.gdb65acc882-goog

