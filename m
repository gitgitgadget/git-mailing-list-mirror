From: mhagger@alum.mit.edu
Subject: [PATCH 11/17] filter_refs(): do not leave gaps in return_refs
Date: Thu, 23 Aug 2012 10:10:36 +0200
Message-ID: <1345709442-16046-12-git-send-email-mhagger@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:19:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4SdP-0000rv-9t
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933722Ab2HWITC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:19:02 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:52683 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933708Ab2HWISx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 04:18:53 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Aug 2012 04:18:44 EDT
X-AuditID: 1207440f-b7fde6d00000095c-1f-5035e5b4ff12
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 3A.11.02396.4B5E5305; Thu, 23 Aug 2012 04:11:32 -0400 (EDT)
Received: from michael.fritz.box (p57A2588E.dip.t-dialin.net [87.162.88.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7N8AkVB030408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 Aug 2012 04:11:30 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsUixO6iqLvlqWmAwfyL7BZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujE2zu5gK
	+vkrui52MDUwHubuYuTkkBAwkbh08zkThC0mceHeerYuRi4OIYHLjBLXtyxjhHDOMklMOXSB
	DaSKTUBK4mVjDzuILSKgJjGx7RALiM0skCLR8bybEcQWFnCTWH9hPlg9i4CqxNUDh8FsXgFX
	iUmdp1kgtilK/Pi+hhnE5gSKL/i+CaxXSMBF4mPjTeYJjLwLGBlWMcol5pTm6uYmZuYUpybr
	Ficn5uWlFuma6OVmluilppRuYoQEEP8Oxq71MocYBTgYlXh4X5ibBgixJpYVV+YeYpTkYFIS
	5f33CCjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhDd8HlCONyWxsiq1KB8mJc3BoiTOq75E3U9I
	ID2xJDU7NbUgtQgmK8PBoSTBe+cJUKNgUWp6akVaZk4JQpqJgxNEcIFs4AHa8BSkkLe4IDG3
	ODMdougUo6KUOO9JkIQASCKjNA9uACzWXzGKA/0jzHsOpIoHmCbgul8BDWYCGqx21RhkcEki
	QkqqgdFAu3N3RkWp87efZW4GT8+4JDW3bHU6KCByT1otI/qN+JHN2x48LV7wnzOAf2NkwFnT
	Jc4fT3Upu9TEMLw947TozeM36/vMjqv/Xt42UzIl7sKUh4c3a6s9da2QORDscUZ4fdS32c/j
	NeVLdjfuahL4o+ml2u37PGj+hk2Tzyc6PIi5kTlL1ViJpTgj0VCLuag4EQBNpvpb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204127>

From: Michael Haggerty <mhagger@alum.mit.edu>

It used to be that this function processed refnames in some arbitrary
order but wanted to return them in the order that they were requested,
not the order that they were processed.  Now, the refnames are
processed in sorted order, so there is no reason to go to the extra
effort.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 9398059..8366012 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -527,14 +527,13 @@ static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
 	struct ref *newlist = NULL;
 	struct ref **newtail = &newlist;
 	struct ref *ref, *next;
-	int match_pos;
+	int match_pos = 0, matched = 0;
 
 	if (*nr_heads && !args.fetch_all)
 		return_refs = xcalloc(*nr_heads, sizeof(struct ref *));
 	else
 		return_refs = NULL;
 
-	match_pos = 0;
 	for (ref = *refs; ref; ref = next) {
 		next = ref->next;
 		if (!memcmp(ref->name, "refs/", 5) &&
@@ -554,7 +553,7 @@ static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
 				if (cmp < 0) /* definitely do not have it */
 					break;
 				else if (cmp == 0) { /* definitely have it */
-					return_refs[match_pos] = ref;
+					return_refs[matched++] = ref;
 					heads[match_pos++][0] = '\0';
 					break;
 				}
@@ -569,13 +568,11 @@ static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
 
 	if (!args.fetch_all) {
 		int i;
-		for (i = 0; i < *nr_heads; i++) {
+		for (i = 0; i < matched; i++) {
 			ref = return_refs[i];
-			if (ref) {
-				*newtail = ref;
-				ref->next = NULL;
-				newtail = &ref->next;
-			}
+			*newtail = ref;
+			ref->next = NULL;
+			newtail = &ref->next;
 		}
 		free(return_refs);
 	}
-- 
1.7.11.3
