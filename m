From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 02 Sep 2010 12:41:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009021233190.19366@xanadu.home>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
 <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
 <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
 <4C7FC3DC.3060907@gmail.com>
 <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
 <20100902155810.GB14508@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_zDdtgmcGhV/9cBqvL1V+4Q)"
Cc: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	gitzilla@gmail.com, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 02 18:41:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrCrI-0004bP-R3
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 18:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755897Ab0IBQlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 12:41:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33023 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab0IBQlq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 12:41:46 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L8400FBSP1LWMF0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 02 Sep 2010 12:41:45 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100902155810.GB14508@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155145>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_zDdtgmcGhV/9cBqvL1V+4Q)
Content-type: TEXT/PLAIN; charset=utf-8
Content-transfer-encoding: 8BIT

On Thu, 2 Sep 2010, Jeff King wrote:

> On Thu, Sep 02, 2010 at 04:42:55PM +0100, Luke Kenneth Casson Leighton wrote:
> 
> > >>  it seems to be.  as long as each version of git produces the exact
> > >> same pack object, off of the command "git pack-objects --all --stdout
> > >> --thin {ref}<  {objref}"
> > >
> > > This is not guaranteed.
> > [...]
> > * under what circumstances is it not guaranteed?  and, crucially, is
> > it necessary to care?   i.e. if someone does a shallow git clone, i
> > couldn't give a stuff.
> 
> pack-objects will reuse previously found deltas. So the deltas you have
> in your existing packs matter. The deltas you have in your existing
> packs depend on many things. At least:
> 
>   1. Options you used when packing (e.g., --depth and --window).
> 
>   2. Probably exactly _when_ you packed. You could find a good delta
>      from A to B. Later, object C comes into existence, and would
>      provide a better delta base for B. I don't think we will ever try A
>      against C, unless --no-reuse-delta is set.
> 
>      You have a different pack than somebody who packed after A, B, and
>      C all existed.
> 
>      In practice, this tends not to happen much because the best deltas
>      are usually going backwards in time to a previous version. But it
>      can happen.

I would go as far as stating that this is never guaranteed by design.  
And I will oppose any attempt to introduce such restrictions as this 
will only prevent future enhancements to packing heuristics.

For example, right now you already can't rely on having the exact same 
pack output even on the same machine using the same arguments and the 
same inputs simply by using threads.  As soon as you're using more than 
one thread (most people do these days) then your pack output becomes non 
deterministic.


Nicolas

--Boundary_(ID_zDdtgmcGhV/9cBqvL1V+4Q)--
