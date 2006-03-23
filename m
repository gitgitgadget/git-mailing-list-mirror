From: Radoslaw Szkodzinski <astralstorm@o2.pl>
Subject: Re: Question about possible git races
Date: Thu, 23 Mar 2006 02:22:34 +0100
Message-ID: <200603230222.38978.astralstorm@o2.pl>
References: <200603201724.12442.astralstorm@o2.pl> <7vacbi6m91.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4073121.8Wnq2WHVvF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 02:26:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMEas-0005PR-NB
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 02:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWCWB0Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 20:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWCWB0Y
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 20:26:24 -0500
Received: from mx2.go2.pl ([193.17.41.42]:51933 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S932232AbWCWB0W (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Mar 2006 20:26:22 -0500
Received: from zen.localdomain (host-81-190-201-167.gorzow.mm.pl [81.190.201.167])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by poczta.o2.pl (Postfix) with ESMTP id 2EF40748084;
	Thu, 23 Mar 2006 02:26:15 +0100 (CET)
Received: from zen.localdomain ([192.168.0.1])
	by zen.localdomain with esmtpa (Exim 4.60)
	(envelope-from <astralstorm@o2.pl>)
	id 1FMEXU-00029h-CE; Thu, 23 Mar 2006 02:23:00 +0100
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.1
In-Reply-To: <7vacbi6m91.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17839>

--nextPart4073121.8Wnq2WHVvF
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 23 March 2006 01:24, Junio C Hamano wrote yet:
> Radoslaw Szkodzinski <astralstorm@o2.pl> writes:
> > - push vs pull
> >
> > - push vs push
> >
> > - fetch vs fetch
>
> About push vs push, with "really bare git", I take it that you
> mean two send-pack from remote sites running two receive-pack
> simultaneously.
>
> There is an explicit race avoidance between the receive-pack
> processes.  When a ref (either branch head or a tag) is updated,
> it does:
>
>  - read the current value from the ref.
>  - do its work.
>  - lock to prevent others to create the temporary file for
>    updating the ref.


>  - create the temporary file for the ref and write the new value.
>  - check if the ref's value has not changed from what it
>    initially read;
>  - rename the temporary file to the ref to unlock.
>
> Read receive-pack.c::update() for exact details if you are
> interested.

So there is locking I've missed while reading through the source.
Guess all the coffee doesn't help.

There is a lock, so the other git-receive-pack for given ref will fail.=20
Does that also work for git-local-fetch with -l option?

Looks good though that I can fetch to another ref.

>
> > I'm meaning really bare git there, w/o bash+perl scripts.
>
> The question does not make any sense for other cases, because
> branch update by fetch and pull are all scripts based.

I should have known better than to use vague words.
=46or me fetch =3D git-*-fetch. Which in turn calls git-receive-pack.

Thank you for the precise answer.

=2D-=20
GPG Key id:  0xD1F10BA2
=46ingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm

--nextPart4073121.8Wnq2WHVvF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEIfhelUMEU9HxC6IRAuQAAKCuBpLaGF5vagL9x7/236yED3BOtQCfba+O
C65s83VvFaEnQ593vgfEUWE=
=sECT
-----END PGP SIGNATURE-----

--nextPart4073121.8Wnq2WHVvF--
