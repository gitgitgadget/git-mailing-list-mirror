From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 09/23] refs.c: move dwim and friend functions to the common refs code
Date: Tue, 19 Aug 2014 09:30:33 -0700
Message-ID: <1408465847-30384-10-git-send-email-sahlberg@google.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:32:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmKc-0002zZ-9n
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245AbaHSQbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:31:35 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:35763 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbaHSQaz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:30:55 -0400
Received: by mail-ig0-f202.google.com with SMTP id r2so1088289igi.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GQ2uYAWS46sc4wxEA30FJXEZXrxZoQVVDfNTEmX8n+M=;
        b=jb1dKCcYlgwnqpCaAzo/NY5zRvdLzT0OfSLI/jo6XK/Cc/Z6k3zA1XBnkpSzrKENTZ
         sb4BBP3K/9iTcn8g9MunQBoHIT+UtK0FCiPzbRQ6LLKpWRCg5m43SAgIv2psYKBztMlI
         apZ0t5N9qVJIM41mKVtf8B2u5MaC/k4uASjQjvXnW+hEVoCHLOTXDq9ZGlFj/UMpPRIB
         WSDBmOo2VI/AxJ8Y/yjjqN9uyvbK6i26aWVX84xNRSchamYo3lvtHIDa3un7t0G/BV4I
         b6v/XaLx4J1p3rKlh0RwD/NvvUsAcdfZ5mxm8PbU0LJj7vj6E9XgaIbgpIALUjiFFfOY
         fGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GQ2uYAWS46sc4wxEA30FJXEZXrxZoQVVDfNTEmX8n+M=;
        b=HeONie8cz87lqdmFHUkvPoZJypI1mQxqUM6Z9+P7MiB1BiGKTciMKNsI4AIqFI9t9L
         0ETbEBX9NHAAr76IYjhZ9o/uqHaYJMs6xAHvTNgrxJVIECn5FcRjZyvtxrhFBK93g1GD
         R0CH3UVY2E0fO4FbCYZQns2KgAzU/r4yrM0ostKzG/kpVNUIwD1YNDLNRWEsvX2x3HsW
         Bhzx4qhO8Bo3v21siFnHcM3AFzcU4BvEVFJcoASFcN4TDS/kdOND+EZpyVwISFRBZ9dN
         II4Va3FOTFPwRPEATMR/6NwBBkKsqaQYdP9mC9U6zBkLteWcmit1QXfmf+tnXTUb73GO
         N7Eg==
X-Gm-Message-State: ALoCoQloksN4LycY1pil0y2ppEYxamFtl+GBnz1Gq42hLNSjvaCA8XmDlDGPHmrpGeBcVG/Luvaj
X-Received: by 10.182.213.105 with SMTP id nr9mr22742840obc.36.1408465853454;
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t75si329273yhe.5.2014.08.19.09.30.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3CF9D31C536;
	Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AF280E1615; Tue, 19 Aug 2014 09:30:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.552.g1af257a
In-Reply-To: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255497>

These functions do not contain any backend specific code so we can move
them to the common code and share across all backends.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 202 --------------------------------------------------------
 refs.c          | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 202 insertions(+), 202 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 6181edf..56e146f 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1956,30 +1956,6 @@ const char *prettify_refname(const char *name)
 		0);
 }
 
