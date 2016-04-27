From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 22/29] lock_ref_for_update(): new function
Date: Wed, 27 Apr 2016 18:57:39 +0200
Message-ID: <1c34010ac77af9d3f7818d01ca267ff7bd0bf621.1461768690.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 19:05:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSuO-0006Oy-5d
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 19:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283AbcD0RFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 13:05:45 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58772 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753221AbcD0RFo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 13:05:44 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Apr 2016 13:05:44 EDT
X-AuditID: 1207440e-ef3ff700000008c5-3a-5720efc08502
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 0A.9F.02245.0CFE0275; Wed, 27 Apr 2016 12:58:40 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6Z022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:39 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqHvgvUK4wcmJahbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7owDJ/azF+zUqpjzeClTA+NShS5GTg4JAROJZ71v
	WbsYuTiEBLYySlyYNZMVJCEkcJxJ4sTKNBCbTUBXYlFPMxOILSLgILF85S92kAZmgSYmie/L
	m1hAEsICVhK/1uwCaubgYBFQldhy0gckzCsQJfF62y5WiGVyEpenP2ADsTkFLCS+tL5lhNhl
	LrHkwWr2CYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGuvlZpbopaaUbmKEBBjfDsb2
	9TKHGAU4GJV4eAskFMKFWBPLiitzDzFKcjApifIuOQsU4kvKT6nMSCzOiC8qzUktPsQowcGs
	JMI7/Q1QjjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwWv2DqhRsCg1
	PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQB8cXAGABJ8QDt/fMWZG9xQWIuUBSi9RSj
	opQ4rytIQgAkkVGaBzcWljZeMYoDfSnMOxVkOw8w5cB1vwIazAQ0+PIhWZDBJYkIKakGxvRj
	efzZu98p+D5+mhJ6a34i56QlRR1ZiaW6avFHTiiL/dab+mfBhaOOzcrGn1aIP8lfrsDNcTzR
	ei6fzZEpIte2xjSseV+srHCXf373pO+h3O5rmj8mx02cUnZw46u2bWxqMaql8cz6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292773>

Extract a new function, lock_ref_for_update(), from
ref_transaction_commit().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 152 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 85 insertions(+), 67 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index e0d9fa3..546656a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3048,6 +3048,88 @@ static int ref_update_reject_duplicates(struct string_list *refnames,
 	return 0;
 }
 
+/*
+ * Acquire all locks, verify old values if provided, check
+ * that new values are valid, and write new values to the
+ * lockfiles, ready to be activated. Only keep one lockfile
+ * open at a time to avoid running out of file descriptors.
+ */
+static int lock_ref_for_update(struct ref_update *update,
+			       struct ref_transaction *transaction,
+			       struct string_list *affected_refnames,
+			       struct strbuf *err)
+{
+	int ret;
+
+	if ((update->flags & REF_HAVE_NEW) &&
+	    is_null_sha1(update->new_sha1))
+		update->flags |= REF_DELETING;
+	update->lock = lock_ref_sha1_basic(
+			update->refname,
+			((update->flags & REF_HAVE_OLD) ?
+			 update->old_sha1 : NULL),
+			affected_refnames, NULL,
+			update->flags,
+			&update->type,
+			err);
+	if (!update->lock) {
+		char *reason;
+
+		ret = (errno == ENOTDIR)
+			? TRANSACTION_NAME_CONFLICT
+			: TRANSACTION_GENERIC_ERROR;
+		reason = strbuf_detach(err, NULL);
+		strbuf_addf(err, "cannot lock ref '%s': %s",
+			    update->refname, reason);
+		free(reason);
+		return ret;
+	}
+	if ((update->flags & REF_HAVE_NEW) &&
+	    !(update->flags & REF_DELETING) &&
+	    !(update->flags & REF_LOG_ONLY)) {
+		int overwriting_symref = ((update->type & REF_ISSYMREF) &&
+					  (update->flags & REF_NODEREF));
+
+		if (!overwriting_symref &&
+		    !hashcmp(update->lock->old_oid.hash, update->new_sha1)) {
+			/*
+			 * The reference already has the desired
+			 * value, so we don't need to write it.
+			 */
+		} else if (write_ref_to_lockfile(update->lock,
+						 update->new_sha1,
+						 err)) {
+			char *write_err = strbuf_detach(err, NULL);
+
+			/*
+			 * The lock was freed upon failure of
+			 * write_ref_to_lockfile():
+			 */
+			update->lock = NULL;
+			strbuf_addf(err,
+				    "cannot update the ref '%s': %s",
+				    update->refname, write_err);
+			free(write_err);
+			return TRANSACTION_GENERIC_ERROR;
+		} else {
+			update->flags |= REF_NEEDS_COMMIT;
+		}
+	}
+	if (!(update->flags & REF_NEEDS_COMMIT)) {
+		/*
+		 * We didn't call write_ref_to_lockfile(), so
+		 * the lockfile is still open. Close it to
+		 * free up the file descriptor:
+		 */
+		if (close_ref(update->lock)) {
+			strbuf_addf(err, "couldn't close '%s.lock'",
+				    update->refname);
+			return TRANSACTION_GENERIC_ERROR;
+		}
+	}
+	return 0;
+}
+
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
@@ -3085,74 +3167,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = updates[i];
 
