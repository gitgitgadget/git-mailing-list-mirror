From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 19/19] Rename struct git_attr_check to git_attr_value
Date: Tue, 26 Jul 2011 16:13:02 +0200
Message-ID: <1311689582-3116-20-git-send-email-mhagger@alum.mit.edu>
References: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 16:34:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QliiC-0006B9-LI
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 16:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab1GZOeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 10:34:19 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40299 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386Ab1GZOeR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 10:34:17 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QliM6-0004aQ-VL; Tue, 26 Jul 2011 16:11:30 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177885>

This described its purpose better, especially when used with
git_allattrs().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

This change makes the name of the structure more closely match its
uses.  However, if git makes backwards-compatibility guarantees for
its API, such a renaming might be prohibited.  If so, this patch can
be left off the series.

 Documentation/technical/api-gitattributes.txt |   20 ++++++++++----------
 archive.c                                     |    4 ++--
 attr.c                                        |    8 ++++----
 attr.h                                        |   12 ++++++------
 builtin/check-attr.c                          |    8 ++++----
 builtin/pack-objects.c                        |    4 ++--
 convert.c                                     |   10 +++++-----
 ll-merge.c                                    |    6 +++---
 userdiff.c                                    |    2 +-
 ws.c                                          |    4 ++--
 10 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
index 640240e..c64969d 100644
--- a/Documentation/technical/api-gitattributes.txt
+++ b/Documentation/technical/api-gitattributes.txt
@@ -16,7 +16,7 @@ Data Structure
 	of no interest to the calling programs.  The name of the
 	attribute can be retrieved by calling `git_attr_name()`.
 
-`struct git_attr_check`::
+`struct git_attr_value`::
 
 	This structure represents a set of attributes to check in a call
 	to `git_checkattr()` function, and receives the results.
