From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 09/21] refs: add method to rename refs
Date: Mon, 11 Jan 2016 20:22:08 -0500
Message-ID: <1452561740-8668-10-git-send-email-dturner@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jan 12 02:22:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aInfe-0003Hj-7l
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 02:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761828AbcALBWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 20:22:48 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35803 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761448AbcALBWk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 20:22:40 -0500
Received: by mail-qk0-f179.google.com with SMTP id n135so233502297qka.2
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 17:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mJmd1nMiHeNcCYagjVN4eL0JF1A82gNgr/1pklyHD5Y=;
        b=fWnFkHXAdR2kzk5IOCIwm+AVPw1aagzD2Nx7up8wgbKLFXsL1u8LyC7yZGrgZWBYkC
         e4KDFVbyqsWNxUgPO6rL8pev3f4D64Tq7TzfDUOVlv9x5iBSIbohm5eqy3irUJHBGbfM
         m26/x3RRGGuRzp1Y3m/Hq7uXSGSlS1tyfuLqsJLCtV2toYr0FEDVSOQ9Y7KsFwyavAOK
         CJ1+/jcv9lXQWhIYNQ+aplXXiDUEsrk+TzEDR18jxQE4VAMaTmgd9lv874+P7tPutgAo
         XWAkiwxGz8nMNJS75lzdexzDtY3qWJNnxZFT8uQLnjbtPureinhe87SZzXxJ1HfRUyS8
         KkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mJmd1nMiHeNcCYagjVN4eL0JF1A82gNgr/1pklyHD5Y=;
        b=gwoetEeP97qhr8oFV70wPaMQ5M/am4SGPxG22H9JeGbT6oRf6OcEZZx12GcDPCBNh1
         BzoQZLN4SrCuxgukBke6S2hEHMyRwWSeb3TAjsfp1krGDwCMRH5DPkavGp0xTC1/Ftcm
         hWgumUcVXAFEdvR0Pkgz0C+wapIae31Y/JFXldFgtzj4IKTH/nbAT7ch6oq+nNeGQpUO
         fxS4HO4E9YnwvR5tG/Ch+dMkx63eyXYgxkNt1W18ARyULoJDnAUlIlnC/3qtPyn2ksTe
         M4RWsZloyOcnDrfJC2Wfk1B/e81QvfBxL9A8mOAudT1zbVK5KSUn26L52faynnyEacN5
         tYRg==
X-Gm-Message-State: ALoCoQlm5M+kNrB6oc95CKOWq2AQ1kXaWoOmJyYgoo1dJegVnN6NuAyirj91i2OmyAyeLp/aH9Tgb/8NT8uHsf5K3OkavzQnbg==
X-Received: by 10.55.79.17 with SMTP id d17mr149558491qkb.56.1452561759694;
        Mon, 11 Jan 2016 17:22:39 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id d64sm55362053qgd.48.2016.01.11.17.22.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jan 2016 17:22:38 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283744>

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 37 +++++++++++++++++++++----------------
 refs/files-backend.c |  4 +++-
 refs/refs-internal.h |  9 +++++++++
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/refs.c b/refs.c
index af5f7a7..0b29b25 100644
--- a/refs.c
+++ b/refs.c
@@ -1089,22 +1089,6 @@ const char *find_descendant_ref(const char *dirname,
 	return NULL;
 }
 
-int rename_ref_available(const char *oldname, const char *newname)
-{
-	struct string_list skip = STRING_LIST_INIT_NODUP;
-	struct strbuf err = STRBUF_INIT;
-	int ret;
-
-	string_list_insert(&skip, oldname);
-	ret = !verify_refname_available(newname, NULL, &skip, &err);
-	if (!ret)
-		error("%s", err.buf);
-
-	string_list_clear(&skip, 0);
-	strbuf_release(&err);
-	return ret;
-}
-
 /* backend functions */
 int refs_init_db(struct strbuf *err, int shared)
 {
@@ -1122,6 +1106,11 @@ int delete_refs(struct string_list *refnames)
 	return the_refs_backend->delete_refs(refnames);
 }
 
+int rename_ref(const char *oldref, const char *newref, const char *logmsg)
+{
+	return the_refs_backend->rename_ref(oldref, newref, logmsg);
+}
+
 const char *resolve_ref_unsafe(const char *ref, int resolve_flags,
 			       unsigned char *sha1, int *flags)
 {
@@ -1135,6 +1124,22 @@ int verify_refname_available(const char *refname, struct string_list *extra,
 	return the_refs_backend->verify_refname_available(refname, extra, skip, err);
 }
 
+int rename_ref_available(const char *oldname, const char *newname)
+{
+	struct string_list skip = STRING_LIST_INIT_NODUP;
+	struct strbuf err = STRBUF_INIT;
+	int ret;
+
+	string_list_insert(&skip, oldname);
+	ret = !verify_refname_available(newname, NULL, &skip, &err);
+	if (!ret)
+		error("%s", err.buf);
+
+	string_list_clear(&skip, 0);
+	strbuf_release(&err);
+	return ret;
+}
+
 int pack_refs(unsigned int flags)
 {
 	return the_refs_backend->pack_refs(flags);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index e8e112c..fd4b530 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2478,7 +2478,8 @@ static int commit_ref_update(struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg,
 			     int flags, struct strbuf *err);
 
-int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
+static int files_rename_ref(const char *oldrefname, const char *newrefname,
+			    const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
 	int flag = 0, logmoved = 0;
@@ -3569,6 +3570,7 @@ struct ref_storage_be refs_be_files = {
 	files_peel_ref,
 	files_create_symref,
 	files_delete_refs,
+	files_rename_ref,
 
 	files_resolve_ref_unsafe,
 	files_verify_refname_available,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f3c2632..64c3092 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -53,6 +53,13 @@ int do_for_each_per_worktree_ref(const char *submodule, const char *base,
 				 void *cb_data);
 
 /*
+ * Check if the new name does not conflict with any existing refs
+ * (other than possibly the old ref).  Return 0 if the ref can be
+ * renamed to the new name.
+ */
+int rename_ref_available(const char *oldname, const char *newname);
+
+/*
  * Return true iff refname is minimally safe. "Safe" here means that
  * deleting a loose reference by this name will not do any damage, for
  * example by causing a file that is not a reference to be deleted.
@@ -246,6 +253,7 @@ typedef const char *resolve_ref_unsafe_fn(const char *ref,
 typedef int verify_refname_available_fn(const char *refname, struct string_list *extra, struct string_list *skip, struct strbuf *err);
 typedef int resolve_gitlink_ref_fn(const char *path, const char *refname,
 				   unsigned char *sha1);
+typedef int rename_ref_fn(const char *oldref, const char *newref, const char *logmsg);
 
 /* iteration methods */
 typedef int head_ref_fn(each_ref_fn fn, void *cb_data);
@@ -284,6 +292,7 @@ struct ref_storage_be {
 	peel_ref_fn *peel_ref;
 	create_symref_fn *create_symref;
 	delete_refs_fn *delete_refs;
+	rename_ref_fn *rename_ref;
 
 	resolve_ref_unsafe_fn *resolve_ref_unsafe;
 	verify_refname_available_fn *verify_refname_available;
-- 
2.4.2.749.g730654d-twtrsrc
