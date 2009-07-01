From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: run_hook: why special check for uncaught signal?
Date: Wed, 1 Jul 2009 11:57:51 +0200
Message-ID: <20090701095751.GE10895@genesis.frugalware.org>
References: <200906302231.45157.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iK1l7ZgcrJDTNPEn"
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jul 01 11:58:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLwZp-0005sr-Bo
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 11:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbZGAJ5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 05:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754110AbZGAJ5u
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 05:57:50 -0400
Received: from virgo.iok.hu ([212.40.97.103]:53229 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753263AbZGAJ5u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 05:57:50 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id D88D6580AD;
	Wed,  1 Jul 2009 11:57:51 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id BFA69448DC;
	Wed,  1 Jul 2009 11:57:51 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 9AFB7634001; Wed,  1 Jul 2009 11:57:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200906302231.45157.j6t@kdbg.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122578>


--iK1l7ZgcrJDTNPEn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2009 at 10:31:45PM +0200, Johannes Sixt <j6t@kdbg.org> wrot=
e:
> Function run_hook (in run-command.c) has this check:
>=20
> 	ret =3D finish_command(&hook);
> 	if (ret =3D=3D -ERR_RUN_COMMAND_WAITPID_SIGNAL)
> 		warning("%s exited due to uncaught signal", argv[0]);
> 	return ret;
>=20
> The lines were moved to this location by ae98a008 (Move run_hook() from=
=20
> builtin-commit.c into run-command.c (libgit), 2009-01-16). Before this=20
> commit, the check existed in builtin-gc.c. It was introduced by bde30540=
=20
> (git-gc --auto: add pre-auto-gc hook, 2008-04-09).
>=20
> Why is this check necessary?

I do not really remember, but I think I wanted to give some error
messages for each return code, and somehow left out
ERR_RUN_COMMAND_WAITPID, ERR_RUN_COMMAND_WAITPID_WRONG_PID and
ERR_RUN_COMMAND_WAITPID_NOEXIT.

> I'm asking because I'm working on a modification that would remove=20
> ERR_RUN_COMMAND_WAITPID_SIGNAL.

That's fine, I think ideally run_hook() should call warning() for each
case which may be returned. Such functionality is already available in
builtin-receive-pack.c::hook_status() and unpack(), probably it would
make sense to introduce some run_command_strerror() to avoid code
duplication.

Sadly I don't have time to implement this in the near future.

--iK1l7ZgcrJDTNPEn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpLMx8ACgkQe81tAgORUJah9ACfeXy9MJPb40R3xhNvSFwLKPEe
siEAnRKgK4Ijk14ApBzIk/uEQLtw078z
=Va6L
-----END PGP SIGNATURE-----

--iK1l7ZgcrJDTNPEn--
