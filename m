From: Marcus Karlsson <mk@acc.umu.se>
Subject: [PATCH v3] gitk: Teach gitk to respect log.showroot
Date: Tue, 4 Oct 2011 22:08:13 +0200
Message-ID: <20111004200813.GA16596@kennedy.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: zbyszek@in.waw.pl, gitster@pobox.com, git@vger.kernel.org
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Tue Oct 04 22:08:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBBHp-0007N6-8k
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 22:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933588Ab1JDUIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 16:08:16 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:47032 "EHLO mail.acc.umu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933403Ab1JDUIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 16:08:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id D563B456;
	Tue,  4 Oct 2011 22:08:14 +0200 (MEST)
X-Virus-Scanned: amavisd-new at acc.umu.se
Received: from kennedy.acc.umu.se (kennedy.acc.umu.se [130.239.18.157])
	by mail.acc.umu.se (Postfix) with ESMTP id 182B0455;
	Tue,  4 Oct 2011 22:08:14 +0200 (MEST)
Received: by kennedy.acc.umu.se (Postfix, from userid 24678)
	id 039B179; Tue,  4 Oct 2011 22:08:13 +0200 (MEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182793>

In early days, all projects managed by git (except for git itself) had the
product of a fairly mature development history in their first commit, and
it was deemed unnecessary clutter to show additions of these thousands of
paths as a patch.

"git log" learned to show the patch for the initial commit without requiring
--root command line option at 0f03ca9 (config option log.showroot to show
the diff of root commits, 2006-11-23).

Teach gitk to respect log.showroot.

Signed-off-by: Marcus Karlsson <mk@acc.umu.se>
---
Improved the commit message after suggestion from Zbigniew
Jedrzejewski-Szmek.

 gitk-git/gitk |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 4cde0c4..40ea73f 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -7402,7 +7402,7 @@ proc addtocflist {ids} {
 }
 
 proc diffcmd {ids flags} {
-    global nullid nullid2
+    global log_showroot nullid nullid2
 
     set i [lsearch -exact $ids $nullid]
     set j [lsearch -exact $ids $nullid2]
@@ -7436,7 +7436,11 @@ proc diffcmd {ids flags} {
 	    lappend cmd HEAD
 	}
     } else {
-	set cmd [concat | git diff-tree -r $flags $ids]
+	set cmd [concat | git diff-tree -r]
+	if {$log_showroot eq true} {
+	    set cmd [concat $cmd --root]
+	}
+	set cmd [concat $cmd $flags $ids]
     }
     return $cmd
 }
@@ -11403,6 +11407,11 @@ catch {
     }
 }
 
+set log_showroot true
+catch {
+    set log_showroot [exec git config --get log.showroot]
+}
+
 if {[tk windowingsystem] eq "aqua"} {
     set mainfont {{Lucida Grande} 9}
     set textfont {Monaco 9}
-- 
1.7.7
