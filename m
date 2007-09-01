From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Improve bash prompt to detect merge / rebase in progress
Date: Sat, 1 Sep 2007 18:20:36 -0400
Message-ID: <20070901222036.GH18160@spearce.org>
References: <11886421573285-git-send-email-robin.rosenberg@dewire.com> <7vir6us1ia.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 00:21:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRbLB-0003zo-Pg
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 00:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbXIAWUn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 18:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757308AbXIAWUn
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 18:20:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60600 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756228AbXIAWUm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 18:20:42 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IRbKO-0005vF-Tm; Sat, 01 Sep 2007 18:20:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 379DB20FBAE; Sat,  1 Sep 2007 18:20:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vir6us1ia.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57283>

Junio C Hamano <gitster@pobox.com> wrote:
> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
> >
> > +	local g="$(git rev-parse --git-dir 2>/dev/null)"
> > +	if [ -n "$g" ]; then
> > +		local r
> > +		local b
> > +		if [ -d "$g/../.dotest" ]
> > +		then
> > +			local b="$(git symbolic-ref HEAD 2>/dev/null)"
> > +			r="|REBASEING"
> 
> I might be in the middle of resolving a conflicted "git am".

And there's no way to tell the difference either.  I just spent a
few minutes digging around git-am and git-rebase and realized there
really isn't a way to tell these two user level commands apart as
git-rebase (by default) calls git-am and there's no marker to say
it was started by rebase.

But more than that I have to wonder why git-am still uses .dotest
in the working directory for its state management.  Why don't we
move it into $GIT_DIR like we do for `rebase -m`?

> But I love the idea.  We need to think about cleaning up our
> "state machine" mechanism to make this kind of thing easier to
> do.  We've had a few suggestions on the list in the past but
> they never passed the suggestion/speculation stage.

I love the idea too.  I've actually walked away from a rebase -i and
come back the following day and forgotten that I was in the middle
of a rebase and just thought I was sitting on a detached checkout.
Really confused me for a few minutes when code I was looking for
wasn't found (it was still pending to be applied by rebase -i).

-- 
Shawn.
