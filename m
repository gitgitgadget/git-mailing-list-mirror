From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [RFC] Removing deleted files after checkout
Date: Tue, 23 Aug 2005 14:50:52 -0600
Organization: Hewlett Packard
Message-ID: <20050823205052.GA13311@hpsvcnb.fc.hp.com>
References: <20050823162156.GA32240@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0508231533570.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Baldwin <cnb@fc.hp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 22:53:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7fkf-0008BU-B0
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 22:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbVHWUva (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 16:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVHWUv3
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 16:51:29 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:21463 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1750821AbVHWUv2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2005 16:51:28 -0400
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.15.136.253])
	by atlrel8.hp.com (Postfix) with ESMTP id A44603524;
	Tue, 23 Aug 2005 16:51:02 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP
	id 01B5141E26F; Tue, 23 Aug 2005 20:50:57 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 8ACE32CD92; Tue, 23 Aug 2005 14:50:52 -0600 (MDT)
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508231533570.23242@iabervon.org>
X-Origin: hpescnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7667>

On Tue, Aug 23, 2005 at 03:43:56PM -0400, Daniel Barkalow wrote:
> On Tue, 23 Aug 2005, Carl Baldwin wrote:
> 
> > Hello,
> >
> > I recently started using git to revision control the source for my
> > web-page.  I wrote a post-update hook to checkout the files when I push
> > to the 'live' repository.
> >
> > In this particular context I decided that it was important to me to remove
> > deleted files after checking out the new HEAD.  I accomplished this by running
> > git-ls-files before and after the checkout.
> >
> > Is there a better way?  Could there be some way built into git to easily
> > find out what files dissappear when replacing the current index with one
> > from a new tree?  Is there already?  The behavior of git should NOT
> > change to delete these files but I would argue that some way should
> > exist to query what files disappeared if removing them is desired.
> 
> If you don't use -f, git-checkout-script removes deleted files. Using -f
> tells it to ignore the old index, which means that it can't tell the
> difference between removed files and files that weren't tracked at all.

Maybe I'm doing something wrong.  This does not happen for me.

I tried a simple test with git v0.99.4...

cd
mkdir test-git && cd test-git/
echo testing | cg-init
echo contents > file
git-add-script file
git-commit-script -m 'testing'
cd ..
cg-clone test-git/.git/ test-git2
cd test-git2
cg-rm file
git-commit-script -m 'testing'
ls
cg-push
cd ../test-git
git-checkout-script
ls
git-status-script

At this point, I want 'file' to be gone.  It is, however, still there.
That is the situation that my code was meant to handle.  Maybe you were
thinking of something different?  Maybe there is new code since 0.99.4?

Now, I think it would be wrong for git-checkout-script to actually
remove files unless an option were given to do so.  So, the behavior
that I observe is correct in my opinion.  I'm looking for a way to find
out what files should be deleted if that is desired.

Thanks,
Carl

> 	-Daniel
> *This .sig left intentionally blank*
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
