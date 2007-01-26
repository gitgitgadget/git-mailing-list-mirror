From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 4/7] add reflog entries for HEAD when detached
Date: Fri, 26 Jan 2007 17:26:08 -0500
Message-ID: <1169850372648-git-send-email-nico@cam.org>
References: <1169850371517-git-send-email-nico@cam.org>
 <11698503712588-git-send-email-nico@cam.org>
 <11698503712998-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 23:26:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAZWm-0004YX-3t
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 23:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbXAZW0R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 17:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752154AbXAZW0P
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 17:26:15 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60997 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbXAZW0O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 17:26:14 -0500
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCH00AEPYBNA4H0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 26 Jan 2007 17:26:12 -0500 (EST)
In-reply-to: <11698503712998-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.0.rc2.g6e2c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37890>

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 git-checkout.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index c52f352..ed344d8 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -259,8 +259,9 @@ if [ "$?" -eq 0 ]; then
 		#	git update-ref --detach HEAD $new
 		# or something like that...
 		#
-		echo "$detached" >"$GIT_DIR/HEAD.new" &&
-		mv "$GIT_DIR/HEAD.new" "$GIT_DIR/HEAD" ||
+		git-rev-parse HEAD >"$GIT_DIR/HEAD.new" &&
+		mv "$GIT_DIR/HEAD.new" "$GIT_DIR/HEAD" &&
+		git-update-ref -m "checkout: moving to $arg" HEAD "$detached" ||
 			die "Cannot detach HEAD"
 		if test -n "$detach_warn"
 		then
-- 
1.5.0.rc2.g6e2c
