From: Timo Hirvonen <tihirvon@ee.oulu.fi>
Subject: [PATCH] Use ntohs instead of htons to convert ce_flags to host byte
 order
Date: Tue, 07 Jun 2005 20:35:56 +0000
Message-ID: <1118176556l.5398l.1l@garlic>
References: <1118098966l.5384l.0l@garlic>
 <Pine.LNX.4.58.0506061858140.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 22:36:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfkkU-0004RT-OT
	for gcvg-git@gmane.org; Tue, 07 Jun 2005 22:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVFGUgS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Jun 2005 16:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVFGUgS
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jun 2005 16:36:18 -0400
Received: from marski.suomi.net ([212.50.131.142]:14001 "EHLO marski.suomi.net")
	by vger.kernel.org with ESMTP id S261977AbVFGUgA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2005 16:36:00 -0400
Received: from spam2.suomi.net (spam2.suomi.net [212.50.131.166])
 by marski.suomi.net (Sun Java System Messaging Server 6.2 (built Dec  2 2004))
 with ESMTP id <0IHQ00IP6EDXOY50@marski.suomi.net> for git@vger.kernel.org;
 Tue, 07 Jun 2005 23:32:21 +0300 (EEST)
Received: from garlic (addr-82-128-203-168.suomi.net [82.128.203.168])
	by spam2.suomi.net (Postfix) with ESMTP id 4009F115063; Tue,
 07 Jun 2005 23:35:57 +0300 (EEST)
In-reply-to: <Pine.LNX.4.58.0506061858140.1876@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Balsa 2.2.6
Content-disposition: inline
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Not virus scanned: please contact OPOY for details
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4.717,	required 5,
 autolearn=not spam, AWL 0.18, BAYES_00 -4.90)
X-MailScanner-From: tihirvon@ee.oulu.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Use ntohs instead of htons to convert ce_flags to host byte order

---
commit f827ec4fa1be102bda5b92edbf380defa03e8ae2
tree 735922d31ccdc6a2dc1f8e3f1388445903542385
parent fd787bb8d89cdacedc16cfef9dc4feb0cf843def
author Timo Hirvonen <tihirvon@ee.oulu.fi> Tue, 07 Jun 2005 23:18:02 +0300
committer Timo Hirvonen <tihirvon@ee.oulu.fi> Tue, 07 Jun 2005 23:18:02 +0300

 read-cache.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ -132,7 +132,7 @@ int cache_name_pos(const char *name, int
 	while (last > first) {
 		int next = (last + first) >> 1;
 		struct cache_entry *ce = active_cache[next];
-		int cmp = cache_name_compare(name, namelen, ce->name, htons(ce->ce_flags));
+		int cmp = cache_name_compare(name, namelen, ce->name, ntohs(ce->ce_flags));
 		if (!cmp)
 			return next;
 		if (cmp < 0) {
@@ -206,7 +206,7 @@ static int check_file_directory_conflict
 		*ep = 0;    /* first cut it at slash */
 		len = ep - pathbuf;
 		pos = cache_name_pos(pathbuf,
-				     htons(create_ce_flags(len, stage)));
+				     ntohs(create_ce_flags(len, stage)));
 		if (0 <= pos) {
 			/* Our leading path component is registered as a file,
 			 * and we are trying to make it a directory.  This is
@@ -230,7 +230,7 @@ static int check_file_directory_conflict
 	 * a directory there?
 	 */
 	pos = cache_name_pos(path,
-			     htons(create_ce_flags(namelen, stage)));
+			     ntohs(create_ce_flags(namelen, stage)));
 
 	/* (0 <= pos) cannot happen because add_cache_entry()
 	 * should have taken care of that case.
@@ -279,7 +279,7 @@ int add_cache_entry(struct cache_entry *
 	int pos;
 	int ok_to_add = option & ADD_CACHE_OK_TO_ADD;
 	int ok_to_replace = option & ADD_CACHE_OK_TO_REPLACE;
-	pos = cache_name_pos(ce->name, htons(ce->ce_flags));
+	pos = cache_name_pos(ce->name, ntohs(ce->ce_flags));
 
 	/* existing match? Just replace it */
 	if (pos >= 0) {
@@ -307,7 +307,7 @@ int add_cache_entry(struct cache_entry *
 	if (check_file_directory_conflict(ce, ok_to_replace)) {
 		if (!ok_to_replace)
 			return -1;
-		pos = cache_name_pos(ce->name, htons(ce->ce_flags));
+		pos = cache_name_pos(ce->name, ntohs(ce->ce_flags));
 		pos = -pos-1;
 	}
 



