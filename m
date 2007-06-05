From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn adding too many blank lines during git-cherry-pick, and git-cherry getting confused
Date: Tue, 5 Jun 2007 03:24:49 -0700
Message-ID: <20070605102449.GB12948@muzzle>
References: <20070602045007.GJ27013@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 12:24:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvWDh-00054a-2B
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 12:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763729AbXFEKYv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 06:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763738AbXFEKYv
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 06:24:51 -0400
Received: from hand.yhbt.net ([66.150.188.102]:52405 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763729AbXFEKYu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 06:24:50 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 7112F2DC034;
	Tue,  5 Jun 2007 03:24:49 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 05 Jun 2007 03:24:49 -0700
Content-Disposition: inline
In-Reply-To: <20070602045007.GJ27013@curie-int.orbis-terrarum.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49183>

"Robin H. Johnson" <robbat2@gentoo.org> wrote:
> Hi,
> 
> Bit of weirdness I ran into.
> 
> I have a SVN tree, with a branch that gets some backported fixe (they
> usually apply cleanly).
> 
> I commit the fix to the trunk + git-svn dcommit, and then switch to the
> other branch, and git-cherry-pick the fix.
> 
> For git-svn commits, the log has:
> On the trunk side, there is a two blank line before git-svn-id.
> On the branch side, there are three blank lines before git-svn-id.
> If I cherry-pick from that branch to a third branch, I get 4 blank
> lines.
> 
> For regular SVN commits, the log has:
> Only a single blank line before git-svn-id.
> 
> I think the source of the problem is that git-svn-id is being removed
> when cherry-picking, but NOT the leading blank line.
> 
> This all leads to the hashes of the commits diverging badly, and then
> git-cherry gets very confused when asked to compare the trunk vs. the
> branches.
> 
> How do we solve it?
> This is only on a conceptual level here, looking at the present state of
> git-svn, I'm not sure how best to solve it.
> 
> git-svn fetch:
> 1. Get commit message from SVN. 
> 2. Trim ALL trailing blank lines (and existing git-svn-id lines).
> 3. If the last line was header-style (Signed-off-by, CC, etc)
> 3.1. if it was, do not add a blank line.
> 3.2. If not, add a single blank line.
> 4. Insert git-svn-id header.

Too much magic.  I don't think this is a good idea, at least
not by default.

> git-svn dcommit:
> 1. Get commit message (git cat-file commit ....)
> 2. Remove the git-svn-id line.
> 3. Remove all trailing blank lines.
> 4. Commit.

We already do step 3.  The problem is that we fail to remove the newline
*before* the git-svn-id line.  I'll make a mental note to fix this
sometime this week, I hope.

-- 
Eric Wong
