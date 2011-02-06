From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] git gui: keep selected branch when remote is changed in
	push dialog
Date: Sun, 6 Feb 2011 18:01:08 +0100
Message-ID: <20110206170055.GA47941@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <jens.lehmann@web.de>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 18:01:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm7zD-0005Bw-0N
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 18:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263Ab1BFRBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 12:01:13 -0500
Received: from darksea.de ([83.133.111.250]:33635 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753016Ab1BFRBM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 12:01:12 -0500
Received: (qmail 7938 invoked from network); 6 Feb 2011 18:01:10 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 6 Feb 2011 18:01:10 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166153>

The selection of the branch to be pushed would be cleared when
the remote was changed. This seems to be dependent on the fact that
the selected content in the combobox was exported to the clipboard. It
was only apparent when using the new ttk widget.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
Note: This patch was created inside the official git repo but should
apply cleanly to git-gui's master using 'git am -p2'

 git-gui/lib/transport.tcl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-gui/lib/transport.tcl b/git-gui/lib/transport.tcl
index 49155c7..e4e1add 100644
--- a/git-gui/lib/transport.tcl
+++ b/git-gui/lib/transport.tcl
@@ -223,7 +223,9 @@ proc do_push_anywhere {} {
 			-value remote \
 			-variable push_urltype
 		if {$use_ttk} {
-			ttk::combobox $w.dest.remote_m -textvariable push_remote \
+			ttk::combobox $w.dest.remote_m -state readonly \
+				-exportselection false \
+				-textvariable push_remote \
 				-values $all_remotes
 		} else {
 			eval tk_optionMenu $w.dest.remote_m push_remote $all_remotes
-- 
1.7.4.34.gd2cb1
