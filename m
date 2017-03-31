Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA7F01FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 14:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933306AbdCaOMQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 10:12:16 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50442 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933244AbdCaOML (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 Mar 2017 10:12:11 -0400
X-AuditID: 1207440c-abdff70000002e8f-c6-58de63b42abe
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 94.D9.11919.4B36ED85; Fri, 31 Mar 2017 10:12:04 -0400 (EDT)
Received: from bagpipes.fritz.box (p4FEDFA60.dip0.t-ipconnect.de [79.237.250.96])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2VEBRBx010139
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 31 Mar 2017 10:12:02 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 18/20] commit_packed_refs(): use reference iteration
Date:   Fri, 31 Mar 2017 16:11:16 +0200
Message-Id: <9c338fe52cac277e87a8d663e0082ccb765ff3f0.1490966385.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490966385.git.mhagger@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsUixO6iqLsl+V6EwY4GXYu1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfG9ylzWQoaVSq67xxhaWBcL9vFyMkhIWAi
        sfPJbuYuRi4OIYEdTBL3nnUxgySEBE4ySZw7kA1iswnoSizqaWYCsUUE1CQmth1iAWlgFnjD
        JHFgyy8WkISwgLvE9AXbWbsYOThYBFQlbrSxg4R5BaIkjjX/YIFYJi+xq+0iK4jNKWAhsW7m
        IXaIXeYSC9ZOYJvAyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6hXm5miV5qSukmRkig
        8exg/LZO5hCjAAejEg/vCe97EUKsiWXFlbmHGCU5mJREeX3DgUJ8SfkplRmJxRnxRaU5qcWH
        GCU4mJVEeJnigHK8KYmVValF+TApaQ4WJXFe1SXqfkIC6YklqdmpqQWpRTBZGQ4OJQneiiSg
        RsGi1PTUirTMnBKENBMHJ8hwHqDhKSA1vMUFibnFmekQ+VOMilLivKwgCQGQREZpHlwvLBG8
        YhQHekWY1wukigeYROC6XwENZgIabPH1LsjgkkSElFQD49T5dgdDbm3Y5n4v0ib59fbLf2OM
        Tj1Ol4gNLfecNH1RI3/Sse7Ap0ILpy9yKL9fXrW8ZNE65WWLbJ5d+JF34frS/evutS6pzJQQ
        KRMTKls/xXPd9/LqA4mtB+VeuP+oOp69UtBsvfGjK1Oz28Jseir4nYSfnshm7N54T9ViZ/7T
        iTLeW7fyfFJiKc5INNRiLipOBAB7Y22X3wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use reference iteration rather than do_for_each_entry_in_dir() in the
definition of commit_packed_refs().

Note that an internal consistency check that was previously done in
`write_packed_entry_fn()` is not there anymore. This is actually an
improvement:

The old error message was emitted when there is an entry in the
packed-ref cache that is not `REF_KNOWS_PEELED`, and when we attempted
to peel the reference, the result was `PEEL_INVALID`,
`PEEL_IS_SYMREF`, or `PEEL_BROKEN`. Since a packed ref cannot be a
symref, `PEEL_IS_SYMREF` and `PEEL_BROKEN` can be ruled out. So we're
left with `PEEL_INVALID`.

An entry without `REF_KNOWS_PEELED` can get into the packed-refs cache
in the following two ways:

* The reference was read from a `packed-refs` file that didn't have
  the `fully-peeled` attribute. In that case, we *don't want* to emit
  an error, because the broken value is presumably a stale value of
  the reference that is now masked by a loose version of the same
  reference (which we just don't happen to be packing this time). This
  is a perfectly legitimate situation and doesn't indicate that the
  repository is corrupt. The old code incorrectly emits an error
  message in this case. (It was probably never reported as a bug
  because this scenario is rare.)

* The reference was a loose reference that was just added to the
  packed ref cache by `files_packed_refs()` via
  `pack_if_possible_fn()` in preparation for being packed. The latter
  function refuses to pack a reference for which
  `entry_resolves_to_object()` returns false, and otherwise calls
  `peel_entry()` itself and checks the return value. So an entry added
  this way should always have `REF_KNOWS_PEELED` and shouldn't trigger
  the error message in either the old code or the new.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 736a6c9ff7..0ea42826c8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1293,30 +1293,15 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
  * Write an entry to the packed-refs file for the specified refname.
  * If peeled is non-NULL, write it as the entry's peeled value.
  */
-static void write_packed_entry(FILE *fh, char *refname, unsigned char *sha1,
-			       unsigned char *peeled)
+static void write_packed_entry(FILE *fh, const char *refname,
+			       const unsigned char *sha1,
+			       const unsigned char *peeled)
 {
 	fprintf_or_die(fh, "%s %s\n", sha1_to_hex(sha1), refname);
 	if (peeled)
 		fprintf_or_die(fh, "^%s\n", sha1_to_hex(peeled));
 }
 
-/*
- * An each_ref_entry_fn that writes the entry to a packed-refs file.
- */
-static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
-{
-	enum peel_status peel_status = peel_entry(entry, 0);
-
-	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
-		error("internal error: %s is not a valid packed reference!",
-		      entry->name);
-	write_packed_entry(cb_data, entry->name, entry->u.value.oid.hash,
-			   peel_status == PEEL_PEELED ?
-			   entry->u.value.peeled.hash : NULL);
-	return 0;
-}
-
 /*
  * Lock the packed-refs file for writing. Flags is passed to
  * hold_lock_file_for_update(). Return 0 on success. On errors, set
@@ -1362,9 +1347,10 @@ static int commit_packed_refs(struct files_ref_store *refs)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(refs);
-	int error = 0;
+	int ok, error = 0;
 	int save_errno = 0;
 	FILE *out;
+	struct ref_iterator *iter;
 
 	files_assert_main_repository(refs, "commit_packed_refs");
 
@@ -1376,8 +1362,18 @@ static int commit_packed_refs(struct files_ref_store *refs)
 		die_errno("unable to fdopen packed-refs descriptor");
 
 	fprintf_or_die(out, "%s", PACKED_REFS_HEADER);
-	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
-				 write_packed_entry_fn, out);
+
+	iter = cache_ref_iterator_begin(packed_ref_cache->cache, NULL, 0);
+	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
+		struct object_id peeled;
+		int peel_error = ref_iterator_peel(iter, &peeled);
+
+		write_packed_entry(out, iter->refname, iter->oid->hash,
+				   peel_error ? NULL : peeled.hash);
+	}
+
+	if (ok != ITER_DONE)
+		die("error while iterating over references");
 
 	if (commit_lock_file(packed_ref_cache->lock)) {
 		save_errno = errno;
-- 
2.11.0

