From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 03/21] refs: add methods for the ref iterators
Date: Fri,  5 Feb 2016 14:44:04 -0500
Message-ID: <1454701462-3817-4-git-send-email-dturner@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Feb 05 20:44:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRmJJ-0000vJ-Ol
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110AbcBETot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:44:49 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:36260 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754962AbcBETor (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:44:47 -0500
Received: by mail-qk0-f178.google.com with SMTP id s68so38142164qkh.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 11:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C5PNvQqNk3/2Ub8vG/z7P7r9qKPHMvMqVMVeWKcRuSw=;
        b=DZjVwQdDHvVYoT6diyqSFLxxKSBnMKfrSjeINH+xU962w5Bs9v7HwnxCt9Utlt9Cbu
         LMXvvrfFqv00BUbWRYHImrF/ML5im55cCXD9rDscCoxRGNdyAN/WdTomQUNslOanGtGI
         pO4jU27kCXk9BUA7ddcircoilCM42yR0TKZyTA5pWyKKUNneVxwFezVi1NibJCwpPjD7
         s4F+Rn53Tc0vZEp8WPVBVKdfyuPCr1BSepeID1Ztz+63mMm53M3dTR4mBRP26v2OW5KS
         nwTZ9zQa3f0tWUb3oBQXhJvwPsCR06fg5ZTVD0L3mhKwyOryas6H3ErH8JeaqITZx7sX
         18fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C5PNvQqNk3/2Ub8vG/z7P7r9qKPHMvMqVMVeWKcRuSw=;
        b=Yp5X0SuRNnS5pgf6BWMfE+z6PUJVKgQSfbweAwVnghHlCE9YiBgM4/H6yLzXDeg8eT
         ssO10TcyQ3Hd8mo6FKX3lS2G4gidcXpLKWaRiJZzKro/L95f0j37WJnBMudXkrLzjDYi
         lFMQupbh2j697n+yzSFYGyzZ95V2qZFSWURfSpClhe3lBUbi1FFUVQrF0Y8/rdhyfxNl
         aKeXVnVm25PU+nxD2lX9TMPfkX7a4BNtyyv/pg+pd+YQCYuThPu3I7iGtporEzJDDBBO
         ZigY6HdEXKFWOxdaM4cjjFs4DOuC/79+AjtyPH55b+VkZ80+yOpnrhN8V+ftdZqxDaUA
         oLhg==
X-Gm-Message-State: AG10YOQyb2ufVFoJvkzmig1BeFeYcl7m3p3W5o7spKChtALGWjOHgK/C9drbomZywRKD+w==
X-Received: by 10.55.72.207 with SMTP id v198mr19198108qka.65.1454701486490;
        Fri, 05 Feb 2016 11:44:46 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g109sm8565535qgg.40.2016.02.05.11.44.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 11:44:43 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285606>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 41 +++++++++++++++++++++++++++------------
 refs/refs-internal.h | 29 ++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index afdde7d..e598b73 100644
--- a/refs.c
+++ b/refs.c
@@ -1158,3 +1158,57 @@ int resolve_gitlink_ref(const char *path, const char *refname,
 {
 	return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
 }
+
+int head_ref(each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->head_ref(fn, cb_data);
+}
+
+int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->head_ref_submodule(submodule, fn, cb_data);
+}
+
+int for_each_ref(each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->for_each_ref(fn, cb_data);
+}
+
+int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->for_each_ref_submodule(submodule, fn, cb_data);
+}
+
+int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->for_each_ref_in(prefix, fn, cb_data);
+}
+
+int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
+			unsigned int broken)
+{
+	return the_refs_backend->for_each_fullref_in(prefix, fn, cb_data,
+						     broken);
+}
+
+int for_each_ref_in_submodule(const char *submodule, const char *prefix,
+			      each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->for_each_ref_in_submodule(submodule, prefix,
+							   fn, cb_data);
+}
+
+int for_each_rawref(each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->for_each_rawref(fn, cb_data);
+}
+
+int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->for_each_namespaced_ref(fn, cb_data);
+}
+
+int for_each_replace_ref(each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->for_each_replace_ref(fn, cb_data);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 882d830..0772a02 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1774,32 +1774,36 @@ static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 	return 0;
 }
 
-int head_ref(each_ref_fn fn, void *cb_data)
+static int files_head_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_head_ref(NULL, fn, cb_data);
 }
 
-int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+static int files_head_ref_submodule(const char *submodule, each_ref_fn fn,
+				    void *cb_data)
 {
 	return do_head_ref(submodule, fn, cb_data);
 }
 
-int for_each_ref(each_ref_fn fn, void *cb_data)
+static int files_for_each_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, "", fn, 0, 0, cb_data);
 }
 
