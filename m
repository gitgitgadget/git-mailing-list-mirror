From: David Turner <dturner@twopensource.com>
Subject: [PATCH 02/24] refs: move for_each_*ref* functions into common code
Date: Thu,  7 Apr 2016 15:02:49 -0400
Message-ID: <1460055791-23313-3-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:03:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFDK-00073u-TT
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756962AbcDGTD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:03:28 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:32967 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755730AbcDGTDX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:23 -0400
Received: by mail-qg0-f51.google.com with SMTP id j35so71754051qge.0
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z/W0VYm79xfZLltxY0KsjfuxJ74RL+QP4de5/4LPEUs=;
        b=IccA5vXicbZ1ZyGwyXQ2upfnzTVurMovLffMBI/Q2P0JN/UbR4O3G6eipm71hlesCj
         6oTygtBzV7bAWkcngaH/lI1AezD4DZlCygXy4dge47xj+Ot1JqDO2F2Ty6c/F7iwYOQy
         cEhv2MbfzAIvkgre0mU20yTC4gnF8xLFfrmT5RIeMPRyA3sIKJGFsTlNYAxvlSHXMK+p
         dBNnwxqQOOl4COs+tDKFkRqf4GCXsoLeXQhM2wwWE5pIKlcea6w82aMDZ5CK1b170OkE
         pmEFPn1nMADOvz+VHMP7kKJlueJNim+M2UEV7YMoRJaHsx1RqJ+/5nW7ppPtj9rqH1hc
         dDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z/W0VYm79xfZLltxY0KsjfuxJ74RL+QP4de5/4LPEUs=;
        b=UOx41Wk9B5ImKjYTEg7Sq34eJK01GQRdlf2DUpEs/nts6GjAom5kzr+v/NyYwgECia
         CXMGyT41ZbCdPJaQhxayrR2vklwr66KwpDtj4OU2Z92gEYke5dxzBDWdlb66C/CMSarV
         BSzCpvT7W7H9q+XkeJYYl36i6d318lsXRQ8A+sIXkcNw4uWQtFBlQPXfCegvfUKVtYBX
         81xuLdFw4eB+7e9kvIhsh3jm7Cc7FaUvlRbndRqJjnOiB3pV0Xw6DZkq2ENj68IjdXBD
         dh006HWlXfFa2xNySkV03C7AEuDfwcj6fjOWXsoadO30LC3umROOaQYZIo0AX9IeNDay
         s+5Q==
X-Gm-Message-State: AD7BkJLJbtVr2RNN36qW/X6E4auQyzYRIPLFQ9Dpc8PyctDXZtFWGDOLs4zBh8a/qNaPXQ==
X-Received: by 10.141.1.87 with SMTP id c84mr6386915qhd.1.1460055802697;
        Thu, 07 Apr 2016 12:03:22 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:21 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290955>

Make do_for_each_ref take a submodule as an argument instead of a
ref_cache.  Since all for_each_*ref* functions are defined in terms of
do_for_each_ref, we can then move them into the common code.

Later, we can simply make do_for_each_ref into a backend function.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 52 +++++++++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 62 +++++-----------------------------------------------
 refs/refs-internal.h |  9 ++++++++
 3 files changed, 66 insertions(+), 57 deletions(-)

diff --git a/refs.c b/refs.c
index 6b8c16c..f0feff7 100644
--- a/refs.c
+++ b/refs.c
@@ -1103,3 +1103,55 @@ int head_ref(each_ref_fn fn, void *cb_data)
 {
 	return head_ref_submodule(NULL, fn, cb_data);
 }
