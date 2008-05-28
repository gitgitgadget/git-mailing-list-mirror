From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: [PATCH] git-init: treat option `--bare'
Date: Wed, 28 May 2008 19:53:57 +0100
Message-ID: <20080528185357.GB4431@bit.office.eurotux.com>
References: <20080519175313.GA17305@bit.office.eurotux.com> <20080520194850.GB19226@bit.office.eurotux.com> <7vy761sgks.fsf@gitster.siamese.dyndns.org> <20080528185103.GA4431@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 20:55:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1QnZ-0004LI-Dn
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 20:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbYE1SyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 14:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752484AbYE1SyF
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 14:54:05 -0400
Received: from os.eurotux.com ([216.75.63.6]:42497 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752457AbYE1SyE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 14:54:04 -0400
Received: (qmail 9591 invoked from network); 28 May 2008 18:54:01 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 28 May 2008 18:54:01 -0000
Content-Disposition: inline
In-Reply-To: <20080528185103.GA4431@bit.office.eurotux.com>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83128>


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Currently, passing the `--bare' option to git-init proper doesn't work, and
gives no indication that `git --bare init' would work instead:

$ git init --bare
usage: git-init [-q | --quiet] [--template=3D<template-directory>] [--share=
d]

Treat the `--bare' option internally in builtin-init-db.

Also, fix the usage string, synchronising it with the synopsis in the
documentation.

Signed-off-by: Luciano Rocha <strange@nsk.pt>
---
 Documentation/git-init.txt |    7 ++++++-
 builtin-init-db.c          |    9 +++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

Parsing the --bare option correctly (AFAICS) was easier than I expected.

Sorry, forgot the Signed-off-by line.

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index b17ae84..b48c312 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -8,7 +8,7 @@ git-init - Create an empty git repository or reinitialize a=
n existing one
=20
 SYNOPSIS
 --------
-'git-init' [-q | --quiet] [--template=3D<template_directory>] [--shared[=
=3D<permissions>]]
+'git-init' [-q | --quiet] [--bare] [--template=3D<template_directory>] [--=
shared[=3D<permissions>]]
=20
=20
 OPTIONS
@@ -20,6 +20,11 @@ OPTIONS
=20
 Only print error and warning messages, all other output will be suppressed.
=20
+--bare::
+
+Create a bare repository. If GIT_DIR environment is not set, it is set to =
the
+current working directory.
+
 --template=3D<template_directory>::
=20
 Provide the directory from which templates will be used.  The default temp=
late
diff --git a/builtin-init-db.c b/builtin-init-db.c
index d8bdf92..e23b843 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -364,7 +364,7 @@ static int guess_repository_type(const char *git_dir)
 }
=20
 static const char init_db_usage[] =3D
-"git-init [-q | --quiet] [--template=3D<template-directory>] [--shared]";
+"git-init [-q | --quiet] [--bare] [--template=3D<template-directory>] [--s=
hared[=3D<permissions>]]";
=20
 /*
  * If you want to, you can share the DB area with any number of branches.
@@ -383,7 +383,12 @@ int cmd_init_db(int argc, const char **argv, const cha=
r *prefix)
 		const char *arg =3D argv[1];
 		if (!prefixcmp(arg, "--template=3D"))
 			template_dir =3D arg+11;
-		else if (!strcmp(arg, "--shared"))
+		else if (!strcmp(arg, "--bare")) {
+			static char git_dir[PATH_MAX+1];
+			is_bare_repository_cfg =3D 1;
+			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir,
+						sizeof(git_dir)), 0);
+		} else if (!strcmp(arg, "--shared"))
 			shared_repository =3D PERM_GROUP;
 		else if (!prefixcmp(arg, "--shared=3D"))
 			shared_repository =3D git_config_perm("arg", arg+9);
--=20
1.5.6.rc0.41.gabae7.dirty


--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkg9qkUACgkQinSul6a7oB98jgCfeOBC+c1WIcmZcKvMOQ0CrztP
lSsAn0HzcbqNOPjiJcuQGx0C4ldeAYFC
=cqIN
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
