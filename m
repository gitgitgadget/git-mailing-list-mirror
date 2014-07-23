From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 04/15] refs.c: add a new update_type field to ref_update
Date: Wed, 23 Jul 2014 10:03:44 -0700
Message-ID: <1406135035-26441-5-git-send-email-sahlberg@google.com>
References: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 19:04:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9zxd-0004Bb-4I
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 19:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbaGWREG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 13:04:06 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:49119 "EHLO
	mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932355AbaGWRD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 13:03:59 -0400
Received: by mail-oi0-f73.google.com with SMTP id u20so294221oif.2
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RoDJFiXX1PN0au9XpGbgPcIDOEjI5aSt/KrX5dqhzwU=;
        b=n7a+Owls60H9mjT6Xo2244yO9fJh9Q8tWMqe6LjB8VpKFLkp2bMy0G2uPJWWQR+OXg
         I6488ITkDUYmtpE2KGUbeSmvHq4nq02U9fpnqP/wcd16Iy9l7HiZnOnlFOCVriXHLxJR
         HDDOxvv2KbpGfVXagkaK1/JDCyvmD7VUL8Rmh2kK38XV1yUacf4lvSb6sz2gRNBAPaOl
         oBcW5BnRYSCoH8CPsoz4yk+JcebL/sZS87ABSaE3n+I+CEC4HpxtH2BI1+mldcGbbZ1S
         6ViZ3KgJBiKtTKFEanlqqagDXnBPQC0PjK+5F7a4NvV0mV2zhWuIM/xUhYHZeXtM/L3Q
         xzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RoDJFiXX1PN0au9XpGbgPcIDOEjI5aSt/KrX5dqhzwU=;
        b=g6DsIrYLvIQcM20Owj/085vqQzJ0QJh4NMPMqhn/co8diF5Ly/dmX0h6vXLKNOqnc9
         qlvwUPy8HqIFyfiYV8vWjpgcRCeqUjKndwJTDv+6vgrnM0Wt2WjyaO0Jfkpo+box2vFQ
         TMHLjGokmPd3MIuoSg74Be7daasHq5s5i/hDl/uJySLjUXpOTC77R27CRB6dkPhyAJfC
         w4LTYVACob8zWNJMiUPyfAv2jW+QkF7drzr1DitzID0PJrSz/e1K2x+gpklQI1fiCyG0
         qLAaF0uweSiKEweGwCiCjjvgpoYIx6cor+/5j0DzTIlPVLugshcjPih/ziUsAe3z6AWM
         Ge7w==
X-Gm-Message-State: ALoCoQn6MiEgEcYy1hxgTY+KNDApRPQZX08L9dvUdITZHLsrO7tXGNDuPMt/MduBunjFznph41US
X-Received: by 10.42.235.132 with SMTP id kg4mr1453813icb.22.1406135038566;
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si487011yhk.4.2014.07.23.10.03.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 42DA35A4478;
	Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D1406E0600; Wed, 23 Jul 2014 10:03:57 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.508.g763ab16
In-Reply-To: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254080>

Add a field that describes what type of update this refers to. For now
the only type is UPDATE_SHA1 but we will soon add more types.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 91163e8..e88cb97 100644
--- a/refs.c
+++ b/refs.c
@@ -3372,6 +3372,10 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
+enum transaction_update_type {
+       UPDATE_SHA1 = 0
+};
+
 /**
  * Information needed for a single ref update.  Set new_sha1 to the
  * new value or to zero to delete the ref.  To check the old value
@@ -3379,6 +3383,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
  * value or to zero to ensure the ref does not exist before update.
  */
 struct ref_update {
+	enum transaction_update_type update_type;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
 	int flags; /* REF_NODEREF? */
@@ -3441,12 +3446,14 @@ void transaction_free(struct ref_transaction *transaction)
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
@@ -3473,7 +3480,7 @@ int transaction_update_sha1(struct ref_transaction *transaction,
 		return -1;
 	}
 
-	update = add_update(transaction, refname);
+	update = add_update(transaction, refname, UPDATE_SHA1);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
 	update->have_old = have_old;
@@ -3561,7 +3568,10 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
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
@@ -3570,6 +3580,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 
 			return 1;
 		}
+	}
 	return 0;
 }
 
@@ -3599,10 +3610,12 @@ int transaction_commit(struct ref_transaction *transaction,
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
@@ -3625,6 +3638,8 @@ int transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
 		if (!is_null_sha1(update->new_sha1)) {
 			ret = write_ref_sha1(update->lock, update->new_sha1,
 					     update->msg);
@@ -3644,6 +3659,8 @@ int transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
 		if (update->lock) {
 			if (delete_ref_loose(update->lock, update->type, err))
 				ret = -1;
-- 
2.0.1.508.g763ab16
