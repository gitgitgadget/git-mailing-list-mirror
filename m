Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9847420401
	for <e@80x24.org>; Thu, 15 Jun 2017 14:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbdFOOsm (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 10:48:42 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:51707 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752707AbdFOOsi (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 10:48:38 -0400
X-AuditID: 1207440f-33bff7000000102d-c5-59429e3f608d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id A1.06.04141.F3E92495; Thu, 15 Jun 2017 10:48:32 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCC0A.dip0.t-ipconnect.de [87.188.204.10])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5FElbRH014537
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 15 Jun 2017 10:48:30 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 23/28] packed_refs_lock(): report errors via a `struct strbuf *err`
Date:   Thu, 15 Jun 2017 16:47:28 +0200
Message-Id: <64020d0dc582f44e5f83c36db0afdfdfdf7ea1b6.1497534157.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqOswzynS4NFvJou1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDKmPZnEVjBNpuLx67vMDYwzxLsY
        OTkkBEwkbk8+wtLFyMUhJLCDSaJhZw87hHOSSeLflymsIFVsAroSi3qamUBsEQE1iYlth8A6
        mAUmMUu8vbYQLCEsECxx/8xVNhCbRUBVomV7LzOIzSsQJXHl7ltmiHXyErvaLoIN5RSwkJj9
        ZR1QnANom7nEseUaExh5FjAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdHLzSzRS00p3cQI
        CTr+HYxd62UOMQpwMCrx8Co0OEUKsSaWFVfmHmKU5GBSEuXllwMK8SXlp1RmJBZnxBeV5qQW
        H2KU4GBWEuGdOgcox5uSWFmVWpQPk5LmYFES51Vfou4nJJCeWJKanZpakFoEk5Xh4FCS4N0G
        0ihYlJqeWpGWmVOCkGbi4AQZzgM0/C/Y8OKCxNzizHSI/ClGRSlxXg+QhABIIqM0D64XlhRe
        MYoDvSLM+wWkigeYUOC6XwENZgIaHHTBAWRwSSJCSqqBUXrbcqnHK+Yekmz91lru0vpyo+PS
        u2eizfyuZxz8y7T2+Zc6nT/WHB+zzH8WVf5r5Foc9tnBWklr/8YlT/i1y/f8TrjWesbKzPCr
        eovnskQXxgadx8Ufo28u2yYpfn3l15JPz5k6hLZpCqwT8X6hZmrxY0Mb99VDzr8c7Bftrc8y
        8f53rYlLQImlOCPRUIu5qDgRAO5JiVvlAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That way the callers don't have to come up with error messages
themselves.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c  |  6 ++----
 refs/packed-backend.c | 17 +++++++++++------
 refs/packed-backend.h |  6 +++---
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3fc2254e33..802ed9e2e9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1084,7 +1084,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	struct ref_to_prune *refs_to_prune = NULL;
 	struct strbuf err = STRBUF_INIT;
 
-	packed_refs_lock(refs->packed_ref_store, LOCK_DIE_ON_ERROR);
+	packed_refs_lock(refs->packed_ref_store, LOCK_DIE_ON_ERROR, &err);
 
 	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL, 0);
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
@@ -2667,9 +2667,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 		}
 	}
 
-	if (packed_refs_lock(refs->packed_ref_store, 0)) {
-		strbuf_addf(err, "unable to lock packed-refs file: %s",
-			    strerror(errno));
+	if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
 	}
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index eb9da04576..24451343b8 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -515,7 +515,7 @@ static int write_packed_entry(FILE *fh, const char *refname,
 	return 0;
 }
 
-int packed_refs_lock(struct ref_store *ref_store, int flags)
+int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 {
 	struct packed_ref_store *refs =
 	        packed_downcast(ref_store, REF_STORE_WRITE | REF_STORE_MAIN,
@@ -537,9 +537,15 @@ int packed_refs_lock(struct ref_store *ref_store, int flags)
 	if (hold_lock_file_for_update_timeout(
 			    &refs->lock,
 			    refs->path,
-			    flags, timeout_value) < 0 ||
-	    close_lock_file(&refs->lock))
+			    flags, timeout_value) < 0) {
+		unable_to_lock_message(refs->path, errno, err);
+		return -1;
+	}
+
+	if (close_lock_file(&refs->lock)) {
+		strbuf_addf(err, "unable to close %s: %s", refs->path, strerror(errno));
 		return -1;
+	}
 
 	/*
 	 * Now that we hold the `packed-refs` lock, make sure that our
@@ -698,10 +704,9 @@ int repack_without_refs(struct ref_store *ref_store,
 	if (!needs_repacking)
 		return 0; /* no refname exists in packed refs */
 
-	if (packed_refs_lock(&refs->base, 0)) {
-		unable_to_lock_message(refs->path, errno, err);
+	if (packed_refs_lock(&refs->base, 0, err))
 		return -1;
-	}
+
 	packed = get_packed_refs(refs);
 
 	/* Remove refnames from the cache */
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index dbc00d3396..210e3f35ce 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -6,10 +6,10 @@ struct ref_store *packed_ref_store_create(const char *path,
 
 /*
  * Lock the packed-refs file for writing. Flags is passed to
- * hold_lock_file_for_update(). Return 0 on success. On errors, set
- * errno appropriately and return a nonzero value.
+ * hold_lock_file_for_update(). Return 0 on success. On errors, write
+ * an error message to `err` and return a nonzero value.
  */
-int packed_refs_lock(struct ref_store *ref_store, int flags);
+int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err);
 
 void add_packed_ref(struct ref_store *ref_store,
 		    const char *refname, const struct object_id *oid);
-- 
2.11.0

