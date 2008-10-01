From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [TRACKER PATCH] Change color at specified threshold
Date: Wed, 1 Oct 2008 22:30:37 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810012229390.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.LFD.2.00.0810011240390.3575@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 22:25:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl8GL-0000pw-Gv
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 22:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166AbYJAUYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 16:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752274AbYJAUYW
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 16:24:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:49802 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751767AbYJAUYW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 16:24:22 -0400
Received: (qmail invoked by alias); 01 Oct 2008 20:24:20 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp012) with SMTP; 01 Oct 2008 22:24:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+oXoU+4zWoKtC3i2AmO2u49rE1tIQw4BjwWUs0XP
	GAC5V3bIXvibbo
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0810011240390.3575@nehalem.linux-foundation.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97262>


Now the color changes when a certain threshold of remaining seconds is
reached.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Wed, 1 Oct 2008, Linus Torvalds wrote:

	> But I also have a UI that the kids can run to _see_ how much 
	> time they have left, so that getting thrown off the machine doesn't 
	> come as a total surprise.

 tracker-ui.tcl |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tracker-ui.tcl b/tracker-ui.tcl
index 16d00d7..1533db5 100755
--- a/tracker-ui.tcl
+++ b/tracker-ui.tcl
@@ -1,5 +1,7 @@
 #!/usr/bin/wish
 
+set red_threshold [expr 60 * 10]
+
 proc every {ms body} {
      eval $body
      after $ms [list every $ms $body]
@@ -7,14 +9,19 @@ proc every {ms body} {
 
 set user $env(USER)
 
-pack [label .tracker -textvariable time]
+pack [label .tracker -textvariable time -font "Times 36" -relief sunken]
 
 every 1000 {
-	global user
+	global user red_threshold
 	set f [open "/var/log/tracker/$user" "r"]
 	gets $f l1
 	gets $f l2
 	gets $f l3
 	close $f
 	set ::time "$l3"
+	if {[expr [lindex $l1 0] - [lindex $l1 1]] < $red_threshold} {
+		.tracker configure -foreground white -background red
+	} {
+		.tracker configure -foreground black -background white
+	}
 }
-- 
1.6.0.2.GIT
