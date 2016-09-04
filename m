Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48DC21F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754145AbcIDQNZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:13:25 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:56480 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754080AbcIDQNB (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:13:01 -0400
X-AuditID: 12074411-a07ff70000000932-69-57cc47272baa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id CD.DD.02354.7274CC75; Sun,  4 Sep 2016 12:09:11 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5V026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:09 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 09/38] {lock,commit,rollback}_packed_refs(): add files_ref_store arguments
Date:   Sun,  4 Sep 2016 18:08:15 +0200
Message-Id: <d4f623a7fde1ccc7d3ab49f8f8bed8b1dddf1933.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqKvufibc4Nk0QYuuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7tHVfoTN41nvHkaP
        i5eUPfYv3cbmsfiBl8fnTXIBHFFcNimpOZllqUX6dglcGR2vXjMVXFKuePBzKlsD4yHZLkZO
        DgkBE4nTH++xdjFycQgJbGWUuLTgFBOEc5JJYv2Cp+wgVWwCuhKLepqZQGwRATWJiW2HWECK
        mEGKZk2cCVYkLBArcf9hNxuIzSKgKnGuYz+YzSsQJTH/TzMrxDo5iUvbvjCD2JwCFhJnds8F
        sjmAtplLtL/InsDIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrqlebmaJXmpK6SZGSMgJ
        7mCccVLuEKMAB6MSD+8E3TPhQqyJZcWVuYcYJTmYlER5Zx08GS7El5SfUpmRWJwRX1Sak1p8
        iFGCg1lJhFfbBaicNyWxsiq1KB8mJc3BoiTOy7dE3U9IID2xJDU7NbUgtQgmK8PBoSTBe90V
        qFGwKDU9tSItM6cEIc3EwQkynAdo+E2QGt7igsTc4sx0iPwpRkUpcd6XIAkBkERGaR5cLywl
        vGIUB3pFmFfRDaiKB5hO4LpfAQ1mAhq8bvdpkMEliQgpqQbGFc13a9oFzynP2XpJ5OEjh/jl
        NT5Zoar2jrtPTfuuHBG8R9cr8NrSy6dXmNXtOS+mI1m48/Tis90PfvdpX9jza6bL0j8ppsvP
        xFpMDnabeSWtaq3nkutf/NfKt3y6y+Ww87VbrVOKwpfbdzY1WkYo3fb1qNP5Ej/p5mv2FzNu
        1h/sePEnJT9SX4mlOCPRUIu5qDgRAGMYWITkAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These functions currently only work in the main repository, so add an
assert_main_repository() check to each function.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0c92ace..6913d45 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2215,14 +2215,14 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
  * hold_lock_file_for_update(). Return 0 on success. On errors, set
  * errno appropriately and return a nonzero value.
  */
-static int lock_packed_refs(int flags)
+static int lock_packed_refs(struct files_ref_store *refs, int flags)
 {
-	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "lock_packed_refs");
 	static int timeout_configured = 0;
 	static int timeout_value = 1000;
 	struct packed_ref_cache *packed_ref_cache;
 
+	assert_main_repository(&refs->base, "lock_packed_refs");
+
 	if (!timeout_configured) {
 		git_config_get_int("core.packedrefstimeout", &timeout_value);
 		timeout_configured = 1;
@@ -2251,16 +2251,16 @@ static int lock_packed_refs(int flags)
  * lock_packed_refs()). Return zero on success. On errors, set errno
  * and return a nonzero value
  */
-static int commit_packed_refs(void)
+static int commit_packed_refs(struct files_ref_store *refs)
 {
-	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "commit_packed_refs");
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(refs);
 	int error = 0;
 	int save_errno = 0;
 	FILE *out;
 
+	assert_main_repository(&refs->base, "commit_packed_refs");
+
 	if (!packed_ref_cache->lock)
 		die("internal error: packed-refs not locked");
 
@@ -2287,13 +2287,13 @@ static int commit_packed_refs(void)
  * in-memory packed reference cache.  (The packed-refs file will be
  * read anew if it is needed again after this function is called.)
  */
-static void rollback_packed_refs(void)
+static void rollback_packed_refs(struct files_ref_store *refs)
 {
-	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "rollback_packed_refs");
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(refs);
 
+	assert_main_repository(&refs->base, "rollback_packed_refs");
+
 	if (!packed_ref_cache->lock)
 		die("internal error: packed-refs not locked");
 	rollback_lock_file(packed_ref_cache->lock);
@@ -2439,13 +2439,13 @@ int pack_refs(unsigned int flags)
 	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.flags = flags;
 
-	lock_packed_refs(LOCK_DIE_ON_ERROR);
+	lock_packed_refs(refs, LOCK_DIE_ON_ERROR);
 	cbdata.packed_refs = get_packed_refs(refs);
 
 	do_for_each_entry_in_dir(get_loose_refs(refs), 0,
 				 pack_if_possible_fn, &cbdata);
 
-	if (commit_packed_refs())
+	if (commit_packed_refs(refs))
 		die_errno("unable to overwrite old ref-pack file");
 
 	prune_refs(cbdata.ref_to_prune);
@@ -2481,7 +2481,7 @@ static int repack_without_refs(struct string_list *refnames, struct strbuf *err)
 	if (!needs_repacking)
 		return 0; /* no refname exists in packed refs */
 
-	if (lock_packed_refs(0)) {
+	if (lock_packed_refs(refs, 0)) {
 		unable_to_lock_message(git_path("packed-refs"), errno, err);
 		return -1;
 	}
@@ -2496,12 +2496,12 @@ static int repack_without_refs(struct string_list *refnames, struct strbuf *err)
 		 * All packed entries disappeared while we were
 		 * acquiring the lock.
 		 */
-		rollback_packed_refs();
+		rollback_packed_refs(refs);
 		return 0;
 	}
 
 	/* Write what remains */
-	ret = commit_packed_refs();
+	ret = commit_packed_refs(refs);
 	if (ret)
 		strbuf_addf(err, "unable to overwrite old ref-pack file: %s",
 			    strerror(errno));
@@ -3929,7 +3929,7 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 		}
 	}
 
-	if (lock_packed_refs(0)) {
+	if (lock_packed_refs(refs, 0)) {
 		strbuf_addf(err, "unable to lock packed-refs file: %s",
 			    strerror(errno));
 		ret = TRANSACTION_GENERIC_ERROR;
@@ -3944,7 +3944,7 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 			add_packed_ref(refs, update->refname, update->new_sha1);
 	}
 
-	if (commit_packed_refs()) {
+	if (commit_packed_refs(refs)) {
 		strbuf_addf(err, "unable to commit packed-refs file: %s",
 			    strerror(errno));
 		ret = TRANSACTION_GENERIC_ERROR;
-- 
2.9.3

