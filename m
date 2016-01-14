From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 03/20] refs: add methods for the ref iterators
Date: Thu, 14 Jan 2016 11:26:00 -0500
Message-ID: <1452788777-24954-4-git-send-email-dturner@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 14 17:26:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJkjY-0002BJ-H0
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755628AbcANQ0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:26:39 -0500
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34110 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755575AbcANQ0f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:26:35 -0500
Received: by mail-qg0-f46.google.com with SMTP id 6so407850291qgy.1
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 08:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GDNwil0/VnZcMTo+sbTgexKxt4q0MZ+y5InkBy89WHo=;
        b=Ka3XLMXrbe7UcmdMaoa+6REaUFliIUDtpTXw309p5knWwr3y96KcWEi/30t6a37g6z
         S8HnejcgmBoKqVxJ4IrkPqTmDV594pATQ2x95K2e27FWGe+CWlR9o0AntZqWL7cyjPsh
         PHi9KuhUW86FFokTsCUppVZFG3+Ga6udgbJA18SuV2W+J5qiD/j2w4QNgRJTOuy/4Gf3
         wKr11h+93mmaeOk6lHp06JvYHT5igwFzSwTgc6Kb8d+qUJ8N43IYVJNSuk4GIXUT5xVj
         x1WmUwe2/c+KjgHgf6H+RsLJetuYl+q7QGnIzTk4n452gFbqUDy6UCMQ39DJ7gnEt9O4
         9dPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GDNwil0/VnZcMTo+sbTgexKxt4q0MZ+y5InkBy89WHo=;
        b=cAo0XyWiqB/8y2xv+yM5KYQVH3lXIeWfXK7HY50lxP/1AK3DIRMydXKjjRazP+8T1J
         Y+CE7Rrwk0Iiyb0COb/DmSkSD4phlkZnRUU6RRI8rjxqYV/oSdb7DwiAjtdPwXieRy0n
         DcAg9ObCpw2Es1Tvbklq+WInOF034ukHwUnHgu1Fn30ICycMEOsyNV+/34+WYXku81KH
         F/ui52kxDv45L+TEjCqpgSNoUV+ATp7VU53RPay3Tqfgq+DMvn1yPaLTSxH0P/8dwF08
         fwf0wEpRP8FTsozv5n1AdgRG9Q9CaHYTcwj3GNQ1zWYtgUREeiSW72cgvoIPxv/GBUJ7
         adgg==
X-Gm-Message-State: ALoCoQmYS935agjtZjbBXSULCrGevN4S7Lk9W3oPKbgAqzQjoJWMQl2ZqcvPSfaGmqXJBQdlff5dEis25cYRwVZGO65pEJt83A==
X-Received: by 10.140.253.3 with SMTP id y3mr7093763qhc.39.1452788794555;
        Thu, 14 Jan 2016 08:26:34 -0800 (PST)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b95sm2724213qge.47.2016.01.14.08.26.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 08:26:33 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284038>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 41 +++++++++++++++++++++++++++------------
 refs/refs-internal.h | 29 ++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 7103781..9c2caa7 100644
--- a/refs.c
+++ b/refs.c
@@ -1147,3 +1147,57 @@ int resolve_gitlink_ref(const char *path, const char *refname,
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
index 783eb03..dcaf9eb 100644
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
@@ -3533,4 +3539,15 @@ struct ref_storage_be refs_be_files = {
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
index 0528239..cd338f9 100644
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
 
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.4.2.749.g730654d-twtrsrc
