From: Caleb Thompson <cjaysson@gmail.com>
Subject: [PATCH v2] commit: support commit.verbose and --no-verbose
Date: Sun, 25 May 2014 01:24:27 -0500
Message-ID: <20140525062427.GA94219@sirius.att.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Cc: James P Howard II <jh@jameshoward.us>, Jeff King <peff@peff.net>,
	Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 25 08:24:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WoRrI-0003DO-0v
	for gcvg-git-2@plane.gmane.org; Sun, 25 May 2014 08:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbaEYGYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2014 02:24:32 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:52393 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbaEYGYb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2014 02:24:31 -0400
Received: by mail-ie0-f179.google.com with SMTP id rd18so6545821iec.38
        for <git@vger.kernel.org>; Sat, 24 May 2014 23:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=Lz10rxzVG6vPjO7o8wxP9/9i1JnfJ4SCnsg3hJK1a+8=;
        b=Z4fvklPSCf64rzwEZ51zizMBAz3IkPiXlHip84aqzxZhJs5Fqtgw7PeHcoO0HdBnzO
         iYzYW1tMCxT03Wzve1fbhOd659IskwNBzf6ZfaupId8XJqynifnMd4Lroa+RV10NN1T0
         +qPogBTW3toWy/zpTMLS33vpm6cXo6ItBu5wE0AD++Hur/BiysfWOV2MnoNhMl7Bb7CW
         BJcbnp7lhdqYY4F7N+jc0SDV3Nx+kYL+v+lnjE1igDk53G8LUtz48NVog9ThxcVjAyZ9
         wlAi5y615OIvp+pE1gL9mtywv0CSfg0lxzKatiKXG8xFf4qxKNqa88dACluUAjRLVcYz
         Nxhw==
X-Received: by 10.42.119.138 with SMTP id b10mr15180162icr.31.1400999070681;
        Sat, 24 May 2014 23:24:30 -0700 (PDT)
Received: from localhost ([2602:306:bd82:c710:3d56:583b:4540:9e06])
        by mx.google.com with ESMTPSA id hy3sm6382340igb.1.2014.05.24.23.24.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 24 May 2014 23:24:29 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250079>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Incorporated changes from Duy Nguyen and Jeremiah Mahler.

Jeremiah, I didn't make the changes about `<<-EOF` or `test_expect_success`
because I'm guessing that keeping the local style of the code intact is more
important than using those. Do you think it makes sense to refactor the res=
t of
the test file (t/t7507-commit-verbose.sh) to use those? I could also change=
 the
other `git config` calls to use `test_config`.

Duy, you were right about `-V`. Do you know of a simple way to add that
shortened flag? `OPT_BOOL('v', "verbose", ...)` gives me `-v`, `--verbose`,=
 and
`--no-verbose`, but no `-V` as a shortened form of `--no-verbose`.

commit 1a49356b87c9028e68e731f34790c11a3075f736
Author: Caleb Thompson <caleb@calebthompson.io>
Date:   Fri May 23 11:47:44 2014 -0500

    commit: support commit.verbose and --no-verbose

    Add a new configuration variable commit.verbose to implicitly pass
    `--verbose` to `git-commit`. Add `--no-verbose` to commit to negate that
    setting.

    Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
    Reviewed-by: Duy Nguyen <pclouds@gmail.com>
    Reviewed-by: Jeremiah Mahler <jmmahler@gmail.com>

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1932e9b..a245928 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1009,6 +1009,11 @@ commit.template::
 	"`~/`" is expanded to the value of `$HOME` and "`~user/`" to the
 	specified user's home directory.

+commit.verbose::
+	A boolean to enable/disable inclusion of diff information in the
+	commit message template when using an editor to prepare the commit
+	message.  Defaults to false.
+
 credential.helper::
 	Specify an external helper to be called when a username or
 	password credential is needed; the helper may consult external
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0bbc8f5..d7b50e2 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -282,7 +282,13 @@ configuration variable documented in linkgit:git-confi=
g[1].
 	Show unified diff between the HEAD commit and what
 	would be committed at the bottom of the commit message
 	template.  Note that this diff output doesn't have its