-static const char *ref_rev_parse_rules[] = {
-	"%.*s",
-	"refs/%.*s",
-	"refs/tags/%.*s",
-	"refs/heads/%.*s",
-	"refs/remotes/%.*s",
-	"refs/remotes/%.*s/HEAD",
-	NULL
-};
-
-int refname_match(const char *abbrev_name, const char *full_name)
-{
-	const char **p;
-	const int abbrev_name_len = strlen(abbrev_name);
-
-	for (p = ref_rev_parse_rules; *p; p++) {
-		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name))) {
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
 static void unlock_ref(struct ref_lock *lock)
 {
 	/* Do not free lock->lk -- atexit() still looks at them */
@@ -2033,91 +2009,6 @@ static int remove_empty_directories(const char *file)
 	return result;
 }
 
-/*
- * *string and *len will only be substituted, and *string returned (for
- * later free()ing) if the string passed in is a magic short-hand form
- * to name a branch.
- */
-static char *substitute_branch_name(const char **string, int *len)
-{
-	struct strbuf buf = STRBUF_INIT;
-	int ret = interpret_branch_name(*string, *len, &buf);
-
-	if (ret == *len) {
-		size_t size;
-		*string = strbuf_detach(&buf, &size);
-		*len = size;
-		return (char *)*string;
-	}
-
-	return NULL;
-}
-
-int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
-{
-	char *last_branch = substitute_branch_name(&str, &len);
-	const char **p, *r;
-	int refs_found = 0;
-
-	*ref = NULL;
-	for (p = ref_rev_parse_rules; *p; p++) {
-		char fullref[PATH_MAX];
-		unsigned char sha1_from_ref[20];
-		unsigned char *this_result;
-		int flag;
-
-		this_result = refs_found ? sha1_from_ref : sha1;
-		mksnpath(fullref, sizeof(fullref), *p, len, str);
-		r = resolve_ref_unsafe(fullref, this_result,
-				       RESOLVE_REF_READING, &flag);
-		if (r) {
-			if (!refs_found++)
-				*ref = xstrdup(r);
-			if (!warn_ambiguous_refs)
-				break;
-		} else if ((flag & REF_ISSYMREF) && strcmp(fullref, "HEAD")) {
-			warning("ignoring dangling symref %s.", fullref);
-		} else if ((flag & REF_ISBROKEN) && strchr(fullref, '/')) {
-			warning("ignoring broken ref %s.", fullref);
-		}
-	}
-	free(last_branch);
-	return refs_found;
-}
-
-int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
-{
-	char *last_branch = substitute_branch_name(&str, &len);
-	const char **p;
-	int logs_found = 0;
-
-	*log = NULL;
-	for (p = ref_rev_parse_rules; *p; p++) {
-		unsigned char hash[20];
-		char path[PATH_MAX];
-		const char *ref, *it;
-
-		mksnpath(path, sizeof(path), *p, len, str);
-		ref = resolve_ref_unsafe(path, hash, RESOLVE_REF_READING, NULL);
-		if (!ref)
-			continue;
-		if (reflog_exists(path))
-			it = path;
-		else if (strcmp(ref, path) && reflog_exists(ref))
-			it = ref;
-		else
-			continue;
-		if (!logs_found++) {
-			*log = xstrdup(it);
-			hashcpy(sha1, hash);
-		}
-		if (!warn_ambiguous_refs)
-			break;
-	}
-	free(last_branch);
-	return logs_found;
-}
-
 /* This function should make sure errno is meaningful on error */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
@@ -3703,96 +3594,3 @@ cleanup:
 		ret = -2;
 	return ret;
 }
