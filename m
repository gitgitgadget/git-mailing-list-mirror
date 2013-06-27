From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Thu, 27 Jun 2013 15:58:27 -0400
Message-ID: <20130627195827.GB17601@sigill.intra.peff.net>
References: <51C5FD28.1070004@ramsay1.demon.co.uk>
 <51C6BC4B.9030905@web.de>
 <51C8BF2C.2050203@ramsay1.demon.co.uk>
 <7vy59y4w3r.fsf@alter.siamese.dyndns.org>
 <51C94425.7050006@alum.mit.edu>
 <51CB610C.7050501@ramsay1.demon.co.uk>
 <20130626223552.GA12785@sigill.intra.peff.net>
 <51CBD2FD.5070905@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, mlevedahl@gmail.com,
	dpotapov@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 27 21:58:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsIL4-0001Cl-Uy
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 21:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594Ab3F0T6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 15:58:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:41493 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754565Ab3F0T6a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 15:58:30 -0400
Received: (qmail 16382 invoked by uid 102); 27 Jun 2013 19:59:35 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Jun 2013 14:59:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Jun 2013 15:58:27 -0400
Content-Disposition: inline
In-Reply-To: <51CBD2FD.5070905@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229151>

On Thu, Jun 27, 2013 at 07:51:57AM +0200, Michael Haggerty wrote:

> > In theory we can drop the safety valve; it should never actually happen.
> > But I'd like to keep it there for working systems. Perhaps it is worth
> > doing something like this:
> > 
> > [...#ifdef out consistency check on cygwin when lock is held...]
> 
> Yes, this would work.
> 
> But, taking a step back, I think it is a bad idea to have an unreliable
> stat() masquerading as a real stat().  If we want to allow the use of an
> unreliable stat for certain purposes, let's have two stat() interfaces:
> 
> * the true stat() (in this case I guess cygwin's slow-but-correct
> implementation)
> 
> * some fast_but_maybe_unreliable_stat(), which would map to stat() on
> most platforms but might map to the Windows stat() on cygwin when so
> configured.

Yeah, that makes sense to me. I don't have a particular opinion on which
way to go, as I do not use cygwin at all (and on most platforms, the
two stat interfaces would just both call stat()).

I will leave it up to Cygwin folks whether they want to do something
like my patch as a band-aid while working up the two-stat() solution.

-Peff