@@ -27,7 +27,7 @@ Attribute Values
 
 An attribute for a path can be in one of four states: Set, Unset,
 Unspecified or set to a string, and `.value` member of `struct
-git_attr_check` records it.  There are three macros to check these:
+git_attr_value` records it.  There are three macros to check these:
 
 `ATTR_TRUE()`::
 
@@ -48,13 +48,13 @@ value of the attribute for the path.
 Querying Specific Attributes
 ----------------------------
 
-* Prepare an array of `struct git_attr_check` to define the list of
+* Prepare an array of `struct git_attr_value` to define the list of
   attributes you would want to check.  To populate this array, you would
   need to define necessary attributes by calling `git_attr()` function.
 
 * Call `git_checkattr()` to check the attributes for the path.
 
-* Inspect `git_attr_check` structure to see how each of the attribute in
+* Inspect `git_attr_value` structure to see how each of the attribute in
   the array is defined for the path.
 
 
@@ -63,12 +63,12 @@ Example
 
 To see how attributes "crlf" and "indent" are set for different paths.
 
-. Prepare an array of `struct git_attr_check` with two elements (because
+. Prepare an array of `struct git_attr_value` with two elements (because
   we are checking two attributes).  Initialize their `attr` member with
   pointers to `struct git_attr` obtained by calling `git_attr()`:
 
 ------------
-static struct git_attr_check check[2];
+static struct git_attr_value check[2];
 static void setup_check(void)
 {
 	if (check[0].attr)
@@ -78,7 +78,7 @@ static void setup_check(void)
 }
 ------------
 
-. Call `git_checkattr()` with the prepared array of `struct git_attr_check`:
+. Call `git_checkattr()` with the prepared array of `struct git_attr_value`:
 
 ------------
 	const char *path;
@@ -115,12 +115,12 @@ Querying All Attributes
 
 To get the values of all attributes associated with a file:
 
-* Call `git_allattrs()`, which returns an array of `git_attr_check`
+* Call `git_allattrs()`, which returns an array of `git_attr_value`
   structures.
 
-* Iterate over the `git_attr_check` array to examine the attribute
+* Iterate over the `git_attr_value` array to examine the attribute
   names and values.  The name of the attribute described by a
-  `git_attr_check` object can be retrieved via
+  `git_attr_value` object can be retrieved via
   `git_attr_name(check[i].attr)`.  (Please note that no items will be
   returned for unset attributes, so `ATTR_UNSET()` will return false
   for all returned `git_array_check` objects.)
diff --git a/archive.c b/archive.c
index 2a7a28e..9a180b6 100644
--- a/archive.c
+++ b/archive.c
@@ -81,7 +81,7 @@ static void *sha1_file_to_archive(const char *path, const unsigned char *sha1,
 	return buffer;
 }
 
-static void setup_archive_check(struct git_attr_check *check)
+static void setup_archive_check(struct git_attr_value *check)
 {
 	static struct git_attr *attr_export_ignore;
 	static struct git_attr *attr_export_subst;
@@ -107,7 +107,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	struct archiver_context *c = context;
 	struct archiver_args *args = c->args;
 	write_archive_entry_fn_t write_entry = c->write_entry;
-	struct git_attr_check check[2];
+	struct git_attr_value check[2];
 	const char *path_without_prefix;
 	int convert = 0;
 	int err;
diff --git a/attr.c b/attr.c
index 976c830..ec50ba5 100644
--- a/attr.c
+++ b/attr.c
@@ -33,7 +33,7 @@ struct git_attr {
 };
 static int attr_nr;
 
-static struct git_attr_check *check_all_attr;
+static struct git_attr_value *check_all_attr;
 static struct git_attr *(git_attr_hash[HASHSIZE]);
 
 char *git_attr_name(struct git_attr *attr) {
@@ -645,7 +645,7 @@ static int macroexpand_one(int attr_nr, int rem);
 
 static int fill_one(const char *what, struct match_attr *a, int rem)
 {
-	struct git_attr_check *check = check_all_attr;
+	struct git_attr_value *check = check_all_attr;
 	int i;
 
 	for (i = a->num_attr - 1; 0 < rem && 0 <= i; i--) {
@@ -705,7 +705,7 @@ static int macroexpand_one(int attr_nr, int rem)
 	return rem;
 }
 
-int git_checkattr(const char *path, int num, struct git_attr_check *check)
+int git_checkattr(const char *path, int num, struct git_attr_value *check)
 {
 	struct attr_stack *stk;
 	const char *cp;
@@ -736,7 +736,7 @@ int git_checkattr(const char *path, int num, struct git_attr_check *check)
 	return 0;
 }
 
-int git_allattrs(const char *path, int *num, struct git_attr_check **check)
+int git_allattrs(const char *path, int *num, struct git_attr_value **check)
 {
 	struct attr_stack *stk;
 	const char *cp;
diff --git a/attr.h b/attr.h
index 83202f0..4dc4db0 100644
--- a/attr.h
+++ b/attr.h
@@ -14,17 +14,17 @@ struct git_attr *git_attr(const char *);
 extern const char git_attr__true[];
 extern const char git_attr__false[];
 
-/* For public to check git_attr_check results */
+/* For public to check git_attr_value results */
 #define ATTR_TRUE(v) ((v) == git_attr__true)
 #define ATTR_FALSE(v) ((v) == git_attr__false)
 #define ATTR_UNSET(v) ((v) == NULL)
 
 /*
- * Send one or more git_attr_check to git_checkattr(), and
+ * Send one or more git_attr_value to git_checkattr(), and
  * each 'value' member tells what its value is.
  * Unset one is returned as NULL.
  */
-struct git_attr_check {
+struct git_attr_value {
 	struct git_attr *attr;
 	const char *value;
 };
@@ -36,16 +36,16 @@ struct git_attr_check {
  */
 char *git_attr_name(struct git_attr *);
 
-int git_checkattr(const char *path, int, struct git_attr_check *);
+int git_checkattr(const char *path, int, struct git_attr_value *);
 
 /*
  * Retrieve all attributes that apply to the specified path.  *num
  * will be set the the number of attributes on the path; **check will
- * be set to point at a newly-allocated array of git_attr_check
+ * be set to point at a newly-allocated array of git_attr_value
  * objects describing the attributes and their values.  *check must be
  * free()ed by the caller.
  */
-int git_allattrs(const char *path, int *num, struct git_attr_check **check);
+int git_allattrs(const char *path, int *num, struct git_attr_value **check);
 
 enum git_attr_direction {
 	GIT_ATTR_CHECKIN,
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 29613d4..cd00496 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -22,7 +22,7 @@ static const struct option check_attr_options[] = {
 	OPT_END()
 };
 
-static void output_attr(int cnt, struct git_attr_check *check,
+static void output_attr(int cnt, struct git_attr_value *check,
 	const char *file)
 {
 	int j;
@@ -41,7 +41,7 @@ static void output_attr(int cnt, struct git_attr_check *check,
 	}
 }
 
-static void check_attr(int cnt, struct git_attr_check *check,
+static void check_attr(int cnt, struct git_attr_value *check,
 	const char *file)
 {
 	if (check != NULL) {
@@ -56,7 +56,7 @@ static void check_attr(int cnt, struct git_attr_check *check,
 	}
 }
 
-static void check_attr_stdin_paths(int cnt, struct git_attr_check *check)
+static void check_attr_stdin_paths(int cnt, struct git_attr_value *check)
 {
 	struct strbuf buf, nbuf;
 	int line_termination = null_term_line ? 0 : '\n';
@@ -85,7 +85,7 @@ static NORETURN void error_with_usage(const char *msg)
 
 int cmd_check_attr(int argc, const char **argv, const char *prefix)
 {
-	struct git_attr_check *check;
+	struct git_attr_value *check;
 	int cnt, i, doubledash, filei;
 
 	argc = parse_options(argc, argv, prefix, check_attr_options,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 84e6daf..a0becea 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -619,7 +619,7 @@ static unsigned name_hash(const char *name)
 	return hash;
 }
 
-static void setup_delta_attr_check(struct git_attr_check *check)
+static void setup_delta_attr_check(struct git_attr_value *check)
 {
 	static struct git_attr *attr_delta;
 
@@ -631,7 +631,7 @@ static void setup_delta_attr_check(struct git_attr_check *check)
 
 static int no_try_delta(const char *path)
 {
-	struct git_attr_check check[1];
+	struct git_attr_value check[1];
 
 	setup_delta_attr_check(check);
 	if (git_checkattr(path, ARRAY_SIZE(check), check))
diff --git a/convert.c b/convert.c
index 85939c2..ab582f8 100644
--- a/convert.c
+++ b/convert.c
@@ -641,7 +641,7 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
 	return 1;
 }
 
-static int git_path_check_crlf(const char *path, struct git_attr_check *check)
+static int git_path_check_crlf(const char *path, struct git_attr_value *check)
 {
 	const char *value = check->value;
 
@@ -658,7 +658,7 @@ static int git_path_check_crlf(const char *path, struct git_attr_check *check)
 	return CRLF_GUESS;
 }
 
-static int git_path_check_eol(const char *path, struct git_attr_check *check)
+static int git_path_check_eol(const char *path, struct git_attr_value *check)
 {
 	const char *value = check->value;
 
@@ -672,7 +672,7 @@ static int git_path_check_eol(const char *path, struct git_attr_check *check)
 }
 
 static struct convert_driver *git_path_check_convert(const char *path,
-					     struct git_attr_check *check)
+					     struct git_attr_value *check)
 {
 	const char *value = check->value;
 	struct convert_driver *drv;
@@ -685,7 +685,7 @@ static struct convert_driver *git_path_check_convert(const char *path,
 	return NULL;
 }
 
-static int git_path_check_ident(const char *path, struct git_attr_check *check)
+static int git_path_check_ident(const char *path, struct git_attr_value *check)
 {
 	const char *value = check->value;
 
@@ -718,7 +718,7 @@ static const char *conv_attr_name[] = {
 static void convert_attrs(struct conv_attrs *ca, const char *path)
 {
 	int i;
-	static struct git_attr_check ccheck[NUM_CONV_ATTRS];
+	static struct git_attr_value ccheck[NUM_CONV_ATTRS];
 
 	if (!ccheck[0].attr) {
 		for (i = 0; i < NUM_CONV_ATTRS; i++)
diff --git a/ll-merge.c b/ll-merge.c
index 6ce512e..65f326e 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -324,7 +324,7 @@ static const struct ll_merge_driver *find_ll_merge_driver(const char *merge_attr
 	return &ll_merge_drv[LL_TEXT_MERGE];
 }
 
-static int git_path_check_merge(const char *path, struct git_attr_check check[2])
+static int git_path_check_merge(const char *path, struct git_attr_value check[2])
 {
 	if (!check[0].attr) {
 		check[0].attr = git_attr("merge");
@@ -350,7 +350,7 @@ int ll_merge(mmbuffer_t *result_buf,
 	     mmfile_t *theirs, const char *their_label,
 	     const struct ll_merge_options *opts)
 {
-	static struct git_attr_check check[2];
+	static struct git_attr_value check[2];
 	static const struct ll_merge_options default_opts;
 	const char *ll_driver_name = NULL;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
@@ -382,7 +382,7 @@ int ll_merge(mmbuffer_t *result_buf,
 
 int ll_merge_marker_size(const char *path)
 {
-	static struct git_attr_check check;
+	static struct git_attr_value check;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 
 	if (!check.attr)
diff --git a/userdiff.c b/userdiff.c
index 01d3a8b..cde9537 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -262,7 +262,7 @@ struct userdiff_driver *userdiff_find_by_name(const char *name) {
 struct userdiff_driver *userdiff_find_by_path(const char *path)
 {
 	static struct git_attr *attr;
-	struct git_attr_check check;
+	struct git_attr_value check;
 
 	if (!attr)
 		attr = git_attr("diff");
diff --git a/ws.c b/ws.c
index 9fb9b14..4a76ef8 100644
--- a/ws.c
+++ b/ws.c
@@ -74,7 +74,7 @@ unsigned parse_whitespace_rule(const char *string)
 	return rule;
 }
 
-static void setup_whitespace_attr_check(struct git_attr_check *check)
+static void setup_whitespace_attr_check(struct git_attr_value *check)
 {
 	static struct git_attr *attr_whitespace;
 
@@ -85,7 +85,7 @@ static void setup_whitespace_attr_check(struct git_attr_check *check)
 
 unsigned whitespace_rule(const char *pathname)
 {
-	struct git_attr_check attr_whitespace_rule;
+	struct git_attr_value attr_whitespace_rule;
 
 	setup_whitespace_attr_check(&attr_whitespace_rule);
 	if (!git_checkattr(pathname, 1, &attr_whitespace_rule)) {
-- 
1.7.6.8.gd2879
