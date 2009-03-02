From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH] git filter-branch: Process commits in --date-order
Date: Tue,  3 Mar 2009 00:10:54 +0100
Message-ID: <1236035454-12236-1-git-send-email-peda@lysator.liu.se>
Cc: Peter Rosin <peda@lysator.liu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 01:22:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeIOy-0007Pc-K8
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 01:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518AbZCCAVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 19:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753550AbZCCAVB
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 19:21:01 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:45365 "EHLO
	pne-smtpout1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755518AbZCCAVA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2009 19:21:00 -0500
X-Greylist: delayed 4196 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Mar 2009 19:21:00 EST
Received: from localhost.localdomain (81.234.184.159) by pne-smtpout1-sn2.hy.skanova.net (7.3.129)
        id 48A144C5031684C0; Tue, 3 Mar 2009 00:11:00 +0100
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111981>

When converting an svn repository to git, I am filtering the commits
using --msg-filter. During this conversion I want to use the
.git-rewrite/map data to fill in references to other commits. In the
svn repo, there is a commit message e.g. "Cherry-pick r207", and I
want to append "r207 = <commit>" to the git commit message, as r207
no longer means very much. This works fine when the git commit
corresponding to r207 has been filtered before the current commit, and
is present in the map. When filtering in --topo-order, this is not
always the case, making it impossible to look up the git commit.

Signed-off-by: Peter Rosin <peda@lysator.liu.se>
---
 git-filter-branch.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 9a09ba1..dbb2bb3 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -257,11 +257,11 @@ mkdir ../map || die "Could not create map/ directory"
 
 case "$filter_subdir" in
 "")
-	git rev-list --reverse --topo-order --default HEAD \
+	git rev-list --reverse --date-order --default HEAD \
 		--parents --simplify-merges "$@"
 	;;
 *)
-	git rev-list --reverse --topo-order --default HEAD \
+	git rev-list --reverse --date-order --default HEAD \
 		--parents --simplify-merges "$@" -- "$filter_subdir"
 esac > ../revs || die "Could not get the commits"
 commits=$(wc -l <../revs | tr -d " ")
-- 
1.6.0.4
