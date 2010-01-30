From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 8/8 v6] gitweb: Add an option to force version match
Date: Sat, 30 Jan 2010 23:30:45 +0100
Message-ID: <1264890645-28310-9-git-send-email-jnareb@gmail.com>
References: <1264890645-28310-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 23:31:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbLqn-0008Ua-NY
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 23:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497Ab0A3WbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 17:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754403Ab0A3WbN
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 17:31:13 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:46818 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886Ab0A3WbL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 17:31:11 -0500
Received: by mail-fx0-f220.google.com with SMTP id 20so3058038fxm.21
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 14:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Y5DAKVayYDXMMN++9K3sZiKqCCBqUBoq78doGBHGtwM=;
        b=VZSToZ7zT1leUXZzOy3Bfchv5qPGVB0InVXjWs9LEU6incZzcDXUymWD7lmXugJz+F
         kZ6vJx7Rq8MX5qYU1JhVv8NKwBl2NMhi3tryrF6iDNMAfL89an72lan01DVhfvxv5cJE
         dScduf7vCpfgarZfPYc7KwjkAx5xz7GhzGfvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=W/RHtSyO3xrx5NX3eWGFK3MSE56Kk9y5FippBXrOS6o0o602PhL4ugItWrt1GCzKrN
         DqklJBIerCHSrcX104Ubp0jLQGwWkerefkLM7o18Duo9op6vUyMrh5w0P03gD5hLQRX+
         Q3OqJ27CW68C+iAT0gVOW+UzOMXHKwVzBeJYI=
Received: by 10.223.17.19 with SMTP id q19mr2288200faa.75.1264890670453;
        Sat, 30 Jan 2010 14:31:10 -0800 (PST)
Received: from localhost.localdomain (abwu191.neoplus.adsl.tpnet.pl [83.8.244.191])
        by mx.google.com with ESMTPS id 15sm1157284fxm.6.2010.01.30.14.31.09
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Jan 2010 14:31:09 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1264890645-28310-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138513>

From: John 'Warthog9' Hawley <warthog9@kernel.org>

This adds $git_versions_must_match variable, which if set to true,
checks that we are running on the same version of git that we
shipped with, and if not throw '500 Internal Server Error' error.
What is checked is the version of gitweb (embedded in building
gitweb.cgi), against version of runtime git binary used.

Gitweb can usually run with a mismatched git install.  This is more
here to give an obvious warning as to what's going on vs. silently
failing.

By default this feature is turned off.

Add tests to t9501-gitweb-standalone-http-status.sh that this feature
works correctly (as expected) if turned on, both in match and no match
case.

Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Changes from version from 'Gitweb caching v5' and
  git://git.kernel.org/pub/scm/git/warthog9/gitweb.git gitweb-ml-v5

* Again turned off by default
* More detailed error description, as requested by Petr 'Pasky' Baudis
  in http://permalink.gmane.org/gmane.comp.version-control.git/137922
* Which in turn required to set $GITWEB_CONFIG_SYSTEM to be able to
  use its value in error description; otherwise we would get 'Variable 
  "$GITWEB_CONFIG_SYSTEM" is not imported' error.
* Turn off forcing version matching in t/gitweb-lib.sh
* Add some tests for this feature in t9501-gitweb-standalone-http-status.sh

 gitweb/README                            |    5 +++++
 gitweb/gitweb.perl                       |   29 ++++++++++++++++++++++++++++-
 t/gitweb-lib.sh                          |    1 +
 t/t9501-gitweb-standalone-http-status.sh |   27 +++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 1 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 6c2c8e1..83a25a9 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -233,6 +233,11 @@ not include variables usually directly set during build):
    If server load exceed this value then return "503 Service Unavaliable" error.
    Server load is taken to be 0 if gitweb cannot determine its value.  Set it to
    undefined value to turn it off.  The default is 300.
