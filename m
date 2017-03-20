Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C858720958
	for <e@80x24.org>; Mon, 20 Mar 2017 16:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932083AbdCTQeX (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:34:23 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52957 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755613AbdCTQeJ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 12:34:09 -0400
X-AuditID: 12074412-4a3ff70000000b04-23-58d0047ea64b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id EA.CA.02820.E7400D85; Mon, 20 Mar 2017 12:34:07 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KGXV9T010511
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 12:34:05 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 19/20] files_pack_refs(): use reference iteration
Date:   Mon, 20 Mar 2017 17:33:24 +0100
Message-Id: <d75087f1562773ef7a831c0cca85b1b546b607db.1490026594.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490026594.git.mhagger@alum.mit.edu>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsUixO6iqFvPciHCoOstn0XXlW4mi4beK8wW
        t1fMZ7ZY8vA1s0X3lLeMFj9aepgd2Dz+vv/A5LFz1l12j672I2wez3r3MHpcvKTs8XmTXABb
        FJdNSmpOZllqkb5dAlfGyRubGQtmGVZcO/ePqYGxRaOLkZNDQsBE4sSj96xdjFwcQgI7mCRO
        z1rHBOGcYpLo2bGPHaSKTUBXYlFPMxOILSKgJjGx7RALSBGzwCNGiavz74IVCQs4Spxp/cIM
        YrMIqEp0337GBmLzCkRJHL65hx1inbzErraLrCA2p4CFxJf7jSwgtpCAuUTngl72CYw8CxgZ
        VjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmunlZpbopaaUbmKEBJTQDsb1J+UOMQpwMCrx8K64
        cj5CiDWxrLgy9xCjJAeTkijv09tAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8VS+BcrwpiZVV
        qUX5MClpDhYlcd6fi9X9hATSE0tSs1NTC1KLYLIyHBxKErzswMgREixKTU+tSMvMKUFIM3Fw
        ggznARquAFLDW1yQmFucmQ6RP8WoKCXOe44JKCEAksgozYPrhUX8K0ZxoFeEeb+CVPEAkwVc
        9yugwUxAg5fdOAMyuCQRISXVwFhoamP/1XN6wCmZjp17VBJ/nt92U2LKyaRAvqjcdSt9oyuF
        s3UV/VXP6jLLLGNOtJ8xrZ2/3ffUDufipqmv1mp1CFzcvThH+ZWN5DctQ55EP4dMzyKXXfzq
        iXMDsnwndvziXK/yWupHQm/jl6OXd5wSYjbvYN5xiuVW5tv1Cxc927VWzEJDTomlOCPRUIu5
        qDgRALmV/5LTAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use reference iteration rather than do_for_each_entry_in_dir() in the
definition of files_pack_refs().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 143 +++++++++++++++++++++------------------------------
 1 file changed, 60 insertions(+), 83 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0ea42826c8..81d59e0de3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -32,17 +32,6 @@ static int ref_resolves_to_object(const char *refname,
 	return 1;
 }
 
-/*
- * Return true if the reference described by entry can be resolved to
- * an object in the database; otherwise, emit a warning and return
- * false.
- */
-static int entry_resolves_to_object(struct ref_entry *entry)
-{
-	return ref_resolves_to_object(entry->name,
-				      &entry->u.value.oid, entry->flag);
-}
-
 struct packed_ref_cache {
 	struct ref_cache *cache;
 
@@ -548,11 +537,6 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
 	return refs->loose;
 }
 
