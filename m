From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v2 2/3] git-merge-one-file: send "ERROR:" messages to stderr
Date: Sun, 24 Mar 2013 14:26:24 +0200
Message-ID: <1364127985-13366-3-git-send-email-kevin@bracey.fi>
References: <CAJDDKr4swZzzv3e+Huz72CVmisFKU8T74jFj3-uGmZHReRGVBw@mail.gmail.com>
 <1364127985-13366-1-git-send-email-kevin@bracey.fi>
Cc: David Aguilar <davvid@gmail.com>, Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 24 13:37:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJkAa-0006W4-Dv
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 13:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540Ab3CXMg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 08:36:29 -0400
Received: from 3.mo4.mail-out.ovh.net ([46.105.57.129]:36812 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753503Ab3CXMg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 08:36:28 -0400
Received: from mail643.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 31204104DC0B
	for <git@vger.kernel.org>; Sun, 24 Mar 2013 13:38:14 +0100 (CET)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 24 Mar 2013 14:25:51 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 24 Mar 2013 14:25:49 +0200
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.rc3.21.g744ac65
In-Reply-To: <1364127985-13366-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 17351524941176082656
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrieeiucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrieeiucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218952>

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 git-merge-one-file.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 2382b1f..39b7799 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -69,7 +69,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 	echo "Adding $4"
 	if test -f "$4"
 	then
-		echo "ERROR: untracked $4 is overwritten by the merge."
+		echo "ERROR: untracked $4 is overwritten by the merge." >&2
 		exit 1
 	fi
 	git update-index --add --cacheinfo "$7" "$3" "$4" &&
@@ -82,8 +82,8 @@ case "${1:-.}${2:-.}${3:-.}" in
 ".$3$2")
 	if test "$6" != "$7"
 	then
-		echo "ERROR: File $4 added identically in both branches,"
-		echo "ERROR: but permissions conflict $6->$7."
+		echo "ERROR: File $4 added identically in both branches," >&2
+		echo "ERROR: but permissions conflict $6->$7." >&2
 		exit 1
 	fi
 	echo "Adding $4"
@@ -98,11 +98,11 @@ case "${1:-.}${2:-.}${3:-.}" in
 
 	case ",$6,$7," in
 	*,120000,*)
-		echo "ERROR: $4: Not merging symbolic link changes."
+		echo "ERROR: $4: Not merging symbolic link changes." >&2
 		exit 1
 		;;
 	*,160000,*)
-		echo "ERROR: $4: Not merging conflicting submodule changes."
+		echo "ERROR: $4: Not merging conflicting submodule changes." >&2
 		exit 1
 		;;
 	esac
@@ -152,14 +152,14 @@ case "${1:-.}${2:-.}${3:-.}" in
 
 	if test $ret != 0
 	then
-		echo "ERROR: $msg in $4"
+		echo "ERROR: $msg in $4" >&2
 		exit 1
 	fi
 	exec git update-index -- "$4"
 	;;
 
 *)
-	echo "ERROR: $4: Not handling case $1 -> $2 -> $3"
+	echo "ERROR: $4: Not handling case $1 -> $2 -> $3" >&2
 	;;
 esac
 exit 1
-- 
1.8.2.rc3.21.g744ac65
