From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 16/23] refs-common.c: move ref iterators to the common code
Date: Wed, 13 Aug 2014 13:15:00 -0700
Message-ID: <1407960907-18189-17-git-send-email-sahlberg@google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:15:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHexT-0008Pc-3N
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753797AbaHMUP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:15:27 -0400
Received: from mail-qg0-f73.google.com ([209.85.192.73]:49992 "EHLO
	mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753694AbaHMUPM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:12 -0400
Received: by mail-qg0-f73.google.com with SMTP id q107so35888qgd.0
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TlUfpfpttCLbFJfmjyJS2InnRxnFltQSYuTcixJUnYM=;
        b=mQKPP6lK61CZmCQz/27U64xj10ysrZwgykP9c2NnMiqepkvXpgC21DRlvI4E4I0T+b
         n7/3ii9GABcU9V5hMJ+ma/miOY+wZNm7cKARoqsdL9E0lcGvQQwNzh7lsRzyBNgwtily
         zQuGcVohP3bajhdn1sw2ZPl/DXm3I6MIOZ2Gej3aGGwOxyulv4Z1Zqc5wSQQPRkGRFWT
         LjUnyNwZLENOcpI//t43JZauGmzgvRAZor1noJACB5LmEGdvKraIXNUYB/w1H3YLc+lg
         THA/uT6Moqoj/yGIG6FxoBA1Vaov+XSBvXZyfdS2ZpTvYwyuNZZaGMZbdhHbQec+qYuv
         xeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TlUfpfpttCLbFJfmjyJS2InnRxnFltQSYuTcixJUnYM=;
        b=D3ytaqX58xKgb1WNNfIB2Gjva2lmPFfCCbsVfgJu/UnDjr+K9dbylCetRW8yRfWF7A
         6acEfj1kJ5aUF32mx0h5A7XtT4awTRzDd3DO6gIhKlL8YwsJ9nzj/K92PKIFYdPV1Mbj
         k+wQHeikiXWLvJ3uKWYjAyJ+blT1yeSjGa0nBpTbffD7kJWYscFUggvVa2Vw654oDIE3
         8Ro/GASjDBT0U8Jeo5p7emFPEuTscnT7Fv0fcuZR7cwo7kjxSjLTecsZNscVeGc/XUAt
         JRma7wGs96AqgtG8Ib4MQUeiAHwNFCbvFlNW9uEa4KYCWZhNrTaBQL1XCwVAq/RxPxhF
         OP4A==
X-Gm-Message-State: ALoCoQkrTCQMujTKNVRbO3SB7wd/41t/DGfVNESSyH5PfpkXAT6GPfYBSZOzV0dpHCAzDih/0Vn9
X-Received: by 10.224.127.6 with SMTP id e6mr3513713qas.3.1407960910987;
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v20si209972yhe.2.2014.08.13.13.15.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id C2B675A4536;
	Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A50CCE09F4; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255235>

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
2.0.1.556.g3edca4c
