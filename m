From: Peter Krefting <peter@softwolves.pp.se>
Subject: [GIT-GUI PATCH] Correctly launch gitk for branch whose name matches a
 local file
Date: Thu, 21 Jan 2010 13:15:17 +0100
Message-ID: <20100121121848.BE37D2FC47@perkele>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 21 14:18:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXww5-0001Jq-1m
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 14:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575Ab0AUNSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 08:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800Ab0AUNSx
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 08:18:53 -0500
Received: from smtp.getmail.no ([84.208.15.66]:56566 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751514Ab0AUNSx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2010 08:18:53 -0500
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jan 2010 08:18:52 EST
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWL002H5JJD8JD0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Jan 2010 13:18:49 +0100 (MET)
Received: from perkele ([84.215.142.63]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWL001TIJJDP240@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Jan 2010 13:18:49 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.21.120919
Received: by perkele (Postfix, from userid 501)	id BE37D2FC47; Thu,
 21 Jan 2010 13:18:48 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137654>

When trying to run gitk on a branch name whose name matches a local file,
it will toss an error saying that the name is ambiguous. Adding a pair
of dashes will make gitk parse the options to the left of it as branch
names. Since wish eats the first pair of dashes we throw at it, we need
to add a second one to ensure they get through.

Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
---
 git-gui.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Reproducible test case:

1. git clone git://git.debian.org/users/peterk/lyskom-server.git
2. cd lyskom-server
3. git gui + "Visualize debian's history"

diff --git a/git-gui.sh b/git-gui.sh
index 822d598..2114945 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1941,7 +1941,7 @@ proc do_gitk {revs} {
 		cd [file dirname [gitdir]]
 		set env(GIT_DIR) [file tail [gitdir]]
 
-		eval exec $cmd $revs &
+		eval exec $cmd $revs "--" "--" &
 
 		if {$old_GIT_DIR eq {}} {
 			unset env(GIT_DIR)
-- 
1.6.6
