From: David Turner <dturner@twopensource.com>
Subject: [PATCH 03/16] refs: add methods for the ref iterators
Date: Wed,  2 Dec 2015 19:35:08 -0500
Message-ID: <1449102921-7707-4-git-send-email-dturner@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Dec 03 01:36:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4HtJ-00084v-Q0
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 01:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757860AbbLCAgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 19:36:12 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:34566 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757092AbbLCAfk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 19:35:40 -0500
Received: by ioir85 with SMTP id r85so64746547ioi.1
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 16:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qW8hUyhtxEWdz2ssUR1VGkkGxTWMNgIZhOYev9YM9L0=;
        b=daxdm1RNyt6OFrE8r/KrMQGhjY4WYHZDL+Er4oHuhTzwurzaPBgAyTGVofIdHRjJNy
         qKu5QoCc+a8u3L/RaQO+Bw41LRTBJ0zbwM0d0v3UyrjGvsSAq9U2SOrB7gJLpiobVUFf
         tl27y71GslJJ1qggDHKzpmKxBeRtXddxDqhWeJP17bYcv/CuJNPd5A8SarPIId3ixt04
         AUtBbuIYr9VNUpcL637czf84Vd6U3RmP3o2eUaBk3ofgCOl7+AskWXX5RDha3YNnSakm
         NQvoMrO+wXLP45guZn88FEwvfHtuiB5OqhPItbw0ZODMT5J4q+txyetVBc1mL88mOyG9
         x/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qW8hUyhtxEWdz2ssUR1VGkkGxTWMNgIZhOYev9YM9L0=;
        b=bl3hQEh+vgyhyIfi1T+fnRELTP57cAdXj1lKx5jJuMgfUueD1QoQV2DITpUraSCe84
         gla7oc6z5uNkuY8OWAs6i7skePHjuiD+Zxia0ZCgGIVGECyMSlCaJACq0TmqDXrfdYmG
         omh/quJHwiB7cpOUnTV0YSjHlGrl/Dg4nQa0FdFnxt8RsZZNTq+Bmz9xbmjivjscqfh4
         QflZX/jbjhVmuwzo9OkwDyDRlMLHhFrtPA1xhCCx9EJSGEFozyzQYQGeX/IOsV1s6q3I
         v/Q/vyterKzAvvOV+EYctUUc9HNt5XWpPKAMhEOXvo+g/XtGGMcZje6T2EcxF0auug95
         wBgQ==
X-Gm-Message-State: ALoCoQnTEdjBNggvf4OYYaqXUhYtLuBNPypH/yooO047lLVRekfUqFFp53Rpf8n1xpNFs0oQ3tTW
X-Received: by 10.107.162.68 with SMTP id l65mr5937313ioe.179.1449102940116;
        Wed, 02 Dec 2015 16:35:40 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id z15sm2108571iod.37.2015.12.02.16.35.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Dec 2015 16:35:39 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g0ed01d8-twtrsrc
In-Reply-To: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281939>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 41 +++++++++++++++++++++++++++------------
 refs/refs-internal.h | 29 ++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 9562325..b9b0244 100644
--- a/refs.c
+++ b/refs.c
@@ -1150,3 +1150,57 @@ int resolve_gitlink_ref(const char *path, const char *refname,
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
index 25fba43..d4bd6cf 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1756,32 +1756,36 @@ static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
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
 
@@ -1790,19 +1794,21 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsig
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
@@ -1812,7 +1818,7 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 	return ret;
 }
 
-int for_each_rawref(each_ref_fn fn, void *cb_data)
+static int files_for_each_rawref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, "", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
@@ -3527,4 +3533,15 @@ struct ref_be refs_be_files = {
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
index 236bce9..ad683df 100644
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
 struct ref_be {
 	struct ref_be *next;
 	const char *name;
@@ -228,6 +246,17 @@ struct ref_be {
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
 
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.4.2.749.g0ed01d8-twtrsrc
