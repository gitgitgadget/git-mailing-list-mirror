Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C571A8801
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 00:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016836; cv=none; b=R16q6QMGs08aQLQ5/gTSEBefbgoIAYKnofthS7vKOhjfqUzUp+yxfks1g30sMjLbMxXIJyd0n5yqeT9c5BkKCwi91hNaTwjB3qe/gB12rdEm4srYR+7z0M9oSL8wN1BZZBhgRSl/yamBn2gPwd7Pb8q6L4UUx1BHSP9xRapuCdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016836; c=relaxed/simple;
	bh=ZX+YRPUjIlVf6PrYiURBdOGVt8y2SE1WfF4/8xL5qSo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CnJ+6lTNPiavdYgvqihNA/xZGlTkbaxZ8O0Ab7Na1mSvapOaDqdFD7vCYmhawlyzedV8ykTnl7bobWkAylU2Hxs6WwVxVcdfTit4FWawUcMqVVaq2vB4+ZO9uxZKl0JMh3P75UWmkW0FTM+NdITdQHiA0R/g2md/7KetBz8SbSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=DdAegd0r; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="DdAegd0r"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712016829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hxMub3Cx9PW3Za2SwFkQJudLmX+41CN4i8jLXJGEXcA=;
	b=DdAegd0rtQfALx+QZmuGQIYK7AzXuym/FYkAuKfmkCA9OvEXYIlZOEWC1JnTPB2OYzdWBv
	o6TYh3aEe08QVsc1OCxJkf5OrelXUZbQ1zuJM4DRkbaIADaagwsyS3AxHQL0OX5sAEEOxC
	ukVUSgvZOILFi8NuumfjBtArGhfftJCJhGpr9IBHVhLDG9QaUFBjcl2/g+mc4EcJ6Qq4A/
	fsy72sm9MgdihtxeZ2UVjXE1Ar0/fYxHAYFBFUXo7OC+9ng/ddvITtS7qOCKYpwod0IZ/a
	ztI3j4zNTnnBm/FQCLeRnAI/t262VkaUYjOItekiSvlJKGHAE9lMJByvj0UnuA==
To: git@vger.kernel.org
Subject: [PATCH 1/3] diff: support additional whitespace in diff.{dirstat,wsErrorHighlight}
Date: Tue,  2 Apr 2024 02:13:42 +0200
Message-Id: <c26393897753e5899431ae527a594bb457eb73b8.1712016667.git.dsimic@manjaro.org>
In-Reply-To: <cover.1712016667.git.dsimic@manjaro.org>
References: <cover.1712016667.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Allow additional whitespace characters to be placed around the commas
in the multi-(sub)value, comma-separated values for the "diff.dirstat" and
"diff.wsErrorHighlight" configuration options.  This makes the way multi-value
configuration options can be specified more consistent, because exactly the
same additional whitespace characters are already allowed for some of the
configuration options, including "core.whitespace", "log.graphColors" and
"color.blame.highlightRecent".

Besides improving the consistency of the configuration syntax, being able
to include additional whitespace characters into the values of a couple more
of the comma-separated configuration values may also make the configuration
files more readable to some users.

This optional support for the additional whitespace around the commas also
extends to the equivalent comma-separated values for the "--dirstat" and
"--ws-error-highlight" command-line options.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 builtin/gc.c                |  4 ++--
 diff.c                      | 14 ++++++++++----
 notes.c                     |  2 +-
 refs/packed-backend.c       |  2 +-
 string-list.c               | 27 +++++++++++++++++++++------
 string-list.h               | 10 ++++++----
 t/helper/test-hashmap.c     |  2 +-
 t/helper/test-json-writer.c |  2 +-
 t/helper/test-oidmap.c      |  2 +-
 t/helper/test-string-list.c |  4 ++--
 10 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index cb80ced6cb5c..5c6a3b5f65c3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1702,11 +1702,11 @@ static int get_schedule_cmd(const char **cmd, int *is_available)
 	if (is_available)
 		*is_available = 0;
 
