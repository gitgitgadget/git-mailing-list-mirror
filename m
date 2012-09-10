From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 2/6] string_list: add two new functions for splitting strings
Date: Mon, 10 Sep 2012 23:18:42 +0200
Message-ID: <1347311926-5207-3-git-send-email-mhagger@alum.mit.edu>
References: <1347311926-5207-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 23:19:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBBO8-0000gI-MP
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 23:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630Ab2IJVTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 17:19:11 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:45039 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752862Ab2IJVTJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Sep 2012 17:19:09 -0400
X-AuditID: 1207440d-b7f236d000000943-ce-504e594caf4a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 51.B5.02371.C495E405; Mon, 10 Sep 2012 17:19:08 -0400 (EDT)
Received: from michael.fritz.box (p57A25B0C.dip.t-dialin.net [87.162.91.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8ALIwqN020122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 10 Sep 2012 17:19:07 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347311926-5207-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsUixO6iqOsT6Rdg0PPawqLrSjeTRUPvFWaL
	2yvmM1v8aOlhdmDx+Pv+A5PHs949jB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8CdcXnSJOaC
	s+4VB+5sZW9g/GLRxcjJISFgInHk2UtGCFtM4sK99WxdjFwcQgKXGSX6t/xmgnDOMElMXbgc
	rIpNQFdiUU8zE4gtIqAmMbHtEAuIzSyQItHxvBusRlggQGJW/1w2EJtFQFViesM6sDivgLPE
	5Kvd7BDbFCV+fF/DDGJzCrhI7O7fChYXAqr5vuIfywRG3gWMDKsY5RJzSnN1cxMzc4pTk3WL
	kxPz8lKLdI30cjNL9FJTSjcxQgKIdwfj/3UyhxgFOBiVeHg1ePwChFgTy4orcw8xSnIwKYny
	GoYAhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwxmsC5XhTEiurUovyYVLSHCxK4rxqS9T9hATS
	E0tSs1NTC1KLYLIyHBxKErw/woEaBYtS01Mr0jJzShDSTBycIIILZAMP0IY6kELe4oLE3OLM
	dIiiU4yKUuK820ASAiCJjNI8uAGwWH/FKA70jzCvYARQFQ8wTcB1vwIazAQ02NfDB2RwSSJC
	SqqB0dvHU/BnVuKh2zNebX0zWen8X615z7dwLS/WnNf4783745KripSWh8sdcEl1/q74lvdn
	HH+vrWQrg65+4ZvyH0skWf7/WbX9bdrGt6/UTAqeLHA3E+laH/wlYEZRUeOde3260sbhKUWF
	cnrnriqW3pm1yjZqvtKZfYssjpoxTMtPqJYtLL/6VomlOCPRUIu5qDgRAFm3SKPQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205186>

Add two new functions, string_list_split() and
string_list_split_in_place().  These split a string into a string_list
on a separator character.  The first makes copies of the substrings
(leaving the input string untouched) and the second splits the
original string in place, overwriting the separator characters with
NULs and referring to the original string's memory.

These functions are similar to the strbuf_split_*() functions except
that they work with the more powerful string_list interface.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 .gitignore                                  |  1 +
 Documentation/technical/api-string-list.txt | 21 +++++++++-
 Makefile                                    |  1 +
 string-list.c                               | 49 ++++++++++++++++++++++
 string-list.h                               | 29 +++++++++++++
 t/t0063-string-list.sh                      | 63 +++++++++++++++++++++++++++++
 test-string-list.c                          | 45 +++++++++++++++++++++
 7 files changed, 208 insertions(+), 1 deletion(-)
 create mode 100755 t/t0063-string-list.sh
 create mode 100644 test-string-list.c

diff --git a/.gitignore b/.gitignore
index bb5c91e..0ca7df8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -193,6 +193,7 @@
 /test-run-command
 /test-sha1
 /test-sigchain
+/test-string-list
 /test-subprocess
 /test-svn-fe
 /common-cmds.h
diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 113f841..670217c 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -21,7 +21,8 @@ member (you need this if you add things later) and you should set the
 `nr` and `alloc` members in that case, too.
 
 . Adds new items to the list, using `string_list_append`,
-  `string_list_append_nodup`, or `string_list_insert`.
+  `string_list_append_nodup`, `string_list_insert`,
+  `string_list_split`, and/or `string_list_split_in_place`.
 
 . Can check if a string is in the list using `string_list_has_string` or
   `unsorted_string_list_has_string` and get it from the list using
@@ -135,6 +136,24 @@ counterpart for sorted lists, which performs a binary search.
 	is set. The third parameter controls if the `util` pointer of the
 	items should be freed or not.
 
+`string_list_split`, `string_list_split_in_place`::
+
+	Split a string into substrings on a delimiter character and
+	append the substrings to a `string_list`.  If `maxsplit` is
+	non-negative, then split at most `maxsplit` times.  Return the
+	number of substrings appended to the list.
++
+`string_list_split` requires a `string_list` that has `strdup_strings`
+set to true; it leaves the input string untouched and makes copies of
+the substrings in newly-allocated memory.
+`string_list_split_in_place` requires a `string_list` that has
+`strdup_strings` set to false; it splits the input string in place,
+overwriting the delimiter characters with NULs and creating new
+string_list_items that point into the original string (the original
+string must therefore not be modified or freed while the `string_list`
+is in use).
+
+
 Data structures
 ---------------
 
diff --git a/Makefile b/Makefile
index 66e8216..ebbb381 100644
--- a/Makefile
+++ b/Makefile
@@ -501,6 +501,7 @@ TEST_PROGRAMS_NEED_X += test-run-command
 TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
 TEST_PROGRAMS_NEED_X += test-sha1
 TEST_PROGRAMS_NEED_X += test-sigchain
+TEST_PROGRAMS_NEED_X += test-string-list
 TEST_PROGRAMS_NEED_X += test-subprocess
 TEST_PROGRAMS_NEED_X += test-svn-fe
 
diff --git a/string-list.c b/string-list.c
index 5594b7d..f9051ec 100644
--- a/string-list.c
+++ b/string-list.c
@@ -204,3 +204,52 @@ void unsorted_string_list_delete_item(struct string_list *list, int i, int free_
 	list->items[i] = list->items[list->nr-1];
 	list->nr--;
 }
+
+int string_list_split(struct string_list *list, const char *string,
+		      int delim, int maxsplit)
+{
+	int count = 0;
+	const char *p = string, *end;
+
+	assert(list->strdup_strings);
+	for (;;) {
+		count++;
+		if (maxsplit >= 0 && count > maxsplit) {
+			string_list_append(list, p);
+			return count;
+		}
+		end = strchr(p, delim);
+		if (end) {
+			string_list_append_nodup(list, xmemdupz(p, end - p));
+			p = end + 1;
+		} else {
+			string_list_append(list, p);
+			return count;
+		}
+	}
+}
+
+int string_list_split_in_place(struct string_list *list, char *string,
+			       int delim, int maxsplit)
+{
+	int count = 0;
+	char *p = string, *end;
+
+	assert(!list->strdup_strings);
+	for (;;) {
+		count++;
+		if (maxsplit >= 0 && count > maxsplit) {
+			string_list_append(list, p);
+			return count;
+		}
+		end = strchr(p, delim);
+		if (end) {
+			*end = '\0';
+			string_list_append(list, p);
+			p = end + 1;
+		} else {
+			string_list_append(list, p);
+			return count;
+		}
+	}
+}
diff --git a/string-list.h b/string-list.h
index 1b3915b..dc5fbc8 100644
--- a/string-list.h
+++ b/string-list.h
@@ -63,4 +63,33 @@ struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
 						     const char *string);
 
 void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util);
