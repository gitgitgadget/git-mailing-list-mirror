Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A88520281
	for <e@80x24.org>; Tue, 19 Sep 2017 06:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751504AbdISGXT (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 02:23:19 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:62436 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751455AbdISGXQ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 02:23:16 -0400
X-AuditID: 1207440f-a43ff70000007960-42-59c0b7d36b2d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id DE.36.31072.3D7B0C95; Tue, 19 Sep 2017 02:23:15 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE885.dip0.t-ipconnect.de [84.170.232.133])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8J6MV1p002857
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 19 Sep 2017 02:23:13 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 18/21] packed_ref_store: get rid of the `ref_cache` entirely
Date:   Tue, 19 Sep 2017 08:22:26 +0200
Message-Id: <6f86618771d29d29b7f70f4d4abb0f4761c6c873.1505799700.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505799700.git.mhagger@alum.mit.edu>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqHt5+4FIg5trjCzWPrvDZPF8/Ql2
        i64r3UwWDb1XmC36l3exWdxeMZ/ZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4fPsZ5
        LNhU6vGsdw+jx8VLyh6fN8kFsEdx2aSk5mSWpRbp2yVwZby6c46lYKlkxYNLV5gaGP+JdDFy
        ckgImEg8WnWcqYuRi0NIYAeTxI0/m1ggnFNMEo/blrKDVLEJ6Eos6mlmArFFBNQkJrYdAiti
        FljJLDFp6xXWLkYODmEBf4ltf+pAalgEVCWOfFjHCmLzCkRJ3JvwggVim7zEuQe3mUFsTgEL
        ieY921lAWoUEzCUOHC2ewMizgJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuiV5uZoleakrp
        JkZIwPHvYOxaL3OIUYCDUYmHV+Da/kgh1sSy4srcQ4ySHExKorxhmw5ECvEl5adUZiQWZ8QX
        leakFh9ilOBgVhLhPbQIKMebklhZlVqUD5OS5mBREudVX6LuJySQnliSmp2aWpBaBJOV4eBQ
        kuBVBEaWkGBRanpqRVpmTglCmomDE2Q4D9BwFZAa3uKCxNzizHSI/ClGXY6Om3f/MAmx5OXn
        pUqJ897fBlQkAFKUUZoHNweWKF4xigO9Jcy7B6SKB5hk4Ca9AlrCBLQkewPYkpJEhJRUA2Pf
        xUPNMZU3956+b3fTr+Te4TIZw8o7G2f7zHu45J38DueId9ObK5vOxDufKVh8LHPZ2i8xS7oL
        tf7bbvjlfHmv1Iyvp5pOrr3usLasbPf291cm33lvkC3Ductkb8u9dR/O/hVd4z9z49aA35mc
        0h9Xt7x44ae1K6Y79iJ36Jr+a6ltTf8KJ718o8RSnJFoqMVcVJwIAI+aHvbvAgAA
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
index 6a930a440c..b4a01637a6 100644
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
@@ -718,15 +715,10 @@ static const char *find_reference_location(struct packed_ref_cache *cache,
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
@@ -799,23 +791,6 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
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
 
@@ -974,8 +949,8 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	else
 		start = packed_refs->buf + packed_refs->header_len;
 
-	iter->iter0 = mmapped_ref_iterator_begin(
-			packed_refs, start, packed_refs->eof);
+	iter->iter0 = mmapped_ref_iterator_begin(packed_refs,
+						 start, packed_refs->eof);
 
 	iter->flags = flags;
 
-- 
2.14.1

