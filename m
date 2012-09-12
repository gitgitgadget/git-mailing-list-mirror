From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 3/6] string_list: add a new function, filter_string_list()
Date: Wed, 12 Sep 2012 16:04:44 +0200
Message-ID: <1347458687-31092-4-git-send-email-mhagger@alum.mit.edu>
References: <1347458687-31092-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 16:05:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBnZJ-0004hC-P1
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 16:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757831Ab2ILOFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 10:05:21 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:56501 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751188Ab2ILOFQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Sep 2012 10:05:16 -0400
X-AuditID: 12074412-b7f216d0000008e3-10-5050969bafca
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 79.EA.02275.B9690505; Wed, 12 Sep 2012 10:05:15 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8CE51QV021888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Sep 2012 10:05:14 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347458687-31092-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsUixO6iqDt7WkCAwZUt1hZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujFdXz7IX
	NOhXdLzcytLAuEe1i5GTQ0LAROLegltMELaYxIV769m6GLk4hAQuM0rsP/uSFcI5wyTxvecc
	G0gVm4CuxKKeZrAOEQE1iYlth1hAbGaBFImO592MILawgK9EQ8tKZhCbRUBVYtmbs6wgNq+A
	i8TUby0sENsUJX58XwNWwyngKrFk5h+w+UJANWubZzJNYORdwMiwilEuMac0Vzc3MTOnODVZ
	tzg5MS8vtUjXTC83s0QvNaV0EyMkgIR2MK4/KXeIUYCDUYmHlyHBP0CINbGsuDL3EKMkB5OS
	KO/nyQEBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4N+gC5XhTEiurUovyYVLSHCxK4rw/F6v7
	CQmkJ5akZqemFqQWwWRlODiUJHhTpwI1ChalpqdWpGXmlCCkmTg4QQQXyAYeoA3lU0A2FBck
	5hZnpkMUnWJUlBLnNQI5SwAkkVGaBzcAFuuvGMWB/hHm7QTZwwNME3Ddr4AGMwENnrDWH2Rw
	SSJCSqqBUeywZJbBkTxfn1XfFYu83D+0f8subZvC2d27eHuD+4eL4jY32e7wLN/I01wv533t
	fvGufH2TQyqxu6fVS+fVTlnE/FfS9xdP/F/jA9c2xE6d354msFtE9r3SJabu2m9CggYPFNZx
	f8u2eh8y+9N2YX0bhYr8Gu4XvMwX7iovXG7XKHXWK3SWEktxRqKhFnNRcSIAP95x 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205293>

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
index 1dcad47..300b301 100644
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
index acb1f5b..179fde4 100644
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
