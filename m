From: Jeff King <peff@peff.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 7 Feb 2011 15:25:51 -0500
Message-ID: <20110207202551.GC13461@sigill.intra.peff.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <20110201181428.GA6579@sigill.intra.peff.net>
 <AANLkTimtU56BAnWU-2pY1npdkPdKEBq_CMCGwXUK+E=H@mail.gmail.com>
 <201102020322.00171.johan@herland.net>
 <7vpqr7xw4z.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1102051330270.12104@xanadu.home>
 <20110205193708.GA2192@sigill.intra.peff.net>
 <alpine.LFD.2.00.1102051449420.12104@xanadu.home>
 <20110207051834.GB4748@sigill.intra.peff.net>
 <alpine.LFD.2.00.1102070936530.14920@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 07 21:26:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmXeq-0006J9-KU
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 21:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945Ab1BGUZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 15:25:55 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:41091 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325Ab1BGUZz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 15:25:55 -0500
Received: (qmail 29902 invoked by uid 111); 7 Feb 2011 20:25:54 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 07 Feb 2011 20:25:54 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Feb 2011 15:25:51 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1102070936530.14920@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166279>

On Mon, Feb 07, 2011 at 09:53:29AM -0500, Nicolas Pitre wrote:

> > But more importantly, don't we sometimes care where the ref came from?
> 
> Not at the moment.  Certainly not with the current flat namespace used 
> for tags.

I'm not sure I was clear. I didn't mean "which remote the ref came from"
but rather "when choosing between two refs, don't we sometimes care
about the actual name of the ref?". But see below.

> > If I say "git push remote v1.7.4" we do some automagic on the
> > destination side of the refspec based on the fact that the source ref
> > was found in the refs/tags hierarchy. In the case we're talking about,
> > all of the ambiguous refs would presumably also be coming from
> > refs/remotes/*/tags/, so they would be functionally equivalent. But I
> > wanted to point it out because:
> > 
> >   1. It is an additional equivalent requirement for two refs to not be
> >      ambiguous. They must have the same sha1, _and_ they must have the
> >      same "type".
> 
> How can this matter?  The same automagic on the destination ref may 
> still take place.  Semantically you want to push v1.7.4 so nothing has 
> to change there, irrespective of the namespace the v1.7.4 tag comes 
> from.  This doesn't matter today, so why would this particular case need 
> to change?

I guess the problem is that I'm not clear on exactly what the new lookup
/ ambiguity rules are proposed to be. Clearly something will need to go
in the dwim_ref level. And I think it's obvious that if "refs/tags/foo"
and "refs/remotes/*/tags/foo" point to the same sha1, they will not be
considered ambiguous.

Will the same apply to refs/heads/foo versus refs/remotes/*/foo? Will it
also apply to refs/heads/foo versus refs/remotes/*/tags/foo? In the
final case, that does matter to "git push" (should the destination be in
the head or tag namespace?). So the actual names of the ref can matter,
and should probably be taken into account when deciding what is
ambiguous.

Maybe that was obvious to everybody and it was an implicit part of the
proposal, but it wasn't clear to me.

-Peff
