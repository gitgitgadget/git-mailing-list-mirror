Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4930F20401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753072AbdFLWPR (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:15:17 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36231 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752661AbdFLWOd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:14:33 -0400
Received: by mail-pg0-f48.google.com with SMTP id a70so50758377pge.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 15:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X9ELGl8tZXsLhxwMbItZEXPAsnUMYOUwAqxedoHlc2s=;
        b=X1V0bN8lilidQYvGPyW07jSwfnsNUe3RJGaZ8+6fYrOQ2dgOrNQi7a3Tg026z4lslM
         3fd0puyN5338b1RgIUt3UP+KURrzmurqYsL0RvLycRrGOQKv+0RECFWBrLj/TCRrOUr1
         1fTmovWoXt6YmeeHf6G11I282bBoZXPP2rlxZ8pj0IWzc1Al2LW8pBbTpHXLBA6oC6AD
         AvArYKCZi2U5b9tgZFTsqDyYbksEHp7kuHxII3wdg9/dI77Xc1U/Pc9WxjBgxXa6CF5t
         7Sie2/NeWQw9687Fuf/pfGAzsqAw//ZBq/RkbA7U/+iqKpS5dWsE0HFwMDnjeyCpp87d
         xjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X9ELGl8tZXsLhxwMbItZEXPAsnUMYOUwAqxedoHlc2s=;
        b=YrcdMmj8WN7qCbQ68Xe4PgB85+mtRGCz0EilX2vRB88Ki1X/VUEOldFltHchYZhNDC
         DzfOGSKwLIMSni3IunzOXp9YKZl9mBsug9t+N5wUjbodwhFv/KUCT5sgwLAF9ebT8XOb
         MR3BLfHgTtutJY2pG4mn2CLDfYBTPIXdEvnm2ajPjgHxxV7rkHVcdT2reKojbK5X1q6w
         bWm8aEP+cIWNUFbgSMfD4VKEvrUHr4QxEO8Bhtw9W3AMfIwsMkTnbEKXePb3PY8ai6ZD
         hWuVZ5ikqsl7R8hP3TA1sQ3rcZY4NadeqxxqqMKdksfZGV4YjnV3B7NCKRMJvqFDET2G
         JP9Q==
X-Gm-Message-State: AODbwcBP4p8fubBJ1Ur72UpTuq32xM99r5gixi+uawz9mSqpw732xfuP
        dvyRBTUx8lydz8AGwSfRiQ==
X-Received: by 10.84.215.23 with SMTP id k23mr59626986pli.104.1497305666920;
        Mon, 12 Jun 2017 15:14:26 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id i68sm22403884pfi.72.2017.06.12.15.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 15:14:26 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 06/17] tree: convert read_tree to take an index parameter
Date:   Mon, 12 Jun 2017 15:13:57 -0700
Message-Id: <20170612221408.173876-7-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170612221408.173876-1-bmwill@google.com>
References: <20170612221408.173876-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c |  2 +-
 tree.c             | 28 ++++++++++++++++++----------
 tree.h             |  3 ++-
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 0044abf66..93e46ab5f 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -460,7 +460,7 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
 			       PATHSPEC_PREFER_CWD, prefix, matchbuf);
 	} else
 		memset(&pathspec, 0, sizeof(pathspec));
