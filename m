From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git blame not respecting --find-copies-harder ?
Date: Thu, 31 Jul 2008 11:01:46 +0200
Message-ID: <20080731090146.GA12867@artemis.madism.org>
References: <20080730093903.GA14330@cuci.nl> <20080730150123.GB9758@atjola.homenet> <bd6139dc0807300843l1d42d6fep95f6c99fe6e0ea0@mail.gmail.com> <20080731064814.GA32431@sigill.intra.peff.net> <7vfxpq3559.fsf@gitster.siamese.dyndns.org> <20080731072149.GA2304@sigill.intra.peff.net> <7v8wvi33ok.fsf@gitster.siamese.dyndns.org> <20080731082553.GA19522@sigill.intra.peff.net> <7v8wvizc16.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="AhhlLboLdkugWU4S";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>, sverre@rabbelier.nl,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 11:02:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOU3i-00085A-Mv
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 11:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbYGaJBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 05:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752489AbYGaJBx
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 05:01:53 -0400
Received: from pan.madism.org ([88.191.52.104]:42998 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355AbYGaJBv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 05:01:51 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 96A723C5FA;
	Thu, 31 Jul 2008 11:01:47 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 54AB9FDE; Thu, 31 Jul 2008 11:01:46 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	sverre@rabbelier.nl,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Git Mailinglist <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7v8wvizc16.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90913>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2008 at 08:35:33AM +0000, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > On Thu, Jul 31, 2008 at 12:36:59AM -0700, Junio C Hamano wrote:
> >
> >> Alas, shortlog does not take --all.  Yes, I know
> >>=20
> >> 	git log --since=3D3.day --all | git shortlog | sort | uniq -c
> >>=20
> >> is an obvious workaround, but it is mildly irritating.
> >
> > Hmm. Could it be as simple as:
> >
> > diff --git a/revision.c b/revision.c
> > index a843c42..eaa5572 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -1002,7 +1002,7 @@ static int handle_revision_opt(struct rev_info *r=
evs, int argc, const char **arg
> >  	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk"))
> >  	{
> >  		unkv[(*unkc)++] =3D arg;
> > -		return 0;
> > +		return 1;
> >  	}
> > =20
> >  	if (!prefixcmp(arg, "--max-count=3D")) {
> >
> > That is, handle_revision_opt says "yes we parsed this, and it should be
> > gone" even though it still gets stuck in the "unknown" section to be
> > parsed by setup_revisions later.

  Ack this is a correct fix. I wonder how this even works with other
commands that use --all and stuff like that.

> Hmm, wouldn't that suggest it needs to return 1 when an option candidate
> given to diff_opt_parse() turns out not to be a diff option and stuffed
> back to unkv[] at the end of this function?

  No, because diff-opts are our last chance, and those are _really_
unknown options. "--all" is different because revision machinery
acknowledge "yeah it's really for us, we recognize it ..." hence the 1
result "... but we have to parse it later so keep it in place".

  There is no such thing with unknown option for the revision _and_ diff
machinery. They _must_ return 0 to say "no we really didn't know what
this is".

  IOW, semantics is:

    < 0 : error
    0   : option was not directed at us, unknown (this allow to chain
          option parsers.
    > 0 : yeah this was for us, and we consumed this amount of arguments
          in the process.

  Here "--all" is clearly something that we _recognized_ hence fit in
the third case, even if we decide to still keep it in the "unk" array
(which is ill named, I kept its name, but it's not unknown options, it's
actually non option arguments that are to be deal with in the last
stage, setup_revisions here, or the command as a general rule).

  Unknown options to both the revision _and_ diff option machineries are
clearly of the 2nd kind and must return 0. They put the option in 'unk'
as well (and here this is properly named) because this is how it
historically worked for many commands, and is here as a legacy
compatibility thing. parse-opt based parser (and git-shortlog has one)
does not uses that (and you can see it in parse_revision_opt that is
what such parser use: a result of `0' triggers a usage).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiRf3oACgkQvGr7W6HudhxvaACfe6hsRRoOJh03wt72CcOAqgGV
nXIAoIQ9mapsXR5QRCDGTXTJ1bRzeWlQ
=sb4B
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
