From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2] submodule: prevent warning in summary output
Date: Tue, 20 Aug 2013 00:26:37 +0000
Message-ID: <1376958397-800967-1-git-send-email-sandals@crustytoothpaste.net>
Cc: judge.packham@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 20 02:27:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBZmj-0002i8-G4
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 02:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833Ab3HTA0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 20:26:52 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:59749 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751826Ab3HTA0w (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Aug 2013 20:26:52 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id BEC1328073;
	Tue, 20 Aug 2013 00:26:49 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232580>

When git submodule summary is run and there is a deleted submodule, there is an
warning from git rev-parse:

  fatal: Not a git repository: '.vim/pathogen/.git'

Silence this warning, since it is fully expected that a deleted submodule will
not be a git repository.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---

I hesitated to add the test for $status because it will end up having no effect
since we exclude that case later.  However, for correctness, I included it.

 git-submodule.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2979197..eec3135 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1070,7 +1070,10 @@ cmd_summary() {
 		missing_src=
 		missing_dst=
 
+		test $status = D && missing_src=t
+
 		test $mod_src = 160000 &&
+		test -e "$name/.git" &&
 		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_src^0 >/dev/null &&
 		missing_src=t
 
-- 
1.8.4.rc3
