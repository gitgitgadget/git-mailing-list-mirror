From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 13/41] refs.c: change ref_transaction_create to do error checking and return status
Date: Tue,  3 Jun 2014 14:37:31 -0700
Message-ID: <1401831479-3388-14-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:38:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwPo-0005eg-0J
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934349AbaFCViZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:38:25 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:43423 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934208AbaFCViI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:08 -0400
Received: by mail-ie0-f201.google.com with SMTP id tp5so1464377ieb.2
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sb5GXbyYuYgW+c+1ZftgI907E+Y6UuWxVLyPsXjDGsk=;
        b=dOrENaavKQJLvXI+yx8RM3ZFBF424LjjLdHeO7h74eLAKTjcz49hGkS/yyMxNWSPv8
         HxoipWgjVFWcLbYXp4cedvZJaspnT+RpzrW5eRh5jdyairkoh+wD5E6QuAO4oLUeIhXC
         Mk5svn4kwvcnuhzpO4DYEJ4d0HeXjFNhr1P6dQ39l6D74oGW3APD4o0E4rdmqcZ+xMWB
         cl9FjDcc2cvyg9Qeazb1lzjLp+6IFVCl88Z91BQH8PVRofHYXNyqQGIhi0sFsg9JGNa3
         EucfL7+iGheYGBv/kkMW7Vn5fOFrUTwtTxZTtPl04upqcvRrg2YCUrI5tcUAnL3rrgJg
         b1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sb5GXbyYuYgW+c+1ZftgI907E+Y6UuWxVLyPsXjDGsk=;
        b=LB/oYbjNo6GELVIJHwyG95VYw/A2NfbgyWo/XlNOVi9cRnasiwYlMw3lPcSFf4VclR
         F/2QLCTcmUmFrdcCg4mG/xiqMUyllDB8uZF4Ww1cmNs8aAhPy14J6g3GH43oFlbbyPMb
         lVv/OBdF78nhKVOKqQpgYjSMKjgETg1bth93rfb0YEKlZ20KuBo9WHFSAkAYa6q4KN1L
         j4aZVBljdCCHZCTuRsbGUFHpd+1rddVVAAOzAiBB26K5JVl6MODlOWn9zi7+2kLrHDZy
         e2pYRmN9F0qYia9E0ycHE4R78lx1gynlo6Nbdzxd6tgp9t7u5wSWDdowaicqUz2Ds3gL
         NIqg==
X-Gm-Message-State: ALoCoQklvXrhNSVHx+11HikpG4uPIn5gkPOUNzyrXlBjx8LHjME1Cqntq40SAC1U1GHM7ng2QRzO
X-Received: by 10.50.79.129 with SMTP id j1mr11071714igx.7.1401831487683;
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si30040yhb.3.2014.06.03.14.38.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 60C805A43D0;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 20CEEE07FA; Tue,  3 Jun 2014 14:38:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250656>

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
index f5e7a12..3cb99f6 100644
--- a/refs.c
+++ b/refs.c
@@ -3439,18 +3439,24 @@ int ref_transaction_update(struct ref_transaction *transaction,
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
index 32edf3f..bda790e6 100644
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
@@ -236,7 +275,7 @@ struct ref_transaction *ref_transaction_begin(void);
  * it must not have existed beforehand.
  * Function returns 0 on success and non-zero on failure. A failure to update
  * means that the transaction as a whole has failed and will need to be
- * rolled back. On failure the err buffer will be updated.
+ * rolled back.
  */
 int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
@@ -250,11 +289,15 @@ int ref_transaction_update(struct ref_transaction *transaction,
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
@@ -270,8 +313,6 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
  * problem.
- * If err is non-NULL we will add an error string to it to explain why
- * the transaction failed. The string does not end in newline.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   const char *msg, struct strbuf *err);
-- 
2.0.0.567.g64a7adf
