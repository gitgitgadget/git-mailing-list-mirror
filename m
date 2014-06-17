From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 19/48] refs.c: remove the onerr argument to ref_transaction_commit
Date: Tue, 17 Jun 2014 08:53:33 -0700
Message-ID: <1403020442-31049-20-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:56:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvkb-0006c5-Mk
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbaFQP41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:56:27 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:46084 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756283AbaFQPyG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:06 -0400
Received: by mail-oa0-f73.google.com with SMTP id eb12so1489275oac.4
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=88b4CdrjmxxMFmaWzE1EWy0/i1ls/Z30kjVEdDOY2sc=;
        b=R9gHyZJRlhLF1OR/MpeiKstRdsEn8tgXsNiDNkzMnTbFcojdlSUbM1afZtAMFllVyO
         n0gZ1cEnFr3nCRgzfecI+YiO3Lbl1Un/dRpp1jSamzAH21Ww2XIgJOaNsXdY500j4IkF
         zswvGnQ8b6N/4bxPRfakj8gUxwofmelYhlKjIkb4Gn4Zt0HAfJfOAlNf2gJttQ1jRvEg
         3uaBgW9yXfaV9YsJUB27aN7ungRZGklA/cL2/db0ynam04JjranCqlsOQMakmzcjOHiI
         9Z3DekpNBNqoWXKn2OVZi4uuPDAV+bF4bOl0e0EfhDPZZv3vOKHL6JZtX05nq+wqOW3a
         4mOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=88b4CdrjmxxMFmaWzE1EWy0/i1ls/Z30kjVEdDOY2sc=;
        b=fs7+m/1k9TQ3ZhyATAABnmVZlICXiva6oEwoBGgwu56uehdQvgKPwhC/EVG0V7mj11
         CA2Ny59jwd75YIXWL/nUWO5Tj+BNLs5kB3OHYWTIikugMH/l1mUbxmPwOONFJYrSDV4c
         WlEV/LNeKq1NjquiXddCArUWxXZFI53qt1sONUjt1cxr89FQr+wqzhW3ujsaPCCTFGDW
         8cY3HXUxTVgsSY8teEc75Tr+phfRL2bZQNTNR3P7Q5zxCbVhQ/hK3r0O802F7A5SZBN8
         OM2J7tjLIQDP4lwJdq171JLp0apewaSnMjJdnnosQOVq2LFQ+sJdnGZQ1//zij58BJEK
         Q9KQ==
X-Gm-Message-State: ALoCoQkOrlAMwkukjMapQ9ycJ+/2+42fsuseIhrNjHu2+7wGp4l5xnyTBao0+SIfQu6jgCLTZkxr
X-Received: by 10.182.28.136 with SMTP id b8mr329109obh.19.1403020445081;
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si1208714yhk.4.2014.06.17.08.54.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id BDA5E31C76B;
	Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 903CAE2068; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251907>

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
index 4ce8959..ebd4d59 100644
--- a/refs.c
+++ b/refs.c
@@ -3514,8 +3514,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
-					struct strbuf *err,
-					enum action_on_err onerr)
+					struct strbuf *err)
 {
 	int i;
 	for (i = 1; i < n; i++)
@@ -3525,22 +3524,13 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
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
@@ -3555,7 +3545,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, err, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err);
 	if (ret)
 		goto cleanup;
 
@@ -3567,7 +3557,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       (update->have_old ?
 						update->old_sha1 : NULL),
 					       update->flags,
-					       &update->type, onerr);
+					       &update->type,
+					       UPDATE_REFS_QUIET_ON_ERR);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
@@ -3585,7 +3576,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
index 593a459..c92f59f 100644
--- a/refs.h
+++ b/refs.h
@@ -282,8 +282,7 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * the transaction failed. The string does not end in newline.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err,
-			   enum action_on_err onerr);
+			   const char *msg, struct strbuf *err);
 
 /*
  * Free an existing transaction and all associated data.
-- 
2.0.0.438.gec92e5c
