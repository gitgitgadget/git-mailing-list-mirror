From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 08/23] refs-common.c: move dwim and friend functions to refs common
Date: Wed, 13 Aug 2014 13:14:52 -0700
Message-ID: <1407960907-18189-9-git-send-email-sahlberg@google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:15:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHexU-0008Pc-47
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbaHMUPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:15:23 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:40699 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698AbaHMUPM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:12 -0400
Received: by mail-vc0-f202.google.com with SMTP id hq11so35589vcb.3
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xiofUHvO9aYkPH9PUY/Jv+GJcOEuJYWjpZtfBFBUy3E=;
        b=Ou0xd3Kt2ER0+Zb7SJMhwJloZJcG+hJTdtoO1llfQBeCtrh34Zr3R7+nqgdMxDn4/O
         35keEwI7I3FXAHu+/oKr13PO3hqVXPkl7tmqR84FaPF/Et+M7sNOWCCndqt3B1mff/RV
         gVeOE5gpp+pUQRxJFgBpIRl1EnjN/GE1lTycBwE8l431YsHRU6QtS4+YlIQK3mcwhkoJ
         6Xjhx8BxFcDYwxa2Yk98oEda9SWfmhB2qxo6StrJxpMdvgWn66CYHrLZ1+F3E3whveOy
         L72JVYYze/wZfMuUg+chLMnO4Jgw7cQvaujG78vowJXdRw49isV2QYQ6je5wD2QluBzT
         k9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xiofUHvO9aYkPH9PUY/Jv+GJcOEuJYWjpZtfBFBUy3E=;
        b=HVMgHIr938FCiix2Zqs+BTZZfNI3jcE4SrDZUddaBux7k3MO/W+Q630ZAhdPn2bw+e
         mWoKYnSuQidBXxUUWAvmxFApLhO+/au4i/EdpixRCO4yv6CZRPt0citQ3cDkpBaeC8Pq
         Z0/1FdMoEsG59tzloFylKb2441fQgtJkueAviPXNLXA4SWRFzsrLjH8LMZxqXXc7V/5a
         6/8sqefZUl11mYNU4uabH3Nu4PdntHo8TNl/9voVyX9M7NKDH4pz9ojfG40Md7tcKFk9
         FRPSe7q5w3XiLW/pVpLNL25+khTAwV6LYaSwMQ3NM3Ce1hs3DaaDVliCVQe0+fZvrOiw
         W2nA==
X-Gm-Message-State: ALoCoQlsAtLEUaheiP36slHUnkDC/QxKYKyaxAKxcAat4mA4aQJpLRZTB9C19Z3AyW3mNImMAr5X
X-Received: by 10.236.191.37 with SMTP id f25mr200262yhn.44.1407960910384;
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si209193yhk.4.2014.08.13.13.15.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 309145A4536;
	Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C9501E0F40; Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255236>

These functions do not contain any backend specific code so we can move
them to the common code and share across all backends.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.c        | 202 ----------------------------------------------------------
 2 files changed, 202 insertions(+), 202 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index c40fa96..ac081e1 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -293,3 +293,205 @@ int ref_is_hidden(const char *refname)
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
diff --git a/refs.c b/refs.c
index 6181edf..56e146f 100644
--- a/refs.c
+++ b/refs.c
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
-- 
2.0.1.556.g3edca4c
