From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 01/48] refs.c: remove ref_transaction_rollback
Date: Mon, 16 Jun 2014 11:03:32 -0700
Message-ID: <1402941859-29354-2-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:08:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbKg-0007ix-Fd
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbaFPSIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:08:31 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:50873 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932545AbaFPSEX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:23 -0400
Received: by mail-ve0-f201.google.com with SMTP id jz11so869750veb.0
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qzczTE0mf5+4O1aLGDhcCaJX4d4sAkMK8OrBRsIpfrs=;
        b=l95xZKWh9Ug2sh7DVhO+YvxgJLDxJFLODkB7GXUP88L0phB3EJlmnL2Fos65DsxsHr
         hUAxypo0/bR1G54JYYy44N9AvmBySGA3E8hKA+Na6yXGK4tnFA7CdODABwn5R1c7ksHC
         5kqfv5U/VTEoCbl5nuHYTL3AI9NBO/jab+5sxDm+lPzWltP3I776cOcIGUa443rNaaTZ
         IwAqdFeWk718JS2BYPgaHxCQSURbnP6zffPfrQifMvl7M7sSmRDuSEKQLzqlaGzf29aN
         v6+v7lb5/0dDiEEdE8H214XWSbj8RuDJzu4e0sJ8GhWyoHwSqIMQ8rEyPah8e3SAnFwE
         mPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qzczTE0mf5+4O1aLGDhcCaJX4d4sAkMK8OrBRsIpfrs=;
        b=UOXfPFIcyxpwRMpCzfHsMWgIeDq8AUH5lakjepnoNFa/TfI+XXThfaCurkb+OUgDZn
         +fbASeXKKQFfqNu0zH+OXi2XEkPxVyY6DFC/Cs5BQUu08t8VVRdNOwvK0LkkHDpromhO
         U5AGgCtkUo9MohHqsrYzEJAGasYILRLcWdKBpgF0RxVcd2nmU5+RFI3mwi0SlifEctxf
         tMkLkOAwR1o8lpdEjnFr5wKx4tIJwMV9MTN8QslSTzUPinQCElLLGfrxQzIzXe6rJcEt
         ixgF5t3df5UYI2be6hRsN7DE/a/TSY/Z1SG+gbLIy+hPAKpumGhig1lB829tVBYb5uJn
         8DPQ==
X-Gm-Message-State: ALoCoQkQvAiH6zyIZzsjejPc3K8OdJgeRKSrKc9CYlEViv8Bk9t0Cp1XzvTd0CCGGIZ4R3hyxFDF
X-Received: by 10.58.187.44 with SMTP id fp12mr201670vec.24.1402941862317;
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si996126yhl.7.2014.06.16.11.04.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 2E9765A4911;
	Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D3B90E0CFF; Mon, 16 Jun 2014 11:04:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251783>

We do not yet need both a rollback and a free function for transactions.
Remove ref_transaction_rollback and use ref_transaction_free instead.

At a later stage we may reintroduce a rollback function if we want to start
adding reusable transactions and similar.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c |  7 +------
 refs.h | 16 +++++++---------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index 6898263..48573e3 100644
--- a/refs.c
+++ b/refs.c
@@ -3308,7 +3308,7 @@ struct ref_transaction *ref_transaction_begin(void)
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
 
-static void ref_transaction_free(struct ref_transaction *transaction)
+void ref_transaction_free(struct ref_transaction *transaction)
 {
 	int i;
 
@@ -3319,11 +3319,6 @@ static void ref_transaction_free(struct ref_transaction *transaction)
 	free(transaction);
 }
 
-void ref_transaction_rollback(struct ref_transaction *transaction)
-{
-	ref_transaction_free(transaction);
-}
-
 static struct ref_update *add_update(struct ref_transaction *transaction,
 				     const char *refname)
 {
diff --git a/refs.h b/refs.h
index 09ff483..a07a5d0 100644
--- a/refs.h
+++ b/refs.h
@@ -216,18 +216,12 @@ enum action_on_err {
 
 /*
  * Begin a reference transaction.  The reference transaction must
- * eventually be commited using ref_transaction_commit() or rolled
- * back using ref_transaction_rollback().
+ * eventually be commited using ref_transaction_commit() or freed by
+ * calling ref_transaction_free().
  */
 struct ref_transaction *ref_transaction_begin(void);
 
 /*
- * Roll back a ref_transaction and free all associated data.
- */
-void ref_transaction_rollback(struct ref_transaction *transaction);
-
-
-/*
  * The following functions add a reference check or update to a
  * ref_transaction.  In all of them, refname is the name of the
  * reference to be affected.  The functions make internal copies of
@@ -235,7 +229,6 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
  * can be REF_NODEREF; it is passed to update_ref_lock().
  */
 
-
 /*
  * Add a reference update to transaction.  new_sha1 is the value that
  * the reference should have after the update, or zeros if it should
@@ -277,6 +270,11 @@ void ref_transaction_delete(struct ref_transaction *transaction,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   const char *msg, enum action_on_err onerr);
 
+/*
+ * Free an existing transaction and all associated data.
+ */
+void ref_transaction_free(struct ref_transaction *transaction);
+
 /** Lock a ref and then write its file */
 int update_ref(const char *action, const char *refname,
 		const unsigned char *sha1, const unsigned char *oldval,
-- 
2.0.0.282.g3799eda.dirty
