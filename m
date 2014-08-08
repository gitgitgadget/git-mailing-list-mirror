From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 16/22] refs-common.c: move ref iterators to the common code
Date: Fri,  8 Aug 2014 09:45:03 -0700
Message-ID: <1407516309-27989-17-git-send-email-sahlberg@google.com>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 18:46:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnJG-0000AC-QT
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756921AbaHHQpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:45:33 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:44331 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756631AbaHHQpR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:45:17 -0400
Received: by mail-vc0-f202.google.com with SMTP id hq11so760311vcb.5
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c0ZsRD+UJ7bQ6IfH/7gaWRxwK/evNbgMyZ2kb3/FRX0=;
        b=iAHp4G8v1kXxCpIS048PFVOcfuDg4y/w5sOrorQsdtjuK5Enap90ffe+nzhKL3gvso
         1NoOATSXw+9MbdV4qkRK9/8Pyn815shMKxlBBeaZXxIJQgImJxC+Frsd2tmZbCe9pHOZ
         nO6pSE48Ha4f0tszlauvmhvFnyWfVWZvgK4LOaLBNEJRUbZqVKpKzTggMxxuB5Pnv3Dr
         nFl3JSZ1R/UodQMPRGdz7E2s2zfptEz/aouQavajzjMuj+LMLTQtM4xcp5Z4NOiQeyoA
         WowVMGjfttlYvHXdB+SwQGovq1hsQMkgedGA68glSVtpY6Uty0iOlPUp4f0/3OuLoWqM
         ZcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c0ZsRD+UJ7bQ6IfH/7gaWRxwK/evNbgMyZ2kb3/FRX0=;
        b=WyLc9t+Qnazqj4CkVoUP6BxgSc6A0rRoDd1lwikPE15htHsfbQn91PssYWvf7eM2FF
         wG5vLg6Njo+FVuB59R41HZT2woanouQmwSlnEqxPpPAlGpCoFAwTJwk5tPAXijoveA5Y
         saU6DR6qDkVz3LPiqL/4xLPjSrMUj4c3R20KrE3feZBvANfEAE25NoqKX1lc45ATYSZi
         5w5TIibMW/COXal0B39tsTZ+QMvPoOiTxgg+QEJA0ZpDn8WibWIZrJQ45uxivOp47sM+
         tEV0EHSPMZFKeHxFERmUkHsOCUQEr2aezE/I1eGj6PrdGxZKb646tI/GumLvJqbw6X4v
         hF3Q==
X-Gm-Message-State: ALoCoQnHESLrwnz3ICQS5LWUS3hZnSbC5itLMfCyltO+Jts+xHiZh3o8/UwvVz6/RqRtGe8Wa73W
X-Received: by 10.236.28.226 with SMTP id g62mr5450236yha.0.1407516316009;
        Fri, 08 Aug 2014 09:45:16 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si504382yhk.4.2014.08.08.09.45.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 09:45:16 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id CA23231C5BF;
	Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9A586E1237; Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.553.geee1b3e
In-Reply-To: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255040>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.c        | 81 -----------------------------------------------------------
 2 files changed, 81 insertions(+), 81 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index d8a295c..3b20db3 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -668,6 +668,87 @@ out:
 	return cp - refname;
 }
 
