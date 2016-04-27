From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 18/29] refs: allow log-only updates
Date: Wed, 27 Apr 2016 18:57:35 +0200
Message-ID: <37887529301c11100ae7bc71495f72ed071a66ca.1461768690.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:58:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSnU-0003nF-SH
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbcD0Q6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:58:35 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:53611 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752892AbcD0Q6e (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:34 -0400
X-AuditID: 12074414-63fff700000008e6-4a-5720efb9c12d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id D2.72.02278.9BFE0275; Wed, 27 Apr 2016 12:58:33 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6V022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:32 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLvzvUK4wf7t6hbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oz9dy8wFtyUrFi2o5G9gXGVSBcjJ4eEgInExSv9
	bF2MXBxCAlsZJZqXTmWHcI4zScz6uIQFpIpNQFdiUU8zE4gtIuAgsXzlL7AiZoEmJonvy5vA
	ioQFjCV+7H7KBmKzCKhKbOq/xAhi8wpESUz6+Y4dYp2cxOXpD8BqOAUsJL60vgWrERIwl1jy
	YDX7BEaeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0LfRyM0v0UlNKNzFCgkxkB+ORk3KH
	GAU4GJV4eE9IKYQLsSaWFVfmHmKU5GBSEuVdchYoxJeUn1KZkVicEV9UmpNafIhRgoNZSYR3
	+hugHG9KYmVValE+TEqag0VJnPfbYnU/IYH0xJLU7NTUgtQimKwMB4eSBK8qMJqEBItS01Mr
	0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kFREF8MjAOQFA/Q3tJ3IHuLCxJzgaIQracYFaXE
	eV+DJARAEhmleXBjYanjFaM40JfCvEEgVTzAtAPX/QpoMBPQ4MuHZEEGlyQipKQaGHM2MC/J
	XNaw7s6r9r4jAfFGWicmnRHiY11yoV2QY+7FDXJi3DX+k6ffcg1peMBwe/9m8X7NluiWa1Wn
	Lkow2pj95fLTlFZpjZy68lTu25W+UUfZMv0ZGFfN3Oad1fnk9MSTcRslcpMqdwl4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292751>

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
index e86e3de..91416db 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2688,7 +2688,7 @@ static int commit_ref_update(struct ref_lock *lock,
 			}
 		}
 	}
-	if (commit_ref(lock)) {
+	if (!(flags & REF_LOG_ONLY) && commit_ref(lock)) {
 		strbuf_addf(err, "couldn't set '%s'", lock->ref_name);
 		unlock_ref(lock);
 		return -1;
@@ -3106,7 +3106,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			goto cleanup;
 		}
 		if ((update->flags & REF_HAVE_NEW) &&
-		    !(update->flags & REF_DELETING)) {
+		    !(update->flags & REF_DELETING) &&
+		    !(update->flags & REF_LOG_ONLY)) {
 			int overwriting_symref = ((update->type & REF_ISSYMREF) &&
 						  (update->flags & REF_NODEREF));
 
@@ -3138,8 +3139,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3154,7 +3156,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = updates[i];
 
-		if (update->flags & REF_NEEDS_COMMIT) {
+		if (update->flags & REF_NEEDS_COMMIT ||
+		    update->flags & REF_LOG_ONLY) {
 			if (commit_ref_update(update->lock,
 					      update->new_sha1, update->msg,
 					      update->flags, err)) {
@@ -3173,7 +3176,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = updates[i];
 
-		if (update->flags & REF_DELETING) {
+		if (update->flags & REF_DELETING &&
+		    !(update->flags & REF_LOG_ONLY)) {
 			if (delete_ref_loose(update->lock, update->type, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 37a1a37..6b53ba1 100644
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
