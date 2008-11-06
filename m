From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Git SVN Rebranching Issue
Date: Thu, 6 Nov 2008 01:39:17 -0800
Message-ID: <20081106093917.GA15686@untitled>
References: <20081103140746.GA5969@mars.cyantechnology.local> <20081104084111.GB14405@untitled> <20081104094224.GC24100@dpotapov.dyndns.org> <20081105003318.GA5666@hand.yhbt.net> <32541b130811041640x18e3bbfewa639df356ff7561e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Matt Kern <matt.kern@undue.org>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 10:40:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky1M5-0005N0-LS
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 10:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504AbYKFJjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 04:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753473AbYKFJjW
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 04:39:22 -0500
Received: from hand.yhbt.net ([66.150.188.102]:38471 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753334AbYKFJjU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 04:39:20 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id DD1212DC01A;
	Thu,  6 Nov 2008 09:39:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <32541b130811041640x18e3bbfewa639df356ff7561e@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100221>

Avery Pennarun <apenwarr@gmail.com> wrote:
> On Tue, Nov 4, 2008 at 7:33 PM, Eric Wong <normalperson@yhbt.net> wrote:
> > Dmitry Potapov <dpotapov@gmail.com> wrote:
> >> On Tue, Nov 04, 2008 at 12:41:11AM -0800, Eric Wong wrote:
> >> >
> >> > Short answer: you can use grafts to remove parents.
> >>
> >> Using grafts requires some cautious, especially when it is used to make
> >> some commits unreachable, because git gc can remove unreachable commits.
> >> Also, a repository with grafts cannot be cloned.  So using grafts looks
> >> like more as workaround rather a real solution.
> >
> > I don't think extra history is harmful at all, so the grafts could even
> > be temporary.  AFAIK, the extra history is only an aesthetic issue in
> > visualizers (and I actually like to see it myself).
> 
> But it's *lying* history in this case; it doesn't reflect what really
> happened in svn *or* in real life.  I'd say lying history is most
> often harmful.  "git blame" and "git log" will lie in this case, for
> example.

Maybe, but I don't find having a choice to follow _either_:
  a) copy history (the REAL history)
  b) the name history (faked)

I've had to deal with repositories that recycled branch names for a
while now and it hasn't been an issue for me nor anybody else
using git svn on them.

git log --first-parent exists for following copy history, too.

> >> Would it not be better to save the old branch using "@SVN-NUMBER" as
> >> suffix? Thus, those do not need the old branch can easily delete it.
> >
> > That would require renaming _existing_ branches to their "@SVN-NUMBER"
> > name; which would break mechanisms for tracking branches based on
> > refname.
> 
> Well, you wouldn't have to rename the existing branch.  You would
> simply create the new @SVN-NUMBER branch when it became clear that
> that commit is no longer reachable from the undecorated branch ref.
> Isn't that why the @SVN-NUMBER branches are needed in the first place?

Making @SVN-NUMBER branches for new/latest branches is even more
confusing.  That would mean the user would have to remember the
@SVN-NUMBER every time they wanted to do operations with the
recycled branch.

The current use of @SVN-NUMBER in branches are only used when following
parents (when repositories are rearranged).  In retrospect, it's
probably possible to for git-svn to not make them user-visible (I seem
to recall they made development/debugging/testing easier in the past,
though).

> As for tracking branches based on refname, it seems like the current
> behaviour of pretending to merge histories together wouldn't work too
> well anyway.  For someone pulling from the messed-up branch, they
> really *will* need to rewind and re-pull, since that's exactly what
> happened in svn.  I don't think git has any chance of doing this
> automatically just because of a new commit with two parents.

"git svn rebase" and "git log ..$RECYCLED" both work.  non-FF/non-squash
pulls won't, of course.

> Disclaimer: I haven't run into any of this myself since I don't
> recycle branch names in svn :)

Lucky you :)

-- 
Eric Wong
