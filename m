From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] daemon: restore getpeername(0,...) use
Date: Mon, 10 Sep 2012 13:58:46 -0400
Message-ID: <20120910175846.GA16791@sigill.intra.peff.net>
References: <1347124173-14460-1-git-send-email-jengelh@inai.de>
 <1347124173-14460-2-git-send-email-jengelh@inai.de>
 <7v1uicuyqi.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.01.1209082119320.18369@frira.zrqbmnf.qr>
 <20120910142100.GB7906@sigill.intra.peff.net>
 <k2ku26$jld$1@ger.gmane.org>
 <20120910155006.GA8737@sigill.intra.peff.net>
 <k2l7s5$gl9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Sep 10 19:59:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB8GC-0000OG-9H
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 19:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146Ab2IJR6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 13:58:51 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39834 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753977Ab2IJR6u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 13:58:50 -0400
Received: (qmail 30906 invoked by uid 107); 10 Sep 2012 17:59:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Sep 2012 13:59:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2012 13:58:46 -0400
Content-Disposition: inline
In-Reply-To: <k2l7s5$gl9$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205157>

On Mon, Sep 10, 2012 at 07:26:26PM +0200, Joachim Schmitz wrote:

> >>as are non-const array intializers, e.g.:
> >>
> >>               const char *args[] = { editor, path, NULL };
> >>                                              ^
> >>".../git/editor.c", line 39: error(122): expression must have a
> >>constant value
> >>
> >>So git source is not plain C89 code (anymore?)
> >
> >I remember we excised a whole bunch of non-constant initializers at
> >some point because somebody's compiler was complaining. But I suppose
> >this one has slipped back in, because non-constant initializers are
> >so damn useful. And nobody has complained, which I imagine means
> >nobody has bothered building lately on those older systems that
> >complained.
> 
> OK, record my complaint then ;-)

Oops, did I say "complained"? I meant "sent patches". Hint, hint. :)

> At least some older release of HP NonStop only have C89 and are still in use
> 
> And tying to compile in plain C89 mode revealed several other
> problems too (e.g. size_t seems not to be typedef'd?)

I think it is a mistake to set -std=c89 (or whatever similar option your
compiler supports). Like I said, we are not interested in being strictly
C89-compliant. We are interested in working on real-world systems.

If your compiler complains in the default mode (or when it is given some
reasonable practical settings), then that's something worth fixing. But
if your compiler is perfectly capable of compiling git, but you choose
to cripple it by telling it to be pedantic about a standard, then that
is not git's problem at all.

-Peff
