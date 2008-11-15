From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [take 2] git send-email updates
Date: Sat, 15 Nov 2008 23:05:10 +0100
Message-ID: <20081115220510.GA11895@artemis.corp>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org> <1226361242-2516-1-git-send-email-madcoder@debian.org> <7v4p2e0zus.fsf@gitster.siamese.dyndns.org> <20081111221351.GE10073@artemis.corp> <7vk5b9x0kj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="fdj2RfSjLxBAspz7";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 23:06:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1THk-0006Vr-Oz
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 23:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbYKOWFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 17:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbYKOWFQ
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 17:05:16 -0500
Received: from pan.madism.org ([88.191.52.104]:49009 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101AbYKOWFP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 17:05:15 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id DFF693B429;
	Sat, 15 Nov 2008 23:05:12 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id B3F4A2A346; Sat, 15 Nov 2008 23:05:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vk5b9x0kj.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101090>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2008 at 12:14:20AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > Oh you mean that if one use --no-format-patch you don't wan't _any_
> > option to be passed to format-patch?
>=20
> The option name --no-format-patch sounded like "I do not want you to act
> as a frontend, ever", i.e. if you type master..next by mistake on the
> command line, the command would barf when the option is given.  Not even
> "pass to format-patch", but "do not run format-patch to begin with".
>=20
> It is not a big deal especially for interactive use (and that is why I
> said "somewhat" unfortunate).
>=20
> > If we're really doing this, then maybe we want a 5-state kind of option:
> >   1 disallow any file name ;
> >   2 if conflict, chose the revision ;
> >   3 barf if any conflict arises (default) ;
> >   4 if conflict chose the file ;
> >   5 disallow any kind of revision argument.
> >
> > My proposal implements 2 as --format-patch, 3 as default, and 4 as
> > --no-format-patch. You propose basically (5) for --no-format-patch
> > instead, well I say this makes sense, but it's somehow "sad" not to have
> > (1) too in that case.
>=20
> Actually, "send-email --format-patch master..fixes Documentation/" may be
> a useful command to send out only documentation fixes.  For such a usage,
> Documentation/ should not be taken as a maildir.  If we would want to
> support such usage (and I'd say why not), a token can fall into one (or
> two) of three categories:

You can do that doing:

git send-email --format-patch master..fixes -- Documentation/

I've kept the `--` usual meaning, and it's sent to git-format-patch
verbatim and it'll work, so it's not required to change the meaning of
the options for that.

[sorry for the late reply, I've been somehow busy lately]

The sole conflict we have is when there is a path/rev conflict *before*
the `--` because of the legacy of git-send-email. I believe that
--format-patch should still allow to send patches passed on the command
line, this way.

> As to options, how about doing this:
>=20
>     --no-format-patch means never ever run format-patch, behave exactly as
>     before;
>=20
>     --format-patch means what you have in your patch.  guess and favor=20
>     format-patch parameter when ambiguous;
>=20
>     without either option, guess and favor mbox/maildir but still run
>     format-patch if remaining parameters and options need to
>     (e.g. "send-email my-cover-letter origin/master..master" will find
>     my-cover-letter which is not tracked and take it as mbox, and grab
>     patches from commits between origin/master..master, and send all of
>     them).

That's sane and I like it.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkfR5UACgkQvGr7W6Hudhz0PwCeLNGAoL9S6hr6uviGyITm3bWb
JVQAnjAW3FLHwXzEgYvITJT6nNblcpmf
=sLl2
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
