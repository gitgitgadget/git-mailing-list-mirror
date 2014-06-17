From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 21/48] refs.c: change ref_transaction_create to do error checking and return status
Date: Tue, 17 Jun 2014 08:53:35 -0700
Message-ID: <1403020442-31049-22-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:58:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwvmD-0000KR-KJ
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933610AbaFQP54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:57:56 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:42906 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756244AbaFQPyG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:06 -0400
Received: by mail-pd0-f201.google.com with SMTP id v10so601254pde.0
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P3gIA05E5q5gaq8BQDjaMqPYkj03w5X8H1/t1q7vdxs=;
        b=FlkgFjFkl+prbiSpCNf4oPl0f+7dwKZYmKv7oRg/3uX5Mqd/kZeSO8tNiQSUtKoH6b
         zCkmLYvGfQRLM2T4IJ0gpmCoOn/sRZiYLATMtRV1gRT6ixmwJirvhbTg9Ev900PtPUm1
         7M86iyjhnJ/OFXpnL9DYO91lCIkfqyhapHSSDuVdgPBpykgVD5vTKTGwbQKGWSV1+K7a
         t/Hw7toRD+dnoAYyvFT3qpqNtmUmoasQBRC3DVwRjYbFJwgd1u9O2f1L3NURlt7m9NRb
         F2VgxqFsSMz6qw0UUz0Zcsal5dv23TQWaWW+bmfw5Meh+hbF3Gls1oFHlv6jE5XJMEtP
         sSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P3gIA05E5q5gaq8BQDjaMqPYkj03w5X8H1/t1q7vdxs=;
        b=BsDG3PR4h0oiqspBgbDlKOomLGd/T/4XJJPOmHmUPqF+Srt67UnJQYDv8zz30cJSA/
         Qk96lbGIwPYfARaf+qGCAAQMHjcibgMXceak23V5eT9H3WbaS2teC8PTxP9qV+uLQY2Y
         Z6WjfSqOfHOIDyvpPm5LG+grRMZwPny1xpfTCpkZDtQZkMM0PcIqkIHeZYZwsTcFvHaB
         oVBklLsWTDF5J+gbDv521LqKO+C+6SMM/Qy9p2WWk4uX26KF7Te14LPlLjR/fAHH8W7w
         ETcqrw6PX4YG30BeqvXtv2Sgnm0FlqdegllUuVQOyvi5BZ40jMj0IKiVP24M2yAU4Bje
         QTPg==
X-Gm-Message-State: ALoCoQnbSPIg/sEyvNeQy13m53lFeLJL/UdCXTx/fdR7x2Ys7B1Zich4OEiJL52fGG7OjVUo/6ey
X-Received: by 10.66.138.17 with SMTP id qm17mr3707586pab.34.1403020445140;
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si1207437yhl.7.2014.06.17.08.54.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id DF97A31C76D;
	Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BBEB4E1158; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251919>

Do basic error checking in ref_transaction_create() and make it return
non-zero on error. Update all callers to check the result of
ref_transaction_create(). There are currently no conditions in _create that
will return error but there will be in the future. Add an err argument that
will be updated on failure.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  4 +++-
 refs.c               | 18 +++++++++++------
 refs.h               | 55 +++++++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 3067b11..41121fa 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -226,7 +226,9 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("create %s: extra input: %s", refname, next);
 
-	ref_transaction_create(transaction, refname, new_sha1, update_flags);
+	if (ref_transaction_create(transaction, refname, new_sha1,
+				   update_flags, &err))
+		die("%s", err.buf);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index 88d2df4..78ae4f0 100644
--- a/refs.c
+++ b/refs.c
@@ -3472,18 +3472,24 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	return 0;
 }
 
-void ref_transaction_create(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    int flags)
+int ref_transaction_create(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   int flags,
+			   struct strbuf *err)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
+
+	if (!new_sha1 || is_null_sha1(new_sha1))
+		die("BUG: create ref with null new_sha1");
+
+	update = add_update(transaction, refname);
 
-	assert(!is_null_sha1(new_sha1));
 	hashcpy(update->new_sha1, new_sha1);
 	hashclr(update->old_sha1);
 	update->flags = flags;
 	update->have_old = 1;
+	return 0;
 }
 
 void ref_transaction_delete(struct ref_transaction *transaction,
diff --git a/refs.h b/refs.h
index 6c99ccf..d1ba4e8 100644
--- a/refs.h
+++ b/refs.h
@@ -10,6 +10,45 @@ struct ref_lock {
 	int force_write;
 };
 
+/*
+ * A ref_transaction represents a collection of ref updates
+ * that should succeed or fail together.
+ *
+ * Calling sequence
+ * ----------------
+ * - Allocate and initialize a `struct ref_transaction` by calling
+ *   `ref_transaction_begin()`.
+ *
+ * - List intended ref updates by calling functions like
+ *   `ref_transaction_update()` and `ref_transaction_create()`.
+ *
+ * - Call `ref_transaction_commit()` to execute the transaction.
+ *   If this succeeds, the ref updates will have taken place and
+ *   the transaction cannot be rolled back.
+ *
+ * - At any time call `ref_transaction_free()` to discard the
+ *   transaction and free associated resources.  In particular,
+ *   this rolls back the transaction if it has not been
+ *   successfully committed.
+ *
+ * Error handling
+ * --------------
+ *
+ * On error, transaction functions append a message about what
+ * went wrong to the 'err' argument.  The message mentions what
+ * ref was being updated (if any) when the error occurred so it
+ * can be passed to 'die' or 'error' as-is.
+ *
+ * The message is appended to err without first clearing err.
+ * This allows the caller to prepare preamble text to the generated
+ * error message:
+ *
+ *     strbuf_addf(&err, "Error while doing foo-bar: ");
+ *     if (ref_transaction_update(..., &err)) {
+ *         ret = error("%s", err.buf);
+ *         goto cleanup;
+ *     }
+ */
 struct ref_transaction;
 
 /*
@@ -248,7 +287,7 @@ struct ref_transaction *ref_transaction_begin(void);
  * it must not have existed beforehand.
  * Function returns 0 on success and non-zero on failure. A failure to update
  * means that the transaction as a whole has failed and will need to be
- * rolled back. On failure the err buffer will be updated.
+ * rolled back.
  */
 int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
@@ -262,11 +301,15 @@ int ref_transaction_update(struct ref_transaction *transaction,
  * that the reference should have after the update; it must not be the
  * null SHA-1.  It is verified that the reference does not exist
  * already.
+ * Function returns 0 on success and non-zero on failure. A failure to create
+ * means that the transaction as a whole has failed and will need to be
+ * rolled back.
  */
-void ref_transaction_create(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    int flags);
+int ref_transaction_create(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   int flags,
+			   struct strbuf *err);
 
 /*
  * Add a reference deletion to transaction.  If have_old is true, then
@@ -282,8 +325,6 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
  * problem.
- * If err is non-NULL we will add an error string to it to explain why
- * the transaction failed. The string does not end in newline.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   const char *msg, struct strbuf *err);
-- 
2.0.0.438.gec92e5c
