From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] parse-options: remove PARSE_OPT_NEGHELP
Date: Mon, 27 Feb 2012 19:34:03 -0500
Message-ID: <20120228003402.GA20784@sigill.intra.peff.net>
References: <4F49317A.3080809@lsrfire.ath.cx>
 <4F49336C.3000303@lsrfire.ath.cx>
 <20120227182504.GA1600@sigill.intra.peff.net>
 <4F4C0308.2050804@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Geoffrey Irving <irving@naml.us>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Feb 28 01:34:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2B1A-0004qV-9u
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 01:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756125Ab2B1AeG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 19:34:06 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59190
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755985Ab2B1AeF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 19:34:05 -0500
Received: (qmail 2152 invoked by uid 107); 28 Feb 2012 00:34:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Feb 2012 19:34:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2012 19:34:03 -0500
Content-Disposition: inline
In-Reply-To: <4F4C0308.2050804@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191692>

On Mon, Feb 27, 2012 at 11:26:16PM +0100, Ren=C3=A9 Scharfe wrote:

> >  OPT_REVERSE_BOOL(0, "no-index",&use_index,
> >              "finds in contents not managed by git"),
>=20
> It's better than NEGHELP, but I find your use of two negations
> (REVERSE and "no-") confusing.  We don't need to invent new OPT_
> types for this, by the way, we can just do this:
>=20
> 	OPT_NEGBIT(0, "no-index", &use_index,
> 	           "finds in contents not managed by git", 1),
>=20
> It certainly shortens the patch.

Right. The point is that the code and the option want to look at the
conditional in two different ways. So you have to have negate it
_somewhere_. Either at point of use (your original patch), between the
option name and the variable name (what I wrote above), or using a
reversed help text (the original code before your patch).

I think we both agree that NEGHELP is the worst one. I have a slight
preference for doing the reversal at the point of the option definition=
,
if only because we know it happens at a single point, and it lets the
actual code (which is usually the trickier part) be more clear. But
beyond that, I think it is largely a matter of aesthetics.

> >I dunno. Given that there are only two uses of NEGHELP, and that the=
y
> >don't come out too badly, I don't care _too_ much. But I have seen s=
ome
> >really tortured logic with double-negations like this, and I'm conce=
rned
> >that a few months down the road somebody is going to want NEGHELP (o=
r
> >something similar) in a case where it actually does really impact
> >readability.
>=20
> I'm curious to see a case that can be solved better using NEGHELP,
> but we can always add it back if we find such a beast.  I'd much
> rather see it go until then because of it's non-obvious semantics.

Yeah, I should have spelled out my "or something similar" more. I'd
rather see something like NEGBIT above than NEGHELP; the latter is a bi=
t
too subtle.

-Peff
