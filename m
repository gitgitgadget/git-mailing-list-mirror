From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 01/41] refs.c: remove ref_transaction_rollback
Date: Tue,  3 Jun 2014 14:37:19 -0700
Message-ID: <1401831479-3388-2-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:38:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwPW-0005Tb-SH
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934220AbaFCViL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:38:11 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:61815 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934016AbaFCViH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:07 -0400
Received: by mail-pb0-f74.google.com with SMTP id rr13so830779pbb.3
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7yq0Ut9QIkoENpIGx0Gy8m6TzYWgLL4lc0pmkCXWn78=;
        b=Al31Wn8ITMJJXZrKHJlz46yFmcKkpvzf5v5A0JSObFOPDQIgM36hwM2DTB/8YDEgO/
         ffeurQlQOLf8hWeNLZVYIL+O6jFCFMDqztyI2+s3R8Z0DX1RjAPdo2A17zhkBbg7PBIx
         s/0txPRzjjkaApKWI00jVYsoju9vkOB6RfYFVG6uhIplAZysRT82Mc2mQMSW321H6U0q
         019UzxxJJcWb+oqN7W2gNN0bds6CnYwfACBbj2BoJKtpBgMaslgbZdxZN1YnKsUwyNDu
         /pLabNyTp3h1JyUiPiMQ6moVjYPsvZlfPmpMPkjmCAvbNB9lDvpjfgdygp+rV+UhAxY/
         Bl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7yq0Ut9QIkoENpIGx0Gy8m6TzYWgLL4lc0pmkCXWn78=;
        b=Ui+KdcggWY5vwu45QJxibUyVl+lI0uZ4l35SqfxMxR6qyeq5NllEh8DyoZ21Q2Qufg
         JZJwwyU9DSUoDANvbd/M+H8fR32cy43QXQN/PuIBmoKrF3oCmItRlGCFl3HfmAg6/9wP
         syIGKJdI4px+JPE2ezlVjF3pNowrO4k1rmH8cILBTMObhW6+2ZZ9chcy7XtFRfnpKEKL
         bYqeEa5H0cIlKrxRVGqug5SdafMulsgwK4suKlJSUoACYOlPVbOlL4OTTb0q4bweCcle
         ae3fkSwxgQxAgm+/cu3qTe+F+MeqAwhgVwA1Q5rJjg/AezsltpyeLL4UgCK8htDliV/e
         p9Hw==
X-Gm-Message-State: ALoCoQnT0yhuwUYhgkouodxR3tX5EVL80PEeoRl5JVTTXMb6VjmVnh5oGIe8HWT8l/99JfdX1exO
X-Received: by 10.68.253.66 with SMTP id zy2mr17377646pbc.1.1401831486910;
        Tue, 03 Jun 2014 14:38:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si8964yhm.0.2014.06.03.14.38.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id AEAAC31C45F;
	Tue,  3 Jun 2014 14:38:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5B206E06DA; Tue,  3 Jun 2014 14:38:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250650>

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
2.0.0.567.g64a7adf
