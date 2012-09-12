From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 4/6] string_list: add a new function, string_list_remove_duplicates()
Date: Wed, 12 Sep 2012 16:04:45 +0200
Message-ID: <1347458687-31092-5-git-send-email-mhagger@alum.mit.edu>
References: <1347458687-31092-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 16:05:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBnZS-0004ws-Vm
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 16:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758413Ab2ILOF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 10:05:28 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:63640 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751605Ab2ILOFU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Sep 2012 10:05:20 -0400
X-AuditID: 12074413-b7f786d0000008bb-1e-5050969f01d9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id B8.92.02235.F9690505; Wed, 12 Sep 2012 10:05:19 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8CE51QW021888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Sep 2012 10:05:18 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347458687-31092-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsUixO6iqDt/WkCAwfNWOYuuK91MFg29V5gt
	bq+Yz2zxo6WH2YHF4+/7D0wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xtLjPxkL
	mtUr1ky9zd7AeEW+i5GDQ0LAROLQ64guRk4gU0ziwr31bF2MXBxCApcZJbrv32KFcM4wSax+
	OJ0VpIpNQFdiUU8zE4gtIqAmMbHtEAuIzSyQItHxvJsRxBYWiJD4cXYWO8gCFgFViRVPDUBM
	XgEXiaYJzhC7FCV+fF/DDGJzCrhKLJn5hw3EFgIqWds8k2kCI+8CRoZVjHKJOaW5urmJmTnF
	qcm6xcmJeXmpRbrmermZJXqpKaWbGCGhI7yDcddJuUOMAhyMSjy8DAn+AUKsiWXFlbmHGCU5
	mJREeT9PDggQ4kvKT6nMSCzOiC8qzUktPsQowcGsJMK7QRcox5uSWFmVWpQPk5LmYFES51Vb
	ou4nJJCeWJKanZpakFoEk5Xh4FCS4H07BahRsCg1PbUiLTOnBCHNxMEJIrhANvAAbSgHKeQt
	LkjMLc5Mhyg6xagoJc57ZhJQQgAkkVGaBzcAFuWvGMWB/hHmFZwKVMUDTBBw3a+ABjMBDZ6w
	1h9kcEkiQkqqgTE00bbyxMFoy7hf/lMY92R//uT1y9O9qMn36o75S2pOHP82v/rxpMrHKY/e
	3To1NUVRRIShq3d1+VGphEu7T54z4olZ1TY/KE1t1t2C0OadU1k+bIs+6Htl0qxHLKG52/56
	mx6caDdhJdv38JiulJU3jspPELwdd6CA84tg8C7G/6tn/i663WquxFKckWioxVxU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205295>

Add a function that deletes duplicate entries from a sorted
string_list.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-string-list.txt |  9 +++++++++
 string-list.c                               | 17 +++++++++++++++++
 string-list.h                               |  7 +++++++
 t/t0063-string-list.sh                      | 17 +++++++++++++++++
 test-string-list.c                          | 10 ++++++++++
 5 files changed, 60 insertions(+)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 300b301..0f8b7ce 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -30,6 +30,9 @@ member (you need this if you add things later) and you should set the
 
 . Can sort an unsorted list using `sort_string_list`.
 
+. Can remove duplicate items from a sorted list using
+  `string_list_remove_duplicates`.
+
 . Can remove individual items of an unsorted list using
   `unsorted_string_list_delete_item`.
 
@@ -108,6 +111,12 @@ write `string_list_insert(...)->util = ...;`.
 	Look up a given string in the string_list, returning the containing
 	string_list_item. If the string is not found, NULL is returned.
 
+`string_list_remove_duplicates`::
+
+	Remove all but the first of consecutive entries that have the
+	same string value.  If free_util is true, call free() on the
+	util members of any items that have to be deleted.
+
 * Functions for unsorted lists only
 
 `string_list_append`::
diff --git a/string-list.c b/string-list.c
index 179fde4..decfa74 100644
--- a/string-list.c
+++ b/string-list.c
@@ -92,6 +92,23 @@ struct string_list_item *string_list_lookup(struct string_list *list, const char
 	return list->items + i;
 }
 
+void string_list_remove_duplicates(struct string_list *list, int free_util)
+{
+	if (list->nr > 1) {
+		int src, dst;
+		for (src = dst = 1; src < list->nr; src++) {
+			if (!strcmp(list->items[dst - 1].string, list->items[src].string)) {
+				if (list->strdup_strings)
+					free(list->items[src].string);
+				if (free_util)
+					free(list->items[src].util);
+			} else
+				list->items[dst++] = list->items[src];
+		}
+		list->nr = dst;
+	}
+}
+
 int for_each_string_list(struct string_list *list,
 			 string_list_each_func_t fn, void *cb_data)
 {
diff --git a/string-list.h b/string-list.h
index 7d18e62..3a6a6dc 100644
--- a/string-list.h
+++ b/string-list.h
@@ -48,6 +48,13 @@ struct string_list_item *string_list_insert_at_index(struct string_list *list,
 						     int insert_at, const char *string);
 struct string_list_item *string_list_lookup(struct string_list *list, const char *string);
 
+/*
+ * Remove all but the first of consecutive entries with the same
+ * string value.  If free_util is true, call free() on the util
+ * members of any items that have to be deleted.
+ */
+void string_list_remove_duplicates(struct string_list *sorted_list, int free_util);
+
 
 /* Use these functions only on unsorted lists: */
 
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
index a5f05cd..dbfc05e 100755
--- a/t/t0063-string-list.sh
+++ b/t/t0063-string-list.sh
@@ -71,4 +71,21 @@ test_expect_success "test filter_string_list" '
 	test "x-" = "x$(test-string-list filter x1:x2 y)"
 '
 
+test_expect_success "test remove_duplicates" '
+	test "x-" = "x$(test-string-list remove_duplicates -)" &&
+	test "x" = "x$(test-string-list remove_duplicates "")" &&
+	test a = "$(test-string-list remove_duplicates a)" &&
+	test a = "$(test-string-list remove_duplicates a:a)" &&
+	test a = "$(test-string-list remove_duplicates a:a:a:a:a)" &&
+	test a:b = "$(test-string-list remove_duplicates a:b)" &&
+	test a:b = "$(test-string-list remove_duplicates a:a:b)" &&
+	test a:b = "$(test-string-list remove_duplicates a:b:b)" &&
+	test a:b:c = "$(test-string-list remove_duplicates a:b:c)" &&
+	test a:b:c = "$(test-string-list remove_duplicates a:a:b:c)" &&
+	test a:b:c = "$(test-string-list remove_duplicates a:b:b:c)" &&
+	test a:b:c = "$(test-string-list remove_duplicates a:b:c:c)" &&
+	test a:b:c = "$(test-string-list remove_duplicates a:a:b:b:c:c)" &&
+	test a:b:c = "$(test-string-list remove_duplicates a:a:a:b:b:b:c:c:c)"
+'
+
 test_done
diff --git a/test-string-list.c b/test-string-list.c
index 702276c..2d6eda7 100644
--- a/test-string-list.c
+++ b/test-string-list.c
@@ -87,6 +87,16 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	if (argc == 3 && !strcmp(argv[1], "remove_duplicates")) {
+		struct string_list list = STRING_LIST_INIT_DUP;
+
+		parse_string_list(&list, argv[2]);
+		string_list_remove_duplicates(&list, 0);
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
