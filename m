From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 05/48] refs.c: add a strbuf argument to ref_transaction_commit for error logging
Date: Tue, 10 Jun 2014 15:28:53 -0700
Message-ID: <1402439376-25839-6-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:39:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUa8-0006OG-2y
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834AbaFJWbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:31:46 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:37659 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219AbaFJW3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:41 -0400
Received: by mail-ob0-f201.google.com with SMTP id nu7so450825obb.2
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sZJsG1z78eJO+Jo1k/EYB8JR9iq3quU4xceG3MA8Tuw=;
        b=JDpnaVSie16xJFA0TbYbJojCJfD7Ios1lpPnAZLHZ9CBEj1BVMvXyEc5BpI+jZQ3gp
         6SqChH73GiizBOBbiCTq+TQ2CHjbOGNlFrzLqWRfj2uTUhs50Emidox4D9TIYDHheaq1
         vfwi6/jMu/8MFrw/cI0eE3KRszEDaVEXG5c3BdTs/83Sgc7SdfD3UjIazxElnaQrYQ5N
         EC3jdjL0bAPBCHw/Lfxv/wXjEpIhDi9/ZT5+RLen0YXi3sZNWzp8TsqP8baB3FUU0/Dn
         ifUEeI0qa9fT/qtkGCsr+kVdiwR01uXtLECn9LX1cAsFmfvC8Cfy0vtGBLY0JoVvcu3Y
         MnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sZJsG1z78eJO+Jo1k/EYB8JR9iq3quU4xceG3MA8Tuw=;
        b=blO7sM2A4CYbfnsV8fjpWNfAL6xDTaEL+MQlWW6nBVAMTIdxWyRhD4i0V+cGc3cS+G
         DqcYDDHp/v8EB9ig+hsyGFsArSpPH4JwiePHAj0J/Ul7SARCoyLJ0XsnjnAHFue7VUfs
         2Arqr+yVUDwDsbwUAcFq9fSEnTgjqOG+Geo5Em+uJQZeDjRRXMryGUWS75pqbAG5OsZZ
         b0Ln0rCLytA8PfiYKH5gJjX/9sCGAdQIZH7Nm5mUXLDv9EK0lGO9I/2NC0TUiLDRzBZh
         qGBe303vlgVB03BxjRfNpHbIeedM0LN4KVJSzEnoqAWzrxErZk9rjGgELE+8OxRjNQhu
         vB7g==
X-Gm-Message-State: ALoCoQkC8bOKA2rsuxcJbsuBkxjLOP2hXgJMj99mrn8EE+aweRZecyNwbbmyJdlYbDsfgNxs+FzU
X-Received: by 10.182.125.4 with SMTP id mm4mr3060493obb.49.1402439380540;
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si1396158yhb.3.2014.06.10.15.29.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 5CE155A473D;
	Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B4697E0AA8; Tue, 10 Jun 2014 15:29:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251309>

Add a strbuf argument to _commit so that we can pass an error string back to
the caller. So that we can do error logging from the caller instead of from
_commit.

Longer term plan is to first convert all callers to use onerr==QUIET_ON_ERR
and craft any log messages from the callers themselves and finally remove the
onerr argument completely.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 2 +-
 refs.c               | 6 +++++-
 refs.h               | 5 ++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 1fd7a89..22617af 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -367,7 +367,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		ret = ref_transaction_commit(transaction, msg,
+		ret = ref_transaction_commit(transaction, msg, NULL,
 					     UPDATE_REFS_DIE_ON_ERR);
 		ref_transaction_free(transaction);
 		return ret;
diff --git a/refs.c b/refs.c
index 0faed29..25c3a93 100644
--- a/refs.c
+++ b/refs.c
@@ -3418,7 +3418,8 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 }
 
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, enum action_on_err onerr)
+			   const char *msg, struct strbuf *err,
+			   enum action_on_err onerr)
 {
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
@@ -3447,6 +3448,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       update->flags,
 					       &update->type, onerr);
 		if (!update->lock) {
+			if (err)
+				strbuf_addf(err, "Cannot lock the ref '%s'.",
+					    update->refname);
 			ret = 1;
 			goto cleanup;
 		}
diff --git a/refs.h b/refs.h
index b893838..94d4cd4 100644
--- a/refs.h
+++ b/refs.h
@@ -266,9 +266,12 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
  * problem.
+ * If err is non-NULL we will add an error string to it to explain why
+ * the transaction failed. The string does not end in newline.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, enum action_on_err onerr);
+			   const char *msg, struct strbuf *err,
+			   enum action_on_err onerr);
 
 /*
  * Free an existing transaction and all associated data.
-- 
2.0.0.574.g30c2c5e
