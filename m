From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 16:04:53 -0400
Message-ID: <20080911200452.GM5082@mit.edu>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com> <20080911123148.GA2056@cuci.nl> <20080911135146.GE5082@mit.edu> <20080911153202.GD2056@cuci.nl> <20080911180037.GH5082@mit.edu> <20080911190335.GB1451@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Sep 11 22:06:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdsQu-0003yn-M5
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 22:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756572AbYIKUFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 16:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756558AbYIKUFQ
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 16:05:16 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:40288 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756541AbYIKUFP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Sep 2008 16:05:15 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8BK4sw3007208;
	Thu, 11 Sep 2008 16:04:54 -0400 (EDT)
Received: from closure.thunk.org (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8BK4ruj002151
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 11 Sep 2008 16:04:53 -0400 (EDT)
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KdsPN-0002CF-28; Thu, 11 Sep 2008 16:04:53 -0400
Content-Disposition: inline
In-Reply-To: <20080911190335.GB1451@cuci.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95636>

On Thu, Sep 11, 2008 at 09:03:35PM +0200, Stephen R. van den Berg wrote:
> >This seems wrong.  OK, suppose you have branches A, B, C, and D, while
> >you are on branch C, you cherry pick commit 'p' from branch B, so that
> >there is a new commit q on branch C which has an origin link
> >containing the commit ID's p^ and 'p.    
> 
> >Now suppose branch B gets deleted, and you do a "git gc".  All of the
> >commits that were part of branch B will vanish except for p^ and p,
> 
> Not quite.  Obviously all parents of p and p^ will continue to exist.
> I.e. deleting branch B will cause all commits from p till the tip of B
> (except p itself) to vanish.  Keeping p implies that the whole chain of
> parents below p will continue to exist and be reachable.  That's the way
> a git repository works.

That's still not very useful, since you still don't have a label for
this anonymous series of commit chain that just dead ends at commit p.
How would anyone find this useful?

> >which in your model will stick around because they are origin links
> >commit q on branch C.  But what good is are these two commits?  They
> >represent two snapshots in time, with no context now that branch B has
> 
> The context are all their ancestors, which continue to exist, and that
> is all you need.

Need for what?  What useful information would you devine from it?

> >Oh, BTW, suppose you then further do a "git cherry-pick -o" of commit
> >q while you are on branch D.  Presumably this will create a new
> >commit, r.  But will the origin-link of commit r be p^ and p, or q^
> >and q?
> 
> It will be q^..q, and specifically not p^..p, using ^p..p would be
> lying.  We aim to document the evolvement of the patch in time.
> Cherry-pick itself will always ignore the origin links present on the
> old commit, it simply creates new ones as if the old ones didn't exist.

So if you never pull branch C (where commit q resides), there is no
way for you to know that commits p and r are related.  How.... not
useful.

If the scenario was being able to tell which stable branches had a
particular bug fixes, I think my proposal of attaching a bug
identifier is a far superior solution.

Again, what's the use case of "trying to document the development of
the patch in time?"  Aside from drawing pretty dotted lines
everywhere, what *good* does this actually achieve?  How would it
affect other git commands' behavior, and how would this change in
behavior actually be considered a net improvement over what we have
now?

						- Ted
