From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 11/17] Fully activate the sliding window pack access.
Date: Sat, 23 Dec 2006 21:23:58 -0500
Message-ID: <20061224022358.GB7443@spearce.org>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org> <20061223073428.GL9837@spearce.org> <Pine.LNX.4.64.0612231038410.3671@woody.osdl.org> <7vodpuqtuf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 03:24:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyJ2A-0003RN-2t
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 03:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065AbWLXCYH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 21:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754066AbWLXCYH
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 21:24:07 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48326 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065AbWLXCYF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 21:24:05 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GyJ1K-0001pA-GN; Sat, 23 Dec 2006 21:23:26 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 255FA20FB65; Sat, 23 Dec 2006 21:23:58 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vodpuqtuf.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35336>

Junio C Hamano <junkio@cox.net> wrote:
> Also the patch makes the maximum mapped from (1<<26) bytes to
> 256MB which is four-fold; I think tweaking such settings should
> be done as a separate step.

Sure, I don't have any objection to that, but I'm also not going
to write a patch to drop it back down to 128 MiB.

The old code was somewhat flawed. It did not always honor the upper
limit of PACK_MAX.  For example it always overshoots that limit
anytime we have a packfile larger than PACK_MAX.

The only way you will hit the new 256 MiB limit is if you actually
have a packfile (or a set of packfiles) that large.  If that is the
case then you were probably overshooting PACK_MAX before.  With this
series you will never overshoot core.packedGitLimit (256 MiB), no
matter how big your packfiles are.

So the new 256 MiB limit, although a four-fold increase, is actually
smaller virtual memory footprint for those users who may have been
hitting PACK_MAX before.

-- 
Shawn.
