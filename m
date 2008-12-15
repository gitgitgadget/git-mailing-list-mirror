From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] gitweb: unify boolean feature subroutines
Date: Mon, 15 Dec 2008 06:51:49 -0800
Message-ID: <1229352709-4663-2-git-send-email-kraai@ftbfs.org>
References: <1229352709-4663-1-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <kraai@ftbfs.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 15 15:53:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCEpC-0004Vz-Di
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 15:53:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273AbYLOOwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 09:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753369AbYLOOwP
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 09:52:15 -0500
Received: from neon.ftbfs.org ([83.168.236.214]:52322 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753258AbYLOOwN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 09:52:13 -0500
Received: from pool-71-119-193-199.lsanca.dsl-w.verizon.net ([71.119.193.199] helo=macbookpro.ftbfs.org)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1LCEne-0000je-Ez; Mon, 15 Dec 2008 06:52:04 -0800
Received: from kraai by macbookpro.ftbfs.org with local (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1LCEnW-0001EX-0W; Mon, 15 Dec 2008 06:51:50 -0800
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1229352709-4663-1-git-send-email-kraai@ftbfs.org>
X-Spam-Score-Int: -41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103171>

The boolean feature subroutines were identical except for the name of
the configuration option, so make that a parameter and unify them.

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
 gitweb/gitweb.perl |   35 ++++++-----------------------------
 1 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 145e712..827e5c5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -203,7 +203,7 @@ our %feature = (
 	# $feature{'blame'}{'override'} = 1;
 	# and in project config gitweb.blame = 0|1;
 	'blame' => {
-		'sub' => \&feature_blame,
+		'sub' => sub { feature_bool('blame', @_) },
 		'override' => 0,
 		'default' => [0]},
 
@@ -241,7 +241,7 @@ our %feature = (
 	# $feature{'grep'}{'override'} = 1;
 	# and in project config gitweb.grep = 0|1;
 	'grep' => {
-		'sub' => \&feature_grep,
+		'sub' => sub { feature_bool('grep', @_) },
 		'override' => 0,
 		'default' => [1]},
 
@@ -255,7 +255,7 @@ our %feature = (
 	# $feature{'pickaxe'}{'override'} = 1;
 	# and in project config gitweb.pickaxe = 0|1;
 	'pickaxe' => {
-		'sub' => \&feature_pickaxe,
+		'sub' => sub { feature_bool('pickaxe', @_) },
 		'override' => 0,
 		'default' => [1]},
 
@@ -363,8 +363,9 @@ sub gitweb_check_feature {
 }
 
 
-sub feature_blame {
-	my ($val) = git_get_project_config('blame', '--bool');
+sub feature_bool {
+	my $key = shift;
+	my ($val) = git_get_project_config($key, '--bool');
 
 	if ($val eq 'true') {
 		return (1);
@@ -387,30 +388,6 @@ sub feature_snapshot {
 	return @fmts;
 }
 
-sub feature_grep {
-	my ($val) = git_get_project_config('grep', '--bool');
-
-	if ($val eq 'true') {
-		return (1);
-	} elsif ($val eq 'false') {
-		return (0);
-	}
-
-	return ($_[0]);
-}
-
-sub feature_pickaxe {
-	my ($val) = git_get_project_config('pickaxe', '--bool');
-
-	if ($val eq 'true') {
-		return (1);
-	} elsif ($val eq 'false') {
-		return (0);
-	}
-
-	return ($_[0]);
-}
-
 # checking HEAD file with -e is fragile if the repository was
 # initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
 # and then pruned.
-- 
1.5.6.5
