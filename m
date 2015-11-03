From: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
Subject: [PATCH 1/1] gitk: add --cwd=path commandline parameter to change path
Date: Tue,  3 Nov 2015 17:00:42 +0200
Message-ID: <1446562842-8478-2-git-send-email-juhapekka.heikkila@gmail.com>
References: <1446562842-8478-1-git-send-email-juhapekka.heikkila@gmail.com>
Cc: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 16:00:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztd4t-0002Si-CA
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 16:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678AbbKCPAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 10:00:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:7736 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754606AbbKCPAp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 10:00:45 -0500
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP; 03 Nov 2015 07:00:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,239,1444719600"; 
   d="scan'208";a="842080652"
Received: from jheikkil-mobl2.fi.intel.com ([10.237.66.161])
  by fmsmga002.fm.intel.com with ESMTP; 03 Nov 2015 07:00:43 -0800
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1446562842-8478-1-git-send-email-juhapekka.heikkila@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280798>

This patch adds --cwd (change working directory) parameter to
gitk. With this parameter, instead of need to cd to directory
with .git folder, one can point the correct folder from
commandline.

Signed-off-by: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
---
 Documentation/gitk.txt |  5 +++++
 gitk-git/gitk          | 15 +++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 6ade002..1f42198 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -146,6 +146,11 @@ gitk-specific options
 	Select the specified commit after loading the graph.
 	Default behavior is equivalent to specifying '--select-commit=HEAD'.
 
+--cwd=<path>::
+
+	Change working direcoty to <path>. If the git tree exist elsewhere
+	gitk first cd to given path before start to operate.
+
 Examples
 --------
 gitk v2.6.12.. include/scsi drivers/scsi::
diff --git a/gitk-git/gitk b/gitk-git/gitk
index fcc606e..5fdf459 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -12279,12 +12279,6 @@ setui $uicolor
 
 setoptions
 
-# check that we can find a .git directory somewhere...
-if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
-    show_error {} . [mc "Cannot find a git repository here."]
-    exit 1
-}
-
 set selecthead {}
 set selectheadid {}
 
@@ -12305,6 +12299,9 @@ foreach arg $argv {
 	"--argscmd=*" {
 	    set revtreeargscmd [string range $arg 10 end]
 	}
+	"--cwd=*" {
+	    cd [string range $arg 6 end]
+	}
 	default {
 	    lappend revtreeargs $arg
 	}
@@ -12312,6 +12309,12 @@ foreach arg $argv {
     incr i
 }
 
+# check that we can find a .git directory somewhere...
+if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
+    show_error {} . [mc "Cannot find a git repository here."]
+    exit 1
+}
+
 if {$selecthead eq "HEAD"} {
     set selecthead {}
 }
-- 
1.9.1
