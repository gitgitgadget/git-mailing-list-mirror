From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 03/44] refs.c: add a strbuf argument to ref_transaction_commit for error logging
Date: Fri, 16 May 2014 10:36:51 -0700
Message-ID: <1400261852-31303-4-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:39:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM6i-0002jl-3N
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758035AbaEPRhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:37:38 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:38116 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbaEPRhg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:36 -0400
Received: by mail-ob0-f202.google.com with SMTP id wm4so585871obc.5
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fECzCYb93kkaN1CeyVRNuyI4IQjNJO+ZmyJqHZkkS5E=;
        b=BGrc9UpzaKEvx7MThjNU+2JHsYmPMg+xmBS3QiDZJ8xSGp+LWVAPhBBPYf7BxUtYpd
         BN4tJnFG21RscpQvBTSnEIwlF5dFkeElKg7HOiguL3P/QroN1o5BH4RNeHUdK4I87rDw
         Ib92oBnBy7EmmTg9DC6f+fy60crwUNg3UrSIc62qfrRusZnPiGM0yXnXq00DIK2MlE6N
         LyTodQ3L85zAlNkP7+o7EBNdPiHwUsiQgv9RUZ0/jLKPzMAq1gUSbPYoyNLMTgIYhmfI
         EYjsV+kKM8hqm/mEc3WS6niNcTVgkWRlMqbWdhleUPemj9mSMWsn84BM+gycELOdu5Uq
         onLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fECzCYb93kkaN1CeyVRNuyI4IQjNJO+ZmyJqHZkkS5E=;
        b=Sq91O3Yi4R3s0/DukA+4/y9nV5Xb1tXDh73PPb1Kt6pJI66D8MUhdKrR6+rjES/G7f
         j64VSYDGxXu/igJNENKwi0MJw+uT3kTmboR1I1SaAv1vMVzBPkV4MGsJg6lV4GS50tA8
         XFvGyEcGYm1B9/oVDLwHSRzZgscQMHYU+ZQdO9Lk4H5HCAvhHG6FqFzyc5EAjjzP3grc
         8WOAHE7r3v6kYKBeRNMFBMf1fzu/SZ0rAMOfDLo6sqfiFMEQLo7Fum8g3ssKxaY3rYnT
         9x3aSeGY0ArsFNB43IftdFWPAT/XlaP5Heex27LWdpRp2UJSrQpltdj/2fjXPzacRYS8
         XoDw==
X-Gm-Message-State: ALoCoQkG5tMGLi7TgvlNmHop0iw+aCx4KCFV1uLMtNbuhDkJkT7S+Ah8xL0hSEPrBFJJJCB+1MLA
X-Received: by 10.182.30.70 with SMTP id q6mr8757309obh.26.1400261856625;
        Fri, 16 May 2014 10:37:36 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n43si191469yhe.1.2014.05.16.10.37.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:36 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 797805A40F6;
	Fri, 16 May 2014 10:37:36 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2699EE0746; Fri, 16 May 2014 10:37:36 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249388>

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
index 405267f..aaa06aa 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -367,7 +367,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		ret = ref_transaction_commit(transaction, msg,
+		ret = ref_transaction_commit(transaction, msg, NULL,
 					     UPDATE_REFS_DIE_ON_ERR);
 		return ret;
 	}
diff --git a/refs.c b/refs.c
index 6357089..686b802 100644
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
index 50ca06a..8669fc9 100644
--- a/refs.h
+++ b/refs.h
@@ -267,9 +267,12 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
  * problem.  The ref_transaction is freed by this function.
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
2.0.0.rc3.510.g20c254b
