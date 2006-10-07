From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Document features better
Date: Sat, 07 Oct 2006 15:17:47 +0200
Message-ID: <20061007131746.13690.38921.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 07 15:19:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWC4M-0000vv-SN
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 15:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWJGNRu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 09:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbWJGNRu
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 09:17:50 -0400
Received: from rover.dkm.cz ([62.24.64.27]:47579 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S932087AbWJGNRs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 09:17:48 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 1E6468BBE5;
	Sat,  7 Oct 2006 15:17:47 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: 7vbqoowmb4.fsf@assigned-by-dhcp.cox.net
References: 7vbqoowmb4.fsf@assigned-by-dhcp.cox.net
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28480>

This expands gitweb/README to talk some more about GITWEB_CONFIG, moves
feature-specific documentation in gitweb.cgi to the inside of the %features
array, and adds some short description of all the features.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/README      |   16 +++++++++++++-
 gitweb/gitweb.perl |   59 ++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 56 insertions(+), 19 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 78e6fc0..e02e90f 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -26,12 +26,26 @@ You can specify the following configurat
  * GITWEB_LOGO
    Points to the location where you put git-logo.png on your web server.
  * GITWEB_CONFIG
-   This file will be loaded using 'require'.  If the environment
+   This file will be loaded using 'require' and can be used to override any
+   of the options above as well as some other options - see the top of
+   'gitweb.cgi' for their full list and description.  If the environment
    $GITWEB_CONFIG is set when gitweb.cgi is executed the file in the
    environment variable will be loaded instead of the file
    specified when gitweb.cgi was created.
 
 
+Runtime gitweb configuration
+----------------------------
+
+You can adjust gitweb behaviour using the file specified in `GITWEB_CONFIG`
+(defaults to 'gitweb_config.perl' in the same directory as the CGI).
+See the top of 'gitweb.cgi' for the list of variables and some description.
+The most notable thing that is not configurable at compile time are the
+optional features, stored in the '%features' variable. You can find further
+description on how to reconfigure the default features setting in your
+`GITWEB_CONFIG` or per-project in `project.git/config` inside 'gitweb.cgi'.
+
+
 Webserver configuration
 -----------------------
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b06e96a..c4970f4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -100,22 +100,62 @@ our %feature = (
 	#
 	# use gitweb_check_feature(<feature>) to check if <feature> is enabled
 
+	# Enable the 'blame' blob view, showing the last commit that modified
+	# each line in the file. This can be very CPU-intensive.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'blame'}{'default'} = [1];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'blame'}{'override'} = 1;
+	# and in project config gitweb.blame = 0|1;
 	'blame' => {
 		'sub' => \&feature_blame,
 		'override' => 0,
 		'default' => [0]},
 
+	# Enable the 'snapshot' link, providing a compressed tarball of any
+	# tree. This can potentially generate high traffic if you have large
+	# project.
+
+	# To disable system wide have in $GITWEB_CONFIG
+	# $feature{'snapshot'}{'default'} = [undef];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'blame'}{'override'} = 1;
+	# and in project config gitweb.snapshot = none|gzip|bzip2;
 	'snapshot' => {
 		'sub' => \&feature_snapshot,
 		'override' => 0,
 		#         => [content-encoding, suffix, program]
 		'default' => ['x-gzip', 'gz', 'gzip']},
 
+	# Enable the pickaxe search, which will list the commits that modified
+	# a given string in a file. This can be practical and quite faster
+	# alternative to 'blame', but still potentially CPU-intensive.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'pickaxe'}{'default'} = [1];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'pickaxe'}{'override'} = 1;
+	# and in project config gitweb.pickaxe = 0|1;
 	'pickaxe' => {
 		'sub' => \&feature_pickaxe,
 		'override' => 0,
 		'default' => [1]},
 
+	# Make gitweb use an alternative format of the URLs which can be
+	# more readable and natural-looking: project name and some other
+	# information is embedded directly in the path and the query string
+	# contains only auxiliary information. All gitweb installations
+	# support recognizing URL in both formats, this configures only
+	# which formats the gitweb-generated links should use.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'pathinfo'}{'default'} = [1];
+	# Project specific override is not supported.
+	# Note that you will need to change the default location of CSS,
+	# favicon, logo and possibly other files to an absolute URL. Also,
+	# if gitweb.cgi serves as your indexfile, you will need to force
+	# $my_uri to contain the script name in your $GITWEB_CONFIG.
 	'pathinfo' => {
 		'override' => 0,
 		'default' => [0]},
@@ -136,12 +176,6 @@ sub gitweb_check_feature {
 	return $sub->(@defaults);
 }
 
-# To enable system wide have in $GITWEB_CONFIG
-# $feature{'blame'}{'default'} = [1];
-# To have project specific config enable override in $GITWEB_CONFIG
-# $feature{'blame'}{'override'} = 1;
-# and in project config gitweb.blame = 0|1;
-
 sub feature_blame {
 	my ($val) = git_get_project_config('blame', '--bool');
 
@@ -154,12 +188,6 @@ sub feature_blame {
 	return $_[0];
 }
 
-# To disable system wide have in $GITWEB_CONFIG
-# $feature{'snapshot'}{'default'} = [undef];
-# To have project specific config enable override in $GITWEB_CONFIG
-# $feature{'blame'}{'override'} = 1;
-# and in project config  gitweb.snapshot = none|gzip|bzip2
-
 sub feature_snapshot {
 	my ($ctype, $suffix, $command) = @_;
 
@@ -183,12 +211,6 @@ sub gitweb_have_snapshot {
 	return $have_snapshot;
 }
 
-# To enable system wide have in $GITWEB_CONFIG
-# $feature{'pickaxe'}{'default'} = [1];
-# To have project specific config enable override in $GITWEB_CONFIG
-# $feature{'pickaxe'}{'override'} = 1;
-# and in project config gitweb.pickaxe = 0|1;
-
 sub feature_pickaxe {
 	my ($val) = git_get_project_config('pickaxe', '--bool');
 
@@ -434,6 +456,7 @@ sub href(%) {
 	my ($use_pathinfo) = gitweb_check_feature('pathinfo');
 	if ($use_pathinfo) {
 		# use PATH_INFO for project name
+		# TODO: use PATH_INFO for other stuff as well
 		$href .= "/$params{'project'}" if defined $params{'project'};
 		delete $params{'project'};
 