+/* The argument to filter_refs */
+struct ref_filter {
+	const char *pattern;
+	each_ref_fn *fn;
+	void *cb_data;
+};
+
+static int filter_refs(const char *refname, const unsigned char *sha1, int flags,
+		       void *data)
+{
+	struct ref_filter *filter = (struct ref_filter *)data;
+	if (wildmatch(filter->pattern, refname, 0, NULL))
+		return 0;
+	return filter->fn(refname, sha1, flags, filter->cb_data);
+}
+
+int for_each_tag_ref(each_ref_fn fn, void *cb_data)
+{
+	return for_each_ref_in("refs/tags/", fn, cb_data);
+}
+
+int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return for_each_ref_in_submodule(submodule, "refs/tags/", fn, cb_data);
+}
+
+int for_each_branch_ref(each_ref_fn fn, void *cb_data)
+{
+	return for_each_ref_in("refs/heads/", fn, cb_data);
+}
+
+int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return for_each_ref_in_submodule(submodule, "refs/heads/", fn, cb_data);
+}
+
+int for_each_remote_ref(each_ref_fn fn, void *cb_data)
+{
+	return for_each_ref_in("refs/remotes/", fn, cb_data);
+}
+
+int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
+}
+
+int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
+	const char *prefix, void *cb_data)
+{
+	struct strbuf real_pattern = STRBUF_INIT;
+	struct ref_filter filter;
+	int ret;
+
+	if (!prefix && !starts_with(pattern, "refs/"))
+		strbuf_addstr(&real_pattern, "refs/");
+	else if (prefix)
+		strbuf_addstr(&real_pattern, prefix);
+	strbuf_addstr(&real_pattern, pattern);
+
+	if (!has_glob_specials(pattern)) {
+		/* Append implied '/' '*' if not present. */
+		if (real_pattern.buf[real_pattern.len - 1] != '/')
+			strbuf_addch(&real_pattern, '/');
+		/* No need to check for '*', there is none. */
+		strbuf_addch(&real_pattern, '*');
+	}
+
+	filter.pattern = real_pattern.buf;
+	filter.fn = fn;
+	filter.cb_data = cb_data;
+	ret = for_each_ref(filter_refs, &filter);
+
+	strbuf_release(&real_pattern);
+	return ret;
+}
+
+int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
+{
+	return for_each_glob_ref_in(fn, pattern, NULL, cb_data);
+}
+
 int check_refname_format(const char *refname, int flags)
 {
 	int component_len, component_count = 0;
diff --git a/refs.c b/refs.c
index fb9c614..9aa88ef 100644
--- a/refs.c
+++ b/refs.c
@@ -1377,22 +1377,6 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int fla
 	}
 }
 
-/* The argument to filter_refs */
-struct ref_filter {
-	const char *pattern;
-	each_ref_fn *fn;
-	void *cb_data;
-};
-
-static int filter_refs(const char *refname, const unsigned char *sha1, int flags,
-		       void *data)
-{
-	struct ref_filter *filter = (struct ref_filter *)data;
-	if (wildmatch(filter->pattern, refname, 0, NULL))
-		return 0;
-	return filter->fn(refname, sha1, flags, filter->cb_data);
-}
-
 enum peel_status {
 	/* object was peeled successfully: */
 	PEEL_PEELED = 0,
@@ -1646,36 +1630,6 @@ int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 	return do_for_each_ref(get_ref_cache(submodule), prefix, fn, strlen(prefix), 0, cb_data);
 }
 
-int for_each_tag_ref(each_ref_fn fn, void *cb_data)
-{
-	return for_each_ref_in("refs/tags/", fn, cb_data);
-}
-
-int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	return for_each_ref_in_submodule(submodule, "refs/tags/", fn, cb_data);
-}
-
-int for_each_branch_ref(each_ref_fn fn, void *cb_data)
-{
-	return for_each_ref_in("refs/heads/", fn, cb_data);
-}
-
-int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	return for_each_ref_in_submodule(submodule, "refs/heads/", fn, cb_data);
-}
-
-int for_each_remote_ref(each_ref_fn fn, void *cb_data)
-{
-	return for_each_ref_in("refs/remotes/", fn, cb_data);
-}
-
-int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
-}
-
 int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, "refs/replace/", fn, 13, 0, cb_data);
@@ -1706,41 +1660,6 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 	return ret;
 }
 
-int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
-	const char *prefix, void *cb_data)
-{
-	struct strbuf real_pattern = STRBUF_INIT;
-	struct ref_filter filter;
-	int ret;
-
-	if (!prefix && !starts_with(pattern, "refs/"))
-		strbuf_addstr(&real_pattern, "refs/");
-	else if (prefix)
-		strbuf_addstr(&real_pattern, prefix);
-	strbuf_addstr(&real_pattern, pattern);
-
-	if (!has_glob_specials(pattern)) {
-		/* Append implied '/' '*' if not present. */
-		if (real_pattern.buf[real_pattern.len - 1] != '/')
-			strbuf_addch(&real_pattern, '/');
-		/* No need to check for '*', there is none. */
-		strbuf_addch(&real_pattern, '*');
-	}
-
-	filter.pattern = real_pattern.buf;
-	filter.fn = fn;
-	filter.cb_data = cb_data;
-	ret = for_each_ref(filter_refs, &filter);
-
-	strbuf_release(&real_pattern);
-	return ret;
-}
-
-int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
-{
-	return for_each_glob_ref_in(fn, pattern, NULL, cb_data);
-}
-
 int for_each_rawref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, "", fn, 0,
-- 
2.0.1.553.geee1b3e
