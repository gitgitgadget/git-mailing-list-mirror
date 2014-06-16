From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 04/14] refs.c: add a new update_type field to ref_update
Date: Mon, 16 Jun 2014 09:51:35 -0700
Message-ID: <1402937505-6091-5-git-send-email-sahlberg@google.com>
References: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 18:53:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwa9a-0003ex-Uq
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 18:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbaFPQwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 12:52:40 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:52663 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932107AbaFPQvu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 12:51:50 -0400
Received: by mail-ie0-f202.google.com with SMTP id tr6so1129656ieb.5
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6k4g5gNr7o9v1PgDsLFzvYqyXE1hQNxWInfhM3fGUvM=;
        b=DCLNfdr/5YARJ881i1hhi/AsvW9kIHn+OKi55mVory63iR3mq3i9Rc2q+Wc7eC2WgK
         HVmQYJ/PyWkO2KP3lf/SMz4WH3a6T/RhJAVAXBUlghe+U5kX4U4CFfLGYMXycFlrKV08
         71P0yYDF84SzaSbMcRPNvmozizWVGu6Uv9+KEsUlElfVxG+MOJwKGEarub64eQ3rRW3M
         jLc5HwWzclwElBENgVa6XF2mnxFKYT/2r7UdQ2F2rbeDz6HhC4MJqMyKef4gHdBi95ZL
         g2z1CRHAd76Jb1v8T8zl0guTNWY0GhY0EgF4t8mWe7Cljt4w4uxuyl0PeqKslo8OmEAU
         15zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6k4g5gNr7o9v1PgDsLFzvYqyXE1hQNxWInfhM3fGUvM=;
        b=ZqIBaY+WS0PNcEsZ8HJN4CAFgjG6T5xVZx6IlXONIYmGBD3Nh9wf6kR20ZnPGqSjQ5
         iOYfpMfhYHm/SMcFESPJ5Fn58H0v1xzfFQBkfaC6rq5Y34I0EMJeNXz9aIf80Yp1jA4f
         IlsJe4uvnWhdI2jqFg7J1GNfObtuJSjYu4OgTVMdtFrYrZTJc5lI7UJji7AD02NVvxYr
         XMtMPT1r2Bxv6xp4Q5OU70hSkLURYIyzYCkNw65FIa3cFpO2f6Rtvmq3YziIVNkhi72w
         rPqM7Bego16+iEElyr0eVKMpjoyHc74X5q4aJO5vkRoQrY6BsD1dqTd/0GCUNTxdcAwG
         lcZQ==
X-Gm-Message-State: ALoCoQmk2qKd0GPqCViR4uMpvBD/FRMCQiLFMH+aYDyeTEGoIhKyBmBB4okfTbJ9ATteb4o0G/oJ
X-Received: by 10.50.79.129 with SMTP id j1mr29547igx.7.1402937509659;
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si982739yhp.6.2014.06.16.09.51.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5B4F531C64B;
	Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id F35EEE0961; Mon, 16 Jun 2014 09:51:48 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.770.gd892650.dirty
In-Reply-To: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251732>

Add a field that describes what type of update this refers to. For now
the only type is UPDATE_SHA1 but we will soon add more types.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index c57148f..ca924d7 100644
--- a/refs.c
+++ b/refs.c
@@ -3396,6 +3396,10 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
+enum transaction_update_type {
+       UPDATE_SHA1 = 0,
+};
+
 /**
  * Information needed for a single ref update.  Set new_sha1 to the
  * new value or to zero to delete the ref.  To check the old value
@@ -3403,6 +3407,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
  * value or to zero to ensure the ref does not exist before update.
  */
 struct ref_update {
+	enum transaction_update_type update_type;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
 	int flags; /* REF_NODEREF? */
@@ -3466,12 +3471,14 @@ void transaction_free(struct ref_transaction *transaction)
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
@@ -3492,7 +3499,7 @@ int transaction_update_sha1(struct ref_transaction *transaction,
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
-	update = add_update(transaction, refname);
+	update = add_update(transaction, refname, UPDATE_SHA1);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
 	update->have_old = have_old;
@@ -3577,7 +3584,10 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
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
@@ -3586,6 +3596,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 
 			return 1;
 		}
+	}
 	return 0;
 }
 
@@ -3615,10 +3626,12 @@ int transaction_commit(struct ref_transaction *transaction,
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
@@ -3641,6 +3654,8 @@ int transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
 		if (!is_null_sha1(update->new_sha1)) {
 			ret = write_ref_sha1(update->lock, update->new_sha1,
 					     update->msg);
@@ -3660,6 +3675,8 @@ int transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
 		if (update->lock) {
 			if (delete_ref_loose(update->lock, update->type, err))
 				ret = -1;
-- 
2.0.0.770.gd892650.dirty
