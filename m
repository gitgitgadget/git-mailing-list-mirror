From: Stefan Haller <stefan@haller-berlin.de>
Subject: [PATCH] git-gui: bring Wish process to front on Mac
Date: Thu,  6 Jun 2013 10:17:47 +0200
Message-ID: <1370506667-24576-1-git-send-email-stefan@haller-berlin.de>
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 10:18:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkVOl-0000XV-2R
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 10:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499Ab3FFISN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 04:18:13 -0400
Received: from server90.greatnet.de ([83.133.96.186]:49921 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337Ab3FFISL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 04:18:11 -0400
Received: from macbook-stk.office.ableton.com (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id DB9B13B0EFD;
	Thu,  6 Jun 2013 10:18:08 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.14.g33f718c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226487>

On Mac OS X, any application that is started from the Terminal will open
behind all running applications; as a work-around, manually bring ourselves
to the front. (Stolen from gitk, commit 76bf6ff93e.)

We do this as the very first thing, so that any message boxes that might pop
up during the rest of the startup sequence are actually seen by the user.

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
 git-gui.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index e133331..c464928 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -29,6 +29,19 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA}]
 
 ######################################################################
 ##
+## On Mac, bring the current Wish process window to front
+
+if {[tk windowingsystem] eq "aqua"} {
+	exec osascript -e [format {
+		tell application "System Events"
+			set frontmost of processes whose unix id is %d to true
+		end tell
+	} [pid] ]
+}
+
+
+######################################################################
+##
 ## Tcl/Tk sanity check
 
 if {[catch {package require Tcl 8.4} err]
-- 
1.8.3.14.g33f718c
