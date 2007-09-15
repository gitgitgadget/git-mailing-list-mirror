From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] strbuf's in builtin-apply
Date: Sat, 15 Sep 2007 19:07:27 +0200
Message-ID: <20070915170727.GF27494@artemis.corp>
References: <20070915141210.GA27494@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="i3lJ51RuaGWuFYNw";
	protocol="application/pgp-signature"; micalg=SHA1
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 19:07:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWb7I-0007YU-0k
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 19:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768AbXIORHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 13:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753630AbXIORHb
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 13:07:31 -0400
Received: from pan.madism.org ([88.191.52.104]:33468 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753251AbXIORHa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 13:07:30 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 05ED81E396;
	Sat, 15 Sep 2007 19:07:28 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 3839133083B; Sat, 15 Sep 2007 19:07:27 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20070915141210.GA27494@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58263>


--i3lJ51RuaGWuFYNw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 15, 2007 at 02:12:10PM +0000, Pierre Habouzit wrote:
> +		nsize =3D buf->len;
> +		nbuf =3D convert_to_git(path, buf->buf, &nsize);
> +		if (nbuf)
> +			strbuf_embed(buf, nbuf, nsize, nsize);

  Okay, I managed to be able to be sure that convert_to_git always have
an extra ending NUL byte, with an intermediate patch.  So now I call
strbuf_embed with nsize, nsize + 1 which has negligible cost.

  Though this question remains:

>   Another suspicious hunk is:
>=20
> -	data =3D (void*) fragment->patch;
> [...]
>  	case BINARY_LITERAL_DEFLATED:
> -		free(desc->buffer);
> -		desc->buffer =3D data;
> -		dst_size =3D fragment->size;
> -		break;
> +		strbuf_embed(buf, fragment->patch, fragment->size, fragment->size);
> +		return 0;
>=20
>   TTBOMK the ->patch pointer is a pointer inside a buffer, not a buffer
> that has been malloc'ed (and there are code paths before my patch that
> would still realloc the buffer so I don't think I introduce an issue).
> It passes the test-suite without crashing, but well, maybe this should
> be a copy instead.
>=20
>   The rest is pretty straightforward.
>=20
> --=20
> =C2=B7O=C2=B7  Pierre Habouzit
> =C2=B7=C2=B7O                                                madcoder@deb=
ian.org
> OOO                                                http://www.madism.org



--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--i3lJ51RuaGWuFYNw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG7BFPvGr7W6HudhwRAmFaAJ9TwoOkKXZ01nBu0TbxpPB03YIrqACdEPRM
Lsna0ugqDXnHrAFK6mx5u8Y=
=ouJT
-----END PGP SIGNATURE-----

--i3lJ51RuaGWuFYNw--
