From: Marcus Karlsson <mk@acc.umu.se>
Subject: [PATCH] git-gui: Use PWD if it exists on Mac OS X.
Date: Sat, 10 Mar 2012 00:17:22 +0100
Message-ID: <1331335042-25509-1-git-send-email-mk@acc.umu.se>
Cc: gitster@pobox.com, spearce@spearce.org,
	Marcus Karlsson <mk@acc.umu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 00:26:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S69CN-0005dJ-Ct
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 00:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527Ab2CIX0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 18:26:00 -0500
Received: from mail.acc.umu.se ([130.239.18.156]:65191 "EHLO mail.acc.umu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151Ab2CIXZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 18:25:59 -0500
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Mar 2012 18:25:59 EST
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id 33E6CABD;
	Sat, 10 Mar 2012 00:18:00 +0100 (MET)
X-Virus-Scanned: amavisd-new at acc.umu.se
Received: from kennedy.acc.umu.se (kennedy.acc.umu.se [130.239.18.157])
	by mail.acc.umu.se (Postfix) with ESMTP id 15BB3ABC;
	Sat, 10 Mar 2012 00:18:00 +0100 (MET)
Received: by kennedy.acc.umu.se (Postfix, from userid 24678)
	id F0BD2353; Sat, 10 Mar 2012 00:17:59 +0100 (MET)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192758>

The current working directory is set to / when git-gui is invoked
using the Git Gui.app bundle on Mac OS X. This means that if it is
launched from a directory which contains a repository then git-gui
won't automatically find it unless the repository happens to be
located in /.

The PWD environment variable is however preserved if the bundle is
invoked using open(1). If git-gui would check for PWD then a user
could for example type open -a 'Git Gui' on a command line in order to
launch the program and it would automatically find the repository.

Teach git-gui to use the PWD environment variable on Mac OS X.

Signed-off-by: Marcus Karlsson <mk@acc.umu.se>
---
 git-gui/macosx/AppMain.tcl |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-gui/macosx/AppMain.tcl b/git-gui/macosx/AppMain.tcl
index ddbe633..738bdd0 100644
--- a/git-gui/macosx/AppMain.tcl
+++ b/git-gui/macosx/AppMain.tcl
@@ -12,7 +12,9 @@ if {[file tail [lindex $argv 0]] eq {gitk}} {
 } else {
 	set argv0 [file join $gitexecdir [file tail [lindex $argv 0]]]
 	set AppMain_source [file join $gitguilib git-gui.tcl]
-	if {[pwd] eq {/}} {
+	if {[info exists env(PWD)]} {
+		cd $env(PWD)
+	} elseif {[pwd] eq {/}} {
 		cd $env(HOME)
 	}
 }
-- 
1.7.10.rc0.17.g36a9f
