From: Anton Gyllenberg <anton@iki.fi>
Subject: [PATCH] gitview: import only one of gtksourceview and gtksourceview2
Date: Mon, 19 Nov 2007 12:37:16 +0200
Message-ID: <1195468636-3468-1-git-send-email-anton@iki.fi>
Cc: Anton Gyllenberg <anton@iki.fi>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 19 11:52:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu4Et-0002pl-V1
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 11:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbXKSKwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 05:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbXKSKwJ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 05:52:09 -0500
Received: from [194.215.226.66] ([194.215.226.66]:53426 "EHLO
	titanium.secgo.net" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751638AbXKSKwI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 05:52:08 -0500
X-Greylist: delayed 985 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Nov 2007 05:52:08 EST
Received: from localhost.localdomain ([192.168.128.106]) by titanium.secgo.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 19 Nov 2007 12:37:28 +0200
X-Mailer: git-send-email 1.5.3.2
X-OriginalArrivalTime: 19 Nov 2007 10:37:28.0671 (UTC) FILETIME=[2EAF86F0:01C82A98]
X-CT-RefID: str=0001.0A0B0201.47416527.00F1,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65423>

Importing both gtksourceview and gtksourceview2 will make python segfault
on my system (ubuntu 7.10). Change so that gtksourceview is only imported
if importing gtksourceview2 fails. This should be safe as gtksourceview
is only used if gtksourceview2 is not available.

Signed-off-by: Anton Gyllenberg <anton@iki.fi>
---
 contrib/gitview/gitview |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 449ee69..4c99dfb 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -27,20 +27,17 @@ import math
 import string
 import fcntl
 
+have_gtksourceview2 = False
+have_gtksourceview = False
 try:
     import gtksourceview2
     have_gtksourceview2 = True
 except ImportError:
-    have_gtksourceview2 = False
-
-try:
-    import gtksourceview
-    have_gtksourceview = True
-except ImportError:
-    have_gtksourceview = False
-
-if not have_gtksourceview2 and not have_gtksourceview:
-    print "Running without gtksourceview2 or gtksourceview module"
+    try:
+        import gtksourceview
+        have_gtksourceview = True
+    except ImportError:
+        print "Running without gtksourceview2 or gtksourceview module"
 
 re_ident = re.compile('(author|committer) (?P<ident>.*) (?P<epoch>\d+) (?P<tz>[+-]\d{4})')
 
-- 
1.5.3.2
