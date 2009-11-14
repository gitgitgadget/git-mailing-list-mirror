From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH] cvsserver doc: database generally can not be reproduced consistently
Date: Sat, 14 Nov 2009 11:39:36 -0700
Message-ID: <1258223976-4044-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Nov 14 19:46:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9NdV-00016N-QN
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 19:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbZKNSqC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 13:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbZKNSqB
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 13:46:01 -0500
Received: from qmta15.emeryville.ca.mail.comcast.net ([76.96.27.228]:33567
	"EHLO QMTA15.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751192AbZKNSqB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Nov 2009 13:46:01 -0500
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Nov 2009 13:46:00 EST
Received: from OMTA05.emeryville.ca.mail.comcast.net ([76.96.30.43])
	by QMTA15.emeryville.ca.mail.comcast.net with comcast
	id 56Vu1d0080vp7WLAF6gMTF; Sat, 14 Nov 2009 18:40:21 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA05.emeryville.ca.mail.comcast.net with comcast
	id 56gL1d00A5FCJCg8R6gLke; Sat, 14 Nov 2009 18:40:21 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id 0E63189114;
	Sat, 14 Nov 2009 11:40:19 -0700 (MST)
X-Mailer: git-send-email 1.6.4.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132879>

A regenerated git-cvsserver database is at risk of having different
CVS revision numbers from an incrementally updated database.  Mention
this in the the documentation, and remove an erroneous statement
to the contrary.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 Documentation/git-cvsserver.txt |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 785779e..99a7c14 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -182,10 +182,9 @@ Database Backend
 ----------------
 
 'git-cvsserver' uses one database per git head (i.e. CVS module) to
-store information about the repository for faster access. The
-database doesn't contain any persistent data and can be completely
-regenerated from the git repository at any time. The database
-needs to be updated (i.e. written to) after every commit.
+store information about the repository to maintain consistent
+CVS revision numbers. The database needs to be
+updated (i.e. written to) after every commit.
 
 If the commit is done directly by using `git` (as opposed to
 using 'git-cvsserver') the update will need to happen on the
@@ -204,6 +203,18 @@ write so it might not be enough to grant the users using
 'git-cvsserver' write access to the database file without granting
 them write access to the directory, too.
 
+The database can not be reliably regenerated in a
+consistent form after the branch it is tracking has changed.
+Example: For merged branches, 'git-cvsserver' only tracks
+one branch of development, and after a 'git-merge' an
+incrementally updated database may track a different branch
+than a database regenerated from scratch, causing inconsistent
+CVS revision numbers. `git-cvsserver` has no way of knowing which
+branch it would have picked if it had been run incrementally
+pre-merge. So if you have to fully or partially (from old
+backup) regenerate the database, you should be suspicious
+of pre-existing CVS sandboxes.
+
 You can configure the database backend with the following
 configuration variables:
 
-- 
1.6.4.GIT
