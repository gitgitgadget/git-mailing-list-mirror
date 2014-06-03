From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 11/41] refs.c: remove the onerr argument to ref_transaction_commit
Date: Tue,  3 Jun 2014 14:37:29 -0700
Message-ID: <1401831479-3388-12-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:38:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwPf-0005YP-Er
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934358AbaFCVi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:38:27 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:55939 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934192AbaFCViI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:08 -0400
Received: by mail-ve0-f202.google.com with SMTP id pa12so1409619veb.3
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=38HFrUkarkH2DTykhbgMiv6Ys19VdINtUaa4G4OsG7w=;
        b=d0+jQoJ9EOqxDIBQCMkoewBDJrKnA97GCT8DAlUtKzKzetokkzctXftejSYJcT+Y+6
         CBVVl5hITOjivsgPXmGHg6+nIFViCw2oH9mX6Dd3e/hevI/RPhQObUpr1/qGUn4pUSSi
         jLK0WqTWmrEcmLXJQ9LuXkgFyLhDA20TlGtZA4LiJ9iE6HA1mp7rKxLsZVPlhi3GvRKw
         YXwGNSUrKgcJ23LXZLKYrhmIs5Hhu8h5pvASgjfcljUDkbP6lhqQJpWGxcvKi6Sld3vs
         ZERm4wBMyJWCE5AqMGoWRed9PhId9ibNWKuSr60jdQTGmfYm/TaubT0TG5+fddlnmLTi
         PtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=38HFrUkarkH2DTykhbgMiv6Ys19VdINtUaa4G4OsG7w=;
        b=VM6wOU0V0+nUqiwJQP38u91XBtzOPZkldYULLQc90woJLrtHBNEUX3P9jBSuEsVkPB
         L4F8JQPP19o+AdpnunkKD7MDZD0oKJClufn7A6TWdaOLF1/4nuXCUMdcxtBbTyoMTCm5
         H2XDapWJoOCxi9H9ePPwYHMK8TyFS+slnleKnQaotUQ9jMTLeHXVFEFEQ3xlaeRiKFl9
         pgLqDftVkatq3cFvZdqTIq7UiWCwBF+F1ZITy0iCABB8fFllRJwFY1FRJhB+HBTKsAYt
         Ct2oidSS5aiFPZsrKaeJ0UyBEiQIZ/GUdpMaIJO7KHHPO1WUHDZS7VVEHbjbyiY58wv3
         +VQA==
X-Gm-Message-State: ALoCoQnGBoOxO2JpAr/3PPKXmj8Ycd090JrtvekdOh2VtHJPDAQiIH3RTR7l2y6SHy8PWUeFamRG
X-Received: by 10.58.18.200 with SMTP id y8mr18806392ved.20.1401831487428;
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si29244yhj.5.2014.06.03.14.38.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 2F6F25A43CF;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E3755E00FA; Tue,  3 Jun 2014 14:38:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250655>

Since all callers now use QUIET_ON_ERR we no longer need to provide an onerr
argument any more. Remove the onerr argument from the ref_transaction_commit
signature.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  3 +--
 refs.c               | 22 +++++++---------------
 refs.h               |  3 +--
 3 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index aec9004..88ab785 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -366,8 +366,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		if (ref_transaction_commit(transaction, msg, &err,
-					   UPDATE_REFS_QUIET_ON_ERR))
+		if (ref_transaction_commit(transaction, msg, &err))
 			die("%s", err.buf);
 		ref_transaction_free(transaction);
 		return 0;
diff --git a/refs.c b/refs.c
index 6696082..fb44978 100644
--- a/refs.c
+++ b/refs.c
@@ -3481,8 +3481,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
-					struct strbuf *err,
-					enum action_on_err onerr)
+					struct strbuf *err)
 {
 	int i;
 	for (i = 1; i < n; i++)
@@ -3492,22 +3491,13 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 			if (err)
 				strbuf_addf(err, str, updates[i]->refname);
 
-			switch (onerr) {
-			case UPDATE_REFS_MSG_ON_ERR:
-				error(str, updates[i]->refname); break;
-			case UPDATE_REFS_DIE_ON_ERR:
-				die(str, updates[i]->refname); break;
-			case UPDATE_REFS_QUIET_ON_ERR:
-				break;
-			}
 			return 1;
 		}
 	return 0;
 }
 
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err,
-			   enum action_on_err onerr)
+			   const char *msg, struct strbuf *err)
 {
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
@@ -3522,7 +3512,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, err, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err);
 	if (ret)
 		goto cleanup;
 
@@ -3534,7 +3524,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       (update->have_old ?
 						update->old_sha1 : NULL),
 					       update->flags,
-					       &update->type, onerr);
+					       &update->type,
+					       UPDATE_REFS_QUIET_ON_ERR);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
@@ -3552,7 +3543,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			ret = update_ref_write(msg,
 					       update->refname,
 					       update->new_sha1,
-					       update->lock, err, onerr);
+					       update->lock, err,
+					       UPDATE_REFS_QUIET_ON_ERR);
 			update->lock = NULL; /* freed by update_ref_write */
 			if (ret)
 				goto cleanup;
diff --git a/refs.h b/refs.h
index 94d4cd4..6ee9c9e 100644
--- a/refs.h
+++ b/refs.h
@@ -270,8 +270,7 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * the transaction failed. The string does not end in newline.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err,
-			   enum action_on_err onerr);
+			   const char *msg, struct strbuf *err);
 
 /*
  * Free an existing transaction and all associated data.
-- 
2.0.0.567.g64a7adf
