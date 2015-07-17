From: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH] fetch: add configuration for making --all default
Date: Fri, 17 Jul 2015 15:31:39 +0200
Message-ID: <1437139899-6210-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 17 15:31:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG5jz-0005d1-Ue
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 15:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758016AbbGQNbs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jul 2015 09:31:48 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:33817 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758003AbbGQNbq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 09:31:46 -0400
Received: by lagx9 with SMTP id x9so61131174lag.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 06:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=4pQR1XChnoY4UlcXzfGpn/LMT6G1g/T6FY5whVaON2Y=;
        b=hIkL9n3H5JeFjgn8SQHBdTIh1DRWNcBBMr04RspqfUBVuUMYl2Z5QCDv3UnXgZwbM8
         3MKMI1KvONBkDA0OMcOmLi/v9AJlVYj8VjM4FjvNLZs++klvMxqscS9as+b2Dcx7KXcI
         nG+UxktL5Jf9B8b+ZF5qrVLS34ANS/OTkacGUDzy6yXvGoniBGiksHO4iPHag7i5Si7t
         wPxEMEyy/yqBV4A0BvA9G2Um6wiSOSZT2xoJQH/0P5lwnpwGTLFEuiOaa8eBicm/Fcoe
         Lrg3ZcO7F3P+mgpoVgbcJq8+y6CSr8QtoIT7GcmgnF6TO9erCHFpI0ULFoFDriMUJkMU
         YZ8g==
X-Received: by 10.112.141.8 with SMTP id rk8mr14257012lbb.87.1437139904368;
        Fri, 17 Jul 2015 06:31:44 -0700 (PDT)
Received: from bigge.localdomain (80.156.189.109.customer.cdi.no. [109.189.156.80])
        by smtp.gmail.com with ESMTPSA id oq2sm2814806lbb.34.2015.07.17.06.31.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 06:31:43 -0700 (PDT)
X-Mailer: git-send-email 2.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274071>

=46etching from all remotes by default is useful if you're working on a
repo with few and/or fast remotes. It also lets you fetch from origin
even if the current branch's upstream is elsewhere without specifying i=
t
explicitly.

Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
---
This is scratching a itch I have. Most of the time I just want to fetch
everything, wherever it may be, and fetch's behavour of using the curre=
nt
upstream's remote sometimes doesn't read my mind as well as I'd like it=
 to.
It's not particularly useful. But more "destructive" behaviours (--prun=
e) can
be made default, so think this could be as well.

 Documentation/config.txt        |  5 +++++
 Documentation/fetch-options.txt |  4 +++-
 Documentation/git-fetch.txt     |  3 ++-
 builtin/fetch.c                 | 21 ++++++++++++++++-----
 t/t5514-fetch-multiple.sh       | 23 +++++++++++++++++++++++
 5 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3e37b93..c40654f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1170,6 +1170,11 @@ fetch.prune::
 	If true, fetch will automatically behave as if the `--prune`
 	option was given on the command line.  See also `remote.<name>.prune`=
=2E
=20
+fetch.all::
+	If true, fetch will automatically behave as if the `--all`
+	option was given on the command line uness a remote was given. The
+	default is false.
+
 format.attach::
 	Enable multipart/mixed attachments as the default for
 	'format-patch'.  The value can also be a double quoted string
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index 45583d8..aa95a30 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -1,5 +1,7 @@
 --all::
-	Fetch all remotes.
+	Fetch all remotes. This can be configured to be the default behaviour
+	when no remotes are given explicitly. See the `fetch.all` configurati=
on
+	variable in linkgit:git-config[1].
=20
 -a::
 --append::
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index e62d9a0..584f3fb 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -36,7 +36,8 @@ there is a remotes.<group> entry in the configuration=
 file.
 (See linkgit:git-config[1]).
=20
 When no remote is specified, by default the `origin` remote will be us=
