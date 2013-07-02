From: Tony Finch <dot@dotat.at>
Subject: [PATCH] gitweb: allow extra breadcrumbs to prefix the trail
Date: Tue, 2 Jul 2013 16:49:08 +0100
Message-ID: <E1Uu3IT-0008U1-3c@hermes-2.csi.cam.ac.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 02 18:42:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu3fE-0005NO-ND
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 18:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762Ab3GBQmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 12:42:43 -0400
Received: from ppsw-mx-f.csi.cam.ac.uk ([131.111.8.149]:50788 "EHLO
	ppsw-42.csi.cam.ac.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754616Ab3GBQmk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 12:42:40 -0400
X-Greylist: delayed 1402 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jul 2013 12:42:40 EDT
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:37937)
	by ppsw-42.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpa (EXTERNAL:fanf2) id 1Uu3IT-0003SY-6y (Exim 4.80_167-5a66dd3) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 02 Jul 2013 17:19:17 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1Uu3IT-0008U1-3c (Exim 4.72) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 02 Jul 2013 17:19:17 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229399>

There are often parent pages logically above the gitweb projects
list, e.g. home pages of the organization and department that host
the gitweb server. This change allows you to include links to those
pages in gitweb's breadcrumb trail.

Signed-off-by: Tony Finch <dot@dotat.at>
---
 Documentation/gitweb.conf.txt | 8 ++++++++
 gitweb/gitweb.perl            | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index ea0526e..4579578 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -339,6 +339,14 @@ $home_link_str::
 	as this link leads to the list of projects.  Other popular choice it to
 	set it to the name of site.
 
+@extra_breadcrumbs::
+	Additional links to be added to the start of the breadcrumb trail,
+	that are logically "above" the gitweb projects list. For example,
+	links to the organization and department which host the gitweb
+	server. Each element of the list is a reference to an array,
+	in which element 0 is the link text and element 1 is the
+	target URL.
+
 $logo_url::
 $logo_label::
 	URI and label (title) for the Git logo link (or your site logo,
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8d69ada..436f17a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -85,6 +85,9 @@ our $project_maxdepth = "++GITWEB_PROJECT_MAXDEPTH++";
 # string of the home link on top of all pages
 our $home_link_str = "++GITWEB_HOME_LINK_STR++";
 
+# extra breadcrumbs preceding the home link
+our @extra_breadcrumbs = ();
+
 # name of your site or organization to appear in page titles
 # replace this with something more descriptive for clearer bookmarks
 our $site_name = "++GITWEB_SITENAME++"
@@ -3982,6 +3985,9 @@ sub print_nav_breadcrumbs_path {
 sub print_nav_breadcrumbs {
 	my %opts = @_;
 
+	for my $crumb (@extra_breadcrumbs) {
+		print $cgi->a({-href => esc_url($crumb->[1])}, $crumb->[0]) . " / ";
+	}
 	print $cgi->a({-href => esc_url($home_link)}, $home_link_str) . " / ";
 	if (defined $project) {
 		my @dirname = split '/', $project;
-- 
1.8.3.1.605.g85318f5
