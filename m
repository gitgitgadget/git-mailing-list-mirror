From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 02/15] refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
Date: Mon,  3 Nov 2014 08:55:44 -0800
Message-ID: <1415033757-9539-3-git-send-email-sahlberg@google.com>
References: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 18:03:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlL2b-0005ua-NJ
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 18:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbaKCRDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 12:03:38 -0500
Received: from mail-oi0-f73.google.com ([209.85.218.73]:63111 "EHLO
	mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbaKCRDf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 12:03:35 -0500
Received: by mail-oi0-f73.google.com with SMTP id e131so1670684oig.0
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 09:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pL3E98kjJkP09UKi0H8C9tXPP9ln0o/fKi6FPlBogqA=;
        b=Ip1UfZ/NWYEQLxkuXtCRQ85dZQT3c3s6E0s2bzjlM6QUDwmqS2o+CAFvWjC732xJB7
         +K8zU7SmYv7K8s326dvnNSLvOGbjjzhG+APhzJMNJ8hGpwzWghrxcusmv0ojcIJ9wzcz
         IWwDvqr++rtFjhAD+JOFp7c8n7FfCgvqY5RZ9WljPloQCTtV0k3kC9HTfc82PNznGo7U
         NAxRU+waqDSTC+L0C5QKF+qHMwP4zoh9gIRfEVR9u+NU88qrB6WOpdKQHv59w7b3fBd9
         9t9NYUsF1Wbr1wM3aA7ZTxi1XqGxqiTKKuSwJqo6VbW8sKOiY17uUIyhoHhvHKalQXZt
         80bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pL3E98kjJkP09UKi0H8C9tXPP9ln0o/fKi6FPlBogqA=;
        b=Rje7JtMu9BHkyweMyGKnigXRbPPmEPSy6ATKXkxDWkxIxd1y2eQSQqZxXL7n66gUFQ
         urzq1yaEPK6h5G/kKEzxc7rO+LQJqiqJ51I9Y0WX7ibCmIe/NUmqwcRiGpuC0vPdaCSH
         qSNQSsoGN5GhZrcrO6cU3w/qQsQ3YMbwDysuR39+7ksRKmiEwKagZGVwhGBFceXeWr8g
         nb2ROPQ72HOtGHcFf6kwNhWia2AM1IoKT9LsJHLuDxzv08XWB6nGfxOlIqkjIggutMnh
         PBY+TANBsbKTRHw+seFMxigy+NU/89TR/L/LUZ0dCMO4P+T+0EV4y3TWRiWZe+QooimX
         Czzw==
X-Gm-Message-State: ALoCoQkRfsji7QuPH2WKf8JE2QgJuyEmmUow27/pYGrwk/S0uYCFKXYS66pvfpE3MbpfHzZ2clWV
X-Received: by 10.183.11.76 with SMTP id eg12mr34067293obd.47.1415034214966;
        Mon, 03 Nov 2014 09:03:34 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id e24si959533yhe.3.2014.11.03.09.03.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 09:03:34 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id 0PgLwk2y.1; Mon, 03 Nov 2014 09:03:34 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 133F0E0FC4; Mon,  3 Nov 2014 08:56:01 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 22 ++--------------------
 refs.h |  2 +-
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index ed0485e..c607ab7 100644
--- a/refs.c
+++ b/refs.c
@@ -3633,26 +3633,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 			   int flags, int have_old, const char *msg,
 			   struct strbuf *err)
 {
-	struct ref_update *update;
-
-	assert(err);
-
-	if (transaction->state != REF_TRANSACTION_OPEN)
-		die("BUG: delete called for transaction that is not open");
-
-	if (have_old && !old_sha1)
-		die("BUG: have_old is true but old_sha1 is NULL");
-
-	update = add_update(transaction, refname);
-	update->flags = flags;
-	update->have_old = have_old;
-	if (have_old) {
-		assert(!is_null_sha1(old_sha1));
-		hashcpy(update->old_sha1, old_sha1);
-	}
-	if (msg)
-		update->msg = xstrdup(msg);
-	return 0;
+	return ref_transaction_update(transaction, refname, null_sha1,
+				      old_sha1, flags, have_old, msg, err);
 }
 
 int update_ref(const char *action, const char *refname,
diff --git a/refs.h b/refs.h
index 2bc3556..7d675b7 100644
--- a/refs.h
+++ b/refs.h
@@ -283,7 +283,7 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
  * Add a reference update to transaction.  new_sha1 is the value that
- * the reference should have after the update, or zeros if it should
+ * the reference should have after the update, or null_sha1 if it should
  * be deleted.  If have_old is true, then old_sha1 holds the value
  * that the reference should have had before the update, or zeros if
  * it must not have existed beforehand.
-- 
2.1.0.rc2.206.gedb03e5