-
-char *shorten_unambiguous_ref(const char *refname, int strict)
-{
-	int i;
-	static char **scanf_fmts;
-	static int nr_rules;
-	char *short_name;
-
-	if (!nr_rules) {
-		/*
-		 * Pre-generate scanf formats from ref_rev_parse_rules[].
-		 * Generate a format suitable for scanf from a
-		 * ref_rev_parse_rules rule by interpolating "%s" at the
-		 * location of the "%.*s".
-		 */
-		size_t total_len = 0;
-		size_t offset = 0;
-
-		/* the rule list is NULL terminated, count them first */
-		for (nr_rules = 0; ref_rev_parse_rules[nr_rules]; nr_rules++)
-			/* -2 for strlen("%.*s") - strlen("%s"); +1 for NUL */
-			total_len += strlen(ref_rev_parse_rules[nr_rules]) - 2 + 1;
-
-		scanf_fmts = xmalloc(nr_rules * sizeof(char *) + total_len);
-
-		offset = 0;
-		for (i = 0; i < nr_rules; i++) {
-			assert(offset < total_len);
-			scanf_fmts[i] = (char *)&scanf_fmts[nr_rules] + offset;
-			offset += snprintf(scanf_fmts[i], total_len - offset,
-					   ref_rev_parse_rules[i], 2, "%s") + 1;
-		}
-	}
-
-	/* bail out if there are no rules */
-	if (!nr_rules)
-		return xstrdup(refname);
-
-	/* buffer for scanf result, at most refname must fit */
-	short_name = xstrdup(refname);
-
-	/* skip first rule, it will always match */
-	for (i = nr_rules - 1; i > 0 ; --i) {
-		int j;
-		int rules_to_fail = i;
-		int short_name_len;
-
-		if (1 != sscanf(refname, scanf_fmts[i], short_name))
-			continue;
-
-		short_name_len = strlen(short_name);
-
-		/*
-		 * in strict mode, all (except the matched one) rules
-		 * must fail to resolve to a valid non-ambiguous ref
-		 */
-		if (strict)
-			rules_to_fail = nr_rules;
-
-		/*
-		 * check if the short name resolves to a valid ref,
-		 * but use only rules prior to the matched one
-		 */
-		for (j = 0; j < rules_to_fail; j++) {
-			const char *rule = ref_rev_parse_rules[j];
-			char refname[PATH_MAX];
-
-			/* skip matched rule */
-			if (i == j)
-				continue;
-
-			/*
-			 * the short name is ambiguous, if it resolves
-			 * (with this previous rule) to a valid ref
-			 * read_ref() returns 0 on success
-			 */
-			mksnpath(refname, sizeof(refname),
-				 rule, short_name_len, short_name);
-			if (ref_exists(refname))
-				break;
-		}
-
-		/*
-		 * short name is non-ambiguous if all previous rules
-		 * haven't resolved to a valid ref
-		 */
-		if (j == rules_to_fail)
-			return short_name;
-	}
-
-	free(short_name);
-	return xstrdup(refname);
-}
diff --git a/refs.c b/refs.c
index 9e2059b..adf0c29 100644
--- a/refs.c
+++ b/refs.c
@@ -295,3 +295,205 @@ int ref_is_hidden(const char *refname)
 	}
 	return 0;
 }
