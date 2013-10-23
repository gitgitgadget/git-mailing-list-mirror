From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/15] ref_remove_duplicates(): simplify function
Date: Wed, 23 Oct 2013 17:50:40 +0200
Message-ID: <1382543448-2586-8-git-send-email-mhagger@alum.mit.edu>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 17:59:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ0q4-0006xj-US
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 17:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496Ab3JWP7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 11:59:10 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:46036 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751709Ab3JWP7J (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Oct 2013 11:59:09 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Oct 2013 11:59:09 EDT
X-AuditID: 1207440c-b7f566d000004272-f4-5267f0a4c4de
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id E9.63.17010.4A0F7625; Wed, 23 Oct 2013 11:52:04 -0400 (EDT)
Received: from localhost.localdomain (p57A247B5.dip0.t-ipconnect.de [87.162.71.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9NFpLt0009100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Oct 2013 11:52:02 -0400
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqLvkQ3qQQeNSU4vpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFocXvFfGaLp52VFvNevGCz+NHSw+zA5fH3/Qcmj0vrXjJ5
	HPozhd3j2Yl2No9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE7o+HdT7aCxfwVp95+ZG9gvMLdxcjJISFgIrH6RysrhC0mceHeerYuRi4OIYHLjBKL9zcx
	QThXmCSWbj3EAlLFJqArsainmQnEFhFQk5jYBhLn4mAWmMgscXz6IrAiYQFHiXVv7rOD2CwC
	qhL/mjcBreDg4BVwlth/Uw3ElBCQk3j4LRakglPAReLC8elgRwgBVUxYOJV9AiPvAkaGVYxy
	iTmlubq5iZk5xanJusXJiXl5qUW6hnq5mSV6qSmlmxghQcuzg/HbOplDjAIcjEo8vBbtaUFC
	rIllxZW5hxglOZiURHnnvEsPEuJLyk+pzEgszogvKs1JLT7EKMHBrCTCu+MuUI43JbGyKrUo
	HyYlzcGiJM6rukTdT0ggPbEkNTs1tSC1CCYrw8GhJMF77D1Qo2BRanpqRVpmTglCmomDE0Rw
	gWzgAdpwDaSQt7ggMbc4Mx2i6BSjopQ4736QhABIIqM0D24ALL28YhQH+keY9yZIFQ8wNcF1
	vwIazAQ0eMqSNJDBJYkIKakGxgI2L1shfv9vxVLmC/3OBh3Mcsv69GXBOzX2rLMMH+aW7/lq
	/+/r53nNyc5eEqWf7U99l+l6yMzxrE7fbpnB09r/zva3PlrbaJ8MDg+44hDV3T/P 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236525>

* Use a dedicated variable, ref, for referring to the current item
  rather than using the ref_map pointer for this purpose.

* Use a (struct ref **) as iteration variable to avoid having to keep
  track of prev and next in addition to the pointer to the current
  item.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 remote.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/remote.c b/remote.c
index a44e897..5ade07f 100644
--- a/remote.c
+++ b/remote.c
@@ -748,29 +748,33 @@ int for_each_remote(each_remote_fn fn, void *priv)
 void ref_remove_duplicates(struct ref *ref_map)
 {
 	struct string_list refs = STRING_LIST_INIT_NODUP;
-	struct string_list_item *item = NULL;
-	struct ref *prev = NULL, *next = NULL;
+	struct ref **p;
 
-	for (; ref_map; prev = ref_map, ref_map = next) {
-		next = ref_map->next;
-		if (!ref_map->peer_ref)
+	for (p = &ref_map; *p; ) {
+		struct ref *ref = *p;
+		struct string_list_item *item;
+
+		if (!ref->peer_ref) {
+			p = &ref->next;
 			continue;
+		}
 
-		item = string_list_insert(&refs, ref_map->peer_ref->name);
+		item = string_list_insert(&refs, ref->peer_ref->name);
 		if (item->util) {
 			/* Entry already existed */
 			if (strcmp(((struct ref *)item->util)->name,
-				   ref_map->name))
+				   ref->name))
 				die("%s tracks both %s and %s",
-				    ref_map->peer_ref->name,
+				    ref->peer_ref->name,
 				    ((struct ref *)item->util)->name,
-				    ref_map->name);
-			prev->next = ref_map->next;
-			free(ref_map->peer_ref);
-			free(ref_map);
-			ref_map = prev; /* skip this; we freed it */
+				    ref->name);
+			/* item is a duplicate; remove and free it */
+			*p = ref->next;
+			free(ref->peer_ref);
+			free(ref);
 		} else {
-			item->util = ref_map;
+			item->util = ref;
+			p = &ref->next;
 		}
 	}
 	string_list_clear(&refs, 0);
-- 
1.8.4
