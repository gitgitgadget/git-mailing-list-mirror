Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8533B20285
	for <e@80x24.org>; Tue, 29 Aug 2017 08:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbdH2IVF (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 04:21:05 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53171 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751336AbdH2IU4 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Aug 2017 04:20:56 -0400
X-AuditID: 1207440f-a5bff70000007960-30-59a523e59cd6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 0F.4F.31072.5E325A95; Tue, 29 Aug 2017 04:20:53 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC836.dip0.t-ipconnect.de [87.188.200.54])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7T8KcS0002808
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 29 Aug 2017 04:20:52 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/10] files_initial_transaction_commit(): use a transaction for packed refs
Date:   Tue, 29 Aug 2017 10:20:30 +0200
Message-Id: <92b29defc3c4ddb65a948b7d142ded941eaccefd.1503993268.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1503993268.git.mhagger@alum.mit.edu>
References: <cover.1503993268.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsUixO6iqPtUeWmkwYtH1hZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHs969zB6
        XLyk7PF5k1wAWxSXTUpqTmZZapG+XQJXRve+i6wFN0QqzqzawdrA2C7YxcjJISFgIrHp8Efm
        LkYuDiGBHUwSU35sYYNwTjJJLL+whRWkik1AV2JRTzMTiC0ioCYxse0QC0gRs8BTJomdJ++C
        FQkLxEg86VnJAmKzCKhK/J7XwgZi8wpESfQfvcMKsU5e4tyD28wgNqeAhcSlz48YQWwhAXOJ
        050PmCcw8ixgZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuil5tZopeaUrqJERJi/DsYu9bL
        HGIU4GBU4uFlsFsSKcSaWFZcmXuIUZKDSUmUN0NhaaQQX1J+SmVGYnFGfFFpTmrxIUYJDmYl
        Ed5gdqAcb0piZVVqUT5MSpqDRUmcV32Jup+QQHpiSWp2ampBahFMVoaDQ0mCN0cJqFGwKDU9
        tSItM6cEIc3EwQkynAdouDBIDW9xQWJucWY6RP4Uo6KUOO8ERaCEAEgiozQPrheWAl4xigO9
        IszrC0wIQjzA9AHX/QpoMBPQYEXBhSCDSxIRUlINjLYLz4juOc7XvDU0avelbUrCl0JZDL+Y
        915+WfCwbpXx2vyYB7nt7S5bu06zx/HX2W0UZsy6aXmZTXS2IWtEoWxb5Zbpi74m3U/jmN51
        iT9vdsVW/ehDie3uTRqZLSXfvutaNinaTWrfkHZuZ/61rQxByo1ln/9UdTyLKtE5m7pxYqXe
        whlSSizFGYmGWsxFxYkAQZkzp9wCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Used a `packed_ref_store` transaction in the implementation of
`files_initial_transaction_commit()` rather than using internal
features of the packed ref store. This further decouples
`files_ref_store` from `packed_ref_store`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0fc44eaca5..29c7c78602 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2663,6 +2663,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 	size_t i;
 	int ret = 0;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
+	struct ref_transaction *packed_transaction = NULL;
 
 	assert(err);
 
@@ -2695,6 +2696,12 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
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
 
@@ -2707,6 +2714,15 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
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
@@ -2714,21 +2730,14 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
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

