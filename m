From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 42/44] refs.c: pass a skip list to name_conflict_fn
Date: Thu, 15 May 2014 10:29:57 -0700
Message-ID: <1400174999-26786-43-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:31:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzUv-0000Jo-PQ
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755696AbaEORbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:31:08 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:57737 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755699AbaEORaK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:10 -0400
Received: by mail-pb0-f74.google.com with SMTP id rr13so255280pbb.5
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dMIta4FpqnUVZgPBO4H2A3lJ2TlSPeKrF/ga3NH7tVk=;
        b=V62ODZC4lLlzqXcbP/yyzCaLSBTXeo9aWiPHg0cHhsh5SPjauGvotowxZiParlkPSy
         BHLIFtL5jo9StIBcwAqAU4TfJnT0wSGgRf628R2vhT6MT+NrN6w/KbVYEwqWG/kxVn0M
         FG9jDRkA9+AbqV3KOZhVSOKRsuNsycWaB4qw5W1pLP7h7txPm/bwf6T9xFSV/whxuucT
         Auhyhk2ZlUSXMsl0LOjRr193nSvxLIVpiQtVvNO84L60ByANFVQ0VJcFxu463edNtsIM
         bOyGuY1XTyTVjKWgeE7FDk+EW6QjVxWlVHvP6OeLH79xkOfG3pcxQEqO+N7AgJ0FM948
         Rdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dMIta4FpqnUVZgPBO4H2A3lJ2TlSPeKrF/ga3NH7tVk=;
        b=JTmiQoUACiy5pUJygZ6ALpuJeO5KxBLIfMlHyuxYtAz0SkpBYfE2H8+NQBUjwmyNkX
         e+uX8qS6wqLtnZ1gGpdYgwO6g1uotwYA6XpZeM9XWZ4QsBK7JH4d+Ek63hEzQEyJ6Dx4
         TFvnlkTmsEBtjD10aqFYBzJIKSYN74iuyhD5Tu2ED20BJPY39HyX7ugQXOfIZyQCA7Xw
         eamAdGqbxlQbmWh4B/Vd27Nw3HkiOH4IfuKVhm/iPgxYY0xulUMmQ2PHnKE8bh4t+BkT
         V5oxpB9hfmvZWz2RvxshxPScOacvkb1GcH3BWz9k3PWBhRcZ4Nz7EmV/NIfo/hZZ9EHg
         qRwA==
X-Gm-Message-State: ALoCoQlGJC2POjDTEdI45Lkwt6MHdwq7axVDFHF/CAc21n9q+4z1iXBzOxTfuR5qxsNVyZupes0/
X-Received: by 10.66.169.231 with SMTP id ah7mr5933150pac.40.1400175007773;
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n43si22359yhe.1.2014.05.15.10.30.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6E56A31C239;
	Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4DF6FE038E; Thu, 15 May 2014 10:30:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249136>

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
 refs.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index f458ff9..c940509 100644
--- a/refs.c
+++ b/refs.c
@@ -798,11 +798,19 @@ struct name_conflict_cb {
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
+	for(i = 0; i < data->skipnum; i++) {
+		if (!strcmp(entry->name, data->skip[i])) {
+			return 0;
+		}
+	}
 	if (data->oldrefname && !strcmp(data->oldrefname, entry->name))
 		return 0;
 	if (names_conflict(data->refname, entry->name)) {
@@ -817,15 +825,21 @@ static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
  * conflicting with the name of an existing reference in dir.  If
  * oldrefname is non-NULL, ignore potential conflicts with oldrefname
  * (e.g., because oldrefname is scheduled for deletion in the same
- * operation).
+ * operation). skip contains a list of refs we want to skip checking for
+ * conflicts with. Refs may be skipped due to us knowing that it will
+ * be deleted later during a transaction that deletes one reference and then
+ * creates a new conflicting reference. For example a rename from m to m/m.
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
@@ -2037,7 +2051,8 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
-					    int flags, int *type_p)
+					    int flags, int *type_p,
+					    const char **skip, int skipnum)
 {
 	char *ref_file;
 	const char *orig_refname = refname;
@@ -2084,7 +2099,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
@@ -2142,7 +2159,7 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
+	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p, NULL, 0);
 }
 
 /*
@@ -2592,6 +2609,9 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
 	const char *symref = NULL;
 
+	if (!strcmp(oldrefname, newrefname))
+		return 0;
+
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
 
@@ -2602,10 +2622,12 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
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
@@ -2638,7 +2660,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL, NULL, 0);
 	if (!lock) {
 		error("unable to lock %s for update", newrefname);
 		goto rollback;
@@ -2653,7 +2675,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL, NULL, 0);
 	if (!lock) {
 		error("unable to lock %s for rollback", oldrefname);
 		goto rollbacklog;
@@ -3512,7 +3534,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.rc3.477.g0f8edf7
