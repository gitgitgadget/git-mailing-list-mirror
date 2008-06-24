From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Tue, 24 Jun 2008 21:43:46 +0200
Message-ID: <20080624194346.GD9189@artemis.madism.org>
References: <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net> <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <7vzlpbeksn.fsf@gitster.siamese.dyndns.org> <20080624082447.GB24357@artemis.madism.org> <alpine.LFD.1.10.0806241001140.2926@woody.linux-foundation.org> <20080624193028.GC9189@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="4zI0WCX1RcnW9Hbu";
	protocol="application/pgp-signature"; micalg=SHA1
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git
X-From: git-owner@vger.kernel.org Tue Jun 24 21:45:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBERx-00075F-RK
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 21:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbYFXTnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 15:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbYFXTnz
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 15:43:55 -0400
Received: from pan.madism.org ([88.191.52.104]:37991 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbYFXTny (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 15:43:54 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 9CA93374CD;
	Tue, 24 Jun 2008 21:43:47 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 3404A46DEE2; Tue, 24 Jun 2008 21:43:46 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080624193028.GC9189@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86127>


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2008 at 07:30:28PM +0000, Pierre Habouzit wrote:
>   Though for the win32 port where fork is replaced with threads, well,
> it may cause some issues, so I was reluctant wrt them. Of course it's
> unlikely that it will cause problems, but one never knows ;)

  OTOH if it's really a problem, we could easily use a custom allocator
in parse-options that registers a pthread_cleanup_push (or whichever
atexit() like pthread use, I'm not really into threads) that would
cleanup this[0]. So maybe just leaking is the simplest way.

  As a consequence it makes the restriction about not keeping pointers
to argv during the parse go away, and I frankly don't like this
restriction, it's counterintuitive and very error prone, which arguably
means it's a really bad design.


  [0] In fact we may even want to have some kind of
      xmalloc_that_is_freed_at_exit that could be used where we
      purposely leak things, and cleanse that on atexit() for POSIX
      platforms and whatever win32 people like to use in their threads.
      It has the nice property to avoid lots of false positives when you
      are using valgrind and other memory checkers.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhhTnIACgkQvGr7W6Hudhy+0wCZAUoZEec7XQjC8/+F3R/4stO7
lzUAmwbg8lxxaUTvzDQZHXSoS2R6dkLI
=B4c7
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
