From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 03/44] refs.c: add a strbuf argument to ref_transaction_commit for error logging
Date: Thu, 15 May 2014 16:15:00 -0700
Message-ID: <1400195741-22996-4-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:17:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4uI-0008LA-47
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346AbaEOXRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:17:39 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:55984 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755660AbaEOXPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:45 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so720782yhl.1
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iKga+nSHcks3gdN1belof9tYrpu7qk1IaEP9FvHxUKQ=;
        b=Hf9t8GrZP/SizYE54lc8Rxpe8veeQKu50USF55GF0X/Nn1KGk1xZHtIMQZEaDgO1eZ
         BE/2acxnp64Fqo/AKKkMi6Zc5aV9G1aauTSGJAs+vNYF22Vg+awyxfwcm6MV1bYNY7OP
         4J/UUDcEUqQx+R5ia5v8cYDfG2odwdf6RFVeAIzzt3UmP634ESjDKttqkrpqjpZvuNSl
         qN6Mm7EKy+qt/tnZbfG/USGdCZgR78NXaJFPIH+bEpUgEddc1hYRlPkg//Yhu0z4X1D8
         aHKPRkXxIUaPG4cTAm3JaOrCJ0cShwB615kelrL8UIqeay36Avos/tXipkrCBdHrNeaB
         MQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iKga+nSHcks3gdN1belof9tYrpu7qk1IaEP9FvHxUKQ=;
        b=S85JvDGjvBYXSNUXRx147+1w/fb7ycFISZ/tPQO0aQ2FeOnwukjdin059ZOBb/6258
         D9ZbDuj5e8+vN60+PqFlGtlIipJE47CF2DjMbr1klCq3OcZJA6ClnefkbBu49f5LN0UF
         qFxX35rU4U0fcT6RquhYCJgq7hq6bNAuAMSsDxBN/AhR0Ie2NNtKhhNUiLEiHF7u/ck6
         DMbAjWandaV5auH7CZzya1Y++LJGfMxaukbDeic+BDUpp/Qc+oKM9msnkKRg+u7li4H6
         WStkWeB+sL4kZHvHa8iDFXG4Wq19mfrejXG1bfTTYlOdy0oiZdtiRQP+b2yk2DHTAOy9
         HCUA==
X-Gm-Message-State: ALoCoQm3uGQGVkqwiFWfRVRT37w7jn70EulaZjB+pCgKzE4AFbNM+60GBj0eK5fInzYYqZSSMzdO
X-Received: by 10.58.207.50 with SMTP id lt18mr6377106vec.1.1400195744654;
        Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id h18si319597yhj.0.2014.05.15.16.15.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 77ABA31C1ED;
	Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 21ABDE0764; Thu, 15 May 2014 16:15:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249257>

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
index 88d73c8..1a7f9d9 100644
--- a/refs.c
+++ b/refs.c
@@ -3423,7 +3423,8 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 }
 
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, enum action_on_err onerr)
+			   const char *msg, struct strbuf *err,
+			   enum action_on_err onerr)
 {
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
@@ -3452,6 +3453,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
index 6d97700..25ae110 100644
--- a/refs.h
+++ b/refs.h
@@ -274,9 +274,12 @@ void ref_transaction_delete(struct ref_transaction *transaction,
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
 
 /** Lock a ref and then write its file */
 int update_ref(const char *action, const char *refname,
-- 
2.0.0.rc3.477.gffe78a2
