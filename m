Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10A6520A04
	for <e@80x24.org>; Sun, 16 Apr 2017 06:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755524AbdDPGnH (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 02:43:07 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:42496 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755274AbdDPGmy (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 02:42:54 -0400
X-AuditID: 1207440c-abdff70000002e8f-f3-58f31266708d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 47.A0.11919.66213F85; Sun, 16 Apr 2017 02:42:46 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G6gGNC025813
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 02:42:44 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 11/20] refs: record the ref_store in ref_cache, not ref_dir
Date:   Sun, 16 Apr 2017 08:41:33 +0200
Message-Id: <b80277d29e0ae26e831d296c6b1d84b2d16feb42.1492323985.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1492323985.git.mhagger@alum.mit.edu>
References: <cover.1492323985.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsUixO6iqJsm9DnC4ON8A4u1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfGpfNZBY/UKmZdWszWwDhbvouRk0NCwERi
        6oQ9zF2MXBxCAjuYJC7s38cO4ZxgknjXd5gRpIpNQFdiUU8zE4gtIqAmMbHtEAtIEbPAYyaJ
        v8u6WUASwgJ+Ev9vN4E1sAioSmzYd5S1i5GDg1cgSqK7qwRim7zErraLrCA2p4CFxJS7G8Ba
        hQTMJbYfv8o8gZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdQ73czBK91JTSTYyQQOPZ
        wfhtncwhRgEORiUeXgv/TxFCrIllxZW5hxglOZiURHll/gOF+JLyUyozEosz4otKc1KLDzFK
        cDArifAms3yOEOJNSaysSi3Kh0lJc7AoifOqLlH3ExJITyxJzU5NLUgtgsnKcHAoSfBGCwI1
        ChalpqdWpGXmlCCkmTg4QYbzAA1PB6nhLS5IzC3OTIfIn2JUlBLn/SEAlBAASWSU5sH1whLB
        K0ZxoFeEebeCtPMAkwhc9yugwUxAgxkmfwAZXJKIkJJqYHQoz50l2hd9Umcze3KC25NU5xmr
        dlikfg/9OC1s5berpoKni1w6l8h1ubCwLNsz5+Le69vmnVM61daXuWTjt8+C2nLutxe3Sz9n
        3FQzMyKuQIx1l+5s2RtFJxO0H73IZzxTt2CR9dGODB5LqVRuuadqCfO3c57a/KqEraX16jNv
        7wdL9Vz+L1RiKc5INNRiLipOBAA29fYZ3wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of keeping a pointer to the `ref_store` in every `ref_dir`
entry, store it once in `struct ref_cache`, and change `struct
ref_dir` to include a pointer to its containing `ref_cache` instead.
This makes it easier to add to the information that is accessible from
a `ref_dir` without increasing the size of every `ref_dir` instance.

Note that previously, every `ref_dir` pointed at the containing
`files_ref_store` regardless of whether it was a part of the loose or
packed reference cache. Now we have to be sure to initialize the
instances to point at the correct containing `ref_cache`. So change
`create_dir_entry()` to take a `ref_cache` parameter, and change its
callers to pass the correct `ref_cache` depending on the purpose of
the new `dir_entry`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c |  6 +++---
 refs/ref-cache.c     | 12 +++++++-----
 refs/ref-cache.h     |  9 ++++++---
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 840a0869a0..1ed3a30d82 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -432,7 +432,7 @@ static void add_packed_ref(struct files_ref_store *refs,
  */
 void read_loose_refs(const char *dirname, struct ref_dir *dir)
 {
-	struct files_ref_store *refs = dir->ref_store;
+	struct files_ref_store *refs = dir->cache->ref_store;
 	DIR *d;
 	struct dirent *de;
 	int dirnamelen = strlen(dirname);
@@ -468,7 +468,7 @@ void read_loose_refs(const char *dirname, struct ref_dir *dir)
 		} else if (S_ISDIR(st.st_mode)) {
 			strbuf_addch(&refname, '/');
 			add_entry_to_dir(dir,
-					 create_dir_entry(refs, refname.buf,
+					 create_dir_entry(dir->cache, refname.buf,
 							  refname.len, 1));
 		} else {
 			if (!refs_resolve_ref_unsafe(&refs->base,
@@ -525,7 +525,7 @@ static struct ref_dir *get_loose_refs(struct files_ref_store *refs)
 		 * lazily):
 		 */
 		add_entry_to_dir(get_ref_dir(refs->loose->root),
-				 create_dir_entry(refs, "refs/", 5, 1));
+				 create_dir_entry(refs->loose, "refs/", 5, 1));
 	}
 	return get_ref_dir(refs->loose->root);
 }
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index bf911028c8..96da094788 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -36,7 +36,7 @@ struct ref_dir *get_ref_dir(struct ref_entry *entry)
 			int pos = search_ref_dir(dir, "refs/bisect/", 12);
 			if (pos < 0) {
 				struct ref_entry *child_entry;
-				child_entry = create_dir_entry(dir->ref_store,
+				child_entry = create_dir_entry(dir->cache,
 							       "refs/bisect/",
 							       12, 1);
 				add_entry_to_dir(dir, child_entry);
@@ -67,7 +67,8 @@ struct ref_cache *create_ref_cache(struct files_ref_store *refs)
 {
 	struct ref_cache *ret = xcalloc(1, sizeof(*ret));
 
-	ret->root = create_dir_entry(refs, "", 0, 1);
+	ret->ref_store = refs;
+	ret->root = create_dir_entry(ret, "", 0, 1);
 	return ret;
 }
 
@@ -104,13 +105,14 @@ static void clear_ref_dir(struct ref_dir *dir)
 	dir->entries = NULL;
 }
 
-struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
+struct ref_entry *create_dir_entry(struct ref_cache *cache,
 				   const char *dirname, size_t len,
 				   int incomplete)
 {
 	struct ref_entry *direntry;
+
 	FLEX_ALLOC_MEM(direntry, name, dirname, len);
-	direntry->u.subdir.ref_store = ref_store;
+	direntry->u.subdir.cache = cache;
 	direntry->flag = REF_DIR | (incomplete ? REF_INCOMPLETE : 0);
 	return direntry;
 }
@@ -181,7 +183,7 @@ static struct ref_dir *search_for_subdir(struct ref_dir *dir,
 		 * therefore, create an empty record for it but mark
 		 * the record complete.
 		 */
-		entry = create_dir_entry(dir->ref_store, subdirname, len, 0);
+		entry = create_dir_entry(dir->cache, subdirname, len, 0);
 		add_entry_to_dir(dir, entry);
 	} else {
 		entry = dir->entries[entry_index];
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index da5388c136..83051854ff 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -3,6 +3,9 @@
 
 struct ref_cache {
 	struct ref_entry *root;
+
+	/* A pointer to the files_ref_store whose cache this is: */
+	struct files_ref_store *ref_store;
 };
 
 /*
@@ -66,8 +69,8 @@ struct ref_dir {
 	 */
 	int sorted;
 
-	/* A pointer to the files_ref_store that contains this ref_dir. */
-	struct files_ref_store *ref_store;
+	/* The ref_cache containing this entry: */
+	struct ref_cache *cache;
 
 	struct ref_entry **entries;
 };
@@ -161,7 +164,7 @@ struct ref_dir *get_ref_dir(struct ref_entry *entry);
  * dirname is the name of the directory with a trailing slash (e.g.,
  * "refs/heads/") or "" for the top-level directory.
  */
-struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
+struct ref_entry *create_dir_entry(struct ref_cache *cache,
 				   const char *dirname, size_t len,
 				   int incomplete);
 
-- 
2.11.0

