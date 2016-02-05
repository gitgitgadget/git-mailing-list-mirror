From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 09/21] refs: add method to rename refs
Date: Fri,  5 Feb 2016 14:44:10 -0500
Message-ID: <1454701462-3817-10-git-send-email-dturner@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Feb 05 20:45:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRmJV-0001CI-3Z
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284AbcBETo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:44:59 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34171 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206AbcBEToy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:44:54 -0500
Received: by mail-qk0-f177.google.com with SMTP id x1so38254906qkc.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 11:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c0hb45elDx1lXO0+3n/n19nBFYc3xQq2+NvPHyybqaU=;
        b=1Ajpm869OpbAypbYZUu6tSj3ba1zbgo3mViGjaYp8+6a7t6VGJJObyN5tXeCfqUl3b
         SFN6uDOUrB0EwAhKjzXuCV9njYDSzCbJpRZbWqKHJnAMTKUdH2VGvvCz237qzmk0cIFj
         IGuEOeTHUXACDo5gBM6EfjLKOArnTDE+hAUTStDcxbD2HdTKS4xQJ+auG6aCMpjk7Bqq
         qRDn72/f/N39iViYRSm0e6x154iQ8B/COCllcsKSuJ0VECQfWjUe6Jno8uoXGjRFQvTi
         LMZJJQG5URCyftTJjb0O0s1aVw42DwX6ujxdwpZtFFOgyp6c/iYuoMF7Iv54r1Ie6zYn
         nokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c0hb45elDx1lXO0+3n/n19nBFYc3xQq2+NvPHyybqaU=;
        b=kH6HMOPaxIsgnOzPweKGRdQ79JdbduCxv9pKAtONnvGDH65WaRrz/3ea9NAWqAk4eE
         Ms15H/WVRnhyS08Trro/F3PsqcsMRf3u8t07SuiUlHhNGoZkCBb3frXTzqmDO/3maC4o
         voIkiPiHZBTbmGrIdu5DSemq0G7elMLP2jV4QiHBnsIyJF1/POL57qhGLmuneTmlWKcZ
         fRsiqT7JLHxjSY/521I1naoqmPr10IUlXe+QeKL//fRuaaiq22ScpEZsNQh/SPrwpGwc
         M6bfcrgWWWMbTjd1aTyWjwH3IfQeberSLpbXh0qWTnYyZvjiFll3OfkPYnvD9NRUWLbi
         Vvrg==
X-Gm-Message-State: AG10YOTSP6J+cKqGoptYEUVqxXKpZZsqpktGYAxI2wMRKlkWfWpnu7bkB/j0JmvGQ0UfSA==
X-Received: by 10.55.71.195 with SMTP id u186mr18626067qka.38.1454701493049;
        Fri, 05 Feb 2016 11:44:53 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g109sm8565535qgg.40.2016.02.05.11.44.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 11:44:52 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285609>

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 5 +++++
 refs/files-backend.c | 4 +++-
 refs/refs-internal.h | 9 +++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 7758bdc..e04fddc 100644
--- a/refs.c
+++ b/refs.c
@@ -1133,6 +1133,11 @@ int delete_refs(struct string_list *refnames)
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
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 45da091..685fc6f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2502,7 +2502,8 @@ static int commit_ref_update(struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg,
 			     int flags, struct strbuf *err);
 
-int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
+static int files_rename_ref(const char *oldrefname, const char *newrefname,
+			    const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
 	int flag = 0, logmoved = 0;
@@ -3592,6 +3593,7 @@ struct ref_storage_be refs_be_files = {
 	files_peel_ref,
 	files_create_symref,
 	files_delete_refs,
+	files_rename_ref,
 
 	files_resolve_ref_unsafe,
 	files_verify_refname_available,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 5768fee..15fa99c 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -67,6 +67,13 @@ int do_for_each_per_worktree_ref(const char *submodule, const char *base,
 				 each_ref_fn fn, int trim, int flags,
 				 void *cb_data);
 
+/*
+ * Check if the new name does not conflict with any existing refs
+ * (other than possibly the old ref).  Return 0 if the ref can be
+ * renamed to the new name.
+ */
+int rename_ref_available(const char *oldname, const char *newname);
+
 enum peel_status {
 	/* object was peeled successfully: */
 	PEEL_PEELED = 0,
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