+
+int for_each_ref(each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(NULL, "", fn, 0, 0, cb_data);
+}
+
+int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(submodule, "", fn, 0, 0, cb_data);
+}
+
+int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(NULL, prefix, fn, strlen(prefix), 0, cb_data);
+}
+
+int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken)
+{
+	unsigned int flag = 0;
+
+	if (broken)
+		flag = DO_FOR_EACH_INCLUDE_BROKEN;
+	return do_for_each_ref(NULL, prefix, fn, 0, flag, cb_data);
+}
+
+int for_each_ref_in_submodule(const char *submodule, const char *prefix,
+		each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(submodule, prefix, fn, strlen(prefix), 0, cb_data);
+}
+
+int for_each_replace_ref(each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(NULL, git_replace_ref_base, fn,
+			       strlen(git_replace_ref_base), 0, cb_data);
+}
+
+int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int ret;
+	strbuf_addf(&buf, "%srefs/", get_git_namespace());
+	ret = do_for_each_ref(NULL, buf.buf, fn, 0, 0, cb_data);
+	strbuf_release(&buf);
+	return ret;
+}
+
+int for_each_rawref(each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(NULL, "", fn, 0,
+			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index c07dc41..9676ec2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -513,9 +513,6 @@ static void sort_ref_dir(struct ref_dir *dir)
 	dir->sorted = dir->nr = i;
 }
 
-/* Include broken references in a do_for_each_ref*() iteration: */
-#define DO_FOR_EACH_INCLUDE_BROKEN 0x01
-
 /*
  * Return true iff the reference described by entry can be resolved to
  * an object in the database.  Emit a warning if the referred-to
@@ -1727,10 +1724,13 @@ static int do_for_each_entry(struct ref_cache *refs, const char *base,
  * value, stop the iteration and return that value; otherwise, return
  * 0.
  */
-static int do_for_each_ref(struct ref_cache *refs, const char *base,
-			   each_ref_fn fn, int trim, int flags, void *cb_data)
+int do_for_each_ref(const char *submodule, const char *base,
+		    each_ref_fn fn, int trim, int flags, void *cb_data)
 {
 	struct ref_entry_cb data;
+	struct ref_cache *refs;
+
+	refs = get_ref_cache(submodule);
 	data.base = base;
 	data.trim = trim;
 	data.flags = flags;
@@ -1745,58 +1745,6 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
 	return do_for_each_entry(refs, base, do_one_ref, &data);
 }
 
-int for_each_ref(each_ref_fn fn, void *cb_data)
-{
-	return do_for_each_ref(&ref_cache, "", fn, 0, 0, cb_data);
-}
-
-int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	return do_for_each_ref(get_ref_cache(submodule), "", fn, 0, 0, cb_data);
-}
-
-int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
-{
-	return do_for_each_ref(&ref_cache, prefix, fn, strlen(prefix), 0, cb_data);
-}
-
-int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken)
-{
-	unsigned int flag = 0;
-
-	if (broken)
-		flag = DO_FOR_EACH_INCLUDE_BROKEN;
-	return do_for_each_ref(&ref_cache, prefix, fn, 0, flag, cb_data);
-}
-
-int for_each_ref_in_submodule(const char *submodule, const char *prefix,
-		each_ref_fn fn, void *cb_data)
-{
-	return do_for_each_ref(get_ref_cache(submodule), prefix, fn, strlen(prefix), 0, cb_data);
-}
-
-int for_each_replace_ref(each_ref_fn fn, void *cb_data)
-{
-	return do_for_each_ref(&ref_cache, git_replace_ref_base, fn,
-			       strlen(git_replace_ref_base), 0, cb_data);
-}
-
-int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
-{
-	struct strbuf buf = STRBUF_INIT;
-	int ret;
-	strbuf_addf(&buf, "%srefs/", get_git_namespace());
-	ret = do_for_each_ref(&ref_cache, buf.buf, fn, 0, 0, cb_data);
-	strbuf_release(&buf);
-	return ret;
-}
-
-int for_each_rawref(each_ref_fn fn, void *cb_data)
-{
-	return do_for_each_ref(&ref_cache, "", fn, 0,
-			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
-}
-
 static void unlock_ref(struct ref_lock *lock)
 {
 	/* Do not free lock->lk -- atexit() still looks at them */
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c7dded3..92aae80 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -197,4 +197,13 @@ const char *find_descendant_ref(const char *dirname,
 
 int rename_ref_available(const char *oldname, const char *newname);
 
+
+/* Include broken references in a do_for_each_ref*() iteration: */
+#define DO_FOR_EACH_INCLUDE_BROKEN 0x01
+
+/*
+ * The common backend for the for_each_*ref* functions
+ */
+int do_for_each_ref(const char *submodule, const char *base,
+		    each_ref_fn fn, int trim, int flags, void *cb_data);
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.4.2.767.g62658d5-twtrsrc
