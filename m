From: Jeff King <peff@peff.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 7 Feb 2011 15:56:30 -0500
Message-ID: <20110207205630.GA14768@sigill.intra.peff.net>
References: <AANLkTimtU56BAnWU-2pY1npdkPdKEBq_CMCGwXUK+E=H@mail.gmail.com>
 <201102020322.00171.johan@herland.net>
 <7vpqr7xw4z.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1102051330270.12104@xanadu.home>
 <20110205193708.GA2192@sigill.intra.peff.net>
 <alpine.LFD.2.00.1102051449420.12104@xanadu.home>
 <20110207051834.GB4748@sigill.intra.peff.net>
 <alpine.LFD.2.00.1102070936530.14920@xanadu.home>
 <20110207202551.GC13461@sigill.intra.peff.net>
 <alpine.LFD.2.00.1102071541460.14920@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 07 21:56:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmY8W-0006Cv-9K
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 21:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446Ab1BGU4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 15:56:35 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:45823 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754359Ab1BGU4e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 15:56:34 -0500
Received: (qmail 30503 invoked by uid 111); 7 Feb 2011 20:56:34 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 07 Feb 2011 20:56:34 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Feb 2011 15:56:30 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1102071541460.14920@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166290>

On Mon, Feb 07, 2011 at 03:51:55PM -0500, Nicolas Pitre wrote:

> > Will it
> > also apply to refs/heads/foo versus refs/remotes/*/tags/foo? In the
> > final case, that does matter to "git push" (should the destination be in
> > the head or tag namespace?).
> 
> In such a case I'd say that head refs have precedence over tag refs, and 
> when that occurs  then warn the user.  And I wouldn't make a special 
> case for 'git push' here.  Whether it is push or log, the head ref would 
> take precedence, and the user warned about existence of a tag with the 
> same name.  Of course using "tag/foo" should be unambigous again.

I am fine with that, although it is the opposite of the current dwim_ref
behavior (which warns on ambiguity but prefers tags). However, Junio has
said that the current behavior was simply arbitrary.

> > So the actual names of the ref can matter,
> > and should probably be taken into account when deciding what is
> > ambiguous.
> 
> What happens today when you have refs/heads/foo and refs/tags/foo?

For dwim_ref, it prefers the tag and issues a warning. For git-push, it
complains about the ambiguity and dies. For git checkout, we prefer the
head. For git-tag, we prefer the tag (though I think that only matters
for "git tag -d").

-Peff
