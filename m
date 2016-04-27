From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/29] ref_transaction_commit(): remove local variable n
Date: Wed, 27 Apr 2016 18:57:25 +0200
Message-ID: <9c31a016aa893e4a3748e31ee3fd48562f63a7a7.1461768689.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:58:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSnC-0003f6-VE
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbcD0Q6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:58:20 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:53601 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753345AbcD0Q6S (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:18 -0400
X-AuditID: 12074414-63fff700000008e6-e9-5720efa8b88c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 09.62.02278.8AFE0275; Wed, 27 Apr 2016 12:58:16 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6L022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:14 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLvivUK4wYUnshbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oyW5+9YCz4rVvyb95K9gXGTdBcjJ4eEgInE4gOf
	WbsYuTiEBLYySvw/NxnKOc4k0TilgQmkik1AV2JRTzOYLSLgILF85S92kCJmgSYmie/Lm1hA
	EsICHhIz9rSwgdgsAqoSiyc9BGvgFYiSuP3jFzPEOjmJy9MfgNVwClhIfGl9ywhiCwmYSyx5
	sJp9AiPPAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Fnq5mSV6qSmlmxghQSayg/HISblD
	jAIcjEo8vCekFMKFWBPLiitzDzFKcjApifIuOQsU4kvKT6nMSCzOiC8qzUktPsQowcGsJMI7
	/Q1QjjclsbIqtSgfJiXNwaIkzvttsbqfkEB6YklqdmpqQWoRTFaGg0NJgrf8HVCjYFFqempF
	WmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCgK4ouBcQCS4gHaWwrSzltckJgLFIVoPcWoKCXO
	uwAkIQCSyCjNgxsLSx2vGMWBvhTmDQKp4gGmHbjuV0CDmYAGXz4kCzK4JBEhJdXAOFcg2SBp
	qXfa7L7yCsH6Pe9l3pzaUZNetf5oI7/jqgUbNxc4B+sdeRS1962r3DcrxcS7lw7M0LbwCddh
	Z3MJtuycq1u48pvz0h9WlhMjPyzd3X2zi+mhvqqUkeLcbdwT8rZ88tHdsiT27fx5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292747>

This microoptimization doesn't make a significant difference in speed.
And it causes problems if somebody ever wants to modify the function to
add updates to a transaction as part of processing it, as will happen
shortly.

Make the same change in initial_ref_transaction_commit().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0ade681..05797cb 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3043,7 +3043,6 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
 	int ret = 0, i;
-	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
 	struct string_list_item *ref_to_delete;
@@ -3054,13 +3053,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: commit called for transaction that is not open");
 
-	if (!n) {
+	if (!transaction->nr) {
 		transaction->state = REF_TRANSACTION_CLOSED;
 		return 0;
 	}
 
 	/* Fail if a refname appears more than once in the transaction: */
-	for (i = 0; i < n; i++)
+	for (i = 0; i < transaction->nr; i++)
 		string_list_append(&affected_refnames, updates[i]->refname);
 	string_list_sort(&affected_refnames);
 	if (ref_update_reject_duplicates(&affected_refnames, err)) {
@@ -3074,7 +3073,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	 * lockfiles, ready to be activated. Only keep one lockfile
 	 * open at a time to avoid running out of file descriptors.
 	 */
-	for (i = 0; i < n; i++) {
+	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = updates[i];
 
 		if ((update->flags & REF_HAVE_NEW) &&
@@ -3145,7 +3144,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	}
 
 	/* Perform updates first so live commits remain referenced */
-	for (i = 0; i < n; i++) {
+	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = updates[i];
 
 		if (update->flags & REF_NEEDS_COMMIT) {
@@ -3164,7 +3163,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	}
 
 	/* Perform deletes now that updates are safely completed */
-	for (i = 0; i < n; i++) {
+	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = updates[i];
 
 		if (update->flags & REF_DELETING) {
@@ -3190,7 +3189,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 cleanup:
 	transaction->state = REF_TRANSACTION_CLOSED;
 
-	for (i = 0; i < n; i++)
+	for (i = 0; i < transaction->nr; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	string_list_clear(&refs_to_delete, 0);
@@ -3210,7 +3209,6 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err)
 {
 	int ret = 0, i;
-	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 
@@ -3220,7 +3218,7 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 		die("BUG: commit called for transaction that is not open");
 
 	/* Fail if a refname appears more than once in the transaction: */
-	for (i = 0; i < n; i++)
+	for (i = 0; i < transaction->nr; i++)
 		string_list_append(&affected_refnames, updates[i]->refname);
 	string_list_sort(&affected_refnames);
 	if (ref_update_reject_duplicates(&affected_refnames, err)) {
@@ -3243,7 +3241,7 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 	if (for_each_rawref(ref_present, &affected_refnames))
 		die("BUG: initial ref transaction called with existing refs");
 
-	for (i = 0; i < n; i++) {
+	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = updates[i];
 
 		if ((update->flags & REF_HAVE_OLD) &&
@@ -3264,7 +3262,7 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 		goto cleanup;
 	}
 
-	for (i = 0; i < n; i++) {
+	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = updates[i];
 
 		if ((update->flags & REF_HAVE_NEW) &&
-- 
2.8.1
