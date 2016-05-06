From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 22/33] refs: allow log-only updates
Date: Fri,  6 May 2016 18:14:03 +0200
Message-ID: <8cc803f8b0b5e3a38d98781095b0093114b23e32.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:22:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiWQ-0005jp-GZ
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758161AbcEFQWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:22:32 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:55623 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758140AbcEFQWb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:22:31 -0400
X-AuditID: 1207440e-ef3ff700000008c5-a9-572cc304da20
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 4D.0E.02245.403CC275; Fri,  6 May 2016 12:15:00 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHV4031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:14:58 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqMtyWCfcYEOnmsX8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgtZl61dmD3+Pv+A5PHzll32T2e9e5h9Lh4Sdlj/9JtbB4L
	nt9n9/i8SS6APYrbJimxpCw4Mz1P3y6BO2PytLssBTclK7b/fcbWwLhKpIuRk0NCwETi0Plb
	bCC2kMBWRon/TQVdjFxA9nEmiWVze8ESbAK6Eot6mplAbBGBCImGVy2MXYwcHMwCnxklVnKD
	hIUFzCTm3ZzLDGKzCKhKLN17EaycVyBK4sGNlawQu+QkLk9/ADaSU8BC4lDvcSaIveYSHWtv
	sE9g5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdYLzezRC81pXQTIyS8+HYwtq+XOcQo
	wMGoxMObcVI7XIg1say4MvcQoyQHk5Io7/cCnXAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrxX
	9gHleFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvIcOAjUKFqWmp1ak
	ZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg8I/vhgYASApHqC9fIdA9hYXJOYCRSFaTzHqchzZ
	f28tkxBLXn5eqpQ471yQHQIgRRmleXArYMnkFaM40MfCvJdBqniAiQhu0iugJUxAS97P1QRZ
	UpKIkJJqYHS/0rKB+wcDR9OOUDn7RDPLDK/FXFO9+T9suHwlqvHK8UmFO/e9vMo8LfLBrI+M
	jztNr310FlVfOW/3YfV00zNPV66dmW/xZd//xreTN87d/iPE/PbbqPjV90oX3DOP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293828>

From: David Turner <dturner@twopensource.com>

The refs infrastructure learns about log-only ref updates, which only
update the reflog.  Later, we will use this to separate symbolic
reference resolution from ref updating.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 16 ++++++++++------
 refs/refs-internal.h |  7 +++++++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f4f7953..3f546d0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2683,7 +2683,7 @@ static int commit_ref_update(struct ref_lock *lock,
 			}
 		}
 	}
-	if (commit_ref(lock)) {
+	if (!(flags & REF_LOG_ONLY) && commit_ref(lock)) {
 		strbuf_addf(err, "couldn't set '%s'", lock->ref_name);
 		unlock_ref(lock);
 		return -1;
@@ -3101,7 +3101,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			goto cleanup;
 		}
 		if ((update->flags & REF_HAVE_NEW) &&
-		    !(update->flags & REF_DELETING)) {
+		    !(update->flags & REF_DELETING) &&
+		    !(update->flags & REF_LOG_ONLY)) {
 			int overwriting_symref = ((update->type & REF_ISSYMREF) &&
 						  (update->flags & REF_NODEREF));
 
@@ -3133,8 +3134,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		}
 		if (!(update->flags & REF_NEEDS_COMMIT)) {
 			/*
-			 * We didn't have to write anything to the lockfile.
-			 * Close it to free up the file descriptor:
+			 * We didn't call write_ref_to_lockfile(), so
+			 * the lockfile is still open. Close it to
+			 * free up the file descriptor:
 			 */
 			if (close_ref(update->lock)) {
 				strbuf_addf(err, "couldn't close '%s.lock'",
@@ -3149,7 +3151,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = updates[i];
 
-		if (update->flags & REF_NEEDS_COMMIT) {
+		if (update->flags & REF_NEEDS_COMMIT ||
+		    update->flags & REF_LOG_ONLY) {
 			if (commit_ref_update(update->lock,
 					      update->new_sha1, update->msg,
 					      update->flags, err)) {
@@ -3168,7 +3171,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = updates[i];
 
-		if (update->flags & REF_DELETING) {
+		if (update->flags & REF_DELETING &&
+		    !(update->flags & REF_LOG_ONLY)) {
 			if (delete_ref_loose(update->lock, update->type, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 1f94f7a..85f4650 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -43,6 +43,13 @@
  */
 
 /*
+ * Used as a flag in ref_update::flags when we want to log a ref
+ * update but not actually perform it.  This is used when a symbolic
+ * ref update is split up.
+ */
+#define REF_LOG_ONLY 0x80
+
+/*
  * Return true iff refname is minimally safe. "Safe" here means that
  * deleting a loose reference by this name will not do any damage, for
  * example by causing a file that is not a reference to be deleted.
-- 
2.8.1
