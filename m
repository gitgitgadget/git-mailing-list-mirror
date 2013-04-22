From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 28/33] refs: inline function do_not_prune()
Date: Mon, 22 Apr 2013 21:52:36 +0200
Message-ID: <1366660361-21831-29-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 22:01:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMw0-0007GU-6e
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 22:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164Ab3DVUBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 16:01:43 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:63504 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755044Ab3DVUBh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 16:01:37 -0400
X-AuditID: 12074412-b7f216d0000008d4-74-5175955f10fe
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 72.8F.02260.F5595715; Mon, 22 Apr 2013 15:54:07 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOf008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:54:06 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqBs/tTTQoP2XuEXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGds3XyFuWACV8XPs9uYGxin
	cHQxcnJICJhI7Fq+lxnCFpO4cG89WxcjF4eQwGVGiaOLmqGcC0wSHx5uAKtiE9CVWNTTzARi
	iwioSUxsO8QCYjMLOEhs/tzICGILC9hJdL67ABZnEVCVOLj9JTuIzSvgKnHnVxcLxDYFiePb
	t4HVcwLFT3ecAIsLCbhIrDg4lWUCI+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbpmermZ
	JXqpKaWbGCHBIrSDcf1JuUOMAhyMSjy8Au6lgUKsiWXFlbmHGCU5mJREeTmmAIX4kvJTKjMS
	izPii0pzUosPMUpwMCuJ8IrmA+V4UxIrq1KL8mFS0hwsSuK8Pxer+wkJpCeWpGanphakFsFk
	ZTg4lCR4v00GahQsSk1PrUjLzClBSDNxcIIILpANPEAb5EG28xYXJOYWZ6ZDFJ1iVJQS53Wb
	BJQQAElklObBDYDF9StGcaB/hHn5QNp5gCkBrvsV0GAmoMGZCSUgg0sSEVJSDYzsO1QkCyb5
	y27/0KDefuGhCkeotUybnatn1eZnZ5vtItz65XdpSd9yuLz+pu6kBuG09d+X16Vef30tN8vj
	suyB22eeH8qwm5FomLbWMzdZfrm4/z65Q68kdu9JSC+Jf8K+jJlnxoOZ++NTtTpO901uNdQ1
	skhw9Z020X/pLv9HeWbO/P1hM5VYijMSDbWYi4oTAXsXcWLGAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222077>

Function do_not_prune() was redundantly checking REF_ISSYMREF, which
was already tested at the top of pack_one_ref(), so remove that check.
And the rest was trivial, so inline the function.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 88875d1..f78e955 100644
--- a/refs.c
+++ b/refs.c
@@ -1995,14 +1995,6 @@ struct pack_refs_cb_data {
 	FILE *refs_file;
 };
 
-static int do_not_prune(int flags)
-{
-	/* If it is already packed or if it is a symref,
-	 * do not prune it.
-	 */
-	return (flags & (REF_ISSYMREF|REF_ISPACKED));
-}
-
 static int pack_one_ref(struct ref_entry *entry, void *cb_data)
 {
 	struct pack_refs_cb_data *cb = cb_data;
@@ -2030,7 +2022,8 @@ static int pack_one_ref(struct ref_entry *entry, void *cb_data)
 				sha1_to_hex(o->sha1));
 	}
 
-	if ((cb->flags & PACK_REFS_PRUNE) && !do_not_prune(entry->flag)) {
+	/* If the ref was already packed, there is no need to prune it. */
+	if ((cb->flags & PACK_REFS_PRUNE) && !(entry->flag & REF_ISPACKED)) {
 		int namelen = strlen(entry->name) + 1;
 		struct ref_to_prune *n = xcalloc(1, sizeof(*n) + namelen);
 		hashcpy(n->sha1, entry->u.value.sha1);
-- 
1.8.2.1
