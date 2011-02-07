From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 07 Feb 2011 15:51:55 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102071541460.14920@xanadu.home>
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
 <20110207202551.GC13461@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 07 21:52:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmY4E-0003rG-Tm
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 21:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515Ab1BGUv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 15:51:57 -0500
Received: from relais.videotron.ca ([24.201.245.36]:52104 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab1BGUv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 15:51:56 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LG9001OPLXT8M20@vl-mo-mrz23.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 07 Feb 2011 15:51:29 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20110207202551.GC13461@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166286>

On Mon, 7 Feb 2011, Jeff King wrote:

> I guess the problem is that I'm not clear on exactly what the new lookup
> / ambiguity rules are proposed to be. Clearly something will need to go
> in the dwim_ref level. And I think it's obvious that if "refs/tags/foo"
> and "refs/remotes/*/tags/foo" point to the same sha1, they will not be
> considered ambiguous.

Agreed.

> Will the same apply to refs/heads/foo versus refs/remotes/*/foo?

I think it should.  If both branches are pointing to the same commit 
then the short form "foo" should be unambigous and the operation proceed 
(be that 'git push' or 'git log' that shouldn't matter).

> Will it
> also apply to refs/heads/foo versus refs/remotes/*/tags/foo? In the
> final case, that does matter to "git push" (should the destination be in
> the head or tag namespace?).

In such a case I'd say that head refs have precedence over tag refs, and 
when that occurs  then warn the user.  And I wouldn't make a special 
case for 'git push' here.  Whether it is push or log, the head ref would 
take precedence, and the user warned about existence of a tag with the 
same name.  Of course using "tag/foo" should be unambigous again.

> So the actual names of the ref can matter,
> and should probably be taken into account when deciding what is
> ambiguous.

What happens today when you have refs/heads/foo and refs/tags/foo?


Nicolas
