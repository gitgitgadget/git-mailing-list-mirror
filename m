From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v21 05/19] refs.c: add a strbuf argument to ref_transaction_commit for error logging
Date: Mon, 14 Jul 2014 13:58:47 -0700
Message-ID: <1405371541-32121-6-git-send-email-sahlberg@google.com>
References: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 22:59:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nLT-0002z1-Bj
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 22:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757184AbaGNU7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 16:59:31 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:38952 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756838AbaGNU7H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:59:07 -0400
Received: by mail-qa0-f73.google.com with SMTP id s7so450161qap.4
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LdFOXRf7MsDxgqiM7qWm6qsEXqNC6mXpiDG1N4KZu94=;
        b=lYXfEIZDRbBgdbu4IAAv+IJWCVV9uLlScycQNr5QjMZIZ8LNdLFgql70g/8kW81Jv1
         86goPuhzmADReiqbBCavz3ag7PBDZUlGA7jer3TqN4IN8u1xUlC460RHgdh43oCWSqb+
         bTP6mbq3fLiiwiCXUWgYA8lV/lL6/33DH2D0VFdASNm76opOjKjPvXsYH9axXm6Hpqn9
         TGi2ypoPZ5+8hYhLXW4Gg5M5//bDVYXloM99GLBnCWdI71Y0Ql5n6KA96rFw1QtyavWJ
         PDORIxV5GLqO95OKWaMmHsCAKu534ZECFpr6bkbKILoxKEmrqk51WFHghuBli7499Zt7
         T0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LdFOXRf7MsDxgqiM7qWm6qsEXqNC6mXpiDG1N4KZu94=;
        b=T8RBkFYAb8Z/q25BxY9swjDUkhWVBfx3nj7wG5Ez39wPfplkQrkFcWvEODQYwv/qem
         z6a/zpJyb7vSOFeRxn50NqlMSyjrRM/XLEXKAy2ZWbYd88Pv7/d6gAigINx8rZ8D+0Be
         W30d5H9VdxH/p0yv960ecBjsP9IyLa8DhvDXpbGgSTtQ3G3WF/5Ms9uSXFXyaAJS8P6T
         4Do1ChJb2sG4TJLHGD71oJ/IUX5+EQvIiid3OXjoIK8ew6ldyBTNU/MC0cYr/pSn019S
         eLKWhAza3l/eNFoDgwfCmO+sxQp+fJJC58dezk/NG7rBx/1J5FZ6LfAHvayOM+OdHXN1
         0qyw==
X-Gm-Message-State: ALoCoQm+VJuelgz2TkSiRF0a6z91i7HLUD16rsAVoNr1YMzL1OMfYitm7ELLW8jTN6OUidzltZfI
X-Received: by 10.52.120.47 with SMTP id kz15mr7729471vdb.5.1405371545807;
        Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si821929yhb.3.2014.07.14.13.59.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id A5A7131C391;
	Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 57A44E0DA0; Mon, 14 Jul 2014 13:59:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.546.gf603308
In-Reply-To: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253523>

Add a strbuf argument to _commit so that we can pass an error string back to
the caller. So that we can do error logging from the caller instead of from
_commit.

Longer term plan is to first convert all callers to use onerr==QUIET_ON_ERR
and craft any log messages from the callers themselves and finally remove the
onerr argument completely.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
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
index 1d6dece..db05602 100644
--- a/refs.c
+++ b/refs.c
@@ -3444,7 +3444,8 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 }
 
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, enum action_on_err onerr)
+			   const char *msg, struct strbuf *err,
+			   enum action_on_err onerr)
 {
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
@@ -3473,6 +3474,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
index 8c7f9c4..09d3564 100644
--- a/refs.h
+++ b/refs.h
@@ -269,9 +269,12 @@ void ref_transaction_delete(struct ref_transaction *transaction,
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
2.0.1.546.gf603308
