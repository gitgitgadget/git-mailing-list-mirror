From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH/RFC 01/10] Teach rebase interactive the mark command
Date: Sat, 12 Apr 2008 12:11:11 +0200
Message-ID: <20080412101110.GD31356@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de> <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de> <7vskxsneau.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="76DTJ5CE0DCVQemd"
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 12:21:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkcrH-0003Fp-TN
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 12:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757390AbYDLKUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 06:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758622AbYDLKUg
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 06:20:36 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:4687 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757297AbYDLKUP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 06:20:15 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 84D20488062; Sat, 12 Apr 2008 12:20:11 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JkchT-0000n7-AP; Sat, 12 Apr 2008 12:11:11 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JkchT-0008LS-13; Sat, 12 Apr 2008 12:11:11 +0200
Content-Disposition: inline
In-Reply-To: <7vskxsneau.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79345>


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Junio,

Junio C Hamano schrieb am Fri 11. Apr, 16:48 (-0700):
> J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:
>=20
> > This new command can be used to set symbolic marks for an commit while
> > doing a rebase. This symbolic name can later be used for merges or
> > resets.
> > ---
>=20
> Comments as requested...

Thanks.

> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index 8aa7371..b001ddf 100755
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -23,6 +23,7 @@ DONE=3D"$DOTEST"/done
> >  MSG=3D"$DOTEST"/message
> >  SQUASH_MSG=3D"$DOTEST"/message-squash
> >  REWRITTEN=3D"$DOTEST"/rewritten
> > +MARKS=3D"$DOTEST"/marks
>=20
> I wonder if this should live somewhere inside $GIT_DIR/refs namespace, so
> that if any object pruning is triggered ever while rebasing interactively
> the objects that marks require will be protected.

Why wasn't the rewritten directory underneath refs/?

> > @@ -240,6 +241,23 @@ peek_next_command () {
> >  	sed -n "1s/ .*$//p" < "$TODO"
> >  }
> > =20
> > +parse_mark() {
> > +	local tmp
>=20
> Bashism is not appreciated here.

=E2=80=9CIEEE P1003.2 Draft 11.2 - September 1991=E2=80=9D, page 277:

 Local variables within a function were considered and included in Draft
 9 (controlled by the special built-in local), but were removed because
 they do not fit the simple model developed for the scoping of functions
 and there was some opposition to adding yet another new special built-in
 from outside existing practice.  Implementations should reserve the
 identifier local (as well as typeset, as used in the KornShell) in case
 this local variable mechanism is adopted in a future version of POSIX.2.

=E2=80=A6 but I didn't found it in =E2=80=9CIEEE Std 1003.1, 2004 Edition=
=E2=80=9D.

> > +	case "$tmp" in
> > +	'#'[0-9]*)
> > +		tmp=3D"${tmp#\#}"
> > +		if test "$tmp" =3D $(printf %d "$tmp")
> > +		then
> > +			echo $tmp
> > +			return 0
> > +		fi
> > +		;;
> > +	esac
>=20
> Wouldn't
>=20
> 	pick 5cc8f37 (init: show "Reinit" message even in ...)
> 	mark 1
> 	pick 18d077c (quiltimport: fix misquoting of parse...)
> 	mark 2
> 	reset 1

=E2=80=9Creset 18d077c~2=E2=80=9D or =E2=80=9Creset some-tag=E2=80=9D or =
=E2=80=9Creset my-branch~12=E2=80=9D

>         merge #2
>=20
> be easier for people?

I don't know. Using the special sign everywhere a mark is used looks more
consistent to me. The only case where it might be omitted is the mark
command, because it only uses marks.

> When you reference a commit with mark name, it is reasonable to require it
> to be prefixed with '#', which is a character that cannot be either in
> refname nor hex representation of a commit object.  I think it is Ok to
> accept an optional prefix when defining one, e.g. "mark #47", but I do not
> think requiring '#' prefix when defining one is needed.

That sounds useful.

BTW: Should the mark be a number or a string, e.g. 001 =3D=3D 1 or 001 !=3D=
 1?

> > @@ -317,6 +335,23 @@ do_next () {
> >  			die_with_patch $sha1 ""
> >  		fi
> >  		;;
> > +	mark|a)
>=20
> I understand that the reason why you did not pick a more obvious 'm' is
> because you would want to add 'merge' later and give it 'm', but we do not
> have to give a single-letter equivalent to all commands especially when
> there is not an appropriate one.

That's fine. I thought it's a requirement.

Bye, J=C3=B6rg.
--=20
Was der Bauer nicht kennt, das frisst er nicht. W=C3=BCrde der St=C3=A4dter=
 kennen,
was er frisst, er w=C3=BCrde umgehend Bauer werden.
                                                       Oliver Hassencamp

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIAIq+we0mZwH1VIARAlpRAJ40o6fnl7AhSE5h/OajJ88mv1GbvgCdFYO1
UjZSJMC7EC2sbCb0QpTjsBU=
=3Zhk
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--
