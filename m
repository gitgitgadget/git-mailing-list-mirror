From: Steven Drake <sdrake@xnet.co.nz>
Subject: [PATCH 2/2] Use $(git rev-parse --show-toplevel) in
 cd_to_toplevel().
Date: Tue, 12 Jan 2010 11:34:34 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1001121133520.10158@vqena.qenxr.bet.am>
References: <alpine.LNX.2.00.1001102011420.2560@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 23:40:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUSwP-0005lO-02
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 23:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292Ab0AKWkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 17:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752323Ab0AKWks
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 17:40:48 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:54506 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276Ab0AKWks (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 17:40:48 -0500
Received: from idran.drake.org.nz (ip-118-90-54-75.xdsl.xnet.co.nz [118.90.54.75])
	by ananke.wxnz.net (Postfix) with ESMTP id 110A5170B48;
	Tue, 12 Jan 2010 11:40:46 +1300 (NZDT)
In-Reply-To: <alpine.LNX.2.00.1001102011420.2560@vqena.qenxr.bet.am>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136675>

rev-parse --show-toplevel gives the absolute (aka "physical") path of the 
toplevel directory and is more portable as 'cd -P' is not supported by all 
shell implementations.

This is also closer to what setup_work_tree() does.

Signed-off-by: Steven Drake <sdrake@xnet.co.nz>
---
 git-sh-setup.sh |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index dfcb807..d56426d 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -120,20 +120,11 @@ is_bare_repository () {
 }
 
 cd_to_toplevel () {
-	cdup=$(git rev-parse --show-cdup)
-	if test ! -z "$cdup"
-	then
-		# The "-P" option says to follow "physical" directory
-		# structure instead of following symbolic links.  When cdup is
-		# "../", this means following the ".." entry in the current
-		# directory instead textually removing a symlink path element
-		# from the PWD shell variable.  The "-P" behavior is more
-		# consistent with the C-style chdir used by most of Git.
-		cd -P "$cdup" || {
-			echo >&2 "Cannot chdir to $cdup, the toplevel of the working tree"
-			exit 1
-		}
-	fi
+	cdup=$(git rev-parse --show-toplevel) &&
+	cd "$cdup" || {
+		echo >&2 "Cannot chdir to $cdup, the toplevel of the working tree"
+		exit 1
+	}
 }
 
 require_work_tree () {
-- 
1.6.4