+ * $git_versions_must_match
+   If set to true value, gitweb fails with "500 Internal Server Error" error
+   if the version of the gitweb doesn't match version of the git binary.
+   Gitweb can usually run with a mismatched git install.   The default is 0
+   (false).
 
 
 Projects list file format
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d0c3ff2..e69efeb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -221,6 +221,9 @@ our %avatar_size = (
 	'double'  => 32
 );
 
+# If it is true, exit if gitweb version and git binary version don't match
+our $git_versions_must_match = 0;
+
 # Used to set the maximum load that we will still respond to gitweb queries.
 # If server load exceed this value then return "503 server busy" error.
 # If gitweb cannot determined server load, it is taken to be 0.
@@ -550,10 +553,10 @@ sub filter_snapshot_fmts {
 }
 
 our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
+our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
 if (-e $GITWEB_CONFIG) {
 	do $GITWEB_CONFIG;
 } else {
-	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
 	do $GITWEB_CONFIG_SYSTEM if -e $GITWEB_CONFIG_SYSTEM;
 }
 
@@ -583,6 +586,30 @@ sub get_loadavg {
 our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
 $number_of_git_cmds++;
 
+# Throw an error if git versions does not match, if $git_versions_must_match is true.
+if ($git_versions_must_match &&
+    $git_version ne $version) {
+	my $admin_contact =
+		defined $ENV{'SERVER_ADMIN'} ? ", $ENV{'SERVER_ADMIN'}," : '';
+	my $err_msg = <<EOT;
+<h1 align="center">*** Warning ***</h1>
+<p>
+This version of gitweb was compiled for <b>@{[esc_html($version)]}</b>,
+however git version <b>@{[esc_html($git_version)]}</b> was found on server,
+and administrator requested strict version checking by setting
+\$git_versions_must_match to @{[esc_html($git_versions_must_match)]}
+(true value) in gitweb configuration file,
+'@{[esc_path(-e $GITWEB_CONFIG ? $GITWEB_CONFIG : $GITWEB_CONFIG_SYSTEM)]}'.
+</p>
+<p>
+Please contact the server administrator${admin_contact} to either configure
+gitweb to allow mismatched versions, or update git or gitweb installation
+so that their versions do match.
+</p>
+EOT
+	die_error(500, 'Internal server error', $err_msg);
+}
+
 $projects_list ||= $projectroot;
 
 if (defined $maxload && get_loadavg() > $maxload) {
diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 5a734b1..66a3e2d 100755
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -26,6 +26,7 @@ our \$projects_list = '';
 our \$export_ok = '';
 our \$strict_export = '';
 our \$maxload = undef;
+our \$git_versions_must_match = 0;
 
 EOF
 
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index 7590f10..e195f97 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -133,5 +133,32 @@ cat >>gitweb_config.perl <<\EOF
 our $maxload = undef;
 EOF
 
+# ======================================================================
+# check $git_versions_must_match feature
+# should be last section, just in case
+cp -f gitweb_config.perl gitweb_config.perl.bak
+echo 'our $git_versions_must_match = 1;' >>gitweb_config.perl
+
+cat <<\EOF >>gitweb_config.perl
+our $version = "current";
+EOF
+test_expect_success 'force version match: no match' '
+	gitweb_run "p=.git" &&
+	grep "Status: 500 Internal Server Error" gitweb.headers &&
+	grep "500 - Internal server error" gitweb.body
+'
+test_debug 'cat gitweb.headers'
+
+cat <<\EOF >>gitweb_config.perl
+# must be kept in sync with code in gitweb/gitweb.perl
+our $version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
+EOF
+test_expect_success 'force version match: match' '
+	gitweb_run "p=.git" &&
+	grep "Status: 200 OK" gitweb.headers
+'
+test_debug 'cat gitweb.headers'
+
+mv -f gitweb_config.perl.bak gitweb_config.perl
 
 test_done
-- 
1.6.6.1
