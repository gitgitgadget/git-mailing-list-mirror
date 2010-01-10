From: Steven Drake <sdrake@xnet.co.nz>
Subject: [PATCH 2/2] Use $(git rev-parse --show-toplevel) in
 cd_to_toplevel()
Date: Sun, 10 Jan 2010 20:19:21 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1001102016380.2560@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 10 08:44:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTsTN-0000Sk-7b
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 08:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968Ab0AJHoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 02:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685Ab0AJHoZ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 02:44:25 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:46581 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402Ab0AJHoY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 02:44:24 -0500
X-Greylist: delayed 1146 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Jan 2010 02:44:24 EST
Received: from idran.drake.org.nz (ip-118-90-54-75.xdsl.xnet.co.nz [118.90.54.75])
	by ananke.wxnz.net (Postfix) with ESMTP id 5DBFA170DAB
	for <git@vger.kernel.org>; Sun, 10 Jan 2010 20:25:24 +1300 (NZDT)
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136562>

as it gives the absolute (aka "physical") path of the toplevel directory 
and 'cd -P' is not supported by all shell implementations.

See NetBSD PR/42168.
http://www.netbsd.org/cgi-bin/query-pr-single.pl?number=42168
---
 git-sh-setup.sh |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index dfcb807..3cbec05 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -120,16 +120,10 @@ is_bare_repository () {
 }
 
 cd_to_toplevel () {
-	cdup=$(git rev-parse --show-cdup)
-	if test ! -z "$cdup"
+	if test ! -z "$(git rev-parse --show-cdup)"
 	then
-		# The "-P" option says to follow "physical" directory
-		# structure instead of following symbolic links.  When cdup is
-		# "../", this means following the ".." entry in the current
-		# directory instead textually removing a symlink path element
-		# from the PWD shell variable.  The "-P" behavior is more
-		# consistent with the C-style chdir used by most of Git.
-		cd -P "$cdup" || {
+		cdup=$(git rev-parse --show-toplevel)
+		cd "$cdup" || {
 			echo >&2 "Cannot chdir to $cdup, the toplevel of the working tree"
 			exit 1
 		}
-- 
1.6.4