+
+/*
+ * Split string into substrings on character delim and append the
+ * substrings to list.  The input string is not modified.
+ * list->strdup_strings must be set, as new memory needs to be
+ * allocated to hold the substrings.  If maxsplit is non-negative,
+ * then split at most maxsplit times.  Return the number of substrings
+ * appended to list.
+ *
+ * Examples:
+ *   string_list_split(l, "foo:bar:baz", ':', -1) -> ["foo", "bar", "baz"]
+ *   string_list_split(l, "foo:bar:baz", ':', 0) -> ["foo:bar:baz"]
+ *   string_list_split(l, "foo:bar:baz", ':', 1) -> ["foo", "bar:baz"]
+ *   string_list_split(l, "foo:bar:", ':', -1) -> ["foo", "bar", ""]
+ *   string_list_split(l, "", ':', -1) -> [""]
+ *   string_list_split(l, ":", ':', -1) -> ["", ""]
+ */
+int string_list_split(struct string_list *list, const char *string,
+		      int delim, int maxsplit);
+
+/*
+ * Like string_list_split(), except that string is split in-place: the
+ * delimiter characters in string are overwritten with NULs, and the
+ * new string_list_items point into string (which therefore must not
+ * be modified or freed while the string_list is in use).
+ * list->strdup_strings must *not* be set.
+ */
+int string_list_split_in_place(struct string_list *list, char *string,
+			       int delim, int maxsplit);
 #endif /* STRING_LIST_H */
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
new file mode 100755
index 0000000..fb85430
--- /dev/null
+++ b/t/t0063-string-list.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Michael Haggerty
+#
+
+test_description='Test string list functionality'
+
+. ./test-lib.sh
+
+test_split () {
+	cat >expected &&
+	test_expect_success "split $1 at $2, max $3" "
+		test-string-list split '$1' '$2' '$3' >actual &&
+		test_cmp expected actual &&
+		test-string-list split_in_place '$1' '$2' '$3' >actual &&
+		test_cmp expected actual
+	"
+}
+
+test_split "foo:bar:baz" ":" "-1" <<EOF
+3
+[0]: "foo"
+[1]: "bar"
+[2]: "baz"
+EOF
+
+test_split "foo:bar:baz" ":" "0" <<EOF
+1
+[0]: "foo:bar:baz"
+EOF
+
+test_split "foo:bar:baz" ":" "1" <<EOF
+2
+[0]: "foo"
+[1]: "bar:baz"
+EOF
+
+test_split "foo:bar:baz" ":" "2" <<EOF
+3
+[0]: "foo"
+[1]: "bar"
+[2]: "baz"
+EOF
+
+test_split "foo:bar:" ":" "-1" <<EOF
+3
+[0]: "foo"
+[1]: "bar"
+[2]: ""
+EOF
+
+test_split "" ":" "-1" <<EOF
+1
+[0]: ""
+EOF
+
+test_split ":" ":" "-1" <<EOF
+2
+[0]: ""
+[1]: ""
+EOF
+
+test_done
diff --git a/test-string-list.c b/test-string-list.c
new file mode 100644
index 0000000..cdc3cf3
--- /dev/null
+++ b/test-string-list.c
@@ -0,0 +1,45 @@
+#include "cache.h"
+#include "string-list.h"
+
+void write_list(const struct string_list *list)
+{
+	int i;
+	for (i = 0; i < list->nr; i++)
+		printf("[%d]: \"%s\"\n", i, list->items[i].string);
+}
+
+int main(int argc, char **argv)
+{
+	if (argc == 5 && !strcmp(argv[1], "split")) {
+		struct string_list list = STRING_LIST_INIT_DUP;
+		int i;
+		const char *s = argv[2];
+		int delim = *argv[3];
+		int maxsplit = atoi(argv[4]);
+
+		i = string_list_split(&list, s, delim, maxsplit);
+		printf("%d\n", i);
+		write_list(&list);
+		string_list_clear(&list, 0);
+		return 0;
+	}
+
+	if (argc == 5 && !strcmp(argv[1], "split_in_place")) {
+		struct string_list list = STRING_LIST_INIT_NODUP;
+		int i;
+		char *s = xstrdup(argv[2]);
+		int delim = *argv[3];
+		int maxsplit = atoi(argv[4]);
+
+		i = string_list_split_in_place(&list, s, delim, maxsplit);
+		printf("%d\n", i);
+		write_list(&list);
+		string_list_clear(&list, 0);
+		free(s);
+		return 0;
+	}
+
+	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
+		argv[1] ? argv[1] : "(there was none)");
+	return 1;
+}
-- 
1.7.11.3
