From: Jeff King <peff@peff.net>
Subject: Re: gc --aggressive
Date: Tue, 1 May 2012 15:35:37 -0400
Message-ID: <20120501193537.GA26245@sigill.intra.peff.net>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
 <CAG+J_DyqvCxwd6+gzixQEk6SxMZF0qsXKcJPaU6imsJdFQ-64g@mail.gmail.com>
 <vpqbomqqdxo.fsf@bauges.imag.fr>
 <20120428122533.GA12098@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204281258050.21030@xanadu.home>
 <20120429113431.GA24254@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204290917051.21030@xanadu.home>
 <20120501162806.GA15614@sigill.intra.peff.net>
 <20120501171640.GA16623@sigill.intra.peff.net>
 <alpine.LFD.2.02.1205011348090.21030@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue May 01 21:35:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPIrS-0004qS-TC
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 21:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757428Ab2EATfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 15:35:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53655
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756038Ab2EATfl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 15:35:41 -0400
Received: (qmail 9890 invoked by uid 107); 1 May 2012 19:35:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 May 2012 15:35:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 May 2012 15:35:37 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1205011348090.21030@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196730>

On Tue, May 01, 2012 at 01:59:08PM -0400, Nicolas Pitre wrote:

> One final quick test if you feel like it: I've never been sure that 
> the last comparison in type_size_sort() is correct.  Maybe it should be 
> the other way around.  Currently it reads:
> 
> 	return a < b ? -1 : (a > b);

I think it is right. At least it should put recent things near the
front of the array, just as we are putting bigger things there.

> >   orig | 31.4M (100%) |   54s (100%)
> >     10 | 44.0M (140%) |  169s (310%)
> >     20 | 37.7M (120%) |  232s (428%)
> >     40 | 33.6M (107%) |  331s (608%)
> >     80 | 30.9M ( 99%) |  473s (868%)
> >    160 | 29.4M ( 94%) |  696s (1279%)
> [...]
> While keeping the size comparison commented out, you could try to 
> replace this line with:
> 
> 	return b < a ? -1 : (b > a);

No, it's not better. A few of the pack sizes are better, but some of
them are worse. And the CPU times are still quite bad. Here are the
numbers:

  orig | 31.4M (100%) |   54s (100%)
    10 | 45.6M (145%) |  158s (292%)
    20 | 39.2M (125%) |  205s (377%)
    40 | 35.1M (112%) |  275s (505%)
    80 | 32.4M (103%) |  388s (713%)
   160 | 30.6M ( 98%) |  581s (1067%)

-Peff
