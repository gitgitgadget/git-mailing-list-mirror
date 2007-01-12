From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Explain "Not a git repository: '.git'".
Date: Fri, 12 Jan 2007 12:26:15 -0800
Message-ID: <7vy7o8rnyw.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net>
	<200701121501.24642.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 21:26:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Sym-00056z-NS
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 21:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbXALU0R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 15:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbXALU0R
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 15:26:17 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:53637 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030255AbXALU0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 15:26:16 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112202616.MNHL15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 15:26:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ALRQ1W00D1kojtg0000000; Fri, 12 Jan 2007 15:25:24 -0500
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200701121501.24642.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 12 Jan 2007 15:01:07 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36703>

Andy Parkins noticed that the error message some "whole tree"
oriented commands emit is stated misleadingly when they refused
to run from a subdirectory.

We could probably allow some of them to work from a subdirectory
but that is a semantic change that could have unintended side
effects, so let's start at first by rewording the error message
to be easier to read without doing anything else to be safe.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Andy Parkins <andyparkins@gmail.com> writes:

 > Minor thing: git-rebase, git-cherry-pick and git-pull (and
 > presumably git-merge) all need to be the repository root to
 > work.  If that is intentional, a better message than "fatal:
 > Not a git repository: '.git'" would be appropriate.
 >
 > For me, I'd prefer that they worked in subdirectories.  I do
 > all almost all development in "src/" and having to change up a
 > directory just to run git commands is inconvenient.

 Thanks; let's do this for now.

 git-sh-setup.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 4a02b38..57f7f77 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -60,7 +60,11 @@ esac
 if [ -z "$SUBDIRECTORY_OK" ]
 then
 	: ${GIT_DIR=.git}
-	GIT_DIR=$(GIT_DIR="$GIT_DIR" git-rev-parse --git-dir) || exit
+	GIT_DIR=$(GIT_DIR="$GIT_DIR" git-rev-parse --git-dir) || {
+		exit=$?
+		echo >&2 "You need to run this command from the toplevel of the working tree."
+		exit $exit
+	}
 else
 	GIT_DIR=$(git-rev-parse --git-dir) || exit
 fi
-- 
1.5.0.rc1.g397d
