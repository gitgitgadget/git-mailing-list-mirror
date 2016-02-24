From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 02/32] refs: move for_each_*ref* functions into common code
Date: Wed, 24 Feb 2016 17:58:34 -0500
Message-ID: <1456354744-8022-3-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 24 23:59:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiPJ-0003fn-O1
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 23:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759085AbcBXW7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:59:24 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:35868 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759041AbcBXW7P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:15 -0500
Received: by mail-qg0-f50.google.com with SMTP id y9so27388097qgd.3
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WNHjhPUT1w8SWjx1k6C+E8RVOanNTnULIB7vur5W77o=;
        b=UoqxVmsjjweSAvlBsFfLoRlgEUgpJHgUlWoqrrfoiVDmCV72OnbokX3f8NuQSR+Mio
         KwhO+AZ2hE5JNw/YzifjLfy2BGL8t9/GfM2FeSoZeoJbrG2BegVWCrn+1k6VfkEJnY/S
         VEOLvSyMcNftaxxWIH/MI6jKtv3uDJ5H51MAEHdLC6KvBOoIVbd3p1Q/MHuHfYzNYY8O
         fFbYPhgC3Ni+dU/TeEQieisNkfprbzAWUcP5TaiQJdaP8N4vhyFoCHc8Ts+2mKKi9vwB
         FM0Kyx63/iSt3Phr+HGVg/A1arjXy14IwZ80U0beuAGmR8O/UM+8wQX9LIU+8wSGHh7Z
         zyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WNHjhPUT1w8SWjx1k6C+E8RVOanNTnULIB7vur5W77o=;
        b=mnY25ySf+FQ1MbSN1qK3N/doTSk+vuSBYTLVI8sNsbGDp/OU7ozsfKc3nYablxa9qX
         dgPeQnI5O2+yro/y5JT04Gnic1j79qmgVaGlE/akkSHM7wAmnWeUv6EjKN5F8RrRrFOB
         p755sTlut/F3uqrUcnhFsbAqVSpk9ZCBjJQXRsOUhTNJ00jNL6yDIA7rX4v5+qwaAO/2
         1/dylNMZsVHf4xn18FVXhfx+wV0XBxqrFDsI7ztHyuwvPy2vZJuSLvF9vSRAyfjuIl6t
         TU9NnZUXb+hXTGVkvIIDRAcDwKj/rNFB5UneCnufc2a8+iM1HeGz465E/V4iELZSxzdt
         +K1g==
X-Gm-Message-State: AG10YOQTo55p2eb27+WfqM4sa8Cj/EEWET/mzjstYpxhyc1zVe2ZFLZOQqqAroTmyN6yEA==
X-Received: by 10.140.96.84 with SMTP id j78mr50686796qge.93.1456354754557;
        Wed, 24 Feb 2016 14:59:14 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:13 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287247>

Make do_for_each_ref take a submodule as an argument instead of a
ref_cache.  Since all for_each_*ref* functions are defined in terms of
do_for_each_ref, we can then move them into the common code.

Later, we can simply make do_for_each_ref into a backend function.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 52 +++++++++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 62 +++++-----------------------------------------------
 refs/refs-internal.h |  9 ++++++++
 3 files changed, 66 insertions(+), 57 deletions(-)

diff --git a/refs.c b/refs.c
index 4367c14..c38311b 100644
--- a/refs.c
+++ b/refs.c
@@ -1105,3 +1105,55 @@ int head_ref(each_ref_fn fn, void *cb_data)
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
index 2e2a6d9..fd664d6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -518,9 +518,6 @@ static void sort_ref_dir(struct ref_dir *dir)
 	dir->sorted = dir->nr = i;
 }
 
-/* Include broken references in a do_for_each_ref*() iteration: */
-#define DO_FOR_EACH_INCLUDE_BROKEN 0x01
-
 /*
  * Return true iff the reference described by entry can be resolved to
  * an object in the database.  Emit a warning if the referred-to
@@ -1735,10 +1732,13 @@ static int do_for_each_entry(struct ref_cache *refs, const char *base,
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
@@ -1753,58 +1753,6 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
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
