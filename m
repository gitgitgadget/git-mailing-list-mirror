From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [GIT GUI PATCH] git-gui: fix open explorer window on Windows 7
Date: Tue, 23 Feb 2010 23:52:45 +0100
Message-ID: <20100223225243.GC11271@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 23:53:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk3ca-0001vs-UB
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 23:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512Ab0BWWws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 17:52:48 -0500
Received: from darksea.de ([83.133.111.250]:41970 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754259Ab0BWWwr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 17:52:47 -0500
Received: (qmail 17587 invoked from network); 23 Feb 2010 23:52:45 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 23 Feb 2010 23:52:45 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140859>

It seems that Windows 7's explorer is not capable to cope with paths
that contain forward slashes as path seperator. We thus substitute slash
with the platforms native backslash.

Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
---
 git-gui/git-gui.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 9a9525d..ae45a12 100644
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2112,15 +2112,17 @@ proc do_git_gui {} {
 proc do_explore {} {
 	global _gitworktree
 	set explorer {}
+	set path $_gitworktree
 	if {[is_Cygwin] || [is_Windows]} {
 		set explorer "explorer.exe"
+		set path [list [string map {/ \\} $path]]
 	} elseif {[is_MacOSX]} {
 		set explorer "open"
 	} else {
 		# freedesktop.org-conforming system is our best shot
 		set explorer "xdg-open"
 	}
-	eval exec $explorer $_gitworktree &
+	eval exec $explorer $path &
 }
 
 set is_quitting 0
-- 
1.7.0.m5.rc2.15.g8ba4c
