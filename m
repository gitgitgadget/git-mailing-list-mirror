From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-fetch: avoid local fetching from alternate (again)
Date: Thu, 8 Nov 2007 02:35:05 -0500
Message-ID: <20071108073505.GI14735@spearce.org>
References: <20071107024118.GA11043@spearce.org> <7vsl3iefoj.fsf@gitster.siamese.dyndns.org> <7vr6j1bxuf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 08:35:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq1vD-0007Pb-Hp
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 08:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbXKHHfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 02:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753879AbXKHHfM
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 02:35:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59962 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbXKHHfL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 02:35:11 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iq1ur-0005ZZ-VL; Thu, 08 Nov 2007 02:35:07 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 82FF120FBCC; Thu,  8 Nov 2007 02:35:05 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vr6j1bxuf.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63945>

Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Well spotted.  It would be a good idea to commit the big comment
> > from contrib/examples/git-fetch.sh to fetch_local_nocopy()
> > function, which would have made us realize that the patch does
> > not refrain from applying this optimization even when shallow
> > is in effect.  But I think that is actually a good change.
> 
> I take this back.  This regresses badly.
> 
> Why?

Whoops.  Good catch.  This is why you had a check for the shallow
history file in git-fetch.sh before you took this optimization path.
My fault for not including it in this patch.
 
> Because the optimization is useless when we are trying to deepen
> the shallow history.  When you are trying to deepen a shallow
> history and the tips of remotes haven't moved since you fetched
> from there the last time, you have everything near the tip, and
> becuse your history is shallow, your ancestry chain is
> cauterized to make it appear that the history is complete.  The
> rev-list reachability test would not fail as we expect.

What about just inserting a check to see if --depth was supplied
to git-fetch on the command line?  If so then we are deepening the
history and we just bypass the rev-list "fast path" test.

I will be posting an updated patch (series now) shortly.

-- 
Shawn.
