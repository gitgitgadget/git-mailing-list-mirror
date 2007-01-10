From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: I just pulled and built 'next'...
Date: Tue, 9 Jan 2007 19:06:00 -0500
Message-ID: <20070110000600.GE30023@spearce.org>
References: <E1H3uc2-0004m1-Ua@think.thunk.org> <7vvejhwa6g.fsf@assigned-by-dhcp.cox.net> <20070108210002.GA15121@thunk.org> <20070109032124.GA1904@spearce.org> <20070109173501.GA3732@cepheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 01:06:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Qyp-0002l7-Uc
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 01:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbXAJAGI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 19:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbXAJAGI
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 19:06:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35702 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932501AbXAJAGH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 19:06:07 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4QyW-0008B3-6z; Tue, 09 Jan 2007 19:05:52 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7302920FBAE; Tue,  9 Jan 2007 19:06:00 -0500 (EST)
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
Content-Disposition: inline
In-Reply-To: <20070109173501.GA3732@cepheus>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36433>

Uwe Kleine-K?nig <zeisberg@informatik.uni-freiburg.de> wrote:
> Shawn O. Pearce wrote:
> >   $ git rev-list v1.5.0-rc0..next | wc -l
> >   687
> >   $ git rev-list v1.4.4.4..next | wc -l
> >   1051
> > 
> > So what about doing Junio's suggestion of going by topology and
> > coming up with the possible set of tags (v1.5.0-rc0 and v1.4.4.4
> > right now), and if more than one is found compute the number of
> > commits between each tag and the requested revision, and take the
> > tag that has a smallest number of commits?
>
> One scenario where this will fail is when a bugfix is commited on top of
> v1.4.4.4 and then is merged into v1.5.0-rc0+gabcdef.

Actually it still works, and does what you want.  The scenario you
are describing is exactly the one that caused this bug to appear,
and is the one my suggestion is trying to offer a partly sane
solution to.

Try it.  Checkout v1.4.4.4, make a trivial commit, merge it to
master, then merge that to next.  You'll still come up with the fact
that master (or next) have less commits different from v1.5.0-rc0
than they have from your hypothetical v1.4.4.5.  In this case the
the v1.5.0-rc0 tag should still be taken.

Its easy to explain this difference in terms of what the user
sees via `git log` and `git rev-list`.  We're taking the tag which
has the fewest commits different.  This will hold even if `next`
suddenly gets another 800 new commits (changing the above counts
to 1847 and 1851 respectively).


Where it might fail is if v1.4.4.5 suddenly gets another 1000 commits
as part of its bug fix release and those all get merged into next.
Now v1.4.4.5 is closer than v1.5.0-rc0.  But you know what, that
does still make a lot of sense.  If you look at the git log (or
git shortlog) between v1.4.4.5 and next there's less output than
if you look at it between v1.5.0-rc0 and next.

-- 
Shawn.
