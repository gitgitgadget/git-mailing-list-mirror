From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Mon, 8 Jan 2007 22:26:40 -0500
Message-ID: <20070109032640.GB1904@spearce.org>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net> <87ps9xgkjo.wl%cworth@cworth.org> <7virfprquo.fsf@assigned-by-dhcp.cox.net> <87odphgfzz.wl%cworth@cworth.org> <7vbql9ydd7.fsf@assigned-by-dhcp.cox.net> <20070108131735.GA2647@coredump.intra.peff.net> <7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net> <87fyalyqqz.wl%cworth@cworth.org> <7v7ivxt3ft.fsf@assigned-by-dhcp.cox.net> <87d55pyp82.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 04:26:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H47dR-0007mk-Fy
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 04:26:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbXAID0q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 22:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbXAID0q
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 22:26:46 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48282 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbXAID0p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 22:26:45 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H47d9-0007oT-2M; Mon, 08 Jan 2007 22:26:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9684120FBAE; Mon,  8 Jan 2007 22:26:40 -0500 (EST)
To: Carl Worth <cworth@cworth.org>
Content-Disposition: inline
In-Reply-To: <87d55pyp82.wl%cworth@cworth.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36301>

Carl Worth <cworth@cworth.org> wrote:
> On Mon, 08 Jan 2007 17:05:26 -0800, Junio C Hamano wrote:
> > An obvious alternative is not to allow building on top of a HEAD
> > that is detached at all, which I suggested initially.
> 
> I just want to make sure that people that never actually need it don't
> have to see the message. And I don't think that _that_ part would be
> feasible with the safety valve at the point of "leaving detached
> state". It would basically come down to having to do reachability
> analysis for the current HEAD from all known branches or something
> equally horrific.

The common case is probably going to be where the argument to
`git checkout` is a fast-foward of the detached HEAD.  And that's
pretty cheap to check.  So we perform that check, and if we fail
that then we search through every ref to determine if the detached
HEAD is fully contained in any of those.  Currently that would be
pretty slow to do with the current tools, but a small modification
of say git-merge-base (or git-describe) might make it cheap enough
to run during this slightly less common case.

No need to complicate merge/am/rebase/revert/commit/applymbox
with a -b option.

-- 
Shawn.
