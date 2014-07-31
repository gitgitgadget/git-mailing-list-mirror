From: Tony Finch <dot@dotat.at>
Subject: [PATCH 5/5] gitweb: make category headings into links when they are
 directories
Date: Thu, 31 Jul 2014 13:53:54 +0100
Message-ID: <alpine.LSU.2.00.1407311353520.23775@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 14:54:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCprv-0007I7-7t
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 14:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbaGaMx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 08:53:56 -0400
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:57672 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaGaMxz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 08:53:55 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:43456)
	by ppsw-50.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:25)
	with esmtpa (EXTERNAL:fanf2) id 1XCprm-0005Xp-rD (Exim 4.82_3-c0e5623) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 31 Jul 2014 13:53:54 +0100
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1XCprm-0005l4-Em (Exim 4.72) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 31 Jul 2014 13:53:54 +0100
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254569>

When $projects_list_category_is_directory is turned on, project
categories can be useful as project filters, so with that setting
gitweb now makes the category headings into project_filter links
(like the breadcrumbs).

Signed-off-by: Tony Finch <dot@dotat.at>
---
 gitweb/gitweb.perl | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index edbc058..32e65ae 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5834,8 +5834,18 @@ sub git_project_list_body {
 				if ($check_forks) {
 					print "<td></td>\n";
 				}
-				print "<td class=\"category\" colspan=\"5\">".esc_html($cat)."</td>\n";
-				print "</tr>\n";
+				print "<td class=\"category\" colspan=\"5\">";
+				if ($projects_list_directory_is_category) {
+					print $cgi->a({-href =>
+					    href(project => undef,
+					        project_filter => $cat,
+					        action => "project_list"),
+					    -class => "list"},
+					    esc_html($cat));
+				} else {
+					print esc_html($cat);
+				}
+				print "</td>\n</tr>\n";
 			}

 			git_project_list_rows($categories{$cat}, undef, undef, $check_forks);
-- 
2.1.0.rc0.229.gaee38de
