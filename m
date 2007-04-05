From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH] Make it possible to run git archive --remote without a git directory.
Date: Thu, 5 Apr 2007 21:47:39 +0200
Message-ID: <200704052147.39255.simon@lst.de>
References: <200704051012.37361.simon@lst.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bJVFGL/R5Zfc5qa"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 21:47:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZXvi-0000yr-VN
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 21:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767268AbXDETrc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 15:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767269AbXDETrc
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 15:47:32 -0400
Received: from verein.lst.de ([213.95.11.210]:57549 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767268AbXDETrb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 15:47:31 -0400
Received: from luria.local (157.80-203-65.nextgentel.com [80.203.65.157])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l35JlaLD008871
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Thu, 5 Apr 2007 21:47:37 +0200
User-Agent: KMail/1.9.6
In-Reply-To: <200704051012.37361.simon@lst.de>
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43851>

--Boundary-00=_bJVFGL/R5Zfc5qa
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 05 April 2007 10:12:37 Simon Hausmann wrote:
[...]

Sorry, for replying to my own mail, but attached is a revised patch that also 
allows --list to work without a git dir, as pointed out by Jeff Garzik.

Would be nice if the patch could be applied to git :)


Simon

--Boundary-00=_bJVFGL/R5Zfc5qa
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="0001-Make-it-possible-to-run-git-archive-remote-and-l.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Make-it-possible-to-run-git-archive-remote-and-l.patch"

=46rom f893a0080d0af6d1f02c05de79d21598f614fa4b Mon Sep 17 00:00:00 2001
=46rom: Simon Hausmann <simon@lst.de>
Date: Thu, 5 Apr 2007 10:03:19 +0200
Subject: [PATCH] Make it possible to run git-archive --remote and --list wi=
thout a git directory.

Try a gentle git directory setup for the archive command that remains fatal=
 for
the local case but permits operation without a local git repository when us=
ing
=2D-remote. If in the remote case a git directory is present it will then s=
till be
used for proxy settings, but that is optional now.

Signed-off-by: Simon Hausmann <simon@lst.de>
=2D--
 builtin-archive.c |    6 ++++++
 git.c             |    2 +-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index 2fae885..8c2fe49 100644
=2D-- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -243,6 +243,9 @@ int cmd_archive(int argc, const char **argv, const char=
 *prefix)
 	struct archiver ar;
 	int tree_idx;
 	const char *remote =3D NULL;
+	int nongit =3D 0;
+
+	prefix =3D setup_git_directory_gently(&nongit);
=20
 	remote =3D extract_remote_arg(&argc, argv);
 	if (remote)
@@ -253,6 +256,9 @@ int cmd_archive(int argc, const char **argv, const char=
 *prefix)
 	memset(&ar, 0, sizeof(ar));
 	tree_idx =3D parse_archive_args(argc, argv, &ar);
=20
+	if (nongit)
+		die("Not a git repository");
+
 	argv +=3D tree_idx;
 	parse_treeish_arg(argv, &ar.args, prefix);
 	parse_pathspec_arg(argv + 1, &ar.args);
diff --git a/git.c b/git.c
index 5b1bc2a..33dd4d3 100644
=2D-- a/git.c
+++ b/git.c
@@ -226,7 +226,7 @@ static void handle_internal_command(int argc, const cha=
r **argv, char **envp)
 		{ "add", cmd_add, RUN_SETUP | NOT_BARE },
 		{ "annotate", cmd_annotate, USE_PAGER },
 		{ "apply", cmd_apply },
=2D		{ "archive", cmd_archive, RUN_SETUP },
+		{ "archive", cmd_archive },
 		{ "blame", cmd_blame, RUN_SETUP },
 		{ "branch", cmd_branch, RUN_SETUP },
 		{ "bundle", cmd_bundle },
=2D-=20
1.5.1


--Boundary-00=_bJVFGL/R5Zfc5qa--
