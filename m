From: Simon Hausmann <simon@lst.de>
Subject: [PATCH] git-p4: Fix warnings about non-existant refs/remotes/p4/HEAD ref when running git-p4 sync the first time after a git clone.
Date: Fri, 24 Aug 2007 17:46:16 +0200
Message-ID: <200708241746.18853.simon@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 17:43:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IObJy-0003YJ-0Z
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 17:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289AbXHXPn2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 11:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755095AbXHXPn2
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 11:43:28 -0400
Received: from esparsett.troll.no ([62.70.27.18]:44472 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754711AbXHXPn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 11:43:27 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id C061B74217; Fri, 24 Aug 2007 17:43:26 +0200 (CEST)
Received: from rhea.troll.no (rhea.troll.no [10.3.4.5])
	by esparsett.troll.no (Postfix) with ESMTP
	id B41FE7420D; Fri, 24 Aug 2007 17:43:26 +0200 (CEST)
X-Length: 1222
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56578>

Don't create the p4/HEAD symbolic ref if p4/master doesn't exist yet.

Signed-off-by: Simon Hausmann <simon@lst.de>
---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index b571e30..55778c5 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1131,7 +1131,7 @@ class P4Sync(Command):
                 system("git update-ref %s refs/heads/p4" % self.branch)
                 system("git branch -D p4");
             # create it /after/ importing, when master exists
-            if not gitBranchExists(self.refPrefix + "HEAD") and self.importIntoRemotes:
+            if not gitBranchExists(self.refPrefix + "HEAD") and self.importIntoRemotes and gitBranchExists(self.branch):
                 system("git symbolic-ref %sHEAD %s" % (self.refPrefix, self.branch))
 
         # TODO: should always look at previous commits,
-- 
1.5.3.rc6.1.ge31f
