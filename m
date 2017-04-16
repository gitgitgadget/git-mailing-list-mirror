Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBF4B20A04
	for <e@80x24.org>; Sun, 16 Apr 2017 06:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755275AbdDPGmw (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 02:42:52 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:60163 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755249AbdDPGmu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 02:42:50 -0400
X-AuditID: 1207440e-ccbff7000000340b-39-58f312684a85
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id EF.CE.13323.86213F85; Sun, 16 Apr 2017 02:42:48 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G6gGND025813
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 02:42:46 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 12/20] ref-cache: use a callback function to fill the cache
Date:   Sun, 16 Apr 2017 08:41:34 +0200
Message-Id: <2e1a785f6a6227eb99af0e60d12ecaa0af63e1fb.1492323985.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1492323985.git.mhagger@alum.mit.edu>
References: <cover.1492323985.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsUixO6iqJsh9DnCYMY0XYu1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfG+aYtTAVHtCo2L/7A2sD4RamLkZNDQsBE
        4tGT6WxdjFwcQgI7mCQevLrFDOGcYJL4cOgYO0gVm4CuxKKeZiYQW0RATWJi2yEWkCJmgcdM
        En+XdbOAJIQF/CReP/zMCmKzCKhKHOi5ANbMKxAl8X/HHRaIdfISu9ougtVwClhITLm7ASwu
        JGAusf34VeYJjDwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuka6+VmluilppRuYoQEG98O
        xvb1MocYBTgYlXh4Lfw/RQixJpYVV+YeYpTkYFIS5ZX5DxTiS8pPqcxILM6ILyrNSS0+xCjB
        wawkwpvM8jlCiDclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwXtDEKhR
        sCg1PbUiLTOnBCHNxMEJMpwHaHg6SA1vcUFibnFmOkT+FKOilDjvDwGghABIIqM0D64Xlgxe
        MYoDvSLMywzSzgNMJHDdr4AGMwENZpj8AWRwSSJCSqqBUbSTSU9AYP4Lvc0c5nf2K5RMPRi3
        UmXBi3sa8zIS6idrpZ7K8mVesU6eXVwh+r3yhYzevdNs5N7LfClZf3zq1sWvRI0+LXm95ONU
        A1v3T4rdh/KWnubxuBJ375TlKqeX4YnCvnfvLnmhdlIyeP/LTPevdQfFi5YJ9ZR0iVpFfDuu
        ZB36c8tbdSWW4oxEQy3mouJEAC77yZPhAgAA
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
index 1ed3a30d82..ff9251b9cd 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -386,7 +386,7 @@ static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *ref
 
 		refs->packed = xcalloc(1, sizeof(*refs->packed));
 		acquire_packed_ref_cache(refs->packed);
-		refs->packed->cache = create_ref_cache(refs);
+		refs->packed->cache = create_ref_cache(&refs->base, NULL);
 		refs->packed->cache->root->flag &= ~REF_INCOMPLETE;
 		f = fopen(packed_refs_file, "r");
 		if (f) {
@@ -430,9 +430,11 @@ static void add_packed_ref(struct files_ref_store *refs,
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
@@ -515,7 +517,7 @@ static struct ref_dir *get_loose_refs(struct files_ref_store *refs)
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

