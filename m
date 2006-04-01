From: Pavel Roskin <proski@gnu.org>
Subject: Default remote branch for local branch
Date: Fri, 31 Mar 2006 20:48:18 -0500
Message-ID: <1143856098.3555.48.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Apr 01 03:48:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPVEC-0001aK-5C
	for gcvg-git@gmane.org; Sat, 01 Apr 2006 03:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWDABsY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 20:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWDABsY
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 20:48:24 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:22417 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751468AbWDABsX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Mar 2006 20:48:23 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FPVDw-00018n-03
	for git@vger.kernel.org; Fri, 31 Mar 2006 20:48:20 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1FPVDv-0001M4-3V
	for git@vger.kernel.org; Fri, 31 Mar 2006 20:48:19 -0500
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18239>

Hello!

This is not a ready-to-use proposal, but I think my message can prompt
useful changes in GIT or in the "porcelain".

Let's see how remote changes end up in the head branch of the local
repository (sorry for possible mistakes in terminology):

branch in          "remote"              local              index,
a remote  -------> branch       -------> branch     ------> tree
repository         (e.g. origin)         (e.g. master)

Brought in sync by:
           fetch                 merge              checkout

Relationship stored in:
          .git/remotes           nowhere!!!         .git/HEAD

If I fetch a remote branch, git knows where to get changes.  If I change
the current branch, git remembers that.  But git doesn't remember the
relationship between branches mirroring the remote branches and branches
used for local development.

There are situations when I want to work for a significant time on a
certain branch.   Significant time means that changes are made by
others, and I'm supposed to integrate them and make more changes.  Yet I
may want to take advantage of some patches from another team that uses
the other repository.

I want GIT and porcelains work the same way if I'm working with
repository 1 or repository 2.  As it stands now, git gives preferential
treatment to the "origin" branch.  Whatever branch I'm on, "git-pull"
will pull from "origin".  I believe the special role of the "origin"
branch should be reduced to cg-clone and similar commands.

I think it would be convenient to have git remember the remote branch
for the given local branch.  git should know that if HEAD points to
"local-B", "git-fetch" should fetch from "remote-B", not from "origin".

To implement this, git would have to implement attributes for local
branches (other ideas are welcome).  Currently, there are no attributes
for local branches other than the top SHA1 in .git/refs/heads/

Once at the topic of branch attributes, let's see what else could be
useful?  I think that would be the creator of the branch and the comment
(e.g. "this is for tested commits only, to be merged tomorrow" etc).
Where can this data be stored?  Probably in blobs pointed to by refs in
e.g. .git/refs/branch-data/ or just in plain files e.g.
under .git/branch-data/

I know, it sounds like a lot of work to save a few keystrokes.  But I
think it may be worth it.  Working on different branches should have the
same "look and feel".  Otherwise, git would repeat a design error of
CVS, where the head branch was given preference e.g. for date based
updates.

I'm sorry, reading this mailing list is beyond my capabilities, so
certain overlaps with other postings may be expected, unless I'm
suggesting something totally off-base :-)

-- 
Regards,
Pavel Roskin
