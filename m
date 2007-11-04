From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 9/5] Migrate git-checkout.sh to use git-rev-parse --parseopt  --keep-dashdash
Date: Sun, 04 Nov 2007 15:18:09 +0100
Message-ID: <20071104141809.GG26269@artemis.corp>
References: <1194043193-29601-5-git-send-email-madcoder@debian.org> <1194112219-19968-1-git-send-email-madcoder@debian.org> <1194112219-19968-2-git-send-email-madcoder@debian.org> <1194112219-19968-3-git-send-email-madcoder@debian.org> <1194112219-19968-4-git-send-email-madcoder@debian.org> <7v7ikytpz0.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711041343470.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="oOB74oR0WcNeq9Zb";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 04 15:18:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IogJ0-0005xG-FE
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 15:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000AbXKDOSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 09:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755003AbXKDOSM
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 09:18:12 -0500
Received: from pan.madism.org ([88.191.52.104]:49751 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755000AbXKDOSL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 09:18:11 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 83C68258FA;
	Sun,  4 Nov 2007 15:18:09 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 2803F435B49; Sun,  4 Nov 2007 15:18:09 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711041343470.4362@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63408>


--oOB74oR0WcNeq9Zb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 04, 2007 at 01:48:36PM +0000, Johannes Schindelin wrote:
> > Pierre Habouzit <madcoder@debian.org> writes:
> > It takes on the standard input the specification of the options to parse
> > and understand, and echoes on the standard ouput a line suitable for=20
> > `sh(1)` `eval` to replace the arguments with normalized ones.
>=20
> Why not go the full nine yards and output something which when eval'ed=20
> sets the variables correctly (taking the variable names from the option=
=20
> names; long name if available, otherwise short one)?  It can also set the=
=20
> command line arguments to what's left after option parsing, with a "set"=
=20
> call.

We could do that, though it's not as great as it looks like at the first
glance. If you want -vvv to work like an accumulator, then you need a
really more complex approach in the C code. To enter the gory details,
git-rev-parse --parseopt uses a callback that deals with options and
their arguments one by one, then appends a delimiter to tell the shell
script that only arguments follow, and then appends the arguments the
option parser left alone.

It does not deal with the semantics that the C has available at all,
it's up to the shell script to decide which is better.

My goal with this is not really to do all the work for the shell script
author, but rather to the user: it's not because a porcelain is new (or
not a builtin yet) that it should have a creepy interface. If it helps
the programmer as a side effect, then it's great, but this series really
is about usability to me.

Of course we can do what you propose, but it will probably be quite
sophisticated and looks to me like an overkill to what shell builtins
really are used for: prototyping a new porcelain until it becomes a new
full blown C-builtin.  I do believe in simplicity after all :)

> And to prevent funny games with "PARSEOPT_OPTS=3Dblabla git xyz", why not=
=20
> provide a function in git-sh-setup which takes the string as argument, an=
d=20
> is called _after_ sourcing git-sh-setup?

This one is quite a non issue, it's only used for keep-dashdash, and I
see no other need in the near future. And if the need arise, it'll still
be doable any time. So for now I've taken a non-generic way to do that,
and I believe it's fine as it is.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--oOB74oR0WcNeq9Zb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHLdShvGr7W6HudhwRAkp/AJ9O/ur2mXV7KuBVXaEhfu4OrbdKigCaAvKp
8IrLp6BV89IInt6B5LmbktE=
=4+z3
-----END PGP SIGNATURE-----

--oOB74oR0WcNeq9Zb--
