From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 09/20] cvsserver: cvs add: do not expand directory arguments
Date: Sat, 13 Oct 2012 23:42:22 -0600
Message-ID: <1350193353-19210-10-git-send-email-mmogilvi_git@miniinfo.net>
References: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 08:08:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNHN6-00078b-Q0
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 08:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275Ab2JNGIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 02:08:04 -0400
Received: from qmta03.emeryville.ca.mail.comcast.net ([76.96.30.32]:36467 "EHLO
	qmta03.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752002Ab2JNGID (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 02:08:03 -0400
Received: from omta16.emeryville.ca.mail.comcast.net ([76.96.30.72])
	by qmta03.emeryville.ca.mail.comcast.net with comcast
	id Atwj1k0011ZMdJ4A3u82Eu; Sun, 14 Oct 2012 06:08:02 +0000
Received: from mmogilvi.homeip.net ([24.9.53.136])
	by omta16.emeryville.ca.mail.comcast.net with comcast
	id Au311k00B2wKXRC8cu32gH; Sun, 14 Oct 2012 06:03:02 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 831501E96020; Sat, 13 Oct 2012 23:43:19 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.2.484.gcd07cc5
In-Reply-To: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207638>

Standard "cvs add" never does any recursion.  With standard
cvs, "cvs add dir" will either add just the "dir" to
the repository, or error out.  Prior to this change, git-cvsserver
would try to recurse (perhaps re-adding sandbox-removed files?) into
the existing directory instead.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 git-cvsserver.perl | 2 --
 1 file changed, 2 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 8a7106d..4d514b4 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -543,8 +543,6 @@ sub req_add
     my $updater = GITCVS::updater->new($state->{CVSROOT}, $state->{module}, $log);
     $updater->update();
 
-    argsfromdir($updater);
-
     my $addcount = 0;
 
     foreach my $filename ( @{$state->{args}} )
-- 
1.7.10.2.484.gcd07cc5