+
+static const char *ref_rev_parse_rules[] = {
+	"%.*s",
+	"refs/%.*s",
+	"refs/tags/%.*s",
+	"refs/heads/%.*s",
+	"refs/remotes/%.*s",
+	"refs/remotes/%.*s/HEAD",
+	NULL
+};
+
+int refname_match(const char *abbrev_name, const char *full_name)
+{
+	const char **p;
+	const int abbrev_name_len = strlen(abbrev_name);
+
+	for (p = ref_rev_parse_rules; *p; p++) {
+		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name))) {
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * *string and *len will only be substituted, and *string returned (for
+ * later free()ing) if the string passed in is a magic short-hand form
+ * to name a branch.
+ */
+static char *substitute_branch_name(const char **string, int *len)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int ret = interpret_branch_name(*string, *len, &buf);
+
+	if (ret == *len) {
+		size_t size;
+		*string = strbuf_detach(&buf, &size);
+		*len = size;
+		return (char *)*string;
+	}
+
+	return NULL;
+}
+
+int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
+{
+	char *last_branch = substitute_branch_name(&str, &len);
+	const char **p, *r;
+	int refs_found = 0;
+
+	*ref = NULL;
+	for (p = ref_rev_parse_rules; *p; p++) {
+		char fullref[PATH_MAX];
+		unsigned char sha1_from_ref[20];
+		unsigned char *this_result;
+		int flag;
+
+		this_result = refs_found ? sha1_from_ref : sha1;
+		mksnpath(fullref, sizeof(fullref), *p, len, str);
+		r = resolve_ref_unsafe(fullref, this_result,
+				       RESOLVE_REF_READING, &flag);
+		if (r) {
+			if (!refs_found++)
+				*ref = xstrdup(r);
+			if (!warn_ambiguous_refs)
+				break;
+		} else if ((flag & REF_ISSYMREF) && strcmp(fullref, "HEAD")) {
+			warning("ignoring dangling symref %s.", fullref);
+		} else if ((flag & REF_ISBROKEN) && strchr(fullref, '/')) {
+			warning("ignoring broken ref %s.", fullref);
+		}
+	}
+	free(last_branch);
+	return refs_found;
+}
+
+int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
+{
+	char *last_branch = substitute_branch_name(&str, &len);
+	const char **p;
+	int logs_found = 0;
+
+	*log = NULL;
+	for (p = ref_rev_parse_rules; *p; p++) {
+		unsigned char hash[20];
+		char path[PATH_MAX];
+		const char *ref, *it;
+
+		mksnpath(path, sizeof(path), *p, len, str);
+		ref = resolve_ref_unsafe(path, hash, RESOLVE_REF_READING, NULL);
+		if (!ref)
+			continue;
+		if (reflog_exists(path))
+			it = path;
+		else if (strcmp(ref, path) && reflog_exists(ref))
+			it = ref;
+		else
+			continue;
+		if (!logs_found++) {
+			*log = xstrdup(it);
+			hashcpy(sha1, hash);
+		}
+		if (!warn_ambiguous_refs)
+			break;
+	}
+	free(last_branch);
+	return logs_found;
+}
+
+char *shorten_unambiguous_ref(const char *refname, int strict)
+{
+	int i;
+	static char **scanf_fmts;
+	static int nr_rules;
+	char *short_name;
+
+	if (!nr_rules) {
+		/*
+		 * Pre-generate scanf formats from ref_rev_parse_rules[].
+		 * Generate a format suitable for scanf from a
+		 * ref_rev_parse_rules rule by interpolating "%s" at the
+		 * location of the "%.*s".
+		 */
+		size_t total_len = 0;
+		size_t offset = 0;
+
+		/* the rule list is NULL terminated, count them first */
+		for (nr_rules = 0; ref_rev_parse_rules[nr_rules]; nr_rules++)
+			/* -2 for strlen("%.*s") - strlen("%s"); +1 for NUL */
+			total_len += strlen(ref_rev_parse_rules[nr_rules]) - 2 + 1;
+
+		scanf_fmts = xmalloc(nr_rules * sizeof(char *) + total_len);
+
+		offset = 0;
+		for (i = 0; i < nr_rules; i++) {
+			assert(offset < total_len);
+			scanf_fmts[i] = (char *)&scanf_fmts[nr_rules] + offset;
+			offset += snprintf(scanf_fmts[i], total_len - offset,
+					   ref_rev_parse_rules[i], 2, "%s") + 1;
+		}
+	}
+
+	/* bail out if there are no rules */
+	if (!nr_rules)
+		return xstrdup(refname);
+
+	/* buffer for scanf result, at most refname must fit */
+	short_name = xstrdup(refname);
+
+	/* skip first rule, it will always match */
+	for (i = nr_rules - 1; i > 0 ; --i) {
+		int j;
+		int rules_to_fail = i;
+		int short_name_len;
+
+		if (1 != sscanf(refname, scanf_fmts[i], short_name))
+			continue;
+
+		short_name_len = strlen(short_name);
+
+		/*
+		 * in strict mode, all (except the matched one) rules
+		 * must fail to resolve to a valid non-ambiguous ref
+		 */
+		if (strict)
+			rules_to_fail = nr_rules;
+
+		/*
+		 * check if the short name resolves to a valid ref,
+		 * but use only rules prior to the matched one
+		 */
+		for (j = 0; j < rules_to_fail; j++) {
+			const char *rule = ref_rev_parse_rules[j];
+			char refname[PATH_MAX];
+
+			/* skip matched rule */
+			if (i == j)
+				continue;
+
+			/*
+			 * the short name is ambiguous, if it resolves
+			 * (with this previous rule) to a valid ref
+			 * read_ref() returns 0 on success
+			 */
+			mksnpath(refname, sizeof(refname),
+				 rule, short_name_len, short_name);
+			if (ref_exists(refname))
+				break;
+		}
+
+		/*
+		 * short name is non-ambiguous if all previous rules
+		 * haven't resolved to a valid ref
+		 */
+		if (j == rules_to_fail)
+			return short_name;
+	}
+
+	free(short_name);
+	return xstrdup(refname);
+}
-- 
2.0.1.552.g1af257a