ed,
-unless there's an upstream branch configured for the current branch.
+unless there's an upstream branch configured for the current branch, o=
r the
+`fetch.all` configuration variable is set to true.
=20
 The names of refs that are fetched, together with the object names
 they point at, are written to `.git/FETCH_HEAD`.  This information
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8d5b2db..715ea82 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -30,10 +30,12 @@ enum {
 };
=20
 static int fetch_prune_config =3D -1; /* unspecified */
+static int fetch_all_config =3D -1; /* unspecified */
 static int prune =3D -1; /* unspecified */
+static int all =3D -1; /* unspecified */
 #define PRUNE_BY_DEFAULT 0 /* do we prune by default? */
=20
-static int all, append, dry_run, force, keep, multiple, update_head_ok=
, verbosity;
+static int append, dry_run, force, keep, multiple, update_head_ok, ver=
bosity;
 static int progress =3D -1, recurse_submodules =3D RECURSE_SUBMODULES_=
DEFAULT;
 static int tags =3D TAGS_DEFAULT, unshallow, update_shallow;
 static const char *depth;
@@ -67,6 +69,10 @@ static int git_fetch_config(const char *k, const cha=
r *v, void *cb)
 		fetch_prune_config =3D git_config_bool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "fetch.all")) {
+		fetch_all_config =3D git_config_bool(k, v);
+		return 0;
+	}
 	return git_default_config(k, v, cb);
 }
=20
@@ -1168,7 +1174,7 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
 		git_config(submodule_config, NULL);
 	}
=20
-	if (all) {
+	if (all =3D=3D 1) {
 		if (argc =3D=3D 1)
 			die(_("fetch --all does not take a repository argument"));
 		else if (argc > 1)
@@ -1176,9 +1182,14 @@ int cmd_fetch(int argc, const char **argv, const=
 char *prefix)
 		(void) for_each_remote(get_one_remote_for_fetch, &list);
 		result =3D fetch_multiple(&list);
 	} else if (argc =3D=3D 0) {
-		/* No arguments -- use default remote */
-		remote =3D remote_get(NULL);
-		result =3D fetch_one(remote, argc, argv);
+		if (fetch_all_config && all !=3D 0) {
+			(void) for_each_remote(get_one_remote_for_fetch, &list);
+			result =3D fetch_multiple(&list);
+		} else {
+			/* No arguments and no --all -- use default remote */
+			remote =3D remote_get(NULL);
+			result =3D fetch_one(remote, argc, argv);
+		}
 	} else if (multiple) {
 		/* All arguments are assumed to be remotes or groups */
 		for (i =3D 0; i < argc; i++)
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index 4b4b667..4e773ee 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -55,6 +55,18 @@ test_expect_success 'git fetch --all' '
 	 test_cmp expect output)
 '
=20
+test_expect_success 'git fetch (fetch.all =3D true)' '
+	(git clone one test9 &&
+	 cd test9 &&
+	 git config fetch.all true &&
+	 git remote add one ../one &&
+	 git remote add two ../two &&
+	 git remote add three ../three &&
+	 git fetch &&
+	 git branch -r > output &&
+	 test_cmp ../test/expect output)
+'
+
 test_expect_success 'git fetch --all should continue if a remote has e=
rrors' '
 	(git clone one test2 &&
 	 cd test2 &&
@@ -91,6 +103,17 @@ test_expect_success 'git fetch --multiple (but only=
 one remote)' '
 	 test_cmp ../expect output)
 '
=20
+test_expect_success 'git fetch one (fetch.all =3D true)' '
+	(cd test3 &&
+	 git config fetch.all true &&
+	 git fetch three &&
+	 git branch -r > output &&
+	 test_cmp ../expect output &&
+	 git fetch --no-all &&
+	 git branch -r > output &&
+	 test_cmp ../expect output)
+'
+
 cat > expect << EOF
   one/master
   one/side
--=20
2.2.0
