Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF0B21FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 14:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933240AbdCaOMA (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 10:12:00 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50442 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933214AbdCaOL6 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 Mar 2017 10:11:58 -0400
X-AuditID: 1207440c-abdff70000002e8f-af-58de63a95617
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 01.D9.11919.9A36ED85; Fri, 31 Mar 2017 10:11:53 -0400 (EDT)
Received: from bagpipes.fritz.box (p4FEDFA60.dip0.t-ipconnect.de [79.237.250.96])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2VEBRBr010139
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 31 Mar 2017 10:11:51 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 12/20] ref-cache: use a callback function to fill the cache
Date:   Fri, 31 Mar 2017 16:11:10 +0200
Message-Id: <b5754fdf848f4b924cc3d682c854ea4fea723016.1490966385.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490966385.git.mhagger@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsUixO6iqLsy+V6EwfwWPYu1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfGlSNPmQuOaFU8/f+VtYHxi1IXIyeHhICJ
        xPQXi1lAbCGBHUwSuycrdDFyAdknmSSOPZ3LBJJgE9CVWNTTDGaLCKhJTGw7xAJSxCzwhkni
        wJZfYN3CAn4S9/7NZwaxWQRUJbZsvM8KYvMKREm0/P7PBrFNXmJX20WwOKeAhcS6mYfYITab
        SyxYO4FtAiPPAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6hnq5mSV6qSmlmxghocazg/Hb
        OplDjAIcjEo8vCe870UIsSaWFVfmHmKU5GBSEuX1DQcK8SXlp1RmJBZnxBeV5qQWH2KU4GBW
        EuFligPK8aYkVlalFuXDpKQ5WJTEeVWXqPsJCaQnlqRmp6YWpBbBZGU4OJQkeCuSgBoFi1LT
        UyvSMnNKENJMHJwgw3mAhqeA1PAWFyTmFmemQ+RPMSpKifOygiQEQBIZpXlwvbBU8IpRHOgV
        YV4vkCoeYBqB634FNJgJaLDF17sgg0sSEVJSDYzdxw2uv50l/L0ye7P3J/azwsdO37jBKLGs
        yl6gZNaDhNcnTL4wiGx50nUn63dN0dKnK4U/sZtWsV/wvr7NrFLMP+/r/M6iniKBdOuXK/f6
        vwkRb9nNK2pf5+dhXSIgwfhhvdivq4E/Dgv0SbJprOUsMH6Vdtm95ppFSo9aYwmTj2xsqKiF
        jRJLcUaioRZzUXEiAGPFGV3gAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is a leveling violation for `ref_cache` to know about
`files_ref_store` or that it should call `read_loose_refs()` to lazily
fill cache directories. So instead, have its constructor take as an
argument a callback function that it should use for lazy-filling, and
change `files_ref_store` to supply a pointer to function
`read_loose_refs` (renamed to `loose_fill_ref_dir`) when creating the
ref cache for its loose refs.

This means that we can generify the type of the back-pointer in
`struct ref_cache` from `files_ref_store` to `ref_store`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 10 ++++++----
 refs/ref-cache.c     | 12 +++++++-----
 refs/ref-cache.h     | 29 +++++++++++++++++++++++++----
 3 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 78572e55a0..e4d78393ac 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -387,7 +387,7 @@ static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *ref
 
 		refs->packed = xcalloc(1, sizeof(*refs->packed));
 		acquire_packed_ref_cache(refs->packed);
