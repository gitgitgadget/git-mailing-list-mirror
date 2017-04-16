Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7C3920A04
	for <e@80x24.org>; Sun, 16 Apr 2017 06:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755204AbdDPGmr (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 02:42:47 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56017 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755111AbdDPGmq (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 02:42:46 -0400
X-AuditID: 12074413-f4fff700000077e1-c2-58f312648c83
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 56.87.30689.46213F85; Sun, 16 Apr 2017 02:42:44 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G6gGNB025813
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 02:42:42 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 10/20] ref-cache: introduce a new type, ref_cache
Date:   Sun, 16 Apr 2017 08:41:32 +0200
Message-Id: <69eee1c3bfc7d090630199c7ef5ea69184e7c405.1492323985.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1492323985.git.mhagger@alum.mit.edu>
References: <cover.1492323985.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsUixO6iqJsi9DnCYPpaFYu1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfGq9/32Qr2aFUsWlrTwPhOqYuRk0NCwERi
        36xmxi5GLg4hgR1MEmv/HoFyTjBJLN72nR2kik1AV2JRTzMTiC0ioCYxse0QC0gRs8BjJom/
        y7pZQBLCAi4SjT132UBsFgFViXl9p8AaeAWiJKZsfsgIsU5eYlfbRVYQm1PAQmLK3Q1gvUIC
        5hLbj19lnsDIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrrlebmaJXmpK6SZGSKgJ72Dc
        dVLuEKMAB6MSD6+F/6cIIdbEsuLK3EOMkhxMSqK8Mv+BQnxJ+SmVGYnFGfFFpTmpxYcYJTiY
        lUR4k1k+RwjxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4owWBGgWL
        UtNTK9Iyc0oQ0kwcnCDDeYCGp4PU8BYXJOYWZ6ZD5E8xKkqJ8/4QAEoIgCQySvPgemGp4BWj
        ONArwry1IO08wDQC1/0KaDAT0GCGyR9ABpckIqSkGhitNwiXPz3sd6bIY5HoaeWXZqkfJrIW
        JR85rLFyZ53A4bmX//LMzTspUSCwN+bsoVsLO+as1Vj/TSZURkv9vs/X3bUL1yXuruld+03L
        L7K00Unn0L9VovM25K9YMkXaQU12nv/8HT6v02xW7Ss9/l/gre+kuifLmvP5NgnGWf8STp19
        vKfBXk9ZiaU4I9FQi7moOBEAVMxR4uACAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For now, it just wraps a `ref_entry *` that points at the root of the
tree. Soon it will hold more information.

Add two new functions, `create_ref_cache()` and `free_ref_cache()`.
Make `free_ref_entry()` private.

Change files-backend to use this type to hold its caches.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 28 +++++++++++++++++-----------
 refs/ref-cache.c     | 16 +++++++++++++++-
 refs/ref-cache.h     | 15 ++++++++++++++-
 3 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index fcace124de..840a0869a0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -44,7 +44,7 @@ static int entry_resolves_to_object(struct ref_entry *entry)
 }
 
 struct packed_ref_cache {
-	struct ref_entry *root;
+	struct ref_cache *cache;
 
 	/*
 	 * Count of references to the data structure in this instance,
@@ -79,7 +79,7 @@ struct files_ref_store {
 	char *gitcommondir;
 	char *packed_refs_path;
 
-	struct ref_entry *loose;
+	struct ref_cache *loose;
 	struct packed_ref_cache *packed;
 };
 
@@ -101,7 +101,7 @@ static void acquire_packed_ref_cache(struct packed_ref_cache *packed_refs)
 static int release_packed_ref_cache(struct packed_ref_cache *packed_refs)
 {
 	if (!--packed_refs->referrers) {
-		free_ref_entry(packed_refs->root);
+		free_ref_cache(packed_refs->cache);
 		stat_validity_clear(&packed_refs->validity);
 		free(packed_refs);
 		return 1;
@@ -125,7 +125,7 @@ static void clear_packed_ref_cache(struct files_ref_store *refs)
 static void clear_loose_ref_cache(struct files_ref_store *refs)
 {
 	if (refs->loose) {
-		free_ref_entry(refs->loose);
+		free_ref_cache(refs->loose);
 		refs->loose = NULL;
 	}
 }
@@ -386,11 +386,12 @@ static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *ref
 
 		refs->packed = xcalloc(1, sizeof(*refs->packed));
 		acquire_packed_ref_cache(refs->packed);
-		refs->packed->root = create_dir_entry(refs, "", 0, 0);
+		refs->packed->cache = create_ref_cache(refs);
+		refs->packed->cache->root->flag &= ~REF_INCOMPLETE;
 		f = fopen(packed_refs_file, "r");
 		if (f) {
 			stat_validity_update(&refs->packed->validity, fileno(f));
-			read_packed_refs(f, get_ref_dir(refs->packed->root));
+			read_packed_refs(f, get_ref_dir(refs->packed->cache->root));
 			fclose(f);
 		}
 	}
@@ -399,7 +400,7 @@ static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *ref
 
 static struct ref_dir *get_packed_ref_dir(struct packed_ref_cache *packed_ref_cache)
 {
-	return get_ref_dir(packed_ref_cache->root);
+	return get_ref_dir(packed_ref_cache->cache->root);
 }
 
 static struct ref_dir *get_packed_refs(struct files_ref_store *refs)
@@ -514,14 +515,19 @@ static struct ref_dir *get_loose_refs(struct files_ref_store *refs)
 		 * are about to read the only subdirectory that can
 		 * hold references:
 		 */
-		refs->loose = create_dir_entry(refs, "", 0, 0);
+		refs->loose = create_ref_cache(refs);
+
+		/* We're going to fill the top level ourselves: */
+		refs->loose->root->flag &= ~REF_INCOMPLETE;
+
 		/*
-		 * Create an incomplete entry for "refs/":
+		 * Add an incomplete entry for "refs/" (to be filled
+		 * lazily):
 		 */
-		add_entry_to_dir(get_ref_dir(refs->loose),
+		add_entry_to_dir(get_ref_dir(refs->loose->root),
 				 create_dir_entry(refs, "refs/", 5, 1));
 	}
-	return get_ref_dir(refs->loose);
+	return get_ref_dir(refs->loose->root);
 }
 
 /*
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 4274a43a9b..bf911028c8 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -63,9 +63,17 @@ struct ref_entry *create_ref_entry(const char *refname,
 	return ref;
 }
 
+struct ref_cache *create_ref_cache(struct files_ref_store *refs)
+{
+	struct ref_cache *ret = xcalloc(1, sizeof(*ret));
+
+	ret->root = create_dir_entry(refs, "", 0, 1);
+	return ret;
+}
+
 static void clear_ref_dir(struct ref_dir *dir);
 
-void free_ref_entry(struct ref_entry *entry)
+static void free_ref_entry(struct ref_entry *entry)
 {
 	if (entry->flag & REF_DIR) {
 		/*
@@ -77,6 +85,12 @@ void free_ref_entry(struct ref_entry *entry)
 	free(entry);
 }
 
+void free_ref_cache(struct ref_cache *cache)
+{
+	free_ref_entry(cache->root);
+	free(cache);
+}
+
 /*
  * Clear and free all entries in dir, recursively.
  */
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index 2e7b1a366e..da5388c136 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -1,6 +1,10 @@
 #ifndef REFS_REF_CACHE_H
 #define REFS_REF_CACHE_H
 
+struct ref_cache {
+	struct ref_entry *root;
+};
+
 /*
  * Information used (along with the information in ref_entry) to
  * describe a single cached reference.  This data structure only
@@ -165,7 +169,16 @@ struct ref_entry *create_ref_entry(const char *refname,
 				   const unsigned char *sha1, int flag,
 				   int check_name);
 
-void free_ref_entry(struct ref_entry *entry);
+/*
+ * Return a pointer to a new `ref_cache`. Its top-level starts out
+ * marked incomplete.
+ */
+struct ref_cache *create_ref_cache(struct files_ref_store *refs);
+
+/*
+ * Free the `ref_cache` and all of its associated data.
+ */
+void free_ref_cache(struct ref_cache *cache);
 
 /*
  * Add a ref_entry to the end of dir (unsorted).  Entry is always
-- 
2.11.0

