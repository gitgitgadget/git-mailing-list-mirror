From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 01/40] refs.c: remove ref_transaction_rollback
Date: Fri,  6 Jun 2014 15:28:39 -0700
Message-ID: <1402093758-3162-2-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:32:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2g4-0003bd-Bc
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbaFFWby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:31:54 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:55827 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbaFFW3W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:22 -0400
Received: by mail-qa0-f73.google.com with SMTP id hw13so680014qab.4
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OIASspJ/EcC45teGohmstHq2TfbNTfrw0bGfPRPzmNA=;
        b=nHZiII82gBeAHl/9a+wBfTt92zECoo26GbB34gYIO9q6tF956lu1xqXmrQI+wKtTx+
         XfsxXJg1uAuFcdbOqevMdCIOkAdY0LUAbY43QokzsGvW5m64PKAiKgDTfFRKFFahPmwf
         dDZF5pJPRNCq7XolReOgNRMz5vLLt/0lKYQoRo+FxoRItHqDO9HreFsza2VBy1PPxSSP
         AVHoXChaOq/O/3S6EaxGypadTykZiZ9NUa9zCv/KAFOx3GFHIN9xNmFvoHS6VmYw6JZA
         9nDCLz616Oj4B1aGETNAAL16vr04NElV5oM9xsAO0qzh0KPFSRvFn3igdVHCqrEnA+/r
         wtzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OIASspJ/EcC45teGohmstHq2TfbNTfrw0bGfPRPzmNA=;
        b=G+xCge6bspC6K8COx55C12ELAOpLcn7jtIyOZCv4NQOdBudst5HCE9CLq9ri2ynbKq
         P07ubFcKR4VfLGZK6QVZTXzCqk3glyiO+37qv4TFr35Rn6TCEk2ST8YwTCz1CKTQBm9a
         AxjQpBN1gnouKmwrNuwbPcMNQ553Y/HCVCcXdeAh2cL4+oO3IRFJgloeBWc82E33eNSB
         fmRrdlEUlMY95OUoRsV/3cFj25BSwU91MwgnsjM5Plk4y/S/y1ELWDBwHYcP3ULfsFS8
         66cCvUxlD1RROLeVx379Lgj4dO+6CoVWZ4MVd/6E+tZ3SGHqu/Pg4JOLgPsJZxlb5CjO
         YYag==
X-Gm-Message-State: ALoCoQn7lvwhvh71f1j+tBoQrtKV6vXnr44yoB/z3wioqlStAPiC8KGNC8C0bHBrcGbGcKedmClA
X-Received: by 10.58.25.99 with SMTP id b3mr5321130veg.28.1402093761803;
        Fri, 06 Jun 2014 15:29:21 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id pr8si750948vdb.1.2014.06.06.15.29.21
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:21 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 8F9FB5A44FE;
	Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 39C7FE0CFF; Fri,  6 Jun 2014 15:29:20 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251011>

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
2.0.0.582.ge25c160
