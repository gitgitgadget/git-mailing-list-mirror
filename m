From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 01/15] refs.c make ref_transaction_create a wrapper to ref_transaction_update
Date: Wed, 23 Jul 2014 10:03:41 -0700
Message-ID: <1406135035-26441-2-git-send-email-sahlberg@google.com>
References: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 19:04:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9zxw-0004WJ-Nn
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 19:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbaGWREJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 13:04:09 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:47438 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932281AbaGWRD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 13:03:59 -0400
Received: by mail-qa0-f73.google.com with SMTP id s7so261582qap.0
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UNHtYrWFMSbOL9DE8u276BpJSuWVfhugpapbG4DQCSQ=;
        b=kGuYAYy19h7EVxbJzUphaERtnxKvEdu4QeZiDPySIs7YAmBs6FfPSIzJlyp88MHiYg
         EP6muNTYzqLjYGtrbEjFVc5TBgX8dY/6ScOhjG1VSrc2s4nJ/tLEae1bIuc7SG2FV1t+
         zEn1O31BxYq1X8WdpbhDhoY69+HhO41NiRLV6GBn1RIucpTzV6gGen7yk35iqyr2swv8
         RtRBLcrApm3PRTJOWEVkudBNiWkwjE90ae+kLrJ1kEsdisTzbWJPgvxD6bo4qBnMixNr
         vbK5U7+SbyhBy8jAZciX+OF80qvocwWsudXW7I5rfPqq++yBMmNnPDYGsWpHeED4raMg
         XKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UNHtYrWFMSbOL9DE8u276BpJSuWVfhugpapbG4DQCSQ=;
        b=AEP/XtN7YPGKtdji653f1NPqM6W8vzT7bQ4c5z8a3qvxIe8So1Lmt++FYdmj0iw9Qa
         Df9abl4yO3OHcnsl0c+9bVc11uAVPxuYn19yhaD/NQl4LokD4koAlxc08gBWAagUO4ZA
         96mUZZLme1HxSHvlqcLD+LO9nKh9SCVCzkcBz9qs5AhpNUkbgM019N23woRBWZKCfjAG
         VXwg5h+oSEMr6mHeoZZmlShy9gdX2+mDgwL4FWpIxRXJQQdXneAxmd7TXvwouajXiFjw
         60mIQatClub/qJ38ppgIroVe6ExKecjbf+af9MQdp1iYVkAwCCu82raUqC7e6xqFqL4P
         s54Q==
X-Gm-Message-State: ALoCoQk13cPpPEg6ZeVWaIaf/99tuGk18mUygHNmQIZbTMcKPelMOwrfSCoYdYE5PdKZc3jRDcFv
X-Received: by 10.236.26.206 with SMTP id c54mr1073824yha.44.1406135038256;
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si487010yhk.4.2014.07.23.10.03.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 2062831C34E;
	Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C0A74E0AA8; Wed, 23 Jul 2014 10:03:57 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.508.g763ab16
In-Reply-To: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254085>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 18 ++----------------
 refs.h |  7 ++++---
 2 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/refs.c b/refs.c
index 6dcb920..8f2aa3a 100644
--- a/refs.c
+++ b/refs.c
@@ -3490,28 +3490,14 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   int flags, const char *msg,
 			   struct strbuf *err)
 {
-	struct ref_update *update;
-
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: create called for transaction that is not open");
 
 	if (!new_sha1 || is_null_sha1(new_sha1))
 		die("BUG: create ref with null new_sha1");
 
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		strbuf_addf(err, "Bad refname: %s", refname);
-		return -1;
-	}
-
-	update = add_update(transaction, refname);
-
-	hashcpy(update->new_sha1, new_sha1);
-	hashclr(update->old_sha1);
-	update->flags = flags;
-	update->have_old = 1;
-	if (msg)
-		update->msg = xstrdup(msg);
-	return 0;
+	return ref_transaction_update(transaction, refname, new_sha1,
+				      null_sha1, flags, 1, msg, err);
 }
 
 int ref_transaction_delete(struct ref_transaction *transaction,
diff --git a/refs.h b/refs.h
index b0476c1..1c08cfd 100644
--- a/refs.h
+++ b/refs.h
@@ -276,9 +276,10 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 /*
  * Add a reference update to transaction.  new_sha1 is the value that
  * the reference should have after the update, or zeros if it should
- * be deleted.  If have_old is true, then old_sha1 holds the value
- * that the reference should have had before the update, or zeros if
- * it must not have existed beforehand.
+ * be deleted.  If have_old is true and old_sha is not the null_sha1
+ * then the previous value of the ref must match or the update will fail.
+ * If have_old is true and old_sha1 is the null_sha1 then the ref must not
+ * already exist and a new ref will be created with new_sha1.
  * Function returns 0 on success and non-zero on failure. A failure to update
  * means that the transaction as a whole has failed and will need to be
  * rolled back.
-- 
2.0.1.508.g763ab16
