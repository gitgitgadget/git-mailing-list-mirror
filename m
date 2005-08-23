From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [RFC] Removing deleted files after checkout
Date: Tue, 23 Aug 2005 15:40:20 -0600
Organization: Hewlett Packard
Message-ID: <20050823214020.GA3763@hpsvcnb.fc.hp.com>
References: <20050823162156.GA32240@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0508231533570.23242@iabervon.org> <20050823205052.GA13311@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0508231713450.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Baldwin <cnb@fc.hp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 23:43:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7gW4-0005xY-1L
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 23:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVHWVlD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 17:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVHWVlB
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 17:41:01 -0400
Received: from palrel12.hp.com ([156.153.255.237]:39886 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S932401AbVHWVlB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2005 17:41:01 -0400
Received: from smtp2.fc.hp.com (smtp2b.fc.hp.com [15.15.136.253])
	by palrel12.hp.com (Postfix) with ESMTP id 98079402FF7;
	Tue, 23 Aug 2005 14:41:00 -0700 (PDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP
	id 3631741E257; Tue, 23 Aug 2005 21:40:20 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 2290A2CD92; Tue, 23 Aug 2005 15:40:20 -0600 (MDT)
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508231713450.23242@iabervon.org>
X-Origin: hpescnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7675>

On Tue, Aug 23, 2005 at 05:27:12PM -0400, Daniel Barkalow wrote:
> On Tue, 23 Aug 2005, Carl Baldwin wrote:
> 
> > On Tue, Aug 23, 2005 at 03:43:56PM -0400, Daniel Barkalow wrote:
> > > On Tue, 23 Aug 2005, Carl Baldwin wrote:
> > >
> > > > Hello,
> > > >
> > > > I recently started using git to revision control the source for my
> > > > web-page.  I wrote a post-update hook to checkout the files when I push
> > > > to the 'live' repository.
> > > >
> > > > In this particular context I decided that it was important to me to remove
> > > > deleted files after checking out the new HEAD.  I accomplished this by running
> > > > git-ls-files before and after the checkout.
> > > >
> > > > Is there a better way?  Could there be some way built into git to easily
> > > > find out what files dissappear when replacing the current index with one
> > > > from a new tree?  Is there already?  The behavior of git should NOT
> > > > change to delete these files but I would argue that some way should
> > > > exist to query what files disappeared if removing them is desired.
> > >
> > > If you don't use -f, git-checkout-script removes deleted files. Using -f
> > > tells it to ignore the old index, which means that it can't tell the
> > > difference between removed files and files that weren't tracked at all.
> >
> > Maybe I'm doing something wrong.  This does not happen for me.
> >
> > I tried a simple test with git v0.99.4...
> >
> > cd
> > mkdir test-git && cd test-git/
> > echo testing | cg-init
> > echo contents > file
> > git-add-script file
> > git-commit-script -m 'testing'
> 
> [point 1]
> 
> > cd ..
> > cg-clone test-git/.git/ test-git2
> > cd test-git2
> > cg-rm file
> > git-commit-script -m 'testing'
> > ls
> 
> > cg-push
> > cd ../test-git
> > git-checkout-script
> 
> Ah, okay. I think "push" and "checkout" don't play that well together;
> "push" changes the ref, which "checkout" uses to determine what it expects
> for the old contents, and then it's confused.
> 
> What you probably actually want is:
> 
> cd ../test-git
> git pull ../test-git2

The point is to push and use a post-update hook to do the checkout.  So,
this won't be possible.

> which will correctly identify before and after, and remove any files that
> were removed.
> 
> Alternatively, you could do, at point 1:
> 
> cp .git/refs/master .git/refs/deployed
> git checkout deployed

How to get a post-update hook to do this?  I suppose an update script
could set this up for the post-update to later use.

Thanks,
Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
