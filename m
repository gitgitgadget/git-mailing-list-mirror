From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 38/41] refs.c: pass a skip list to name_conflict_fn
Date: Tue, 27 May 2014 13:25:57 -0700
Message-ID: <1401222360-21175-39-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:27:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNxi-0003CU-G6
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198AbaE0U03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:26:29 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:47272 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbaE0U0G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:06 -0400
Received: by mail-yh0-f73.google.com with SMTP id f73so1646767yha.4
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+M6C2tpT+stK0ElLfxNjTECybZol8l72E1cqkMEOLuU=;
        b=B1Pd1ciwt6aCpa4hiI/tEAWAJ7gpcaFeli5KRfX46rz13iR1JkGF0/WAzJVSxc/5Yc
         zOowM+OSYSQ1oygsm+8MU9jbo5CRcxgrr1ISiv49+jV7rsxRppLkUy+wbFzcX0odXZWT
         6fiS6TwpRMYp0avQeafnt3Y+A3NTJLm0eBVthD3p/xR0AgY5OSqeKcI/zcoUbmiLeT2Y
         KTgv2jcjO/ZMhCWh2Gn6STBsl8Q3+eBhiFvSAVA7hD2A0AKiMKTN157JHqIoPMShEhrK
         AkIqW8ry83DRCLCDqtaGHl8RrtGLBVZ/osj3q4cdfC9aeNkfIZBjXn1ifX80+K5jBuEr
         TJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+M6C2tpT+stK0ElLfxNjTECybZol8l72E1cqkMEOLuU=;
        b=ROGt4lZk3eH+/H+8HMA1AmxsG5KUaxCxbwMuGUDxmYpr0GQJpCzYtnQmbE7xoIsyvN
         rCE5sHPHMUxp23UZNFavZ3kt5EfRsn2abV3SMx/FhFcM1QE7nssCfdc+bsuZOAkTTrrE
         14CCm3a2sMYEcjHLW4gkS2vmVxzJ+iN2Ym7HNW9AerAzDzEH3HVWJ4yLNNjpG9m1tqS4
         kbn3T76lbjOToXp9IAN8jzmqog1Ttzf2q5J3srSSHfcSc3WbukQVtouhJzALv6cuM9Il
         Br2x3PmmIsg3fYfJCdsGjo7JemR4BWNzmqV4N1WEAm285dcPnSXSY0FMds6SfOfKLtoM
         fMFg==
X-Gm-Message-State: ALoCoQm6jfh7X4HOd9rIbkMrEx7qxjL1piQt+9j0jmGOxPUi5zYDTswzfkph1kzM32z3+8xFTBLD
X-Received: by 10.52.142.72 with SMTP id ru8mr12483990vdb.0.1401222365615;
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si1574650yhj.5.2014.05.27.13.26.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 628CA370571;
	Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3ECCBE0DE4; Tue, 27 May 2014 13:26:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250214>

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
 refs.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 28138ea..d3812b7 100644
--- a/refs.c
+++ b/refs.c
@@ -793,11 +793,17 @@ struct name_conflict_cb {
 	const char *refname;
 	const char *oldrefname;
 	const char *conflicting_refname;
+	const char **skip;
+	int skipnum;
 };
 
 static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
 {
 	struct name_conflict_cb *data = (struct name_conflict_cb *)cb_data;
+	int i;
+	for (i = 0; i < data->skipnum; i++)
+		if (!strcmp(entry->name, data->skip[i]))
+			return 0;
 	if (data->oldrefname && !strcmp(data->oldrefname, entry->name))
 		return 0;
 	if (names_conflict(data->refname, entry->name)) {
@@ -812,15 +818,19 @@ static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
  * conflicting with the name of an existing reference in dir.  If
  * oldrefname is non-NULL, ignore potential conflicts with oldrefname
  * (e.g., because oldrefname is scheduled for deletion in the same
- * operation).
+ * operation). skip contains a list of refs we want to skip checking for
+ * conflicts with.
  */
 static int is_refname_available(const char *refname, const char *oldrefname,
-				struct ref_dir *dir)
+				struct ref_dir *dir,
+				const char **skip, int skipnum)
 {
 	struct name_conflict_cb data;
 	data.refname = refname;
 	data.oldrefname = oldrefname;
 	data.conflicting_refname = NULL;
+	data.skip = skip;
+	data.skipnum = skipnum;
 
 	sort_ref_dir(dir);
 	if (do_for_each_entry_in_dir(dir, 0, name_conflict_fn, &data)) {
@@ -2032,7 +2042,8 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
-					    int flags, int *type_p)
+					    int flags, int *type_p,
+					    const char **skip, int skipnum)
 {
 	char *ref_file;
 	const char *orig_refname = refname;
@@ -2079,7 +2090,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(refname, NULL, get_packed_refs(&ref_cache))) {
+	     !is_refname_available(refname, NULL,
+				   get_packed_refs(&ref_cache),
+				   skip, skipnum)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2137,7 +2150,7 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
+	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p, NULL, 0);
 }
 
 /*
@@ -2618,6 +2631,9 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
 	const char *symref = NULL;
 
+	if (!strcmp(oldrefname, newrefname))
+		return 0;
+
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
 
@@ -2628,10 +2644,12 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (!symref)
 		return error("refname %s not found", oldrefname);
 
-	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(&ref_cache)))
+	if (!is_refname_available(newrefname, oldrefname,
+				  get_packed_refs(&ref_cache), NULL, 0))
 		return 1;
 
-	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(&ref_cache)))
+	if (!is_refname_available(newrefname, oldrefname,
+				  get_loose_refs(&ref_cache), NULL, 0))
 		return 1;
 
 	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
@@ -2664,7 +2682,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL, NULL, 0);
 	if (!lock) {
 		error("unable to lock %s for update", newrefname);
 		goto rollback;
@@ -2679,7 +2697,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL, NULL, 0);
 	if (!lock) {
 		error("unable to lock %s for rollback", oldrefname);
 		goto rollbacklog;
@@ -3530,7 +3548,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.rc3.474.g0203784
