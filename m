From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/2] submodule: fix confusing variable name
Date: Sat,  3 Aug 2013 17:14:19 +0000
Message-ID: <1375550060-5406-2-git-send-email-sandals@crustytoothpaste.net>
References: <1375550060-5406-1-git-send-email-sandals@crustytoothpaste.net>
Cc: judge.packham@gmail.com, iveqy@iveqy.com,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 03 19:14:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5fPc-0003iD-PJ
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 19:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489Ab3HCROh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 13:14:37 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:45639 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752106Ab3HCROg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Aug 2013 13:14:36 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6159428075;
	Sat,  3 Aug 2013 17:14:36 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.rc1
In-Reply-To: <1375550060-5406-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231609>

cmd_summary reads the output of git diff, but reads in the submodule path into a
variable called name.  Since this variable does not contain the name of the
submodule, but the path, rename it to be clearer what data it actually holds.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-submodule.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2979197..30b7fc1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1032,13 +1032,13 @@ cmd_summary() {
 	# Get modified modules cared by user
 	modules=$(git $diff_cmd $cached --ignore-submodules=dirty --raw $head -- "$@" |
 		sane_egrep '^:([0-7]* )?160000' |
-		while read mod_src mod_dst sha1_src sha1_dst status name
+		while read mod_src mod_dst sha1_src sha1_dst status path
 		do
 			# Always show modules deleted or type-changed (blob<->module)
-			test $status = D -o $status = T && echo "$name" && continue
+			test $status = D -o $status = T && echo "$path" && continue
 			# Also show added or modified modules which are checked out
-			GIT_DIR="$name/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
-			echo "$name"
+			GIT_DIR="$path/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
+			echo "$path"
 		done
 	)
 
-- 
1.8.4.rc1
