From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 04/14] refs.c: add a new update_type field to ref_update
Date: Wed, 18 Jun 2014 10:08:56 -0700
Message-ID: <1403111346-18466-5-git-send-email-sahlberg@google.com>
References: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:10:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJN4-0007XJ-G4
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716AbaFRRJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:09:52 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:40744 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbaFRRJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:09:10 -0400
Received: by mail-pb0-f74.google.com with SMTP id rq2so127099pbb.5
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gZn2N4tyF2p9MNLP56MLM32BToHgS5vU3k927YNxExU=;
        b=VvjD1hm8UvqxkOE3+2FPlWI14hF+SFn127ZR9yDi/HxeaiSHm5RrxRsPz+r+rVyn44
         xjZnlqc/ArC5xGgHrVvegDJpW8vSPHugCTb1J4ox2lcH4KwViXcq+QVFe7pYq/1TM22j
         Ov1DkMql3zxHxvR2JeJ9Ko+8Ft73tNP41ySr41A7JoFWWM71xXJFBqnA3erK4Wbd5pyf
         ZzShR8XUoSS8iiPFXn2pESCkoHJ3ZpHUiF0ZWcWU0vnfGv/L/DmseaizlWcjL4LGQTMl
         XiI3T11QzYon9zcaIY1KGPO3stzDlRTNMljrqbAgwafwSopxBx+OBYuTN/ToPwR1112Q
         wlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gZn2N4tyF2p9MNLP56MLM32BToHgS5vU3k927YNxExU=;
        b=Jmjk5F4BZtEfU+IHc2+X2C2NlofJP2ld4sPpah2QjNhzSmo8BvImAHj0hXPLCq5pgH
         E9aj1qv9X83pAHbygA5GI3I2BcxPNa50fteyOguZS6u9NsSiaKz4lqGe8rykM73ie/lC
         m4l86j8IB01YMh2pvJjlM+2iB0V8TLGDTXh4Chf2+2GHdw/ts2xdvOgCbU/Ehf6h+WYD
         kxaOdFWa+C+lRxrIUzA3zx7bPr7FCQ0kBS1spNZq7PYXzIYT5RIXPMOxzECfnikgk+9y
         7jIRzEQCQgkndDS5Ph2x29W4XEiblPqFiOGyk4YBhdMQhXwkhXSgFv5k3Omr47lqMBkE
         xPHg==
X-Gm-Message-State: ALoCoQl+16ZyfF94eB02b0VXLCegw10L10kygFS+kUjQzPHyrW12YwKPPlaHGrO9FCBlu6Jd02Pg
X-Received: by 10.66.249.68 with SMTP id ys4mr1281926pac.31.1403111349887;
        Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j5si174156yhi.1.2014.06.18.10.09.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8A0DE31C80B;
	Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 353E7E075A; Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.467.g08c0633
In-Reply-To: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252003>

Add a field that describes what type of update this refers to. For now
the only type is UPDATE_SHA1 but we will soon add more types.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 4e3d4c3..4129de6 100644
--- a/refs.c
+++ b/refs.c
@@ -3374,6 +3374,10 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
+enum transaction_update_type {
+       UPDATE_SHA1 = 0,
+};
+
 /**
  * Information needed for a single ref update.  Set new_sha1 to the
  * new value or to zero to delete the ref.  To check the old value
@@ -3381,6 +3385,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
  * value or to zero to ensure the ref does not exist before update.
  */
 struct ref_update {
+	enum transaction_update_type update_type;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
 	int flags; /* REF_NODEREF? */
@@ -3444,12 +3449,14 @@ void transaction_free(struct ref_transaction *transaction)
 }
 
 static struct ref_update *add_update(struct ref_transaction *transaction,
-				     const char *refname)
+				     const char *refname,
+				     enum transaction_update_type update_type)
 {
 	size_t len = strlen(refname);
 	struct ref_update *update = xcalloc(1, sizeof(*update) + len + 1);
 
 	strcpy((char *)update->refname, refname);
+	update->update_type = update_type;
 	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
 	transaction->updates[transaction->nr++] = update;
 	return update;
@@ -3470,7 +3477,7 @@ int transaction_update_sha1(struct ref_transaction *transaction,
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
-	update = add_update(transaction, refname);
+	update = add_update(transaction, refname, UPDATE_SHA1);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
 	update->have_old = have_old;
@@ -3555,7 +3562,10 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 					struct strbuf *err)
 {
 	int i;
-	for (i = 1; i < n; i++)
+	for (i = 1; i < n; i++) {
+		if (updates[i - 1]->update_type != UPDATE_SHA1 ||
+		    updates[i]->update_type != UPDATE_SHA1)
+			continue;
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			const char *str =
 				"Multiple updates for ref '%s' not allowed.";
@@ -3564,6 +3574,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 
 			return 1;
 		}
+	}
 	return 0;
 }
 
@@ -3593,10 +3604,12 @@ int transaction_commit(struct ref_transaction *transaction,
 		goto cleanup;
 	}
 
-	/* Acquire all locks while verifying old values */
+	/* Acquire all ref locks while verifying old values */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
 		update->lock = lock_ref_sha1_basic(update->refname,
 						   (update->have_old ?
 						    update->old_sha1 :
@@ -3619,6 +3632,8 @@ int transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
 		if (!is_null_sha1(update->new_sha1)) {
 			ret = write_ref_sha1(update->lock, update->new_sha1,
 					     update->msg);
@@ -3638,6 +3653,8 @@ int transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
 		if (update->lock) {
 			if (delete_ref_loose(update->lock, update->type, err))
 				ret = -1;
-- 
2.0.0.467.g08c0633
