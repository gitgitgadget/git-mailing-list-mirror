From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 27 Nov 2007 10:34:11 -0500
Message-ID: <20071127153411.GA11731@fieldses.org>
References: <200711270622.lAR6MFXQ010010@mi0.bluebottle.com> <Pine.LNX.4.64.0711271109130.27959@racer.site> <alpine.LFD.0.99999.0711270917580.9605@xanadu.home> <20071127150829.GB3853@fieldses.org> <alpine.LFD.0.99999.0711271013310.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Andreas Ericsson <ae@op5.se>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 16:35:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix2Sc-0004Fq-0a
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 16:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757701AbXK0PeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 10:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759152AbXK0PeW
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 10:34:22 -0500
Received: from mail.fieldses.org ([66.93.2.214]:45830 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756968AbXK0PeV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 10:34:21 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Ix2Rv-0003Jc-Pk; Tue, 27 Nov 2007 10:34:11 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99999.0711271013310.9605@xanadu.home>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66231>

On Tue, Nov 27, 2007 at 10:19:53AM -0500, Nicolas Pitre wrote:
> On Tue, 27 Nov 2007, J. Bruce Fields wrote:
> 
> > On Tue, Nov 27, 2007 at 09:29:21AM -0500, Nicolas Pitre wrote:
> > > Being much more involved in the maintenance of a published Git tree 
> > > lately, I must disagree with the "wrong workflow" statement.  Until the 
> > > stuff I maintain is finally merged upstream, I have to constantly 
> > > amend/replace/fold/split random commits in my repo to follow the review 
> > > cycles involved.  yet I have to publish the result to let others base 
> > > their work on top of my latest tree.  A fetch+rebase is the only option 
> > > for those following my tree, and I made it clear that they have to 
> > > rebase after a fetch because I constantly rebase commits that I have 
> > > already published myself.
> > 
> > Right.  But a rebase "merge strategy" doesn't work for those people,
> > because it's not possible in general for their git to know exactly which
> > part is their work (which needs to be rebased) and which is your old
> > work (which should be discarded).  Manual inspection is required.
> 
> I don't follow.
> 
> Their work is always origin/master@{1}..HEAD after origin/master has 
> been updated through a fetch, and it needs to be rebased on 
> origin/master.

No, their work isn't always based on origin/master@{1}.  Often they've
got more than one project going.  If they try

	git checkout project-1
	git pull -s rebase
	git checkout project-2
	git pull -s rebase

what's going to happen?  What if project-2 has been on the back burner
for a few months and they're just getting around to rebasing it now?
What if their various projects are based on different upstream branches,
but the fetch done by git-pull updates them all at once?  What if they
did a git fetch earlier just to peek at current development and are only
now getting around to updating their own branches?

And I don't think any of those are crazy corner cases; I know at least
that I do all of those things.

> > Again, if you have people basing work on top of yours, I think the best
> > option may really be to add a merge commit on top of each new version of
> > the series with first parent the new series and second parent the
> > previous history.
> > 
> > That way the history does have the information necessary to rebase their
> > work automatically.
> 
> And my repo will then be full of clutter which no one upstream will ever 
> accept to merge.  Can't do that.

No, it's no problem--you just submit branch^.  You probably want to give
it a throw-away name for the purpose of the request-pull message, e.g.:

	git branch for-linus HEAD^
	git push my-pub-repo for-linus

then delete for-linus after you see it merged.

But use for-linus only for that, and advertise "branch" as the base
people should be using for ongoing development.

I don't know, maybe it's too complicated.  But I think it's the only way
to get a really robust automated process for the people basing work on
your branch.

--b.
