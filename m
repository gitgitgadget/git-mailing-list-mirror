From: Jeff King <peff@peff.net>
Subject: Re: Resumable clone/Gittorrent (again) - stable packs?
Date: Fri, 7 Jan 2011 17:27:04 -0500
Message-ID: <20110107222704.GA10583@sigill.intra.peff.net>
References: <alpine.LFD.2.00.1101061552580.22191@xanadu.home>
 <AANLkTikgzqoG2cymNJ0NN03RsTRJi22R9M+0LFJ8U2yB@mail.gmail.com>
 <alpine.LFD.2.00.1101062221480.22191@xanadu.home>
 <20110107052207.GA23128@sigill.intra.peff.net>
 <20110107053119.GA23177@sigill.intra.peff.net>
 <20110107185218.GA16645@LK-Perkele-VI.localdomain>
 <20110107191719.GA6175@sigill.intra.peff.net>
 <20110107214501.GA29959@LK-Perkele-VI.localdomain>
 <20110107215631.GA10343@sigill.intra.peff.net>
 <20110107222133.GA2377@LK-Perkele-VI.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Zenaan Harkness <zen@freedbms.net>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Jan 07 23:27:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbKmH-0005oA-Ih
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 23:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724Ab1AGW1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 17:27:08 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:57373 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754650Ab1AGW1H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 17:27:07 -0500
Received: (qmail 19150 invoked by uid 111); 7 Jan 2011 22:27:06 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 07 Jan 2011 22:27:06 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jan 2011 17:27:04 -0500
Content-Disposition: inline
In-Reply-To: <20110107222133.GA2377@LK-Perkele-VI.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164777>

On Sat, Jan 08, 2011 at 12:21:33AM +0200, Ilari Liusvaara wrote:

> On Fri, Jan 07, 2011 at 04:56:31PM -0500, Jeff King wrote:
> > On Fri, Jan 07, 2011 at 11:45:01PM +0200, Ilari Liusvaara wrote:
> > 
> > 
> > I think there should always be an assumption that mirrors are not
> > necessarily complete. That is necessary for bundle-like mirrors to be
> > feasible, since updating the bundle for every commit defeats the
> > purpose.
> 
> Also add protocol that grabs a bundle from HTTP and then opens that
> up? :-)

Well, yes, that still needs to be implemented. But it's all client-side,
so the server just has to provide the bundle somewhere.

> > It would be nice for there to be a way for some mirrors to be marked as
> > "should be considered complete and authoritative", since we can optimize
> > out the final check of the master in that case (as well as for future
> > fetches). But that's a future feature. My plan was to leave space in the
> > mirror list for arbitrary metadata of that sort.
> 
> The first thing one should get/do when connecting to another repository
> is its list of references. One can see from there if what one has got
> is complete or not (with --use-mirror that only allows skipping commit
> negotiation and fetch, not the whole connection due to the fact that the
> repositories are contacted in order)...

Yes, but it would be cool to be able to skip even that connect in some
cases (e.g., mirrors can be useful not just to take load off the master,
but also when the master isn't available, either for downtime or because
the client is behind a firewall). But the default should definitely be
to double-check that the master is right, and we can leave more advanced
cases for later (we just need to be aware of leaving room for them now).

I'm going to start working on a patch series for this, so hopefully
we'll see how it's shaping up in a day or two.

-Peff
