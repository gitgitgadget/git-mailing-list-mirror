From: "Luke-Jr" <luke-jr@utopios.org>
Subject: For review: git add --ignore-unmatch
Date: Wed, 12 Aug 2009 17:26:51 -0500
Organization: Utopios
Message-ID: <200908121726.52121.luke-jr@utopios.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sG0gKPUDQM09mE6"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 00:36:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbMRC-0003b0-6E
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 00:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbZHLWgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 18:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752331AbZHLWgm
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 18:36:42 -0400
Received: from unused ([66.216.20.21]:55247 "EHLO zinan.dashjr.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752204AbZHLWgl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 18:36:41 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Aug 2009 18:36:41 EDT
Received: from tsuruki.localnet (ip70-187-26-118.om.om.cox.net [70.187.26.118])
	(Authenticated sender: luke-jr)
	by zinan.dashjr.org (Postfix) with ESMTPSA id 87DF1B9DB16
	for <git@vger.kernel.org>; Wed, 12 Aug 2009 22:26:59 +0000 (UTC)
User-Agent: KMail/1.12.0 (Linux/2.6.27-gentoo-r7; KDE/4.3.0; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125753>

--Boundary-00=_sG0gKPUDQM09mE6
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit



--Boundary-00=_sG0gKPUDQM09mE6
Content-Type: text/x-patch;
  charset="ISO-8859-1";
  name="0001-port-ignore-unmatch-from-git-rm-to-git-add.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-port-ignore-unmatch-from-git-rm-to-git-add.patch"

=46rom 54768360aa7b1882dd2b76211661abb6014cbf23 Mon Sep 17 00:00:00 2001
=46rom: Luke Dashjr <luke-jr+git@utopios.org>
Date: Wed, 12 Aug 2009 16:26:31 -0500
Subject: [PATCH 1/3] port --ignore-unmatch from "git rm" to "git add"

=2D--
 builtin-add.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 581a2a1..0597fb9 100644
=2D-- a/builtin-add.c
+++ b/builtin-add.c
@@ -19,6 +19,7 @@ static const char * const builtin_add_usage[] =3D {
 };
 static int patch_interactive, add_interactive, edit_interactive;
 static int take_worktree_changes;
+static int ignore_unmatch =3D 0;
=20
 static void fill_pathspec_matches(const char **pathspec, char *seen, int s=
pecs)
 {
@@ -63,7 +64,7 @@ static void prune_directory(struct dir_struct *dir, const=
 char **pathspec, int p
 	fill_pathspec_matches(pathspec, seen, specs);
=20
 	for (i =3D 0; i < specs; i++) {
=2D		if (!seen[i] && pathspec[i][0] && !file_exists(pathspec[i]))
+		if (!seen[i] && pathspec[i][0] && !file_exists(pathspec[i]) && !ignore_u=
nmatch)
 			die("pathspec '%s' did not match any files",
 					pathspec[i]);
 	}
@@ -108,7 +109,7 @@ static void refresh(int verbose, const char **pathspec)
 	refresh_index(&the_index, verbose ? REFRESH_SAY_CHANGED : REFRESH_QUIET,
 		      pathspec, seen);
 	for (i =3D 0; i < specs; i++) {
=2D		if (!seen[i])
+		if (!seen[i] && !ignore_unmatch)
 			die("pathspec '%s' did not match any files", pathspec[i]);
 	}
         free(seen);
@@ -226,6 +227,8 @@ static struct option builtin_add_options[] =3D {
 	OPT_BOOLEAN('A', "all", &addremove, "add all, noticing removal of tracked=
 files"),
 	OPT_BOOLEAN( 0 , "refresh", &refresh_only, "don't add, only refresh the i=
ndex"),
 	OPT_BOOLEAN( 0 , "ignore-errors", &ignore_add_errors, "just skip files wh=
ich cannot be added because of errors"),
+	OPT_BOOLEAN( 0 , "ignore-unmatch", &ignore_unmatch,
+				"exit with a zero status even if nothing matched"),
 	OPT_END(),
 };
=20
=2D-=20
1.6.3.3


--Boundary-00=_sG0gKPUDQM09mE6
Content-Type: text/x-patch;
  charset="ISO-8859-1";
  name="0002-fix-git-add-ignore-errors-to-ignore-pathspec-errors.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-fix-git-add-ignore-errors-to-ignore-pathspec-errors.patch"

=46rom c6cd06db8ab3b198eafffd5b0e94d2f338f10072 Mon Sep 17 00:00:00 2001
=46rom: Luke Dashjr <luke-jr+git@utopios.org>
Date: Wed, 12 Aug 2009 16:31:37 -0500
Subject: [PATCH 2/3] fix "git add --ignore-errors" to ignore pathspec errors

=2D--
 builtin-add.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 0597fb9..e3132c8 100644
=2D-- a/builtin-add.c
+++ b/builtin-add.c
@@ -280,6 +280,8 @@ int cmd_add(int argc, const char **argv, const char *pr=
efix)
 		add_interactive =3D 1;
 	if (add_interactive)
 		exit(interactive_add(argc - 1, argv + 1, prefix));
+	if (ignore_add_errors)
+		ignore_unmatch =3D 1;
=20
 	if (edit_interactive)
 		return(edit_patch(argc, argv, prefix));
=2D-=20
1.6.3.3


--Boundary-00=_sG0gKPUDQM09mE6
Content-Type: text/x-patch;
  charset="ISO-8859-1";
  name="0003-Document-ignore-unmatch-in-git-add.txt.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0003-Document-ignore-unmatch-in-git-add.txt.patch"

=46rom 410a93cb61669304a0b1d10b8013d1635432e8a0 Mon Sep 17 00:00:00 2001
=46rom: Luke Dashjr <luke-jr+git@utopios.org>
Date: Wed, 12 Aug 2009 17:23:44 -0500
Subject: [PATCH 3/3] Document --ignore-unmatch in git-add.txt

=2D--
 Documentation/git-add.txt |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index ab1943c..6b93b4e 100644
=2D-- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 [verse]
 'git add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
 	  [--edit | -e] [--all | [--update | -u]] [--intent-to-add | -N]
=2D	  [--refresh] [--ignore-errors] [--] <filepattern>...
+	  [--refresh] [--ignore-errors] [--ignore-unmatch] [--]
+	  <filepattern>...
=20
 DESCRIPTION
 -----------
@@ -119,6 +120,9 @@ apply.
 	them, do not abort the operation, but continue adding the
 	others. The command shall still exit with non-zero status.
=20
+--ignore-unmatch::
+	Exit with a zero status even if no files matched.
+
 \--::
 	This option can be used to separate command-line options from
 	the list of files, (useful when filenames might be mistaken
=2D-=20
1.6.3.3


--Boundary-00=_sG0gKPUDQM09mE6--
