From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Teach git-describe to display distances from tags.
Date: Thu, 25 Jan 2007 16:49:23 -0500
Message-ID: <20070125214923.GD13874@spearce.org>
References: <20070125173954.GA13276@spearce.org> <7vmz46ajcq.fsf@assigned-by-dhcp.cox.net> <7v7ivaailb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 25 22:49:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HACTW-0002dt-Rg
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 22:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030608AbXAYVt2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 16:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030610AbXAYVt2
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 16:49:28 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51263 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030608AbXAYVt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 16:49:27 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HACTA-0005aS-6B; Thu, 25 Jan 2007 16:49:20 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B42A920FBAE; Thu, 25 Jan 2007 16:49:23 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v7ivaailb.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37764>

Junio C Hamano <junkio@cox.net> wrote:
>   - We need to update the documentation to say what this new
>     number means.

Indeed; I apologize for forgetting to do that.  At this point
I'll wind up resending the patch to address everything so toss
what you have.
 
> It's some number close to the number of revs since the named
> tag, but not exactly.
> 
>     $ git describe --debug 65ebe634 2>&1 | head -4
>     searching to describe 65ebe634
>      annotated        251 v2.6.20-rc5
>      annotated        427 v2.6.20-rc4
>      annotated        594 v2.6.20-rc3
>     $ git rev-list v2.6.20-rc5..65ebe634 | wc -l
>     254
>     $ git rev-list v2.6.20-rc4..65ebe634 | wc -l
>     430
> 
> And it does not seem to be always "minus 3" either.

What you skipped in the --debug output above was that we hit
our internal possible tag limit (10 by default) and aborted
walking the revision chain.  That's why we missed 3 revs in
our counting.  :)

We probably should make an option to enable the count, and
if the count is enabled then we'll have to pickup counting
where we left off and finish it out for the chosen tag so
the count is correct.

-- 
Shawn.
