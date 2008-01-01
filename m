From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH WIP] sha1-lookup: make selection of 'middle' less  aggressive
Date: Tue, 01 Jan 2008 15:51:30 +0100
Message-ID: <20080101145130.GD3893@artemis.madism.org>
References: <7vd4soa3cw.fsf@gitster.siamese.dyndns.org> <7vtzm08l9w.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0712301150120.32517@woody.linux-foundation.org> <7vodc77t0o.fsf@gitster.siamese.dyndns.org> <e5bfff550712301404g273dd092w9b36b48d94ed1e70@mail.gmail.com> <alpine.LFD.1.00.0712311232520.32517@woody.linux-foundation.org> <20080101063616.GA21605@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="UfEAyuTBtIjiZzX6";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 01 15:52:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9iTM-0004E3-Dc
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 15:52:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbYAAOve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2008 09:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752290AbYAAOvd
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 09:51:33 -0500
Received: from pan.madism.org ([88.191.52.104]:43105 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752216AbYAAOvc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 09:51:32 -0500
Received: from madism.org (unknown [82.236.23.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A77E520FA0;
	Tue,  1 Jan 2008 15:51:30 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 300D23388; Tue,  1 Jan 2008 15:51:30 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080101063616.GA21605@coredump.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69438>


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 01, 2008 at 06:36:16AM +0000, Jeff King wrote:
> zlib makes a noticeable impact in real world cases. On a git.git repo,
> fully packed with stock config, warm cache:

On linux-2.6.git, with compressed packs:

    $ =3Dtime git whatchanged >|/dev/null
    19.67user 1.24system 0:21.01elapsed 99%CPU (0avgtext+0avgdata 0maxresid=
ent)k
    0inputs+0outputs (0major+38556minor)pagefaults 0swaps

Without compression:

    $ =3Dtime git whatchanged >|/dev/null
    14.41user 1.23system 0:15.67elapsed 99%CPU (0avgtext+0avgdata 0maxresid=
ent)k
    0inputs+0outputs (0major+44678minor)pagefaults 0swaps


> More pagefaults, but a 25% improvement in wall clock time.  The packfile
> is noticeably larger (55M versus 40M), so I'm sure the cold cache case
> sucks. It may also change with larger repos, where the packfile size
> difference kills your cache.

  The packfile is _incredibly_ larger (~200Mo -> ~420, though I suppose
the first one was packed with a larger window, coming from kernel.org).
I experience the same 25% wall clock reduction here as well. Though,
even if larger, linux-2.6.git still stays in RAM easily on my machine.

  On an unrelated note, I wonder if it wouldn't be possible for git at
fetch time to "share" a very efficient pack that was computed on some
host. I mean, if I'm not mistaken, at clone time you get the efficient
pack, but at fetch time only incremental parts. I wonder if there would
be ways to say "hey, we recomputed here a very very very good pack, take
it instead of yours.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHelNyvGr7W6HudhwRAlosAJ9Dsd9Bdg1+ORUxmSfEpbZis1iOTwCfY3TH
spRJK1zAiSQeM8xCN5K9qEY=
=iFvX
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--
