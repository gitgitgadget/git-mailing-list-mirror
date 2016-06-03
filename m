From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/38] {lock,commit,rollback}_packed_refs(): add files_ref_store arguments
Date: Fri,  3 Jun 2016 23:03:44 +0200
Message-ID: <54d13545f73cf6a00a2e3a5f89c3e4568b5c836b.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:05:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wHb-0000uA-K2
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932963AbcFCVFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:05:13 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58635 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932781AbcFCVEx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:04:53 -0400
X-AuditID: 1207440e-ef3ff700000008c5-5a-5751f0e815e8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 34.68.02245.8E0F1575; Fri,  3 Jun 2016 17:04:40 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4KcZ003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:04:39 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsUixO6iqPviQ2C4wfX91hbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2uLMm0ZGBw6Pv+8/MHnsnHWX3eNZ7x5Gj4uXlD32
	L93G5rH4gZfHguf32T0+b5IL4IjitklKLCkLzkzP07dL4M54eHsea8F85YrdU5sZGxinynYx
	cnBICJhIzD1m1sXIxSEksJVR4ue35ewQznEmiU/t65i7GDk52AR0JRb1NDOB2CICERINr1oY
	QYqYBeYwSdx+2MkMMklYIEri3mVdkBoWAVWJK5uuMYLYvEDhmf92soLYEgJyEpenP2ADsTkF
	LCRaPq8CiwsJmEs0njrMMoGRZwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXWO93MwSvdSU
	0k2MkJDj28HYvl7mEKMAB6MSD2/Bs8BwIdbEsuLK3EOMkhxMSqK8e+8AhfiS8lMqMxKLM+KL
	SnNSiw8xSnAwK4nwprwGyvGmJFZWpRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiU
	JHgXvQdqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFQHwxMAZAUjxAe7k/gOwt
	LkjMBYpCtJ5iVJQS5w0FmSsAksgozYMbC0skrxjFgb4U5k0GqeIBJiG47ldAg5mABhc88gcZ
	XJKIkJICxrKxhkLFIZGX6i36S1ne+iSEadQqrX/n8FVe+pbwna+pP2TMeXcX3y/v2Sg1+1TB
	R8/cb7eWzprfeyjt7+TeS0Ivp7wO1W3p5z9XP/W4stH7BDfuBReOa3jxcv0Kmm4Y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296381>

These functions currently only work in the main repository, so add an
assert_main_repository() check to each function.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9307fa0..0d64a3d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2219,14 +2219,14 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
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
@@ -2255,16 +2255,16 @@ static int lock_packed_refs(int flags)
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
 
@@ -2291,13 +2291,13 @@ static int commit_packed_refs(void)
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
@@ -2443,13 +2443,13 @@ int pack_refs(unsigned int flags)
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
@@ -2485,7 +2485,7 @@ static int repack_without_refs(struct string_list *refnames, struct strbuf *err)
 	if (!needs_repacking)
 		return 0; /* no refname exists in packed refs */
 
-	if (lock_packed_refs(0)) {
+	if (lock_packed_refs(refs, 0)) {
 		unable_to_lock_message(git_path("packed-refs"), errno, err);
 		return -1;
 	}
@@ -2500,12 +2500,12 @@ static int repack_without_refs(struct string_list *refnames, struct strbuf *err)
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
@@ -3923,7 +3923,7 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 		}
 	}
 
-	if (lock_packed_refs(0)) {
+	if (lock_packed_refs(refs, 0)) {
 		strbuf_addf(err, "unable to lock packed-refs file: %s",
 			    strerror(errno));
 		ret = TRANSACTION_GENERIC_ERROR;
@@ -3938,7 +3938,7 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 			add_packed_ref(refs, update->refname, update->new_sha1);
 	}
 
-	if (commit_packed_refs()) {
+	if (commit_packed_refs(refs)) {
 		strbuf_addf(err, "unable to commit packed-refs file: %s",
 			    strerror(errno));
 		ret = TRANSACTION_GENERIC_ERROR;
-- 
2.8.1
