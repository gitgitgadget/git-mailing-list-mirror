From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/4] Add -z option to show-files
Date: Thu, 14 Apr 2005 23:04:12 -0700
Message-ID: <7vis2oo9sz.fsf@assigned-by-dhcp.cox.net>
References: <7vr7hco9z7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 08:01:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMJsy-0004pK-Tl
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 08:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVDOGEZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 02:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVDOGEZ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 02:04:25 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:53971 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261739AbVDOGEP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 02:04:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050415060412.JAIV22013.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Apr 2005 02:04:12 -0400
To: Petr Baudis <pasky@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds NUL-terminated output (-z) to show-files.  This is necessary
for merge-trees script to deal with filenames with embedded newlines.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 show-files.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

Index: show-files.c
===================================================================
--- 6767883b330882bc0e9a7c1e4fd999c0ee97ba3a/show-files.c  (mode:100664 sha1:a9fa6767a418f870a34b39379f417bf37b17ee18)
+++ 21e5e9f7d7dfa81c6519f0204d5a467236c7fdd5/show-files.c  (mode:100664 sha1:c392db8b4edb16675528f86e106e841f42bc74e4)
@@ -14,6 +14,7 @@
 static int show_cached = 0;
 static int show_others = 0;
 static int show_ignored = 0;
+static int line_terminator = '\n';
 
 static const char **dir;
 static int nr_dir;
@@ -105,12 +106,12 @@
 	}
 	if (show_others) {
 		for (i = 0; i < nr_dir; i++)
-			printf("%s\n", dir[i]);
+			printf("%s%c", dir[i], line_terminator);
 	}
 	if (show_cached) {
 		for (i = 0; i < active_nr; i++) {
 			struct cache_entry *ce = active_cache[i];
-			printf("%s\n", ce->name);
+			printf("%s%c", ce->name, line_terminator);
 		}
 	}
 	if (show_deleted) {
@@ -119,7 +120,7 @@
 			struct stat st;
 			if (!stat(ce->name, &st))
 				continue;
-			printf("%s\n", ce->name);
+			printf("%s%c", ce->name, line_terminator);
 		}
 	}
 	if (show_ignored) {
@@ -134,6 +135,11 @@
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
 
+		if (!strcmp(arg, "-z")) {
+			line_terminator = 0;
+			continue;
+		}
+
 		if (!strcmp(arg, "--cached")) {
 			show_cached = 1;
 			continue;

