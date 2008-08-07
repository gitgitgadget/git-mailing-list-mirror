From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: [PATCH A] GIT-VERSION-GEN: refresh the index before judging a working dir to be dirty
Date: Thu, 7 Aug 2008 17:16:00 +0200
Message-ID: <14341e3a48ec86021f933361af9b02b542cc7c04.1218137290.git.christian@jaeger.mine.nu>
References: <sjj6zt28jy9qy7y8@jaeger.mine.nu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 22:20:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRByi-0000P3-Am
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 22:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbYHGUTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 16:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbYHGUTy
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 16:19:54 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:52672 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752962AbYHGUTy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 16:19:54 -0400
Received: (qmail 27385 invoked by uid 1000); 7 Aug 2008 20:19:52 -0000
In-Reply-To: <sjj6zt28jy9qy7y8@jaeger.mine.nu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91602>

When building under the control of the "fakeroot" tool [*], as is the
case when building a Debian package using "dpkg-buildpackage
-rfakeroot", GIT-VERSION-GEN appended "-dirty" to the version number;
this happens because "git diff-index --name-only HEAD --" would report
all files as changed if they have a non-root owner/group, since they
appear as owned by root under fakeroot, leading to non-empty
output. Refreshing the index first makes the decision based on content
changes only.

[*] http://fakeroot.alioth.debian.org/

Signed-off-by: Christian Jaeger <christian@jaeger.mine.nu>
---
 GIT-VERSION-GEN |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index cb7cd4b..e6ff486 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -16,6 +16,7 @@ elif test -d .git -o -f .git &&
 	case "$VN" in
 	*$LF*) (exit 1) ;;
 	v[0-9]*)
+		git update-index --refresh
 		test -z "$(git diff-index --name-only HEAD --)" ||
 		VN="$VN-dirty" ;;
 	esac
-- 
1.6.0.rc2.1.g7e734
