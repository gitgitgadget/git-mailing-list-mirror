From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 07/27] refs.c: remove the onerr argument to ref_transaction_commit
Date: Mon, 28 Apr 2014 15:54:22 -0700
Message-ID: <1398725682-30782-8-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:55:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuS2-0005nE-NL
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854AbaD1Wyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:54:52 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:61257 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740AbaD1Wyt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:49 -0400
Received: by mail-vc0-f202.google.com with SMTP id lc6so276286vcb.1
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YsQW1gNxbL02srnJ8neR9sU48c+wWRYlGahy7qL7nvw=;
        b=AR23h/KhVNUNEsdPj0UsP4eKYBNGcM7S9e4rIiHUKth+WqN112UikhX8Zk5+OHCSl0
         y+N7OVUJ4/sUv+SiW6hTTaIm+Uity2pYM/dmUw5KCmZoSbcXoVF9skFYnJM1O/cgQCby
         A3MmTM1w446/5ULEfDjfyXnRtUMmrpFQjQjCX79RmRaIC/zIuTCuEMtm9yxpcNr3556P
         DeHo3alNoEz0zMDLxfzG/wIus24dJv07HKjbUqTd/VmWinnn6Ocfdvh5rS2LBpw3Ow5V
         jP8qt3/I+Fqix/Sd92OvxPjSlAest2+NQtZ9moySoyTRl67iEnzVZMkgrv45iv8JYN4M
         HrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YsQW1gNxbL02srnJ8neR9sU48c+wWRYlGahy7qL7nvw=;
        b=Fyf1NMpBjGD8mZtm9+EknSXovsKMtVFBJB8u+3jRxA4BR96cfIcZevdgmNVhQAjs+I
         3K7msEnYFICUfU5JCvU+W6sUpoDphcossK1Wp3ALmuu+iMf1NhTW0FSOPXeA8WamMwe8
         V1Un7kdF8VylTBPdDgCHRzcx2lGxnZurgQNBVk+bFfo5DvF+WwCHDC4sZgRcqz1eH0AD
         lQVgIPMInV7B3z5D7dvaGMW0S0vCJWwUGUk/qS6pAvGxhNRhac2Og/gxx5tXRqRTgo3s
         nl507hl/5jgaCLsAsNFzX7aeUb5AioEEXhY15HBNYZ0Z7Bcar6Ble7hKREtgarY2XwWH
         GNjA==
X-Gm-Message-State: ALoCoQmtBUg/nOsJOfTzHcgfVvRtRD3BOic4w9FK9QZeMpVB833vvqPvRxZPRtxFNSutjP8sH9J6JWzNt72BDD7dxc4wp7DDzymctqEsRrQA1GJLo7twt5dsb6w5eAHNsOAwS7hfv3Gu9jRPnCSpMXLB50Lj14edAxD226aLx526C8DW46mSSZ5NgXdGTAFuFmBbVJmKiM+5
X-Received: by 10.224.29.129 with SMTP id q1mr14091269qac.3.1398725688635;
        Mon, 28 Apr 2014 15:54:48 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si2350741yhk.4.2014.04.28.15.54.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:48 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 27A8E31C20B;
	Mon, 28 Apr 2014 15:54:48 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id CDAD5E080D; Mon, 28 Apr 2014 15:54:47 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247464>

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
1.9.1.528.g98b8868.dirty
