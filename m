From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/4] Add a new function, filter_string_list()
Date: Sun,  9 Sep 2012 07:53:08 +0200
Message-ID: <1347169990-9279-3-git-send-email-mhagger@alum.mit.edu>
References: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 07:54:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAaTo-0003vs-Py
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 07:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026Ab2IIFyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 01:54:33 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:64047 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751930Ab2IIFxt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 01:53:49 -0400
X-AuditID: 12074411-b7fa36d0000008cc-68-504c2eec1b26
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 80.50.02252.CEE2C405; Sun,  9 Sep 2012 01:53:48 -0400 (EDT)
Received: from michael.fritz.box (p57A25CBD.dip.t-dialin.net [87.162.92.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q895raZB028212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Sep 2012 01:53:47 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqPtGzyfA4PwLa4uuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M6YtrSBpaBftGLO/LQGxr8C
	XYycHBICJhJTup4yQdhiEhfurWfrYuTiEBK4zChxedF+ZgjnDJPE5CldLCBVbAK6Eot6msE6
	RATUJCa2HQKLMws4SGz+3MgIYgsL2Eosv/iKDcRmEVCVeHZkMSuIzSvgLLHx7G1WiG2KEj++
	r2EGsTkFXCRuX93NDmILAdV8/3yZfQIj7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuqZ6
	uZkleqkppZsYIaEiuINxxkm5Q4wCHIxKPLzMd7wDhFgTy4orcw8xSnIwKYnymmv7BAjxJeWn
	VGYkFmfEF5XmpBYfYpTgYFYS4b3KDpTjTUmsrEotyodJSXOwKInz8i1R9xMSSE8sSc1OTS1I
	LYLJynBwKEnwXtIFahQsSk1PrUjLzClBSDNxcIIILpANPEAbXEAKeYsLEnOLM9Mhik4xKkqJ
	854DSQiAJDJK8+AGwKL6FaM40D/CvO9BqniACQGu+xXQYCagwSLPPEAGlyQipKQaGIOVuxOe
	rOB/aNEhk//potfmJ+Jnt3C8sZTk4GTftKLmTduFxRXm1xx4xfnE1jHNfDtvWZTQE6a6pe5r
	9u16IPLkt27eR+aA75Lfpr+fsOy/Z8X6JH6VdRrsi4Rkz9Y9zJftkdyv1/qh9o6Nam7Fcsar
	5nnc0auMAlMy2RolZHKPC1QxX+64qcRSnJFoqMVcVJwIAFm15IzFAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205047>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-string-list.txt |  8 ++++++++
 string-list.c                               | 17 +++++++++++++++++
 string-list.h                               |  9 +++++++++
 3 files changed, 34 insertions(+)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 3b959a2..15b8072 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -60,6 +60,14 @@ Functions
 
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
index 110449c..72610ce 100644
--- a/string-list.c
+++ b/string-list.c
@@ -102,6 +102,23 @@ int for_each_string_list(struct string_list *list,
 	return ret;
 }
 
+void filter_string_list(struct string_list *list, int free_util,
+			string_list_each_func_t fn, void *cb_data)
+{
+	int src, dst = 0;
+	for (src = 0; src < list->nr; src++) {
+		if (fn(&list->items[src], cb_data)) {
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
index 7e51d03..84996aa 100644
--- a/string-list.h
+++ b/string-list.h
@@ -29,6 +29,15 @@ int for_each_string_list(struct string_list *list,
 #define for_each_string_list_item(item,list) \
 	for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
 
+/*
+ * Apply fn to each item in list, retaining only the ones for which
+ * the function returns true.  If free_util is true, call free() on
+ * the util members of any items that have to be deleted.  Preserve
+ * the order of the items that are retained.
+ */
+void filter_string_list(struct string_list *list, int free_util,
+			string_list_each_func_t fn, void *cb_data);
+
 /* Use these functions only on sorted lists: */
 int string_list_has_string(const struct string_list *list, const char *string);
 int string_list_find_insert_index(const struct string_list *list, const char *string,
-- 
1.7.11.3
