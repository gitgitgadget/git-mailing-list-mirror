Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08B442082D
	for <e@80x24.org>; Fri,  8 Sep 2017 13:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754549AbdIHNwX (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 09:52:23 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:53087 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752415AbdIHNwR (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Sep 2017 09:52:17 -0400
X-AuditID: 1207440c-7e5ff7000000143e-f5-59b2a0909f37
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 92.3B.05182.090A2B95; Fri,  8 Sep 2017 09:52:16 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAEECC.dip0.t-ipconnect.de [84.170.238.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v88Dpvk0002844
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 8 Sep 2017 09:52:14 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/11] files_initial_transaction_commit(): use a transaction for packed refs
Date:   Fri,  8 Sep 2017 15:51:49 +0200
Message-Id: <1107477d7134f9c3114ea564ca0dd740e761b537.1504877858.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1504877858.git.mhagger@alum.mit.edu>
References: <cover.1504877858.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsUixO6iqDthwaZIg65ZEhZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHs969zB6
        XLyk7PF5k1wAWxSXTUpqTmZZapG+XQJXxpn3OQXXRSr2TdnL3MDYJtjFyMEhIWAisfVvWhcj
        F4eQwA4mibendrJCOCeZJGZtPsnYxcjJwSagK7Gop5kJxBYRUJOY2HaIBaSIWeApk8TOk3dZ
        QRLCAvESTc8nM4PYLAKqEgtmrWcBsXkFoiTanl9lA7ElBOQlzj24DVbDKWAh8erfGrC4kIC5
        xNXdk1gnMPIsYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrqJebWaKXmlK6iRESXjw7GL+t
        kznEKMDBqMTDOyF0Y6QQa2JZcWXuIUZJDiYlUV6Znk2RQnxJ+SmVGYnFGfFFpTmpxYcYJTiY
        lUR4zWcB5XhTEiurUovyYVLSHCxK4ryqS9T9hATSE0tSs1NTC1KLYLIyHBxKErwB84EaBYtS
        01Mr0jJzShDSTBycIMN5gIZvBKnhLS5IzC3OTIfIn2LU5ei4efcPkxBLXn5eqpQ4b9s8oCIB
        kKKM0jy4ObC08IpRHOgtYd4pIKN4gCkFbtIroCVMQEtKnm8AWVKSiJCSamCUa9j0p4Y5xz3w
        V/vLGudVi6c+Xfq1+2DVi9NJbuKJ+5TWKBywkfsjVZz6KH7FW/ObSj1Ju9QXOn8x3srXK9q2
        b/UPgWsfz25jCHjftzrnTNXPcwdXlPQH7DFXEV7FZ+9dG/vuRHlZ/cEsxmi3W7qtRyI/PToW
        oXx61TO3nOnstWz+3w6vWP1GiaU4I9FQi7moOBEAVokABuYCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use a `packed_ref_store` transaction in the implementation of
`files_initial_transaction_commit()` rather than using internal
features of the packed ref store. This further decouples
`files_ref_store` from `packed_ref_store`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 60031fe3ae..2700e3b5d5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2669,6 +2669,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 	size_t i;
 	int ret = 0;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
+	struct ref_transaction *packed_transaction = NULL;
 
 	assert(err);
 
@@ -2701,6 +2702,12 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 				 &affected_refnames))
 		die("BUG: initial ref transaction called with existing refs");
 
+	packed_transaction = ref_store_transaction_begin(refs->packed_ref_store, err);
+	if (!packed_transaction) {
+		ret = TRANSACTION_GENERIC_ERROR;
+		goto cleanup;
+	}
+
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
@@ -2713,6 +2720,15 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 			ret = TRANSACTION_NAME_CONFLICT;
 			goto cleanup;
 		}
+
+		/*
+		 * Add a reference creation for this reference to the
+		 * packed-refs transaction:
+		 */
+		ref_transaction_add_update(packed_transaction, update->refname,
+					   update->flags & ~REF_HAVE_OLD,
+					   update->new_oid.hash, update->old_oid.hash,
+					   NULL);
 	}
 
 	if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
@@ -2720,21 +2736,14 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
-	for (i = 0; i < transaction->nr; i++) {
-		struct ref_update *update = transaction->updates[i];
-
-		if ((update->flags & REF_HAVE_NEW) &&
-		    !is_null_oid(&update->new_oid))
-			add_packed_ref(refs->packed_ref_store, update->refname,
-				       &update->new_oid);
-	}
-
-	if (commit_packed_refs(refs->packed_ref_store, err)) {
+	if (initial_ref_transaction_commit(packed_transaction, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
 	}
 
 cleanup:
+	if (packed_transaction)
+		ref_transaction_free(packed_transaction);
 	packed_refs_unlock(refs->packed_ref_store);
 	transaction->state = REF_TRANSACTION_CLOSED;
 	string_list_clear(&affected_refnames, 0);
-- 
2.14.1

