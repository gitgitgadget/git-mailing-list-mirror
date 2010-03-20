From: Benjamin C Meyer <bmeyer@rim.com>
Subject: [PATCH 1/4] stash: use --quiet rather than using 2>/dev/null
Date: Fri, 19 Mar 2010 22:18:35 -0400
Message-ID: <1269051518-25099-1-git-send-email-bmeyer@rim.com>
Cc: Benjamin C Meyer <bmeyer@rim.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 03:19:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsoHJ-00038c-Gu
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 03:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712Ab0CTCSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 22:18:50 -0400
Received: from qmta12.westchester.pa.mail.comcast.net ([76.96.59.227]:46818
	"EHLO qmta12.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751269Ab0CTCSt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 22:18:49 -0400
Received: from omta01.westchester.pa.mail.comcast.net ([76.96.62.11])
	by qmta12.westchester.pa.mail.comcast.net with comcast
	id vDvC1d0040EZKEL5CEJpv3; Sat, 20 Mar 2010 02:18:49 +0000
Received: from localhost.localdomain ([71.192.50.29])
	by omta01.westchester.pa.mail.comcast.net with comcast
	id vEJo1d00g0dnthT3MEJoMf; Sat, 20 Mar 2010 02:18:49 +0000
X-Mailer: git-send-email 1.7.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142671>

Signed-off-by: Benjamin C Meyer <bmeyer@rim.com>
---
 git-stash.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index aa47e54..2533185 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -39,7 +39,7 @@ clear_stash () {
 	then
 		die "git stash clear with parameters is unimplemented"
 	fi
-	if current=$(git rev-parse --verify $ref_stash 2>/dev/null)
+	if current=$(git rev-parse --quiet --verify $ref_stash)
 	then
 		git update-ref -d $ref_stash $current
 	fi
@@ -201,7 +201,7 @@ save_stash () {
 }
 
 have_stash () {
-	git rev-parse --verify $ref_stash >/dev/null 2>&1
+	git rev-parse --quiet --verify $ref_stash >/dev/null
 }
 
 list_stash () {
@@ -342,16 +342,16 @@ drop_stash () {
 	fi
 	# Verify supplied argument looks like a stash entry
 	s=$(git rev-parse --verify "$@") &&
-	git rev-parse --verify "$s:"   > /dev/null 2>&1 &&
-	git rev-parse --verify "$s^1:" > /dev/null 2>&1 &&
-	git rev-parse --verify "$s^2:" > /dev/null 2>&1 ||
+	git rev-parse --quiet --verify "$s:"   > /dev/null &&
+	git rev-parse --quiet --verify "$s^1:" > /dev/null &&
+	git rev-parse --quiet --verify "$s^2:" > /dev/null ||
 		die "$*: not a valid stashed state"
 
 	git reflog delete --updateref --rewrite "$@" &&
 		say "Dropped $* ($s)" || die "$*: Could not drop stash entry"
 
 	# clear_stash if we just dropped the last stash entry
-	git rev-parse --verify "$ref_stash@{0}" > /dev/null 2>&1 || clear_stash
+	git rev-parse --quiet --verify "$ref_stash@{0}" > /dev/null || clear_stash
 }
 
 apply_to_branch () {
-- 
1.7.0.2
