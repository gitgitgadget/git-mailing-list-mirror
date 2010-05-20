From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH (regression, resend)] Handle failure of core.worktree to identify the working directory.
Date: Thu, 20 May 2010 13:57:57 +0400
Message-ID: <1274349477-8747-1-git-send-email-kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 20 11:57:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF2Ux-00044S-Pb
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 11:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755361Ab0ETJ47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 05:56:59 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:58653 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604Ab0ETJ46 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 05:56:58 -0400
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1OF2Ua-00007K-Dj; Thu, 20 May 2010 13:56:40 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1OF2W3-0002Ha-DE; Thu, 20 May 2010 13:58:11 +0400
X-Mailer: git-send-email 1.7.1.91.ga63a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147371>

From: Pat Thoyts <patthoyts@users.sourceforge.net>

Commit 21985a11 'git-gui: handle non-standard worktree locations' attempts
to use either GIT_WORK_TREE or core.worktree to set the _gitworktree
variable but these may not be set which leads to a failure to launch
gitk to review history. Use _gitdir to set the location for a standard
git layout where the parent of the .git directory is the working tree.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
Tested-by: Kirill Smelkov <kirr@mns.spb.ru>
---
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
1.7.1.91.ga63a7
