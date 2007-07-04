From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH] gitk: Fix for tree view ending in nested directories
Date: Wed, 4 Jul 2007 16:26:44 -0500
Message-ID: <20070704212643.GR4087@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 23:27:11 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6CNP-0004Aq-Ux
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 23:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755652AbXGDV0z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 17:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755564AbXGDV0z
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 17:26:55 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:35964 "EHLO
	asav03.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509AbXGDV0y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 17:26:54 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav03.insightbb.com with ESMTP; 04 Jul 2007 17:26:52 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah5FAD+ti0ZKhvbzR2dsb2JhbACBS4Vbh3kBAT8B
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 322E0309F31; Wed,  4 Jul 2007 16:26:44 -0500 (CDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51644>

Unroll the prefix stack when assigning treeheights when leaving
proc treeview.  Previously, when the ls-tree output ended in
multiple nested directories (for instance in a repository with a
single file "foo/bar/baz"), $treeheight("foo/bar/") was assigned
twice, and $treeheight("foo/") was never assigned.  This led to
an error when expanding the "foo" directory in the gitk treeview.

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 gitk |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 2d6a6ef..d94c512 100755
--- a/gitk
+++ b/gitk
@@ -1216,6 +1216,9 @@ proc treeview {w l openlevs} {
 	set treeheight($prefix) $ht
 	incr ht [lindex $htstack end]
 	set htstack [lreplace $htstack end end]
+	set prefixend [lindex $prefendstack end]
+	set prefendstack [lreplace $prefendstack end end]
+	set prefix [string range $prefix 0 $prefixend]
     }
     $w conf -state disabled
 }
-- 
1.5.2.GIT
