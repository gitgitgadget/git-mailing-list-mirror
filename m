Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F39931FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 14:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933325AbdCaOMd (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 10:12:33 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:45182 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933228AbdCaOL6 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 Mar 2017 10:11:58 -0400
X-AuditID: 12074414-807ff70000002bfd-b6-58de63a7cb45
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 5C.1A.11261.7A36ED85; Fri, 31 Mar 2017 10:11:51 -0400 (EDT)
Received: from bagpipes.fritz.box (p4FEDFA60.dip0.t-ipconnect.de [79.237.250.96])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2VEBRBq010139
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 31 Mar 2017 10:11:50 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/20] refs: record the ref_store in ref_cache, not ref_dir
Date:   Fri, 31 Mar 2017 16:11:09 +0200
Message-Id: <7e63849fdb197cd66b229a28408845908fa844a7.1490966385.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490966385.git.mhagger@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsUixO6iqLs8+V6EwZS1xhZrn91hsui60s1k
        0dB7hdni9or5zBZLHr5mtuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHl3tR9g8
        nvXuYfS4eEnZ4/MmuQD2KC6blNSczLLUIn27BK6MmXcfsxWsUa6Ye3cncwPjBpkuRk4OCQET
        iQ0zPzB3MXJxCAnsYJJYd/kUO0hCSOAkk8Tbbm0Qm01AV2JRTzMTiC0ioCYxse0QC0gDs8Ab
        JokDW36xgCSEBfwkFn7ZzgZiswioSlx694MVxOYViJJYeqiVGWKbvMSutotgcU4BC4l1Mw9B
        LTOXWLB2AtsERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3Qt9HIzS/RSU0o3MUJCTWQH
        45GTcocYBTgYlXh4T3jfixBiTSwrrsw9xCjJwaQkyusbDhTiS8pPqcxILM6ILyrNSS0+xCjB
        wawkwssUB5TjTUmsrEotyodJSXOwKInzflus7ickkJ5YkpqdmlqQWgSTleHgUJLgrUgCahQs
        Sk1PrUjLzClBSDNxcIIM5wEavgCkhre4IDG3ODMdIn+KUVFKnJcVJCEAksgozYPrhaWCV4zi
        QK8I805JBKriAaYRuO5XQIOZgAZbfL0LMrgkESEl1cDo9dXO+NTNVYsqZgkIPQrf/G974WGJ
        nXm7/u1ewSYY/i+25F/H15M3Mln2HHyXJcr4zD8p+O/c4rxL0w1qDYM1gr6yL0/c7JB6lXm6
        /4VqbSlzmZPib9smXHYWszuRptBaXrmyzJ5P4D3fySXHbsyTNXzkFmH06mC5G9v6RZfOPX4S
        y7vk194lSizFGYmGWsxFxYkAAfc8N+ACAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of keeping a pointer to the ref_store in every ref_dir entry,
store it once in `struct ref_cache`, and change `struct ref_dir` to
include a pointer to its containing `ref_cache` instead. This makes it
easier to add to the information that is accessible from a `ref_dir`
without increasing the size of every `ref_dir` instance.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c |  6 +++---
 refs/ref-cache.c     | 12 +++++++-----
 refs/ref-cache.h     |  9 ++++++---
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a7d912ae39..78572e55a0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -433,7 +433,7 @@ static void add_packed_ref(struct files_ref_store *refs,
  */
 void read_loose_refs(const char *dirname, struct ref_dir *dir)
 {
-	struct files_ref_store *refs = dir->ref_store;
+	struct files_ref_store *refs = dir->cache->ref_store;
 	DIR *d;
 	struct dirent *de;
 	int dirnamelen = strlen(dirname);
@@ -469,7 +469,7 @@ void read_loose_refs(const char *dirname, struct ref_dir *dir)
 		} else if (S_ISDIR(st.st_mode)) {
 			strbuf_addch(&refname, '/');
 			add_entry_to_dir(dir,
-					 create_dir_entry(refs, refname.buf,
+					 create_dir_entry(dir->cache, refname.buf,
 							  refname.len, 1));
 		} else {
 			if (!refs_resolve_ref_unsafe(&refs->base,
@@ -526,7 +526,7 @@ static struct ref_dir *get_loose_refs(struct files_ref_store *refs)
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

