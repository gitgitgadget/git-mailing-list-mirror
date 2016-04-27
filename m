From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 21/29] add_update(): initialize the whole ref_update
Date: Wed, 27 Apr 2016 18:57:38 +0200
Message-ID: <a1a444f7863a6d4457095912793337b8ba18f6d7.1461768690.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:59:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSnz-00040G-El
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbcD0Q6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:58:42 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:59417 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753011AbcD0Q6k (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:40 -0400
X-AuditID: 12074413-473ff700000008c7-45-5720efbefd1b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 99.58.02247.EBFE0275; Wed, 27 Apr 2016 12:58:38 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6Y022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:37 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqLvvvUK4wZkFVhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oyvW9cyFmyVrmjfMJmpgbFXrIuRk0NCwERi+o35
	zCC2kMBWRolNP8W7GLmA7ONMEl2LW9lBEmwCuhKLepqZQGwRAQeJ5St/sYMUMQs0MUl8X97E
	ApIQFnCRWLJ3NlgRi4CqxO9pZ8DivAJRErN+rmCG2CYncXn6AzYQm1PAQuJL61tGiM3mEkse
	rGafwMizgJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuuV5uZoleakrpJkZIiAnvYNx1Uu4Q
	owAHoxIPb4GEQrgQa2JZcWXuIUZJDiYlUd4lZ4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHin
	vwHK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeI++A2oULEpNT61I
	y8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB8VAfDEwCkBSPEB7S0HaeYsLEnOBohCtpxgVpcR5
	X4MkBEASGaV5cGNhieMVozjQl8K8F0CqeIBJB677FdBgJqDBlw/JggwuSURISTUwSiZKXE7e
	/3zRKauuNhv7h1rNCyelrhTNq3/8XzPwnZGI/LtAhhiRlYecXeV/N51ZH/9+SUNrztN2hric
	VGPm3Uxlv9exX5v74HBIjFF69rpffZ6Wco82C5+4PMX4ue18dmvRpDkMT8OybNYs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292759>

Change add_update() to initialize all of the fields in the new
ref_update object. Rename the function to ref_transaction_add_update(),
and increase its visibility to all of the refs-related code.

All of this makes the function more useful for other future callers.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
In particular, it's nice that it returns the "struct ref_update *"
that it creates, which is useful for refs-internal code that might
want to tweak other field in the ref_update. But we don't want
non-refs code to get its hands on a ref_update.

 refs.c               | 33 +++++++++++++++++----------------
 refs/refs-internal.h | 14 ++++++++++++++
 2 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 5dc2473..858b6d7 100644
--- a/refs.c
+++ b/refs.c
@@ -766,13 +766,24 @@ void ref_transaction_free(struct ref_transaction *transaction)
 	free(transaction);
 }
 
-static struct ref_update *add_update(struct ref_transaction *transaction,
-				     const char *refname)
+struct ref_update *ref_transaction_add_update(
+		struct ref_transaction *transaction,
+		const char *refname, unsigned int flags,
+		const unsigned char *new_sha1,
+		const unsigned char *old_sha1,
+		const char *msg)
 {
 	struct ref_update *update;
 	FLEX_ALLOC_STR(update, refname, refname);
 	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
 	transaction->updates[transaction->nr++] = update;
+	update->flags = flags;
+	if (flags & REF_HAVE_NEW)
+		hashcpy(update->new_sha1, new_sha1);
+	if (flags & REF_HAVE_OLD)
+		hashcpy(update->old_sha1, old_sha1);
+	if (msg)
+		update->msg = xstrdup(msg);
 	return update;
 }
 
@@ -783,8 +794,6 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err)
 {
-	struct ref_update *update;
-
 	assert(err);
 
 	if (transaction->state != REF_TRANSACTION_OPEN)
@@ -800,18 +809,10 @@ int ref_transaction_update(struct ref_transaction *transaction,
 		return -1;
 	}
 
-	update = add_update(transaction, refname);
-	if (new_sha1) {
-		hashcpy(update->new_sha1, new_sha1);
-		flags |= REF_HAVE_NEW;
-	}
-	if (old_sha1) {
-		hashcpy(update->old_sha1, old_sha1);
-		flags |= REF_HAVE_OLD;
-	}
-	update->flags = flags;
-	if (msg)
-		update->msg = xstrdup(msg);
+	flags |= (new_sha1 ? REF_HAVE_NEW : 0) | (old_sha1 ? REF_HAVE_OLD : 0);
+
+	ref_transaction_add_update(transaction, refname, flags,
+				   new_sha1, old_sha1, msg);
 	return 0;
 }
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index aaf56ea..c46fe67 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -158,6 +158,20 @@ struct ref_update {
 };
 
 /*
+ * Add a ref_update with the specified properties to transaction, and
+ * return a pointer to the new object. This function does not verify
+ * that refname is well-formed. new_sha1 and old_sha1 are only
+ * dereferenced if the REF_HAVE_NEW and REF_HAVE_OLD bits,
+ * respectively, are set in flags.
+ */
+struct ref_update *ref_transaction_add_update(
+		struct ref_transaction *transaction,
+		const char *refname, unsigned int flags,
+		const unsigned char *new_sha1,
+		const unsigned char *old_sha1,
+		const char *msg);
+
+/*
  * Transaction states.
  * OPEN:   The transaction is in a valid state and can accept new updates.
  *         An OPEN transaction can be committed.
-- 
2.8.1
