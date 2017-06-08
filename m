Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B22D1FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751703AbdFHXlx (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:41:53 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35361 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbdFHXlu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:41:50 -0400
Received: by mail-pg0-f50.google.com with SMTP id k71so20708893pgd.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hT+LGYajv6PiZLmqdTR+kSIwPZZWEdDt8yntshxmQtE=;
        b=p4865Jz1zxrkCgs7gIjIhg1WSrZ0o5jGjs5mJkBNL2PUIzaRncyEkYY09XA+1pUdEx
         ObTaYxQpuWGTSY3xfb6a/PIP6l/EVd4gltAWmdK6S4uN1qqM7g3IYedNUMVs6PKdVAu7
         9vNU0Q+0L8a47NzjbUngOy1/avp8v8sDusFbnbFYVVGcv/3hgACjiigvo+xjGnds79Dv
         1cG77m1o644osxucRxN9Cj5h5buMXunw21ATWsQo7V9Ku1xegj0E8V0WZOFk07qZer1P
         NfAre86aUvyRspT/xDICr/OsJ8FlgGdGsPAWb5rxnufRTfUsAscKdVzqZUX1gBOurQ4C
         KQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hT+LGYajv6PiZLmqdTR+kSIwPZZWEdDt8yntshxmQtE=;
        b=RCUUT8FqOMRCV1Ot1XWctUK+Jh4iiRonVldORWt/CwIayVYlxOAUPZ9HyhPAjnTpZv
         0vatQJNpRMaiQNUZpsDDy2yE5O3NZ6R7BZIPnTc1ev/+1ia9Dr+qEKgdjSSoznA8xbp0
         3bJjYT576NJUVBFSjtou4SOcsByr+SzPeDlzod71rMZqhTYf8Xpyws0AazDvtrLZRQ6q
         JTqGHMIYPSDdYE4Fls0rhLeyWoC9rRXnxBr0PZ/QP/TaPb6+HC1rGA7k1DUuNOsDrHiB
         s5uQQI5E6zwACopMp5VDQx+OBrudaRwjbb6yeDxXXHGYk90S6exQkJCuGyf8ecqpDF2c
         wzhw==
X-Gm-Message-State: AODbwcAxUDAx6jbAdXlWyKcsUwTCxXColU4HFFshDnZZke4PtPe7JqKy
        j2asYfPZZfcVkF5spjifhw==
X-Received: by 10.84.133.162 with SMTP id f31mr1821876plf.83.1496965309440;
        Thu, 08 Jun 2017 16:41:49 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:48 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 21/32] tree: convert read_tree to take an index parameter
Date:   Thu,  8 Jun 2017 16:40:49 -0700
Message-Id: <20170608234100.188529-22-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
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
2.13.1.508.gb3defc5cc-goog

