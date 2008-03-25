From: SZEDER =?iso-8859-2?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] shortlog: initialize nongit variable
Date: Tue, 25 Mar 2008 22:06:26 +0100
Message-ID: <20080325210600.GE6506@neumann>
References: <1206456377-2735-1-git-send-email-szeder@ira.uka.de> <fcaeb9bf0803250839p721e1870l8fbc8715b3c6e7cb@mail.gmail.com> <20080325160356.GC6506@neumann> <2c6b72b30803251258j313e0d94qe290b8b7c7b377f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 22:07:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeGMm-0000TJ-RF
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 22:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbYCYVGw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2008 17:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753012AbYCYVGw
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 17:06:52 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:51935 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbYCYVGv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2008 17:06:51 -0400
Received: from elysium (p5B13323B.dip0.t-ipconnect.de [91.19.50.59])
	by mrelayeu.kundenserver.de (node=mrelayeu0) with ESMTP (Nemesis)
	id 0MKwh2-1JeGLi0kMT-0008Eu; Tue, 25 Mar 2008 22:06:26 +0100
Received: from fzi.de (neumann.wired [192.168.1.2])
	by elysium (Postfix) with SMTP id 1FC4A1241C8;
	Tue, 25 Mar 2008 22:06:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <2c6b72b30803251258j313e0d94qe290b8b7c7b377f0@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Provags-ID: V01U2FsdGVkX1/Bz1CirSvya6Q4RLtfzcFzZNqQfZW/K7dte5/
 7wfXDOwHdXUtd8S38nBBpZRdrzSyoM55hWa0Bfvkld+JU2wnQO
 5sbfLGs6AH2n79imAr/hQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78222>

On Tue, Mar 25, 2008 at 08:58:50PM +0100, Jonas Fonseca wrote:
> 2008/3/25 SZEDER G=E1bor <szeder@ira.uka.de>:
> >   builtin-bundle.c     |    2 +-
> >   builtin-config.c     |    2 +-
> >   builtin-diff-files.c |    2 +-
> >   builtin-ls-remote.c  |    2 +-
> >   git.c                |    2 +-
> >   setup.c              |    8 ++++++++
> >   6 files changed, 13 insertions(+), 5 deletions(-)
>=20
> git grep reveals that builtin-{apply,diff}.c,
Right, I have overseen them.  Updated patch appended.

> help.c and var.c also belongs on this list.
They don't initialize (and use) their nongit variable.

Regards,
G=E1bor


Always set *nongit_ok in setup_git_directory_gently()

setup_git_directory_gently() only modified the value of its *nongit_ok
argument if we were not in a git repository.  Now it will always set it
to 0 when we are inside a repository.

Also remove now unnecessary initializations in the callers of this
function.

Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
---
 builtin-apply.c      |    2 +-
 builtin-bundle.c     |    2 +-
 builtin-config.c     |    2 +-
 builtin-diff-files.c |    2 +-
 builtin-diff.c       |    2 +-
 builtin-ls-remote.c  |    2 +-
 git.c                |    2 +-
 setup.c              |    8 ++++++++
 8 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index a3f075d..b5f78ac 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2994,7 +2994,7 @@ int cmd_apply(int argc, const char **argv, const =
char *unused_prefix)
 	int read_stdin =3D 1;
 	int inaccurate_eof =3D 0;
 	int errs =3D 0;
-	int is_not_gitdir =3D 0;
+	int is_not_gitdir;
=20
 	const char *whitespace_option =3D NULL;
=20
diff --git a/builtin-bundle.c b/builtin-bundle.c
index 9f38e21..ac476e7 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -14,7 +14,7 @@ static const char *bundle_usage=3D"git-bundle (create=
 <bundle> <git-rev-list args>
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
 	struct bundle_header header;
-	int nongit =3D 0;
+	int nongit;
 	const char *cmd, *bundle_file;
 	int bundle_fd =3D -1;
 	char buffer[PATH_MAX];
diff --git a/builtin-config.c b/builtin-config.c
index 2b9a426..c34bc8b 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -264,7 +264,7 @@ static int get_colorbool(int argc, const char **arg=
v)
=20
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
-	int nongit =3D 0;
+	int nongit;
 	char* value;
 	const char *file =3D setup_git_directory_gently(&nongit);
=20
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 4abe3c2..e2306c1 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -16,7 +16,7 @@ COMMON_DIFF_OPTIONS_HELP;
 int cmd_diff_files(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
-	int nongit =3D 0;
+	int nongit;
 	int result;
=20
 	prefix =3D setup_git_directory_gently(&nongit);
diff --git a/builtin-diff.c b/builtin-diff.c
index 444ff2f..7c2a841 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -210,7 +210,7 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 	int ents =3D 0, blobs =3D 0, paths =3D 0;
 	const char *path =3D NULL;
 	struct blobinfo blob[2];
-	int nongit =3D 0;
+	int nongit;
 	int result =3D 0;
=20
 	/*
diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
index 8907a89..06ab8da 100644
--- a/builtin-ls-remote.c
+++ b/builtin-ls-remote.c
@@ -31,7 +31,7 @@ int cmd_ls_remote(int argc, const char **argv, const =
char *prefix)
 {
 	int i;
 	const char *dest =3D NULL;
-	int nongit =3D 0;
+	int nongit;
 	unsigned flags =3D 0;
 	const char *uploadpack =3D NULL;
 	const char **pattern =3D NULL;
diff --git a/git.c b/git.c
index 13de801..70458af 100644
--- a/git.c
+++ b/git.c
@@ -142,7 +142,7 @@ static int split_cmdline(char *cmdline, const char =
***argv)
=20
 static int handle_alias(int *argcp, const char ***argv)
 {
-	int nongit =3D 0, envchanged =3D 0, ret =3D 0, saved_errno =3D errno;
+	int nongit, envchanged =3D 0, ret =3D 0, saved_errno =3D errno;
 	const char *subdir;
 	int count, option_count;
 	const char** new_argv;
diff --git a/setup.c b/setup.c
index 41e298b..3d2d958 100644
--- a/setup.c
+++ b/setup.c
@@ -326,6 +326,14 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 	int len, offset;
=20
 	/*
+	 * Let's assume that we are in a git repository.
+	 * If it turns out later that we are somewhere else, the value will b=
e
+	 * updated accordingly.
+	 */
+	if (nongit_ok)
+		*nongit_ok =3D 0;
+
+	/*
 	 * If GIT_DIR is set explicitly, we're not going
 	 * to do any discovery, but we still do repository
 	 * validation.
--=20
1.5.5.rc1.7.g249d1
