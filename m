From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: [PATCH v2 2/2] gitweb: place links to parent directories in page
 header
Date: Sat, 28 Jan 2012 17:57:56 +0100
Message-ID: <20120128165753.GA6795@server.brlink.eu>
References: <20120128165606.GA6770@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 28 18:40:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrCFn-0000o9-F2
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jan 2012 18:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709Ab2A1Q5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jan 2012 11:57:40 -0500
Received: from server.brlink.eu ([78.46.187.186]:54053 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477Ab2A1Q5k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 11:57:40 -0500
Received: from mfs.mathematik.uni-freiburg.de ([132.230.30.170] helo=client.brlink.eu)
	by server.brlink.eu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrBat-00039k-9s
	for git@vger.kernel.org; Sat, 28 Jan 2012 17:57:39 +0100
Received: from brl by client.brlink.eu with local (Exim 4.77)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrBbA-0001lq-VT
	for git@vger.kernel.org; Sat, 28 Jan 2012 17:57:57 +0100
Content-Disposition: inline
In-Reply-To: <20120128165606.GA6770@server.brlink.eu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189261>

Signed-off-by: Bernhard R. Link <brlink@debian.org>

---
This patch was not yet part of v1.

I'm not sure this if having this as seperate patch or merged into 1/2
makes more sense.

 gitweb/gitweb.perl |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a114bd4..ddce27d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3841,7 +3841,18 @@ sub print_nav_breadcrumbs {
 
 	print $cgi->a({-href => esc_url($home_link)}, $home_link_str) . " / ";
 	if (defined $project) {
-		print $cgi->a({-href => href(action=>"summary")}, esc_html($project));
+		my @dirname = split '/', $project;
+		my $projectbasename = pop @dirname;
+		my $dirprefix = undef;
+		while (my $part = shift @dirname) {
+			$dirprefix .= "/" if defined $dirprefix;
+			$dirprefix .= $part;
+			print $cgi->a({-href => href(project => undef,
+			                             project_filter => $dirprefix,
+			                             action=>"project_list")},
+			              esc_html($part)) . " / ";
+		}
+		print $cgi->a({-href => href(action=>"summary")}, esc_html($projectbasename));
 		if (defined $action) {
 			my $action_print = $action ;
 			if (defined $opts{-action_extra}) {
@@ -3854,6 +3865,16 @@ sub print_nav_breadcrumbs {
 			print " / $opts{-action_extra}";
 		}
 		print "\n";
+	} elsif (defined $project_filter) {
+		my @dirname = split '/', $project_filter;
+		my $dirprefix = undef;
+		while (my $part = shift @dirname) {
+			$dirprefix .= "/" if defined $dirprefix;
+			$dirprefix .= $part;
+			print $cgi->a({-href => href(project_filter => $dirprefix,
+			                             action=>"project_list")},
+			              esc_html($part)) . " / ";
+		}
 	}
 }
 
-- 
1.7.8.3