-	lines prefixed with '#'.
+	lines prefixed with '#'.  The `commit.verbose` configuration
+	variable can be set to true to implicitly send this option.
+
+--no-verbose::
+	Do not show the unified diff  at the bottom of the commit message
+	template.  This is the default behavior, but can be used to override
+	the`commit.verbose` configuration variable.

 -q::
 --quiet::
diff --git a/builtin/commit.c b/builtin/commit.c
index 9cfef6c..7978d7f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1417,6 +1417,10 @@ static int git_commit_config(const char *k, const ch=
ar *v, void *cb)
 		sign_commit =3D git_config_bool(k, v) ? "" : NULL;
 		return 0;
 	}
+	if (!strcmp(k, "commit.verbose")) {
+		verbose =3D git_config_bool(k, v);
+		return 0;
+	}

 	status =3D git_gpg_config(k, v, NULL);
 	if (status)
@@ -1484,7 +1488,7 @@ int cmd_commit(int argc, const char **argv, const cha=
r *prefix)
 	static struct wt_status s;
 	static struct option builtin_commit_options[] =3D {
 		OPT__QUIET(&quiet, N_("suppress summary after successful commit")),
-		OPT__VERBOSE(&verbose, N_("show diff in commit message template")),
+		OPT_BOOL('v', "verbose", &verbose, N_("show diff in commit message templ=
ate")),
=20
 		OPT_GROUP(N_("Commit message options")),
 		OPT_FILENAME('F', "file", &logfile, N_("read message from file")),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/gi=
t-completion.bash
index 2c59a76..b8f4b94 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1976,6 +1976,7 @@ _git_config ()
 		color.ui
 		commit.status
 		commit.template
+		commit.verbose
 		core.abbrev
 		core.askpass
 		core.attributesfile
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 2ddf28c..bea5d88 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -10,6 +10,12 @@ EOF
 chmod +x check-for-diff
 test_set_editor "$PWD/check-for-diff"
=20
+cat >check-for-no-diff <<EOF
+#!$SHELL_PATH
+exec grep -v '^diff --git' "\$1"
+EOF
+chmod +x check-for-no-diff
+
 cat >message <<'EOF'
 subject

@@ -48,6 +54,21 @@ test_expect_success 'verbose diff is stripped out (mnemo=
nicprefix)' '
 	check_message message
 '

+test_expect_success 'commit shows verbose diff with set commit.verbose' '
+	echo morecontent >file &&
+	git add file &&
+	test_config commit.verbose true &&
+	check_message message
+'
+
+test_expect_success 'commit does not show verbose diff with --no-verbose' '
+	echo morecontent >file &&
+	git add file &&
+	test_config commit.verbose true &&
+	test_set_editor "$PWD/check-for-no-diff" &&
+	git commit --amend --no-verbose
+'
+
 cat >diff <<'EOF'
 This is an example commit message that contains a diff.

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJTgYybAAoJEBYhrcKgrOcKD64H/iXx3H+emPiXn29i6hbVWEFZ
ZxhN03y8Ph17HOk2Voa3n5a+c85ef9+iaTqeSzLBAccJLCBLM/om/deuwwePZ1B+
cg00Xq7PKPqtZevVicjQW2iWUUFMfWZAnZkwGOfOPllEkmevchZO45dtBYzejdqb
5J8APtFnKr/bnnI+m8eseu0XYzKYungqwPZv2HSVgBHgDTRdxhkhOP8OnGeSl9Ka
fS0WBkRrG8ijx0iue7ZllegFZmkLRyZnF+MQ+VfFo/xaYnTq7l2uc6Y+jjj7Ei12
mI9X0P8qaQ5wcOA004lv403pnlRvnqFbu4hK/+A5UhKWU0FQWa1mqZhUDoDwM9Y=
=fq6o
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
