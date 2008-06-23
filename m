From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 23:28:56 +0200
Message-ID: <20080623212855.GE13395@artemis.madism.org>
References: <20080623164917.GA25474@sigill.intra.peff.net> <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <20080623183358.GA28941@sigill.intra.peff.net> <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231158340.2926@woody.linux-foundation.org> <20080623210935.GC13395@artemis.madism.org> <7vprq7hmkx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="kA1LkgxZ0NN7Mz3A";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 23:31:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAtbt-0003uS-SF
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 23:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725AbYFWV3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 17:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752552AbYFWV3A
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 17:29:00 -0400
Received: from pan.madism.org ([88.191.52.104]:44259 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754725AbYFWV27 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 17:28:59 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 606F637F40;
	Mon, 23 Jun 2008 23:28:57 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 4D91029FE; Mon, 23 Jun 2008 23:28:56 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vprq7hmkx.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85936>


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2008 at 09:23:58PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   With that, you write parsers this way:
> >
> > {
> >     struct parse_opt_ctx_t ctx;
> >
> >     parse_options_start(&ctx, argc, argv, 0);
> >
> >     for (;;) {
> >         const char *arg;
> >
> >         switch (parse_options_step(&ctx, options, usagestr)) {
> >         case PARSE_OPT_HELP:
> >             /* dump your help here, the one for options/usagestr is alr=
eady dumped */
> >             exit(129);
> >         case PARSE_OPT_DONE:
> >             goto done;
> >         }
> >
> >         arg =3D *ctx->argv++;
> >         ctx->argc--;
> >
> >         if (strcmp(arg, "-")) {
> >             /* you're on baby ! */
> >         } else if ....
> >         } else {
> >             error("unknown option %s", arg);
> >             parse_options_usage(options, usagestr);
> >             /* dump your help here */
> >             exit(129);
> >         }
> >     }
> >
> > done:
> >     argc =3D parse_options_end(&ctx);
> > }
>=20
> Nice.  I have started doing the same (insignificant details are different;
> e.g. I used "positive is unknown" convention instead ) and then the
> solution is sitting in my mbox ;-)

Well it's still rough on the edges, totally untested (I didn't bother to
run the testsuite), but I wanted some feedback before I cook this to
something nicer.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhgFZcACgkQvGr7W6HudhwIZQCggH/xzFzh8v2Hhsk1ICFEDxAE
G8cAnjmVbWpceUSM8acvmFqV5stRwAY3
=cRbf
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--
