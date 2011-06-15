From: Jeff King <peff@github.com>
Subject: Re: [PATCH 2/2] archive: support gzipped tar files
Date: Wed, 15 Jun 2011 18:46:40 -0400
Message-ID: <20110615224640.GA19803@sigill.intra.peff.net>
References: <20110614181732.GA31635@sigill.intra.peff.net>
 <20110614181821.GA32685@sigill.intra.peff.net>
 <7vaadkkvew.fsf@alter.siamese.dyndns.org>
 <20110614204950.GB12776@sigill.intra.peff.net>
 <87vcw8f0d5.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git-dev@github.com
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jun 16 00:46:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWyrH-00066I-7l
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 00:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755707Ab1FOWqn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2011 18:46:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39816
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755683Ab1FOWqm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 18:46:42 -0400
Received: (qmail 7844 invoked by uid 107); 15 Jun 2011 22:46:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jun 2011 18:46:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jun 2011 18:46:40 -0400
Content-Disposition: inline
In-Reply-To: <87vcw8f0d5.fsf@catnip.gol.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175866>

On Wed, Jun 15, 2011 at 08:40:22AM +0900, Miles Bader wrote:

> Jeff King <peff@github.com> writes:
> >> I didn't know it was that easy (primarily because I didn't know zl=
ib had a
> >> ready-to-eat interface to do this).
> >
> > Yes, though I think it may be worth doing the more flexible,
> > external-filters approach. See elsewhere in the thread.
>=20
> Given the relatively trivial code, isn't it worth doing both...?
>
> One method for flexibility/multi-threaded-speed, the other for
> portability/robustness (doesn't depend on configuration / setup
> details)...

Maybe, although the code is a little less trivial than I hoped (see
Ren=C3=A9's response for some bugs in my original series).

My series allowing external filters via configuration also comes with
builtin config for gzip. So there's no extra config or setup details fo=
r
the user, assuming they can run "gzip" from their PATH.

So I think the only disadvantage now is for people who don't have gzip
at all. I suspect people on such platforms are going to want another
format anyway, but we could still help them out. However, I think
instead of building it specially into the archive code, it would be
cleaner to simply ship a bare-bones version of gzip that only stdio
(i.e., a "git-gzip"). It would be no more code than what the internal
solution would be, it could be easier to read (since the program is
self-contained), and it benefits from the SMP speedup.

Although at the point we are shipping "git-gzip", I really have to
wonder if people wouldn't prefer to just install gzip themselves. So I'=
m
inclined to wait until somebody complains that git+zlib are easy to get
on their system, but gzip isn't.

-Peff
