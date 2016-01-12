From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 03/21] refs: add methods for the ref iterators
Date: Mon, 11 Jan 2016 20:22:02 -0500
Message-ID: <1452561740-8668-4-git-send-email-dturner@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jan 12 02:22:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aInfU-0003Bc-FS
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 02:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761765AbcALBWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 20:22:34 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34291 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761337AbcALBWc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 20:22:32 -0500
Received: by mail-qg0-f51.google.com with SMTP id 6so339423810qgy.1
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 17:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nkist2CQXHRrdwduZWRS01hr+3G2Nh1BJ7p/AWo3BS4=;
        b=Jgdcr4htI6aznhQqf3/6P2WgXYMl2Wq5E5rASVfb6Deyb8V22s/Nsbqi/yvwPted03
         1mraLxxWSn7xPHFkscwQlLhvLuS8BPG0Y0/o6rB4iLANx1maT+fYBDhUyoHtTzwOfXlq
         Rp9I7XPpupTUJTfw+0Zodwv9/GFSq38BX2Z+Yj7jaKbpurh8D0JwMSw3+0UbfRncV8DU
         XtjBOZCNGxKMa+pbodlDmzRyM1/BDmjnW10YB5MlivVHp9z9ThQz+FJPUL8080JhOQ6r
         Q0xF9Yk5VfaUQTkMEAJ/TRZquT6fF7iwdQUmy/M/nYEhyyyJ5IrHcEQFvc+4Zc4bmKP2
         XuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nkist2CQXHRrdwduZWRS01hr+3G2Nh1BJ7p/AWo3BS4=;
        b=bvCYtBnhPMYkzFS3R1cinpogPRK5LkDdX6QfYlZmNG8MAkGH7b3NxGm47le/JM/kz0
         3IXWgSl2KXpKpV+xaKZ2/DZ22H70s+Dtwcc1T3hADTj4Pg62I3WZYBQ3FZfxuUeqfpiB
         m19YTdCt5dqCvA2nWAp2cnvYJHTNT5pMb58NuUcuNlshPiq14yLvH4tS1xiJyFQMZxzR
         cXK3J26ZPEUU+uBbIT/Q5JzNdhHxg9nx/L6oMiDWwf2749fGSKktV6eSdk00ZJklieUj
         AjOsdzZ7V+88I2hO5qBvfvWfPKEiIu3V/GEBQikipSG4THi0xrG3hJq0++fmZbdpPEvg
         p+0g==
X-Gm-Message-State: ALoCoQmlkGPe2X3FNx+i+/b7DSWVBGmK/MA06seCv5dPIb7Y93UJ8NjAAI5HlTVuQ5Ds0a1GcGj3KiKFpG59N6R+Kih5p28rUw==
X-Received: by 10.140.105.198 with SMTP id c64mr8185484qgf.94.1452561751221;
        Mon, 11 Jan 2016 17:22:31 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id d64sm55362053qgd.48.2016.01.11.17.22.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jan 2016 17:22:30 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283740>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 41 +++++++++++++++++++++++++++------------
 refs/refs-internal.h | 29 ++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 6875ff9..2deb2e0 100644
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
index e65afff..b35dece 100644
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
@@ -3527,4 +3533,15 @@ struct ref_storage_be refs_be_files = {
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
