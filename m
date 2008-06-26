From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-send-pack: don't consider branch lagging behind as  errors.
Date: Thu, 26 Jun 2008 15:28:58 +0200
Message-ID: <20080626132858.GE7237@artemis.madism.org>
References: <1213872715-11182-1-git-send-email-madcoder@debian.org> <20080619133747.GA31209@sigill.intra.peff.net> <20080619135159.GA19560@artemis.madism.org> <20080619151110.GA31654@sigill.intra.peff.net> <20080626075036.GA25770@sigill.intra.peff.net> <7vfxr0sj61.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Ycz6tD7Th1CMF4v7";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 15:30:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBrY9-0007JM-Ny
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 15:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbYFZN3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 09:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbYFZN3J
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 09:29:09 -0400
Received: from pan.madism.org ([88.191.52.104]:45796 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754484AbYFZN3H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 09:29:07 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id E66F138864;
	Thu, 26 Jun 2008 15:28:59 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id A6AAAA54F; Thu, 26 Jun 2008 15:28:58 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vfxr0sj61.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86449>


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2008 at 08:19:02AM +0000, Junio C Hamano wrote:
> I however think what Pierre wanted to do is different, and you do not have
> to solve "force this strict rewind" problem to solve it.
>=20
> What we need is (with a configuration option) to change the meaning of
> "matching refs" from the current definition "branches with the same name
> between here and there" to "branches with the same name between here and
> there, but excluding the ones that do not fast forward (or strictly
> behind)".  So if you have tons of stale branches you checked out but
> haven't touched most of them, your "matching push" won't even try to push
> what you haven't touched.
>=20
> I do not think we would ever want to allow a configuration that disables
> the exit status from push upon a push failure when somebody explicitly
> says "git push $there $this" and $this is not non-fast-forward.  If you
> asked $this to be pushed, and if $this cannot be pushed, we _should_ error
> out.
>
> So...
>=20
>  (1) when you say "git push" to trigger the "matching refs" push, with the
>      new configuration, you do not error out nor even try to push out
>      things that do not fast forward.  Pretend that you did not even
>      attempt to push them, and do not error out.  This may result in not
>      pushing anything out, but that is what the people who have such a
>      configuration is asking for.
>=20
>      If you have configured which branches are pushed when you are on your
>      current branch, and that branch --- most likely it is that current
>      branch --- does not fast forward, it is your problem.
>=20
>  (2) even with such a configuration, you can "git push $there $this" and
>      "git push $there +$this" to explicitly ask refs to be pushed.  Such a
>      push won't be interfered by the new configuration and correctly fail
>      (or force).

  Of course if I: git push $remote $branch, if it's stalled, I want it
to fail (exit with !0). *BUT* if I don't specify branches, I don't want
the stalled ones to generate noise. That's exactly the behaviour I'd
like to see.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhjmZgACgkQvGr7W6HudhyJ0gCeNw5Oca4yt3KW4V4YzUk7n1by
rUEAn2EZxexKiFPV7kfscOpQlSQAGdiY
=dssM
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
