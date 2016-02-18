From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 11/27] refs: add method to rename refs
Date: Thu, 18 Feb 2016 00:17:34 -0500
Message-ID: <1455772670-21142-12-git-send-email-dturner@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 18 06:20:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWH0m-0002Tp-BL
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 06:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425016AbcBRFUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 00:20:10 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:32881 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424840AbcBRFSm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 00:18:42 -0500
Received: by mail-qk0-f177.google.com with SMTP id s5so14809689qkd.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 21:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Pnr+HkYerX1tMPjm/cB4zZK/eEZZ/m0zS9DkLKJKAQ=;
        b=b2ijGhsapA7cFjPrwtVoSAtMTThwBaGebMGJWUZ5GOjSL/XsHjLPDBiF/6/WMoS/wh
         8Gzvx6DDygybIVQfoAoRdmOVz+yAguZDQsjdMfXiGa+nZxWYsB7UI/QOJwLXNLUdN/T8
         cGzTvItzYlAQXEbb8/noh1EmmfcCUVWFFvXV3Z5mEnjKSSKCICQRxj68cAW7sbyTCW9i
         7DOwwN/L0pddlR+ufBHO5UrFnjGK2xJHTM9Oxod3FF6yrko7+0SgjBzRnM8RjRNpw+xi
         LYETanvLllt9iEdNB/ic1tDj/801SCMAwnmXTpMt6cyf4ki4EyDIhk4BcyUdDAMgDl0o
         kTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Pnr+HkYerX1tMPjm/cB4zZK/eEZZ/m0zS9DkLKJKAQ=;
        b=bH+K3mRTw6rX1YFCGHNITJvYH9s8d6cteZG1Luxz/Z2jvIm0HBB/Z9cqkQ3C4I/Mf+
         RiKul46sYLlKEYCbnqFqXvJsY+t80LYmYouvIwIbpod18BuTmBYoGv2bSe1RPJ+GVAVA
         QNhjI0hjbEovpe8oLkKOWFAxhJUHaDTylTO9jn0hrn5AjfCrN+zNkKPWYg6aV++5PkY+
         LWrrp5gD/5gqhPUb4lJS9FOzWFjLm2cp01fxoAO5EOSTWQSA/PAWpQ54Nc6kEBDMDeMh
         eJpbDHsIzUiF1BmEihJhjKGPjQOpUPmRNIlB7+e+yi5s32zRglXZ4Z+XLmeHlw4LT31M
         rbTg==
X-Gm-Message-State: AG10YOQ+zT7nGr+YWR2mJPPIoPPjAg7BEqrD4RKrz9vphfMFbT73sh2uTSHSLsIa/kD68w==
X-Received: by 10.55.82.195 with SMTP id g186mr4510094qkb.47.1455772721865;
        Wed, 17 Feb 2016 21:18:41 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id q22sm1965322qkl.19.2016.02.17.21.18.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 21:18:40 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286597>

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 5 +++++
 refs/files-backend.c | 4 +++-
 refs/refs-internal.h | 8 ++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index e222d02..f5754f2 100644
--- a/refs.c
+++ b/refs.c
@@ -1303,3 +1303,8 @@ int delete_refs(struct string_list *refnames)
 {
 	return the_refs_backend->delete_refs(refnames);
 }
+
+int rename_ref(const char *oldref, const char *newref, const char *logmsg)
+{
+	return the_refs_backend->rename_ref(oldref, newref, logmsg);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5377e3f..d38acd6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2424,7 +2424,8 @@ static int commit_ref_update(struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg,
 			     int flags, struct strbuf *err);
 
-int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
+static int files_rename_ref(const char *oldrefname, const char *newrefname,
+			    const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
 	int flag = 0, logmoved = 0;
@@ -3514,6 +3515,7 @@ struct ref_storage_be refs_be_files = {
 	files_peel_ref,
 	files_create_symref,
 	files_delete_refs,
+	files_rename_ref,
 
 	files_resolve_ref_unsafe,
 	files_verify_refname_available,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 94227cf..10a4e4d 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -195,6 +195,11 @@ const char *find_descendant_ref(const char *dirname,
 				const struct string_list *extras,
 				const struct string_list *skip);
 
+/*
+ * Check if the new name does not conflict with any existing refs
+ * (other than possibly the old ref).  Return 0 if the ref can be
+ * renamed to the new name.
+ */
 int rename_ref_available(const char *oldname, const char *newname);
 
 /* Include broken references in a do_for_each_ref*() iteration: */
@@ -244,6 +249,8 @@ typedef int create_symref_fn(const char *ref_target,
 			     const char *refs_heads_master,
 			     const char *logmsg);
 typedef int delete_refs_fn(struct string_list *refnames);
+typedef int rename_ref_fn(const char *oldref, const char *newref,
+			  const char *logmsg);
 
 /* resolution methods */
 typedef const char *resolve_ref_unsafe_fn(const char *ref,
@@ -275,6 +282,7 @@ struct ref_storage_be {
 	peel_ref_fn *peel_ref;
 	create_symref_fn *create_symref;
 	delete_refs_fn *delete_refs;
+	rename_ref_fn *rename_ref;
 
 	resolve_ref_unsafe_fn *resolve_ref_unsafe;
 	verify_refname_available_fn *verify_refname_available;
-- 
2.4.2.767.g62658d5-twtrsrc
