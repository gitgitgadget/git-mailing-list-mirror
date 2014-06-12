From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 05/48] refs.c: add a strbuf argument to ref_transaction_commit for error logging
Date: Thu, 12 Jun 2014 10:20:56 -0700
Message-ID: <1402593699-13983-6-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:25:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8kH-0001Xh-UV
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756409AbaFLRYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:24:51 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:52733 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756189AbaFLRVn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:43 -0400
Received: by mail-pb0-f74.google.com with SMTP id rr13so186345pbb.3
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qF23mwKpojoW5ES6ajD/ezwRfV7TwEUcTrY8oYCYSN8=;
        b=SiDZXC3T6FrIg3tIrACwYLxakqu1vhFQGOtZjORk+MkVj+atui9t1+BHarxzVHHDw1
         eyz9sqFH9/SPPStxgdTsu2vVfskxpGDYvAXARU3peZMFQ9DgLkyHL3R96GNa3ufXuUPK
         KKplce/EkJNjxFDOTuaq0QPBUlPQrS8ekVHQ04JnLbZsr5CU9PaeXvy3okgaSGCtNhxq
         b+dcuCRP2LQBuqxcVbRJLBOBxAvZTswweAxPW5Z+78ScruhANcYOaO6acUBPzp8A0HoJ
         WZw1LkkKrw22MyxMOkLa7RTrECLBTyx/KE9o537ER/e6jbUcdyTF2HUp6nLiru8YTU5i
         57WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qF23mwKpojoW5ES6ajD/ezwRfV7TwEUcTrY8oYCYSN8=;
        b=LlOrPdZTBwJ+C2+VQJuF7fw7/pgFi21qI2t95NMi+Rc3rjKXBxpgGECdr5FhhR4pmO
         hkUgOG9uId5g8aap2kN8BrXVY0IBq9NR66BaSOTvX2k562NSPWHDKfJ6qehGsh8QMR2L
         c9ohH7feRb3cChDXeXjOuQQCieDWTblIzZMn7dulkR+M4dECxa1q70wis/avrWSbtvu6
         xzsEQyQ1OhELEamnpLinsj+V5peNVzeqc9SQoa+5qEXM2ayioeX+DW2roId+Fx+whCXx
         c2ydKewP2YT5vcUgoobla1V3ybQeYIMKSVNSOpi/HRHZA9+QV9hvWUJkw674045OfkiP
         5dBg==
X-Gm-Message-State: ALoCoQlAa4chg+Ng1NE2bu7cnW0qgvAONiQCfGaIMV4QXZyYJBbfUEmPE2ZjqIgRpLiMSzaomBKn
X-Received: by 10.66.169.79 with SMTP id ac15mr5386863pac.48.1402593703202;
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si112562yhk.4.2014.06.12.10.21.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 0A0A85A4749;
	Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A4BB7E0D36; Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251464>

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
2.0.0.599.g83ced0e
