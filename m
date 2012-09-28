From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 01/21] git p4: temp branch name should use / even on windows
Date: Fri, 28 Sep 2012 08:04:05 -0400
Message-ID: <1348833865-6093-2-git-send-email-pw@padd.com>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 14:04:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZJR-0000z7-VM
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046Ab2I1MEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:04:49 -0400
Received: from honk.padd.com ([74.3.171.149]:34952 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753574Ab2I1MEs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:04:48 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 5BE645AF2;
	Fri, 28 Sep 2012 05:04:48 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 0A8AE31413; Fri, 28 Sep 2012 08:04:45 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.457.g468b3ef
In-Reply-To: <1348833865-6093-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206558>

Commit fed2369 (git-p4: Search for parent commit on branch creation,
2012-01-25) uses temporary branches to help find the parent of a
new p4 branch.  The temp branches are of the form "git-p4-tmp/%d"
for some p4 change number.  Mistakenly, this string was made
using os.path.join() instead of just string concatenation.  On
windows, this turns into a backslash (\), which is not allowed in
git branch names.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 882b1bb..1e7a22a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2599,7 +2599,7 @@ class P4Sync(Command, P4UserMap):
 
                         blob = None
                         if len(parent) > 0:
-                            tempBranch = os.path.join(self.tempBranchLocation, "%d" % (change))
+                            tempBranch = "%s/%d" % (self.tempBranchLocation, change)
                             if self.verbose:
                                 print "Creating temporary branch: " + tempBranch
                             self.commit(description, filesForCommit, tempBranch)
-- 
1.7.12.1.403.g28165e1
