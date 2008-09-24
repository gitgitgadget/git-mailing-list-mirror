From: pasky@suse.cz
Subject: [PATCH 2/3] git-gui: Use git web--browse --stdin for safe URL passing
Date: Thu, 25 Sep 2008 01:57:36 +0200
Message-ID: <20080925000156.857197915@suse.cz>
References: <20080924235734.697978308@suse.cz>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 02:03:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KieKO-0003We-3C
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 02:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbYIYACN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 20:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbYIYACL
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 20:02:11 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:50390 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752144AbYIYACI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 20:02:08 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 78FD12AC8FD; Thu, 25 Sep 2008 02:01:57 +0200 (CEST)
User-Agent: quilt/0.46_cvs20080326-19.1
Content-Disposition: inline; filename=t/git-gui/web-browse-stdin.diff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96717>

The current code does not actually require this since the documentation
URL should always pass through unmangled, but future users of
start_browser() (as in the patch to follow) might require this.

This patch has been sponsored by Novartis.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 git-gui/git-gui.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index fc67eb8..4d2d600 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2360,7 +2360,11 @@ if {[file isfile $doc_path]} {
 }
 
 proc start_browser {url} {
-	git "web--browse" $url
+	# We use --stdin here since passing URLs (especially with query
+	# strings) does insane things in MSysGit.
+	set fd [git_write "web--browse" "--stdin"]
+	puts $fd $url
+	close $fd
 }
 
 .mbar.help add command -label [mc "Online Documentation"] \
-- 
tg: (6e32399..) t/git-gui/web-browse-stdin (depends on: t/git-gui/web-browse t/web--browse/stdin)
