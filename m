From: Jeff King <peff@peff.net>
Subject: Re: gc --aggressive
Date: Tue, 17 Apr 2012 14:58:01 -0700
Message-ID: <20120417215801.GA10797@sigill.intra.peff.net>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
 <CAG+J_DyqvCxwd6+gzixQEk6SxMZF0qsXKcJPaU6imsJdFQ-64g@mail.gmail.com>
 <vpqbomqqdxo.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 17 23:58:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKGPb-0003w3-9m
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 23:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624Ab2DQV6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 17:58:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37378
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab2DQV6F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 17:58:05 -0400
Received: (qmail 8832 invoked by uid 107); 17 Apr 2012 21:58:13 -0000
Received: from c-67-169-43-61.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.43.61)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Apr 2012 17:58:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Apr 2012 14:58:01 -0700
Content-Disposition: inline
In-Reply-To: <vpqbomqqdxo.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195811>

On Tue, Apr 17, 2012 at 10:52:03PM +0200, Matthieu Moy wrote:

> Jay Soffian <jaysoffian@gmail.com> writes:
> 
> > + 3. `git gc --aggressive`; this is often much slower than (2) because git
> > +    throws out all of the existing deltas and recomputes them from
> > +    scratch. It uses a higher window parameter meaning it will spend
> > +    more time computing, and it may end up with a smaller pack. However,
> > +    unless the repository is known to have initially been poorly packed,
> > +    this option is not needed and will just cause git to perform
> > +    extra work.
> 
> I like your patch.

Me too. I guess it is not surprising since I wrote the initial draft. ;)

> Maybe you should elaborate on "unless the repository is known to have
> initially been poorly packed". My understanding is that --aggressive was
> implemented to be called after an import from another VCS that would
> have computed very poor deltas, but I'm not sure about the details.

Yes, that's exactly it. fast-import will generate packs, but they are
often not optimal. So if you have done a big import, you should
definitely "git gc --aggressive" as the final step. I don't know how
something like a remote-helper would work, where it is fast-importing
little bits at a time. Probably a regular repack would be fine, since it
will be considering deltas between objects in different packs anyway.

-Peff
