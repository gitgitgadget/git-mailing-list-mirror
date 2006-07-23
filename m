From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH 1/4] gitweb.cgi: Teach git_history() to read hash from $hash_base
Date: Sun, 23 Jul 2006 13:26:30 -0700 (PDT)
Message-ID: <20060723202630.9322.qmail@web31806.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-77798904-1153686390=:7670"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Jul 23 22:27:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4kX6-0007E1-Cj
	for gcvg-git@gmane.org; Sun, 23 Jul 2006 22:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWGWU0c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Jul 2006 16:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWGWU0c
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Jul 2006 16:26:32 -0400
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:7512 "HELO
	web31806.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751296AbWGWU0b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jul 2006 16:26:31 -0400
Received: (qmail 9324 invoked by uid 60001); 23 Jul 2006 20:26:30 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=KvEhKdQVf1rqMtSV7J8EJznbkoyOOt4WOHhGOhAkIRabY1OHnZykWPFoahvzVQZS6p6WvWdLdbj1SZ110wDLg4Lkxkqaz63p66ObjM/sPoL5ni4GMgn1jH5c3s7gR1ojnwZT/o70HQsdT/GwOI9sB0XsK0qe0Sv7oSrsyy9ZHL4=  ;
Received: from [71.80.232.189] by web31806.mail.mud.yahoo.com via HTTP; Sun, 23 Jul 2006 13:26:30 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24100>

--0-77798904-1153686390=:7670
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Teach git_history() to take its hash argument from
the hb parameter, i.e. from $hash_base.  Also change
all "a=history" actions to pass "hb=" instead of "h=".

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.cgi |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)
--0-77798904-1153686390=:7670
Content-Type: text/inline; name="p1.patch"
Content-Description: 2795696785-p1.patch
Content-Disposition: name="p1.patch"; filename="p1.patch"

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 2fd1e5f..d976d4a 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -1687,7 +1687,7 @@ sub git_tree {
 			      "<td class=\"link\">" .
 			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$t_hash$base_key;f=$base$t_name")}, "blob") .
 #			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;h=$t_hash$base_key;f=$base$t_name")}, "blame") .
-			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=history;h=$hash_base;f=$base$t_name")}, "history") .
+			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=history;hb=$hash_base;f=$base$t_name")}, "history") .
 			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$t_hash;f=$base$t_name")}, "raw") .
 			      "</td>\n";
 		} elsif ($t_type eq "tree") {
@@ -1696,7 +1696,7 @@ #			      " | " . $cgi->a({-href => "$my
 			      "</td>\n" .
 			      "<td class=\"link\">" .
 			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$t_hash$base_key;f=$base$t_name")}, "tree") .
-			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=history;h=$hash_base;f=$base$t_name")}, "history") .
+			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=history;hb=$hash_base;f=$base$t_name")}, "history") .
 			      "</td>\n";
 		}
 		print "</tr>\n";
@@ -2041,7 +2041,7 @@ sub git_commit {
 			      "<td><span class=\"file_status deleted\">[deleted " . file_type($from_mode). "]</span></td>\n" .
 			      "<td class=\"link\">" .
 			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$from_id;hb=$hash;f=$file")}, "blob") .
-			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=history;h=$hash;f=$file")}, "history") .
+			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=history;hb=$hash;f=$file")}, "history") .
 			      "</td>\n"
 		} elsif ($status eq "M" || $status eq "T") {
 			my $mode_chnge = "";
@@ -2072,7 +2072,7 @@ sub git_commit {
 			if ($to_id ne $from_id) {
 				print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blobdiff;h=$to_id;hp=$from_id;hb=$hash;f=$file")}, "diff");
 			}
-			print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=history;h=$hash;f=$file")}, "history") . "\n";
+			print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=history;hb=$hash;f=$file")}, "history") . "\n";
 			print "</td>\n";
 		} elsif ($status eq "R") {
 			my ($from_file, $to_file) = split "\t", $file;
@@ -2293,10 +2293,10 @@ sub git_commitdiff_plain {
 }
 
 sub git_history {
-	if (!defined $hash) {
-		$hash = git_read_head($project);
+	if (!defined $hash_base) {
+		$hash_base = git_read_head($project);
 	}
-	my %co = git_read_commit($hash);
+	my %co = git_read_commit($hash_base);
 	if (!%co) {
 		die_error(undef, "Unknown commit object.");
 	}
@@ -2306,18 +2306,18 @@ sub git_history {
 	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, "summary") .
 	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog")}, "shortlog") .
 	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log")}, "log") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash")}, "commit") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$hash")}, "commitdiff") .
-	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash")}, "tree") .
+	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base")}, "commit") .
+	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$hash_base")}, "commitdiff") .
+	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash_base")}, "tree") .
 	      "<br/><br/>\n" .
 	      "</div>\n";
 	print "<div>\n" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash"), -class => "title"}, esc_html($co{'title'})) . "\n" .
+	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base"), -class => "title"}, esc_html($co{'title'})) . "\n" .
 	      "</div>\n";
 	print "<div class=\"page_path\"><b>/" . esc_html($file_name) . "</b><br/></div>\n";
 
 	open my $fd, "-|",
-		"$GIT rev-list --full-history $hash -- \'$file_name\'";
+		"$GIT rev-list --full-history $hash_base -- \'$file_name\'";
 	print "<table cellspacing=\"0\">\n";
 	my $alternate = 0;
 	while (my $line = <$fd>) {
@@ -2345,8 +2345,7 @@ sub git_history {
 			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit")}, "commit") .
 			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$commit")}, "commitdiff") .
 			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;hb=$commit;f=$file_name")}, "blob");
-			my $blob = git_get_hash_by_path($hash, $file_name);
+			my $blob = git_get_hash_by_path($hash_base, $file_name);
 			my $blob_parent = git_get_hash_by_path($commit, $file_name);
 			if (defined $blob && defined $blob_parent && $blob ne $blob_parent) {
 				print " | " .
-- 
1.4.2.rc1.g9b54


--0-77798904-1153686390=:7670--
