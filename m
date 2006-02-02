From: Pavel Roskin <proski@gnu.org>
Subject: gitk changing line color for no reason after merge
Date: Thu, 02 Feb 2006 12:21:37 -0500
Message-ID: <1138900897.28967.18.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Feb 02 18:24:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4i9b-0004dq-4f
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 18:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWBBRVw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 12:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWBBRVw
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 12:21:52 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:52460 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932185AbWBBRVv
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Feb 2006 12:21:51 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F4i8P-0005R8-BN
	for git@vger.kernel.org; Thu, 02 Feb 2006 12:20:41 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1F4i9J-0000yN-Un; Thu, 02 Feb 2006 12:21:37 -0500
To: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-Mailer: Evolution 2.5.90 (2.5.90-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15513>

Hello, Paul!

I have noticed that gitk changes the line color at a commit following a
merge (i.e. a commit with many parents).  I made this screenshot to
demonstrate the problem:

http://red-bean.com/proski/gitk/gitk.png

If you follow the leftmost line, you'll see how green becomes red, gray
becomes brown and red becomes blue.

I think it would be much better if line colors only change at
non-trivial nodes, i.e. those with more than one child or parent.

The fix is trivial:

diff --git a/gitk b/gitk
index f12b3ce..14ff570 100755
--- a/gitk
+++ b/gitk
@@ -770,7 +770,7 @@ proc assigncolor {id} {
 
     if [info exists colormap($id)] return
     set ncolors [llength $colors]
-    if {$nparents($id) <= 1 && $nchildren($id) == 1} {
+    if {$nchildren($id) == 1} {
 	set child [lindex $children($id) 0]
 	if {[info exists colormap($child)]
 	    && $nparents($child) == 1} {


I checked the history of gitk and could trace this code back to the
first version of gitk in the git repository.  Maybe it was intended this
way, but I think it would be better to fix it.

-- 
Regards,
Pavel Roskin
