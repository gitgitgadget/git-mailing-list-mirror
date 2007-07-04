From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] filter-branch: make output nicer
Date: Wed, 4 Jul 2007 13:45:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707041345230.4071@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 04 14:46:03 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I64F8-0003dD-Vy
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 14:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758886AbXGDMqA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 08:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758778AbXGDMp7
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 08:45:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:57126 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757712AbXGDMp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 08:45:59 -0400
Received: (qmail invoked by alias); 04 Jul 2007 12:45:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp052) with SMTP; 04 Jul 2007 14:45:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wSZcS6D8wCQG8ICbTzgvb32i1Wu7oBYf9HF0cHy
	gTDRGvsbqV+J2h
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51603>


Instead of filling the screen with progress lines, use \r so that
the progress can be seen, but warning messages are more visible.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-filter-branch.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
 mode change 100644 => 100755 git-filter-branch.sh

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
old mode 100644
new mode 100755
index 22fb5bf..e320379
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -160,7 +160,7 @@ test $commits -eq 0 && die "Found nothing to rewrite"
 i=0
 while read commit parents; do
 	i=$(($i+1))
-	printf "$commit ($i/$commits) "
+	printf "\rRewrite $commit ($i/$commits)"
 
 	case "$filter_subdir" in
 	"")
@@ -203,8 +203,8 @@ while read commit parents; do
 
 	sed -e '1,/^$/d' <../commit | \
 		eval "$filter_msg" | \
-		sh -c "$filter_commit" "git commit-tree" $(git write-tree) $parentstr | \
-		tee ../map/$commit
+		(sh -c "$filter_commit" "git commit-tree" $(git write-tree)
+			$parentstr) 2> /dev/null > ../map/$commit
 done <../revs
 
 src_head=$(tail -n 1 ../revs | sed -e 's/ .*//')
-- 
1.5.3.rc0.2646.g88600-dirty
