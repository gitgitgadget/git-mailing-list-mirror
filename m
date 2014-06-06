From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 05/40] refs.c: add a strbuf argument to ref_transaction_commit for error logging
Date: Fri,  6 Jun 2014 15:28:43 -0700
Message-ID: <1402093758-3162-6-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:32:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2g3-0003bd-RB
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbaFFWbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:31:55 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:55347 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbaFFW3W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:22 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so140482pbc.2
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y/iVhXT+z7pgLvqWuI1DRJbjfAOWaYvSvMK2BAbLFRY=;
        b=OuL6YcnqOylpTqsLRDIRsPZDRCb1T6oQeCEJgWvfrvO3HuIVNZxmHK3kDINFbQjNvk
         ltdzQ/0vdUsBvCFuF0gpy3pF462NlCP85JyaBiQ5IMVnbhEkrv3/CG1tq7eeed2CuZdq
         z1WZzlSwdN/6lf1Jabv+S54hbDeo3WQErKy+BM1jvzq4OrHQjxm97CxYsONjlqWTd2z1
         /rOpgiVsAVMrbwDYJQqa36YnXjvBuDXMGotk74JsGpEOYu+tRATFX1LmG5O/jGS9mSSj
         H2YTIi1xXlGUX1bk5cpoRZBA0gMJCvnJKZkwpkNlq9yFC0Tje/BEO0fusrKOmhBbWvzC
         aUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y/iVhXT+z7pgLvqWuI1DRJbjfAOWaYvSvMK2BAbLFRY=;
        b=YJmd4M2cIQZJO3HnLrnnR+0FivzkuNw7BYhcedjmoVghC2bT7EzgCIJHDt04itYPHM
         T8vzbfTqq99tCV/2ZHDEPHwcDyLwnURHS0Gc30eoe84wF5fsgGQ6Bol8YYZwfdYEK6FV
         dvMPDB6fSFtu8Cqrk7uUS2G15ZB4V/UIEJ2SsMCuZKCPW4KrR7pczilg2VG+WRueX3vK
         6HEWk0BiXIx/+KgtPF2y1BZl234Q97BND7eYH2YxmCbJEyDCLwVlKZUiRDXntPdK8sOt
         0quxxSwMZubzdltcdiPLeA3l+QirdMtRAXm6wO9yqPWkaq91v4XeWbp2jAEnzh4SOpqs
         62Aw==
X-Gm-Message-State: ALoCoQmKH8y29+L+h1DETHFopXLZlIJM1XDeJlGt8IzDHdc6Ps99nI+bDCz+w/cc2Hmqiga0uWgO
X-Received: by 10.68.197.73 with SMTP id is9mr4408413pbc.0.1402093762035;
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l7si751211vda.3.2014.06.06.15.29.21
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:21 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id BD75431C62B;
	Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 77F4CE047D; Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251012>

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
2.0.0.582.ge25c160
