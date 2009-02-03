From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] filter-branch: really allow running in a bare repository
Date: Tue, 3 Feb 2009 19:10:10 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902031910001.9822@pacific.mpi-cbg.de>
References: <cover.1233684552u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 19:11:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUPjm-0003rM-N8
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 19:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbZBCSJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 13:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbZBCSJl
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 13:09:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:33133 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752057AbZBCSJk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 13:09:40 -0500
Received: (qmail invoked by alias); 03 Feb 2009 18:09:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 03 Feb 2009 19:09:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18QIFlLdNAQAALTyrwxduvyByUVpG2OZXQ0iO0fya
	9UzAJ5QC6Ka+wb
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1233684552u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108232>

When checking if running in a bare repository, the work tree has to be
reset, otherwise we will be checking the temporary state, which is
always non-bare.

This commit augments a4661b0(git-filter-branch.sh: Allow running in bare
repositories).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-filter-branch.sh |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index eb62f71..8cbce4e 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -469,19 +469,19 @@ rm -rf "$tempdir"
 
 trap - 0
 
+unset GIT_DIR GIT_WORK_TREE GIT_INDEX_FILE
+test -z "$ORIG_GIT_DIR" || {
+	GIT_DIR="$ORIG_GIT_DIR" && export GIT_DIR
+}
+test -z "$ORIG_GIT_WORK_TREE" || {
+	GIT_WORK_TREE="$ORIG_GIT_WORK_TREE" &&
+	export GIT_WORK_TREE
+}
+test -z "$ORIG_GIT_INDEX_FILE" || {
+	GIT_INDEX_FILE="$ORIG_GIT_INDEX_FILE" &&
+	export GIT_INDEX_FILE
+}
 if [ "$(is_bare_repository)" = false ]; then
-	unset GIT_DIR GIT_WORK_TREE GIT_INDEX_FILE
-	test -z "$ORIG_GIT_DIR" || {
-		GIT_DIR="$ORIG_GIT_DIR" && export GIT_DIR
-	}
-	test -z "$ORIG_GIT_WORK_TREE" || {
-		GIT_WORK_TREE="$ORIG_GIT_WORK_TREE" &&
-		export GIT_WORK_TREE
-	}
-	test -z "$ORIG_GIT_INDEX_FILE" || {
-		GIT_INDEX_FILE="$ORIG_GIT_INDEX_FILE" &&
-		export GIT_INDEX_FILE
-	}
 	git read-tree -u -m HEAD
 fi
 
-- 
1.6.1.2.574.g140d5
