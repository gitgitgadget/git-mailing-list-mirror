From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 20/23] ref_remove_duplicates(): simplify loop logic
Date: Wed, 30 Oct 2013 06:33:09 +0100
Message-ID: <1383111192-23780-21-git-send-email-mhagger@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 06:41:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOXJ-0007RQ-C6
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089Ab3J3Flm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:41:42 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:44736 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752796Ab3J3Fll (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:41:41 -0400
X-AuditID: 1207440c-b7f566d000004272-0b-52709a6f9dd5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 53.A8.17010.F6A90725; Wed, 30 Oct 2013 01:34:39 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbIV014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:34:37 -0400
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqJs/qyDI4MUCQYvpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFocXvFfGaLp52VFvNevGCz+NHSw+zA5fH3/Qcmj0vrXjJ5
	HPozhd3j2Yl2No9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE7Y1v/NtaCm7IVrQcuszQwThbvYuTkkBAwkZiztYcRwhaTuHBvPVsXIxeHkMBlRonWrWcY
	IZwrTBILbqxnAqliE9CVWNTTDGaLCKhJTGw7xAJSxCwwkVni+PRFQA4Hh7CAm8Tl1QogNSwC
	qhILnn5nB7F5BVwldt7YDbVNQeJG81RWEJsTKP5p102wGiEBF4mm9s/sExh5FzAyrGKUS8wp
	zdXNTczMKU5N1i1OTszLSy3SNdTLzSzRS00p3cQICVueHYzf1skcYhTgYFTi4TV4kB8kxJpY
	VlyZe4hRkoNJSZQ3bUpBkBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3unHgcp5UxIrq1KL8mFS
	0hwsSuK8qkvU/YQE0hNLUrNTUwtSi2CyMhwcShK8yjOBhgoWpaanVqRl5pQgpJk4OEEEF8gG
	HqANPCCFvMUFibnFmekQRacYFaXEeZNAEgIgiYzSPLgBsATzilEc6B9hiHYeYHKC634FNJgJ
	aPAeljyQwSWJCCmpBsae/+01/D8lAkrm9RoE62t9rDU/vSHB1sAze1bMI6Xrr9KMl03X+3Vw
	jdfqe7LlNSwexU+10zZZrV+8wPnh2V87F/+bs/zYlKTNP9n/XhD13JqW/6arpkGi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236971>

Change the loop body into the more straightforward

* remove item from the front of the old list
* if necessary, add it to the tail of the new list

and return a pointer to the new list (even though it is currently
always the same as the input argument, because the first element in
the list is currently never deleted).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch.c |  4 +---
 remote.c        | 52 +++++++++++++++++++++++++++++++---------------------
 remote.h        |  8 ++++++--
 3 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5ddb9af..3d978eb 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -360,9 +360,7 @@ static struct ref *get_ref_map(struct transport *transport,
 		tail = &rm->next;
 	}
 
-	ref_remove_duplicates(ref_map);
-
-	return ref_map;
+	return ref_remove_duplicates(ref_map);
 }
 
 #define STORE_REF_ERROR_OTHER 1
diff --git a/remote.c b/remote.c
index 15f3dc5..c90a2bf 100644
--- a/remote.c
+++ b/remote.c
@@ -745,35 +745,45 @@ int for_each_remote(each_remote_fn fn, void *priv)
 	return result;
 }
 
-void ref_remove_duplicates(struct ref *ref_map)
+struct ref *ref_remove_duplicates(struct ref *ref_map)
 {
 	struct string_list refs = STRING_LIST_INIT_NODUP;
-	struct string_list_item *item = NULL;
-	struct ref *prev = NULL, *next = NULL;
+	struct ref *retval = NULL;
+	struct ref **p = &retval;
 
-	for (; ref_map; prev = ref_map, ref_map = next) {
-		next = ref_map->next;
-		if (!ref_map->peer_ref)
-			continue;
+	while (ref_map) {
+		struct ref *ref = ref_map;
+
+		ref_map = ref_map->next;
+		ref->next = NULL;
 
-		item = string_list_insert(&refs, ref_map->peer_ref->name);
-		if (item->util) {
-			/* Entry already existed */
-			if (strcmp(((struct ref *)item->util)->name,
-				   ref_map->name))
-				die("%s tracks both %s and %s",
-				    ref_map->peer_ref->name,
-				    ((struct ref *)item->util)->name,
-				    ref_map->name);
-			prev->next = ref_map->next;
-			free(ref_map->peer_ref);
-			free(ref_map);
-			ref_map = prev; /* skip this; we freed it */
+		if (!ref->peer_ref) {
+			*p = ref;
+			p = &ref->next;
 		} else {
-			item->util = ref_map;
+			struct string_list_item *item =
+				string_list_insert(&refs, ref->peer_ref->name);
+
+			if (item->util) {
+				/* Entry already existed */
+				if (strcmp(((struct ref *)item->util)->name,
+					   ref->name))
+					die("%s tracks both %s and %s",
+					    ref->peer_ref->name,
+					    ((struct ref *)item->util)->name,
+					    ref->name);
+				free(ref->peer_ref);
+				free(ref);
+			} else {
+				*p = ref;
+				p = &ref->next;
+				item->util = ref;
+			}
 		}
 	}
+
 	string_list_clear(&refs, 0);
+	return retval;
 }
 
 int remote_has_url(struct remote *remote, const char *url)
diff --git a/remote.h b/remote.h
index 131130a..c07eb99 100644
--- a/remote.h
+++ b/remote.h
@@ -149,9 +149,13 @@ int resolve_remote_symref(struct ref *ref, struct ref *list);
 int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1);
 
 /*
- * Removes and frees any duplicate refs in the map.
+ * Remove and free all but the first of any entries in the input list
+ * that map the same remote reference to the same local reference.  If
+ * there are two entries that map different remote references to the
+ * same local reference, emit an error message and die.  Return a
+ * pointer to the head of the resulting list.
  */
-void ref_remove_duplicates(struct ref *ref_map);
+struct ref *ref_remove_duplicates(struct ref *ref_map);
 
 int valid_fetch_refspec(const char *refspec);
 struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
-- 
1.8.4.1
