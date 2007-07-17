From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] gitk - Ignore ctrl-z as EOF on windows
Date: Tue, 17 Jul 2007 18:42:04 -0400
Message-ID: <11847121241814-git-send-email-mdl123@verizon.net>
Cc: Mark Levedahl <mdl123@verizon.net>
To: paulus@samba.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 00:42:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAvkU-0002A4-5v
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 00:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbXGQWm0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 18:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755397AbXGQWm0
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 18:42:26 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:55094 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbXGQWm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 18:42:26 -0400
Received: from fal-l07294-lp.us.ray.com ([72.66.124.87])
 by vms040.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JLC0095OHQ6Z1A4@vms040.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 17 Jul 2007 17:42:07 -0500 (CDT)
X-Mailer: git-send-email 1.5.3.rc2.5.g66bbd
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52808>

Cygwin's Tcl is configured to honor any occurence of ctrl-z as an
end-of-file marker, while some commits in the git repository and possibly
elsewhere include that character in the commit comment. This causes gitk
ignore commit history following such a comment and incorrect graphs. This
change affects only Windows as Tcl on other platforms already has
eofchar == {}. This fixes problems noted by me and by Ray Lehtiniemi, and
the fix was suggested by Shawn Pierce.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 39e452a..238607e 100755
--- a/gitk
+++ b/gitk
@@ -101,7 +101,7 @@ proc start_rev_list {view} {
     set commfd($view) $fd
     set leftover($view) {}
     set lookingforhead $showlocalchanges
-    fconfigure $fd -blocking 0 -translation lf
+    fconfigure $fd -blocking 0 -translation lf -eofchar {}
     if {$tclencoding != {}} {
 	fconfigure $fd -encoding $tclencoding
     }
-- 
1.5.3.rc2.5.g66bbd
