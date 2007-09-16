From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] strbuf's in builtin-apply
Date: Sun, 16 Sep 2007 19:21:34 +0200
Message-ID: <20070916172134.GA26457@artemis.corp>
References: <20070915141210.GA27494@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="x+6KMIRAuhnl3hBn";
	protocol="application/pgp-signature"; micalg=SHA1
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 19:21:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWxoS-0007ix-TT
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 19:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbXIPRVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 13:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbXIPRVh
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 13:21:37 -0400
Received: from pan.madism.org ([88.191.52.104]:35165 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750935AbXIPRVg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 13:21:36 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 879DC2029B;
	Sun, 16 Sep 2007 19:21:35 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id C3A0EF87F; Sun, 16 Sep 2007 19:21:34 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20070915141210.GA27494@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58326>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Following this mail will happen a new janitoring series. This is a
rewrite of the former, using Junio's advice to use strbufs in
convert_to_* functions. The patch hence becomes more intrusive than
before (in convert.c mostly). Note that this imply that now strbuf.h is
included from cache.h so all git sources see strbuf's.

The convert_to_git patches gain some marginal efficiency as the new API
makes the reuse of the buffers possible when in-place editing works
(e.g. the \r\n -> \n can be done in place, we save a malloc here). Else
nothing should have changed significantly.

The last 2 patches are new. The first one is a simplification of the
code splicing the "encoding" header in commit.c, reusing the logic
already in strbuf.c for that matter, and also making the parsing code
easier to read (IMHO).

The latter further simplify some code that was trying to guess if
rfc2047 encoding of some header was needed. Thanks to strbuf_grow, and
the fact that now at each point we can grow buffers (which was harder
before), I tried to wait until we are sure if rfc2047 encoding will be
needed or not to extend the buffer. I've benchmarked many tools (on real
repositories, with commiters having non ascii chars in their name) using
the pretty printer without noticeable changes in the numbers (and rather
again, a trend to be faster, but with less than a percent gain, so I
won't call it a real gain).

The series is based on next, as many patches are definitely not suitable
for master :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG7WYevGr7W6HudhwRAnO1AJ405127PQ9Y2CX+mfkKdkEA6eNXPACfWNKp
Hc1nSEvn46NreI7x3mpneUY=
=TIxl
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
