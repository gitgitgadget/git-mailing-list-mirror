From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-clone-pack: do not silently overwrite an existing branch
 'origin'
Date: Thu, 22 Dec 2005 18:59:30 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512221859110.20025@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Dec 22 18:59:39 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpUj1-0004gB-In
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 18:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbVLVR7d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 12:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbVLVR7c
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 12:59:32 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:51613 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030233AbVLVR7c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 12:59:32 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2ACFE13C144; Thu, 22 Dec 2005 18:59:31 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id EF3D49E3A1; Thu, 22 Dec 2005 18:59:30 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B76F99E231; Thu, 22 Dec 2005 18:59:30 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A2D7813C144; Thu, 22 Dec 2005 18:59:30 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13960>


When cloning a repository which already contains a branch called 'origin',
do not silently overwrite it with the remote 'master' ref.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	This happened to me with a project I track via git-cvsimport.
	The clone strangely suffered a time warp ;-)

 git-clone.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

f0d4ef72573488410a1e8eb0198e347630d6e2c9
diff --git a/git-clone.sh b/git-clone.sh
index 280cc2e..e988964 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -204,6 +204,10 @@ then
 	head_points_at=`git-symbolic-ref HEAD`
 	case "$head_points_at" in
 	refs/heads/*)
+		if test -e .git/refs/heads/origin; then
+			chmod a-w .git/refs/heads/origin
+			echo "Warning: branch 'origin' exists already"
+		fi
 		head_points_at=`expr "$head_points_at" : 'refs/heads/\(.*\)'`
 		mkdir -p .git/remotes &&
 		echo >.git/remotes/origin \
-- 
1.0.0
