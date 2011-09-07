From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: "on for all" configuration of
 notes.rewriteRef
Date: Wed, 7 Sep 2011 17:35:42 -0400
Message-ID: <20110907213542.GA26388@sigill.intra.peff.net>
References: <f415402994735a60664e1f9f85be490a68b25ed3.1315167848.git.trast@student.ethz.ch>
 <20110907212310.GH13364@sigill.intra.peff.net>
 <201109072329.18338.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "John S. Urban\"" <urbanjost@comcast.net>,
	Tor Arntsen <tor@spacetec.no>,
	knittl <knittl89@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Sep 07 23:36:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Pmx-0004Wh-NX
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 23:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757197Ab1IGVfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 17:35:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35837
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757178Ab1IGVfu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 17:35:50 -0400
Received: (qmail 6334 invoked by uid 107); 7 Sep 2011 21:36:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Sep 2011 17:36:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2011 17:35:42 -0400
Content-Disposition: inline
In-Reply-To: <201109072329.18338.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180916>

On Wed, Sep 07, 2011 at 11:29:17PM +0200, Thomas Rast wrote:

> Admittedly I never considered the problem of supposedly-immutable
> notes here.  The whole point was to help users who had no idea that
> the string put there should probably start with refs/notes/.
> 
> So maybe the patch should instead say something along the lines of, to
> enable rewriting for the notes ref called foo, put refs/notes/foo --
> which to a core gitter of course sounds extremely redundant.
> 
> But what about the general issue of users who *have* put refs/notes/*,
> and then some software comes along that does not expect them to be
> rewritten?  Do we declare the software broken, or discourage from such
> blanket rewriting?

I think putting "refs/notes/*" is a perfectly reasonable thing from the
user's perspective, and I'd hate to take away that convenience (and
especially, I think in the long run, we'd like to have a hierarchy of
notes that have rewriting turned on by default).

The cache code is probably what should be changed, then. It can move to
"refs/cache", I guess, though I'm not too happy with that. The notes
code assumes refs/notes in several places, and it's nice to be able to
look at the cache trees with "--notes=cache/foo".

Maybe some way of saying "every notes tree gets rewriting, except ones
in refs/notes/cache"?

Right now it's not a big problem. The only such immutable cache in a
released version of git is the textconv cache, and it only contains
blobs. Which, AFAIK, cannot be subject to rewriting. So we could put it
off until another such cache comes along.

-Peff
