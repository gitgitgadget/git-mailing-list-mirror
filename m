From: Jeff King <peff@peff.net>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Fri, 23 Sep 2011 15:44:31 -0400
Message-ID: <20110923194431.GA27839@sigill.intra.peff.net>
References: <4E7A3BDE.3040301@alum.mit.edu>
 <7vy5xh1whq.fsf@alter.siamese.dyndns.org>
 <4E7AF1AE.5030005@alum.mit.edu>
 <CAG+J_DxtCx6-RKWLKFy+V7tOtu7UnUrke7iN8gNdGiY-sC52sQ@mail.gmail.com>
 <20110922171340.GA2934@sigill.intra.peff.net>
 <CAG+J_DxdP2qHhttJOtWQTKeiDV2YbC_A_F+b9sDOZsWhWxjcjw@mail.gmail.com>
 <20110922205856.GA8563@sigill.intra.peff.net>
 <4E7C5A3B.10703@alum.mit.edu>
 <20110923193341.GA26820@sigill.intra.peff.net>
 <7vobybt5bw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jay Soffian <jaysoffian@gmail.com>,
	git discussion list <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 21:44:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7Bfr-0000iM-9j
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 21:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583Ab1IWToe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 15:44:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41781
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290Ab1IWToe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 15:44:34 -0400
Received: (qmail 20047 invoked by uid 107); 23 Sep 2011 19:49:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Sep 2011 15:49:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Sep 2011 15:44:31 -0400
Content-Disposition: inline
In-Reply-To: <7vobybt5bw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181997>

On Fri, Sep 23, 2011 at 12:40:51PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We do some of this already. For example, textconv will look up each side
> > based on its individual filename. But the funcname code, for example
> > does this ("one" is the "from" side of the diff, "two" is the "to"
> > side):
> >
> >   pe = diff_funcname_pattern(one);
> >   if (!pe)
> >           pe = diff_funcname_pattern(two);
> 
> What text would we see on the actual hunk header line? I had an impression
> that we always take from the preimage. I might be wrong, but if that is
> indeed the case, shouldn't we be ignoring the attribute tacked on to the
> postimage side altogether?

Sort of. I think this is Michael's fallback case of "if there was no
attribute before, use the other side". In other words, we are guessing
if there was no attribute before, and there is one now, the reason is
not because they are two different formats but rather because the
attribute simply hadn't been added yet on the other side.

So if you have three commits, and the second one adds the attribute, you
can diff commits 1 and 3 in either direction, and still get the benefit
of the attribute.

Like reading .gitattributes from the current directory to look at old
(or even unrelated) commits, I think this is a convenience and is right
in most cases, but can be spectacularly wrong in some corner cases.

-Peff
