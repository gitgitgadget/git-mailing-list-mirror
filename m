From: pasky@suse.cz
Subject: [PATCH 5/5] git-gui: mkdir -p when initializing new remote repository
Date: Wed, 24 Sep 2008 22:44:03 +0200
Message-ID: <20080924204616.697813413@suse.cz>
References: <20080924204358.144077183@suse.cz>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 24 22:48:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KibHP-0002ti-Vs
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 22:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbYIXUqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 16:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbYIXUqd
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 16:46:33 -0400
Received: from [212.249.11.140] ([212.249.11.140]:46832 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752587AbYIXUq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 16:46:28 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 5193C2AC95E; Wed, 24 Sep 2008 22:46:17 +0200 (CEST)
User-Agent: quilt/0.46_cvs20080326-19.1
Content-Disposition: inline; filename=t/git-gui/remote-mkdir.diff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96693>

This allows the user to create repositories with arbitrary paths
on the server. The downside is that errorneously typed paths are
not caught but instead created remotely; YMMV.

This patch has been sponsored by Novartis.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 git-gui/lib/remote_add.tcl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-gui/lib/remote_add.tcl b/git-gui/lib/remote_add.tcl
index 89e88ee..8e3ad16 100644
--- a/git-gui/lib/remote_add.tcl
+++ b/git-gui/lib/remote_add.tcl
@@ -144,8 +144,9 @@ method _add {} {
 			if {[info exists env(GIT_SSH)]} {
 				set ssh $env(GIT_SSH)
 			}
-			lappend cmds [list exec $ssh $host git --git-dir=$path init --bare]
+			lappend cmds [list exec $ssh $host mkdir -p $location && git --git-dir=$path init --bare]
 		} elseif { ! [regexp {://} $location xx] } {
+			lappend cmds [list exec mkdir -p $location]
 			lappend cmds [list exec git --git-dir=$location init --bare]
 		} else {
 			tk_messageBox \
-- 
tg: (f30d624..) t/git-gui/remote-mkdir (depends on: t/git-gui/remote-add)
