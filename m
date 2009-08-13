From: Zbyszek Szmek <zbyszek@in.waw.pl>
Subject: [PATCH] Use "gitk: /path/to/repo" as gitk window title.
Date: Thu, 13 Aug 2009 21:58:30 +0200
Message-ID: <20090813195830.GL24561@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: zbyszek@in.waw.pl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 22:11:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbgeG-0002cO-4n
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 22:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbZHMUIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 16:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbZHMUIJ
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 16:08:09 -0400
Received: from cwm83.internetdsl.tpnet.pl ([83.19.120.83]:3827 "EHLO
	szyszka.in.waw.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172AbZHMUIH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 16:08:07 -0400
X-Greylist: delayed 565 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Aug 2009 16:08:07 EDT
Received: from zbyszek by szyszka.in.waw.pl with local (Exim 4.69)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1MbgRS-0006lJ-E1; Thu, 13 Aug 2009 21:58:30 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125865>

In case of non-bare repos, the .git suffix in the path is skipped.

Previously, when run in a subdirectory, gitk would show the name
of this subdirectory as the title, which was misleading.
---
 gitk-git/gitk |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 4604c83..e656e81 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -16,6 +16,14 @@ proc gitdir {} {
     }
 }
 
+proc reponame {} {
+    set n [file normalize [gitdir]]
+    if {[string match "*/.git" $n]} {
+	set n [string range $n 0 end-5]
+    }
+    return $n
+}
+
 # A simple scheduler for compute-intensive stuff.
 # The aim is to make sure that event handlers for GUI actions can
 # run at least every 50-100 ms.  Unfortunately fileevent handlers are
@@ -11156,6 +11164,8 @@ set nullfile "/dev/null"
 set have_tk85 [expr {[package vcompare $tk_version "8.5"] >= 0}]
 set git_version [join [lrange [split [lindex [exec git version] end] .] 0 2] .]
 
+set appname "gitk"
+
 set runq {}
 set history {}
 set historyindex 0
@@ -11220,7 +11230,7 @@ catch {
 }
 # wait for the window to become visible
 tkwait visibility .
-wm title . "[file tail $argv0]: [file tail [pwd]]"
+wm title . "$appname: [reponame]"
 update
 readrefs
 
-- 
1.6.3.3
