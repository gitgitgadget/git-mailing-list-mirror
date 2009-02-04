From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] filter-branch: do not consider diverging submodules a 'dirty
 worktree'
Date: Wed, 4 Feb 2009 15:40:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902041540130.10279@pacific.mpi-cbg.de>
References: <cover.1233758410u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 15:42:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUiwt-0004hG-8v
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 15:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbZBDOk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 09:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbZBDOk2
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 09:40:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:44810 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751518AbZBDOk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 09:40:27 -0500
Received: (qmail invoked by alias); 04 Feb 2009 14:40:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp034) with SMTP; 04 Feb 2009 15:40:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Rxotl4mtRrtOeuma3qePzW6L9ygEle3zON4nlbN
	D26LiCZVMLrLMU
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1233758410u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108368>

As filter-branch could not care less about submodules' actual contents,
it does not make sense to check if the checked-out submodules are
up-to-date before running filter-branch.  So do not do it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-filter-branch.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 8cbce4e..066f9c3 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -108,8 +108,8 @@ OPTIONS_SPEC=
 . git-sh-setup
 
 if [ "$(is_bare_repository)" = false ]; then
-	git diff-files --quiet &&
-	git diff-index --cached --quiet HEAD -- ||
+	git diff-files --ignore-submodules --quiet &&
+	git diff-index --ignore-submodules --cached --quiet HEAD -- ||
 	die "Cannot rewrite branch(es) with a dirty working directory."
 fi
 
-- 
1.6.1.2.582.g3fdd5
