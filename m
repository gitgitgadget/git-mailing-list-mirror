From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 07/42] refs.c: remove the onerr argument to ref_transaction_commit
Date: Thu,  1 May 2014 13:37:07 -0700
Message-ID: <1398976662-6962-8-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:40:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfxmX-0003kt-Ut
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbaEAUk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:40:27 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:58295 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbaEAUhs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:48 -0400
Received: by mail-vc0-f202.google.com with SMTP id hr9so230721vcb.5
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=myy6N3I/BIwfLyUpGuNr7ltMi+pWlOkrzmvrPtXdeCU=;
        b=h/JJRa37qYM+GlnwKfHMuZLIskZNtv00qmmG415db9GbrCg+IebEfFlhnrc97FYorp
         LQdFN66xxziWzcShnDMSuIi6uRRyN4uzvagmDjCtgkJd/Ty3vF+r4GWnPDN5c+aTAfBQ
         SEiJqtuaW79exUkuSa2RgDJJ2OeKNCr/+CfeFCJRtyNG2uHQ0kgkBBj83GIljA+kYYVB
         hrnoxRfBeUZiZ3hF0Iwmh7ZNpsPWu/fOvQMic7+DFSceIy+yLQtoPJO15YlIe6DKasO6
         7C3vICyVWQwu75a0j7RVVJFAbMOaR5rydWqmcDPN8IgFX9LhN9bHN/QqyfaE6v5DbEfa
         oZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=myy6N3I/BIwfLyUpGuNr7ltMi+pWlOkrzmvrPtXdeCU=;
        b=UgzZGsbPIZJwZWNNqL3+uWhLSjM9aMgxOn20awsfX+CjiA1B82OlS9lT36rrQKim+p
         N85ynVgrXkI1MwUuTLLGWjFeRNRxS7C2UduaZ9mAYK5D2RtGbrEDy2va6rIMgZN4odOJ
         o8bBe8fdhjCRsIutcfBWCmUNsKyJH1FjGgnRYBywbqfY+l5am7GTvuB/EwRZHgD34zDR
         7XHm+9043r4LP6fk05pjCDtNcL6LtOSvfMjtVueq6TvgxMhgKWCEHSHp+RTR56XWfqNl
         5t2LG+x/vd6v7XHNJzlOVShWscrtR5WyRK/FXkSk5vGVQKpcQ4bXRNlJhxv1/hD9T90x
         vTHw==
X-Gm-Message-State: ALoCoQkM2K818Kf5vNip5++lcmXQrV/OOgH1osqTPpooDsiWcq4r/9selvSJKHD9l+uGs2d4Uz0J
X-Received: by 10.236.94.238 with SMTP id n74mr5586374yhf.27.1398976667826;
        Thu, 01 May 2014 13:37:47 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si3538017yhe.3.2014.05.01.13.37.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:47 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 953B531C1CC;
	Thu,  1 May 2014 13:37:47 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 52FA6E097F; Thu,  1 May 2014 13:37:47 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247873>

Since all callers now use QUIET_ON_ERR we no longer need to provide an onerr
argument any more. Remove the onerr argument from the ref_transaction_commit
signature.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  3 +--
 refs.c               | 22 +++++++---------------
 refs.h               |  3 +--
 3 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 207e24d..2bef2a0 100644
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
 		return 0;
 	}
diff --git a/refs.c b/refs.c
index 5e06fd9..308e13e 100644
--- a/refs.c
+++ b/refs.c
@@ -3396,8 +3396,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
-					struct strbuf *err,
-					enum action_on_err onerr)
+					struct strbuf *err)
 {
 	int i;
 	for (i = 1; i < n; i++)
@@ -3407,22 +3406,13 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
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
@@ -3437,7 +3427,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, err, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err);
 	if (ret)
 		goto cleanup;
 
@@ -3449,7 +3439,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       (update->have_old ?
 						update->old_sha1 : NULL),
 					       update->flags,
-					       &update->type, onerr);
+					       &update->type,
+					       UPDATE_REFS_QUIET_ON_ERR);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err ,"Cannot lock the ref '%s'.",
@@ -3467,7 +3458,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
index ff87e14..bc7715e 100644
--- a/refs.h
+++ b/refs.h
@@ -272,8 +272,7 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * the transaction failed.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err,
-			   enum action_on_err onerr);
+			   const char *msg, struct strbuf *err);
 
 /** Lock a ref and then write its file */
 int update_ref(const char *action, const char *refname,
-- 
2.0.0.rc1.351.g4d2c8e4
