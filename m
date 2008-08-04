From: warthog19@eaglescrag.net
Subject: [PATCH 1/1] Add "git" link to the end of project line on the project_list page.
Date: Sun,  3 Aug 2008 19:00:17 -0700
Message-ID: <1217815217-11329-2-git-send-email-warthog19@eaglescrag.net>
References: <1217815217-11329-1-git-send-email-warthog19@eaglescrag.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.5.4.1"
Cc: "John 'Warthog9' Hawley" <warthog19@eaglescrag.net>,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 04:13:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPpa1-00079j-5o
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 04:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbYHDCMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 22:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753977AbYHDCMl
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 22:12:41 -0400
Received: from c-67-188-226-86.hsd1.ca.comcast.net ([67.188.226.86]:53308 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754023AbYHDCMj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 22:12:39 -0400
X-Greylist: delayed 695 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Aug 2008 22:12:38 EDT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.14.2/8.14.2) with ESMTP id m7420JkZ011364;
	Sun, 3 Aug 2008 19:00:19 -0700
Received: (from warthog9@localhost)
	by localhost.localdomain (8.14.2/8.14.2/Submit) id m7420JGh011363;
	Sun, 3 Aug 2008 19:00:19 -0700
X-Authentication-Warning: localhost.localdomain: warthog9 set sender to warthog19@eaglescrag.net using -f
X-Mailer: git-send-email 1.5.4.1
In-Reply-To: <1217815217-11329-1-git-send-email-warthog19@eaglescrag.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91305>

From: John 'Warthog9' Hawley <warthog19@eaglescrag.net>

This is a multi-part message in MIME format.
--------------1.5.4.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


This makes the assumption that all repositories are available from a unified location.

Using .git/cloneurl is actually a problem as that can define multiple URLs to clone from, and we are seeking a single unified URL for now.

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
---
 gitweb/gitweb.perl |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)
--------------1.5.4.1
Content-Type: text/x-patch; name="07ce8f81cc06027c9c166cf316238d7a4af17162.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="07ce8f81cc06027c9c166cf316238d7a4af17162.diff"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 90cd99b..c33f4ed 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -108,6 +108,14 @@ our $mimetypes_file = undef;
 # could be even 'utf-8' for the old behavior)
 our $fallback_encoding = 'latin1';
 
+# enable / disable a final link on the project list page
+# that will be the location of that actuall git url
+# it will output this in the format:
+# git://hostname/path/to/tree.git
+# disabled = blank or undef
+# enable = url to prefix before filling in the trailing path to the git repo
+our $projectlist_gitlinkurl = undef;
+
 # rename detection options for git-diff and git-diff-tree
 # - default is '-M', with the cost proportional to
 #   (number of removed files) * (number of new files).
@@ -3661,8 +3669,11 @@ sub git_project_list_body {
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"shortlog")}, "shortlog") . " | " .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") . " | " .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"tree")}, "tree") .
-		      ($pr->{'forks'} ? " | " . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "forks") : '') .
-		      "</td>\n" .
+		      ($pr->{'forks'} ? " | " . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "forks") : '');
+		if( $projectlist_gitlinkurl != undef && $projectlist_gitlinkurl ne "" ){
+                        print " | ". $cgi->a({-href => "git://projectlist_gitlinkurl/".esc_html($pr->{'path'})}, "git");
+		}
+		print "</td>\n" .
 		      "</tr>\n";
 	}
 	if (defined $extra) {

--------------1.5.4.1--
