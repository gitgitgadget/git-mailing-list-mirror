From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-gui: properly popup error if gitk should be started but is not installed
Date: Fri, 29 Jun 2007 11:32:29 +0000
Message-ID: <20070629113229.23815.qmail@e211c3361797a3.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 29 13:36:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4Elj-000321-Bc
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 13:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758176AbXF2LfY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 07:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763702AbXF2LfV
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 07:35:21 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:60651 "HELO a.mx.smarden.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1762754AbXF2LfN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 07:35:13 -0400
Received: (qmail 23816 invoked by uid 1000); 29 Jun 2007 11:32:29 -0000
Mail-Followup-To: "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51172>

On 'Visualize ...', a gitk process is started.  Since it is run in the
background, catching a possible startup error doesn't work, and the error
output goes to the console git-gui is started from.  The most probable
startup error is that gitk is not installed; so before trying to start,
check for the existence of the gitk program, and popup an error message
unless it's found.

This was noticed and reported by Paul Wise through
 http://bugs.debian.org/429810

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 git-gui.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 9df2e47..1b0691c 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1070,10 +1070,10 @@ proc do_gitk {revs} {
 		append cmd { }
 		append cmd $revs
 	}
-
-	if {[catch {eval exec $cmd &} err]} {
-		error_popup "Failed to start gitk:\n\n$err"
+	if {! [file exists [gitexec gitk]]} {
+		error_popup "Unable to start gitk:\n\nFile does not exist"
 	} else {
+		eval exec $cmd &
 		set ui_status_value $starting_gitk_msg
 		after 10000 {
 			if {$ui_status_value eq $starting_gitk_msg} {
-- 
1.5.2.1
