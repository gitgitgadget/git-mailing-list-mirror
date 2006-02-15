From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Tue, 14 Feb 2006 19:35:10 -0500
Message-ID: <20060215003510.GA25715@spearce.org>
References: <20060210195914.GA1350@spearce.org> <20060210211740.GO31278@pasky.or.cz> <20060213210001.GA31278@pasky.or.cz> <tnxoe1aqoj2.fsf@arm.com> <20060214100844.GA1234@diana.vm.bytemark.co.uk> <43F1F5CB.10402@citi.umich.edu> <20060214160747.GA6350@diana.vm.bytemark.co.uk> <43F2445A.6020109@citi.umich.edu> <20060214222913.GK31278@pasky.or.cz> <43F2745D.4010800@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Chuck Lever <cel@citi.umich.edu>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 01:35:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9Ae0-0001be-5j
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 01:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422899AbWBOAfm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 19:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422900AbWBOAfm
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 19:35:42 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:9867 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1422899AbWBOAfl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 19:35:41 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1F9AdK-0006Ml-Mz; Tue, 14 Feb 2006 19:35:02 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id 7E36820FBA0; Tue, 14 Feb 2006 19:35:10 -0500 (EST)
To: Sam Vilain <sam@vilain.net>
Mail-Followup-To: Sam Vilain <sam@vilain.net>, Petr Baudis <pasky@suse.cz>,
	Chuck Lever <cel@citi.umich.edu>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <43F2745D.4010800@vilain.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16197>

Sam Vilain <sam@vilain.net> wrote:
> Petr Baudis wrote:
> >>my impression of git is that you don't change stuff that's already 
> >>committed.  you revert changes by applying a new commit that backs out 
> >>the original changes.  i'm speculating, but i suspect that's why there's 
> >>a "stg pick --reverse" and not a "stg uncommit."
> >It is ok as long as you know what are you doing - if you don't push out
> >the commits you've just "undid" (or work on a public accessible
> >repository in the first place, but I think that's kind of rare these
> >days; quick survey - does anyone reading these lines do that?), there's
> >nothing wrong on it, and it gives you nice flexibility.
> 
> Yes, and this is one problem I envision with publishing a git repository
> with an stgit stack applied - somebody later doing a pull of it will not
> find the head revision they had.  I'm not sure what the net effect of
> this will be, though.

It would cause some pain for anyone pulling from it with git-pull, as
git-pull won't happily go backwards from what I've seen. But I think
you can force it to do so even if it won't make sense during the
resulting merge, which then leaves the user in an interesting state.

This is actually why pg-rebase doesn't care what you move to
when you grab the remote's commit; it just jumps to that commit
and pushes your patch stack back down onto it.  So if the remote
rebuilds itself through a new commit lineage which you have never
seen before the next pg-rebase will still update to it.  But on
the other hand if you have a commit that isn't in your local patch
stack its gone into the bit bucket.

Publishing a repository with a stg (or pg) patch series isn't
a problem; the problem is that no clients currently know how to
follow along with the remote repository's patch series.  And I can't
think of a sensible behavior for doing so that isn't what git-core is
already doing today for non patch series type clients (as in don't go
backwards by popping but instead by pushing a negative delta).  :-)

-- 
Shawn.
