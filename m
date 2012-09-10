From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 3/6] string_list: add a new function, filter_string_list()
Date: Mon, 10 Sep 2012 23:18:43 +0200
Message-ID: <1347311926-5207-4-git-send-email-mhagger@alum.mit.edu>
References: <1347311926-5207-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 23:19:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBBO9-0000gI-6x
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 23:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764Ab2IJVTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 17:19:15 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:57931 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753622Ab2IJVTM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Sep 2012 17:19:12 -0400
X-AuditID: 12074411-b7fa36d0000008cc-5f-504e594faef8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 69.B2.02252.F495E405; Mon, 10 Sep 2012 17:19:11 -0400 (EDT)
Received: from michael.fritz.box (p57A25B0C.dip.t-dialin.net [87.162.91.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8ALIwqO020122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 10 Sep 2012 17:19:10 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347311926-5207-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqOsf6Rdg8GavjEXXlW4mi4beK8wW
	t1fMZ7b40dLD7MDi8ff9ByaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE749V24YIG
	/Yqe45uZGxj3qHYxcnJICJhInP8wgQ3CFpO4cG89kM3FISRwmVHiw8l+VgjnDJPE9W0vmECq
	2AR0JRb1NIPZIgJqEhPbDrGA2MwCKRIdz7sZQWxhAV+JKx8vgk1lEVCVeHB8DlgNr4CzxINF
	l1kgtilK/Pi+hhnE5hRwkdjdv5UdxBYCqvm+4h/LBEbeBYwMqxjlEnNKc3VzEzNzilOTdYuT
	E/PyUot0TfVyM0v0UlNKNzFCwkdwB+OMk3KHGAU4GJV4eDV4/AKEWBPLiitzDzFKcjApifIa
	hgCF+JLyUyozEosz4otKc1KLDzFKcDArifDGawLleFMSK6tSi/JhUtIcLErivHxL1P2EBNIT
	S1KzU1MLUotgsjIcHEoSvHYRQI2CRanpqRVpmTklCGkmDk4QwQWygQdoQy5IIW9xQWJucWY6
	RNEpRkUpcV4DkIQASCKjNA9uACzSXzGKA/0jzOsLUsUDTBJw3a+ABjMBDfb18AEZXJKIkJJq
	YGQwFupZ/PF0y+c15Rfv3k3/kXQlImMPw5v78Q8ub1Obsepoyx+389Zvb8jv1vyxq6eY6Uy2
	mnr6qqVvpte8dvgfm+PY5X55xrMrX9csk7yz7WprAMPhvsSlwh/sdewvxghmPQ3e1HXlx42m
	xktXcvruCdptMFibuEAouHXmIhsD+6LrR/k3r9ylxFKckWioxVxUnAgA6TwWMs8C 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205188>

This function allows entries that don't match a specified criterion to
be discarded from a string_list while preserving the order of the
remaining entries.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-string-list.txt | 11 +++++++
 string-list.c                               | 17 ++++++++++
 string-list.h                               |  9 ++++++
 t/t0063-string-list.sh                      | 11 +++++++
 test-string-list.c                          | 48 +++++++++++++++++++++++++++++
 5 files changed, 96 insertions(+)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 670217c..ea65818 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -33,6 +33,9 @@ member (you need this if you add things later) and you should set the
 . Can remove individual items of an unsorted list using
   `unsorted_string_list_delete_item`.
 
+. Can remove items not matching a criterion from a sorted or unsorted
+  list using `filter_string_list`.
+
 . Finally it should free the list using `string_list_clear`.
 
 Example:
@@ -61,6 +64,14 @@ Functions
 
 * General ones (works with sorted and unsorted lists as well)
 
+`filter_string_list`::
+
+	Apply a function to each item in a list, retaining only the
+	items for which the function returns true.  If free_util is
+	true, call free() on the util members of any items that have
+	to be deleted.  Preserve the order of the items that are
+	retained.
+
 `print_string_list`::
 
 	Dump a string_list to stdout, useful mainly for debugging purposes. It
diff --git a/string-list.c b/string-list.c
index f9051ec..e0806fb 100644
--- a/string-list.c
+++ b/string-list.c
@@ -102,6 +102,23 @@ int for_each_string_list(struct string_list *list,
 	return ret;
 }
 
+void filter_string_list(struct string_list *list, int free_util,
+			string_list_each_func_t want, void *cb_data)
+{
+	int src, dst = 0;
+	for (src = 0; src < list->nr; src++) {
+		if (want(&list->items[src], cb_data)) {
+			list->items[dst++] = list->items[src];
+		} else {
+			if (list->strdup_strings)
+				free(list->items[src].string);
+			if (free_util)
+				free(list->items[src].util);
+		}
+	}
+	list->nr = dst;
+}
+
 void string_list_clear(struct string_list *list, int free_util)
 {
 	if (list->items) {
diff --git a/string-list.h b/string-list.h
index dc5fbc8..7d18e62 100644
--- a/string-list.h
+++ b/string-list.h
@@ -29,6 +29,15 @@ int for_each_string_list(struct string_list *list,
 #define for_each_string_list_item(item,list) \
 	for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
 
+/*
+ * Apply want to each item in list, retaining only the ones for which
+ * the function returns true.  If free_util is true, call free() on
+ * the util members of any items that have to be deleted.  Preserve
+ * the order of the items that are retained.
+ */
+void filter_string_list(struct string_list *list, int free_util,
+			string_list_each_func_t want, void *cb_data);
+
 
 /* Use these functions only on sorted lists: */
 int string_list_has_string(const struct string_list *list, const char *string);
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
index fb85430..a5f05cd 100755
--- a/t/t0063-string-list.sh
+++ b/t/t0063-string-list.sh
@@ -60,4 +60,15 @@ test_split ":" ":" "-1" <<EOF
 [1]: ""
 EOF
 
+test_expect_success "test filter_string_list" '
+	test "x-" = "x$(test-string-list filter - y)" &&
+	test "x-" = "x$(test-string-list filter no y)" &&
+	test yes = "$(test-string-list filter yes y)" &&
+	test yes = "$(test-string-list filter no:yes y)" &&
+	test yes = "$(test-string-list filter yes:no y)" &&
+	test y1:y2 = "$(test-string-list filter y1:y2 y)" &&
+	test y2:y1 = "$(test-string-list filter y2:y1 y)" &&
+	test "x-" = "x$(test-string-list filter x1:x2 y)"
+'
+
 test_done
diff --git a/test-string-list.c b/test-string-list.c
index cdc3cf3..702276c 100644
--- a/test-string-list.c
+++ b/test-string-list.c
@@ -1,6 +1,20 @@
 #include "cache.h"
 #include "string-list.h"
 
+/*
+ * Parse an argument into a string list.  arg should either be a
+ * ':'-separated list of strings, or "-" to indicate an empty string
+ * list (as opposed to "", which indicates a string list containing a
+ * single empty string).  list->strdup_strings must be set.
+ */
+void parse_string_list(struct string_list *list, const char *arg)
+{
+	if (!strcmp(arg, "-"))
+		return;
+
+	(void)string_list_split(list, arg, ':', -1);
+}
+
 void write_list(const struct string_list *list)
 {
 	int i;
@@ -8,6 +22,25 @@ void write_list(const struct string_list *list)
 		printf("[%d]: \"%s\"\n", i, list->items[i].string);
 }
 
+void write_list_compact(const struct string_list *list)
+{
+	int i;
+	if (!list->nr)
+		printf("-\n");
+	else {
+		printf("%s", list->items[0].string);
+		for (i = 1; i < list->nr; i++)
+			printf(":%s", list->items[i].string);
+		printf("\n");
+	}
+}
+
+int prefix_cb(struct string_list_item *item, void *cb_data)
+{
+	const char *prefix = (const char *)cb_data;
+	return !prefixcmp(item->string, prefix);
+}
+
 int main(int argc, char **argv)
 {
 	if (argc == 5 && !strcmp(argv[1], "split")) {
@@ -39,6 +72,21 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	if (argc == 4 && !strcmp(argv[1], "filter")) {
+		/*
+		 * Retain only the items that have the specified prefix.
+		 * Arguments: list|- prefix
+		 */
+		struct string_list list = STRING_LIST_INIT_DUP;
+		const char *prefix = argv[3];
+
+		parse_string_list(&list, argv[2]);
+		filter_string_list(&list, 0, prefix_cb, (void *)prefix);
+		write_list_compact(&list);
+		string_list_clear(&list, 0);
+		return 0;
+	}
+
 	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
 		argv[1] ? argv[1] : "(there was none)");
 	return 1;
-- 
1.7.11.3
