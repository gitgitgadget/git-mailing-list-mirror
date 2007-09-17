From: Pierre Habouzit <madcoder@debian.org>
Subject: xmemdup patches
Date: Mon, 17 Sep 2007 18:11:13 +0200
Message-ID: <20070917161113.GB460@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ZfOjI3PrQbgiZnxM";
	protocol="application/pgp-signature"; micalg=SHA1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 18:11:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXJBv-0004rt-Nf
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 18:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbXIQQLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 12:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbXIQQLP
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 12:11:15 -0400
Received: from pan.madism.org ([88.191.52.104]:48338 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220AbXIQQLP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 12:11:15 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id BCBC26AB
	for <git@vger.kernel.org>; Mon, 17 Sep 2007 18:11:13 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 0FD72344A49; Mon, 17 Sep 2007 18:11:13 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58455>


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  I noticed a lot of places in git's code use code like:

  char *res;

  ...

  res =3D xmalloc(len + 1);
  memcpy(res, src, len);
  res[len] =3D '\0';
  return res;

  I've added a "xmemdup" function that duplicates a portion of memory,
also adding an extra NUL after the end of the buffer. There was a
xstrndup already, doing almost the same, except that it worked like
strndup, meaning that it duplicates the memory areay up to len or the
first embeded NUL. The extra scan costs, and is often not necessary (as
we want to extract a token from a buffer we just validated e.g.).

  There were 41 of those places.


  I'm not a huge fan of "xmemdup" as I would not have supposed that a
function called like that would add the extra NUL, so I'm 100% okay with
someone coming up with any better name.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG7qchvGr7W6HudhwRAkcoAJ9/D9QcatcPVOUb1c/FpXjcqWOoTACePhrC
2eibtKhKBvAag4+IKvToNLU=
=TbQw
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
