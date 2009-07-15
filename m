From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Dividing up a large merge.
Date: Wed, 15 Jul 2009 14:57:59 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0907151429490.2147@iabervon.org>
References: <20090714233246.GA25390@huya.quicinc.com> <3e8340490907141716j77df346es1f894d6a7f6cb0aa@mail.gmail.com> <20090715002926.GA26630@huya.quicinc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bryan Donlan <bdonlan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: davidb@quicinc.com
X-From: git-owner@vger.kernel.org Wed Jul 15 20:58:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR9gB-0004xp-1s
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 20:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbZGOS6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 14:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbZGOS6D
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 14:58:03 -0400
Received: from iabervon.org ([66.92.72.58]:45030 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932171AbZGOS6C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 14:58:02 -0400
Received: (qmail 21214 invoked by uid 1000); 15 Jul 2009 18:57:59 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Jul 2009 18:57:59 -0000
In-Reply-To: <20090715002926.GA26630@huya.quicinc.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123330>

On Tue, 14 Jul 2009, davidb@quicinc.com wrote:

> On Tue, Jul 14, 2009 at 05:16:54PM -0700, Bryan Donlan wrote:
> 
> > What do you mean by describing a merge? git is designed to have all
> > the information needed for a merge inherent in the repository history.
> 
> Yes, provided you can actually do the merge all at once.
> 
> > Why are there so many conflicts to make this an issue?
> 
> Because I have to work in the "real world".
> 
> > If the commits are isolated to small changes, rebasing the developer
> > topic branches instead of merging may help, by allowing you to take
> > conflicts one commit at a time. For example, if your problems are
> > primarily conflicts between developer branches and upstream:
> 
> No real developer branches with conflicts (I make those be
> fixed), but several upstreams.  We have many developers busily
> doing work, and one or more other companies is also working on
> the same code.  Meanwhile, the mainline kernel advances at it's
> own astounding rate.
> 
> Unfortunately, paying customers will always get priority of work,
> even when that position is actually somewhat shortsighted and it
> makes for a lot of merge effort later.
> 
> The real issue is that there isn't any single individual who
> understands all of the code that conflicts.  It has to be divided
> up somehow, I'm just trying to figure out a better way of doing
> it.

It sounds to me like you're maintaining an internal version that everybody 
merges their stuff into, and you periodically merge that with the mainline 
kernel (generating a lot of conflicts which have to be resolved at the 
same time). Instead of merging the branch that contains a lot of merges, 
it would probably be easier to merge into a clone of mainline each of the 
things that was merged before. That is, instead of merging less than all 
of two trees, you'd merge commits which are not the newest commit on the 
branch, choosing ones that individuals can resolve.

This also has the advantage where, if two of the changes affect an API 
that's used in various different places, one person will get the 
responsibility of resolving each of those conflicts, despite them being in 
the middle of code they don't really understand, because they understand 
what happened with the API and therefore what has to be done in that 
little spot. Dividing the merge up by parts of the content would split 
this work among people who aren't looking at the conflict in the 
definition of the API.

	-Daniel
*This .sig left intentionally blank*
