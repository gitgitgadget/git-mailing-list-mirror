From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v21 01/19] refs.c: remove ref_transaction_rollback
Date: Mon, 14 Jul 2014 13:58:43 -0700
Message-ID: <1405371541-32121-2-git-send-email-sahlberg@google.com>
References: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 22:59:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nLC-0002qo-RL
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 22:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757076AbaGNU7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 16:59:11 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:38152 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756749AbaGNU7G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:59:06 -0400
Received: by mail-pd0-f202.google.com with SMTP id r10so1031128pdi.3
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iHxDP0TIp67Gstik7L35zMwzUYq6luFUYhXvbrocEKk=;
        b=KFLoZK6AGMx8BUzaPyKFm/DHQhv/LMbXAdEWY/I3fCSY2ikUtMT9uzUUcP5lS/p7WF
         lQT4B+/l8PdCgDQnkJFtSFKYwYkHot/Y0Szp/k3p9ZBM+lOoTWzIi8kR90nQoeOsuIla
         gK9F9H/5E2QoMsstrvEOyrVHY86OduF6kh5BDH+v6a1CzqhAtWoBfzEK1l3tCZZkZ0M2
         9SeHqhYz7VvZahQq2D06FOzEQOp1PWNtH5aJjC5EqyC4dFZ7Nb2/PHajpTHiGeHufk38
         xq/hakPmAleojpR3GrMsvGPGObaqoZDAT8GEYm6iWrsBL+uEUpDpK7KpuZmgpqYYZS0P
         ZkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iHxDP0TIp67Gstik7L35zMwzUYq6luFUYhXvbrocEKk=;
        b=ND1I+Vzu1FRvUOEGnO/ByRVTQu4LspAsXEKSBzs/3fG4aUFLac90pu/jYOjsFjuM6s
         bFZi7N7IUEUUVQNBuRmhU1tH1gSq9u/8eb3yM9BMxMDFBEmtB0pLs7DZVsyCPy7SkgDg
         L2aRIS5+ZxGbfK+at1T8XhyXFp9sDe/QvjbprpGD+dwKbNXuuwcsZl0iNPmz1ojWwoDw
         IN1+EV/xU7tF7Ov4LTlXm8cEtmbiKRyNGHtB8tw87ZZnz8BOh4CJLOkWyHb3QVef7kpI
         rD4JypUOWpo1xftudLilbjfCk3rfTTVQRxqutjKrjPpJ1Idn3Ws2UD5s6kFc6zx0z7g7
         UM0g==
X-Gm-Message-State: ALoCoQm9pRUkVjnKUdOjYL/oqBRXadqTmlQoH/WE2te2yTbYcBP61uiw/0PgWs50vd9+Pm2dAOSx
X-Received: by 10.66.145.33 with SMTP id sr1mr8682784pab.18.1405371545551;
        Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si820540yhp.6.2014.07.14.13.59.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5E2DD31C42D;
	Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0F4C9E08FA; Mon, 14 Jul 2014 13:59:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.546.gf603308
In-Reply-To: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253517>

We do not yet need both a rollback and a free function for transactions.
Remove ref_transaction_rollback and use ref_transaction_free instead.

At a later stage we may reintroduce a rollback function if we want to start
adding reusable transactions and similar.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c |  7 +------
 refs.h | 16 +++++++---------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index dc45774..6d841a0 100644
--- a/refs.c
+++ b/refs.c
@@ -3334,7 +3334,7 @@ struct ref_transaction *ref_transaction_begin(void)
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
 
-static void ref_transaction_free(struct ref_transaction *transaction)
+void ref_transaction_free(struct ref_transaction *transaction)
 {
 	int i;
 
@@ -3345,11 +3345,6 @@ static void ref_transaction_free(struct ref_transaction *transaction)
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
index 4e3050d..cfd1832 100644
--- a/refs.h
+++ b/refs.h
@@ -219,18 +219,12 @@ enum action_on_err {
 
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
@@ -238,7 +232,6 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
  * can be REF_NODEREF; it is passed to update_ref_lock().
  */
 
-
 /*
  * Add a reference update to transaction.  new_sha1 is the value that
  * the reference should have after the update, or zeros if it should
@@ -280,6 +273,11 @@ void ref_transaction_delete(struct ref_transaction *transaction,
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
2.0.1.546.gf603308
