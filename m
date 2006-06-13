From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 8/13] git-svn: add --shared and --template= options to pass to init-db
Date: Tue, 13 Jun 2006 11:02:10 -0700
Message-ID: <1150221746915-git-send-email-normalperson@yhbt.net>
References: <11502217352245-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 13 20:02:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqDE0-0004t6-4E
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 20:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWFMSC3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 14:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWFMSC3
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 14:02:29 -0400
Received: from hand.yhbt.net ([66.150.188.102]:49861 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932074AbWFMSC1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 14:02:27 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id A13D67DC020;
	Tue, 13 Jun 2006 11:02:26 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 13 Jun 2006 11:02:26 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11502217352245-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21791>

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index a04cf1d..d8f103e 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -35,6 +35,7 @@ my $sha1_short = qr/[a-f\d]{4,40}/;
 my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
 	$_find_copies_harder, $_l, $_cp_similarity,
 	$_repack, $_repack_nr, $_repack_flags,
+	$_template, $_shared,
 	$_version, $_upgrade, $_authors, $_branch_all_refs);
 my (@_branch_from, %tree_map, %users);
 my ($_svn_co_url_revs, $_svn_pg_peg_revs);
@@ -54,7 +55,9 @@ my %cmd = (
 	fetch => [ \&fetch, "Download new revisions from SVN",
 			{ 'revision|r=s' => \$_revision, %fc_opts } ],
 	init => [ \&init, "Initialize a repo for tracking" .
-			  " (requires URL argument)", { } ],
+			  " (requires URL argument)",
+			  { 'template=s' => \$_template,
+			    'shared' => \$_shared } ],
 	commit => [ \&commit, "Commit git revisions to SVN",
 			{	'stdin|' => \$_stdin,
 				'edit|e' => \$_edit,
@@ -217,7 +220,10 @@ sub init {
 	$SVN_URL = shift or die "SVN repository location required " .
 				"as a command-line argument\n";
 	unless (-d $GIT_DIR) {
-		sys('git-init-db');
+		my @init_db = ('git-init-db');
+		push @init_db, "--template=$_template" if defined $_template;
+		push @init_db, "--shared" if defined $_shared;
+		sys(@init_db);
 	}
 	setup_git_svn();
 }
-- 
1.4.0
