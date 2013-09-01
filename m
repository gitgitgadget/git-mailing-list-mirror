From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 1/2] submodule: fix confusing variable name
Date: Sun,  1 Sep 2013 20:06:48 +0000
Message-ID: <1378066009-1017855-2-git-send-email-sandals@crustytoothpaste.net>
References: <1378066009-1017855-1-git-send-email-sandals@crustytoothpaste.net>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de, judge.packham@gmail.com,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 01 22:07:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGDvc-0001g1-Tn
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 22:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473Ab3IAUHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 16:07:12 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60025 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752409Ab3IAUHM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Sep 2013 16:07:12 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 837AA28073;
	Sun,  1 Sep 2013 20:07:11 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <1378066009-1017855-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233592>

cmd_summary reads the output of git diff, but reads in the submodule path into a
variable called name.  Since this variable does not contain the name of the
submodule, but the path, rename it to be clearer what data it actually holds.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-submodule.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2979197..38520db 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1032,13 +1032,13 @@ cmd_summary() {
 	# Get modified modules cared by user
 	modules=$(git $diff_cmd $cached --ignore-submodules=dirty --raw $head -- "$@" |
 		sane_egrep '^:([0-7]* )?160000' |
-		while read mod_src mod_dst sha1_src sha1_dst status name
+		while read mod_src mod_dst sha1_src sha1_dst status sm_path
 		do
 			# Always show modules deleted or type-changed (blob<->module)
-			test $status = D -o $status = T && echo "$name" && continue
+			test $status = D -o $status = T && echo "$sm_path" && continue
 			# Also show added or modified modules which are checked out
-			GIT_DIR="$name/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
-			echo "$name"
+			GIT_DIR="$sm_path/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
+			echo "$sm_path"
 		done
 	)
 
-- 
1.8.4.rc3
