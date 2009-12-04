From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH RESEND] git gui: make current branch default in "remote
	delete branch" merge check
Date: Fri, 4 Dec 2009 22:26:48 +0100
Message-ID: <20091204212648.GA3979@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Dec 04 22:26:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGffy-0007bM-8V
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 22:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757290AbZLDV0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 16:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757276AbZLDV0m
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 16:26:42 -0500
Received: from darksea.de ([83.133.111.250]:45454 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757266AbZLDV0m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 16:26:42 -0500
Received: (qmail 29047 invoked from network); 4 Dec 2009 22:26:47 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 4 Dec 2009 22:26:47 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134577>

We already do the same when locally deleting a branch.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---

 lib/remote_branch_delete.tcl |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/lib/remote_branch_delete.tcl b/lib/remote_branch_delete.tcl
index 31e0947..2416420 100644
--- a/lib/remote_branch_delete.tcl
+++ b/lib/remote_branch_delete.tcl
@@ -250,6 +250,8 @@ method _write_url        {args} { set urltype url    }
 method _write_check_head {args} { set checktype head }
 
 method _write_head_list {args} {
+	global current_branch
+
 	$head_m delete 0 end
 	foreach abr $head_list {
 		$head_m insert end radiobutton \
@@ -258,7 +260,11 @@ method _write_head_list {args} {
 			-variable @check_head
 	}
 	if {[lsearch -exact -sorted $head_list $check_head] < 0} {
-		set check_head {}
+		if {[lsearch -exact -sorted $head_list $current_branch] < 0} {
+			set check_head {}
+		} else {
+			set check_head $current_branch
+		}
 	}
 }
 
-- 
1.6.4.m4.4
