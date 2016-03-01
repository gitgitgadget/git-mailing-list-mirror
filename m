From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 03/33] refs: move for_each_*ref* functions into common code
Date: Mon, 29 Feb 2016 19:52:36 -0500
Message-ID: <1456793586-22082-4-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:53:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYZJ-0006xI-Lk
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbcCAAxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:53:35 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:36032 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbcCAAx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:29 -0500
Received: by mail-qg0-f47.google.com with SMTP id u110so1409158qge.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9QENzcYCppGEzK4rR0Rhg/SjWKm8d8j0Js6ZFj4n4oo=;
        b=lTqFPiBHCcVdErju8W5ARqvRC2zsl4SFHc7oMbgXyk6RVGzKXSvhRNUJ0kVcu3qBLS
         yyCmWSo0NBPZ0fC/6KPHH4amH4Z+NNuIxsNO7SpGUW1LiD5tBlhMlrgS5yc7coOXq2r+
         M/P92QjktbkEbMc9+UUB7kvzgbJa+6QhKNfK5H4a4XOISgG8JlSi+sAj6uDqWpMpit6J
         QI31w5gDQuHNRixsBUij41VoxP+RAWbMhpMHpS3WNoFEsgjep+EBH5a+EYNKgHpm5Uc/
         X0OiBE+LXNdjtf+QV30SjQZWjiDIwdrlj0VLRqI2L9E8qCaOjV/rsy7Rus7OVL+Xslug
         36Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9QENzcYCppGEzK4rR0Rhg/SjWKm8d8j0Js6ZFj4n4oo=;
        b=IL6gSCanKsKhwV7yPybYbgmEtsCCOAfHOflFkT6vg6fcgaEGs3aj1Mqt0Vc6iwAtn4
         o3oY2vO526HvU4CVc3nwMp/CmE4zr7xKxo8C+NsvcW7SEQfwIoP+phv38I8Wxat61HX6
         4CiRNM4Pzbrp56uswDQJbUXPRusjtsjOsRcuKWpID30KCgm6dly88QawYlw+P77EsNS8
         dZITa2QO3eXN+YyEMZUQRfoOYjDzWKhzXd4Rv9wNgpqu+bhoMSm52x6Kw2pyV/Sbgkdv
         opPBy1obQNKTKIZMLXaJSeJIIxhlO6EKN0OfVSuhd5X273myp3hsjRv3EelYPmQ+Rer1
         8B5g==
X-Gm-Message-State: AD7BkJJ5sAiy97Z+j412WP63ugiq9wU49Bw8zV4iIHMvHkRMeWJqtEuiTjuqsjGte+sxUg==
X-Received: by 10.140.246.136 with SMTP id r130mr11223154qhc.12.1456793608282;
        Mon, 29 Feb 2016 16:53:28 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:27 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287947>

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
index beac899..b49c077 100644
--- a/refs.c
+++ b/refs.c
@@ -1109,3 +1109,55 @@ int head_ref(each_ref_fn fn, void *cb_data)
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
