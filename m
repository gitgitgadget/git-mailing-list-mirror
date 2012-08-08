From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH v2 resend] gitk: Use an external icon file on Windows
Date: Wed, 08 Aug 2012 22:37:16 +0200
Message-ID: <5022CDFC.4090900@gmail.com>
References: <500CEF06.2030501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 22:37:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzD0b-0000Q8-JT
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 22:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759244Ab2HHUhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 16:37:33 -0400
Received: from plane.gmane.org ([80.91.229.3]:35986 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759235Ab2HHUhc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 16:37:32 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SzD0T-00009h-Bq
	for git@vger.kernel.org; Wed, 08 Aug 2012 22:37:29 +0200
Received: from p5ddb050a.dip0.t-ipconnect.de ([93.219.5.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 22:37:29 +0200
Received: from sschuberth by p5ddb050a.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 22:37:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p5ddb050a.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <500CEF06.2030501@gmail.com>
X-Forwarded-Message-Id: <500CEF06.2030501@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203124>

Git for Windows now ships with the new Git icon from git-scm.com. Use that
icon file instead of the old procedurally drawn one if it exists.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 gitk-git/gitk | 49 ++++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 59693c0..5127e55 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11664,7 +11664,6 @@ if { [info exists ::env(GITK_MSGSDIR)] } {
     set gitk_prefix [file dirname [file dirname [file normalize $argv0]]]
     set gitk_libdir [file join $gitk_prefix share gitk lib]
     set gitk_msgsdir [file join $gitk_libdir msgs]
-    unset gitk_prefix
 }
 
 ## Internationalization (i18n) through msgcat and gettext. See
@@ -11821,28 +11820,32 @@ if {[expr {[exec git rev-parse --is-inside-work-tree] == "true"}]} {
 set worktree [exec git rev-parse --show-toplevel]
 setcoords
 makewindow
-catch {
-    image create photo gitlogo      -width 16 -height 16
-
-    image create photo gitlogominus -width  4 -height  2
-    gitlogominus put #C00000 -to 0 0 4 2
-    gitlogo copy gitlogominus -to  1 5
-    gitlogo copy gitlogominus -to  6 5
-    gitlogo copy gitlogominus -to 11 5
-    image delete gitlogominus
-
-    image create photo gitlogoplus  -width  4 -height  4
-    gitlogoplus  put #008000 -to 1 0 3 4
-    gitlogoplus  put #008000 -to 0 1 4 3
-    gitlogo copy gitlogoplus  -to  1 9
-    gitlogo copy gitlogoplus  -to  6 9
-    gitlogo copy gitlogoplus  -to 11 9
-    image delete gitlogoplus
-
-    image create photo gitlogo32    -width 32 -height 32
-    gitlogo32 copy gitlogo -zoom 2 2
-
-    wm iconphoto . -default gitlogo gitlogo32
+if {$::tcl_platform(platform) eq {windows} && [file exists $gitk_prefix/etc/git.ico]} {
+    wm iconbitmap . -default $gitk_prefix/etc/git.ico
+} else {
+    catch {
+        image create photo gitlogo      -width 16 -height 16
+
+        image create photo gitlogominus -width  4 -height  2
+        gitlogominus put #C00000 -to 0 0 4 2
+        gitlogo copy gitlogominus -to  1 5
+        gitlogo copy gitlogominus -to  6 5
+        gitlogo copy gitlogominus -to 11 5
+        image delete gitlogominus
+
+        image create photo gitlogoplus  -width  4 -height  4
+        gitlogoplus  put #008000 -to 1 0 3 4
+        gitlogoplus  put #008000 -to 0 1 4 3
+        gitlogo copy gitlogoplus  -to  1 9
+        gitlogo copy gitlogoplus  -to  6 9
+        gitlogo copy gitlogoplus  -to 11 9
+        image delete gitlogoplus
+
+        image create photo gitlogo32    -width 32 -height 32
+        gitlogo32 copy gitlogo -zoom 2 2
+
+        wm iconphoto . -default gitlogo gitlogo32
+    }
 }
 # wait for the window to become visible
 tkwait visibility .
-- 
1.7.11.msysgit.2
