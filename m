From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Make builtin-reset.c use parse_options.
Date: Mon, 03 Mar 2008 18:07:07 +0100
Message-ID: <20080303170706.GA23210@artemis.madism.org>
References: <47C98472.8000002@gmail.com> <7vir05x2di.fsf@gitster.siamese.dyndns.org> <1b46aba20803020437p2a5128a5wfee3e98c32c1a610@mail.gmail.com> <7vbq5xqetq.fsf@gitster.siamese.dyndns.org> <1b46aba20803030607v726a6ba1y49ca8524e09c6eae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="9jxsPFA5p3P2qPhR";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 18:08:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWE8n-0008Sp-I0
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 18:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbYCCRHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 12:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbYCCRHL
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 12:07:11 -0500
Received: from pan.madism.org ([88.191.52.104]:47912 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771AbYCCRHK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 12:07:10 -0500
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 73A50308CE;
	Mon,  3 Mar 2008 18:07:08 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 6F44A451FE8; Mon,  3 Mar 2008 18:07:07 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Carlos Rica <jasampler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1b46aba20803030607v726a6ba1y49ca8524e09c6eae@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75948>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 03, 2008 at 02:07:57PM +0000, Carlos Rica wrote:
> On Sun, Mar 2, 2008 at 5:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >  Although "--h" still favors "--hard" over "--help":
> >
> >         $ ./git-reset --h
> >         HEAD is now at c149184...
> >
>=20
> Pierre, is there a way to give preference to --help over --hard
> when someone uses --h in command line?

  The problem is that --help (and --help-all for the matter) are "magic"
arguments that parse-options is not aware of when it deals with
abbreviations.

  I assume the sole way is to always test against --help (--help-all
whom --help is a prefix anyways) for prefixes.

  So basically we should replace the block in parse-options.c:

        if (ambiguous_option)
            ...
        if (abbrev_option)
            return get_value(p, abbrev_option, abbrev_flags);

  with something that basically does:


   ambiguous:
       if (ambiguous_option)
            ...
       if (abbrev_option) {
           if (clashes with --help) {
               ambiguous_option =3D "help";
               ambiguous_flags =3D 0;
               goto ambiguous;
           }
           return get_value....
      }


the "if (clashes with --help)" obviously has to be expansed as real
code, and should use an array of hardcoded values so that it's
extensible if the need arises.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHzDA6vGr7W6HudhwRApEMAJwIPIl+jwfSmqdUaqzgtnVxDcExTACeLeJ1
gbl9PNTSXeibv00reaoq9nk=
=v/6v
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
