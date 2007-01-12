From: koreth@midwinter.com
Subject: [PATCH] Friendlier error message for commands that can't be run from a subdirectory.
Date: Fri, 12 Jan 2007 10:35:48 -0800
Message-ID: <20070112183548.GA3940@midwinter.com>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net> <200701121501.24642.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 19:36:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5RFr-0002Ob-O0
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 19:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbXALSfu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 13:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbXALSfu
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 13:35:50 -0500
Received: from tater.midwinter.com ([216.32.86.90]:43557 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964947AbXALSft (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 13:35:49 -0500
Received: (qmail 4082 invoked by uid 1001); 12 Jan 2007 18:35:48 -0000
To: Andy Parkins <andyparkins@gmail.com>
Content-Disposition: inline
In-Reply-To: <200701121501.24642.andyparkins@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36690>

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---

This doesn't fix the underlying problem (those commands ought to work
from any directory) but it is at least less baffling for the common case.
It's pretty braindead -- if you for some reason have a .git directory
inside one of your subdirectories, you'll get the old error message.

 git-sh-setup.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 4a02b38..803a3bc 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -60,6 +60,9 @@ esac
 if [ -z "$SUBDIRECTORY_OK" ]
 then
 	: ${GIT_DIR=.git}
+	if [ ! -d "$GIT_DIR" ]; then
+		die "This command must be run from the root directory of a git repository."
+	fi
 	GIT_DIR=$(GIT_DIR="$GIT_DIR" git-rev-parse --git-dir) || exit
 else
 	GIT_DIR=$(git-rev-parse --git-dir) || exit
-- 
1.5.0.rc0.g4083
