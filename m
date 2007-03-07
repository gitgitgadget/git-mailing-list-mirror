From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: [PATCH] git-gui: '/dev/null' on Windows is named 'nul'
Date: Wed, 07 Mar 2007 17:26:34 +0100
Organization: eudaptics software gmbh
Message-ID: <45EEE7BA.E0603922@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 07 17:24:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOyvw-0003ah-LM
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 17:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbXCGQYF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 11:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbXCGQYF
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 11:24:05 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160]:21339 "EHLO
	linz.eudaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbXCGQYE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 11:24:04 -0500
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0038554D; Wed,  7 Mar 2007 17:24:02 +0100 (CET)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41672>

From: Johannes Sixt <johannes.sixt@telecom.at>

Making (or amending) an initial commit on Windows fails because
redirecting something to '/dev/null' must fail - this device does not exist.
Redirect to 'nul' instead.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 I've noticed this while using the MinGW port, but I do not know whether
 this is needed or even works on Cygwin.

 (Now lets see whether my MUA wraps long lines...)

 -- Hannes

 git-gui/git-gui.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index f84ba33..971d5fe 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1288,7 +1288,11 @@ proc commit_committree {fd_wt curHEAD msg} {
 		}
 	} else {
 		# git commit-tree writes to stderr during initial commit.
-		lappend cmd 2>/dev/null
+		if {[is_Windows]} {
+			lappend cmd 2>nul
+		} else {
+			lappend cmd 2>/dev/null
+		}
 	}
 	lappend cmd <$msg_p
 	if {[catch {set cmt_id [eval exec $cmd]} err]} {
-- 
1.5.0.2.279.g4808
