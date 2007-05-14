From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix git-clone buglet for remote case.
Date: Mon, 14 May 2007 14:25:52 -0700
Message-ID: <7vr6pjm71b.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705141836350.26948@jalava.cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tero Roponen <teanropo@jyu.fi>
X-From: git-owner@vger.kernel.org Mon May 14 23:26:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hni3Y-0008NK-Ex
	for gcvg-git@gmane.org; Mon, 14 May 2007 23:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbXENVZz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 17:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753012AbXENVZz
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 17:25:55 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:59937 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbXENVZy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 17:25:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070514212553.ZMDK1318.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 14 May 2007 17:25:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id z9Rs1W00u1kojtg0000000; Mon, 14 May 2007 17:25:53 -0400
In-Reply-To: <Pine.LNX.4.64.0705141836350.26948@jalava.cc.jyu.fi> (Tero
	Roponen's message of "Mon, 14 May 2007 18:41:25 +0300 (EEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47291>

c2f599e09fd0496413d1744b5b89b9b5c223555d introduced a buglet while
cloning from a remote URL; we forgot to squelch the unnecessary
error message when we try to cd to the given "remote" name,
in order to see if it is a local directory.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Tero Roponen <teanropo@jyu.fi> writes:

  > the latest git seems to output a warning every time I
  > try to clone a repository that is not local:
  >
  > $ git --version
  > git version 1.5.2.rc3.27.g43d151
  >
  > $ git clone git://git.kernel.org/pub/scm/git/git.git
  > /usr/local/bin/git-clone: line 23: cd: git://git.kernel.org/pub/scm/git/git.git: No such file or directory

  Yup, thankfully that is harmless but it is ugly and wrong
  nevertheless.  Thanks for the report.

 git-clone.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 70374aa..fdd354f 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -22,10 +22,10 @@ get_repo_base() {
 		cd "`/bin/pwd`" &&
 		cd "$1" &&
 		{
-			cd .git 2>/dev/null
+			cd .git
 			pwd
 		}
-	)
+	) 2>/dev/null
 }
 
 if [ -n "$GIT_SSL_NO_VERIFY" ]; then
-- 
1.5.2.rc3.27.g43d151
