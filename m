From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Abort mergetool on read error from stdinput
Date: Thu,  2 Dec 2010 07:28:21 +0100
Message-ID: <1291271301-12511-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Dec 02 07:28:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO2et-0006Fj-Pd
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 07:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757241Ab0LBG2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 01:28:41 -0500
Received: from mail.dewire.com ([83.140.172.130]:9136 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756959Ab0LBG2k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 01:28:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 29F988003A9;
	Thu,  2 Dec 2010 07:28:39 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KcX+E8lFBOA6; Thu,  2 Dec 2010 07:28:38 +0100 (CET)
Received: from Robin-Rosenbergs-MacBook-Pro.local.com (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 9DA88800366;
	Thu,  2 Dec 2010 07:28:38 +0100 (CET)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162678>

If you press e.g Ctrl-C the interactive merge goes into an
infinite loop that is somewhat tricky to stop. Abort the script
if bash read fails.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 git-mergetool--lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 77d4aee..2fc2886 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -35,7 +35,7 @@ check_unchanged () {
 		while true; do
 			echo "$MERGED seems unchanged."
 			printf "Was the merge successful? [y/n] "
-			read answer
+			read answer < /dev/tty || exit 1
 			case "$answer" in
 			y*|Y*) status=0; break ;;
 			n*|N*) status=1; break ;;
-- 
1.7.2.3
