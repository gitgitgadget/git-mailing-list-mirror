From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/4] Add a new function, string_list_remove_duplicates()
Date: Sun,  9 Sep 2012 07:53:09 +0200
Message-ID: <1347169990-9279-4-git-send-email-mhagger@alum.mit.edu>
References: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 07:54:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAaTp-0003vs-AB
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 07:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122Ab2IIFyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 01:54:33 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:59776 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751947Ab2IIFxv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 01:53:51 -0400
X-AuditID: 12074413-b7f786d0000008bb-76-504c2eef5677
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 09.93.02235.FEE2C405; Sun,  9 Sep 2012 01:53:51 -0400 (EDT)
Received: from michael.fritz.box (p57A25CBD.dip.t-dialin.net [87.162.92.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q895raZC028212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Sep 2012 01:53:50 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqPtezyfA4PxzbouuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M7oPm1TsFms4v7d6awNjEuF
	uhg5OSQETCS+fvjGBmGLSVy4tx7I5uIQErjMKHF8+lp2COcMk8Sn26uZQarYBHQlFvU0M4HY
	IgJqEhPbDrGA2MwCDhKbPzcygtjCAh4S257vAIuzCKhKdE9fxA5i8wo4SyxdN58FYpuixI/v
	a8Bmcgq4SNy+uhusRgio5vvny+wTGHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI118vN
	LNFLTSndxAgJFeEdjLtOyh1iFOBgVOLhZb7jHSDEmlhWXJl7iFGSg0lJlNdc2ydAiC8pP6Uy
	I7E4I76oNCe1+BCjBAezkgjvVXagHG9KYmVValE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoR
	TFaGg0NJgveSLlCjYFFqempFWmZOCUKaiYMTRHCBbOAB2mCsB7KhuCAxtzgzHaLoFKOilDjv
	OZAJAiCJjNI8uAGwqH7FKA70jzDvKpAqHmBCgOt+BTSYCWiwyDMPkMEliQgpqQZGt8PTzp7Q
	P28eNMuviv9ExuI+vpN/n10T9Uz+2uG4rdNQ7MsXIZs+V+f5kWyslc952YV5mZ9nX59SEXOO
	K9n0ysufe9t2XFect/a0QuyUt9M7J4YtNwk6fdWcYcrRTTLcR/qetL94+L9fNfzqur4qUYXc
	X0ZHCns4Z85Yqp/p+C1++5/Hf5dPVWIpzkg01GIuKk4EAL9FNX3FAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205049>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-string-list.txt |  4 ++++
 string-list.c                               | 17 +++++++++++++++++
 string-list.h                               |  5 +++++
 3 files changed, 26 insertions(+)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 15b8072..9206f8f 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -104,6 +104,10 @@ write `string_list_insert(...)->util = ...;`.
 	Look up a given string in the string_list, returning the containing
 	string_list_item. If the string is not found, NULL is returned.
 
+`string_list_remove_duplicates`::
+
+	Remove all but the first entry that has a given string value.
+
 * Functions for unsorted lists only
 
 `string_list_append`::
diff --git a/string-list.c b/string-list.c
index 72610ce..bfef6cf 100644
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
index 84996aa..c4dc659 100644
--- a/string-list.h
+++ b/string-list.h
@@ -38,6 +38,7 @@ int for_each_string_list(struct string_list *list,
 void filter_string_list(struct string_list *list, int free_util,
 			string_list_each_func_t fn, void *cb_data);
 
+
 /* Use these functions only on sorted lists: */
 int string_list_has_string(const struct string_list *list, const char *string);
 int string_list_find_insert_index(const struct string_list *list, const char *string,
@@ -47,6 +48,10 @@ struct string_list_item *string_list_insert_at_index(struct string_list *list,
 						     int insert_at, const char *string);
 struct string_list_item *string_list_lookup(struct string_list *list, const char *string);
 
+/* Remove all but the first entry that has a given string value. */
+void string_list_remove_duplicates(struct string_list *list, int free_util);
+
+
 /* Use these functions only on unsorted lists: */
 struct string_list_item *string_list_append(struct string_list *list, const char *string);
 void sort_string_list(struct string_list *list);
-- 
1.7.11.3
