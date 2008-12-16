From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] gitweb: unify boolean feature subroutines
Date: Mon, 15 Dec 2008 22:16:19 -0800
Message-ID: <1229408179-7655-1-git-send-email-kraai@ftbfs.org>
References: <7vabawu1ao.fsf@gitster.siamese.dyndns.org>
Cc: Matt Kraai <kraai@ftbfs.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 16 07:18:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCTG2-0000Uz-Cp
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 07:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbYLPGQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 01:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbYLPGQy
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 01:16:54 -0500
Received: from neon.ftbfs.org ([83.168.236.214]:53896 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbYLPGQy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 01:16:54 -0500
Received: from pool-71-119-193-199.lsanca.dsl-w.verizon.net ([71.119.193.199] helo=macbookpro.ftbfs.org)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1LCTEN-0002fj-QR; Mon, 15 Dec 2008 22:16:35 -0800
Received: from kraai by macbookpro.ftbfs.org with local (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1LCTEB-0001zs-Hq; Mon, 15 Dec 2008 22:16:19 -0800
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <7vabawu1ao.fsf@gitster.siamese.dyndns.org>
X-Spam-Score-Int: -41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103250>

The boolean feature subroutines behaved identically except for the
name of the configuration option, so make that a parameter and unify
them.

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
 gitweb/gitweb.perl |   41 +++++++++--------------------------------
 1 files changed, 9 insertions(+), 32 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6eb370d..827e5c5 100755
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
 
@@ -363,16 +363,17 @@ sub gitweb_check_feature {
 }
 
 
-sub feature_blame {
-	my ($val) = git_get_project_config('blame', '--bool');
+sub feature_bool {
+	my $key = shift;
+	my ($val) = git_get_project_config($key, '--bool');
 
 	if ($val eq 'true') {
-		return 1;
+		return (1);
 	} elsif ($val eq 'false') {
-		return 0;
+		return (0);
 	}
 
-	return $_[0];
+	return ($_[0]);
 }
 
 sub feature_snapshot {
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