-		if ((update->flags & REF_HAVE_NEW) &&
-		    is_null_sha1(update->new_sha1))
-			update->flags |= REF_DELETING;
-		update->lock = lock_ref_sha1_basic(
-				update->refname,
-				((update->flags & REF_HAVE_OLD) ?
-				 update->old_sha1 : NULL),
-				&affected_refnames, NULL,
-				update->flags,
-				&update->type,
-				err);
-		if (!update->lock) {
-			char *reason;
-
-			ret = (errno == ENOTDIR)
-				? TRANSACTION_NAME_CONFLICT
-				: TRANSACTION_GENERIC_ERROR;
-			reason = strbuf_detach(err, NULL);
-			strbuf_addf(err, "cannot lock ref '%s': %s",
-				    update->refname, reason);
-			free(reason);
+		ret = lock_ref_for_update(update, transaction,
+					  &affected_refnames, err);
+		if (ret)
 			goto cleanup;
-		}
-		if ((update->flags & REF_HAVE_NEW) &&
-		    !(update->flags & REF_DELETING) &&
-		    !(update->flags & REF_LOG_ONLY)) {
-			int overwriting_symref = ((update->type & REF_ISSYMREF) &&
-						  (update->flags & REF_NODEREF));
-
-			if (!overwriting_symref &&
-			    !hashcmp(update->lock->old_oid.hash, update->new_sha1)) {
-				/*
-				 * The reference already has the desired
-				 * value, so we don't need to write it.
-				 */
-			} else if (write_ref_to_lockfile(update->lock,
-							 update->new_sha1,
-							 err)) {
-				char *write_err = strbuf_detach(err, NULL);
-
-				/*
-				 * The lock was freed upon failure of
-				 * write_ref_to_lockfile():
-				 */
-				update->lock = NULL;
-				strbuf_addf(err,
-					    "cannot update the ref '%s': %s",
-					    update->refname, write_err);
-				free(write_err);
-				ret = TRANSACTION_GENERIC_ERROR;
-				goto cleanup;
-			} else {
-				update->flags |= REF_NEEDS_COMMIT;
-			}
-		}
-		if (!(update->flags & REF_NEEDS_COMMIT)) {
-			/*
-			 * We didn't call write_ref_to_lockfile(), so
-			 * the lockfile is still open. Close it to
-			 * free up the file descriptor:
-			 */
-			if (close_ref(update->lock)) {
-				strbuf_addf(err, "couldn't close '%s.lock'",
-					    update->refname);
-				ret = TRANSACTION_GENERIC_ERROR;
-				goto cleanup;
-			}
-		}
 	}
 
 	/* Perform updates first so live commits remain referenced */
-- 
2.8.1
