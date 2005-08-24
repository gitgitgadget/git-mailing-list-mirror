From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [RFC] undo and redo
Date: Wed, 24 Aug 2005 13:56:15 -0600
Organization: Hewlett Packard
Message-ID: <20050824195615.GA693@hpsvcnb.fc.hp.com>
References: <20050824172339.GA7083@hpsvcnb.fc.hp.com> <20050824181004.GA18790@hpsvcnb.fc.hp.com> <Pine.LNX.4.58.0508241148480.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Baldwin <cnb@fc.hp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 21:57:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E81Mj-0004rm-Ni
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 21:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbVHXT4g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 15:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbVHXT4g
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 15:56:36 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:36243 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1751505AbVHXT4W (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2005 15:56:22 -0400
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.15.136.253])
	by atlrel7.hp.com (Postfix) with ESMTP id 6CC3611D;
	Wed, 24 Aug 2005 15:56:21 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP
	id 3B8BE41E09B; Wed, 24 Aug 2005 19:56:21 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id F09662CE99; Wed, 24 Aug 2005 13:56:15 -0600 (MDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508241148480.3317@g5.osdl.org>
X-Origin: hpescnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7725>

On Wed, Aug 24, 2005 at 11:51:32AM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 24 Aug 2005, Carl Baldwin wrote:
> >
> > Oops.  I forgot to actually exit from the script if git-diff-files is
> > non-empty.
> > 
> > Also, looking at it now, I don't think keeping undo information in a
> > stack is the right thing.  But keeping more than just one would be good.
> > Oh well, my first shot is never perfect.  ;-)
> 
> I would actually argue that
> 
> 	git checkout -b newbranch <undo-point>
> 
> is the perfect undo.

Yes, this does the job nicely.  I've used it like this effectively.  I
meant for undo/redo to be a lighter weight way of moving (uncommitted)
changes out of the way briefly and then replaying them onto the working
directory later.

> It leaves the old state in the old branch, and creates a new branch (and
> checks it out) with the state you want to revert to. The advantage is
> exactly that there is no "stack" of undo's: you can have multiple
> independent undo's pending, and you can continue development at any of 
> them. And merge the results together.

The "stack" was the wrong thing to do.  I think I would have undo pick a
name like undo-1, undo-2 etc.  Or something like that.  redo would pick
the most recent unless told to do otherwise.

A possible advantage of undo is having the freedom to stay on the
current branch or switch to another.

> Of course, right now we don't have a "delete branch" command, but it's 
> really as simple as
>
> 	rm .git/refs/heads/branchname
> 
> (and eventually you may want to do a "git prune" to get rid of stale
> objects, but that's a separate issue).
> 
> 		Linus
> 

This brings up a good point (indirectly).  "git prune" would destroy the
undo objects.  I had thought of this but decided to ignore it for the
time being.

Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
