From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: bug in git diff --unified=0 ?
Date: Sat, 2 May 2009 16:47:01 -0700
Message-ID: <20090502234701.GL23604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 03 01:47:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0OvG-0001Zv-P3
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 01:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbZEBXrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 19:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752676AbZEBXrB
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 19:47:01 -0400
Received: from george.spearce.org ([209.20.77.23]:49692 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbZEBXrA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 19:47:00 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5109238081; Sat,  2 May 2009 23:47:01 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118149>

I can't decide if this is a bug in JGit, or a bug in CGit, or just
an area where the patch format is very unclear.

The following 2 patches are identical, but use different context:

git diff --unified=1:

    diff --git a/X b/X
    index a3648a1..2d44096 100644
    --- a/X
    +++ b/X
    @@ -2,2 +2,3 @@
     b
    +c
     d
    @@ -16,4 +17,2 @@
     q
    -r
    -s
     t

git diff --unified=0:

    diff --git a/X b/X
    index a3648a1..2d44096 100644
    --- a/X
    +++ b/X
    @@ -2,0 +3 @@
    +c
    @@ -17,2 +17,0 @@
    -r
    -s
    
Now lets look at JGit's output of that last patch, unified=0:

    diff --git a/X b/X
    index a3648a1..2d44096 100644
    --- a/X
    +++ b/X
    @@ -3,0 +3,1 @@
    +c
    @@ -17,2 +18,0 @@
    -r
    -s

Notice that `git diff --unified=1` said the first hunk started on
line 2 of the pre-image, as the 2nd line of the file is the context
line "b\n".  I call that correct.

However, `git diff --unified=0` said the first hunk started on line
2 of the pre-image, but there is no pre-image mentioned.  JGit says
it starts on line 3 of the pre-image, because the script is adding
a "c\n" on line 3.

The exact opposite behavior can be seen in the 2nd hunk, where we
delete lines.  Again, `git diff --unified=0` seems to behave as
though we had 1 line of context, but we don't.

-- 
Shawn.
