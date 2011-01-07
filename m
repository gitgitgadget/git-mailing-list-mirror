From: Jeff King <peff@peff.net>
Subject: Re: Resumable clone/Gittorrent (again) - stable packs?
Date: Fri, 7 Jan 2011 14:17:19 -0500
Message-ID: <20110107191719.GA6175@sigill.intra.peff.net>
References: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com>
 <alpine.LFD.2.00.1101061552580.22191@xanadu.home>
 <AANLkTikgzqoG2cymNJ0NN03RsTRJi22R9M+0LFJ8U2yB@mail.gmail.com>
 <alpine.LFD.2.00.1101062221480.22191@xanadu.home>
 <20110107052207.GA23128@sigill.intra.peff.net>
 <20110107053119.GA23177@sigill.intra.peff.net>
 <20110107185218.GA16645@LK-Perkele-VI.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Zenaan Harkness <zen@freedbms.net>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Jan 07 20:17:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbHoc-0007bq-8V
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 20:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254Ab1AGTRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 14:17:24 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54537 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752429Ab1AGTRX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 14:17:23 -0500
Received: (qmail 17517 invoked by uid 111); 7 Jan 2011 19:17:21 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 07 Jan 2011 19:17:21 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jan 2011 14:17:19 -0500
Content-Disposition: inline
In-Reply-To: <20110107185218.GA16645@LK-Perkele-VI.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164743>

On Fri, Jan 07, 2011 at 08:52:18PM +0200, Ilari Liusvaara wrote:

> On Fri, Jan 07, 2011 at 12:31:19AM -0500, Jeff King wrote:
> > 
> >   3. people on low-bandwidth servers who fork major projects; if I write
> >      three kernel patches and host a git server, I would really like
> >      people to only fetch my patches from me and get the rest of it from
> >      kernel.org
> 
> One client-side-only feature that could be useful:
> 
> Ability to contact multiple servers in sequence, each time advertising
> everything obtained so far. Then treat the new repo as clone of the last
> address.
> 
> This would e.g. be very handy if you happen to have local mirror of say, Linux
> kernel and want to fetch some related project without messing with alternates
> or downloading everything again:
> 
> git clone --use-mirror=~/repositories/linux-2.6 git://foo.example/linux-foo
> 
> This would first fetch everything from local source and then update that
> from remote, likely being vastly faster.

I'm not clear in your example what ~/repositories/linux-2.6 is. Is it a
repo? In that case, isn't that basically the same as --reference? Or is
it a local mirror list?

If the latter, then yeah, I think it is a good idea. Clients should
definitely be able to ignore, override, or add to mirror lists provided
by servers. The server can provide hints about useful mirrors, but it is
up to the client to decide which methods are useful to it and which
mirrors are closest.

Of course there are some servers who will want to do more than hint
(e.g., the gentoo case where they really don't want people cloning from
the main machine). For those cases, though, I think it is best to
provide the hint and to reject clients who don't follow it (e.g., by
barfing on somebody who tries to do a full clone). You have to implement
that rejection layer anyway for older clients.

-Peff