-	string_list_split_in_place(&list, testing, ",", -1);
+	string_list_split_in_place(&list, testing, ",", "", -1);
 	for_each_string_list_item(item, &list) {
 		struct string_list pair = STRING_LIST_INIT_NODUP;
 
-		if (string_list_split_in_place(&pair, item->string, ":", 2) != 2)
+		if (string_list_split_in_place(&pair, item->string, ":", "", 2) != 2)
 			continue;
 
 		if (!strcmp(*cmd, pair.items[0].string)) {
diff --git a/diff.c b/diff.c
index 108c1875775d..bf3aa148aeed 100644
--- a/diff.c
+++ b/diff.c
@@ -141,7 +141,7 @@ static int parse_dirstat_params(struct diff_options *options, const char *params
 	int i;
 
 	if (*params_copy)
-		string_list_split_in_place(&params, params_copy, ",", -1);
+		string_list_split_in_place(&params, params_copy, ",", " \t\n\r", -1);
 	for (i = 0; i < params.nr; i++) {
 		const char *p = params.items[i].string;
 		if (!strcmp(p, "changes")) {
@@ -232,10 +232,16 @@ long parse_algorithm_value(const char *value)
 
 static int parse_one_token(const char **arg, const char *token)
 {
+	const char ignored[] = " \t\n\r";
 	const char *rest;
-	if (skip_prefix(*arg, token, &rest) && (!*rest || *rest == ',')) {
-		*arg = rest;
-		return 1;
+
+	*arg += strspn(*arg, ignored);
+	if (skip_prefix(*arg, token, &rest)) {
+		rest += strspn(rest, ignored);
+		if (!*rest || *rest == ',') {
+			*arg = rest;
+			return 1;
+		}
 	}
 	return 0;
 }
diff --git a/notes.c b/notes.c
index fed1eda80cd7..b6d4b7d7cd0f 100644
--- a/notes.c
+++ b/notes.c
@@ -962,7 +962,7 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
 	char *globs_copy = xstrdup(globs);
 	int i;
 
-	string_list_split_in_place(&split, globs_copy, ":", -1);
+	string_list_split_in_place(&split, globs_copy, ":", "", -1);
 	string_list_remove_empty_items(&split, 0);
 
 	for (i = 0; i < split.nr; i++)
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4e826c05ff2b..65ccbcf9475f 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -676,7 +676,7 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 					 snapshot->buf,
 					 snapshot->eof - snapshot->buf);
 
-		string_list_split_in_place(&traits, p, " ", -1);
+		string_list_split_in_place(&traits, p, " ", "", -1);
 
 		if (unsorted_string_list_has_string(&traits, "fully-peeled"))
 			snapshot->peeled = PEELED_FULLY;
diff --git a/string-list.c b/string-list.c
index 954569f381d8..bdf731b3c209 100644
--- a/string-list.c
+++ b/string-list.c
@@ -309,21 +309,36 @@ int string_list_split(struct string_list *list, const char *string,
 }
 
 int string_list_split_in_place(struct string_list *list, char *string,
-			       const char *delim, int maxsplit)
+			       const char *delim, const char *ignored,
+			       int maxsplit)
 {
 	int count = 0;
-	char *p = string, *end;
+	char *p = string, *trim, *end;
+	size_t length = strlen(string);
 
 	if (list->strdup_strings)
 		die("internal error in string_list_split_in_place(): "
 		    "list->strdup_strings must not be set");
+
 	for (;;) {
 		count++;
-		if (maxsplit >= 0 && count > maxsplit) {
-			string_list_append(list, p);
-			return count;
+		if (*ignored) {
+			trim = p + strspn(p, ignored);
+			while (p != trim)
+				*p++ = '\0';
+		}
+		if (maxsplit >= 0 && count > maxsplit)
+			end = NULL;
+		else
+			end = strpbrk(p, delim);
+		if (*ignored) {
+			if (end)
+				trim = end - 1;
+			else
+				trim = string + length - 1;
+			while (trim >= string && strchr(ignored, *trim))
+				*trim-- = '\0';
 		}
-		end = strpbrk(p, delim);
 		if (end) {
 			*end = '\0';
 			string_list_append(list, p);
diff --git a/string-list.h b/string-list.h
index 122b31864198..1219f7f72778 100644
--- a/string-list.h
+++ b/string-list.h
@@ -274,11 +274,13 @@ int string_list_split(struct string_list *list, const char *string,
 
 /*
  * Like string_list_split(), except that string is split in-place: the
- * delimiter characters in string are overwritten with NULs, and the
- * new string_list_items point into string (which therefore must not
- * be modified or freed while the string_list is in use).
+ * delimiter characters in string and the optionally ignored characters
+ * that surround the substrings after splitting are overwritten with NULs,
+ * and the new string_list_items point into string (which therefore must
+ * not be modified or freed while the string_list is in use).
  * list->strdup_strings must *not* be set.
  */
 int string_list_split_in_place(struct string_list *list, char *string,
-			       const char *delim, int maxsplit);
+			       const char *delim, const char *ignored,
+			       int maxsplit);
 #endif /* STRING_LIST_H */
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 0eb0b3d49cec..7cc62bcc1b78 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -167,7 +167,7 @@ int cmd__hashmap(int argc, const char **argv)
 
 		/* break line into command and up to two parameters */
 		string_list_setlen(&parts, 0);
-		string_list_split_in_place(&parts, line.buf, DELIM, 2);
+		string_list_split_in_place(&parts, line.buf, DELIM, "", 2);
 		string_list_remove_empty_items(&parts, 0);
 
 		/* ignore empty lines */
diff --git a/t/helper/test-json-writer.c b/t/helper/test-json-writer.c
index afe393f59741..6a54bac1e971 100644
--- a/t/helper/test-json-writer.c
+++ b/t/helper/test-json-writer.c
@@ -490,7 +490,7 @@ static int scripted(void)
 
 		/* break line into command and zero or more tokens */
 		string_list_setlen(&parts, 0);
-		string_list_split_in_place(&parts, line, " ", -1);
+		string_list_split_in_place(&parts, line, " ", "", -1);
 		string_list_remove_empty_items(&parts, 0);
 
 		/* ignore empty lines */
diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
index bd30244a54cc..0861afedb11e 100644
--- a/t/helper/test-oidmap.c
+++ b/t/helper/test-oidmap.c
@@ -44,7 +44,7 @@ int cmd__oidmap(int argc UNUSED, const char **argv UNUSED)
 
 		/* break line into command and up to two parameters */
 		string_list_setlen(&parts, 0);
-		string_list_split_in_place(&parts, line.buf, DELIM, 2);
+		string_list_split_in_place(&parts, line.buf, DELIM, "", 2);
 		string_list_remove_empty_items(&parts, 0);
 
 		/* ignore empty lines */
diff --git a/t/helper/test-string-list.c b/t/helper/test-string-list.c
index e2aad611d1c8..116469c2621b 100644
--- a/t/helper/test-string-list.c
+++ b/t/helper/test-string-list.c
@@ -65,7 +65,7 @@ int cmd__string_list(int argc, const char **argv)
 		const char *delim = argv[3];
 		int maxsplit = atoi(argv[4]);
 
-		i = string_list_split_in_place(&list, s, delim, maxsplit);
+		i = string_list_split_in_place(&list, s, delim, "", maxsplit);
 		printf("%d\n", i);
 		write_list(&list);
 		string_list_clear(&list, 0);
@@ -111,7 +111,7 @@ int cmd__string_list(int argc, const char **argv)
 		 */
 		if (sb.len && sb.buf[sb.len - 1] == '\n')
 			strbuf_setlen(&sb, sb.len - 1);
-		string_list_split_in_place(&list, sb.buf, "\n", -1);
+		string_list_split_in_place(&list, sb.buf, "\n", "", -1);
 
 		string_list_sort(&list);
 
