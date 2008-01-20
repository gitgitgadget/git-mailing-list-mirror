From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 1/2] git-svn: Don't call git-repack anymore
Date: Sun, 20 Jan 2008 22:39:51 +0100
Message-ID: <20080120213847.9679.56653.stgit@yoghurt>
References: <20080120093436.GA10924@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Harvey Harrison <harvey.harrison@gmail.com>,
	Kevin Ballard <kevin@sb.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jan 20 22:40:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGhuI-0000Fa-NA
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 22:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755655AbYATVkK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jan 2008 16:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755581AbYATVkK
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 16:40:10 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3524 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755540AbYATVkI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 16:40:08 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JGhta-0004Yp-00; Sun, 20 Jan 2008 21:40:02 +0000
In-Reply-To: <20080120093436.GA10924@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71193>

In a moment, we'll start calling git-gc --auto instead, since it is a
better fit to what we're trying to accomplish.

The command line options are still accepted, but don't have any
effect, and we warn the user about that.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

Is this close enough to what you intended?

 git-svn.perl |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)


diff --git a/git-svn.perl b/git-svn.perl
index 9f2b587..988d8f6 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1247,7 +1247,6 @@ use File::Path qw/mkpath/;
 use File::Copy qw/copy/;
 use IPC::Open3;
=20
-my $_repack_nr;
 # properties that we do not log:
 my %SKIP_PROP;
 BEGIN {
@@ -1408,10 +1407,8 @@ sub read_all_remotes {
 }
=20
 sub init_vars {
-	if (defined $_repack) {
-		$_repack =3D 1000 if ($_repack <=3D 0);
-		$_repack_nr =3D $_repack;
-		$_repack_flags ||=3D '-d';
+	if (defined $_repack || defined $_repack_flags) {
+               warn "Repack options are obsolete; they have no effect.=
\n";
 	}
 }
=20
@@ -2151,13 +2148,6 @@ sub do_git_commit {
 		                   0, $self->svm_uuid);
 	}
 	print " =3D $commit ($self->{ref_id})\n";
-	if (defined $_repack && (--$_repack_nr =3D=3D 0)) {
-		$_repack_nr =3D $_repack;
-		# repack doesn't use any arguments with spaces in them, does it?
-		print "Running git repack $_repack_flags ...\n";
-		command_noisy('repack', split(/\s+/, $_repack_flags));
-		print "Done repacking\n";
-	}
 	return $commit;
 }
=20
