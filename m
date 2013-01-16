From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fix some clang warnings
Date: Wed, 16 Jan 2013 10:15:58 -0800
Message-ID: <20130116181558.GA4426@sigill.intra.peff.net>
References: <1358348003-11130-1-git-send-email-max@quendi.de>
 <20130116160410.GC22400@sigill.intra.peff.net>
 <7vk3rdxe5y.fsf@alter.siamese.dyndns.org>
 <CALWbr2z4TiynwOR3Lk4005dbZaLtcHK3J01ZF73wp8Q7Rm6YBA@mail.gmail.com>
 <20130116171809.GA2476@farnsworth.metanate.com>
 <7FDA1B56-731E-4BA2-8FE5-196B965FFFDB@quendi.de>
 <20130116175057.GB27525@sigill.intra.peff.net>
 <20130116180041.GC27525@sigill.intra.peff.net>
 <20130116181203.GB2476@farnsworth.metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Max Horn <max@quendi.de>, Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:16:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvXXF-0003fK-9u
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 19:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756371Ab3APSQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 13:16:04 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35443 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755836Ab3APSQD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 13:16:03 -0500
Received: (qmail 14290 invoked by uid 107); 16 Jan 2013 18:17:19 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 16 Jan 2013 13:17:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Jan 2013 10:15:58 -0800
Content-Disposition: inline
In-Reply-To: <20130116181203.GB2476@farnsworth.metanate.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213790>

On Wed, Jan 16, 2013 at 06:12:03PM +0000, John Keeping wrote:

> On Wed, Jan 16, 2013 at 10:00:42AM -0800, Jeff King wrote:
> > It is not about the macro itself, but rather the callsites that do not
> > return error, but call it for its printing side effect. It seems that
> > clang -Wunused-value is OK with unused values from functions being
> > discarded, but not with constants. So:
> > 
> >   int foo();
> >   void bar()
> >   {
> >     foo(); /* ok */
> >     1; /* not ok */
> >     (foo(), 1); /* not ok */
> >   }
> > 
> > The first one is OK (I think it would fall under -Wunused-result under
> > either compiler). The middle one is an obvious error, and caught by both
> > compilers. The last one is OK by gcc, but clang complains.
> 
> I wonder if this would be changed in clang - the change in [1] is
> superficially similar.
> 
> [1] http://llvm.org/bugs/show_bug.cgi?id=13747

Yeah, I think it is exactly the same issue, and the fix they mention
there would apply to us, too.

Is it worth applying this at all, then? Or should we apply it but limit
it with a clang version macro (they mention r163034, but I do not know
if it is in a released version yet, nor what macros are available to
inspect the version)?

-Peff
