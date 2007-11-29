From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] git-svn: Don't create a "master" branch every time rebase is run
Date: Thu, 29 Nov 2007 11:54:39 -0800
Message-ID: <20071129195439.GA22630@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 29 20:55:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxpTQ-0005zG-On
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 20:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbXK2Tyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 14:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759873AbXK2Tyk
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 14:54:40 -0500
Received: from tater.midwinter.com ([216.32.86.90]:37705 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759739AbXK2Tyj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 14:54:39 -0500
Received: (qmail 22684 invoked by uid 1001); 29 Nov 2007 19:54:39 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66556>

If you run "git-svn rebase" while sitting on a topic branch, there is
no need to create a "master" branch if one didn't exist already. The
branch was created implicitly by the automatic checkout after fetching,
which in the case of rebase isn't actually necessary anyway.

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---
 git-svn.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 43e1591..d483e6b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -545,6 +545,8 @@ sub cmd_rebase {
 		exit 1;
 	}
 	unless ($_local) {
+		# rebase will checkout for us, so no need to do it explicitly
+		$_no_checkout = 'true';
 		$_fetch_all ? $gs->fetch_all : $gs->fetch;
 	}
 	command_noisy(rebase_cmd(), $gs->refname);
-- 
1.5.3.6.960.g49661
