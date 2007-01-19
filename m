From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
Subject: [RFC PATCH] rename --exec to --receive-pack for push and send-pack
Date: Fri, 19 Jan 2007 13:49:27 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070119124927.GA3039@cepheus>
References: <20070119124616.GA3012@cepheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 19 13:49:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7tBW-00034w-Cl
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 13:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbXASMtb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 19 Jan 2007 07:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbXASMtb
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 07:49:31 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:34996 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965110AbXASMta (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jan 2007 07:49:30 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1H7tBR-0001DZ-F6; Fri, 19 Jan 2007 13:49:29 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l0JCnRhp012752;
	Fri, 19 Jan 2007 13:49:27 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l0JCnQEp012751;
	Fri, 19 Jan 2007 13:49:26 +0100 (MET)
To: git@vger.kernel.org
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20070119124616.GA3012@cepheus>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37179>

=46or now it's just to get a more descriptive name.  Later we might upd=
ate the
push protocol to run more than one program on the other end.  Moreover =
this
matches better the corresponding config option remote.<name>. receivepa=
ck.

--exec continues to work

Signed-off-by: Uwe Kleine-K=F6nig <zeisberg@informatik.uni-freiburg.de>
---
Junio pointed out that remote.<name>.pushexec might not be appropriate,
"just in case we update the fetch/push protocol someday to run more tha=
n
one program on the other end".

In my eyes the consequence is to rename --exec to --receive-pack as is
done by this patch.

 Documentation/git-push.txt      |    7 +++++--
 Documentation/git-send-pack.txt |    7 +++++--
 builtin-push.c                  |   24 ++++++++++++++----------
 send-pack.c                     |   12 ++++++++----
 4 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 7a2e503..f8cc2b5 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -8,7 +8,7 @@ git-push - Update remote refs along with associated obj=
ects
=20
 SYNOPSIS
 --------
-'git-push' [--all] [--tags] [--exec=3D<git-receive-pack>] [--repo=3Dal=
l] [-f | --force] [-v] [<repository> <refspec>...]
+'git-push' [--all] [--tags] [--receive-pack=3D<git-receive-pack>] [--r=
epo=3Dall] [-f | --force] [-v] [<repository> <refspec>...]
=20
 DESCRIPTION
 -----------
@@ -67,12 +67,15 @@ the remote repository.
 	addition to refspecs explicitly listed on the command
 	line.
=20
-\--exec::
+\--receive-pack=3D<git-receive-pack>::
 	Path to the 'git-receive-pack' program on the remote
 	end.  Sometimes useful when pushing to a remote
 	repository over ssh, and you do not have the program in
 	a directory on the default $PATH.
=20
+\--exec=3D<git-receive-pack>::
+	Same as \--receive-pack=3D<git-receive-pack>.
+
 -f, \--force::
 	Usually, the command refuses to update a remote ref that is
 	not a descendant of the local ref used to overwrite it.
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-p=
ack.txt
index dee43a9..2f6267c 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -8,7 +8,7 @@ git-send-pack - Push objects over git protocol to anoth=
er reposiotory
=20
 SYNOPSIS
 --------
-'git-send-pack' [--all] [--force] [--exec=3D<git-receive-pack>] [--ver=
bose] [--thin] [<host>:]<directory> [<ref>...]
+'git-send-pack' [--all] [--force] [--receive-pack=3D<git-receive-pack>=
] [--verbose] [--thin] [<host>:]<directory> [<ref>...]
=20
 DESCRIPTION
 -----------
@@ -21,12 +21,15 @@ updates it from the current repository, sending nam=
ed refs.
=20
 OPTIONS
 -------
-\--exec=3D<git-receive-pack>::
+\--receive-pack=3D<git-receive-pack>::
 	Path to the 'git-receive-pack' program on the remote
 	end.  Sometimes useful when pushing to a remote
 	repository over ssh, and you do not have the program in
 	a directory on the default $PATH.
=20
+\--exec=3D<git-receive-pack>::
+	Same as \--receive-pack=3D<git-receive-pack>.
+
 \--all::
 	Instead of explicitly specifying which refs to update,
 	update all refs that locally exist.
diff --git a/builtin-push.c b/builtin-push.c
index 6b3c03b..5f4d7d3 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -8,10 +8,10 @@
=20
 #define MAX_URI (16)
=20
-static const char push_usage[] =3D "git-push [--all] [--tags] [--exec=3D=
<git-receive-pack>] [--repo=3Dall] [-f | --force] [-v] [<repository> <r=
efspec>...]";
+static const char push_usage[] =3D "git-push [--all] [--tags] [--recei=
ve-pack=3D<git-receive-pack>] [--repo=3Dall] [-f | --force] [-v] [<repo=
sitory> <refspec>...]";
=20
 static int all, tags, force, thin =3D 1, verbose;
