From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 01/20] refs.c: change ref_transaction_create to do error checking and return status
Date: Tue, 15 Jul 2014 16:33:59 -0700
Message-ID: <1405467258-24102-2-git-send-email-sahlberg@google.com>
References: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:34:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CFN-0003Pj-5d
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934340AbaGOXef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:34:35 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:64945 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934222AbaGOXeX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:34:23 -0400
Received: by mail-pd0-f201.google.com with SMTP id v10so40109pde.2
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pX34y82P+M3cQmA0J3vSY70rKztdWRJwcqrjwuys0TA=;
        b=f/fYOg8kcTuxl1G7CRPJmaaJQLqizELGTMVJPqs8sRzl++Jx4GKb9H2TiDysusSKAI
         BJx4lOu1xZOmwZbERuoqgsEVoELJMccNt6fT0s5DEHB0Jsd3ld1/1wbrOr7P/AWy0i7x
         mIdGq2wzd+C3hWici33uWlLjrxDr5GfD3NV10TTnID1fnsyh/vliFcJZK7v8S4XL+f+B
         cCrHWgzAr0gEj+BjVAILcv+85fGfmu2y77ow2CeVCprp+gXs5th4ymXydD5i4M3LX8o0
         J+abRTvk36lMOvBDHMo4MH5gv4rksW0QAGWT84eJoopiU7H6FmV6unrWPi1kPoIB8aEe
         mPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pX34y82P+M3cQmA0J3vSY70rKztdWRJwcqrjwuys0TA=;
        b=NGXMiB3x+Fn5/AiczPSesk76SPdBXwlVZewlEgml97eJeCW4j3yEfVEh1CWl9Vihkd
         9FlTsKV8vVWJ1ThhlQifBBX1jC7MjjfHBwjJV2q0s4Nj2UBRpKTi5tiQEMCy2mxd6R6M
         xm1Ki2Dph/nirnkyGjcudTCNuMwhGXYd4KXizR4i+Acidky1UuKXR7VAizs/2CBQB3wI
         atq6y1c3z0JXuL5wpg0Z88QTqJjgw+/rG2CGKSbOUtTgQIW2Kz7u0REiIlREdcuuqUrs
         ityAm8uLL+BturSPT1IR+msft0uBlIBCsIaqIefPx9vn+kZhnmZA98yYMCO3WoloJhEJ
         gl2A==
X-Gm-Message-State: ALoCoQn4yUkKPo2awC+vVDyNejpB3BZUgd+Zlo5MkasxsunPd7PmmThH6wC/cztyflXg0u/M/RdL
X-Received: by 10.66.121.2 with SMTP id lg2mr12607583pab.43.1405467263205;
        Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si1060118yhk.4.2014.07.15.16.34.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id F02A231C2EA;
	Tue, 15 Jul 2014 16:34:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 99B3CE0C77; Tue, 15 Jul 2014 16:34:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.481.gb244468
In-Reply-To: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253627>

Do basic error checking in ref_transaction_create() and make it return
non-zero on error. Update all callers to check the result of
ref_transaction_create(). There are currently no conditions in _create that
will return error but there will be in the future. Add an err argument that
will be updated on failure.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  4 +++-
 refs.c               | 18 ++++++++++++------
 refs.h               | 48 +++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 56 insertions(+), 14 deletions(-)

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
index 3f05e88..c49f1c6 100644
--- a/refs.c
+++ b/refs.c
@@ -3449,18 +3449,24 @@ int ref_transaction_update(struct ref_transaction *transaction,
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
index c5376ce..b648819 100644
--- a/refs.h
+++ b/refs.h
@@ -10,6 +10,38 @@ struct ref_lock {
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
+ * err will not be '\n' terminated.
+ */
 struct ref_transaction;
 
 /*
@@ -248,7 +280,7 @@ struct ref_transaction *ref_transaction_begin(void);
  * it must not have existed beforehand.
  * Function returns 0 on success and non-zero on failure. A failure to update
  * means that the transaction as a whole has failed and will need to be
- * rolled back. On failure the err buffer will be updated.
+ * rolled back.
  */
 int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
@@ -262,11 +294,15 @@ int ref_transaction_update(struct ref_transaction *transaction,
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
@@ -282,8 +318,6 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
  * problem.
- * If err is non-NULL we will add an error string to it to explain why
- * the transaction failed. The string does not end in newline.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   const char *msg, struct strbuf *err);
-- 
2.0.1.442.g7fe6834.dirty
