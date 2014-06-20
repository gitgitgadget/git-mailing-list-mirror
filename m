From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 20/48] refs.c: change ref_transaction_create to do error checking and return status
Date: Fri, 20 Jun 2014 07:43:01 -0700
Message-ID: <1403275409-28173-21-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:47:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy05o-0004LJ-AA
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211AbaFTOqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:46:18 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:42964 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201AbaFTOne (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:34 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so979782iec.0
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kHsQBc61WX4W0Ulyx0tZg227UzOxAkI9G0XaMeYLwd0=;
        b=eM0EpVizpAVqKRQNixgrEXrdU0hSKc9YMkJ8s6iNUyibHAzLf8ORAuI9Am9+KWurfO
         kPeTzsiYbyarxRSuHq9ouEDtM1pml+WoAuX+15uPdc7USSw7Gm//lSpSAa2zq7CvQSPF
         U9QDk/VmlxwlBJZTgXMHTogZ3IJ59I3aawATT9L7N8PWAXYu7NXjyla7qIm4cgwE0eoe
         L2uunhGmsEpXla3hTNIAtPK2OfPVY2rKn0H9xM9OHbcfBOytDNMUwEl7AA5NedDOJw95
         CyWjdp6A7tmAMKWbb45LL16/LE6BabtGJGGhVdZRStbVmSxxSPkD3H7w4tjn+PVp+znF
         aXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kHsQBc61WX4W0Ulyx0tZg227UzOxAkI9G0XaMeYLwd0=;
        b=MHoQt8jZZ36l7RTSPMBvgT051Hevmi0rdjy2zNlFDZU1CNvvWxKGvJ1tueKpSibr37
         +KgOqqeHE29z6iElZx4ethhDU51gyHf9G3JScUUtkEnd3oDSndlMdpOFmrxY/ecxF3ed
         s5OU0+CLIDMznekSIGmMVWFumClcjhkn3h3irbtj+XEm/NUJQSQo1iUSP9lQ8qGwbQ7O
         cCM9k4KP9B6ndj/vle1+yLInI/xilHcv8kKcKOIxKM80dB0s7ruObVohuKvSjErvog8V
         jobZ8hQ66XyQCivYm1hsa2xbCERk6SFkUjbd0q8PoBq6+NfThOPos4k1jF8GSJ7ngu9N
         Z6qQ==
X-Gm-Message-State: ALoCoQlOd+AC2QzdSwxFb43szjAJ3DjOGJQbzo1Gl6zr0Peh4Z8PZ+WA/UTA1KEoewAQ3EhzJiyl
X-Received: by 10.42.249.207 with SMTP id ml15mr1399320icb.21.1403275412898;
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j43si432420yhh.5.2014.06.20.07.43.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id AB9185A44A6;
	Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 87C08E15A5; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252272>

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
index c5376ce..33b4383 100644
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
2.0.0.420.g181e020.dirty
