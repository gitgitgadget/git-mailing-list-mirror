From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 05/41] refs.c: add a strbuf argument to ref_transaction_commit for error logging
Date: Tue,  3 Jun 2014 14:37:23 -0700
Message-ID: <1401831479-3388-6-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:42:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwT8-0007ro-7H
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965429AbaFCVl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:41:57 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:33095 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934164AbaFCViI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:08 -0400
Received: by mail-yh0-f73.google.com with SMTP id f73so1406615yha.4
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rNic5ZtW2J1OHUj6iLCwzsLbgqVQzY7fIAsjh//NTcs=;
        b=As/n+8p8L3lweN7puQNRNrRBGuBYe5cXpNvEmpJ0bw8I3Bd/adtk+oObhLIxG54GjG
         JP/D9q+/XTMofi0TqLbAIV6QoTu8ayYVmdcdYlIkHEFKpvm/EnmZ54BYZuUFNRoYphEz
         NihVVAZ1Enu4AkQ3PrUt9gGKyXwx8gWOKYm3U0yINyrGBw9QBxeS2Ye2lrPL0Z1roVjG
         GWAdpjgsbODLj2RfrjGloK+P1uDD0QIUNoAkSmojIXR0XaImmYFcgiHiFcFGxmzBQ6W/
         iEupOcxflKxKwUhV9jiNabBZ/hLIHmUb0SUTEC0Y3tneCaiYMYlOeGHg5HNl9u7JJO2n
         zCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rNic5ZtW2J1OHUj6iLCwzsLbgqVQzY7fIAsjh//NTcs=;
        b=LQ8pA8OQAwlSPsH4Jjgd4jxQFfzpiYCdhVj66/XYb4B7awDYnaET6jc0bIP17P9SdL
         YHwov1dQVWC9NASuIvm/xIdCUXiO+gMHtWk95+7a1cr5hWotlatzbzctrltIQSx3uVGB
         WINtBjNSqrkeUwaR7FF59r7f0cDuyiKEAelbRiq0AIk6gx6kWHXDsDTvdXzE195EQUjH
         UxbjQOj+1nyH9ht7twGhPSf5Z/JUDHsz9+bh7w6TPhlBzthX678UD/EyJSFLFbZR+MNW
         ZjuRaNDaPUfIw7Z9BrngZsKNzmPNWsdXqiFEJAon4z4uIstxsjXNurdtNZ5ragJ9BFxf
         dJ9w==
X-Gm-Message-State: ALoCoQm8nUYQTdSDfGd/lrQGrteGSX1848RKuR6UrnfUvmaOPuVMH9nXvepzH/2oSWZwz3R6703y
X-Received: by 10.58.46.101 with SMTP id u5mr12077549vem.16.1401831487159;
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si29579yhk.4.2014.06.03.14.38.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0528331C462;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8870BE0887; Tue,  3 Jun 2014 14:38:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250681>

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
2.0.0.567.g64a7adf
