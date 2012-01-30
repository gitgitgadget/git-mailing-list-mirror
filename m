From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: [PATCH v5 4/5] gitweb: show active project_filter in project_list
 page header
Date: Mon, 30 Jan 2012 12:48:52 +0100
Message-ID: <20120130114852.GD9267@server.brlink.eu>
References: <20120128165606.GA6770@server.brlink.eu>
 <m3wr8bcuon.fsf@localhost.localdomain>
 <20120129012234.GD16079@server.brlink.eu>
 <201201291354.50241.jnareb@gmail.com>
 <20120129160615.GA13937@server.brlink.eu>
 <7v7h0afcc2.fsf@alter.siamese.dyndns.org>
 <20120130095252.GA6183@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 12:48:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrpj2-00010y-P3
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 12:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590Ab2A3Lsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 06:48:36 -0500
Received: from server.brlink.eu ([78.46.187.186]:54094 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752443Ab2A3Lsf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 06:48:35 -0500
Received: from mfs.mathematik.uni-freiburg.de ([132.230.30.170] helo=client.brlink.eu)
	by server.brlink.eu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@mail.brlink.eu>)
	id 1Rrpiq-0005eA-RF; Mon, 30 Jan 2012 12:48:32 +0100
Received: from brl by client.brlink.eu with local (Exim 4.77)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrpjA-0002Q8-6a; Mon, 30 Jan 2012 12:48:52 +0100
Content-Disposition: inline
In-Reply-To: <20120130095252.GA6183@server.brlink.eu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189352>

In a project_list view show breadcrumbs with the currently active
project_filter (and those of parent directories) in the page header.

Signed-off-by: Bernhard R. Link <brlink@debian.org>
---
 gitweb/gitweb.perl |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e022e11..dfc79df 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3836,6 +3836,18 @@ sub print_header_links {
 	}
 }
 
+sub print_nav_breadcrumbs_path {
+	my $dirprefix = undef;
+	while (my $part = shift) {
+		$dirprefix .= "/" if defined $dirprefix;
+		$dirprefix .= $part;
+		print $cgi->a({-href => href(project => undef,
+		                             project_filter => $dirprefix,
+					     action=>"project_list")},
+			      esc_html($part)) . " / ";
+	}
+}
+
 sub print_nav_breadcrumbs {
 	my %opts = @_;
 
@@ -3854,6 +3866,8 @@ sub print_nav_breadcrumbs {
 			print " / $opts{-action_extra}";
 		}
 		print "\n";
+	} elsif (defined $project_filter) {
+		print_nav_breadcrumbs_path(split '/', $project_filter);
 	}
 }
 
-- 
1.7.8.3
