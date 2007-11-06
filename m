From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH 1/5] Avoid a few unportable, needlessly nested "...`...".
Date: Tue, 6 Nov 2007 21:17:08 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071106201707.GB6361@ins.uni-bonn.de>
References: <20071106201518.GA6361@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 21:17:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpUrq-0001t0-1c
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 21:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089AbXKFURM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 15:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755286AbXKFURL
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 15:17:11 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:57065 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707AbXKFURK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 15:17:10 -0500
Received: from ins.uni-bonn.de (gibraltar [192.168.193.254])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 17D874000269A
	for <git@vger.kernel.org>; Tue,  6 Nov 2007 21:17:09 +0100 (CET)
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071106201518.GA6361@ins.uni-bonn.de>
User-Agent: Mutt/1.5.17 (2007-11-04)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63715>

Some shells wrongly interpret double-quote backquote double-quote
nesting.  OTOH, the right hand side of an assignment is never split
in words, so the outer double quotes are needless there.
---
 git-rebase--interactive.sh |    2 +-
 git-request-pull.sh        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 76dc679..ecc6778 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -391,7 +391,7 @@ do
 	-s|--strategy)
 		case "$#,$1" in
 		*,*=*)
-			STRATEGY="-s `expr "z$1" : 'z-[^=]*=\(.*\)'`" ;;
+			STRATEGY="-s "`expr "z$1" : 'z-[^=]*=\(.*\)'` ;;
 		1,*)
 			usage ;;
 		*)
diff --git a/git-request-pull.sh b/git-request-pull.sh
index a992430..ec367d7 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -24,7 +24,7 @@ headrev=`git rev-parse --verify "$head"^0` || exit
 merge_base=`git merge-base $baserev $headrev` ||
 die "fatal: No commits in common between $base and $head"
 
-url="`get_remote_url "$url"`"
+url=`get_remote_url "$url"`
 branch=`git peek-remote "$url" \
 	| sed -n -e "/^$headrev	refs.heads./{
 		s/^.*	refs.heads.//
-- 
1.5.3.5.561.g140d
