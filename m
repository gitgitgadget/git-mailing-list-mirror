From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] filter-branch: provide the convenience functions also
 for commit filters
Date: Wed, 18 Jul 2007 16:52:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707181650080.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 18 17:52:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBBpI-0000mj-FY
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 17:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760302AbXGRPw3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 11:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760282AbXGRPw3
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 11:52:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:47828 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759780AbXGRPw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 11:52:28 -0400
Received: (qmail invoked by alias); 18 Jul 2007 15:52:25 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp008) with SMTP; 18 Jul 2007 17:52:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ELHBULA9EPEgjhoSN8mnwSbbqiTRjFkJ1gIi0Jo
	RT0fIX/+4xHwY9
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52872>


By sourcing git-filter-branch and stopping after the function definitions,
the commit filter can now access the convenience functions like "map".

This is done automatically if you specify a commit filter.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-filter-branch.sh |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 0d000ed..b574612 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -8,9 +8,6 @@
 # a new branch. You can specify a number of filters to modify the commits,
 # files and trees.
 
-USAGE="git-filter-branch [-d TEMPDIR] [FILTERS] DESTBRANCH [REV-RANGE]"
-. git-sh-setup
-
 warn () {
         echo "$*" >&2
 }
@@ -69,6 +66,13 @@ set_ident () {
 	echo "[ -n \"\$GIT_${uid}_NAME\" ] || export GIT_${uid}_NAME=\"\${GIT_${uid}_EMAIL%%@*}\""
 }
 
+# This script can be sourced by the commit filter to get the functions
+test "a$SOURCE_FUNCTIONS" = a1 && return
+this_script="$(cd "$(dirname "$0")"; pwd)"/$(basename "$0")
+
+USAGE="git-filter-branch [-d TEMPDIR] [FILTERS] DESTBRANCH [REV-RANGE]"
+. git-sh-setup
+
 tempdir=.git-rewrite
 filter_env=
 filter_tree=
@@ -118,7 +122,7 @@ do
 		filter_msg="$OPTARG"
 		;;
 	--commit-filter)
-		filter_commit="$OPTARG"
+		filter_commit="SOURCE_FUNCTIONS=1 . \"$this_script\"; $OPTARG"
 		;;
 	--tag-name-filter)
 		filter_tag_name="$OPTARG"
-- 
1.5.3.rc1.16.g9d6f-dirty
