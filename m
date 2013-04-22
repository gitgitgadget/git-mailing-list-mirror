From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 03/33] refs: document do_for_each_ref() and do_one_ref()
Date: Mon, 22 Apr 2013 21:52:11 +0200
Message-ID: <1366660361-21831-4-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:53:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMnw-0004QV-56
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078Ab3DVTxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:53:34 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:49126 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755034Ab3DVTxc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 15:53:32 -0400
X-AuditID: 12074411-b7f286d0000008e8-e5-5175953cae0e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 8C.6A.02280.C3595715; Mon, 22 Apr 2013 15:53:32 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOG008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:30 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqGsztTTQYH8ri0XXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGcsb/nAVvCYu2Lh4yksDYx7
	ObsYOTkkBEwk1j86xQZhi0lcuLceyObiEBK4zChxfNF9KOcCk8S5h7dYQarYBHQlFvU0M4HY
	IgJqEhPbDrGA2MwCDhKbPzcygtjCAt4SUy93gNWwCKhK/Dx2HCzOK+AiMf3SJqhtChLHt28D
	i3MKuEqc7jgBNkcIqGbFwaksExh5FzAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdXLzSzR
	S00p3cQICRbBHYwzTsodYhTgYFTi4RVwLw0UYk0sK67MPcQoycGkJMrLMQUoxJeUn1KZkVic
	EV9UmpNafIhRgoNZSYRXNB8ox5uSWFmVWpQPk5LmYFES5+Vbou4nJJCeWJKanZpakFoEk5Xh
	4FCS4M0AGSpYlJqeWpGWmVOCkGbi4AQRXCAbeIA2RIIU8hYXJOYWZ6ZDFJ1iVJQS562eBJQQ
	AElklObBDYDF9StGcaB/hHk9QNp5gCkBrvsV0GAmoMGZCSUgg0sSEVJSDYxbXQ4sMnoV5MFc
	znTiqM2EDUH7z5o84pXhEjURXnf6zlWDz87HN+tNb+pPDZ346A7jIauDH27+CVQ8lOOiybSq
	+NjC0FUn/VUiulIid19b0DShb/Yy9gN/5/wzX5OzTXrK1YtbPuyO3NHX7Pzpwhbu/6zLPdn2
	7xTirPq9uGS7xKxb7GW32zznKbEUZyQaajEXFScCAK8MGOTGAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222053>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 1df1ccd..44cc2fc 100644
--- a/refs.c
+++ b/refs.c
@@ -525,10 +525,14 @@ static void sort_ref_dir(struct ref_dir *dir)
 	dir->sorted = dir->nr = i;
 }
 
-#define DO_FOR_EACH_INCLUDE_BROKEN 01
+/* Include broken references in a do_for_each_ref*() iteration: */
+#define DO_FOR_EACH_INCLUDE_BROKEN 0x01
 
 static struct ref_entry *current_ref;
 
+/*
+ * Handle one reference in a do_for_each_ref*()-style iteration.
+ */
 static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 		      int flags, void *cb_data, struct ref_entry *entry)
 {
@@ -1338,6 +1342,15 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
 
+/*
+ * Call fn for each reference in the specified submodule for which the
+ * refname begins with base.  If trim is non-zero, then trim that many
+ * characters off the beginning of each refname before passing the
+ * refname to fn.  flags can be DO_FOR_EACH_INCLUDE_BROKEN to include
+ * broken references in the iteration.  If fn ever returns a non-zero
+ * value, stop the iteration and return that value; otherwise, return
+ * 0.
+ */
 static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn fn,
 			   int trim, int flags, void *cb_data)
 {
-- 
1.8.2.1
