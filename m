From: Stefan Haller <stefan@haller-berlin.de>
Subject: [PATCH v2] git-gui: bring Wish process to front on Mac
Date: Fri,  7 Jun 2013 23:56:51 +0200
Message-ID: <1370642211-34416-1-git-send-email-stefan@haller-berlin.de>
References: <1l424u5.uk987q18u3oxfM%lists@haller-berlin.de>
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 23:57:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4f0-0003Ei-DU
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 23:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177Ab3FGV5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 17:57:22 -0400
Received: from server90.greatnet.de ([83.133.96.186]:37963 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999Ab3FGV5V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 17:57:21 -0400
Received: from macbook-stk.fritz.box (dslb-094-223-125-109.pools.arcor-ip.net [94.223.125.109])
	by server90.greatnet.de (Postfix) with ESMTPA id EE83C3B0EF9;
	Fri,  7 Jun 2013 23:57:19 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.14.g33f718c
In-Reply-To: <1l424u5.uk987q18u3oxfM%lists@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226742>

On Mac OS X, any application that is started from the Terminal will open
behind all running applications; as a work-around, manually bring ourselves
to the front. (Stolen from gitk, commit 76bf6ff93e.)

We do this as the very first thing, so that any message boxes that might pop
up during the rest of the startup sequence are actually seen by the user.

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
Changes since the first patch: 
 - add catch
 - specify full path to /usr/bin/osascript

 git-gui.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index e133331..a792924 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -29,6 +29,21 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA}]
 
 ######################################################################
 ##
+## On Mac, bring the current Wish process window to front
+
+if {[tk windowingsystem] eq "aqua"} {
+	catch {
+		exec /usr/bin/osascript -e [format {
+			tell application "System Events"
+				set frontmost of processes whose unix id is %d to true
+			end tell
+		} [pid] ]
+	}
+}
+
+
+######################################################################
+##
 ## Tcl/Tk sanity check
 
 if {[catch {package require Tcl 8.4} err]
-- 
1.8.3.14.g33f718c