-	if (read_tree(tree, 1, &pathspec))
+	if (read_tree(tree, 1, &pathspec, &the_index))
 		die("unable to read tree entries %s", tree_name);
 
 	for (i = 0; i < active_nr; i++) {
diff --git a/tree.c b/tree.c
index 603b29ee8..dd69423d9 100644
--- a/tree.c
+++ b/tree.c
@@ -1,3 +1,4 @@
+#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "cache-tree.h"
 #include "tree.h"
@@ -8,7 +9,11 @@
 
 const char *tree_type = "tree";
 
-static int read_one_entry_opt(const unsigned char *sha1, const char *base, int baselen, const char *pathname, unsigned mode, int stage, int opt)
+static int read_one_entry_opt(struct index_state *istate,
+			      const unsigned char *sha1,
+			      const char *base, int baselen,
+			      const char *pathname,
+			      unsigned mode, int stage, int opt)
 {
 	int len;
 	unsigned int size;
@@ -27,14 +32,15 @@ static int read_one_entry_opt(const unsigned char *sha1, const char *base, int b
 	memcpy(ce->name, base, baselen);
 	memcpy(ce->name + baselen, pathname, len+1);
 	hashcpy(ce->oid.hash, sha1);
-	return add_cache_entry(ce, opt);
+	return add_index_entry(istate, ce, opt);
 }
 
 static int read_one_entry(const unsigned char *sha1, struct strbuf *base,
 			  const char *pathname, unsigned mode, int stage,
 			  void *context)
 {
-	return read_one_entry_opt(sha1, base->buf, base->len, pathname,
+	struct index_state *istate = context;
+	return read_one_entry_opt(istate, sha1, base->buf, base->len, pathname,
 				  mode, stage,
 				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
 }
@@ -47,7 +53,8 @@ static int read_one_entry_quick(const unsigned char *sha1, struct strbuf *base,
 				const char *pathname, unsigned mode, int stage,
 				void *context)
 {
-	return read_one_entry_opt(sha1, base->buf, base->len, pathname,
+	struct index_state *istate = context;
+	return read_one_entry_opt(istate, sha1, base->buf, base->len, pathname,
 				  mode, stage,
 				  ADD_CACHE_JUST_APPEND);
 }
@@ -144,7 +151,8 @@ static int cmp_cache_name_compare(const void *a_, const void *b_)
 				  ce2->name, ce2->ce_namelen, ce_stage(ce2));
 }
 
-int read_tree(struct tree *tree, int stage, struct pathspec *match)
+int read_tree(struct tree *tree, int stage, struct pathspec *match,
+	      struct index_state *istate)
 {
 	read_tree_fn_t fn = NULL;
 	int i, err;
@@ -164,23 +172,23 @@ int read_tree(struct tree *tree, int stage, struct pathspec *match)
 	 * do it the original slow way, otherwise, append and then
 	 * sort at the end.
 	 */
-	for (i = 0; !fn && i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
+	for (i = 0; !fn && i < istate->cache_nr; i++) {
+		const struct cache_entry *ce = istate->cache[i];
 		if (ce_stage(ce) == stage)
 			fn = read_one_entry;
 	}
 
 	if (!fn)
 		fn = read_one_entry_quick;
-	err = read_tree_recursive(tree, "", 0, stage, match, fn, NULL);
+	err = read_tree_recursive(tree, "", 0, stage, match, fn, istate);
 	if (fn == read_one_entry || err)
 		return err;
 
 	/*
 	 * Sort the cache entry -- we need to nuke the cache tree, though.
 	 */
-	cache_tree_free(&active_cache_tree);
-	QSORT(active_cache, active_nr, cmp_cache_name_compare);
+	cache_tree_free(&istate->cache_tree);
+	QSORT(istate->cache, istate->cache_nr, cmp_cache_name_compare);
 	return 0;
 }
 
diff --git a/tree.h b/tree.h
index 0d4734b94..744e6dc2a 100644
--- a/tree.h
+++ b/tree.h
@@ -34,6 +34,7 @@ extern int read_tree_recursive(struct tree *tree,
 			       int stage, const struct pathspec *pathspec,
 			       read_tree_fn_t fn, void *context);
 
-extern int read_tree(struct tree *tree, int stage, struct pathspec *pathspec);
+extern int read_tree(struct tree *tree, int stage, struct pathspec *pathspec,
+		     struct index_state *istate);
 
 #endif /* TREE_H */
-- 
2.13.1.518.g3df882009-goog

