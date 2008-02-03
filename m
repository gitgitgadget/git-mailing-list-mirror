From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 1/2] git-svn: Don't call git-repack anymore
Date: Sun, 03 Feb 2008 17:56:12 +0100
Message-ID: <20080203165612.10816.35458.stgit@yoghurt>
References: <20080203165234.10816.6061.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 17:57:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLi9V-0006Zt-Go
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 17:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756354AbYBCQ4X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Feb 2008 11:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756377AbYBCQ4X
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 11:56:23 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3872 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756317AbYBCQ4W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 11:56:22 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JLi8a-0005ew-00; Sun, 03 Feb 2008 16:56:12 +0000
In-Reply-To: <20080203165234.10816.6061.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72366>

In a moment, we'll start calling git-gc --auto instead, since it is a
better fit to what we're trying to accomplish.

The command line options are still accepted, but don't have any
effect, and we warn the user about that.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 git-svn.perl |   14 +++-----------
 1 files changed, 3 insertions(+), 11 deletions(-)


diff --git a/git-svn.perl b/git-svn.perl
index 75e97cc..074068c 100755
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
@@ -1408,9 +1407,9 @@ sub read_all_remotes {
 }
=20
 sub init_vars {
-	$_repack =3D 1000 unless (defined $_repack && $_repack > 0);
-	$_repack_nr =3D $_repack;
-	$_repack_flags ||=3D '-d';
+	if (defined $_repack || defined $_repack_flags) {
+	       warn "Repack options are obsolete; they have no effect.\n";
+	}
 }
=20
 sub verify_remotes_sanity {
@@ -2149,13 +2148,6 @@ sub do_git_commit {
 		                   0, $self->svm_uuid);
 	}
 	print " =3D $commit ($self->{ref_id})\n";
-	if ($_repack && (--$_repack_nr =3D=3D 0)) {
-		$_repack_nr =3D $_repack;
-		# repack doesn't use any arguments with spaces in them, does it?
-		print "Running git repack $_repack_flags ...\n";
-		command_noisy('repack', split(/\s+/, $_repack_flags));
-		print "Done repacking\n";
-	}
 	return $commit;
 }
=20
