From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH 1/3] Avoid a few unportable, needlessly nested "...`...".
Date: Thu, 8 Nov 2007 22:47:36 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071108214736.GG31439@ins.uni-bonn.de>
References: <20071108214624.GF31439@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 22:48:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqFEJ-0002QB-Iq
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 22:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761346AbXKHVrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 16:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761332AbXKHVri
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 16:47:38 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:60546 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597AbXKHVri (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 16:47:38 -0500
Received: from localhost.localdomain (xdsl-87-78-163-133.netcologne.de [87.78.163.133])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 1B0FE400000BC
	for <git@vger.kernel.org>; Thu,  8 Nov 2007 22:47:37 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1IqFDs-00058n-JQ
	for git@vger.kernel.org; Thu, 08 Nov 2007 22:47:36 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071108214624.GF31439@ins.uni-bonn.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64076>


Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
---
 git-rebase--interactive.sh |    2 +-
 git-request-pull.sh        |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6d14092..66c80d4 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -392,7 +392,7 @@ do
 	-s|--strategy)
 		case "$#,$1" in
 		*,*=*)
-			STRATEGY="-s `expr "z$1" : 'z-[^=]*=\(.*\)'`" ;;
+			STRATEGY="-s "$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
 		1,*)
 			usage ;;
 		*)
diff --git a/git-request-pull.sh b/git-request-pull.sh
index 90d969c..068f5e0 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -25,13 +25,13 @@ headrev=`git rev-parse --verify "$head"^0` || exit
 merge_base=`git merge-base $baserev $headrev` ||
 die "fatal: No commits in common between $base and $head"
 
-url="`get_remote_url "$url"`"
-branch=`git peek-remote "$url" \
+url=$(get_remote_url "$url")
+branch=$(git peek-remote "$url" \
 	| sed -n -e "/^$headrev	refs.heads./{
 		s/^.*	refs.heads.//
 		p
 		q
-	}"`
+	}")
 if [ -z "$branch" ]; then
 	echo "warn: No branch of $url is at:" >&2
 	git log --max-count=1 --pretty='format:warn:   %h: %s' $headrev >&2
-- 
1.5.3.5.561.g140d
