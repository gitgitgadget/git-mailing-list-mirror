From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] rebase -i --root: simplify code
Date: Mon, 26 Jan 2009 00:31:55 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901260031460.14855@racer>
References: <alpine.DEB.1.00.0901260029480.14855@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 26 00:32:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRETC-0001bU-Vq
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 00:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbZAYXb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 18:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbZAYXb0
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 18:31:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:42986 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750937AbZAYXbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 18:31:25 -0500
Received: (qmail invoked by alias); 25 Jan 2009 23:31:24 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp046) with SMTP; 26 Jan 2009 00:31:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19aeIEAmxtapCMmrtTlD6fAtnGVMZ2B0aStI9SniO
	QOb1M3hiIdoPw9
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0901260029480.14855@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107131>


When we rebase with --root, what we are actually picking are the commits
in $ONTO..$HEAD.  So $ONTO is really our $UPSTREAM.  Spell it out.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 21ac20c..6e2bf25 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -581,13 +581,15 @@ first and then run 'git rebase --continue' again."
 		if test -z "$REBASE_ROOT"
 		then
 			UPSTREAM_ARG="$1"
-			UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
+			UPSTREAM=$(git rev-parse --verify "$1") ||
+				die "Invalid base"
 			test -z "$ONTO" && ONTO=$UPSTREAM
 			shift
 		else
 			UPSTREAM_ARG=--root
 			test -z "$ONTO" &&
 				die "You must specify --onto when using --root"
+			UPSTREAM=$ONTO
 		fi
 		run_pre_rebase_hook "$UPSTREAM_ARG" "$@"
 
@@ -648,16 +650,9 @@ first and then run 'git rebase --continue' again."
 
 		SHORTHEAD=$(git rev-parse --short $HEAD)
 		SHORTONTO=$(git rev-parse --short $ONTO)
-		if test -z "$REBASE_ROOT"
-			# this is now equivalent to ! -z "$UPSTREAM"
-		then
-			SHORTUPSTREAM=$(git rev-parse --short $UPSTREAM)
-			REVISIONS=$UPSTREAM...$HEAD
-			SHORTREVISIONS=$SHORTUPSTREAM..$SHORTHEAD
-		else
-			REVISIONS=$ONTO...$HEAD
-			SHORTREVISIONS=$SHORTHEAD
-		fi
+		SHORTUPSTREAM=$(git rev-parse --short $UPSTREAM)
+		REVISIONS=$UPSTREAM...$HEAD
+		SHORTREVISIONS=$SHORTUPSTREAM..$SHORTHEAD
 		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
 			--abbrev=7 --reverse --left-right --topo-order \
 			$REVISIONS | \
-- 
1.6.1.482.g7d54be
