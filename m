From: Greg KH <greg@kroah.com>
Subject: Re: "git push" logic changed?
Date: Fri, 20 Jan 2006 16:15:47 -0800
Message-ID: <20060121001547.GA30712@kroah.com>
References: <20060120225336.GA29206@kroah.com> <7vlkxa30rd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 01:15:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F06Q1-0005kX-Id
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 01:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWAUAPp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 19:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWAUAPp
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 19:15:45 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:6609 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S932292AbWAUAPp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 19:15:45 -0500
Received: from press.kroah.org ([192.168.0.25] helo=localhost)
	by aria.kroah.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.54)
	id 1F06Pw-0006pE-Cd; Fri, 20 Jan 2006 16:15:44 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkxa30rd.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14981>

On Fri, Jan 20, 2006 at 04:03:50PM -0800, Junio C Hamano wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > As of the git development tree from last night, 'git push' seems to work
> > a bit differently now.
> 
> The change was 9e9b267.  I suspect the earlier way was a bit
> more friendly to savvier people (especially the subsystem
> maintainers and the project lead), but it was found to be
> confusing for people who clone from an upstream and then use
> that as a shared repository.  Their developers further clone
> from that shared repository, and as needed pull from the true
> upstream.  When they push their changes back, "git push
> central:/shared.git/" would trigger a "remote origin does not
> fast forward" error, depending on when these developers fetched
> from the shared repository the last time, and whether they
> stored what they fetched from the shared repository in their
> "origin" or not.  If you do "git pull central:/shared.git/", not
> "git pull origin" (taking advantage of remotes/origin file),
> your "origin" branch would become out-of-date.  Which is OK for
> the purpose of maintaining "master" branch properly, but pushing
> meaningless "origin" back to "origin" at the shared repository
> (which is also meaningless) was triggering an error and causing
> confusion in that setup.

Well what should I do then to push to "orgin"?
	$ git push
	Where would you want to push today?
	Usage: /home/greg/bin/git-push [--all] [--tags] [--force] <repository> [<refspec>...]

	$ git push origin
	No refs given to be pushed.

> > Or should I always be doing --all?
> 
> In order to make sure all your local refs are on the "parent",
> then yes.  And this is not new.  It used to push all the refs
> that appear in _both_ your local repo and the "parent" repo, so
> your new tags and branches did not get propagated so you needed
> to use '--all' in such a case anyway.  We now also have '--tags'
> to push all tags.

Yes, but "git push origin" used to push my local changes there, and
that's all I really want.

Someone off-list told me I could edit my .git/branches/parent file to
fix this issue for that branch.  Since I hand-created that file in the
first place, that's not a bit deal.  But I was relying on git to get the
"origin" branch right, as I didn't edit it at all :)

So, what I'm really just looking for is a simple way to push back to the
repository that I cloned this one from, as I only have one "repo" here.

> We could probably resurrect the earlier behaviour with a
> '--matching' option or something if you'd like.

It would be nicer not to break a previously working command :)

Or at least show me how to change it so I can just easily push back to
where I cloned the original from...

thanks,

greg k-h
