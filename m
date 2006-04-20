From: Shawn Pearce <spearce@spearce.org>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 17:53:46 -0400
Message-ID: <20060420215346.GA32748@spearce.org>
References: <20060420133640.GA31198@spearce.org> <Pine.LNX.4.64.0604200745550.3701@g5.osdl.org> <20060420150315.GB31198@spearce.org> <Pine.LNX.4.64.0604200857460.3701@g5.osdl.org> <20060420164351.GB31738@spearce.org> <Pine.LNX.4.64.0604200954440.3701@g5.osdl.org> <20060420173131.GF31738@spearce.org> <7vodywvsrq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Apr 20 23:53:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWh66-0001GC-3N
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 23:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWDTVxz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 17:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWDTVxz
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 17:53:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:19943 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751351AbWDTVxy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 17:53:54 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FWh5n-0006qq-V2; Thu, 20 Apr 2006 17:53:40 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B614E20FBB4; Thu, 20 Apr 2006 17:53:46 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vodywvsrq.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19002>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > I just spent some time bisecting this issue and it looks like the
> > following change by Junio may be the culprit:
> >
> >   commit 1d6b38cc76c348e2477506ca9759fc241e3d0d46
[snip]
> Unfortunately, that is not the same hash we use in v1.3.0, so we
> need to look elsewhere for interactions.

Pity.  Then either bisect goofed or there was a goof in meatspace
while using bisect.  I honestly expected bisect to point at the
problem commit.  I tried reverting 1d6b38cc but it didn't apply
cleanly and I didn't feel like working through all of the conflicts
at the time.
 
[snip]
> The earlier observation by Linus on reverting eeef7135 is
> consistent with it; that commit was the one that introduced
> v1.3.0 hash.

Yet reverting that didn't help either.
 
[snip]
> You could try this patch to resurrect the hash used in v1.2.3,
> and you may get better packing for your particular repository;
> but I am not sure if it gives better results in the general
> case.  I am running the test myself now while waiting for my
> day-job database to load X-<.
[snip]

Nope.  When applied to 'next' it didn't help very much:

  Total 46391, written 46391 (delta 6466), reused 38662 (delta 0)
  118M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack


Just to note: the 1.3.0 packer is saving 1M in the GIT repository
over the 1.2.3 packer.  So for a real project it does seem to have
some benefit.  And if you benchmarked the 1.3.0 packer against
the Linux kernel and found it to be better than the 1.2.3 packer
that's even better.

I think this repository of mine may just be a degenerate case which
GIT doesn't pack very well.  GIT can't be all things to all people!

-- 
Shawn.
