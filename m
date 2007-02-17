From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Convert update-index references in docs to add.
Date: Sat, 17 Feb 2007 10:20:06 -0800
Message-ID: <7vvei0tzmx.fsf@assigned-by-dhcp.cox.net>
References: <20070217094342.GA496@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Feb 17 19:20:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIUAO-0001Cg-JT
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 19:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993039AbXBQSUI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 13:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993041AbXBQSUI
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 13:20:08 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:44266 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993039AbXBQSUH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 13:20:07 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070217182007.XRID21704.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Feb 2007 13:20:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QiL61W0011kojtg0000000; Sat, 17 Feb 2007 13:20:06 -0500
In-Reply-To: <20070217094342.GA496@spearce.org> (Shawn O. Pearce's message of
	"Sat, 17 Feb 2007 04:43:42 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40002>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Since `git add` is the approved porcelain for an end-user to invoke
> when they want to manipulate the index, porcelain documentation
> should steer the user to this command rather than the pure plumbing
> update-index.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>
>  Maybe this isn't the best change to make.  I dunno.  I think it is
>  cleaner to keep the user looking at add instead of update-index,
>  but what do I know.  :-)

I think I agree with most of your changes, except in a few
places we should suggest 'git rm' to resolve conflict as
deletion of paths.  On top of your patch, something like the
attached.

One thing I suspect is that currently we refuse to 'git rm' if
the index does not match working tree and HEAD, but it might
make sense to skip that check when the path is unmerged in the
index.


diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index f65514e..1ae77be 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -61,7 +61,8 @@ OPTIONS
 +
 When a merge conflict happens, the index entries for conflicting
 paths are left unmerged, and you need to resolve the conflicts
-and mark the resolved paths with `git add`.
+and mark the resolved paths with `git add` (or `git rm` if the merge
+should result in deletion of the path).
 
 <new_branch>::
 	Name for the new branch.
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 911c69b..9c08efa 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -136,7 +136,7 @@ After seeing a conflict, you can do two things:
 
  * Resolve the conflicts.  `git-diff` would report only the
    conflicting paths because of the above 2. and 3..  Edit the
-   working tree files into a desirable shape, `git-add`
+   working tree files into a desirable shape, `git-add` or `git-rm`
    them, to make the index file contain what the merge result
    should be, and run `git-commit` to commit the result.
 
diff --git a/Documentation/git-runstatus.txt b/Documentation/git-runstatus.txt
index e95662b..8bb52f4 100644
--- a/Documentation/git-runstatus.txt
+++ b/Documentation/git-runstatus.txt
@@ -16,7 +16,7 @@ DESCRIPTION
 Examines paths in the working tree that has changes unrecorded
 to the index file, and changes between the index file and the
 current HEAD commit.  The former paths are what you _could_
-commit by running 'git add' before running 'git
+commit by running 'git add' (or 'git rm' if you are deleting) before running 'git
 commit', and the latter paths are what you _would_ commit by
 running 'git commit'.
 
