From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 01/48] refs.c: remove ref_transaction_rollback
Date: Tue, 10 Jun 2014 15:28:49 -0700
Message-ID: <1402439376-25839-2-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:39:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUYB-0004cL-7A
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817AbaFJW3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:29:43 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:57904 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064AbaFJW3k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:40 -0400
Received: by mail-oa0-f74.google.com with SMTP id i7so487987oag.1
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w7dS5Bjkb/k+v8zE+iyAM1Wk3HX/z+X0WthaTNQGInw=;
        b=IkJ4VXDGjIaxPDT8AUpeiBDZdd7SkNaS+gfzlYXepNtVrMhSPOPkqOxCuu5QdtHEwh
         ccV0g/TV2DiIFgaQUPabfteG+vZS5MxkKtFTGCH8644tYsPqRVnqtIDwM3nDA6ZHK4zq
         /vOUsQdyM817FQFcovP7OecMjku+rG4oZN0t3U+gDzT7ULZYJN6XHd6Bj0FdqXGRGU24
         /CRv7Rc7SEj6FN8TnoqpwDAoIrg9gowc+f7TM32vy00aXvmLV6hKoVrzZGjVZcxH9geL
         EKxGa38K09cJFiQFgdle29iZ46DsBh7iwF4Qlvo35IQBTrtLJlCI/O/P9ZYI5Li9jmVz
         09dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w7dS5Bjkb/k+v8zE+iyAM1Wk3HX/z+X0WthaTNQGInw=;
        b=DaG3KjBAUB+wIv2V8+rEtOFjxYrXA09ZmitdyBkA1jc1X9bxBR3lFUs2+VkFGZhs6I
         uGlTGaKFpPJkhCscEvVCXxhUOEH9WJ05/tfiGNAOJevVtXHAQmQP8qqQl4IjIEZHbl3d
         6/oiDdjKez3i7y9RrNrlQOgy+HWhPBV929o4oV1FRXU/AITP1KOivUrowwWUlnd21V3+
         e3AgdqDOT8uSYSi4KHoqrsxiuZ1v0whE/eRBLGyx3wElsuND97vTUFo5SBipdFxhV3kF
         DK5ePVq/vsLJKBk62UCuaXZgkySgelmuvkQ3kxoBIO++ApqNB0QYQTpW3YvcQWZJnVHW
         zCFw==
X-Gm-Message-State: ALoCoQl0B8fhmpCiXdb6Ohp6QdrC5AslM3Yaex7RACccEZLU/cdhYfDAHc0GBFmOuAtg+roQx9gN
X-Received: by 10.182.22.65 with SMTP id b1mr17090627obf.10.1402439380035;
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c22si1396557yhe.1.2014.06.10.15.29.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id D95BC5A472D;
	Tue, 10 Jun 2014 15:29:39 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 84EBCE0616; Tue, 10 Jun 2014 15:29:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251305>

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
2.0.0.574.g30c2c5e
