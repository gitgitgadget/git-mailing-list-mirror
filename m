From: Tony Finch <dot@dotat.at>
Subject: [PATCH 5/5] gitweb: make category headings into links when they are
 directories
Date: Thu, 19 Mar 2015 15:40:19 +0000
Message-ID: <alpine.LSU.2.00.1503191540020.23307@hermes-1.csi.cam.ac.uk>
References: <5e56772f50d3d1498361d8831c4f2fba38d197b4.1426779553.git.dot@dotat.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 16:50:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYchy-0001E6-U4
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 16:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbbCSPt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 11:49:59 -0400
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:45712 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbbCSPt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 11:49:56 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:39695)
	by ppsw-52.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpa (EXTERNAL:fanf2) id 1YYcYV-0002NO-Fh (Exim 4.82_3-c0e5623) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 19 Mar 2015 15:40:19 +0000
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1YYcYV-0007yr-Q3 (Exim 4.72) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 19 Mar 2015 15:40:19 +0000
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
In-Reply-To: <5e56772f50d3d1498361d8831c4f2fba38d197b4.1426779553.git.dot@dotat.at>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265808>

When $projects_list_category_is_directory is turned on, project
categories can be useful as project filters, so with that setting
gitweb now makes the category headings into project_filter links
(like the breadcrumbs).

Signed-off-by: Tony Finch <dot@dotat.at>
---
 gitweb/gitweb.perl | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0aab3e0..a02f3e4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5838,8 +5838,18 @@ sub git_project_list_body {
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
2.2.1.68.g56d9796
