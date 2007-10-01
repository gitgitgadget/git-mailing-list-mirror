From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Adding rebase merge strategy
Date: Mon, 1 Oct 2007 18:30:50 -0400
Message-ID: <20071001223050.GE2137@spearce.org>
References: <Pine.LNX.4.64.0709281751390.28395@racer.site> <11912513203420-git-send-email-tom@u2i.com> <7vr6ker1lf.fsf@gitster.siamese.dyndns.org> <550f9510710011441t1eb50352ofc8db77f79d794d5@mail.gmail.com> <87ejgescnb.wl%cworth@cworth.org> <550f9510710011521s126ca747v956a6f80182444bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carl Worth <cworth@cworth.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Tom Clarke <tom@u2i.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 00:31:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcTn6-0000lH-SB
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 00:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026AbXJAWa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 18:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753876AbXJAWa5
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 18:30:57 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51475 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753614AbXJAWa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 18:30:56 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IcTmq-00028N-1u; Mon, 01 Oct 2007 18:30:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 671BC20FBAE; Mon,  1 Oct 2007 18:30:50 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <550f9510710011521s126ca747v956a6f80182444bb@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59641>

Tom Clarke <tom@u2i.com> wrote:
> On 10/2/07, Carl Worth <cworth@cworth.org> wrote:
> > What I think I've always wanted is something like the following
> > behavior for "git pull":
> >
> >   * Fast forward if possible
> >
> >   * Otherwise, rebase, but only if there are no conflicts at all
> >
> >   * Otherwise, do the merge as normal, (leave conflict markers in
> >     place allowing the user to fix them up and then commit).
> >
> > Would it be straightforward to turn your rebase merge strategy into
> > something like the above? And if so, would that address the primary
> > concerns that Junio raised?
> 
> Maybe we need a 'pull' strategy' - merge, rebase or <insert name for
> strategy you describe above>.

`git pull -s <name>` takes any merge strategy that git-merge will
accept for its -s option.  There is also the config option of
pull.twohead that indicates what the default merge/pull strategy
should be for a two head merge.  Most people don't set this,
letting the code default to 'recursive'.

But I have to agree with (was it Junio who said this?) doing a rebase
in a merge strategy doesn't make sense when conflicts come into play.
It gets confusing fast for the end-user as the conflict resolution
process is different than for a merge.  A long time ago I wrote a
git-merge-rebase strategy and gave up on it for basically the same
reason.  I posted it to the mailing list and I think Linus said
"Why?!".  That was the end of that thread as I wound up agreeing
with him.

Multiple merge strategies can be given (and attempted).  A rebase
strategy could be attempted before recursive, and if the rebase
fails but the recursive succeeds then you get (roughly) what is
being described above by Carl.  But that still requires a rebase
merge strategy.  :-\

-- 
Shawn.
