From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Show an error and exit if started in a directory where no .git could be found
Date: Sun, 29 Jul 2007 22:29:45 +0200
Message-ID: <20070729202945.GB9362@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Jul 29 22:29:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFFOg-00076U-D9
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 22:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934837AbXG2U3s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 16:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934811AbXG2U3r
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 16:29:47 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:64865 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934510AbXG2U3r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 16:29:47 -0400
Received: from tigra.home (Facac.f.strato-dslnet.de [195.4.172.172])
	by post.webmailer.de (mrclete mo27) (RZmta 10.3)
	with ESMTP id k0725cj6TJPmCS ; Sun, 29 Jul 2007 22:29:45 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 8AAE3277BD;
	Sun, 29 Jul 2007 22:29:45 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 84720C21D; Sun, 29 Jul 2007 22:29:45 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFz2KC8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54137>

This is to help people starting gitk from graphical file managers where
the stderr output is hidden.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 gitk |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index fc7cc8c..f5949a2 100755
--- a/gitk
+++ b/gitk
@@ -7575,7 +7575,10 @@ catch {source ~/.gitk}
 font create optionfont -family sans-serif -size -12
 
 # check that we can find a .git directory somewhere...
-set gitdir [gitdir]
+if {[ catch { set gitdir [gitdir] } ]} {
+    show_error {} . "Cannot find a git repository here."
+    exit 1
+}
 if {![file isdirectory $gitdir]} {
     show_error {} . "Cannot find the git directory \"$gitdir\"."
     exit 1
-- 
1.5.3.rc3.48.g5b618
