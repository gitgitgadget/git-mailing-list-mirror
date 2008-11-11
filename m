From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [take 2] git send-email updates
Date: Tue, 11 Nov 2008 23:13:51 +0100
Message-ID: <20081111221351.GE10073@artemis.corp>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org> <1226361242-2516-1-git-send-email-madcoder@debian.org> <7v4p2e0zus.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="96YOpH+ONegL0A3E";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 23:15:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L01Vv-00042M-CW
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 23:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbYKKWN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 17:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbYKKWN4
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 17:13:56 -0500
Received: from pan.madism.org ([88.191.52.104]:51356 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbYKKWNz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 17:13:55 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id A08CA3D176;
	Tue, 11 Nov 2008 23:13:53 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id E75432A28E; Tue, 11 Nov 2008 23:13:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v4p2e0zus.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100687>


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2008 at 08:30:51PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > The last patch is dropped for now (the automatic --compose stuff)
> > because I'm not sure which option to add, and that I don't care enough
> > about it to spend more time on it.
> >
> > I think I've incorporated most of the stuff people asked about in this
> > series.
> >
> >  [PATCH 1/4] git send-email: make the message file name more specific.
> >  [PATCH 2/4] git send-email: interpret unknown files as revision lists
> >  [PATCH 3/4] git send-email: add --annotate option
> >  [PATCH 4/4] git send-email: ask less questions when --compose is used.
>=20
> Thanks.
>=20
> It is somewhat unfortunate that an explicit --no-format-patch works
> exactly the same way as not giving the option at all.

Unless I'm mistaken in my code, and I may really be, it doesn't.
--format-patch says that in case of conflicts, the "revision" kind of
argument wins, --no-format-patch says that the "file" one wins, without
any it dies with an error. It's really a tristate, but maybe I missed
your point ?

> I would have expected that it would guess and warn if you did not give
> either, and it would not even guess (i.e. file is mbox, dir is
> maildir) and error out if there is a leftover option in @rev_list_opts
> if the user explicitly asked the command not act as a frontend to
> format patch.

Oh you mean that if one use --no-format-patch you don't wan't _any_
option to be passed to format-patch ? Hmmm I don't know, both what I did
and that are sane, I don't really know what to chose. But if we're going
to go down this road, _your_ --no-format-patch and --format-patch don't
quite do the opposite, as --format-patch still allows files to be passed
to it.

If we're really doing this, then maybe we want a 5-state kind of option:
  1 disallow any file name ;
  2 if conflict, chose the revision ;
  3 barf if any conflict arises (default) ;
  4 if conflict chose the file ;
  5 disallow any kind of revision argument.

My proposal implements 2 as --format-patch, 3 as default, and 4 as
--no-format-patch. You propose basically (5) for --no-format-patch
instead, well I say this makes sense, but it's somehow "sad" not to have
(1) too in that case.

But in the end, I believe this _may_ quite be slightly over-engineered in
the end ;) I would gladly implement the combination people like most, as
soon as I can pass format-patch option a way or the other, I'm happy :)

> I will queue the series in 'pu' because I suspect you would like a chance
> to amend out a "print foo" from the second commit ;-)

*ooops*

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkaA58ACgkQvGr7W6HudhwoUACdH0g8sdOaCndW6uTWwIXe9nvs
dcwAn0Ie+HtN+0m8Qrj6euxoYidSfkGa
=BCOp
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
