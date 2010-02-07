From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] git-gui: check whether systems nice command works or
	disable it
Date: Sun, 7 Feb 2010 22:47:56 +0100
Message-ID: <20100207214755.GB3034@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 07 22:49:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeF0L-0002Wh-Jv
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 22:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825Ab0BGVr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 16:47:58 -0500
Received: from darksea.de ([83.133.111.250]:56422 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754582Ab0BGVr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 16:47:58 -0500
Received: (qmail 15437 invoked from network); 7 Feb 2010 22:47:55 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 7 Feb 2010 22:47:55 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139258>

This fixes issue 394 from msysgit. It seems that the Gnuwin32 project
provides a nice command but it returns a "not implemented" error. To
help users we now try to execute once and disable it in case it fails.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---

see: http://code.google.com/p/msysgit/issues/detail?id=394
for more information.

cheers Heiko

 git-gui/git-gui.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 1fb3cbf..eec2dc9 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -388,6 +388,9 @@ proc _lappend_nice {cmd_var} {
 
 	if {![info exists _nice]} {
 		set _nice [_which nice]
+		if {[catch {exec $_nice git version}]} {
+			set _nice {}
+		}
 	}
 	if {$_nice ne {}} {
 		lappend cmd $_nice
-- 
1.7.0.rc1.7.gc0da5
