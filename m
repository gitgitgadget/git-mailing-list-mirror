Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D17A620286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751471AbdIMRRE (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:17:04 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59516 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751454AbdIMRRA (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Sep 2017 13:17:00 -0400
X-AuditID: 12074412-1e5ff7000000748d-b1-59b9680a7f83
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id E8.27.29837.A0869B95; Wed, 13 Sep 2017 13:16:58 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC855.dip0.t-ipconnect.de [87.188.200.85])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8DHGIif001379
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 13 Sep 2017 13:16:56 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 17/20] packed_ref_store: get rid of the `ref_cache` entirely
Date:   Wed, 13 Sep 2017 19:16:11 +0200
Message-Id: <e556cd698a9106a4b796069dba489f0ac0e0f3e7.1505319366.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505319366.git.mhagger@alum.mit.edu>
References: <cover.1505319366.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqMuVsTPSYHOzusXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8XtFfOZLbqnvGW0+NHSw2yxeXM7iwOHx9/3H5g8ds66y+6xYFOpx7PePYwe
        Fy8pe3zeJBfAFsVlk5Kak1mWWqRvl8CV8fLBBqaC1ZIV37s/sTQw/hTpYuTkkBAwkXj3/A57
        FyMXh5DADiaJt28aWCCck0wS/e9bGEGq2AR0JRb1NDOB2CICahIT2w6BFTELPGWS2HnyLitI
        QljAR2Lq7OtsIDaLgKrExLmvweK8AlESr9bMZYZYJy9x7sFtMJtTwEJi444nYAuEBMwlGufs
        ZJzAyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6ZXm5miV5qSukmRkiICe1gXH9S7hCj
        AAejEg/vA8udkUKsiWXFlbmHGCU5mJREeffqAoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8AZF
        AeV4UxIrq1KL8mFS0hwsSuK8Pxer+wkJpCeWpGanphakFsFkZTg4lCR4ndKBGgWLUtNTK9Iy
        c0oQ0kwcnCDDeYCGX0gDGV5ckJhbnJkOkT/FqMvRcfPuHyYhlrz8vFQpcd6/qUBFAiBFGaV5
        cHNgqeEVozjQW8K8LCDreIBpBW7SK6AlTEBLzpzeAbKkJBEhJdXAmOWxbKf651kHFJo7zGf0
        1KtnrHSZzhDCHCgnd3+O0OrPGW8nT1/Bfa/Tv75T29D99GP5j4t5e3t/JFRpHn09SVrh+b8M
        tQ3fSuRj21K33lxsbxRxmtN4/tIvVyxfMz9rvCDmeej+EfO4fzv51Ermbblr7pQpfO3cxsfp
        8o1s/psbpvH3zZ+/Q4mlOCPRUIu5qDgRAKeRfAnoAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that everything has been changed to read what it needs directly
out of the `packed-refs` file, `packed_ref_store` doesn't need to
maintain a `ref_cache` at all. So get rid of it.

First of all, this will save a lot of memory and lots of little
allocations. Instead of needing to store complicated parsed data
structures in memory, we just mmap the file (potentially sharing
memory with other processes) and parse only what we need.

Moreover, since the mmapped access to the file reads only the parts of
the file that it needs, this might save reading all of the data from
disk at all (at least if the file starts out sorted).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 88242a49fe..9868a5c198 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -16,8 +16,6 @@ struct packed_ref_cache {
 	 */
 	struct packed_ref_store *refs;
 
-	struct ref_cache *cache;
-
 	/*
 	 * The file descriptor of the `packed-refs` file (open in
 	 * read-only mode), or -1 if it is not open.
@@ -123,7 +121,6 @@ static void release_packed_ref_buffer(struct packed_ref_cache *packed_refs)
 static int release_packed_ref_cache(struct packed_ref_cache *packed_refs)
 {
 	if (!--packed_refs->referrers) {
-		free_ref_cache(packed_refs->cache);
 		stat_validity_clear(&packed_refs->validity);
 		release_packed_ref_buffer(packed_refs);
 		free(packed_refs);
@@ -640,15 +637,10 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 	struct packed_ref_cache *packed_refs = xcalloc(1, sizeof(*packed_refs));
 	struct stat st;
 	size_t size;
-	struct ref_dir *dir;
-	struct ref_iterator *iter;
 	int sorted = 0;
-	int ok;
 
 	packed_refs->refs = refs;
 	acquire_packed_ref_cache(packed_refs);
-	packed_refs->cache = create_ref_cache(NULL, NULL);
-	packed_refs->cache->root->flag &= ~REF_INCOMPLETE;
 	packed_refs->peeled = PEELED_NONE;
 
 	packed_refs->fd = open(refs->path, O_RDONLY);
@@ -730,23 +722,6 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 		verify_buffer_safe(packed_refs);
 	}
 
-	dir = get_ref_dir(packed_refs->cache->root);
-	iter = mmapped_ref_iterator_begin(
-			packed_refs,
-			packed_refs->buf + packed_refs->header_len,
-			packed_refs->eof);
-	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
-		struct ref_entry *entry =
-			create_ref_entry(iter->refname, iter->oid, iter->flags);
-
-		if ((iter->flags & REF_KNOWS_PEELED))
-			ref_iterator_peel(iter, &entry->u.value.peeled);
-		add_ref_entry(dir, entry);
-	}
-
-	if (ok != ITER_DONE)
-		die("error reading packed-refs file %s", refs->path);
-
 	return packed_refs;
 }
 
@@ -905,8 +880,8 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	else
 		start = packed_refs->buf + packed_refs->header_len;
 
-	iter->iter0 = mmapped_ref_iterator_begin(
-			packed_refs, start, packed_refs->eof);
+	iter->iter0 = mmapped_ref_iterator_begin(packed_refs,
+						 start, packed_refs->eof);
 
 	iter->flags = flags;
 
-- 
2.14.1

