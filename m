From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 15/25] refs: move ref iterators to the common code
Date: Tue,  3 Nov 2015 08:39:59 +0100
Message-ID: <e1eebbf63a9e097b662d6aabcac337c837844193.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:40:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWD1-0007Um-GH
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064AbbKCHko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:40:44 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:55595 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752677AbbKCHke (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:40:34 -0500
X-AuditID: 1207440d-f79136d00000402c-ff-563864f14fb1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 6A.6D.16428.1F468365; Tue,  3 Nov 2015 02:40:34 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDdC016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:33 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqPspxSLMoPcvk8X8TScYLbqudDNZ
	NPReYba4vWI+s8W/CTUOrB5/339g8liwqdTj4iVljwXP77N7fN4kF8AaxW2TlFhSFpyZnqdv
	l8CdcX3CGcaCtQYVG861MzcwntboYuTgkBAwkfi51aWLkRPIFJO4cG89WxcjF4eQwGVGiZ5P
	O9ghnGNMEtvW3WQCqWIT0JVY1NMMZosIqElMbDvEAlLELLCIUaL1zXSwhLCAq8ShtrnsIDaL
	gKrE9gMvGUFsXoEoiecLP7FCrJOTmHK/HayeU8BC4sHdP2D1QgLmEpvuLWObwMi7gJFhFaNc
	Yk5prm5uYmZOcWqybnFyYl5eapGukV5uZoleakrpJkZIQPHuYPy/TuYQowAHoxIP74Il5mFC
	rIllxZW5hxglOZiURHnXxViECfEl5adUZiQWZ8QXleakFh9ilOBgVhLhLQgEyvGmJFZWpRbl
	w6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHhnJwM1ChalpqdWpGXmlCCkmTg4QYZz
	SYkUp+alpBYllpZkxINiI74YGB0gKR6gvStB2nmLCxJzgaIQracYFaXEeSeDJARAEhmleXBj
	YWniFaM40JfCvBNBqniAKQau+xXQYCagweHbTEEGlyQipKQaGMWXH596I1t//yveF3wsCZvu
	LuJk0lij6KnL0Rr9VHyK9q4VAd6ZjZ0mDdMm32beWlp47reFasujfVWtt9i67bhFl5QXzAiY
	mPVBiSuzquTSzznPb220c7ggbBo6rUC4uH693LPq+gumPaZlMvUH9i05/7Jrg8ST 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280763>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 81 ----------------------------------------------------
 refs/refs.c          | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 81 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 89410a7..53f69f3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1680,23 +1680,6 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	return ret;
 }
 
-/* The argument to filter_refs */
-struct ref_filter {
-	const char *pattern;
-	each_ref_fn *fn;
-	void *cb_data;
-};
-
-static int filter_refs(const char *refname, const struct object_id *oid,
-			   int flags, void *data)
-{
-	struct ref_filter *filter = (struct ref_filter *)data;
-
-	if (wildmatch(filter->pattern, refname, 0, NULL))
-		return 0;
-	return filter->fn(refname, oid, flags, filter->cb_data);
-}
-
 enum peel_status {
 	/* object was peeled successfully: */
 	PEEL_PEELED = 0,
@@ -1963,36 +1946,6 @@ int for_each_ref_in_submodule(const char *submodule, const char *prefix,
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
 	return do_for_each_ref(&ref_cache, git_replace_ref_base, fn,
@@ -2024,40 +1977,6 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
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
-		strbuf_complete(&real_pattern, '/');
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
diff --git a/refs/refs.c b/refs/refs.c
index 3dd8e91..9644df6 100644
--- a/refs/refs.c
+++ b/refs/refs.c
@@ -745,3 +745,84 @@ const char *prettify_refname(const char *name)
 		starts_with(name, "refs/remotes/") ? 13 :
 		0);
 }
+
+/* The argument to filter_refs */
+struct ref_filter {
+	const char *pattern;
+	each_ref_fn *fn;
+	void *cb_data;
+};
+
+static int filter_refs(const char *refname, const struct object_id *oid, int flags,
+		       void *data)
+{
+	struct ref_filter *filter = (struct ref_filter *)data;
+
+	if (wildmatch(filter->pattern, refname, 0, NULL))
+		return 0;
+	return filter->fn(refname, oid, flags, filter->cb_data);
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
+		strbuf_complete(&real_pattern, '/');
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
-- 
2.6.2
