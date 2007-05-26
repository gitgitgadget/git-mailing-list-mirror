From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] gitweb: Provide links to individual commitdiffs in difftree for merges
Date: Sun, 27 May 2007 01:50:22 +0200
Message-ID: <1180223422170-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 01:46:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs5xe-0006Bv-1j
	for gcvg-git@gmane.org; Sun, 27 May 2007 01:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbXEZXqF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 19:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbXEZXqF
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 19:46:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:3655 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbXEZXqC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 19:46:02 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1384471ugf
        for <git@vger.kernel.org>; Sat, 26 May 2007 16:46:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=rXk4FvlND36nK63AykWbtLJBYogySY39UAilgJjPNgsLh2CylPnCNxre02vPIUvJwOvgeLEs95+eMzRxvh0LZQoOcuUQ9GRXoh4eWU02yczZEI2tXeZ+S+TZJdfhAduA3/wJKLDPCo1oXrySqXltU6f1u+ceQM5Ai6rl67hCGUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=fa3N8m4GEC5CeP4cBpXFyDp0jdW1ZRsj0CdeRVY1MxNnQhLSxJXTfz6d8x8ZchaPAvprMS8MRu4LkNUOl5q1Skl0EDVZ5OkIAZV7dvc+MdbO3snS8CRwf6Uvo+Pqb7toh9z4qmUimKSN3XNm1Q4rt3GE5QIpx+Tu6K4RbvPQoW4=
Received: by 10.67.89.5 with SMTP id r5mr4036323ugl.1180223161551;
        Sat, 26 May 2007 16:46:01 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id j9sm20666304mue.2007.05.26.16.45.18;
        Sat, 26 May 2007 16:45:18 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l4QNoN0v030228;
	Sun, 27 May 2007 01:50:23 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l4QNoMss030227;
	Sun, 27 May 2007 01:50:22 +0200
X-Mailer: git-send-email 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48507>

Add to difftree / whatchanged table row with "1", "2", ... links to
'commitdiff' view for diff with n-th parent for merge commits, as a
table header.  This is visible in 'commit' and 'comitdiff' views.  It
is more important for 'commitdiff' view, as in 'commit' view commit
object header has 'diff' links to diff to n-th parent.

To save space links are shown as "n", where "n" is number of a parent,
and not as for example shortened (to 7 characters) sha1 of a parent
commit.  To make it easier to doscover what links is for, encompassing
<th> element has 'title' attribute explaining the link.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is my proposal on how to provide links to diffs to individual
parents in the 'commitdiff' view.  This is RFC: please comment if you
like the idea (or not), and what the layout should be, what this
should look like.  Should we add those links only for 'commitdiff'
view, for example?

Some complications in creating layout stem from the fact that "|" is
used as separator, instead of using table border, or cell borders to
separate columns. And we use "|" because in most other places we use
only one cell (column) for the whole series of links.

 gitweb/gitweb.css  |    5 +++++
 gitweb/gitweb.perl |   19 +++++++++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 9f0822f..7908fe3 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -181,10 +181,15 @@ table.diff_tree {
 	font-family: monospace;
 }
 
+table.combined.diff_tree th {
+	text-align: center;
+}
+
 table.combined.diff_tree td {
 	padding-right: 24px;
 }
 
+table.combined.diff_tree th.link,
 table.combined.diff_tree td.link {
 	padding: 0px 2px;
 }
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c3921cb..999353d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2380,6 +2380,25 @@ sub git_difftree_body {
 	print "<table class=\"" .
 	      (@parents > 1 ? "combined " : "") .
 	      "diff_tree\">\n";
+
+	if (@parents > 1) { #combined diff
+		# table header for combined diff
+		print "<tr>\n" .
+		      ($action eq 'commitdiff' ? "<th></th><th></th>\n"
+		                               : "<th></th>\n");
+		for (my $i = 0; $i < @parents; $i++) {
+			my $par = $parents[$i];
+			print "<th title=\"commitdiff to parent number " .
+			      ($i+1) . ": " .
+			      substr($par,0,7) . "\">" .
+			      $cgi->a({-href => href(action=>"commitdiff",
+			                             hash=>$hash, hash_parent=>$par)},
+			              $i+1) .
+			      "&nbsp;</th>\n";
+		}
+		print "</tr>\n";
+	}
+
 	my $alternate = 1;
 	my $patchno = 0;
 	foreach my $line (@{$difftree}) {
-- 
1.5.2
