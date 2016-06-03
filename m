From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 37/38] refs: make lock generic
Date: Fri,  3 Jun 2016 23:04:12 +0200
Message-ID: <d2a3cb56d7276c00174a08fe609d63e00755b205.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:07:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wJ5-00025e-T3
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbcFCVGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:06:49 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:61185 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932974AbcFCVFe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:05:34 -0400
X-AuditID: 1207440f-8a7ff700000008e4-9f-5751f11c1c96
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id A6.FB.02276.C11F1575; Fri,  3 Jun 2016 17:05:32 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kd3003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:05:31 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsUixO6iqCvzMTDcYNEydYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGdM+HifueCzUsXlptNMDYw3pbsY
	OTkkBEwkWh+9ZwaxhQS2MkpM/iUBYR9nkpj7zQ/EZhPQlVjU08wEYosIREg0vGph7GLk4mAW
	mMMkcfthJ1izsICexJ6rf9lAbBYBVYnD+/4B2RwcvAJREt/vi0LskpO4PP0BWAmngIVEy+dV
	rBC7zCUaTx1mmcDIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrolebmaJXmpK6SZGSMDx
	72DsWi9ziFGAg1GJh/fEi8BwIdbEsuLK3EOMkhxMSqK8e+8AhfiS8lMqMxKLM+KLSnNSiw8x
	SnAwK4nwprwGyvGmJFZWpRblw6SkOViUxHnVl6j7CQmkJ5akZqemFqQWwWRlODiUJHgXvQdq
	FCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAeFf3wxMAJAUjxAe7k/gOwtLkjMBYpC
	tJ5iVJQS5z0EMlcAJJFRmgc3FpZGXjGKA30pzBsI0s4DTEFw3a+ABjMBDS545A8yuCQRISXV
	wDh14oR/AkdLvoWwVrjv+jTnWl/EXLaFW840Zl5j6TWeUh6snb6upSbjx+xAhrBu5dqLT8VE
	l8zf/u2Nzyvec/P/vjzFJuFqfybylUjkmzXW5vWqp0QXqB9LyfSQbTM/P3tCyY7p 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296407>

From: David Turner <dturner@twopensource.com>

Instead of including a files-backend-specific struct ref_lock, change
the generic ref_update struct to include a void pointer that backends
can use for their own arbitrary data.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 25 +++++++++++++------------
 refs/refs-internal.h |  2 +-
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index d098c7d..53d0ba1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3523,9 +3523,8 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 
 	ret = lock_raw_ref(refs, update->refname, mustexist,
 			   affected_refnames, NULL,
-			   &update->lock, &referent,
+			   &lock, &referent,
 			   &update->type, err);
-
 	if (ret) {
 		char *reason;
 
@@ -3536,7 +3535,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		return ret;
 	}
 
-	lock = update->lock;
+	update->backend_data = lock;
 
 	if (update->type & REF_ISSYMREF) {
 		if (update->flags & REF_NODEREF) {
@@ -3591,7 +3590,8 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		for (parent_update = update->parent_update;
 		     parent_update;
 		     parent_update = parent_update->parent_update) {
-			oidcpy(&parent_update->lock->old_oid, &lock->old_oid);
+			struct ref_lock *parent_lock = parent_update->backend_data;
+			oidcpy(&parent_lock->old_oid, &lock->old_oid);
 		}
 
 		if ((update->flags & REF_HAVE_OLD) &&
@@ -3626,7 +3626,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * The lock was freed upon failure of
 			 * write_ref_to_lockfile():
 			 */
-			update->lock = NULL;
+			update->backend_data = NULL;
 			strbuf_addf(err,
 				    "cannot update the ref '%s': %s",
 				    update->refname, write_err);
@@ -3745,7 +3745,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	/* Perform updates first so live commits remain referenced */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = updates[i];
-		struct ref_lock *lock = update->lock;
+		struct ref_lock *lock = update->backend_data;
 
 		if (update->flags & REF_NEEDS_COMMIT ||
 		    update->flags & REF_LOG_ONLY) {
@@ -3758,7 +3758,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 					    lock->ref_name, old_msg);
 				free(old_msg);
 				unlock_ref(lock);
-				update->lock = NULL;
+				update->backend_data = NULL;
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			}
@@ -3768,7 +3768,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 			if (commit_ref(lock)) {
 				strbuf_addf(err, "couldn't set '%s'", lock->ref_name);
 				unlock_ref(lock);
-				update->lock = NULL;
+				update->backend_data = NULL;
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			}
@@ -3777,17 +3777,18 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	/* Perform deletes now that updates are safely completed */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = updates[i];
+		struct ref_lock *lock = update->backend_data;
 
 		if (update->flags & REF_DELETING &&
 		    !(update->flags & REF_LOG_ONLY)) {
-			if (delete_ref_loose(update->lock, update->type, err)) {
+			if (delete_ref_loose(lock, update->type, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			}
 
 			if (!(update->flags & REF_ISPRUNING))
 				string_list_append(&refs_to_delete,
-						   update->lock->ref_name);
+						   lock->ref_name);
 		}
 	}
 
@@ -3803,8 +3804,8 @@ cleanup:
 	transaction->state = REF_TRANSACTION_CLOSED;
 
 	for (i = 0; i < transaction->nr; i++)
-		if (updates[i]->lock)
-			unlock_ref(updates[i]->lock);
+		if (updates[i]->backend_data)
+			unlock_ref(updates[i]->backend_data);
 	string_list_clear(&refs_to_delete, 0);
 	free(head_ref);
 	string_list_clear(&affected_refnames, 0);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 4bfa5ce..db891e6 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -162,7 +162,7 @@ struct ref_update {
 	 */
 	unsigned int flags;
 
-	struct ref_lock *lock;
+	void *backend_data;
 	unsigned int type;
 	char *msg;
 
-- 
2.8.1