-static struct ref_dir *get_loose_ref_dir(struct files_ref_store *refs)
-{
-	return get_ref_dir(get_loose_ref_cache(refs)->root);
-}
-
 /*
  * Return the ref_entry for the given refname from the packed
  * references.  If it does not exist, return NULL.
@@ -1411,65 +1395,6 @@ struct ref_to_prune {
 	char name[FLEX_ARRAY];
 };
 
-struct pack_refs_cb_data {
-	unsigned int flags;
-	struct ref_dir *packed_refs;
-	struct ref_to_prune *ref_to_prune;
-};
-
-/*
- * An each_ref_entry_fn that is run over loose references only.  If
- * the loose reference can be packed, add an entry in the packed ref
- * cache.  If the reference should be pruned, also add it to
- * ref_to_prune in the pack_refs_cb_data.
- */
-static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
-{
-	struct pack_refs_cb_data *cb = cb_data;
-	enum peel_status peel_status;
-	struct ref_entry *packed_entry;
-	int is_tag_ref = starts_with(entry->name, "refs/tags/");
-
-	/* Do not pack per-worktree refs: */
-	if (ref_type(entry->name) != REF_TYPE_NORMAL)
-		return 0;
-
-	/* ALWAYS pack tags */
-	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref)
-		return 0;
-
-	/* Do not pack symbolic or broken refs: */
-	if ((entry->flag & REF_ISSYMREF) || !entry_resolves_to_object(entry))
-		return 0;
-
-	/* Add a packed ref cache entry equivalent to the loose entry. */
-	peel_status = peel_entry(entry, 1);
-	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
-		die("internal error peeling reference %s (%s)",
-		    entry->name, oid_to_hex(&entry->u.value.oid));
-	packed_entry = find_ref_entry(cb->packed_refs, entry->name);
-	if (packed_entry) {
-		/* Overwrite existing packed entry with info from loose entry */
-		packed_entry->flag = REF_ISPACKED | REF_KNOWS_PEELED;
-		oidcpy(&packed_entry->u.value.oid, &entry->u.value.oid);
-	} else {
-		packed_entry = create_ref_entry(entry->name, entry->u.value.oid.hash,
-						REF_ISPACKED | REF_KNOWS_PEELED, 0);
-		add_ref_entry(cb->packed_refs, packed_entry);
-	}
-	oidcpy(&packed_entry->u.value.peeled, &entry->u.value.peeled);
-
-	/* Schedule the loose reference for pruning if requested. */
-	if ((cb->flags & PACK_REFS_PRUNE)) {
-		struct ref_to_prune *n;
-		FLEX_ALLOC_STR(n, name, entry->name);
-		hashcpy(n->sha1, entry->u.value.oid.hash);
-		n->next = cb->ref_to_prune;
-		cb->ref_to_prune = n;
-	}
-	return 0;
-}
-
 enum {
 	REMOVE_EMPTY_PARENTS_REF = 0x01,
 	REMOVE_EMPTY_PARENTS_REFLOG = 0x02
@@ -1559,21 +1484,73 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB,
 			       "pack_refs");
-	struct pack_refs_cb_data cbdata;
-
-	memset(&cbdata, 0, sizeof(cbdata));
-	cbdata.flags = flags;
+	struct ref_iterator *iter;
+	struct ref_dir *packed_refs;
+	int ok;
+	struct ref_to_prune *refs_to_prune = NULL;
 
 	lock_packed_refs(refs, LOCK_DIE_ON_ERROR);
-	cbdata.packed_refs = get_packed_refs(refs);
+	packed_refs = get_packed_refs(refs);
+
+	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL, 0);
+	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
+		/*
+		 * If the loose reference can be packed, add an entry
+		 * in the packed ref cache. If the reference should be
+		 * pruned, also add it to refs_to_prune.
+		 */
+		struct ref_entry *packed_entry;
+		int is_tag_ref = starts_with(iter->refname, "refs/tags/");
+
+		/* Do not pack per-worktree refs: */
+		if (ref_type(iter->refname) != REF_TYPE_NORMAL)
+			continue;
+
+		/* ALWAYS pack tags */
+		if (!(flags & PACK_REFS_ALL) && !is_tag_ref)
+			continue;
+
+		/* Do not pack symbolic or broken refs: */
+		if (iter->flags & REF_ISSYMREF)
+			continue;
 
-	do_for_each_entry_in_dir(get_loose_ref_dir(refs),
-				 pack_if_possible_fn, &cbdata);
+		if (!ref_resolves_to_object(iter->refname, iter->oid, iter->flags))
+			continue;
+
+		/*
+		 * Create an entry in the packed-refs cache equivalent
+		 * to the one from the loose refs cache, except that
+		 * we don't copy the peeled status, because we want it
+		 * to be re-peeled.
+		 */
+		packed_entry = find_ref_entry(packed_refs, iter->refname);
+		if (packed_entry) {
+			/* Overwrite existing packed entry with info from loose entry */
+			packed_entry->flag = REF_ISPACKED;
+			oidcpy(&packed_entry->u.value.oid, iter->oid);
+		} else {
+			packed_entry = create_ref_entry(iter->refname, iter->oid->hash,
+							REF_ISPACKED, 0);
+			add_ref_entry(packed_refs, packed_entry);
+		}
+		oidclr(&packed_entry->u.value.peeled);
+
+		/* Schedule the loose reference for pruning if requested. */
+		if ((flags & PACK_REFS_PRUNE)) {
+			struct ref_to_prune *n;
+			FLEX_ALLOC_STR(n, name, iter->refname);
+			hashcpy(n->sha1, iter->oid->hash);
+			n->next = refs_to_prune;
+			refs_to_prune = n;
+		}
+	}
+	if (ok != ITER_DONE)
+		die("error while iterating over references");
 
 	if (commit_packed_refs(refs))
 		die_errno("unable to overwrite old ref-pack file");
 
-	prune_refs(refs, cbdata.ref_to_prune);
+	prune_refs(refs, refs_to_prune);
 	return 0;
 }
 
-- 
2.11.0

