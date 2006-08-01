From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] gitweb: clean up user configuration part
Date: Tue, 1 Aug 2006 14:48:52 +0200
Message-ID: <E1G7tg4-0007bJ-7r@moooo.ath.cx>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Aug 01 14:49:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7tgA-0006xH-8q
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 14:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbWHAMsz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 08:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbWHAMsz
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 08:48:55 -0400
Received: from moooo.ath.cx ([85.116.203.178]:52165 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751601AbWHAMsy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Aug 2006 08:48:54 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24597>

 * add a marker where the user configuration starts/ends
 * replaced the two $projectroot = lines
 * add a comment to $projectlist
 * reorder the variables

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
I tried to put the variables at top which will be edited most likely
(cannot have sane default values).
---
 gitweb/gitweb.cgi |   58 ++++++++++++++++++++++++++++++++---------------------
 1 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 9448b72..ca2ef70 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -18,44 +18,42 @@ use File::Find qw();
 binmode STDOUT, ':utf8';
 
 our $cgi = new CGI;
-our $version = "267";
-our $my_url = $cgi->url();
-our $my_uri = $cgi->url(-absolute => 1);
-our $rss_link = "";
 
-# core git executable to use
-# this can just be "git" if your webserver has a sensible PATH
-our $GIT = "/usr/bin/git";
+##
+## BEGIN USER CONFIGURATION
+##
 
 # absolute fs-path which will be prepended to the project path
-#our $projectroot = "/pub/scm";
-our $projectroot = "/home/kay/public_html/pub/scm";
+our $projectroot = "/pub/git";
 
-# version of the core git binary
-our $git_version = qx($GIT --version) =~ m/git version (.*)$/ ? $1 : "unknown";
+# source of projects list
+# file: list of projects, may use subdirectories
+# directory: all git repositories in the directory (not subdirectories)
+our $projects_list = "index/index.aux";
+#our $projects_list = $projectroot;
 
-# location for temporary files needed for diffs
-our $git_temp = "/tmp/gitweb";
-if (! -d $git_temp) {
-	mkdir($git_temp, 0700) || die_error("Couldn't mkdir $git_temp");
-}
+# html text to include at home page
+our $home_text = "indextext.html";
 
-# target of the home link on top of all pages
-our $home_link = $my_uri;
+# core git executable to use
+# this can just be "git" if your webserver has a sensible PATH
+our $GIT = "/usr/bin/git";
 
 # name of your site or organization to appear in page titles
 # replace this with something more descriptive for clearer bookmarks
 our $site_name = $ENV{'SERVER_NAME'} || "Untitled";
 
-# html text to include at home page
-our $home_text = "indextext.html";
+our $my_url = $cgi->url();
+our $my_uri = $cgi->url(-absolute => 1);
+our $rss_link = "";
+# target of the home link on top of all pages
+our $home_link = $my_uri;
 
 # URI of default stylesheet
 our $stylesheet = "gitweb.css";
 
-# source of projects list
-#our $projects_list = $projectroot;
-our $projects_list = "index/index.aux";
+# location for temporary files needed for diffs
+our $git_temp = "/tmp/gitweb";
 
 # default blob_plain mimetype and default charset for text/plain blob
 our $default_blob_plain_mimetype = 'text/plain';
@@ -65,6 +63,20 @@ # file to use for guessing MIME types be
 # (relative to the current git repository)
 our $mimetypes_file = undef;
 
+##
+## END USER CONFIGURATION
+##
+
+# version of the core git binary
+our $git_version = qx($GIT --version) =~ m/git version (.*)$/ ? $1 : "unknown";
+
+our $version = "267";
+
+# create temp directory
+if (! -d $git_temp) {
+	mkdir($git_temp, 0700) || die_error("Couldn't mkdir $git_temp");
+}
+
 # input validation and dispatch
 our $action = $cgi->param('a');
 if (defined $action) {
-- 
1.4.2.rc2.g4713
