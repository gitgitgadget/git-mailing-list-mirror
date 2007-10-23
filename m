From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Tue, 23 Oct 2007 00:46:57 -0400
Message-ID: <20071023044657.GC14735@spearce.org>
References: <20071016060456.GC13801@spearce.org> <Pine.LNX.4.64.0710161209480.25221@racer.site> <20071016195744.GB32132@closure.lan> <7v3aw2aaxu.fsf@gitster.siamese.dyndns.org> <20071023012140.GC22997@thunk.org> <7vtzoi8voo.fsf@gitster.siamese.dyndns.org> <20071023020044.GA27132@thunk.org> <20071023040522.GX14735@spearce.org> <20071023043321.GC27132@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 23 06:47:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkBfj-00041Z-8H
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 06:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbXJWErG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 00:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbXJWErF
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 00:47:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39746 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbXJWErE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 00:47:04 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IkBfP-00027G-C8; Tue, 23 Oct 2007 00:46:59 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D0D2720FBAE; Tue, 23 Oct 2007 00:46:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071023043321.GC27132@thunk.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62089>

Theodore Tso <tytso@mit.edu> wrote:
> On Tue, Oct 23, 2007 at 12:05:22AM -0400, Shawn O. Pearce wrote:
> >
> > Yes.  Because 'next' always has commits in it that never appear in
> > 'master'.  So any topic forked from master must merge into next.
> > It can't be a fast-forward.  No forced merging required.
> 
> Why is it the case that 'next' always commits that never appear in
> 'master'.  So far in how I've been doing things that hasn't been the
> case.  When I do a "git checkout master; git merge next", it's always
> been a fast-forward merge. 
> 
> Oh, I see.  That's because if you put some trivial changes in
> 'master', and then pull those changes into next, there will be merge
> commits in 'next' that will never be in 'master.  Is that it?  

Exactly.  This of course means that next has been growing in distance
from master for quite some time.  It has well over 1000 commits now
in git.git that aren't in master.  Most of those will never merge
there either.
 
> I had been trying to avoid that case by always putting new commits,
> even trivial ones, into 'next', and then having them drop into
> 'master' at the next cycle; so 'master' was always trailing 'next',
> but they were always the same commit string (i.e., 'master' was always
> a subset of 'next').  
> 
> Aside from the WC script not working right, are there other
> disadvantages to my doing things that way as opposed to the way the
> Junio has been running the git repository?

The reason Junio does what he does is flexibility.

By merging only individual topics forked from master into next you
can merge those individual topics into master at different points
in time.  For example db/fetch-pack has been in next for many weeks
and hasn't yet merged into master, yet jc/am-quiet was forked after
db/fetch-pack started and has already merged into master.

Your way would make jc/am-quiet wait until db/fetch-pack was ready.
That's a big risk in the sense that your tree is "blocked" and even
simple changes are held up by ones that suddenly became a lot more
complex then you originally thought they were going to be.

-- 
Shawn.
