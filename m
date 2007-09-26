From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] Create .dotest-merge after validating options.
Date: Tue, 25 Sep 2007 18:30:13 -0700
Message-ID: <1190770213-8651-1-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <kraai@ftbfs.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 03:30:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaLjX-0001if-OQ
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 03:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbXIZBa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 21:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbXIZBa2
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 21:30:28 -0400
Received: from neon.ftbfs.org ([83.168.236.214]:33832 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbXIZBa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 21:30:27 -0400
Received: from pool-71-104-149-201.lsanca.dsl-w.verizon.net ([71.104.149.201] helo=macbookpro.ftbfs.org)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1IaM0D-000207-Dd; Tue, 25 Sep 2007 18:47:53 -0700
Received: from kraai by macbookpro.ftbfs.org with local (Exim 4.67)
	(envelope-from <kraai@ftbfs.org>)
	id 1IaLjB-0002G0-Ni; Tue, 25 Sep 2007 18:30:16 -0700
X-Mailer: git-send-email 1.5.3.2
X-Spam-Score: -4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59204>

Creating .dotest-merge before validating the options prevents both
--continue and --interactive from working if the options are invalid,
so only create it after validating the options.

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
 git-rebase--interactive.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2fa53fd..7466b5a 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -406,7 +406,6 @@ do
 
 		require_clean_work_tree
 
-		mkdir "$DOTEST" || die "Could not create temporary $DOTEST"
 		if test ! -z "$2"
 		then
 			output git show-ref --verify --quiet "refs/heads/$2" ||
@@ -418,6 +417,8 @@ do
 		HEAD=$(git rev-parse --verify HEAD) || die "No HEAD?"
 		UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
 
+		mkdir "$DOTEST" || die "Could not create temporary $DOTEST"
+
 		test -z "$ONTO" && ONTO=$UPSTREAM
 
 		: > "$DOTEST"/interactive || die "Could not mark as interactive"
-- 
1.5.3.2
