From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/33] ref_transaction_commit(): remove local variable n
Date: Fri,  6 May 2016 18:13:52 +0200
Message-ID: <366668e3785a18ca82587ab018ea72eb597e87ba.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:14:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiOw-00085v-7a
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758658AbcEFQOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:14:44 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:64261 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758562AbcEFQOm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:14:42 -0400
X-AuditID: 12074411-e2bff70000000955-49-572cc2f03011
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id D1.00.02389.0F2CC275; Fri,  6 May 2016 12:14:40 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHUr031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:14:39 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqPvxkE64wfTNjBbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oz+fa4FnxUrPu36xNrAuEm6i5GTQ0LARGLTnZeM
	XYxcHEICWxkl2r5dY4VwjjNJNOx8yQJSxSagK7Gop5kJxBYRiJBoeNUC1MHBwSzwmVFiJTdI
	WFjAW2Ln8smsIDaLgKrElAc7wcp5BaIknvWsYoJYJidxefoDNhCbU8BC4lDvcbC4kIC5RMfa
	G+wTGHkWMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11cvNLNFLTSndxAgJL8EdjDNOyh1i
	FOBgVOLhzTipHS7EmlhWXJl7iFGSg0lJlPd7gU64EF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHe
	K/uAcrwpiZVVqUX5MClpDhYlcV6+Jep+QgLpiSWp2ampBalFMFkZDg4lCV5+YBwJCRalpqdW
	pGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIPCP74YGAEgKR6gvXwg7bzFBYm5QFGI1lOMuhxH
	9t9byyTEkpeflyolzjv3IFCRAEhRRmke3ApYMnnFKA70sTDvJJAqHmAigpv0CmgJE9CS93M1
	QZaUJCKkpBoY+8onn5k8pfahrMrc6m6TXr+JidecYk8IqQaxrQy9FHz0wHQn+zelugpGR26s
	kb2et6oyhsFoV07rz8sGP6yz/q/9s679VfDpgy+iDdyN/vZuf9PMbyRTvijut9vs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293801>

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
index 80d346f..93a94af 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3076,7 +3076,6 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
 	int ret = 0, i;
-	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
 	struct string_list_item *ref_to_delete;
@@ -3087,13 +3086,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3107,7 +3106,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	 * lockfiles, ready to be activated. Only keep one lockfile
 	 * open at a time to avoid running out of file descriptors.
 	 */
-	for (i = 0; i < n; i++) {
+	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = updates[i];
 
 		if ((update->flags & REF_HAVE_NEW) &&
@@ -3178,7 +3177,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	}
 
 	/* Perform updates first so live commits remain referenced */
-	for (i = 0; i < n; i++) {
+	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = updates[i];
 
 		if (update->flags & REF_NEEDS_COMMIT) {
@@ -3197,7 +3196,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	}
 
 	/* Perform deletes now that updates are safely completed */
-	for (i = 0; i < n; i++) {
+	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = updates[i];
 
 		if (update->flags & REF_DELETING) {
@@ -3223,7 +3222,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 cleanup:
 	transaction->state = REF_TRANSACTION_CLOSED;
 
-	for (i = 0; i < n; i++)
+	for (i = 0; i < transaction->nr; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	string_list_clear(&refs_to_delete, 0);
@@ -3243,7 +3242,6 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err)
 {
 	int ret = 0, i;
-	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 
@@ -3253,7 +3251,7 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 		die("BUG: commit called for transaction that is not open");
 
 	/* Fail if a refname appears more than once in the transaction: */
-	for (i = 0; i < n; i++)
+	for (i = 0; i < transaction->nr; i++)
 		string_list_append(&affected_refnames, updates[i]->refname);
 	string_list_sort(&affected_refnames);
 	if (ref_update_reject_duplicates(&affected_refnames, err)) {
@@ -3276,7 +3274,7 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 	if (for_each_rawref(ref_present, &affected_refnames))
 		die("BUG: initial ref transaction called with existing refs");
 
-	for (i = 0; i < n; i++) {
+	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = updates[i];
 
 		if ((update->flags & REF_HAVE_OLD) &&
@@ -3297,7 +3295,7 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 		goto cleanup;
 	}
 
-	for (i = 0; i < n; i++) {
+	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = updates[i];
 
 		if ((update->flags & REF_HAVE_NEW) &&
-- 
2.8.1
