From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Use of strbuf.buf when strbuf.len == 0
Date: Thu, 27 Sep 2007 13:22:04 +0200
Message-ID: <20070927112204.GE10289@artemis.corp>
References: <7vir5wy6fv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="uCPdOCrL+PnN2Vxy";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 13:22:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IarRl-0004cI-MQ
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 13:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbXI0LWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 07:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754377AbXI0LWM
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 07:22:12 -0400
Received: from pan.madism.org ([88.191.52.104]:35556 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754206AbXI0LWL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 07:22:11 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 6794122045;
	Thu, 27 Sep 2007 13:22:05 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id DC8C89378; Thu, 27 Sep 2007 13:22:04 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vir5wy6fv.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59284>


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 27, 2007 at 06:21:24AM +0000, Junio C Hamano wrote:
> It would be appreciated if somebody with a fresh pair of eyes
> can go over the strbuf series one more time to make sure that we
> do not try to blindly use buf.buf, assuming buf.buf[0] is NUL if
> (buf.len =3D=3D 0).

  Like said in the 2/2 patch, I think it's better if people could be
able to always assume that and be done with it, else you have to know
this internal duality of the empty strbuf and it sucks.

  Instead, what is important, is that people that initialized a strbuf,
then want to go back in the char* world gets a NULL if nothing was
allocated. It is a semantics that is used in a few places (it's arguable
that it's a right thing to assume though). For those, making
strbuf_detach use mandatory, and dealing with the special ->alloc =3D=3D 0
case is the easiest way.

  And as I don't trust my eyes to be fresh, I've used the aid of the
compiler to bust any place where we were using .buf members directly,
possibly doing something stupid.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG+5JcvGr7W6HudhwRApi1AJ0exL95c4Ftj2vsQas5e1igc5p83ACfeyDE
G/ZG56jMuqmsFqFmfe2sp+w=
=BZPE
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--