-int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+static int files_for_each_ref_submodule(const char *submodule, each_ref_fn fn,
+					void *cb_data)
 {
 	return do_for_each_ref(get_ref_cache(submodule), "", fn, 0, 0, cb_data);
 }
 
-int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
+static int files_for_each_ref_in(const char *prefix, each_ref_fn fn,
+				 void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, prefix, fn, strlen(prefix), 0, cb_data);
 }
 
-int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken)
+static int files_for_each_fullref_in(const char *prefix, each_ref_fn fn,
+				     void *cb_data, unsigned int broken)
 {
 	unsigned int flag = 0;
 
@@ -1808,19 +1812,21 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsig
 	return do_for_each_ref(&ref_cache, prefix, fn, 0, flag, cb_data);
 }
 
-int for_each_ref_in_submodule(const char *submodule, const char *prefix,
-		each_ref_fn fn, void *cb_data)
+static int files_for_each_ref_in_submodule(const char *submodule,
+					   const char *prefix,
+					   each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(get_ref_cache(submodule), prefix, fn, strlen(prefix), 0, cb_data);
+	return do_for_each_ref(get_ref_cache(submodule), prefix, fn,
+			       strlen(prefix), 0, cb_data);
 }
 
-int for_each_replace_ref(each_ref_fn fn, void *cb_data)
+static int files_for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, git_replace_ref_base, fn,
 			       strlen(git_replace_ref_base), 0, cb_data);
 }
 
-int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
+static int files_for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
@@ -1830,7 +1836,7 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 	return ret;
 }
 
-int for_each_rawref(each_ref_fn fn, void *cb_data)
+static int files_for_each_rawref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, "", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
@@ -3551,4 +3557,15 @@ struct ref_storage_be refs_be_files = {
 	files_resolve_ref_unsafe,
 	files_verify_refname_available,
 	files_resolve_gitlink_ref,
+
+	files_head_ref,
+	files_head_ref_submodule,
+	files_for_each_ref,
+	files_for_each_ref_submodule,
+	files_for_each_ref_in,
+	files_for_each_fullref_in,
+	files_for_each_ref_in_submodule,
+	files_for_each_rawref,
+	files_for_each_namespaced_ref,
+	files_for_each_replace_ref,
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index e83bc22..4a1d215 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -216,6 +216,24 @@ typedef int verify_refname_available_fn(const char *refname, struct string_list
 typedef int resolve_gitlink_ref_fn(const char *path, const char *refname,
 				   unsigned char *sha1);
 
+/* iteration methods */
+typedef int head_ref_fn(each_ref_fn fn, void *cb_data);
+typedef int head_ref_submodule_fn(const char *submodule, each_ref_fn fn,
+				  void *cb_data);
+typedef int for_each_ref_fn(each_ref_fn fn, void *cb_data);
+typedef int for_each_ref_submodule_fn(const char *submodule, each_ref_fn fn,
+				      void *cb_data);
+typedef int for_each_ref_in_fn(const char *prefix, each_ref_fn fn,
+			       void *cb_data);
+typedef int for_each_fullref_in_fn(const char *prefix, each_ref_fn fn,
+				   void *cb_data, unsigned int broken);
+typedef int for_each_ref_in_submodule_fn(const char *submodule,
+					 const char *prefix,
+					 each_ref_fn fn, void *cb_data);
+typedef int for_each_rawref_fn(each_ref_fn fn, void *cb_data);
+typedef int for_each_namespaced_ref_fn(each_ref_fn fn, void *cb_data);
+typedef int for_each_replace_ref_fn(each_ref_fn fn, void *cb_data);
+
 struct ref_storage_be {
 	struct ref_storage_be *next;
 	const char *name;
@@ -228,6 +246,17 @@ struct ref_storage_be {
 	resolve_ref_unsafe_fn *resolve_ref_unsafe;
 	verify_refname_available_fn *verify_refname_available;
 	resolve_gitlink_ref_fn *resolve_gitlink_ref;
+
+	head_ref_fn *head_ref;
+	head_ref_submodule_fn *head_ref_submodule;
+	for_each_ref_fn *for_each_ref;
+	for_each_ref_submodule_fn *for_each_ref_submodule;
+	for_each_ref_in_fn *for_each_ref_in;
+	for_each_fullref_in_fn *for_each_fullref_in;
+	for_each_ref_in_submodule_fn *for_each_ref_in_submodule;
+	for_each_rawref_fn *for_each_rawref;
+	for_each_namespaced_ref_fn *for_each_namespaced_ref;
+	for_each_replace_ref_fn *for_each_replace_ref;
 };
 
 extern struct ref_storage_be refs_be_files;
-- 
2.4.2.749.g730654d-twtrsrc
