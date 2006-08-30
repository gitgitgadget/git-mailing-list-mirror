From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Mozilla .git tree
Date: Tue, 29 Aug 2006 22:25:34 -0400
Message-ID: <20060830022534.GF22935@spearce.org>
References: <9e4733910608290943g6aa79855q62b98caf4f19510@mail.gmail.com> <20060829165811.GB21729@spearce.org> <9e4733910608291037k2d9fb791v18abc19bdddf5e89@mail.gmail.com> <20060829175819.GE21729@spearce.org> <9e4733910608291155g782953bbv5df1b74878f4fcf1@mail.gmail.com> <20060829190548.GK21729@spearce.org> <9e4733910608291252q130fc723r945e6ab906ca6969@mail.gmail.com> <20060829232007.GC22935@spearce.org> <9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com> <20060830015122.GE22935@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 30 04:25:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIFm1-0003J2-1a
	for gcvg-git@gmane.org; Wed, 30 Aug 2006 04:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWH3CZn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 22:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWH3CZn
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 22:25:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:14783 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750761AbWH3CZm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Aug 2006 22:25:42 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GIFlg-00036l-SS; Tue, 29 Aug 2006 22:25:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8AA7020FB7F; Tue, 29 Aug 2006 22:25:35 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060830015122.GE22935@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26219>

Shawn Pearce <spearce@spearce.org> wrote:
> We may well have a general problem here with always compressing
> tree deltas.  It appears to be a minor dent in the space required
> for a pack but its certainly a non-trivial amount on the larger
> Mozilla pack.  The wasted space is 2% of the Git pack and its 6.7%
> of the Mozilla pack.

Whoops.

mugwump (Sam Vilain) just pointed out on #git that I didn't account
for the 20 byte base when comparing the offset differences (claimed
compressed size) and the uncompressed size.  Nor did I account for
the variable sized headers.

I stated that 29 MiB of the Mozilla pack was wasted by 976712
tree deltas.  Of that 29 MiB we know that 18.6 MiB must be the
20 byte base-SHA1 header.  That leaves 10.4 MiB unaccounted for.
But we also have the variable length header; lets say the average
uncompressed length of a tree delta is 44 MiB/976712 so 47 bytes.
That average length can be encoded in two header bytes, so that's
another 1.8 MiB.  Which leaves us with 8.6 MiB of wasted space.

Which is clearly not the 29 MiB I previously stated.  But we're
still wasting a small amount of space over not compressing them.

-- 
Shawn.
