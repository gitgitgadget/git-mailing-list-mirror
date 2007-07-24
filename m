From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git am: skip pine's internal folder data
Date: Tue, 24 Jul 2007 01:02:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707240102110.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 24 02:02:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID7rP-00020T-Qt
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 02:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504AbXGXACl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 20:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752432AbXGXACl
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 20:02:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:46360 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753347AbXGXACk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 20:02:40 -0400
Received: (qmail invoked by alias); 24 Jul 2007 00:02:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 24 Jul 2007 02:02:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xZPRIlZQxAHvl0AjfvXlAFZz6F4ecwaXjwl47eX
	w+LaCEYB3sjKjD
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53510>


Test if the From: line contains "Mail System Internal Data" and if
it is, skip this mail.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-am.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index bfd65dc..22d2b5c 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -284,6 +284,12 @@ do
 		git mailinfo $keep $utf8 "$dotest/msg" "$dotest/patch" \
 			<"$dotest/$msgnum" >"$dotest/info" ||
 			stop_here $this
+
+		# skip pine's internal folder data
+		sed '/^$/q' < "$dotest"/info |
+			grep '^Author: Mail System Internal Data$' > /dev/null
+			&& go_next && continue
+
 		test -s $dotest/patch || {
 			echo "Patch is empty.  Was it split wrong?"
 			stop_here $this
-- 
1.5.3.rc2.32.g35c5b-dirty
