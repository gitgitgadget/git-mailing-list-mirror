From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 0/14] fork/exec removal series
Date: Sun, 14 Oct 2007 09:12:39 +0200
Message-ID: <20071014071239.GB1198@artemis.corp>
References: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at> <20071014021149.GO27899@spearce.org> <Pine.LNX.4.64.0710140348550.25221@racer.site> <20071014025857.GQ27899@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="LyciRD1jyfeSSjG0";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, gitster@pobox.com,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 14 09:12:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igxei-00033W-0s
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 09:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbXJNHMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 03:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbXJNHMm
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 03:12:42 -0400
Received: from pan.madism.org ([88.191.52.104]:40560 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbXJNHMl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 03:12:41 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 22B27244A4;
	Sun, 14 Oct 2007 09:12:40 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id ADBA139B17C; Sun, 14 Oct 2007 09:12:39 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, gitster@pobox.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071014025857.GQ27899@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60800>


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 14, 2007 at 02:58:57AM +0000, Shawn O. Pearce wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Sat, 13 Oct 2007, Shawn O. Pearce wrote:
> >=20
> > > Since builtin-pack-objects now accepts (limited) pthread support,=20
> > > perhaps this should be implemented in terms of pthread support when=
=20
> > > pthreads are available?
> >=20
> > Falling back to fork() when no pthreads are available?  Yes, that makes=
=20
> > sense.
> >=20
> > It might also (marginally) speed up operations, since the switches betw=
een=20
> > threads are cheaper than those between processes, right?
>=20
> Usually.  If we have a large virtual address space (say due to
> opening a bunch of packfiles and reading commits out of them into
> struct commit* thingies) and the OS does a giant copy of the page
> tables during fork() then the pthread creation should be a heck of
> a lot cheaper.
>=20
> But we most definately *must* continue to support fork() for the
> async functions.  Its the most common interface available on one
> of our biggest platforms (UNIX).

  Yeah that, and the fact that many of the git modules aren't
thread-safe (some modules have static buffers strbuf's or caching
variables) and should be used with care.

  The trivial way is to add a __thread keyword to make them TLS
variables, though, it's not really a step in the direction of
portability, and last time I looked at it, mingw didn't had TLS support,
not sure if msys has. Though, if Msys has, it's worth using, and we
could require that targets using the fancy pthread thingy should also
have some fancy TLS, or use fork().

  Portability for such issues, would be to use pthread_key_* and
pthread_{get,set}specific, and those are a hell of a sucky API.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHEcFnvGr7W6HudhwRAoKVAKCLuylXpQqsLFJz26TWQApPnedKWQCePS8S
tpx67aeeTB5n16/6kqgsPLQ=
=Gzvg
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
