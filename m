From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 09/19] documentation: add documentation for the bitmap
 format
Date: Thu, 24 Oct 2013 23:21:44 -0400
Message-ID: <20131025032144.GB26283@sigill.intra.peff.net>
References: <20131024175915.GA23398@sigill.intra.peff.net>
 <20131024180347.GI24180@sigill.intra.peff.net>
 <CACsJy8DFisnZZiPOWjktuMC2J289AYGtgefZob=4YFAJAxBc6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Vicent Marti <vicent@github.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 05:22:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZXyK-0003mH-0k
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 05:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755278Ab3JYDVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 23:21:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:55193 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754267Ab3JYDVq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 23:21:46 -0400
Received: (qmail 28032 invoked by uid 102); 25 Oct 2013 03:21:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Oct 2013 22:21:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Oct 2013 23:21:44 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8DFisnZZiPOWjktuMC2J289AYGtgefZob=4YFAJAxBc6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236647>

[+cc spearce; sorry, I really should have cc'd the whole series to you
     in the first place]

On Fri, Oct 25, 2013 at 08:16:18AM +0700, Nguyen Thai Ngoc Duy wrote:

> > +       - A header appears at the beginning:
> > +
> > +               4-byte signature: {'B', 'I', 'T', 'M'}
> > +
> > +               2-byte version number (network byte order)
> > +                       The current implementation only supports version 1
> > +                       of the bitmap index (the same one as JGit).
> 
> I suppose this means if I want to extend pack bitmaps to be used on
> shallow clones, I need to step version to 2 before adding the shallow
> points in .bitmap file as there's no chance of modifying v1 anymore,
> correct?

It depends on how you want to change it. And what Shawn says. :)

This is an attempt to document the JGit format. My feeling is that there
should be a version bump if an existing implementation would barf on it,
and I assume Shawn would agree.  But if you want to simply add extra
data that would be ignored by an existing implementation, it would be OK
to add the data and mark it with a flag:

> > +               2-byte flags (network byte order)
> > +
> > +                       The following flags are supported:
> [...]

That's how we added the name-hash cache in the final patch.

That being said, JGit is _not_ happy with that, and complains when any
flags besides OPT_FULL are used.  Whether that is because I am
misinterpreting the intent of the flags field, or because JGit is being
overly strict is up for debate.

-Peff
