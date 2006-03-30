From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH] gitk: Use git wrapper to run git-ls-remote.
Date: Thu, 30 Mar 2006 13:31:51 +0100
Message-ID: <20060330123151.25779.73775.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Thu Mar 30 14:32:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOwJg-0001GQ-Rg
	for gcvg-git@gmane.org; Thu, 30 Mar 2006 14:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWC3Mby (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Mar 2006 07:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWC3Mbx
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Mar 2006 07:31:53 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:55407 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1750982AbWC3Mbx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Mar 2006 07:31:53 -0500
Received: (qmail 25794 invoked from network); 30 Mar 2006 12:31:51 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (127.0.0.1)
  by localhost with SMTP; 30 Mar 2006 12:31:51 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18194>

From: Mark Wooding <mdw@distorted.org.uk>

For some reason, the Cygwin Tcl's `exec' command has trouble running
scripts.  Fix this by using the C `git' wrapper.  Other GIT programs run
by gitk are written in C already, so we don't need to incur a
performance hit of going via the wrapper (which I'll bet isn't pretty
under Cygwin).

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index f4c6624..ac85d1c 100755
--- a/gitk
+++ b/gitk
@@ -359,7 +359,7 @@ proc readrefs {} {
     foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
 	catch {unset $v}
     }
-    set refd [open [list | git-ls-remote [gitdir]] r]
+    set refd [open [list | git ls-remote [gitdir]] r]
     while {0 <= [set n [gets $refd line]]} {
 	if {![regexp {^([0-9a-f]{40})	refs/([^^]*)$} $line \
 	    match id path]} {