-static const char *execute;
+static const char *receivepack;
=20
 #define BUF_SIZE (2084)
 static char buffer[BUF_SIZE];
@@ -160,10 +160,10 @@ static int get_remote_config(const char* key, con=
st char* value)
 			add_refspec(xstrdup(value));
 		else if (config_get_receivepack &&
 			 !strcmp(key + 7 + config_repo_len, ".receivepack")) {
-			if (!execute) {
-				char *ex =3D xmalloc(strlen(value) + 8);
-				sprintf(ex, "--exec=3D%s", value);
-				execute =3D ex;
+			if (!receivepack) {
+				char *rp =3D xmalloc(strlen(value) + 16);
+				sprintf(rp, "--receive-pack=3D%s", value);
+				receivepack =3D rp;
 			} else
 				error("more than one receivepack given, using the first");
 		}
@@ -178,7 +178,7 @@ static int get_config_remotes_uri(const char *repo,=
 const char *uri[MAX_URI])
 	config_current_uri =3D 0;
 	config_uri =3D uri;
 	config_get_refspecs =3D !(refspec_nr || all || tags);
-	config_get_receivepack =3D (execute =3D=3D NULL);
+	config_get_receivepack =3D (receivepack =3D=3D NULL);
=20
 	git_config(get_remote_config);
 	return config_current_uri;
@@ -263,8 +263,8 @@ static int do_push(const char *repo)
 		argv[argc++] =3D "--all";
 	if (force)
 		argv[argc++] =3D "--force";
-	if (execute)
-		argv[argc++] =3D execute;
+	if (receivepack)
+		argv[argc++] =3D receivepack;
 	common_argc =3D argc;
=20
 	for (i =3D 0; i < n; i++) {
@@ -347,8 +347,12 @@ int cmd_push(int argc, const char **argv, const ch=
ar *prefix)
 			thin =3D 0;
 			continue;
 		}
+		if (!strncmp(arg, "--receive-pack=3D", 15)) {
+			receivepack =3D arg;
+			continue;
+		}
 		if (!strncmp(arg, "--exec=3D", 7)) {
-			execute =3D arg;
+			receivepack =3D arg;
 			continue;
 		}
 		usage(push_usage);
diff --git a/send-pack.c b/send-pack.c
index ec2c108..cd478dd 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -6,9 +6,9 @@
 #include "exec_cmd.h"
=20
 static const char send_pack_usage[] =3D
-"git-send-pack [--all] [--force] [--exec=3D<git-receive-pack>] [--verb=
ose] [--thin] [<host>:]<directory> [<ref>...]\n"
+"git-send-pack [--all] [--force] [--receive-pack=3D<git-receive-pack>]=
 [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
 "  --all and explicit <ref> specification are mutually exclusive.";
-static const char *exec =3D "git-receive-pack";
+static const char *receivepack =3D "git-receive-pack";
 static int verbose;
 static int send_all;
 static int force_update;
@@ -377,8 +377,12 @@ int main(int argc, char **argv)
 		char *arg =3D *argv;
=20
 		if (*arg =3D=3D '-') {
+			if (!strncmp(arg, "--receive-pack=3D", 15)) {
+				receivepack =3D arg + 15;
+				continue;
+			}
 			if (!strncmp(arg, "--exec=3D", 7)) {
-				exec =3D arg + 7;
+				receivepack =3D arg + 7;
 				continue;
 			}
 			if (!strcmp(arg, "--all")) {
@@ -413,7 +417,7 @@ int main(int argc, char **argv)
 		usage(send_pack_usage);
 	verify_remote_names(nr_heads, heads);
=20
-	pid =3D git_connect(fd, dest, exec);
+	pid =3D git_connect(fd, dest, receivepack);
 	if (pid < 0)
 		return 1;
 	ret =3D send_pack(fd[0], fd[1], nr_heads, heads);
--=20
1.5.0.rc1.g581a


--=20
Uwe Kleine-K=F6nig

exit vi, lesson II:
: w q ! <CR>

NB: write the current file
