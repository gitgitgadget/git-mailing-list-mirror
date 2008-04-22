From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Tue, 22 Apr 2008 11:55:49 +0200
Message-ID: <20080422095549.GB3752@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de> <7vabjm78v2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 12:03:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoFL2-0004lF-0P
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 12:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758868AbYDVKCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 06:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758581AbYDVKCN
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 06:02:13 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:2404 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758247AbYDVKCL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 06:02:11 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 3E5D6488025; Tue, 22 Apr 2008 12:02:07 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JoFE6-0007n0-3O; Tue, 22 Apr 2008 11:55:50 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JoFE5-00014G-Qo; Tue, 22 Apr 2008 11:55:49 +0200
Content-Disposition: inline
In-Reply-To: <7vabjm78v2.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80092>


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Junio,

Junio C Hamano schrieb am Mon 21. Apr, 22:32 (-0700):
> J=F6rg Sommer <joerg@alea.gnuu.de> writes:
>=20
> >  cleanup_before_quit () {
> > -	rm -rf "$DOTEST"
> > +	rm -rf "$DOTEST" &&
> > +	for ref in "$GIT_DIR/$mark_prefix"*
> > +	do
> > +		test "$ref" =3D "$GIT_DIR/$mark_prefix*" && continue
> > +		git update-ref -d "${ref#$GIT_DIR/}" "${ref#$GIT_DIR/}" || \
> > +			return 1
> > +	done
>=20
> In practice nobody would "run" pack-refs during the rebase session, but I
> have to wonder if it can be triggered to run as part of automated gc or
> something, in which case this loop does not work as intended. It needs to
> be rewritten using for-each-ref.

What do you think about this version:

cleanup_before_quit () {
	rm -rf "$DOTEST" &&
	for ref in $(git for-each-ref --format=3D'%(refname)' ${mark_prefix%/})
	do
		git update-ref -d "$ref" "$ref" || return 1
	done
}

> > @@ -244,6 +252,19 @@ peek_next_command () {
> >  	sed -n "1s/ .*$//p" < "$TODO"
> >  }
> > =20
> > +mark_to_ref () {
> > +	case "$1" in
> > +	:[!/]*)
> > +		# :/SOMETHING is a reference for the last commit whose
> > +                # message starts with SOMETHING
> > +		echo "$mark_prefix${1#:}"
> > +		;;
>=20
> What was the conclusion of the mark-syntax discussion?

Use the same as fast-import and fix fast-import. :)

I've posted a new version
<1208169584-15931-1-git-send-email-joerg@alea.gnuu.de>

Bye, J=F6rg.
--=20
Nutze die Talente, die du hast. Die W=E4lder w=E4ren sehr still,
wenn nur die begabtesten V=F6gel s=E4ngen.                (Henry van Dyke)

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIDbYlwe0mZwH1VIARAgsvAKC8zXfvcFj+ojWwDGAGgfR6YvRoqgCdFTEv
gfm4HnlNLEUiIy5US5E6v54=
=i2on
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
