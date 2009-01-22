From: ecashin@coraid.com
Subject: [PATCH] git-describe documentation: --match pattern is glob
Date: Thu, 22 Jan 2009 11:21:53 -0500
Message-ID: <dfa634dbd8def9e205bbe219217179ca@coraid.com>
Cc: ecashin@coraid.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 22 17:39:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ2av-0003TV-2U
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 17:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753632AbZAVQi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 11:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753575AbZAVQi2
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 11:38:28 -0500
Received: from ns1.coraid.com ([12.51.113.4]:39234 "EHLO coraid.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752571AbZAVQi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 11:38:27 -0500
X-Greylist: delayed 961 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Jan 2009 11:38:27 EST
Received: from kokone.coraid.com ([68.16.104.79]) by coraid.com; Thu Jan 22 11:21:53 EST 2009
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106762>

I finally took a few minutes to figure out what kind of pattern
specification the "--match" option to git-describe expects.  I
think it would be helpful to mention it explicitly in the manpage
so that trial and error isn't the only recourse for git-describe
users.

It seemed a bit weird to use "torvalds@g5" in the examples,
but I guess it's good to be consistent.


commit 0cbed245ca2812cb7708d9d97a8b5092a8b22b73
Author: Ed L. Cashin <ecashin@coraid.com>
Date:   Thu Jan 22 11:09:22 2009 -0500

    mention what kind of pattern the --match option expects
    
    It wasn't clear whether the --match option expects a regular
    expression or some other kind of pattern specification.

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index a99b4ef..92a7995 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -73,7 +73,8 @@ OPTIONS
 
 --match <pattern>::
 	Only consider tags matching the given pattern (can be used to avoid
-	leaking private tags made from the repository).
+	leaking private tags made from the repository).  The pattern
+	syntax is similar to shell globbing.
 
 --always::
 	Show uniquely abbreviated commit object as fallback.
@@ -117,6 +118,21 @@ closest tagname without any suffix:
 	[torvalds@g5 git]$ git describe --abbrev=0 v1.0.5^2
 	tags/v1.0.0
 
+When multiple trees are being tracked, --match can specify which tags
+are interesting.  I see that a certain commit appeared first in a
+linux-next release, because I am tracking the linux-next tree as a
+remote:
+
+	[torvalds@g5 linux-2.6]$ git describe --contains 9514dff9
+	next-20080623~13^2~72
+
+But since I really want to know the first mainline release containing
+the commit, I use --match to get those results:
+
+	[torvalds@g5 linux-2.6]$ git describe --contains --match 'v*' 9514dff9
+	v2.6.27-rc1~1103^2~85
+
+
 SEARCH STRATEGY
 ---------------
 
