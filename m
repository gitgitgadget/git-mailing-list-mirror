From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 1 Jan 2007 16:18:29 -0500
Message-ID: <20070101211829.GC26821@spearce.org>
References: <7vhcvcfpze.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 01 22:19:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1UYt-00029s-Fe
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 22:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695AbXAAVSe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 16:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754705AbXAAVSe
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 16:18:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60158 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754695AbXAAVSd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 16:18:33 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H1UY3-00042b-JV; Mon, 01 Jan 2007 16:18:23 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2D91520FB65; Mon,  1 Jan 2007 16:18:30 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhcvcfpze.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35744>

Junio C Hamano <junkio@cox.net> wrote:
> * sp/mmap (Sat Dec 30 22:13:43 2006 -0500) 25 commits
> 
> This is Shawn's sliding mmap series to allow smaller virtual
> memory footprint to access larger packfiles.  I started using
> this series in production tonight.  Although the size of the
> series is somewhat intimidating, they are sane changes and I
> think it may be worth considering for 'master'.  This does not
> change the user experience majorly as has almost no UI elements,
> so it could go in either before or after v1.5.0.

I know your testing is saying this series may be slightly faster than
the prior code in 'master', and at least on Linux can be so without
using a lot of virtual address space as mmap() is so fast there.
(Nice job kernel people!)  Anyway, I haven't done any performance
testing on this myself.  It would be nice to know more about how
it behaves.
 
> * sp/merge (Sun Dec 31 00:02:13 2006 -0500) 6 commits
>  - Refresh the index before starting merge-recursive.
>  - Improve merge performance by avoiding in-index merges.
>  - Avoid git-fetch in `git-pull .` when possible.
>  + Use merge-recursive in git-am -3.
>  + Allow merging bare trees in merge-recursive.
>  + Move better_branch_name above get_ref in merge-recursive.
> 
> I'm reasonably happy with the earlier three of this series but
> not really about the latter, and I've already described why.

I know you've stated a number of good reasons against "Avoid
git-fetch in `git-pull .` when possible.".  One way I've thought
of trying to resolve that would be to verify the arguments to
`git pull .` are refs only (and not SHA1 expressions) which makes
the behavior the same as `git pull .` and *might* still save time,
as the fetch can still get bypassed.

The only objection I know of to "Improve merge performance by
avoiding in-index merges." was that it needs more testing to ensure
its doing the same thing as before, which basically means we hold it
out until post v1.5.0.  Since it is only a performance improvement
I think that's reasonable.

-- 
Shawn.
