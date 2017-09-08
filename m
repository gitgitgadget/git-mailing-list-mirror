Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 797EA2082D
	for <e@80x24.org>; Fri,  8 Sep 2017 13:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754459AbdIHNwP (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 09:52:15 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:65450 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753060AbdIHNwN (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Sep 2017 09:52:13 -0400
X-AuditID: 12074414-0ebff70000006ddf-b3-59b2a08c8328
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 60.8E.28127.C80A2B95; Fri,  8 Sep 2017 09:52:12 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAEECC.dip0.t-ipconnect.de [84.170.238.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v88Dpvjw002844
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 8 Sep 2017 09:52:10 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 05/11] files_pack_refs(): use a reference transaction to write packed refs
Date:   Fri,  8 Sep 2017 15:51:47 +0200
Message-Id: <ebdd82025b884bdd632a6c4856d07a5011566571.1504877858.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1504877858.git.mhagger@alum.mit.edu>
References: <cover.1504877858.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqNuzYFOkwa5X/BZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHs969zB6
        XLyk7PF5k1wAWxSXTUpqTmZZapG+XQJXRufjB2wFq4UqNs6/w97A2MLfxcjJISFgInFz8XOm
        LkYuDiGBHUwS0ya0M0I4J5kkzr75zA5SxSagK7Gop5kJxBYRUJOY2HaIBaSIWeApk8TOk3dZ
        QRLCArESN7u/s4HYLAKqEj8mngBr5hWIkngw4RUjxDp5iXMPbjOD2JwCFhKv/q0BqxcSMJe4
        unsS6wRGngWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdC30cjNL9FJTSjcxQkJMZAfjkZNy
        hxgFOBiVeHgtgjdGCrEmlhVX5h5ilORgUhLllenZFCnEl5SfUpmRWJwRX1Sak1p8iFGCg1lJ
        hNd8FlCONyWxsiq1KB8mJc3BoiTO+22xup+QQHpiSWp2ampBahFMVoaDQ0mCN2A+UKNgUWp6
        akVaZk4JQpqJgxNkOA/Q8P3zQIYXFyTmFmemQ+RPMepydNy8+4dJiCUvPy9VSpy3DaRIAKQo
        ozQPbg4sNbxiFAd6S5jXAGQdDzCtwE16BbSECWhJyfMNIEtKEhFSUg2Mkw1X/RH94144N9JJ
        my9vd7rru1eVTw44B3OdXmyy9rf3t+cFs4RN99XuWhXkUHSisGvnjwM67ZszK87G3Jlqnvaz
        L2JfOoPfr9k+5U+2aNj92P3YTPck64EF9zIEGDXnFl+59WfuKu8LBrF5qnPatS+e0WNjdn45
        PSj2pOqUsqeV91s7jt4+q8RSnJFoqMVcVJwIAKyl7hvoAgAA
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
index 2c78f63494..3475c6f8a2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1100,6 +1100,11 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	int ok;
 	struct ref_to_prune *refs_to_prune = NULL;
 	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction;
+
+	transaction = ref_store_transaction_begin(refs->packed_ref_store, &err);
+	if (!transaction)
+		return -1;
 
 	packed_refs_lock(refs->packed_ref_store, LOCK_DIE_ON_ERROR, &err);
 
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

