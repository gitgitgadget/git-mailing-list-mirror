From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: remove redundant slashes from show-ignore
Date: Sat, 29 Mar 2008 16:37:17 -0700
Message-ID: <20080329233717.GA16157@soma>
References: <b762bfda0803291340ta70ee88k8d5d7c7e384e41e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 30 00:38:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jfkcc-0005IC-Kf
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 00:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbYC2XhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 19:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbYC2XhU
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 19:37:20 -0400
Received: from hand.yhbt.net ([66.150.188.102]:40867 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920AbYC2XhU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 19:37:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 65CDF7F4153;
	Sat, 29 Mar 2008 16:37:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <b762bfda0803291340ta70ee88k8d5d7c7e384e41e0@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78491>

Jonathan Scott Duff wrote:
> Recently I tried "git svn showignore" on my parrot repository and it
> failed.  I tracked it down to the prop_walk() sub.  When it recurses,
> $path has an extra / on the beginning (i.e., when it recurses, it
> tries to get the props for "//apps" instead of "/apps").   I *think*
> this is because $path is used in the recursive call rather than $p
> (which seems to contain a properly transformed $path).  Anyway, I've
> attached a patch that works for me and I think is generally the right
> thing.

Patch-submitted-by: Jonathan Scott Duff
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 Thanks Jonathan

 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 073471f..bc0c22c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1903,7 +1903,7 @@ sub prop_walk {
 
 	foreach (sort keys %$dirent) {
 		next if $dirent->{$_}->{kind} != $SVN::Node::dir;
-		$self->prop_walk($path . '/' . $_, $rev, $sub);
+		$self->prop_walk($p . $_, $rev, $sub);
 	}
 }
 
-- 
Eric Wong
