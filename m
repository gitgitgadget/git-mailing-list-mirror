From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v21 18/19] refs.c: remove the onerr argument to ref_transaction_commit
Date: Mon, 14 Jul 2014 13:59:00 -0700
Message-ID: <1405371541-32121-19-git-send-email-sahlberg@google.com>
References: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 23:00:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nLv-0003E7-EI
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 23:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757252AbaGNU74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 16:59:56 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:62753 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756976AbaGNU7I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:59:08 -0400
Received: by mail-oa0-f74.google.com with SMTP id eb12so789696oac.3
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KRfgJhoCwm3j/JsOQFfE/hdpOgldPJmk47emsSvftqg=;
        b=MVa3++jFe4bQ4Yfcg9J7VR/ApvQGgV8WFYfWBdFY2AC/BBy43PAJkhk0Fieyw54DR9
         IsE2Masc03THjFj67KaHtPwBs5jHw3/sb7hrAzMQC4RU8rFB8rjA8OeFnlYRdk5h3o0K
         u7Rha3ceufe8Lyaeet6sHYmrDM/8i9/mfPU/cyxtaUr5fRt1P9AP7/99uON9sO8czfkC
         fl7sgK+GKlY+haUmVgCBP2RKOL2SYW7Mba4QAI1YUozVSdiYaAvseRFUZyi0TQot7bVA
         xDVPJSWDMLDc1N+HOO5hesIzZCmYkOlbpMEKyfQ9AlTQtnYZs1vlMBL8nKkp47m3CCmj
         FXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KRfgJhoCwm3j/JsOQFfE/hdpOgldPJmk47emsSvftqg=;
        b=HjqsK1TUoXqk+eVT5FQ+dj+5Z8fibWTS9YLLRXus4qMYZ3TJkJBDcWoWopU5NS4IqW
         8Fu+xXU+QqsnVhHjajK2nmoIp4YQkmVQ5wYpv01LQL8Rkc6W1T9QXshwGkhNUmW0hhyc
         lFeOO/51otM52SM+ZUj9tQaN0RpdPdI6WUXPHeVVlqaqn+NV99RZq+kzZ1JF6bXh21n2
         Dq1qvBai5pmXUHOtjP5Jl1bxfSh6WN0V47cgdrv6AIHbES2cTBlue5/8kE4SIoQXKI/I
         ttGWjeIu8BZ47oO06P/GHVeM7c5IQCiD3MbdX4/KYYCL5WYVgUMeac40BYi65mQfEBZ5
         YvTQ==
X-Gm-Message-State: ALoCoQnc1tbS055pvAX1zByIRSc9Dsr/z/Aho3eTZ+lgnXbJOZMkKuapL0WGJ03kUACCmgvLVGwL
X-Received: by 10.43.98.71 with SMTP id cn7mr9567117icc.14.1405371546425;
        Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v12si822290yhe.2.2014.07.14.13.59.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 19AC431C548;
	Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id F0878E07FA; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.546.gf603308
In-Reply-To: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253533>

Since all callers now use QUIET_ON_ERR we no longer need to provide an onerr
argument any more. Remove the onerr argument from the ref_transaction_commit
signature.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
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
index 003b313..4f78bd9 100644
--- a/refs.c
+++ b/refs.c
@@ -3491,8 +3491,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
-					struct strbuf *err,
-					enum action_on_err onerr)
+					struct strbuf *err)
 {
 	int i;
 	for (i = 1; i < n; i++)
@@ -3502,22 +3501,13 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
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
@@ -3532,7 +3522,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, err, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err);
 	if (ret)
 		goto cleanup;
 
@@ -3544,7 +3534,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       (update->have_old ?
 						update->old_sha1 : NULL),
 					       update->flags,
-					       &update->type, onerr);
+					       &update->type,
+					       UPDATE_REFS_QUIET_ON_ERR);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
@@ -3562,7 +3553,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
index e588ff8..163b45c 100644
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
2.0.1.546.gf603308
