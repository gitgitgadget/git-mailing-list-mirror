From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] gitweb: pass the key to the feature subroutines
Date: Sat,  3 Jan 2009 07:31:32 -0800
Message-ID: <1230996692-7182-2-git-send-email-kraai@ftbfs.org>
References: <1230996692-7182-1-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <kraai@ftbfs.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 03 16:33:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJ8Ux-0007SO-4W
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 16:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759494AbZACPbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 10:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759422AbZACPbq
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 10:31:46 -0500
Received: from neon.ftbfs.org ([83.168.236.214]:52889 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759300AbZACPbp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 10:31:45 -0500
Received: from pool-71-119-193-199.lsanca.dsl-w.verizon.net
	([71.119.193.199] helo=macbookpro.ftbfs.org ident=Debian-exim)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1LJ8TO-0001Hz-MG; Sat, 03 Jan 2009 07:31:38 -0800
Received: from kraai by macbookpro.ftbfs.org with local (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1LJ8TM-0001sF-IY; Sat, 03 Jan 2009 07:31:32 -0800
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1230996692-7182-1-git-send-email-kraai@ftbfs.org>
X-Spam-Score-Int: -40
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104469>

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
 gitweb/gitweb.perl |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4ba2a9b..2edefda 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -203,7 +203,7 @@ our %feature = (
 	# $feature{'blame'}{'override'} = 1;
 	# and in project config gitweb.blame = 0|1;
 	'blame' => {
-		'sub' => sub { feature_bool('blame', @_) },
+		'sub' => \&feature_bool,
 		'override' => 0,
 		'default' => [0]},
 
@@ -241,7 +241,7 @@ our %feature = (
 	# $feature{'grep'}{'override'} = 1;
 	# and in project config gitweb.grep = 0|1;
 	'grep' => {
-		'sub' => sub { feature_bool('grep', @_) },
+		'sub' => \&feature_bool,
 		'override' => 0,
 		'default' => [1]},
 
@@ -255,7 +255,7 @@ our %feature = (
 	# $feature{'pickaxe'}{'override'} = 1;
 	# and in project config gitweb.pickaxe = 0|1;
 	'pickaxe' => {
-		'sub' => sub { feature_bool('pickaxe', @_) },
+		'sub' => \&feature_bool,
 		'override' => 0,
 		'default' => [1]},
 
@@ -344,7 +344,7 @@ sub gitweb_get_feature {
 		warn "feature $name is not overrideable";
 		return @defaults;
 	}
-	return $sub->(@defaults);
+	return $sub->($name, @defaults);
 }
 
 # A wrapper to check if a given feature is enabled.
@@ -377,9 +377,9 @@ sub feature_bool {
 }
 
 sub feature_snapshot {
-	my (@fmts) = @_;
+	my ($key, @fmts) = @_;
 
-	my ($val) = git_get_project_config('snapshot');
+	my ($val) = git_get_project_config($key);
 
 	if ($val) {
 		@fmts = ($val eq 'none' ? () : split /\s*[,\s]\s*/, $val);
-- 
1.5.6.5
