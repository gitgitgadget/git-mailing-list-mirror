From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH (amend)] filter-branch: always export GIT_DIR if it is set
Date: Wed, 6 Jun 2007 09:16:56 +0200
Message-ID: <20070606071656.GC32642@moooo.ath.cx>
References: <20070603144401.GA9518@moooo.ath.cx> <20070603144714.GD20061@moooo.ath.cx> <7vodjudei2.fsf@assigned-by-dhcp.cox.net> <20070605164957.GA12358@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 09:17:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvplS-0004m2-KR
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 09:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbXFFHQ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 03:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbXFFHQ7
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 03:16:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:41533 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751113AbXFFHQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 03:16:58 -0400
Received: (qmail invoked by alias); 06 Jun 2007 07:16:56 -0000
Received: from pD9EBB5B0.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.176]
  by mail.gmx.net (mp055) with SMTP; 06 Jun 2007 09:16:56 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX189NYRRZ/w9MT6Ceu4RVuGrd8UrSCNHKX+LuYOWnD
	2/vuIoU/mbJ2We
Content-Disposition: inline
In-Reply-To: <20070605164957.GA12358@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49253>

Currently filter-branch exports GIT_DIR only if it is an
relative path but git-sh-setup might also set GIT_DIR to an
absolute path that is not exported yet.  Additionally export
GIT_WORK_TREE with GIT_DIR to ensure that cwd is used as
working tree even for bare repositories.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
The last one was a bit bloated :)
---
 git-filter-branch.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 0c8a7df..acd52bd 100644
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -315,9 +315,10 @@ case "$GIT_DIR" in
 /*)
 	;;
 *)
-	export GIT_DIR="$(pwd)/../../$GIT_DIR"
+	GIT_DIR="$(pwd)/../../$GIT_DIR"
 	;;
 esac
+export GIT_DIR GIT_WORK_TREE=.
 
 export GIT_INDEX_FILE="$(pwd)/../index"
 git-read-tree # seed the index file
-- 
1.5.2.1.116.g9f308
