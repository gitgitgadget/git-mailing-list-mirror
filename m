Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39F96201CF
	for <e@80x24.org>; Thu, 18 May 2017 23:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754846AbdERXWY (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:22:24 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35655 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752689AbdERXWR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:17 -0400
Received: by mail-pf0-f180.google.com with SMTP id n23so30735172pfb.2
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5B0i5ihLV9h3MIwEH4Q10SlqVs9apQ3UoRuBYJnL8fE=;
        b=m3iBSjPUXs4KRVhIltJUid0GGnHaxXm2wV70MCEySr1DrOylysa7bSqScM5DJBbAHG
         CzXtjrmREb6KIMwGQlkgYU9jxFpDJ6zjXQ2qyOA6BdCd6kPKVABJ6ADaPxAqQ0yWYrAJ
         Tk1f+ptEd9nCc6qTH/1Zt8wzNwH8CdxmvWSbNRHiSL722H3VrYUanvMB+fi93pjONQCW
         KDabeDmxSf1H6Ta2sIoFSCRfb0KW2xStmi2EgaH45QGQ+KsFKDDHnE3JAuaDcQQNtJoQ
         FLfPxHXlBS52nXbZ6GKcZ/HOgR5ReMnz4xrA6Z6GYJR6dDTuUN26dWBiPhwOPdQ0KJ9o
         xDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5B0i5ihLV9h3MIwEH4Q10SlqVs9apQ3UoRuBYJnL8fE=;
        b=lOvSs5PAa8JoOFlTQj8EK2kDN66cv6GAgDFKZrM4Fq1wUNwGm86ZJmaKip9mfZF1e/
         QsT9vcKs5h9EES7IJNI5Gx5T6RgJvTT+5d8pQvLhZx74U9uAk4EnPh1h6S0aDxKCc2mA
         j/vUQFp7BPZOqH721pVuTeclY0cNzVcFbkJIBTwveGE6smDCe0nGVPbxKCWrf9DfoVGK
         BYSPo5cYYJsZmgPfHI1Un1o/gqhjrNu+/MWeycwE6cH5pLh/GCjsKxJhdfTpHl6TjFNG
         YQFemeJDjZpw6RTR8WTd205cNAZTYzb+pXf+lk1rHkPDRlz+mToYo/FV2i1/avngXWNK
         qWUg==
X-Gm-Message-State: AODbwcBCxU0hDoeQAWBCU4n+Z/7URqSCdhNakVWkRVeHxZIR+YD0XCxK
        IpuvdoGVRgymGc2c
X-Received: by 10.84.237.1 with SMTP id s1mr7755153plk.157.1495149736190;
        Thu, 18 May 2017 16:22:16 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:15 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 06/23] tree: convert read_tree to take an index parameter
Date:   Thu, 18 May 2017 16:21:17 -0700
Message-Id: <20170518232134.163059-7-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
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
index 770d8774a..a4ced5a9c 100644
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
index ce345c551..cb5d40320 100644
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
index d24786cba..99f5b7ec1 100644
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
2.13.0.303.g4ebf302169-goog

