From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] Handle failure of core.worktree to identify the working directory.
Date: Thu, 18 Feb 2010 02:11:21 +0000
Message-ID: <87iq9vgugf.fsf@users.sourceforge.net>
References: <20100217121304.GA1623@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Thu Feb 18 03:16:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhvvs-000093-CB
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 03:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476Ab0BRCP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 21:15:56 -0500
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:57062 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932449Ab0BRCPx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Feb 2010 21:15:53 -0500
Received: from [172.23.170.145] (helo=anti-virus03-08)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Nhvvi-0002H7-2i; Thu, 18 Feb 2010 02:15:50 +0000
Received: from [77.99.239.132] (helo=badger.patthoyts.tk)
	by asmtp-out5.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1Nhvve-0004C0-Ea; Thu, 18 Feb 2010 02:15:46 +0000
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id DCA9A13D389; Thu, 18 Feb 2010 02:15:45 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
X-Url: http://www.patthoyts.tk/
In-Reply-To: <20100217121304.GA1623@tugrik.mns.mnsspb.ru> (Kirill Smelkov's
	message of "Wed, 17 Feb 2010 15:13:04 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.90 (usg-unix-v)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140288>

Commit 21985a11 'git-gui: handle non-standard worktree locations' attempts
to use either GIT_WORK_TREE or core.worktree to set the _gitworktree
variable but these may not be set which leads to a failure to launch
gitk to review history. Use _gitdir to set the location for a standard
git layout where the parent of the .git directory is the working tree.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
>Git-gui as shipped with todays git.git master is a bit broken:
>
>in git.git master (v1.7.0-29-g6d81630), try running:
>
>    $ git gui blame xdiff-interface.h
>
>Then select first line 'd9ea d9ea   1 #ifndef XDIFF_INTERFACE_H', right
>click to popup context menu, select "Show History Context" -->
>
>--> git gui errors with:
>
>    "Error: couldn't change working directory to "": no ...
>
>
>Thanks,
>Kirill

 git-gui.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 8996d2d..ec81b15 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1158,6 +1158,9 @@ apply_config
 # try to set work tree from environment, falling back to core.worktree
 if {[catch { set _gitworktree $env(GIT_WORK_TREE) }]} {
 	set _gitworktree [get_config core.worktree]
+	if {$_gitworktree eq ""} {
+		set _gitworktree [file dirname [file normalize $_gitdir]]
+	}
 }
 if {$_prefix ne {}} {
 	if {$_gitworktree eq {}} {
-- 
1.6.5.1.1367.gcd48


-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
