Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CEB420285
	for <e@80x24.org>; Tue, 29 Aug 2017 08:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbdH2IU4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 04:20:56 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:48297 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751236AbdH2IUw (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Aug 2017 04:20:52 -0400
X-AuditID: 12074412-1fdff7000000748d-c4-59a523e346f4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 75.5D.29837.3E325A95; Tue, 29 Aug 2017 04:20:51 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC836.dip0.t-ipconnect.de [87.188.200.54])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7T8KcRx002808
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 29 Aug 2017 04:20:50 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/10] files_pack_refs(): use a reference transaction to write packed refs
Date:   Tue, 29 Aug 2017 10:20:29 +0200
Message-Id: <2280d995f8516f296859ee583da112790e764b98.1503993268.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1503993268.git.mhagger@alum.mit.edu>
References: <cover.1503993268.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsUixO6iqPtYeWmkwY69FhZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHs969zB6
        XLyk7PF5k1wAWxSXTUpqTmZZapG+XQJXxudjN1gLtghX/O+7wdjA+I2/i5GTQ0LAROJE2xTm
        LkYuDiGBHUwST9cfYQRJCAmcZJL4MMEFxGYT0JVY1NPMBGKLCKhJTGw7xALSwCzwlEli58m7
        rCAJYYEoiUt3X7CB2CwCqhK73v5mB7F5geL9+04wQmyTlzj34DYziM0pYCFx6fMjqGXmEqc7
        HzBPYORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXTC83s0QvNaV0EyMkwIR2MK4/KXeI
        UYCDUYmHd4X1kkgh1sSy4srcQ4ySHExKorwZCksjhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nw
        BrMD5XhTEiurUovyYVLSHCxK4rw/F6v7CQmkJ5akZqemFqQWwWRlODiUJHi5gJEkJFiUmp5a
        kZaZU4KQZuLgBBnOAzTcCaSGt7ggMbc4Mx0if4pRUUqcd4IiUEIAJJFRmgfXC0sArxjFgV4R
        5o1QAqriASYPuO5XQIOZgAYrCi4EGVySiJCSamCsKb1ffm+NYFHJ33mtW06Xrnx/dM7i5tlJ
        7uuyq8QNvmzeqel94LD341NHH24PeV++6v1yrYj8yqnhU++cnbc8+Pa+zTMXTV3JldQuYKGg
        bPipaJZp3aID0wI8Duv1nZb2kmZiFzrmocv9LWgps5+11FneyWuXXJ99/ZjHdQ/NgCjVyE8p
        D04HKbEUZyQaajEXFScCADLtCArbAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the packed reference store supports transactions, we can use
a transaction to write the packed versions of references that we want
to pack. This decreases the coupling between `files_ref_store` and
`packed_ref_store`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2c78f63494..0fc44eaca5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1100,9 +1100,14 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	int ok;
 	struct ref_to_prune *refs_to_prune = NULL;
 	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction;
 
 	packed_refs_lock(refs->packed_ref_store, LOCK_DIE_ON_ERROR, &err);
 
+	transaction = ref_store_transaction_begin(refs->packed_ref_store, &err);
+	if (!transaction)
+		return -1;
+
 	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL, 0);
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
 		/*
@@ -1115,12 +1120,14 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 			continue;
 
 		/*
-		 * Create an entry in the packed-refs cache equivalent
-		 * to the one from the loose ref cache, except that
-		 * we don't copy the peeled status, because we want it
-		 * to be re-peeled.
+		 * Add a reference creation for this reference to the
+		 * packed-refs transaction:
 		 */
-		add_packed_ref(refs->packed_ref_store, iter->refname, iter->oid);
+		if (ref_transaction_update(transaction, iter->refname,
+					   iter->oid->hash, NULL,
+					   REF_NODEREF, NULL, &err))
+			die("failure preparing to create packed reference %s: %s",
+			    iter->refname, err.buf);
 
 		/* Schedule the loose reference for pruning if requested. */
 		if ((flags & PACK_REFS_PRUNE)) {
@@ -1134,8 +1141,11 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	if (ok != ITER_DONE)
 		die("error while iterating over references");
 
-	if (commit_packed_refs(refs->packed_ref_store, &err))
-		die("unable to overwrite old ref-pack file: %s", err.buf);
+	if (ref_transaction_commit(transaction, &err))
+		die("unable to write new packed-refs: %s", err.buf);
+
+	ref_transaction_free(transaction);
+
 	packed_refs_unlock(refs->packed_ref_store);
 
 	prune_refs(refs, refs_to_prune);
-- 
2.14.1

