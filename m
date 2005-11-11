From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] gitk: use git-diff-tree --no-commit-id
Date: Fri, 11 Nov 2005 10:09:12 -0500
Message-ID: <1131721752.1284.7.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 11 16:10:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaaX4-0004Pv-DY
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 16:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVKKPJd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 10:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVKKPJd
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 10:09:33 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:56549 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750802AbVKKPJc
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 10:09:32 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EaaWn-0007tY-Lb
	for git@vger.kernel.org; Fri, 11 Nov 2005 10:09:28 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EaaWe-0005Jy-6Q; Fri, 11 Nov 2005 10:09:12 -0500
To: Paul Mackerras <paulus@samba.org>, git <git@vger.kernel.org>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11604>

gitk switched to use git-diff-tree with one argument in gettreediffs and
getblobdiffs.  git-diff-tree with one argument outputs commit ID in from
of the patch.  This causes an empty line after "Comments" in the lower
right pane.  Also, the diff in the lower left pane has the commit ID,
which is useless there.

This patch makes git use the newly added -no-commit-id option for
git-diff-tree to suppress commit ID.  It also removes the p variable in
both functions, since it has become useless after switching to the
one-argument invocation for git-diff-tree.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/gitk b/gitk
index a9d37d9..6d47139 100755
--- a/gitk
+++ b/gitk
@@ -2805,8 +2805,7 @@ proc gettreediffs {ids} {
     set treepending $ids
     set treediff {}
     set id [lindex $ids 0]
-    set p [lindex $ids 1]
-    if [catch {set gdtf [open "|git-diff-tree -r $id" r]}] return
+    if [catch {set gdtf [open "|git-diff-tree --no-commit-id -r $id" r]}] return
     fconfigure $gdtf -blocking 0
     fileevent $gdtf readable [list gettreediffline $gdtf $ids]
 }
@@ -2840,9 +2839,8 @@ proc getblobdiffs {ids} {
     global difffilestart nextupdate diffinhdr treediffs
 
     set id [lindex $ids 0]
-    set p [lindex $ids 1]
     set env(GIT_DIFF_OPTS) $diffopts
-    set cmd [list | git-diff-tree -r -p -C $id]
+    set cmd [list | git-diff-tree --no-commit-id -r -p -C $id]
     if {[catch {set bdf [open $cmd r]} err]} {
 	puts "error getting diffs: $err"
 	return



-- 
Regards,
Pavel Roskin
