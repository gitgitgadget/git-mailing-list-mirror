From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 04/11] refs.c: add a new update_type field to ref_update
Date: Wed,  4 Jun 2014 11:57:45 -0700
Message-ID: <1401908272-7600-5-git-send-email-sahlberg@google.com>
References: <1401908272-7600-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 20:58:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsGOX-0008BH-SQ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 20:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbaFDS6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 14:58:24 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:53988 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbaFDS6I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 14:58:08 -0400
Received: by mail-ve0-f201.google.com with SMTP id db11so1708366veb.4
        for <git@vger.kernel.org>; Wed, 04 Jun 2014 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OYUAyV0ZaAjt+bTRyhm5lkG4V9RGCOYiEwTCTrQ4YYM=;
        b=gu46K87Icd/Mj+nnQEZD/toXQi9U7i7J+C+DQ9jD+ZzpOaaJ6YNgmhjneh81i1kl+E
         s4Y3MU4lAYgG+39Nd0fLggy1Cmydsf0jLQVj1rX4v4hnrM8TEgUn2mpHKJ4iXaXuNNjv
         lduQlbrTvNuwHYJuxdd61j8gGCf5z3iVL3gOXi7+JUYJOIhH4nq9nKL1uePISuTwMvkk
         yQ/JStvWC6MQnh39NnS+lvgI3Dk1rqZt4T5n+0sr25fBn+JUxuDcNP5OLJMWIJCpOode
         gWpDzDBZa1T+ZQCyPIuXn+6vi/HQuq8Hj3f6MKsswsXKZc8ysg5lTsdNPxS9OsROULdf
         xa2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OYUAyV0ZaAjt+bTRyhm5lkG4V9RGCOYiEwTCTrQ4YYM=;
        b=X0HSh2lsGbbf1EPoq8GE5gFc2sFPhYOu8lWkDrB/TbXgHq6T3DxfaBf2x/298w8cwV
         bIFoUmM3m4AC//qBRXmleuA7cZv7MsjtYmPp7zq6MekcGe4aDN0j++XDTxVy7PFqdMPp
         W2nDBdth393qmLhfNUA3UDKsxoCDjXml0bhMNrJ2XE5QdzkHsoZHi5R//yfkFSetsof3
         201KTuIOgJ7llRrjM/NVZvk4lQfLPjIK7B7JeBsjpHoxwx+t8HNVEhbXMdkdk0/IPg9v
         uE5GgIoJhSuk/EhPVCcexmuFVNPubi0tZNZmbzZ84Rhv18WXDWnY+BNWUvagufH+8G12
         behQ==
X-Gm-Message-State: ALoCoQnE8kvjyWNcY8Z6s1UjSsQdpJg79aRr13kD+yEZiG8+oD+J7hh0ADh5fvMcJOz/tVK1cLM6
X-Received: by 10.236.101.148 with SMTP id b20mr20381282yhg.46.1401908286948;
        Wed, 04 Jun 2014 11:58:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id t4si311084yhm.0.2014.06.04.11.58.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jun 2014 11:58:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A76C62F42F6;
	Wed,  4 Jun 2014 11:58:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5C01DE0B05; Wed,  4 Jun 2014 11:58:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.578.gb9e379f
In-Reply-To: <1401908272-7600-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250765>

Add a field that describes what type of update this refers to. For now
the only type is UPDATE_SHA1 but we will soon add more types.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index f0800ac..0c3e83b 100644
--- a/refs.c
+++ b/refs.c
@@ -3343,6 +3343,10 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
+enum transaction_update_type {
+       UPDATE_SHA1 = 0,
+};
+
 /**
  * Information needed for a single ref update.  Set new_sha1 to the
  * new value or to zero to delete the ref.  To check the old value
@@ -3350,6 +3354,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
  * value or to zero to ensure the ref does not exist before update.
  */
 struct ref_update {
+	enum transaction_update_type update_type;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
 	int flags; /* REF_NODEREF? */
@@ -3413,12 +3418,14 @@ void transaction_free(struct ref_transaction *transaction)
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
@@ -3439,7 +3446,7 @@ int transaction_update_sha1(struct ref_transaction *transaction,
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
-	update = add_update(transaction, refname);
+	update = add_update(transaction, refname, UPDATE_SHA1);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
 	update->have_old = have_old;
@@ -3529,7 +3536,9 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 					struct strbuf *err)
 {
 	int i;
-	for (i = 1; i < n; i++)
+	for (i = 1; i < n; i++) {
+		if (updates[i - 1]->update_type != UPDATE_SHA1)
+			continue;
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			const char *str =
 				"Multiple updates for ref '%s' not allowed.";
@@ -3538,6 +3547,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 
 			return 1;
 		}
+	}
 	return 0;
 }
 
@@ -3567,10 +3577,12 @@ int transaction_commit(struct ref_transaction *transaction,
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
@@ -3593,6 +3605,8 @@ int transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
 		if (!is_null_sha1(update->new_sha1)) {
 			ret = write_ref_sha1(update->lock, update->new_sha1,
 					     update->msg);
@@ -3612,6 +3626,8 @@ int transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
 		if (update->lock) {
 			if (delete_ref_loose(update->lock, update->type, err))
 				ret = -1;
-- 
2.0.0.578.gb9e379f
