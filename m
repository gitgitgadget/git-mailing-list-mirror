Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C83620209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752236AbdGAScn (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:32:43 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:45228 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752092AbdGAScU (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:32:20 -0400
X-AuditID: 12074412-b7fff70000000fed-df-5957eaaa4a8d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 01.75.04077.AAAE7595; Sat,  1 Jul 2017 14:32:10 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBb010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:32:08 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 24/30] packed_refs_lock(): report errors via a `struct strbuf *err`
Date:   Sat,  1 Jul 2017 20:31:02 +0200
Message-Id: <f76dd91617965cdd2d72821de60bfcd1a70ab9bb.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqLvqVXikweM7ShZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntljy8DWzRfeUt4wWP1p6mC02b25nceD0+Pv+A5PHzll32T0WbCr1
        6Go/wubxrHcPo8fFS8oenzfJBbBHcdmkpOZklqUW6dslcGU86DQu6JepWHf5I2MD4wzxLkZO
        DgkBE4ldK1czdTFycQgJ7GCSePPmHguEc5JJorHrLBtIFZuArsSinmYmEFtEQE1iYtshsCJm
        gUnMEm+vLQRKcHAIC4RJtHaFgdSwCKhKtF1/zQpi8wpESbzdco8VYpu8xK62i2A2p4CFxJ+2
        9cwgtpCAuUTzwT6WCYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmunlZpbopaaUbmKE
        hJzQDsb1J+UOMQpwMCrx8G4ICYsUYk0sK67MPcQoycGkJMq78lpopBBfUn5KZUZicUZ8UWlO
        avEhRgkOZiUR3tzn4ZFCvCmJlVWpRfkwKWkOFiVx3p+L1f2EBNITS1KzU1MLUotgsjIcHEoS
        vJNeAjUKFqWmp1akZeaUIKSZODhBhvMADV94F2R4cUFibnFmOkT+FKMux6sJ/78xCbHk5eel
        SonztoIMEgApyijNg5sDSxWvGMWB3hLmZQAmDiEeYJqBm/QKaAkT0BLhGSEgS0oSEVJSDYyL
        VrX0iWW2mD7+e0eT54fuqi6O/i+fQiU23uKRqnyq1mdv6rjCa7tM3uuju1w3fL969uKZOa/S
        veoua1/ePXumNENvxnOOt5d7Vlxd5XE6Wb5T8wVrkt5PDgNZnTctzcYX1VijdoWoXsvtND/p
        4O/XeejYoeQr6/LseU/Xr2Ve8jVA8aHJfw0lluKMREMt5qLiRADgqM0Y8AIAAA==
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
index 88de907148..8ea4e9ab05 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1096,7 +1096,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	struct ref_to_prune *refs_to_prune = NULL;
 	struct strbuf err = STRBUF_INIT;
 
-	packed_refs_lock(refs->packed_ref_store, LOCK_DIE_ON_ERROR);
+	packed_refs_lock(refs->packed_ref_store, LOCK_DIE_ON_ERROR, &err);
 
 	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL, 0);
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
@@ -2679,9 +2679,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
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
index cd214e07a1..78e877a9e3 100644
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

