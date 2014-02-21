From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/6] replace_object: use struct members instead of an array
Date: Fri, 21 Feb 2014 17:32:03 +0100
Message-ID: <1393000327-11402-3-git-send-email-mhagger@alum.mit.edu>
References: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Feb 21 17:32:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGt1x-0001GP-Pq
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 17:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932833AbaBUQcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 11:32:45 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:46334 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932624AbaBUQcn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Feb 2014 11:32:43 -0500
X-AuditID: 1207440d-f79d86d0000043db-43-53077faa9c9e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 15.C5.17371.AAF77035; Fri, 21 Feb 2014 11:32:42 -0500 (EST)
Received: from michael.fritz.box (p4FDD425E.dip0.t-ipconnect.de [79.221.66.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1LGWAgu026428
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 21 Feb 2014 11:32:41 -0500
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqLuqnj3YYMJGaYuuK91MFg29V5gt
	bq+Yz2wx78ULNosfLT3MDqwef99/YPJ4dqKdzeNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M5Y1LKJveCtYMXFOU2sDYwH+LoYOTkkBEwknuxexgJhi0lcuLeerYuRi0NI4DKjxKU5
	L1ggnONMEjPm/mYCqWIT0JVY1NMMZosI5EhsuXqQEcRmFnCQ2Py5EcwWFvCW6Nq2DcxmEVCV
	eLb+IdgGXgEXid57Z1ghtilItCzbxd7FyMHBKeAq0bHcF8QUAir53FU/gZF3ASPDKka5xJzS
	XN3cxMyc4tRk3eLkxLy81CJdI73czBK91JTSTYyQgOLdwfh/ncwhRgEORiUeXodU9mAh1sSy
	4srcQ4ySHExKorzfa4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHibo4FyvCmJlVWpRfkwKWkO
	FiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJXsY6oEbBotT01Iq0zJwShDQTByfIcC4pkeLU
	vJTUosTSkox4UFzEFwMjAyTFA7TXFqSdt7ggMRcoCtF6ilFRSpxXGuRYAZBERmke3FhYmnjF
	KA70pTCvJEg7DzDFwHW/AhrMBDS4ZCMryOCSRISUVANjd72iyPaNNXPPNmTP0pDbE3YjR+bi
	7rntq97M+Hjq8tr8RrN5Da82ppRNDKrzraqMeXtD6vys0JX79m/2PmI9/10X1/UL3IecU6Ty
	n/xlY336dkf6k6JVZUkv6/1OaC9UXZoTb8IU0eH8bPtu+z9tHgtmBl4rFfz95Nyu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242470>

Give the poor humans some names to help them make sense of things.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 replace_object.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/replace_object.c b/replace_object.c
index cdcaf8c..6fc3ff4 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -3,8 +3,13 @@
 #include "refs.h"
 #include "commit.h"
 
+/*
+ * An array of replacements.  The array is kept sorted by the original
+ * sha1.
+ */
 static struct replace_object {
-	unsigned char sha1[2][20];
+	unsigned char original[20];
+	unsigned char replacement[20];
 } **replace_object;
 
 static int replace_object_alloc, replace_object_nr;
@@ -12,7 +17,7 @@ static int replace_object_alloc, replace_object_nr;
 static const unsigned char *replace_sha1_access(size_t index, void *table)
 {
 	struct replace_object **replace = table;
-	return replace[index]->sha1[0];
+	return replace[index]->original;
 }
 
 static int replace_object_pos(const unsigned char *sha1)
@@ -24,7 +29,7 @@ static int replace_object_pos(const unsigned char *sha1)
 static int register_replace_object(struct replace_object *replace,
 				   int ignore_dups)
 {
-	int pos = replace_object_pos(replace->sha1[0]);
+	int pos = replace_object_pos(replace->original);
 
 	if (0 <= pos) {
 		if (ignore_dups)
@@ -60,14 +65,14 @@ static int register_replace_ref(const char *refname,
 	const char *hash = slash ? slash + 1 : refname;
 	struct replace_object *repl_obj = xmalloc(sizeof(*repl_obj));
 
-	if (strlen(hash) != 40 || get_sha1_hex(hash, repl_obj->sha1[0])) {
+	if (strlen(hash) != 40 || get_sha1_hex(hash, repl_obj->original)) {
 		free(repl_obj);
 		warning("bad replace ref name: %s", refname);
 		return 0;
 	}
 
 	/* Copy sha1 from the read ref */
-	hashcpy(repl_obj->sha1[1], sha1);
+	hashcpy(repl_obj->replacement, sha1);
 
 	/* Register new object */
 	if (register_replace_object(repl_obj, 1))
@@ -107,7 +112,7 @@ const unsigned char *do_lookup_replace_object(const unsigned char *sha1)
 
 		pos = replace_object_pos(cur);
 		if (0 <= pos)
-			cur = replace_object[pos]->sha1[1];
+			cur = replace_object[pos]->replacement;
 	} while (0 <= pos);
 
 	return cur;
-- 
1.8.5.3
