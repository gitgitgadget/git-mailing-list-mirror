From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 19/48] refs.c: remove the onerr argument to ref_transaction_commit
Date: Tue, 10 Jun 2014 15:29:07 -0700
Message-ID: <1402439376-25839-20-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:37:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUZ9-0005Ui-1C
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbaFJW3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:29:50 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:63649 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-qa0-f74.google.com with SMTP id w8so293941qac.5
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h/2iKWzIrObXSJ6KKZ5Grb46dLedZupfzVzORVUPz9Q=;
        b=dGI8nCTweHlYIsuarpGpgvzgFGpVUwgYPb3XooRWk87eqLqt9Gji7ogA8UwEeE3CBz
         PUOgsJRmbaHMCqKmLkmPhVH2/LCCZHB6SLOvNhw2gHNbcgtgucqRyPm8k1whFF9K0Dcr
         LLG+MC9Yw0OwGqNpS21xf8sbjgsbKeMF0WwmHMKxFqebh1mRYQ/mVN8NqIO01M+nxoQi
         FeuwZL28Aot72EiALyvB/5xSBLEqRkLAcuz0ru8JFY7d8zUB3QwUFT7MRiXGYBXDkdo0
         qPa/tIcgP0+cQBJvou4dmqz+i79yiFPgg8ezNxK+6sB6lmdSxP60vGUAZVKoQfpvghYW
         NfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h/2iKWzIrObXSJ6KKZ5Grb46dLedZupfzVzORVUPz9Q=;
        b=GwWkt1oZ/cD/bKCVHHBkQzCyb7Lvi6j/AuGmHMLRJBVy12Wsn5RitUnPXOrxjrrgBi
         Sp6CT7GtM2p08xDs1waV/A4Pl4WpAf1P+AzjEBY21CmL8ZxomFnrjvBp3A6n5MUZ/Wdy
         iqQnBoPMOw1IMrQTffW7Be4TTbe9czZyS5zrjNgYZheET4SUlP4uJSVACKId/vmMpgqI
         HJMOAPSniCdSAqdhznQNJC0+zbM3OmlznZxqaIzscHLtFk3rmj0xzTD0Rkd7H7YhYhTG
         yHfNWmwoE8C1ubBh4r/1DGjRsDeo7ziZbE9QlAwWv9R4HSqLmu0EVDBn+heOGaXFGngG
         Q3ig==
X-Gm-Message-State: ALoCoQksE73JgMODQ703M3Ve079b+5s1+uWEferdj3o3pIKJsHZ+eVAl50FgXb3w6/RVOjUZJg6s
X-Received: by 10.58.198.231 with SMTP id jf7mr1148066vec.19.1402439380866;
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c22si1396560yhe.1.2014.06.10.15.29.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8941F31C750;
	Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 64264E127B; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251279>

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
index 1fe4dcb..0b1c449 100644
--- a/refs.c
+++ b/refs.c
@@ -3488,8 +3488,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
-					struct strbuf *err,
-					enum action_on_err onerr)
+					struct strbuf *err)
 {
 	int i;
 	for (i = 1; i < n; i++)
@@ -3499,22 +3498,13 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
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
@@ -3529,7 +3519,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, err, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err);
 	if (ret)
 		goto cleanup;
 
@@ -3541,7 +3531,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       (update->have_old ?
 						update->old_sha1 : NULL),
 					       update->flags,
-					       &update->type, onerr);
+					       &update->type,
+					       UPDATE_REFS_QUIET_ON_ERR);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
@@ -3559,7 +3550,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
index 86f0984..1eb447d 100644
--- a/refs.h
+++ b/refs.h
@@ -278,8 +278,7 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * the transaction failed. The string does not end in newline.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err,
-			   enum action_on_err onerr);
+			   const char *msg, struct strbuf *err);
 
 /*
  * Free an existing transaction and all associated data.
-- 
2.0.0.574.g30c2c5e
