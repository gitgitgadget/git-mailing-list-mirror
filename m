From: Miklos Vajna <vmiklos@frugalware.org>
Subject: git-am strips newlines in some commit messages?
Date: Wed, 13 Feb 2008 09:32:00 +0100
Message-ID: <20080213083200.GP25954@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E9b8Qrao4pLwl/2H"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 09:32:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPD2z-0000IK-Py
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 09:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756235AbYBMIcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 03:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756110AbYBMIcR
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 03:32:17 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:48834 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754546AbYBMIcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 03:32:16 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1JPD2D-0006wp-Da
	from <vmiklos@frugalware.org>
	for <git@vger.kernel.org>; Wed, 13 Feb 2008 09:32:14 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 31C87119051B; Wed, 13 Feb 2008 09:32:00 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0024]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73755>


--E9b8Qrao4pLwl/2H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello,

it seems that in case the second line of a commit message is not empty,
then git am strips newlines from the commit message. is this expected?

vmiklos@gaia:~/git/t$ git init
Initialized empty Git repository in .git/
vmiklos@gaia:~/git/t$ echo foo > foo.c
vmiklos@gaia:~/git/t$ git add foo.c
vmiklos@gaia:~/git/t$ git commit -m foo
Created initial commit d0d61f2: foo
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 foo.c
vmiklos@gaia:~/git/t$ echo bar >> foo.c
vmiklos@gaia:~/git/t$ git commit -a
< here is insert "-foo\n-bar\n-baz" >
Created commit a928423: - foo
 1 files changed, 1 insertions(+), 0 deletions(-)
vmiklos@gaia:~/git/t$ git format-patch HEAD^
0001-foo.patch
vmiklos@gaia:~/git/t$ git reset --hard HEAD^
HEAD is now at d0d61f2... foo
vmiklos@gaia:~/git/t$ cat 0001-foo.patch |git am
Applying - foo - bar - baz
vmiklos@gaia:~/git/t$ head -n 6 0001-foo.patch
=46rom a928423a563201d95cf2e53c5050dbdfb415708e Mon Sep 17 00:00:00 2001
=46rom: Miklos Vajna <vmiklos@frugalware.org>
Date: Wed, 13 Feb 2008 09:23:49 +0100
Subject: [PATCH] - foo
 - bar
 - baz
vmiklos@gaia:~/git/t$ git --no-pager log -1
commit 8af2dc6b5df430e004d6887c3e05d5295a16c947
Author: Miklos Vajna <vmiklos@frugalware.org>
Date:   Wed Feb 13 09:23:49 2008 +0100

    - foo - bar - baz

of maybe the solution would be that git format-patch inserts two
newlines after the subject - even if the second line would not empty
originally.

thanks,
- VMiklos

--E9b8Qrao4pLwl/2H
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHsqsAe81tAgORUJYRAkttAJ9Kt19x79J7UYEiYp0yUUBbMiGZTQCdEI0L
ml/AaxOrmYE7TytN9AYgxu8=
=A6Pv
-----END PGP SIGNATURE-----

--E9b8Qrao4pLwl/2H--
