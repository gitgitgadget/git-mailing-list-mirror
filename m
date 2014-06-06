From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 13/40] refs.c: change ref_transaction_create to do error checking and return status
Date: Fri,  6 Jun 2014 15:28:51 -0700
Message-ID: <1402093758-3162-14-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:29:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2du-0002LL-Sg
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbaFFW3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:29:34 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:48702 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471AbaFFW3W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:22 -0400
Received: by mail-ob0-f202.google.com with SMTP id wm4so742273obc.3
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DaNvoHEyGyMGp0HhOfneg/yvYcnRfN7yoKwydAAjoT8=;
        b=XejIj0EAKKijW8hxi1Qu1G7XNx1bkdsLQacA/BytGqKFJJh1/5G7R/7fx/UXYnsnen
         8kmWSr2tRqGsF3++ZZiSb+w9emE+FfNI2+8vz+phrtpK0O09laJkyHLyvuwKgrtf1IWV
         p/5bUlil+eb37V4NHVG3b3+jjO+wyC+sYIF2ZEoFsOZLwxdwi/9dNt1idAgIGYmYaGQh
         XU8K+lA0xefo7Onej0XdWX9Ak/LsCQjQ15QjfwhJYvsfIMI58AnDaRoADLrzhBWDeyI+
         5pwEeLKtM4ytK+4T3UNtcYYpZWdmmD12fyvDxX+dy+IkV4B2ywYib+YxxH51R4FuK8dF
         K3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DaNvoHEyGyMGp0HhOfneg/yvYcnRfN7yoKwydAAjoT8=;
        b=PS75cKZPijMJLZp70p5FtiZAQRMIUuJg1BXY/wONk2NzOHd/Iz10/N22ZPJIIh4tnC
         7Y/fHhcNAuxlWupl/lEhjJ0qVX/isooTnXAJYMHpT4oY8NotEVzmhklaDV3xrIZAPxUp
         pLD4A5noEn05VNNJuvxKZ8Zm/40xaWIZGiWffOvTTaIX47rHVPuUf+kWzhTj0CHTGeCl
         rto9ZPh1wPcJ7mvtUfjY0u3rnuNmCSkc3xAuc2b2EMEnKI4XHqX2YGHlRSV2PmpdyHkt
         oDTADUHfqbC2X3geWUwRSrZUItb6S0Q/tGgf05hAcfOOIG5O9xiw9MEV1nlIQZOhtPwn
         QYDQ==
X-Gm-Message-State: ALoCoQkV1yrITAtvcVqXvwRQWPyI+MiN/w/dgGRhmObpNU1ZbCKGq1N5Kplru4xcPaElg/oiftwi
X-Received: by 10.182.86.5 with SMTP id l5mr4567748obz.32.1402093762364;
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id pr8si750954vdb.1.2014.06.06.15.29.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 0F1855A4515;
	Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DF71BE109D; Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250977>

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
2.0.0.582.ge25c160
