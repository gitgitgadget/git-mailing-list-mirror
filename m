From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 05/48] refs.c: add a strbuf argument to ref_transaction_commit for error logging
Date: Fri, 20 Jun 2014 07:42:46 -0700
Message-ID: <1403275409-28173-6-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:43:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy02h-00017d-Kf
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505AbaFTOnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:43:45 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:65054 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846AbaFTOnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:33 -0400
Received: by mail-ob0-f202.google.com with SMTP id va2so193375obc.3
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rfw9OqlEqJgXSn411KQilj8v+9nWWMkr5BSIuC+ndqo=;
        b=Mua07IRUou2rXuYBkLWo7fCs36fcrDKiafyEgqZzNKikD61BjFDqUSjrwW+RzqLRk1
         UNxXqeg9UFECi03XsYmV4yWQmqvzO9FvaWy04ho93nonmt7+gHNXe0c47WYXNCYNmHN2
         cohc5P/wv/lL+vEmz9uMLQoVIbLVI2cTjws9BJ/7L5TK7EOLuan8zf9xoYuGicjT1Efc
         NDdxkLLOy36mrw2+sZViSb+2B9cAprKhvhcq+FiV8D3Pgu7APXZDVVUvyGoXgIvXZrxk
         wjRThBaxsDmv98dqlMYLJfLcvVjwGY63STZIJVL42LtlFAHI4jGZwBEDLdTNzbBbLobM
         3ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rfw9OqlEqJgXSn411KQilj8v+9nWWMkr5BSIuC+ndqo=;
        b=dwPio4TbcRPQjxvGMVv6OgSZ8dp91HBf9Sw2xD+OYIp98cSyNYoWFnII7kjkpgX6yz
         zLvyKCY0rrReRCEdOTSVsPqI0bR/yBDfHTtCdbuUoTQwmmjs1RqxNQo6fJJTpoOofmCl
         DdRXdrJkQuSm0/phYbWlJSmpId1hp5YCAG2DuKz8XqesxWxHSpz5DXVbQ0pBQj6K+FDf
         vMY2XvCq606q+43CUNBNG5nB8PG9gAflwZ5De3VfLEj6gXNd99XDkMRQu+wmW1KoGB+j
         Z+eZ2oKuHjvpMJam5bQwMY8TrA/phl1bic7fRdQ6ZVJrG5O7yYFJkELxlYkfBYBbH1j5
         yABg==
X-Gm-Message-State: ALoCoQnPJiPYvttdyGgsT14ot32Bma3y673P/XEu/I5ebCvIy8Zx2gRNSKwANEeGX8P9gXo2EiCK
X-Received: by 10.182.28.136 with SMTP id b8mr1539500obh.19.1403275412347;
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id b39si187829yhj.0.2014.06.20.07.43.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3397131C6B1;
	Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C33B7E114E; Fri, 20 Jun 2014 07:43:31 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252230>

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
2.0.0.420.g181e020.dirty
