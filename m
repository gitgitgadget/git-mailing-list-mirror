From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Feature request: fetch --prune by default
Date: Thu, 19 Jul 2012 21:34:38 +0400
Message-ID: <20120719213438.1cc7ca77a9cb3367a3be0539@domain007.com>
References: <2C63E314-2EF5-4B8E-B96A-5306E317E045@gmail.com>
	<20120719115558.GC29774@sigill.intra.peff.net>
	<88300470-AB41-4317-8B97-81DC18FD5899@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Alexey Muranov <alexey.muranov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 19:34:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Srucq-0001Nj-Tf
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 19:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597Ab2GSRev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 13:34:51 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:47717 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab2GSRes (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 13:34:48 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id q6JHYcup007885;
	Thu, 19 Jul 2012 21:34:39 +0400
In-Reply-To: <88300470-AB41-4317-8B97-81DC18FD5899@gmail.com>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201748>

On Thu, 19 Jul 2012 18:21:21 +0200
Alexey Muranov <alexey.muranov@gmail.com> wrote:

[...]
> I do not still understand very well some aspects of Git, like the
> exact purpose of "remote tracking branches" (are they for pull or for
> push?), so i may be wrong.
This is wery well explained in the Pro Git book, for instance.
And in numerous blog posts etc.

> However, i thought that a user was not
> expected to follow the moves of a remote branch of which the user is
> not an owner: if the user needs to follow the brach and not lose its
> commits, he/she should create a remote tracking branch.
This would present another namespacing issue: how would you name the
branches you're interested in so that they don't clash with your own
personal local branches?  You'd have to invent a scheme which would
encode the remote's name in a branch name.  But remote branches already
do just this.  So you create a remote tracking branch when you intend
to actually *develop* something on that branch with the final intention
to push that work back.

> > So I think it would be a lot more palatable if we kept reflogs on
> > deleted branches. That, in turn, has a few open issues, such as how
> > to manage namespace conflicts (e.g., the fact that a deleted "foo"
> > branch can conflict with a new "foo/bar" branch).
> 
> I prefer to think of a remote branch and its local copy as the same
> thing, which are physically different only because of current real
> world/hardware/software limitations, which make it necessary to keep
> a local cache of remote data.  With this approach, reflogs should be
> deleted with the branch, and there will be no namespace conflicts.
It appears, the distributed nature of a DVCS did not fully sink into
your mindset yet. ;-)
Looks like you mentally treat a Git remote as a thing being used to
access a centralized "reference" server which maintains a master copy
of a repository, of which you happen to also have a local copy.
Then it's quite logically to think that if someone deleted a branch in
the master copy, everyone "downstream" should have the same
remote branch deleted to be in sync with that master copy.
But this is not the only way to organize your work.
You could fetch from someone else's repository and be interested in
their branch "foo", but think what happens when you fetch next time from
that repo and see Git happily deleting your local branch thatremote/foo
simply because someone with push access deleted that branch from the
repo.  This might *not* be what you really want or expect.
