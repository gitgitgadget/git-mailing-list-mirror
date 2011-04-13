From: martin f krafft <madduck@madduck.net>
Subject: git submodule add requires remote
Date: Wed, 13 Apr 2011 08:20:23 +0200
Message-ID: <20110413062023.GA29119@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Cc: Lars Hjemli <hjemli@gmail.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 13 08:30:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9tas-0003eS-Sc
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 08:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994Ab1DMGaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 02:30:21 -0400
Received: from seamus.madduck.net ([213.203.238.82]:36125 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126Ab1DMGaU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 02:30:20 -0400
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Apr 2011 02:30:20 EDT
Received: from fishbowl.rw.madduck.net (84-74-106-21.dclient.hispeed.ch [84.74.106.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id CA9BE43A4CB;
	Wed, 13 Apr 2011 08:20:24 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id D28B42080E; Wed, 13 Apr 2011 08:20:23 +0200 (CEST)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux wheezy/sid kernel 2.6.38-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.97 at seamus
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171434>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear gitsters, dear Lars,

while testing some workflows with submodules, we ran into the
problem that adding a submodule seems to require a remote "origin"
to be defined, even though that is not really necessary:

  ### subproj setup:

  % GIT_DIR=3Dsubproj.git git --bare init
  Initialized empty Git repository in /tmp/madduck/cdt.ciwkf2/subproj.git/
  % mkdir subproj && cd subproj
  % git init && git remote add origin ../subproj.git
  Initialized empty Git repository in /tmp/madduck/cdt.ciwkf2/subproj/.git/
  % touch a && git add a && git commit -minitial && git push origin master
  [master (root-commit) 7f6f6e9] initial
  0 files changed, 0 insertions(+), 0 deletions(-)
  create mode 100644 a
  Counting objects: 3, done.
  Writing objects: 100% (3/3), 201 bytes, done.
  Total 3 (delta 0), reused 0 (delta 0)
  Unpacking objects: 100% (3/3), done.
  To ../subproj.git
  * [new branch]      master -> master

  ### test project setup:

  % mkdir ../proj && cd ../proj
  % git init
  Initialized empty Git repository in /tmp/madduck/cdt.ciwkf2/proj/.git/
  % touch a && git add a && git commit -minitial
  [master (root-commit) aa15bae] initial
  0 files changed, 0 insertions(+), 0 deletions(-)
  create mode 100644 a

  ### adding submodule:

  % git submodule add ../subproj.git
  remote (origin) does not have a url defined in .git/config

The requirements stems from the resolve_relative_url() function in
git-submodule, which assumes that a relative submodule URL is
relative to the superproject's default remote URL. This might make
sense for './' URLs, but not really for '../'. Plus, it breaks the
normal assumption that Git accepts relative (filesystem) paths as
URLs (works for git-clone etc.).

Before I work out a patch for this, I would be curious to hear your
thoughts.

Thanks,

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
fighting for peace is like screwing for virginity.
                                     -- the irish times, washington dc
=20
spamtraps: madduck.bogus@madduck.net

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQLvBAEBCgDZBQJNpUCnwBEaaHR0cDovL21hcnRpbi1rcmFmZnQubmV0L2dwZy9z
aWctcG9saWN5LzU1Yzk4ODJkOTk5YmJjYzQvMjAxMTAxMjQxMTI1P3NoYTUxMnN1
bT0xY2FkOTZmZDI3ZDMyMzNmNTNlMjI4NDk1MzM2NDgxMDdlNWVlOGQ1YmU2NTUy
NTFkNzRjOGYxYzVjM2JjNDJmMjMwNGZhNTE1MTUwZjdiZDRkZDA1ZTk4MTk5MjRm
MDQ5NTEzZWU5OTYyY2E3MTcwOWY4MWQ5NDUxNTg1MmJkOAAKCRBVyYgtmZu8xF0F
D/sF9Zvwve3GZL9xQWeyr/u5JPLFRBkjFn9FEO9QNLwWyILuNF6mMKAIcBQsv3p1
kZwZoKpl24nLMxubWg4sCpq6rohi0a8VF0H+Gz10v9hsV1F2hRwbIN1B956qIcMy
ozGZHQHyvFVCuUDBcC7mVfoGm+qDgmePhaTnX3Jl0dHvs1+Htyz1J+Tz6pL3dn2k
QR1ytcn9renD7r/ts+4GKnJ9Oyeipw8OztDkJ1KX9IqOmtktzQViWRzxPuQx+MSu
DhYH0Htxon0gyN++C0tHmAOLav8WwnFNh53MJyRABXLw3aMHAzS+/H8wPXIFcpr9
gv3xXaZBpNty9sVKbO4MMUW/pgwceh85YOPUUk61Cr3ERYtmAk9KhFrt7cCsN3Q4
7GBO/B5w5z2DuANHo1RqZe13ToaePu8ToWeFL0sFu95/0/0yqdDIAurbeoGqQSaM
Pn7xE13NrTa7Uo/yDKyi9HDv1R+JF9kCv9+xjsg/FEBY7PPsDKhkvCgkEFdY9Q5u
pZRDaHjM6BbN3Mm4Q6nCDkgLeWaPjQK5w8Ak8E8VoK4Vko1QSP01gjK2jDvgNotS
6G2jwCTzL7+UjUDH3Mki3M9ro4RTE8ZyOPown23jzfkf8du91SA0oxhQk/gHGVxD
bO9oIS6MysWZb4ZuwyHBnCd2TRfjsXxYUXTfYpeBkNKNAw==
=GqMM
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
