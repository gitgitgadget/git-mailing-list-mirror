From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFH] convert shortlog to use parse_options
Date: Thu, 13 Dec 2007 19:03:47 +0100
Message-ID: <20071213180347.GE1224@artemis.madism.org>
References: <20071213055226.GA3636@coredump.intra.peff.net> <20071213090604.GA12398@artemis.madism.org> <20071213091055.GA5674@coredump.intra.peff.net> <20071213093536.GC12398@artemis.madism.org> <7vbq8u4ho8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="TiqCXmo5T1hvSQQg";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 19:04:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2sPt-0004bS-Ug
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 19:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802AbXLMSDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 13:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754311AbXLMSDv
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 13:03:51 -0500
Received: from pan.madism.org ([88.191.52.104]:34906 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754032AbXLMSDu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 13:03:50 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D57B119737;
	Thu, 13 Dec 2007 19:03:48 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id C8309684; Thu, 13 Dec 2007 19:03:47 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vbq8u4ho8.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68179>


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2007 at 05:40:23PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > In fact we have kind of the issue for every single optional argument out
> > there:
> >
> > $ git describe --abbrev HEAD
> > error: option `abbrev' expects a numerical value
> > [...]
> >
> >   *ouch*
> >
> > So I believe that with optional arguments we must change the way we do
> > things, and that we _must_ enforce the argument to be sticked in that
> > case.
>=20
> I think "Must" is a bit too strong an expression.
>=20
> 	git describe --abbrev 7 HEAD
>         git describe --abbrev HEAD
>         git describe --abbrev=3DHEAD
> 	git describe --abbrev=3D7 HEAD
> 	git describe --abbrev
>=20
> The --abbrev parser in this case could be asked with this question: "You
> are on the command line.  There is a token after you.  Is it your
> parameter?".

  I thought of that, but it's really convoluted and can definitely lead
to very subtle issues. The number of git commands with optional
arguments is quite low, mostly due to legacy, I don't expect _new_
commands to take optional arguments. I don't really like the ambiguity
it creates, and in some cases you just won't be able to disambiguate at
all. Here it looks nice because --abbrev takes an integer argument, and
it's likely that no branch nor reference names will be only made of
digits. Though for commands taking an optional string[0] argument this is
way more fishy.

  *I* (and it's my opinion, maybe other don't see it that way) see the
parse-option module as a convenience given to people using the CLI UI in
an interactive shell. So it tries to achieve a good balance between
brevity and error detection. Here I think it's quite error prone and
gives almost no help to the user: if there is a gain to type git repack
-afd vs. git repack -a -f -d, I see no real gain in --abbrev 10 vs.
--abbrev=3D10.


  [0] OTOH I'm not sure there will ever be optional arguments that
      aren't integers in git, but I may be wrong.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHYXQDvGr7W6HudhwRAs/wAJ457UnEca7Ov4Ku9dya6fKXyN1VqACfV728
/itD2pM3RwjxWVxMv8Xl1YY=
=QX7D
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
