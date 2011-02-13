From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 1/2] git-gui: refactor remote submenu creation into
	subroutine
Date: Sun, 13 Feb 2011 14:50:38 +0100
Message-ID: <20110213135038.GD31986@book.hvoigt.net>
References: <20110212164344.GA19433@book.hvoigt.net> <AANLkTi=hY1XpBNfhNDfM8kwgnitQXN-97mM-dkhCpTac@mail.gmail.com> <20110213134753.GC31986@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@googlemail.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Pat Thoyts <patthoyts@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 14:50:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PocLd-0002S2-Tw
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 14:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568Ab1BMNul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 08:50:41 -0500
Received: from darksea.de ([83.133.111.250]:34771 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754375Ab1BMNuk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 08:50:40 -0500
Received: (qmail 13981 invoked from network); 13 Feb 2011 14:50:38 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 13 Feb 2011 14:50:38 +0100
Content-Disposition: inline
In-Reply-To: <20110213134753.GC31986@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166667>

Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
---
 lib/remote.tcl |   40 ++++++++++++++++++++++++----------------
 1 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/lib/remote.tcl b/lib/remote.tcl
index b92b429..d9eab78 100644
--- a/lib/remote.tcl
+++ b/lib/remote.tcl
@@ -157,22 +157,7 @@ proc add_fetch_entry {r} {
 	}
 
 	if {$enable} {
-		if {![winfo exists $fetch_m]} {
-			menu $remove_m
-			$remote_m insert 0 cascade \
-				-label [mc "Remove Remote"] \
-				-menu $remove_m
-
-			menu $prune_m
-			$remote_m insert 0 cascade \
-				-label [mc "Prune from"] \
-				-menu $prune_m
-
-			menu $fetch_m
-			$remote_m insert 0 cascade \
-				-label [mc "Fetch from"] \
-				-menu $fetch_m
-		}
+		make_sure_remote_submenues_exist $remote_m
 
 		$fetch_m add command \
 			-label $r \
@@ -222,6 +207,29 @@ proc add_push_entry {r} {
 	}
 }
 
+proc make_sure_remote_submenues_exist {remote_m} {
+	set fetch_m $remote_m.fetch
+	set prune_m $remote_m.prune
+	set remove_m $remote_m.remove
+
+	if {![winfo exists $fetch_m]} {
+		menu $remove_m
+		$remote_m insert 0 cascade \
+			-label [mc "Remove Remote"] \
+			-menu $remove_m
+
+		menu $prune_m
+		$remote_m insert 0 cascade \
+			-label [mc "Prune from"] \
+			-menu $prune_m
+
+		menu $fetch_m
+		$remote_m insert 0 cascade \
+			-label [mc "Fetch from"] \
+			-menu $fetch_m
+	}
+}
+
 proc populate_remotes_menu {} {
 	global all_remotes
 
-- 
1.7.4.rc3.4.g155c4
