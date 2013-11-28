From: Max Kirillov <max@max630.net>
Subject: [PATCH v2] gitk: make pointer selection visible in highlighted lines
Date: Thu, 28 Nov 2013 23:20:18 +0200
Message-ID: <20131128212018.GA24615@wheezy.local>
References: <20131127180601.GA31211@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Nov 28 22:26:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm96T-0000H4-Vl
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 22:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949Ab3K1V00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 16:26:26 -0500
Received: from p3plsmtpa08-07.prod.phx3.secureserver.net ([173.201.193.108]:41143
	"EHLO p3plsmtpa08-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750932Ab3K1V0Z (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Nov 2013 16:26:25 -0500
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Nov 2013 16:26:25 EST
Received: from wheezy.local ([89.27.29.195])
	by p3plsmtpa08-07.prod.phx3.secureserver.net with 
	id v9LL1m01T4CavkR019LSRk; Thu, 28 Nov 2013 14:20:30 -0700
Content-Disposition: inline
In-Reply-To: <20131127180601.GA31211@wheezy.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238515>

Custom tags have higher priority than `sel`, and when they define their
own background, it makes selection invisible. Especially inconvenient
for `filesep` (to select filenames), but also affects other tags.
Use `tag raise` to fix `sel`'s priority.

Also change `omark` tag handling, so that it is created once, together
with others, and then only removed from text rather than deleted. Then
it will not get larger priority than the `sel` tag.

Signed-off-by: Max Kirillov <max@max630.net>
---

Fixed the typo in the comment and selection of text in marked line

 gitk | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index 1dd5137..491a1fa 100755
--- a/gitk
+++ b/gitk
@@ -2029,6 +2029,7 @@ proc makewindow {} {
     global headctxmenu progresscanv progressitem progresscoords statusw
     global fprogitem fprogcoord lastprogupdate progupdatepending
     global rprogitem rprogcoord rownumsel numcommits
+    global markbgcolor
     global have_tk85 use_ttk NS
     global git_version
     global worddiff
@@ -2376,6 +2377,8 @@ proc makewindow {} {
     $ctext tag conf found -back yellow
     $ctext tag conf currentsearchhit -back orange
     $ctext tag conf wwrap -wrap word
+    $ctext tag conf omark -background $markbgcolor
+    $ctext tag raise sel
 
     .pwbottom add .bleft
     if {!$use_ttk} {
@@ -7439,11 +7442,10 @@ proc getblobline {bf id} {
 }
 
 proc mark_ctext_line {lnum} {
-    global ctext markbgcolor
+    global ctext
 
-    $ctext tag delete omark
+    $ctext tag remove omark 1.0 end
     $ctext tag add omark $lnum.0 "$lnum.0 + 1 line"
-    $ctext tag conf omark -background $markbgcolor
     $ctext see $lnum.0
 }
 
-- 
1.8.4.2.1566.g3c1a064
