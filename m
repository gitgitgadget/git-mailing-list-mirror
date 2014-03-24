From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 21/27] refs: Remove API function update_refs()
Date: Mon, 24 Mar 2014 18:56:54 +0100
Message-ID: <1395683820-17304-22-git-send-email-mhagger@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:58:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS999-0002Oo-18
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbaCXR5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:57:53 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:43478 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753818AbaCXR5w (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:57:52 -0400
X-AuditID: 1207440c-f79656d000003eba-20-5330721f4d8b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 78.AF.16058.F1270335; Mon, 24 Mar 2014 13:57:51 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xr028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:57:49 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqCtfZBBssHy7nMXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4vaK+cwWP1p6mC0+di5gdmD3+Pv+A5PHzll32T0uvfzO5vHx2XJ2j2e9exg9
	Ll5S9vi8SS6APYrbJimxpCw4Mz1P3y6BO+NE527WgkcKFe8v32BpYPwm2cXIySEhYCJx7fQ0
	ZghbTOLCvfVsXYxcHEIClxklOqZNZYRwTjBJNG/cxA5SxSagK7Gop5kJxBYRUJOY2HaIBaSI
	WeAKo8SVj9tZQBLCAo4S77ougtksAqoSm5//BWvgFXCVOLXxJSvEOjmJKb8XgA3lBIpvbT8M
	doaQgIvEjo+9TBMYeRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXUy80s0UtNKd3ECAk+
	nh2M39bJHGIU4GBU4uGNMDYIFmJNLCuuzD3EKMnBpCTKy5YLFOJLyk+pzEgszogvKs1JLT7E
	KMHBrCTCaxkOlONNSaysSi3Kh0lJc7AoifOqLlH3ExJITyxJzU5NLUgtgsnKcHAoSfCGFQI1
	ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIOiI74YGB8gKR6gvQ4g7bzFBYm5QFGI
	1lOMilLivNcKgBICIImM0jy4sbCU8opRHOhLYd4EkHYeYDqC634FNJgJaHB4kx7I4JJEhJRU
	AyNTkUIUl1ddzVTemr8sUr7ZKo+2B/z1Mz/FH+e+K7Bea+Wd5ru32+fzzY/V75g649Euwct1
	GflvJ91dp3xlwwKVN3ZLpR9H3OvY3mfBUh7Jx97GkjxTX+/u9MvOPU94vHg3tbKW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244847>

It has been superseded by reference transactions.  This also means
that struct ref_update can become private.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 33 ++++++++++++++++++++-------------
 refs.h | 20 --------------------
 2 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/refs.c b/refs.c
index e788c27..dfff117 100644
--- a/refs.c
+++ b/refs.c
@@ -3267,6 +3267,20 @@ static int update_ref_write(const char *action, const char *refname,
 	return 0;
 }
 
+/**
+ * Information needed for a single ref update.  Set new_sha1 to the
+ * new value or to zero to delete the ref.  To check the old value
+ * while locking the ref, set have_old to 1 and set old_sha1 to the
+ * value or to zero to ensure the ref does not exist before update.
+ */
+struct ref_update {
+	const char *ref_name;
+	unsigned char new_sha1[20];
+	unsigned char old_sha1[20];
+	int flags; /* REF_NODEREF? */
+	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
+};
+
 /*
  * Data structure for holding a reference transaction, which can
  * consist of checks and updates to multiple references, carried out
@@ -3393,16 +3407,17 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 	return 0;
 }
 
-int update_refs(const char *action, struct ref_update * const *updates_orig,
-		int n, enum action_on_err onerr)
+int ref_transaction_commit(struct ref_transaction *transaction,
+			   const char *msg, enum action_on_err onerr)
 {
 	int ret = 0, delnum = 0, i;
 	struct ref_update **updates;
 	int *types;
 	struct ref_lock **locks;
 	const char **delnames;
+	int n = transaction->nr;
 
-	if (!updates_orig || !n)
+	if (!n)
 		return 0;
 
 	/* Allocate work space */
@@ -3412,7 +3427,7 @@ int update_refs(const char *action, struct ref_update * const *updates_orig,
 	delnames = xmalloc(sizeof(*delnames) * n);
 
 	/* Copy, sort, and reject duplicate refs */
-	memcpy(updates, updates_orig, sizeof(*updates) * n);
+	memcpy(updates, transaction->updates, sizeof(*updates) * n);
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
 	ret = ref_update_reject_duplicates(updates, n, onerr);
 	if (ret)
@@ -3434,7 +3449,7 @@ int update_refs(const char *action, struct ref_update * const *updates_orig,
 	/* Perform updates first so live commits remain referenced */
 	for (i = 0; i < n; i++)
 		if (!is_null_sha1(updates[i]->new_sha1)) {
-			ret = update_ref_write(action,
+			ret = update_ref_write(msg,
 					       updates[i]->ref_name,
 					       updates[i]->new_sha1,
 					       locks[i], onerr);
@@ -3462,14 +3477,6 @@ cleanup:
 	free(types);
 	free(locks);
 	free(delnames);
-	return ret;
-}
-
-int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, enum action_on_err onerr)
-{
-	int ret = update_refs(msg, transaction->updates, transaction->nr,
-			      onerr);
 	ref_transaction_free(transaction);
 	return ret;
 }
diff --git a/refs.h b/refs.h
index 476a923..99c194b 100644
--- a/refs.h
+++ b/refs.h
@@ -10,20 +10,6 @@ struct ref_lock {
 	int force_write;
 };
 
-/**
- * Information needed for a single ref update.  Set new_sha1 to the
- * new value or to zero to delete the ref.  To check the old value
- * while locking the ref, set have_old to 1 and set old_sha1 to the
- * value or to zero to ensure the ref does not exist before update.
- */
-struct ref_update {
-	const char *ref_name;
-	unsigned char new_sha1[20];
-	unsigned char old_sha1[20];
-	int flags; /* REF_NODEREF? */
-	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
-};
-
 struct ref_transaction;
 
 /*
@@ -290,12 +276,6 @@ int update_ref(const char *action, const char *refname,
 		const unsigned char *sha1, const unsigned char *oldval,
 		int flags, enum action_on_err onerr);
 
-/**
- * Lock all refs and then perform all modifications.
- */
-int update_refs(const char *action, struct ref_update * const *updates,
-		int n, enum action_on_err onerr);
-
 extern int parse_hide_refs_config(const char *var, const char *value, const char *);
 extern int ref_is_hidden(const char *);
 
-- 
1.9.0
