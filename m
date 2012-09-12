From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 2/6] string_list: add two new functions for splitting strings
Date: Wed, 12 Sep 2012 16:04:43 +0200
Message-ID: <1347458687-31092-3-git-send-email-mhagger@alum.mit.edu>
References: <1347458687-31092-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 16:05:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBnZI-0004hC-Ix
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 16:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758898Ab2ILOFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 10:05:15 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:46564 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751188Ab2ILOFN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Sep 2012 10:05:13 -0400
X-AuditID: 12074413-b7f786d0000008bb-07-5050969822ad
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 06.92.02235.89690505; Wed, 12 Sep 2012 10:05:12 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8CE51QU021888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Sep 2012 10:05:11 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347458687-31092-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqDtjWkCAQd89E4uuK91MFg29V5gt
	bq+Yz2zxo6WH2YHF4+/7D0wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xoTOZ+wF
	Uz0rdq48xtjAOMmqi5GTQ0LARGLOsX+sELaYxIV769m6GLk4hAQuM0o0H77ABOGcYZJ4vqeR
	GaSKTUBXYlFPMxOILSKgJjGx7RALiM0skCLR8bybEcQWFgiQeH/tM9hUFgFViRfzb7N3MXJw
	8Aq4SOx6HQ2xTFHix/c1YCM5BVwllsz8wwZiCwGVrG2eyTSBkXcBI8MqRrnEnNJc3dzEzJzi
	1GTd4uTEvLzUIl1zvdzMEr3UlNJNjJDwEd7BuOuk3CFGAQ5GJR5ehgT/ACHWxLLiytxDjJIc
	TEqivJ8nBwQI8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuHdoAuU401JrKxKLcqHSUlzsCiJ86ot
	UfcTEkhPLEnNTk0tSC2CycpwcChJ8L6dAtQoWJSanlqRlplTgpBm4uAEEVwgG3iANpSDFPIW
	FyTmFmemQxSdYlSUEuc9MwkoIQCSyCjNgxsAi/RXjOJA/wjzCk4FquIBJgm47ldAg5mABk9Y
	6w8yuCQRISXVwChbOSfl7eJyp6y2Ewf6w1IyAsu6mVVNrLkOLL7zr2613QUnTlb5h7ZBT99I
	F9146b88cK156+2ud9HThQI4Z1RoH/n2zOtPEPOW/i85K1RTKiyNQxltUk++eBLoWhZ7Ycl3
	23gl18+CJ77ZKJxr3xQ5ZdOcbNawrdfW/gtYtdt+xxWVIOs1lkosxRmJhlrMRcWJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205292>

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
 Documentation/technical/api-string-list.txt | 22 +++++++++-
 Makefile                                    |  1 +
 string-list.c                               | 53 ++++++++++++++++++++++++
 string-list.h                               | 29 +++++++++++++
 t/t0063-string-list.sh                      | 63 +++++++++++++++++++++++++++++
 test-string-list.c                          | 45 +++++++++++++++++++++
 7 files changed, 213 insertions(+), 1 deletion(-)
 create mode 100755 t/t0063-string-list.sh
 create mode 100644 test-string-list.c

diff --git a/.gitignore b/.gitignore
index 68fe464..a188a82 100644
--- a/.gitignore
+++ b/.gitignore
@@ -194,6 +194,7 @@
 /test-run-command
 /test-sha1
 /test-sigchain
+/test-string-list
 /test-subprocess
 /test-svn-fe
 /common-cmds.h
diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 113f841..1dcad47 100644
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
@@ -135,6 +136,25 @@ counterpart for sorted lists, which performs a binary search.
 	is set. The third parameter controls if the `util` pointer of the
 	items should be freed or not.
 
+`string_list_split`::
+`string_list_split_in_place`::
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
index 26b697d..2e396b0 100644
--- a/Makefile
+++ b/Makefile
@@ -502,6 +502,7 @@ TEST_PROGRAMS_NEED_X += test-run-command
 TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
 TEST_PROGRAMS_NEED_X += test-sha1
 TEST_PROGRAMS_NEED_X += test-sigchain
+TEST_PROGRAMS_NEED_X += test-string-list
 TEST_PROGRAMS_NEED_X += test-subprocess
 TEST_PROGRAMS_NEED_X += test-svn-fe
 
diff --git a/string-list.c b/string-list.c
index ad2aa5a..acb1f5b 100644
--- a/string-list.c
+++ b/string-list.c
@@ -204,3 +204,56 @@ void unsorted_string_list_delete_item(struct string_list *list, int i, int free_
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
+	if (!list->strdup_strings)
+		die("internal error in string_list_split(): "
+		    "list->strdup_strings must be set");
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
+	if (list->strdup_strings)
+		die("internal error in string_list_split_in_place(): "
+		    "list->strdup_strings must not be set");
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
