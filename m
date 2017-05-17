Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14320201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753763AbdEQMGh (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:06:37 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:45819 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753015AbdEQMGa (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:06:30 -0400
X-AuditID: 1207440e-7afff70000007d8a-1c-591c3cc54d70
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id C9.B5.32138.5CC3C195; Wed, 17 May 2017 08:06:29 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pg9000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:06:28 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 18/23] read_packed_refs(): do more of the work of reading packed refs
Date:   Wed, 17 May 2017 14:05:41 +0200
Message-Id: <41dba75f36a53c963255922009463e67a8126f21.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsUixO6iqHvURibS4FCnscXaZ3eYLLqudDNZ
        NPReYba4vWI+s8WSh6+ZLbqnvGW0+NHSw2yxeXM7iwOHx9/3H5g8ds66y+6xYFOpR1f7ETaP
        Z717GD0uXlL2+LxJLoA9issmJTUnsyy1SN8ugSujc9ZixoJdchUzWqYyNzD2SnYxcnJICJhI
        tN//ztLFyMUhJLCDSWLqpVdQzgkmifM9J1hAqtgEdCUW9TQzgdgiAmoSE9sOgRUxCzxmkvi7
        rBusSFggVGLB6++MIDaLgKrEg2sXWEFsXoEoie0LPjNBrJOX2NV2ESzOKWAhcf/9I/YuRg6g
        beYS269XTmDkWcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11gvN7NELzWldBMjJNT4djC2
        r5c5xCjAwajEwzuBSzpSiDWxrLgy9xCjJAeTkijv/gdAIb6k/JTKjMTijPii0pzU4kOMEhzM
        SiK8N01lIoV4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8U6yBGgWL
        UtNTK9Iyc0oQ0kwcnCDDeYCGc4HU8BYXJOYWZ6ZD5E8xKkqJ8x4ASQiAJDJK8+B6YangFaM4
        0CvCvHkgVTzANALX/QpoMBPQ4GaQj3iLSxIRUlINjN4tjPfMH0e0nZ9Z9/Q/z57C/mP3XOKN
        Fy5Ty0/bL3bTOtNxr5rxubNyPv5MBzdO3fxAeXNpzFquxs8i+oEX3n/nWLS46MHj8EbLswfW
        R+se8m/fuf7g9JrVPg8mNF13EHr6L8dq49e3j/MvNkv28U7MvD0/OpThz8lgIQeOCcFJ3inh
        +50zXiuxFGckGmoxFxUnAgCUezBy4AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach `read_packed_refs()` to also

* Allocate and initialize the new `packed_ref_cache`
* Open and close the `packed-refs` file
* Update the `validity` field of the new object

This decreases the coupling between `packed_refs_cache` and
`files_ref_store` by a little bit.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 40 ++++++++++++++++++++++++----------------
 refs/ref-cache.h     |  3 ++-
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a910c44f38..6a037e1d61 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -221,7 +221,9 @@ static const char *parse_ref_line(struct strbuf *line, unsigned char *sha1)
 }
 
 /*
- * Read f, which is a packed-refs file, into dir.
+ * Read from `packed_refs_file` into a newly-allocated
+ * `packed_ref_cache` and return it. The return value will already
+ * have its reference count incremented.
  *
  * A comment line of the form "# pack-refs with: " may contain zero or
  * more traits. We interpret the traits as follows:
@@ -247,12 +249,26 @@ static const char *parse_ref_line(struct strbuf *line, unsigned char *sha1)
  *      compatibility with older clients, but we do not require it
  *      (i.e., "peeled" is a no-op if "fully-peeled" is set).
  */
-static void read_packed_refs(FILE *f, struct ref_dir *dir)
+static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
 {
+	FILE *f;
+	struct packed_ref_cache *packed_refs = xcalloc(1, sizeof(*packed_refs));
 	struct ref_entry *last = NULL;
 	struct strbuf line = STRBUF_INIT;
 	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled = PEELED_NONE;
+	struct ref_dir *dir;
 
+	acquire_packed_ref_cache(packed_refs);
+	packed_refs->cache = create_ref_cache(NULL, NULL);
+	packed_refs->cache->root->flag &= ~REF_INCOMPLETE;
+
+	f = fopen(packed_refs_file, "r");
+	if (!f)
+		return packed_refs;
+
+	stat_validity_update(&packed_refs->validity, fileno(f));
+
+	dir = get_ref_dir(packed_refs->cache->root);
 	while (strbuf_getwholeline(&line, f, '\n') != EOF) {
 		unsigned char sha1[20];
 		const char *refname;
@@ -299,7 +315,10 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 		}
 	}
 
+	fclose(f);
 	strbuf_release(&line);
+
+	return packed_refs;
 }
 
 static const char *files_packed_refs_path(struct files_ref_store *refs)
@@ -369,20 +388,9 @@ static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *ref
 	    !stat_validity_check(&refs->packed->validity, packed_refs_file))
 		clear_packed_ref_cache(refs);
 
-	if (!refs->packed) {
-		FILE *f;
-
-		refs->packed = xcalloc(1, sizeof(*refs->packed));
-		acquire_packed_ref_cache(refs->packed);
-		refs->packed->cache = create_ref_cache(&refs->base, NULL);
-		refs->packed->cache->root->flag &= ~REF_INCOMPLETE;
-		f = fopen(packed_refs_file, "r");
-		if (f) {
-			stat_validity_update(&refs->packed->validity, fileno(f));
-			read_packed_refs(f, get_ref_dir(refs->packed->cache->root));
-			fclose(f);
-		}
-	}
+	if (!refs->packed)
+		refs->packed = read_packed_refs(packed_refs_file);
+
 	return refs->packed;
 }
 
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index ffdc54f3f0..83e6c2dd2a 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -194,7 +194,8 @@ struct ref_entry *create_ref_entry(const char *refname,
  * function called to fill in incomplete directories in the
  * `ref_cache` when they are accessed. If it is NULL, then the whole
  * `ref_cache` must be filled (including clearing its directories'
- * `REF_INCOMPLETE` bits) before it is used.
+ * `REF_INCOMPLETE` bits) before it is used, and `refs` can be NULL,
+ * too.
  */
 struct ref_cache *create_ref_cache(struct ref_store *refs,
 				   fill_ref_dir_fn *fill_ref_dir);
-- 
2.11.0

