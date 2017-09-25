Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B568F20281
	for <e@80x24.org>; Mon, 25 Sep 2017 08:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934071AbdIYIBN (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:01:13 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:56633 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933892AbdIYIBI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Sep 2017 04:01:08 -0400
X-AuditID: 1207440e-be1ff70000007085-28-59c8b7c3c107
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 4D.8C.28805.3C7B8C95; Mon, 25 Sep 2017 04:01:07 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDF6.dip0.t-ipconnect.de [87.188.205.246])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8P80N6c027347
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 25 Sep 2017 04:01:05 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 18/21] packed_ref_store: get rid of the `ref_cache` entirely
Date:   Mon, 25 Sep 2017 10:00:15 +0200
Message-Id: <cfa2e29c34bb712b17b8067515710a606a4fedab.1506325610.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1506325610.git.mhagger@alum.mit.edu>
References: <cover.1506325610.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqHt4+4lIg9lvJC3WPrvDZPF8/Ql2
        i64r3UwWDb1XmC36l3exWdxeMZ/ZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4fPsZ5
        LNhU6vGsdw+jx8VLyh6fN8kFsEdx2aSk5mSWpRbp2yVwZaz6YVewVLLi+erHzA2M/0S6GDk5
        JARMJPrunWXtYuTiEBLYwSSxftErKOcUk8SdE0/YQKrYBHQlFvU0M4HYIgJqEhPbDrGAFDEL
        rGSWmLT1CitIQljAX6Jn63GgBAcHi4CqxOwH1SBhXoEoidbm9SwQ2+Qlzj24zQxicwpYSLw5
        cwRsvpCAucT5G7dYJzDyLGBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6yXm1mil5pSuokR
        EnB8Oxjb18scYhTgYFTi4Y34dzxSiDWxrLgy9xCjJAeTkijvXb4TkUJ8SfkplRmJxRnxRaU5
        qcWHGCU4mJVEeI+tBsrxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4
        920DahQsSk1PrUjLzClBSDNxcIIM5wEavhykhre4IDG3ODMdIn+KUZej4+bdP0xCLHn5ealS
        4rzxIEUCIEUZpXlwc2CJ4hWjONBbwrwLQap4gEkGbtIroCVMQEt6p4ItKUlESEk1MPbliHyb
        s/LJ4cifayY9XmAo0rNT3KWKa7+gkNKCrI/zU/hO8h1c7dRuG7DpYYBwwASf4Ab/GpG2jgXr
        Xku8lt9gUCP1fpl59wpNxg7H/5VvSz2nSC/j+S2+rLuzc5a2f7lV0BX+vck33x+YvyhcP+7L
        zjpPxju3Z6+T+PM18fPGt82hGaF/e5VYijMSDbWYi4oTAamBfHDvAgAA
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
index dbbba45502..3829e9c294 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -45,8 +45,6 @@ struct packed_ref_cache {
 	 */
 	struct packed_ref_store *refs;
 
-	struct ref_cache *cache;
-
 	/* Is the `packed-refs` file currently mmapped? */
 	int mmapped;
 
@@ -148,7 +146,6 @@ static void release_packed_ref_buffer(struct packed_ref_cache *packed_refs)
 static int release_packed_ref_cache(struct packed_ref_cache *packed_refs)
 {
 	if (!--packed_refs->referrers) {
-		free_ref_cache(packed_refs->cache);
 		stat_validity_clear(&packed_refs->validity);
 		release_packed_ref_buffer(packed_refs);
 		free(packed_refs);
@@ -719,15 +716,10 @@ static const char *find_reference_location(struct packed_ref_cache *cache,
 static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 {
 	struct packed_ref_cache *packed_refs = xcalloc(1, sizeof(*packed_refs));
-	struct ref_dir *dir;
-	struct ref_iterator *iter;
 	int sorted = 0;
-	int ok;
 
 	packed_refs->refs = refs;
 	acquire_packed_ref_cache(packed_refs);
-	packed_refs->cache = create_ref_cache(NULL, NULL);
-	packed_refs->cache->root->flag &= ~REF_INCOMPLETE;
 	packed_refs->peeled = PEELED_NONE;
 
 	if (!load_contents(packed_refs))
@@ -800,23 +792,6 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 		packed_refs->eof = buf_copy + size;
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
 
@@ -975,8 +950,8 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	else
 		start = packed_refs->buf + packed_refs->header_len;
 
-	iter->iter0 = mmapped_ref_iterator_begin(
-			packed_refs, start, packed_refs->eof);
+	iter->iter0 = mmapped_ref_iterator_begin(packed_refs,
+						 start, packed_refs->eof);
 
 	iter->flags = flags;
 
-- 
2.14.1

