From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 01/21] git p4: temp branch name should use / even on windows
Date: Sat, 26 Jan 2013 22:11:04 -0500
Message-ID: <1359256284-5660-2-git-send-email-pw@padd.com>
References: <1359256284-5660-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 04:12:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzIfE-0004K7-Cb
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401Ab3A0DLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:11:48 -0500
Received: from honk.padd.com ([74.3.171.149]:58686 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755361Ab3A0DLr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:11:47 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id E751E2F3F;
	Sat, 26 Jan 2013 19:11:46 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 2084722838; Sat, 26 Jan 2013 22:11:44 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.gf5c753f
In-Reply-To: <1359256284-5660-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214651>

Commit fed2369 (git-p4: Search for parent commit on branch creation,
2012-01-25) uses temporary branches to help find the parent of a
new p4 branch.  The temp branches are of the form "git-p4-tmp/%d"
for some p4 change number.  Mistakenly, this string was made
using os.path.join() instead of just string concatenation.  On
windows, this turns into a backslash (\), which is not allowed in
git branch names.

Reported-by: Casey McGinty <casey.mcginty@gmail.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 2da5649..fb77c56 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2687,7 +2687,7 @@ class P4Sync(Command, P4UserMap):
 
                         blob = None
                         if len(parent) > 0:
-                            tempBranch = os.path.join(self.tempBranchLocation, "%d" % (change))
+                            tempBranch = "%s/%d" % (self.tempBranchLocation, change)
                             if self.verbose:
                                 print "Creating temporary branch: " + tempBranch
                             self.commit(description, filesForCommit, tempBranch)
-- 
1.8.1.1.460.g6fa8886
