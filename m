From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Have a flag to stop the option parsing at the first argument.
Date: Mon, 17 Dec 2007 12:47:03 +0100
Message-ID: <20071217114703.GH7453@artemis.madism.org>
References: <20071217095014.GF7453@artemis.madism.org> <30351C09-8BED-4D81-ABDD-2E079B4D54D2@wincent.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="dMyqICaxQaaUjrCL";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 12:47:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4ERY-00017U-LB
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 12:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934447AbXLQLrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 06:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933412AbXLQLrI
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 06:47:08 -0500
Received: from pan.madism.org ([88.191.52.104]:35702 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765542AbXLQLrG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 06:47:06 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 705BC3027D;
	Mon, 17 Dec 2007 12:47:04 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 88CC34BE7B6; Mon, 17 Dec 2007 12:47:03 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <30351C09-8BED-4D81-ABDD-2E079B4D54D2@wincent.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68545>


--dMyqICaxQaaUjrCL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2007 at 11:10:00AM +0000, Wincent Colaiuta wrote:
> El 17/12/2007, a las 10:50, Pierre Habouzit escribi=C3=B3:
>=20
> >Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> >---
> >>   // ...
> >>   /* when in `git --opt1 --opt2 foo -a -b -c` mode: */
> >>   int cmd_pos =3D git_find_builtin_command_name(argc, argv);
> >>   int count =3D parse_options(cmd_pos, argv, git_generic_options,
> >>	"git [special-options] cmd [options]", 0);
> >>   if (count)
> >>	die("unknown git command: `%s`", argv[0]);
> >>   argv +=3D cmd_pos;
> >>   argc -=3D cmd_pos;
> >>   /* here we simulate an argv of {"foo", "-a", "-b", "-c"} */
> >
> >   Or even simpler, with the following specifically tailored patch you
> >   can directly write:
> >
> >   argc =3D parse_options(argc, argv, git_generic_options,
> >	"git [generic-options] <command> [cmd-options]",
> >	PARSE_OPT_STOP_AT_ARG);
> >
> >   and then {argc, argv} will exactly be the NULL-terminated array
> >   starting with the builtin command. Kind of nice :)
>=20
> Indeed, nice ideas. I think all this will lead to a nice UI improvement=
=20
> post-1.5.4.
>=20
> About the only thing that I think would merit action *prior* to 1.5.4 is=
=20
> marking the "-p" switch to git (synonym for --paginate) as deprecated,=20
> see as it clashes with other commands' uses of that switch ("git log -p"=
=20
> for example). Are there any other conflicting specials that a currently=
=20
> parsed in git.c?

  You don't need to, and I'd see that as a regression. With my proposal,
there isn't any kind of need that git commands do not clash with git
ones. The parse-option mechanism will properly hide options that are
masked this way, dscho wrote the patch for that.

  git -p log -p ...

just makes sense to me. CVS or SVN e.g. (don't hit me !) have the same
kind of "issues", and I never found that weird.

  In fact I see this the other way around: git status -p that is in fact
the same as git -p status, is the conveniency, git -p status is the
canonical form.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--dMyqICaxQaaUjrCL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHZmG3vGr7W6HudhwRAm4UAJ9QrXRCfb8Hqkcdf0pnnE//j4j+6ACeNOg7
Is4tA7UIZi66kbylCaT5Cn8=
=+KLf
-----END PGP SIGNATURE-----

--dMyqICaxQaaUjrCL--
