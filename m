From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] submodule: prevent warning in summary output
Date: Sun, 18 Aug 2013 17:31:35 +0000
Message-ID: <1376847095-767956-1-git-send-email-sandals@crustytoothpaste.net>
Cc: judge.packham@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 19:31:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB6pU-0003pk-Mq
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 19:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754178Ab3HRRbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 13:31:41 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:45934 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753987Ab3HRRbk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Aug 2013 13:31:40 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CF9AD28073;
	Sun, 18 Aug 2013 17:31:39 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232486>

When git submodule summary is run and there is a deleted submodule, there is an
warning from git rev-parse:

  fatal: Not a git repository: '.vim/pathogen/.git'

Silence this warning, since it is fully expected that a deleted submodule will
not be a git repository.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2979197..66ee621 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1071,7 +1071,7 @@ cmd_summary() {
 		missing_dst=
 
 		test $mod_src = 160000 &&
-		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_src^0 >/dev/null &&
+		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_src^0 >/dev/null 2>&1 &&
 		missing_src=t
 
 		test $mod_dst = 160000 &&
-- 
1.8.4.rc2.564.g10ce5ae
