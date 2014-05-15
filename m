From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 09/44] refs.c: remove the onerr argument to ref_transaction_commit
Date: Thu, 15 May 2014 16:15:06 -0700
Message-ID: <1400195741-22996-10-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:16:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4sm-0004YP-1O
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756198AbaEOXP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:15:57 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:47380 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755801AbaEOXPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:45 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so719457yhl.3
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wDTeZBlQoRDPZT63OcuDaqeWUaRTv8lqTml2K0seXyc=;
        b=h5QRSgxi3fhmMmJAfhu6N2OCcEYjV4IQ5V2i/Yxu1giHsALl8gIzKT3bVeXiOTh2Ly
         svR9gWCTxsPendPto8QnaEyroqJE4nPNB2elKDcBdvtqUJ+bE3vEkqjU6HpGfS909CW3
         XjTmQ3ISqVL3jX67VA1A0PzE4YYD3/r2iHTXkgI/kk6DbfqsrqXmLVdZZsQILpEQcwyU
         VhQCZHKoIHzF1rR8lmBHEPV0ET/4MyB5k0lHSnqBzsdZeo57gmHYIlxSPkv2rya1ftdB
         IDn9VlU5/fPGgzG9cKYuKh1B94bjSTWgkRVgzdLEzQpWgJPoHwtCaRpAxXTF0T82ipvO
         S5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wDTeZBlQoRDPZT63OcuDaqeWUaRTv8lqTml2K0seXyc=;
        b=ez6qlwLsAm2stWv16NxUHa0gu6BSHSUkA4abf4q6fsL9Jk6WDHTIuoudfCFIsyWqoY
         JAZzogXuzzeOS5+Qr8sFGB33GEjj8Ipq9i1LiqiWysAnprdQFSCA7IUmW/tWrvUvY+zG
         E/t+mFaxiFYs7Xut6Usy0rF1e1WfCd0F3tOWS8UTXfMc1OC5W47S18hh7s+UkMBgFLWg
         LemxJL8NJ+YnNEAr2WOJiXfum8KPljPnrahr1VjgsXHULZ3I7Cou4tfnCPTPo5pVBDhO
         s+WoghCdnZFLSP2Nzz00oJeobDuNuhX/duzG5CewVWx6zmaGXoHW65NONbS6L353T9Ub
         kRLA==
X-Gm-Message-State: ALoCoQnsGcrO8HKCT7kUSrzBfhgJiI6QGgQkOx5KwEzVUkwrSMOiXTqy89eUR8tnbF2SktlKqE1q
X-Received: by 10.236.128.195 with SMTP id f43mr5576978yhi.45.1400195745087;
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si318066yhb.6.2014.05.15.16.15.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id CADFF31C25B;
	Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 84F5EE0D39; Thu, 15 May 2014 16:15:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249229>

Since all callers now use QUIET_ON_ERR we no longer need to provide an onerr
argument any more. Remove the onerr argument from the ref_transaction_commit
signature.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  3 +--
 refs.c               | 22 +++++++---------------
 refs.h               |  3 +--
 3 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 207e24d..2bef2a0 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -366,8 +366,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		if (ref_transaction_commit(transaction, msg, &err,
-					   UPDATE_REFS_QUIET_ON_ERR))
+		if (ref_transaction_commit(transaction, msg, &err))
 			die("%s", err.buf);
 		return 0;
 	}
diff --git a/refs.c b/refs.c
index e8756fd..3eb73a3 100644
--- a/refs.c
+++ b/refs.c
@@ -3444,8 +3444,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
-					struct strbuf *err,
-					enum action_on_err onerr)
+					struct strbuf *err)
 {
 	int i;
 	for (i = 1; i < n; i++)
@@ -3455,22 +3454,13 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 			if (err)
 				strbuf_addf(err, str, updates[i]->refname);
 
-			switch (onerr) {
-			case UPDATE_REFS_MSG_ON_ERR:
-				error(str, updates[i]->refname); break;
-			case UPDATE_REFS_DIE_ON_ERR:
-				die(str, updates[i]->refname); break;
-			case UPDATE_REFS_QUIET_ON_ERR:
-				break;
-			}
 			return 1;
 		}
 	return 0;
 }
 
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err,
-			   enum action_on_err onerr)
+			   const char *msg, struct strbuf *err)
 {
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
@@ -3485,7 +3475,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, err, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err);
 	if (ret)
 		goto cleanup;
 
@@ -3497,7 +3487,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       (update->have_old ?
 						update->old_sha1 : NULL),
 					       update->flags,
-					       &update->type, onerr);
+					       &update->type,
+					       UPDATE_REFS_QUIET_ON_ERR);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
@@ -3515,7 +3506,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			ret = update_ref_write(msg,
 					       update->refname,
 					       update->new_sha1,
-					       update->lock, err, onerr);
+					       update->lock, err,
+					       UPDATE_REFS_QUIET_ON_ERR);
 			update->lock = NULL; /* freed by update_ref_write */
 			if (ret)
 				goto cleanup;
diff --git a/refs.h b/refs.h
index 25ae110..555ee59 100644
--- a/refs.h
+++ b/refs.h
@@ -278,8 +278,7 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * the transaction failed. The string does not end in newline.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err,
-			   enum action_on_err onerr);
+			   const char *msg, struct strbuf *err);
 
 /** Lock a ref and then write its file */
 int update_ref(const char *action, const char *refname,
-- 
2.0.0.rc3.477.gffe78a2
