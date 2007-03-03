From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull fails to exit with non-zero status after fatal error
Date: Sat, 3 Mar 2007 19:13:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703031913100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45E9A641.8020002@lightspeed.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Larry Streepy <larry@lightspeed.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 19:13:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNYk2-0000cr-64
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 19:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbXCCSNq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 13:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbXCCSNq
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 13:13:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:53431 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030349AbXCCSNp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 13:13:45 -0500
Received: (qmail invoked by alias); 03 Mar 2007 18:13:44 -0000
X-Provags-ID: V01U2FsdGVkX1/zPS9ol+Lz9asLELtvw3eHsUex4YdKQBxyGjNXds
	8T4tAv2oRlcdhu
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45E9A641.8020002@lightspeed.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41306>

Hi,

On Sat, 3 Mar 2007, Larry Streepy wrote:

> We have just upgraded to 1.5 (don't know if this is specific to 1.5, but just
> in case).  When I perform a git-pull on a working repo that has a modified
> file, git pull refuses to do the pull, as shown below:
> 
> $ git pull
> Updating b5d9263..506b347
> tools/Pvt/Pvt.py: needs update
> fatal: Entry 'tools/Pvt/Pvt.py' not uptodate. Cannot merge.
> $ echo $?
> 0
> 
> Notice the exit status of 0.

Does this fix it?

diff --git a/git-merge.sh b/git-merge.sh
index 498c938..6b23bf5 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -295,8 +295,9 @@ f,*)
 	new_head=$(git-rev-parse --verify "$1^0") &&
 	git-read-tree -v -m -u --exclude-per-directory=.gitignore $head "$new_head" &&
 	finish "$new_head" "Fast forward"
+	ret=$?
 	dropsave
-	exit 0
+	exit $ret
 	;;
 ?,1,?*"$LF"?*,*)
 	# We are not doing octopus and not fast forward.  Need a
