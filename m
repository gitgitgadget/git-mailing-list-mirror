Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBAB11FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751256AbdEaVpW (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:45:22 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35289 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbdEaVpK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:45:10 -0400
Received: by mail-pf0-f175.google.com with SMTP id n23so18565572pfb.2
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7L1IfB28vMwwS9Fm/CxB0bYsMg3zWRALUZNt6wRuZtI=;
        b=MR5SYmDU2jnovYOV94TPNjdwKWvOH5iWtl5r7ppwB7ANSNG9UqSQZYds3rjUiKGOL1
         vyJMJ/FDz5WcfIzXWvrZJRKX36lESxWKIaik5U3jkxUocrlKA8hKa3IelzeOAYjWc1Ln
         dAP7RDIwjgX1efyDVtSlgyN4Q9/03c5QFGoxjGXELECgPtDU/QlNjR7tKB3J8ZQRym45
         miKkkRhKwdGB5XT//OSkSgLRY+wYkrCLI+Ki5e/KN1wYJfqdA50q/QTBHcezImvJ/MbJ
         qXPQqNf/lNrPeR/qC/KX8KPkuzoCdf3qnXQqZfLb+2i6SyXnkbB36/CSwyOlsqnangvb
         oFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7L1IfB28vMwwS9Fm/CxB0bYsMg3zWRALUZNt6wRuZtI=;
        b=aJQ22QGILFpGAZe1vXsU85zjidcohEkvWKTeSGKxxY/JXZeU+87O1QAFly3wlG41yI
         +qULM/ol2z5y35it5TxfjQWUxE8SzZ8vfTWTJ2TlgWBguOHnl+zjyuz9Hv0gzeeAvQHP
         zC4QLGnBs7YkY/zRPvXXbgV34YEMMCs9GBW2Yu9d+Scc1gyUoWwlKm0iPQIO0O8uBig/
         Baox8wXJcIIbP1WcOtTZRLIgHKSAaP5H8I0s6V2Fnj5hM4rvHvfxpo88WAW/qheNdpTH
         Tq/S0wTOn1jVv7/NgdgHpMKx65/xEwHCu7jV9sb5hzRddCyypJWCmCQw/7hNLnWCDZqA
         qSvA==
X-Gm-Message-State: AODbwcC92VS1tEA7DZou9/UcLFkxzHXdR8i3KevWIKmCaZjNMQ8IN/UA
        zdd8zWix9IQDXxBnBTnqkQ==
X-Received: by 10.98.194.66 with SMTP id l63mr32711397pfg.234.1496267104317;
        Wed, 31 May 2017 14:45:04 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:45:03 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 20/31] tree: convert read_tree to take an index parameter
Date:   Wed, 31 May 2017 14:44:06 -0700
Message-Id: <20170531214417.38857-21-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
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
index f16ce0053..620487a77 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -461,7 +461,7 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
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
2.13.0.506.g27d5fe0cd-goog