-		refs->packed->cache = create_ref_cache(refs);
+		refs->packed->cache = create_ref_cache(&refs->base, NULL);
 		refs->packed->cache->root->flag &= ~REF_INCOMPLETE;
 		f = fopen(packed_refs_file, "r");
 		if (f) {
@@ -431,9 +431,11 @@ static void add_packed_ref(struct files_ref_store *refs,
  * (without recursing).  dirname must end with '/'.  dir must be the
  * directory entry corresponding to dirname.
  */
-void read_loose_refs(const char *dirname, struct ref_dir *dir)
+static void loose_fill_ref_dir(struct ref_store *ref_store,
+			       struct ref_dir *dir, const char *dirname)
 {
-	struct files_ref_store *refs = dir->cache->ref_store;
+	struct files_ref_store *refs =
+		files_downcast(ref_store, REF_STORE_READ, "fill_ref_dir");
 	DIR *d;
 	struct dirent *de;
 	int dirnamelen = strlen(dirname);
@@ -516,7 +518,7 @@ static struct ref_dir *get_loose_refs(struct files_ref_store *refs)
 		 * are about to read the only subdirectory that can
 		 * hold references:
 		 */
-		refs->loose = create_ref_cache(refs);
+		refs->loose = create_ref_cache(&refs->base, loose_fill_ref_dir);
 
 		/* We're going to fill the top level ourselves: */
 		refs->loose->root->flag &= ~REF_INCOMPLETE;
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 96da094788..7f247b9170 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -4,9 +4,6 @@
 #include "ref-cache.h"
 #include "../iterator.h"
 
-/* FIXME: This declaration shouldn't be here */
-void read_loose_refs(const char *dirname, struct ref_dir *dir);
-
 void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry)
 {
 	ALLOC_GROW(dir->entries, dir->nr + 1, dir->alloc);
@@ -25,7 +22,10 @@ struct ref_dir *get_ref_dir(struct ref_entry *entry)
 	assert(entry->flag & REF_DIR);
 	dir = &entry->u.subdir;
 	if (entry->flag & REF_INCOMPLETE) {
-		read_loose_refs(entry->name, dir);
+		if (!dir->cache->fill_ref_dir)
+			die("BUG: incomplete ref_store without fill_ref_dir function");
+
+		dir->cache->fill_ref_dir(dir->cache->ref_store, dir, entry->name);
 
 		/*
 		 * Manually add refs/bisect, which, being
@@ -63,11 +63,13 @@ struct ref_entry *create_ref_entry(const char *refname,
 	return ref;
 }
 
-struct ref_cache *create_ref_cache(struct files_ref_store *refs)
+struct ref_cache *create_ref_cache(struct ref_store *refs,
+				   fill_ref_dir_fn *fill_ref_dir)
 {
 	struct ref_cache *ret = xcalloc(1, sizeof(*ret));
 
 	ret->ref_store = refs;
+	ret->fill_ref_dir = fill_ref_dir;
 	ret->root = create_dir_entry(ret, "", 0, 1);
 	return ret;
 }
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index 83051854ff..ed51e80d88 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -1,11 +1,27 @@
 #ifndef REFS_REF_CACHE_H
 #define REFS_REF_CACHE_H
 
+struct ref_dir;
+
+/*
+ * If this ref_cache is filled lazily, this function is used to load
+ * information into the specified ref_dir (shallow or deep, at the
+ * option of the ref_store). dirname includes a trailing slash.
+ */
+typedef void fill_ref_dir_fn(struct ref_store *ref_store,
+			     struct ref_dir *dir, const char *dirname);
+
 struct ref_cache {
 	struct ref_entry *root;
 
-	/* A pointer to the files_ref_store whose cache this is: */
-	struct files_ref_store *ref_store;
+	/* A pointer to the ref_store whose cache this is: */
+	struct ref_store *ref_store;
+
+	/*
+	 * Function used (if necessary) to lazily-fill cache. May be
+	 * NULL.
+	 */
+	fill_ref_dir_fn *fill_ref_dir;
 };
 
 /*
@@ -174,9 +190,14 @@ struct ref_entry *create_ref_entry(const char *refname,
 
 /*
  * Return a pointer to a new `ref_cache`. Its top-level starts out
- * marked incomplete.
+ * marked incomplete. If `fill_ref_dir` is non-NULL, it is the
+ * function called to fill in incomplete directories in the
+ * `ref_cache` when they are accessed. If it is NULL, then the whole
+ * `ref_cache` must be filled (including clearing its directories'
+ * `REF_INCOMPLETE` bits) before it is used.
  */
-struct ref_cache *create_ref_cache(struct files_ref_store *refs);
+struct ref_cache *create_ref_cache(struct ref_store *refs,
+				   fill_ref_dir_fn *fill_ref_dir);
 
 /*
  * Free the `ref_cache` and all of its associated data.
-- 
2.11.0

