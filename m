From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: [PATCH v6 5/6] gitweb: show active project_filter in project_list
 page header
Date: Mon, 30 Jan 2012 21:09:43 +0100
Message-ID: <20120130200943.GF2584@server.brlink.eu>
References: <20120128165606.GA6770@server.brlink.eu>
 <20120130095252.GA6183@server.brlink.eu>
 <20120130114557.GB9267@server.brlink.eu>
 <201201301657.12944.jnareb@gmail.com>
 <20120130200355.GA2584@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 21:09:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrxXk-0004KU-Pg
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 21:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408Ab2A3UJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 15:09:26 -0500
Received: from server.brlink.eu ([78.46.187.186]:54118 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055Ab2A3UJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 15:09:25 -0500
Received: from mfs.mathematik.uni-freiburg.de ([132.230.30.170] helo=client.brlink.eu)
	by server.brlink.eu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrxXY-0005w0-QL; Mon, 30 Jan 2012 21:09:24 +0100
Received: from brl by client.brlink.eu with local (Exim 4.77)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrxXr-0001CH-N2; Mon, 30 Jan 2012 21:09:43 +0100
Content-Disposition: inline
In-Reply-To: <20120130200355.GA2584@server.brlink.eu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189414>

In the page header of a project_list view with a project_filter
given show breadcrumbs in the page headers showing which directory
it is currently limited to and also containing links to the parent
directories.

Signed-off-by: Bernhard R. Link <brlink@debian.org>

---
Changes since v5:
	- improve description, better?
	- equalize whitespace
---
 gitweb/gitweb.perl |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9299504..27db84e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3841,6 +3841,18 @@ sub print_header_links {
 	}
 }
 
+sub print_nav_breadcrumbs_path {
+	my $dirprefix = undef;
+	while (my $part = shift) {
+		$dirprefix .= "/" if defined $dirprefix;
+		$dirprefix .= $part;
+		print $cgi->a({-href => href(project => undef,
+		                             project_filter => $dirprefix,
+		                             action => "project_list")},
+			      esc_html($part)) . " / ";
+	}
+}
+
 sub print_nav_breadcrumbs {
 	my %opts = @_;
 
@@ -3859,6 +3871,8 @@ sub print_nav_breadcrumbs {
 			print " / $opts{-action_extra}";
 		}
 		print "\n";
+	} elsif (defined $project_filter) {
+		print_nav_breadcrumbs_path(split '/', $project_filter);
 	}
 }
 
-- 
1.7.8.3
