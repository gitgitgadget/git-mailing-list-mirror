From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 45/48] refs.c: pass a skip list to name_conflict_fn
Date: Tue, 17 Jun 2014 08:53:59 -0700
Message-ID: <1403020442-31049-46-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:54:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwviW-0003rn-SZ
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbaFQPyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:54:32 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:40408 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756354AbaFQPyI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:08 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so782856pbc.0
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=McVkQ22goasnCPqamgTxoqUeQITvytbIpqxkBZv16cQ=;
        b=hTqaDNFP/TNKYErQt3DJEWm4g2m2Wmld5wTYpG1Ayhq3UN0OkdRPX4H/5tbRKynHa5
         PgvBQ16KDT/PjnYNPV9NekCWgcLAA8TxlzwwNCebBdMFXkKMiI/k3heQAhzAejxEDQ8p
         wh1x2mumrm4Rg0MmTg/LG5hbQHa+SAaQ1OMuwFpIuGxmkmoBI9ArQDeXuqy5hkO6tqmc
         VnZOu2CP4qVA0qKE6cr6FkKW9HX43xRo0Lhr+z/l4JhhDmlsY5joh4RQLrZTxViUNUW4
         0fOYiKUKrP58CUatpWu8qPdkMq7fYgUCpzm6+zFbE9hiWbteSWV4Q5NJgaioe8FwqZcp
         TFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=McVkQ22goasnCPqamgTxoqUeQITvytbIpqxkBZv16cQ=;
        b=BL/E20JxnKtWisZ8NKCe1mTgir2nghxQ4GhYOFOapqROyM3KSyVr7XPzVLhRnCnY0k
         jx+j3TgSISvG2TdHnPY0RPLD4AV2QV8isja4mt2ICpQErTStX7GW+D0Crkxyf9+5p8kj
         hzOPMRY7ZQ390WdV9e3fIm96N64fQcIw+4/SykTE7sq4beO0N628BJ3hdnZ+Coea2cLr
         XxISVy+9nr5EXjKt+2kesjB9Q6V5hQwxJPHc7aZ0M2kUthNaKtV72OR8Q4kxzV/E1Hgh
         8Zp6MNgoArfwJ8HnfbKWGUQJYe0QJOCebbWFvEm6p/QQGgoY9ttPI+YxPAU+XXYz5q3/
         2FHQ==
X-Gm-Message-State: ALoCoQn2X3a81tAbWIX5QYnUSSs6/CZ7NOZTXfHVD0VrLj1wjIkCL/ItWZuTzcVkTQQtqUUAkUSf
X-Received: by 10.66.228.162 with SMTP id sj2mr2411479pac.11.1403020446319;
        Tue, 17 Jun 2014 08:54:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si1208009yhp.6.2014.06.17.08.54.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 175E931C76C;
	Tue, 17 Jun 2014 08:54:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EC860E1354; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251877>

Allow passing a list of refs to skip checking to name_conflict_fn.
There are some conditions where we want to allow a temporary conflict and skip
checking those refs. For example if we have a transaction that
1, guarantees that m is a packed refs and there is no loose ref for m
2, the transaction will delete m from the packed ref
3, the transaction will create conflicting m/m

For this case we want to be able to lock and create m/m since we know that the
conflict is only transient. I.e. the conflict will be automatically resolved
by the transaction when it deletes m.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index 610e063..0e29fb4 100644
--- a/refs.c
+++ b/refs.c
@@ -801,15 +801,18 @@ static int names_conflict(const char *refname1, const char *refname2)
 
 struct name_conflict_cb {
 	const char *refname;
-	const char *oldrefname;
 	const char *conflicting_refname;
+	const char **skip;
+	int skipnum;
 };
 
 static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
 {
 	struct name_conflict_cb *data = (struct name_conflict_cb *)cb_data;
-	if (data->oldrefname && !strcmp(data->oldrefname, entry->name))
-		return 0;
+	int i;
+	for (i = 0; i < data->skipnum; i++)
+		if (!strcmp(entry->name, data->skip[i]))
+			return 0;
 	if (names_conflict(data->refname, entry->name)) {
 		data->conflicting_refname = entry->name;
 		return 1;
@@ -822,15 +825,18 @@ static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
  * conflicting with the name of an existing reference in dir.  If
  * oldrefname is non-NULL, ignore potential conflicts with oldrefname
  * (e.g., because oldrefname is scheduled for deletion in the same
- * operation).
+ * operation). skip contains a list of refs we want to skip checking for
+ * conflicts with.
  */
-static int is_refname_available(const char *refname, const char *oldrefname,
-				struct ref_dir *dir)
+static int is_refname_available(const char *refname,
+				struct ref_dir *dir,
+				const char **skip, int skipnum)
 {
 	struct name_conflict_cb data;
 	data.refname = refname;
-	data.oldrefname = oldrefname;
 	data.conflicting_refname = NULL;
+	data.skip = skip;
+	data.skipnum = skipnum;
 
 	sort_ref_dir(dir);
 	if (do_for_each_entry_in_dir(dir, 0, name_conflict_fn, &data)) {
@@ -2078,7 +2084,8 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 /* This function should make sure errno is meaningful on error */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
-					    int flags, int *type_p)
+					    int flags, int *type_p,
+					    const char **skip, int skipnum)
 {
 	char *ref_file;
 	const char *orig_refname = refname;
@@ -2127,7 +2134,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(refname, NULL, get_packed_refs(&ref_cache))) {
+	     !is_refname_available(refname, get_packed_refs(&ref_cache),
+				   skip, skipnum)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2185,7 +2193,7 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
+	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p, NULL, 0);
 }
 
 /*
@@ -2677,10 +2685,12 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (!symref)
 		return error("refname %s not found", oldrefname);
 
-	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(&ref_cache)))
+	if (!is_refname_available(newrefname, get_packed_refs(&ref_cache),
+				  &oldrefname, 1))
 		return 1;
 
-	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(&ref_cache)))
+	if (!is_refname_available(newrefname, get_loose_refs(&ref_cache),
+				  &oldrefname, 1))
 		return 1;
 
 	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
@@ -2710,7 +2720,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL, NULL, 0);
 	if (!lock) {
 		error("unable to lock %s for update", newrefname);
 		goto rollback;
@@ -2725,7 +2735,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL, NULL, 0);
 	if (!lock) {
 		error("unable to lock %s for rollback", oldrefname);
 		goto rollbacklog;
@@ -3601,7 +3611,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 						    update->old_sha1 :
 						    NULL),
 						   update->flags,
-						   &update->type);
+						   &update->type,
+						   delnames, delnum);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
-- 
2.0.0.438.gec92e5c
