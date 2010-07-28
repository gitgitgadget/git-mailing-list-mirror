From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC PATCH 0/2] Allow detached forms (--option arg) for git
 log options.
Date: Wed, 28 Jul 2010 15:06:11 +0200
Message-ID: <20100728130610.GG6895@madism.org>
References: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr>
 <20100726193109.GA1043@burratino>
 <20100727144639.GU2504@madism.org>
 <m37hkhklll.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 15:06:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe6L5-0006c2-2Y
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 15:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411Ab0G1NGO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 09:06:14 -0400
Received: from pan.madism.org ([88.191.52.104]:34755 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab0G1NGN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 09:06:13 -0400
Received: from madism.org (unknown [94.228.180.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 026D74EA15;
	Wed, 28 Jul 2010 15:06:11 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 1BFD23AC; Wed, 28 Jul 2010 15:06:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m37hkhklll.fsf@localhost.localdomain>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152081>

On Tue, Jul 27, 2010 at 08:10:35AM -0700, Jakub Narebski wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > On Mon, Jul 26, 2010 at 02:31:09PM -0500, Jonathan Nieder wrote:
> > > Hi Matthieu,
> > >=20
> > > Matthieu Moy wrote:
> > >=20
> > > >                    is there any reason why "git log" hasn't bee=
n
> > > > migrated to parse-option? Or is it only that nobody did it yet?
> > >=20
> > > Please go ahead. :)
> >=20
> > I started it in the past, but never went around to actually do it.
> >=20
> > I started to get rid of most of the bitfields to use explicit or-ed
> > fields, but stopped at that, I don't even remember if those patches=
 got
> > merged or not.
>=20
> Why did you feel this change was needed / necessary?  Was it
> limitation of parseopt?  Or perhaps it was for portability reasons?
> Or was it just the matter of code elegance?

you cannot take the address of a bit portably in C, so you can't let
parseopt set/clear bits through bitfields (as in unsigned field : 1 in =
a
struct in C I mean).

So to use parseopt OPTION_BIT feature, you have to convert them to C
flags as in "unsigned flags" and explicit masks defines/enums.

IOW:

    struct foo {
       unsigned bar : 1,
		...
		baz : 1;
    };

Must be converted into:

    struct foo {
    #define FOO_FLAG_BAR (1U <<  1)
    ...
    #define FOO_FLAG_BAZ (1U << 18)
      unsigned flags;
    }

so that you can use parseopt.  that's what I meant.


This was done for the rev-list parsing stuff e.g.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g
