From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCHv2 2/4 (resent)] gitweb: Add option to force version match
Date: Sun,  3 Jan 2010 17:07:28 +0100
Message-ID: <1262534850-24572-3-git-send-email-jnareb@gmail.com>
References: <1262534850-24572-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 03 17:08:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRSzz-0008Jq-3Q
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jan 2010 17:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164Ab0ACQHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2010 11:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752358Ab0ACQHo
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 11:07:44 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:63992 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab0ACQHm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jan 2010 11:07:42 -0500
Received: by mail-fx0-f225.google.com with SMTP id 25so8133186fxm.21
        for <git@vger.kernel.org>; Sun, 03 Jan 2010 08:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fy0HtDRjkH10cxcj1f0ixwDc/oN/Klw4+cPil2ePInk=;
        b=tKBcVHQLjc37PmtoH04PCTPeVd89baXUypnjb3rUIsZRvS5fovN/FQ9BzhDw3VfzVT
         gYjvc4tdHScvjgSs54lrs9SdfTzFgoZlqKdbmSpKUHA8sfAz89H75L4KF3b8Eqer4RW4
         tBz0GnHW5zfFvOrfzM9na2nFOvVDpRV8+26mo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ab5G6PcUQBUZnqVj8AweaD93AvDzUCgEbMbI6ngWZwANSIPYjrf3wnahI5NizSttSs
         iXCi4rc8mGwBaOctbmYzmaUBwbMn4nPRgnj87U1P5pNxl4E4nOOAHOhj5xeQMKETP53/
         3i+lL/K3bRT/TZgtPdywueojUeOTRjbAFV9Rc=
Received: by 10.103.48.13 with SMTP id a13mr2170306muk.14.1262534862100;
        Sun, 03 Jan 2010 08:07:42 -0800 (PST)
Received: from localhost.localdomain (abvk210.neoplus.adsl.tpnet.pl [83.8.208.210])
        by mx.google.com with ESMTPS id g1sm1607328muf.14.2010.01.03.08.07.40
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Jan 2010 08:07:41 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3
In-Reply-To: <1262534850-24572-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136075>

From: John 'Warthog9' Hawley <warthog9@kernel.org>

This adds $git_versions_must_match variable, which is set to true
value checks that we are running on the same version of git that we
shipped with, and if not throw '500 Internal Server Error' error.
What is checked is the version of gitweb (embedded in building
gitweb.cgi), against version of runtime git binary used.

Gitweb can usually run with a mismatched git install.  This is more
here to give an obvious warning as to whats going on vs. silently
failing.

By default this feature is turned off.

Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I don't quite see the reason behind such option, and I think that
error (instead of for example warning) on version mismatch is too much.

In short: this change is meant to avoid situation where version
mismatch results in silent error, but it would work only if it would
be default on; on the other hand having it default on is I think too
inconvenient, so I changed it to default off, which perhaps defeats
the stated purpose of this patch.

This is an RFC because formatting of error page is a bit rough, and
(ab)uses exist CSS classes instead of creating new classnames for
semantic markup.

Differences from original version, by J.H.:
* Changed name and flipped meaning of config variable, from
  $missmatch_git to $git_versions_must_match
* $git_versions_must_match is boolean flag - do not compare with an
  empty string.
* Changed error message a bit, fixed style, added entry in README

 gitweb/README      |    3 +++
 gitweb/gitweb.perl |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 6c2c8e1..608b0f8 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -233,6 +233,9 @@ not include variables usually directly set during build):
    If server load exceed this value then return "503 Service Unavailable" error.
    Server load is taken to be 0 if gitweb cannot determine its value.  Set it to
    undefined value to turn it off.  The default is 300.
+ * $git_versions_must_match
+   If set, gitweb fails with 500 Internal Server Error if the version of gitweb
+   doesn't match version of git binary.  The default is false.
 
 
 Projects list file format
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3222131..b9bd865 100755
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
@@ -581,6 +584,36 @@ if (defined $maxload && get_loadavg() > $maxload) {
 our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
 $number_of_git_cmds++;
 
+# Throw an error if git versions does not match, if $git_versions_must_match is true.
+if ($git_versions_must_match &&
+    $git_version ne $version) {
+	git_header_html('500 - Internal Server Error');
+	my $admin_contact =
+		defined $ENV{'SERVER_ADMIN'} ? ", $ENV{'SERVER_ADMIN'}," : '';
+	print <<"EOT";
+<div class="page_body">
+<br /><br />
+500 - Internal Server Error
+<br />
+</div>
+<hr />
+<div class="readme">
+<h1 align="center">*** Warning ***</h1>
+<p>
+This version of gitweb was compiled for <b>@{[esc_html($version)]}</b>,
+however git version <b>@{[esc_html($git_version)]}</b> was found on server,
+and administrator requested strict version checking.
+</p>
+<p>
+Please contact the server administrator${admin_contact} to either configure
+gitweb to allow mismatched versions, or update git or gitweb installation.
+</p>
+</div>
+EOT
+	git_footer_html();
+	exit;
+}
+
 $projects_list ||= $projectroot;
 
 # ======================================================================
-- 
1.6.5.3
