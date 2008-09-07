From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: [RFC] cherry-pick using multiple parents to implement -x
Date: Sun, 7 Sep 2008 12:34:15 +0200
Message-ID: <20080907103415.GA3139@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 07 12:35:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcHc4-0004zg-DN
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 12:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184AbYIGKeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 06:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753039AbYIGKeS
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 06:34:18 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:40460 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757AbYIGKeR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 06:34:17 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id AA9A45465; Sun,  7 Sep 2008 12:34:15 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95133>

I've been converting some old CVS repositories to git, and as it turns
out, these repositories consist of a number of main branches of the same
project that were created at several points in time (the stable release
branches), and the branches contain numerous backports (and a few
forward ports) between each other.

I.e. the branches split off each other at various points in time, and
evolved independently ever since (except for the numerous backports).

Now, the backports can be implemented using a mere "git cherry-pick -x",
but that creates this silly text references to the original commits.
I'd rather use something that gitk can visualise.

So I tried to use the parents of the commit to reference the origin(s).
I.e. the first parent links to the linear history on a given branch, but
the second (and possibly more) parents point to the cherry-picked
back-ported commit from another branch.  This graft-constructed
repository is then fed to filter-branch to make it permanent.
To view it try: git://pike-git.lysator.liu.se/pikex

This works quite well and shows the following results:
- gitk shows proper grafts.
- gitk properly shows a zero-diff between the new commit and the
  commits we cherry-picked from.
- It even works perfectly when picking from multiple parents.
- gitk is confused in its display of tags preceding and following this
  commit (depending on the situation it mixes up the branches).

Obviously the reason it works rather well is because git can actually
distinguish between a merge and a backport because of the way the
contents of the trees change.

The questions now are:
- Would there be good reason not to record the backport/forwardport
  relationship in the additional parents of a commit?
- Since most of the git machinery (git diff, and gitk, most notably)
  seem to work just fine when using parents for that purpose, would it
  be acceptable to create a patch to cherry-pick to support an option to
  record the backport/forwardport relationship in the second (or more)
  parent field(s)?
- And depending on an affirmative on the previous question, would it be
  acceptable to teach the gitk preceding/following tag listing to deal
  with these backport/forwardports ?
-- 
Sincerely,
           Stephen R. van den Berg.

"The future is here, it's just not widely distributed yet." -- William Gibson
