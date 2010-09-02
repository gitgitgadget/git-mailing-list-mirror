From: Jeff King <peff@peff.net>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 2 Sep 2010 11:58:13 -0400
Message-ID: <20100902155810.GB14508@sigill.intra.peff.net>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
 <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
 <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
 <4C7FC3DC.3060907@gmail.com>
 <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitzilla@gmail.com, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 17:58:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrCBP-0000ws-O8
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 17:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977Ab0IBP60 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 11:58:26 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:41367 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754682Ab0IBP6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 11:58:25 -0400
Received: (qmail 22450 invoked by uid 111); 2 Sep 2010 15:58:08 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 02 Sep 2010 15:58:08 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Sep 2010 11:58:13 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155140>

On Thu, Sep 02, 2010 at 04:42:55PM +0100, Luke Kenneth Casson Leighton =
wrote:

> >> =C2=A0it seems to be. =C2=A0as long as each version of git produce=
s the exact
> >> same pack object, off of the command "git pack-objects --all --std=
out
> >> --thin {ref}< =C2=A0{objref}"
> >
> > This is not guaranteed.
> [...]
> * under what circumstances is it not guaranteed?  and, crucially, is
> it necessary to care?   i.e. if someone does a shallow git clone, i
> couldn't give a stuff.

pack-objects will reuse previously found deltas. So the deltas you have
in your existing packs matter. The deltas you have in your existing
packs depend on many things. At least:

  1. Options you used when packing (e.g., --depth and --window).

  2. Probably exactly _when_ you packed. You could find a good delta
     from A to B. Later, object C comes into existence, and would
     provide a better delta base for B. I don't think we will ever try =
A
     against C, unless --no-reuse-delta is set.

     You have a different pack than somebody who packed after A, B, and
     C all existed.

     In practice, this tends not to happen much because the best deltas
     are usually going backwards in time to a previous version. But it
     can happen.

-Peff
