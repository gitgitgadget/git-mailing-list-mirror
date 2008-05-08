From: Trent Piepho <tpiepho@freescale.com>
Subject: [PATCH] cvsexportcommit: Create config option for CVS dir
Date: Thu,  8 May 2008 14:26:55 -0700
Message-ID: <1210282015-20872-1-git-send-email-tpiepho@freescale.com>
Cc: Trent Piepho <tpiepho@freescale.com>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 23:30:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuDgL-0006Uj-OC
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 23:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598AbYEHV2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 17:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754085AbYEHV2w
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 17:28:52 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:38967 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958AbYEHV2v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 17:28:51 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id m48LSVeb019918;
	Thu, 8 May 2008 14:28:31 -0700 (MST)
Received: from localhost.localdomain (vpn-10-213-160-40.am.freescale.net [10.213.160.40])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m48LSUZ6004470;
	Thu, 8 May 2008 16:28:30 -0500 (CDT)
X-Mailer: git-send-email 1.5.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81569>

For a given project the directory used with the -w option is almost always
the same each time.  Let it be specified with 'cvsexportcommit.cvsdir' so
it's not necessary to manually add it with -w each time.

Signed-off-by: Trent Piepho <tpiepho@freescale.com>
---
 Documentation/git-cvsexportcommit.txt |    8 +++++++-
 git-cvsexportcommit.perl              |    5 +++++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index 9a47b4c..363c36d 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -65,11 +65,17 @@ OPTIONS
 -w::
 	Specify the location of the CVS checkout to use for the export. This
 	option does not require GIT_DIR to be set before execution if the
-	current directory is within a git repository.
+	current directory is within a git repository.  The default is the
+	value of 'cvsexportcommit.cvsdir'.
 
 -v::
 	Verbose.
 
+CONFIGURATION
+-------------
+cvsexportcommit.cvsdir::
+	The default location of the CVS checkout to use for the export.
+
 EXAMPLES
 --------
 
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index b6036bd..c93bd9c 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -6,6 +6,7 @@ use File::Temp qw(tempdir);
 use Data::Dumper;
 use File::Basename qw(basename dirname);
 use File::Spec;
+use Git;
 
 our ($opt_h, $opt_P, $opt_p, $opt_v, $opt_c, $opt_f, $opt_a, $opt_m, $opt_d, $opt_u, $opt_w);
 
@@ -15,6 +16,10 @@ $opt_h && usage();
 
 die "Need at least one commit identifier!" unless @ARGV;
 
+# Get git-config settings
+my $repo = Git->repository();
+$opt_w = $repo->config('cvsexportcommit.cvsdir') unless defined $opt_w;
+
 if ($opt_w) {
 	# Remember where GIT_DIR is before changing to CVS checkout
 	unless ($ENV{GIT_DIR}) {
-- 
1.5.4.1
