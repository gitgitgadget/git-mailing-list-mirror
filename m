From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: handling merge-base failures
Date: Sun, 3 Jan 2010 19:45:41 -0800
Message-ID: <20100104034540.GA4548@dcvr.yhbt.net>
References: <931B0483-7628-488E-BB9F-C40346353149@apple.com> <7878A426-9D87-43B5-A10A-38F3C9369165@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Andrew Myrick <amyrick@apple.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 04:46:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRdtg-0007FO-U7
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 04:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988Ab0ADDpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2010 22:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752979Ab0ADDpo
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 22:45:44 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:34699 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917Ab0ADDpn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jan 2010 22:45:43 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2672D1F4E5;
	Mon,  4 Jan 2010 03:45:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7878A426-9D87-43B5-A10A-38F3C9369165@apple.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136089>

Andrew Myrick <amyrick@apple.com> wrote:
> On Dec 23, 2009, at 11:54 AM, Andrew Myrick wrote:
> > One of my projects is failing to clone because merge-base is failing
> > on one of the revisions; the branch is a partial branch, so
> > merge-base can't find a common ancestor with trunk.  I'd like to
> > catch the exception that command_oneline should throw when
> > merge-base fails,
> 
> Instead of using the Error.pm module, I was able to handle the
> exception with the more basic eval block.  However, there are some
> details here I would like to discuss with the community.
> 
> When git-svn fetches a partial branch, it appears to refetch all of
> the history of the subdirectory from which the branch was created.
> This creates new commits for the old revisions, and these new commits
> exist as a separate history for the partial branch.   When git-svn
> fetches the revision at which this partial branch is merged back to
> trunk, git-svn attempts to run merge-base to find a common ancestor.
> However, because the partial branch has its own history, the
> merge-base fails, and git-svn dies.
> 
> Naively handling the exception with an eval block and skipping the
> merge ticket works fine in that it brings us back to parity with git
> 1.6.5.7, but it means that the merge parent relationship between trunk
> and the partial branch is lost.  Is there any way to preserve this
> information, or does the separate commit history of the partial branch
> make it fundamentally impossible?

Hi Andrew,

A method of preserving the $SVN_PATH <=> $PARENT@$REV mapping for
reusing follow_parent-created branches is definitely desired.

I've just been lacking time and motivation these days with other
projects taking priority.  Help (even if it's just to refactor/cleanup
existing code) would definitely be appreciated here.

> I've created a small svn repository that demonstrates this failure
> with git v1.6.6.  Its dump is attached.

Thanks.  This (and a similar dump a few weeks back) will definitely
come in handy for writing test cases and fixing this long-standing
issue.

-- 
Eric Wong
