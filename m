From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 15] gitweb: Headers refactoring - use git_header_div for header divs
Date: Sun, 30 Jul 2006 20:32:01 +0200
Message-ID: <200607302032.01623.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jul 30 20:32:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7G50-0003Rj-J4
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 20:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWG3Sbz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 14:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWG3Sbz
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 14:31:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:13706 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932418AbWG3Sby (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jul 2006 14:31:54 -0400
Received: by ug-out-1314.google.com with SMTP id m3so428688ugc
        for <git@vger.kernel.org>; Sun, 30 Jul 2006 11:31:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lCGKiKOCMEfGGJjZ4oFpWOfAU5ZYOhR9fnAb40jDibx7G9CGFOYfJKaLfpqWr4bX9N275tPJ44t97h2huSCrBOnHtTeI47IPfv5srxyDA/opZmnH2a0QFw8UV4uDn9qjC+gHYwyM6foWlQUZ7r8Fw9ruWb/z/AWFCGinu4gu6uU=
Received: by 10.66.220.17 with SMTP id s17mr1720327ugg;
        Sun, 30 Jul 2006 11:31:52 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id k2sm3072770ugf.2006.07.30.11.31.52;
        Sun, 30 Jul 2006 11:31:52 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24470>

Add git_header_div subroutine which prints "header" divs, now with
class "header" (class "title" is taken, and has set CSS style,
changing appereance and maing layout wrong), and use it thorough
gitweb.cgi.  Change header linking to project summary from empty
(&nbsp; as a contents of link) to having $project as contents/name
of link.  Sometimes a little reordering.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.cgi |  100 +++++++++++++++++++++--------------------------------
 1 files changed, 40 insertions(+), 60 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index bfb01de..06a6930 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -420,6 +420,19 @@ sub git_page_nav {
 	      "</div>\n";
 }
 
+sub git_header_div {
+	my ($action, $title, $hash, $hash_base) = @_;
+	my $rest = '';
+
+	$rest .= ";h=$hash" if $hash;
+	$rest .= ";hb=$hash_base" if $hash_base;
+
+	print "<div class=\"header\">\n" .
+	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$action$rest"),
+	               -class => "title"}, $title ? $title : $action) . "\n" .
+	      "</div>\n";
+}
+
 sub git_get_paging_nav {
 	my ($action, $hash, $head, $page, $nrevs) = @_;
 	my $paging_nav;
@@ -1123,9 +1136,7 @@ sub git_summary {
 		or die_error(undef, "Open git-rev-list failed.");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
-	print "<div>\n" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog"), -class => "title"}, "shortlog") .
-	      "</div>\n";
+	git_header_div('shortlog');
 	my $i = 16;
 	print "<table cellspacing=\"0\">\n";
 	my $alternate = 0;
@@ -1169,9 +1180,7 @@ sub git_summary {
 
 	my $taglist = git_read_refs("refs/tags");
 	if (defined @$taglist) {
-		print "<div>\n" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tags"), -class => "title"}, "tags") .
-		      "</div>\n";
+		git_header_div('tags');
 		my $i = 16;
 		print "<table cellspacing=\"0\">\n";
 		my $alternate = 0;
@@ -1221,9 +1230,7 @@ sub git_summary {
 
 	my $headlist = git_read_refs("refs/heads");
 	if (defined @$headlist) {
-		print "<div>\n" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=heads"), -class => "title"}, "heads") .
-		      "</div>\n";
+		git_header_div('heads');
 		my $i = 16;
 		print "<table cellspacing=\"0\">\n";
 		my $alternate = 0;
@@ -1276,9 +1283,7 @@ sub git_tag {
 	git_header_html();
 	git_page_nav('','', $head,undef,$head);
 	my %tag = git_read_tag($hash);
-	print "<div>\n" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash"), -class => "title"}, esc_html($tag{'name'})) . "\n" .
-	      "</div>\n";
+	git_header_div('commit', esc_html($tag{'name'}), $hash);
 	print "<div class=\"title_text\">\n" .
 	      "<table cellspacing=\"0\">\n" .
 	      "<tr>\n" .
@@ -1326,9 +1331,7 @@ sub git_blame2 {
 		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$hash;hb=$hash_base;f=$file_name")}, "blob") .
 		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;f=$file_name")}, "head");
 	git_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
-	print "<div>" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base"), -class => "title"}, esc_html($co{'title'})) .
-	      "</div>\n";
+	git_header_div('commit', esc_html($co{'title'}), $hash_base);
 	git_print_page_path($file_name, $ftype);
 	my @rev_color = (qw(light dark));
 	my $num_colors = scalar(@rev_color);
@@ -1382,9 +1385,7 @@ sub git_blame {
 		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$hash;hb=$hash_base;f=$file_name")}, "blob") .
 		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;f=$file_name")}, "head");
 	git_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
-	print "<div>" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base"), -class => "title"}, esc_html($co{'title'})) .
-	      "</div>\n";
+	git_header_div('commit', esc_html($co{'title'}), $hash_base);
 	git_print_page_path($file_name);
 	print "<div class=\"page_body\">\n";
 	print <<HTML;
@@ -1460,11 +1461,10 @@ sub git_tags {
 	my $head = git_read_head($project);
 	git_header_html();
 	git_page_nav('','', $head,undef,$head);
-	my $taglist = git_read_refs("refs/tags");
-	print "<div>\n" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary"), -class => "title"}, "&nbsp;") .
-	      "</div>\n";
+	git_header_div('summary', $project);
 	print "<table cellspacing=\"0\">\n";
+
+	my $taglist = git_read_refs("refs/tags");
 	my $alternate = 0;
 	if (defined @$taglist) {
 		foreach my $entry (@$taglist) {
@@ -1511,11 +1511,10 @@ sub git_heads {
 	my $head = git_read_head($project);
 	git_header_html();
 	git_page_nav('','', $head,undef,$head);
-	my $taglist = git_read_refs("refs/heads");
-	print "<div>\n" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary"), -class => "title"}, "&nbsp;") .
-	      "</div>\n";
+	hit_header_div('summary', $project);
 	print "<table cellspacing=\"0\">\n";
+
+	my $taglist = git_read_refs("refs/heads");
 	my $alternate = 0;
 	if (defined @$taglist) {
 		foreach my $entry (@$taglist) {
@@ -1684,9 +1683,7 @@ sub git_blob {
 			$formats_nav .= $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$hash")}, "plain");
 		}
 		git_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
-		print "<div>" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base"), -class => "title"}, esc_html($co{'title'})) .
-		      "</div>\n";
+		git_header_div('commit', esc_html($co{'title'}), $hash_base);
 	} else {
 		print "<div class=\"page_nav\">\n" .
 		      "<br/><br/></div>\n" .
@@ -1740,9 +1737,7 @@ sub git_tree {
 	if (defined $hash_base && (my %co = git_read_commit($hash_base))) {
 		$base_key = ";hb=$hash_base";
 		git_page_nav('tree','', $hash_base);
-		print "<div>\n" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base"), -class => "title"}, esc_html($co{'title'}) . $ref) . "\n" .
-		      "</div>\n";
+		git_header_div('commit', esc_html($co{'title'}) . $ref, $hash_base);
 	} else {
 		print "<div class=\"page_nav\">\n";
 		print "<br/><br/></div>\n";
@@ -1909,10 +1904,9 @@ sub git_log {
 	git_page_nav('log','', $hash,undef,undef, $paging_nav);
 
 	if (!@revlist) {
-		print "<div>\n" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary"), -class => "title"}, "&nbsp;") .
-		      "</div>\n";
 		my %co = git_read_commit($hash);
+
+		git_header_div('summary', $project);
 		print "<div class=\"page_body\"> Last change $co{'age_string'}.<br/><br/></div>\n";
 	}
 	for (my $i = ($page * 100); $i <= $#revlist; $i++) {
@@ -1924,10 +1918,10 @@ sub git_log {
 		my %co = git_read_commit($commit);
 		next if !%co;
 		my %ad = date_str($co{'author_epoch'});
-		print "<div>\n" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit"), -class => "title"},
-		      "<span class=\"age\">$co{'age_string'}</span>" . esc_html($co{'title'}) . $ref) . "\n";
-		print "</div>\n";
+		git_header_div('commit',
+									 "<span class=\"age\">$co{'age_string'}</span>" .
+									 esc_html($co{'title'}) . $ref,
+									 $commit);
 		print "<div class=\"title_text\">\n" .
 		      "<div class=\"log_link\">\n" .
 		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit")}, "commit") .
@@ -1999,13 +1993,9 @@ sub git_commit {
 							 $formats_nav);
 
 	if (defined $co{'parent'}) {
-		print "<div>\n" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$hash"), -class => "title"}, esc_html($co{'title'}) . $ref) . "\n" .
-		      "</div>\n";
+		git_header_div('commitdiff', esc_html($co{'title'}) . $ref, $hash);
 	} else {
-		print "<div>\n" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash"), -class => "title"}, esc_html($co{'title'})) . "\n" .
-		      "</div>\n";
+		git_header_div('tree', esc_html($co{'title'}), $co{'tree'}, $hash);
 	}
 	print "<div class=\"title_text\">\n" .
 	      "<table cellspacing=\"0\">\n";
@@ -2171,9 +2161,7 @@ sub git_blobdiff {
 		my $formats_nav = 
 			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blobdiff_plain;h=$hash;hp=$hash_parent")}, "plain");
 		git_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
-		print "<div>\n" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base"), -class => "title"}, esc_html($co{'title'})) . "\n" .
-		      "</div>\n";
+		git_header_div('commit', esc_html($co{'title'}), $hash_base);
 	} else {
 		print "<div class=\"page_nav\">\n" .
 		      "<br/><br/></div>\n" .
@@ -2225,9 +2213,7 @@ sub git_commitdiff {
 	my $formats_nav =
 		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff_plain;h=$hash;hp=$hash_parent")}, "plain");
 	git_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
-	print "<div>\n" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash"), -class => "title"}, esc_html($co{'title'}) . $ref) . "\n" .
-	      "</div>\n";
+	git_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
 	print "<div class=\"page_body\">\n";
 	my $comment = $co{'comment'};
 	my $empty = 0;
@@ -2357,9 +2343,7 @@ sub git_history {
 	my $refs = read_info_ref();
 	git_header_html();
 	git_page_nav('','', $hash_base,$co{'tree'},$hash_base);
-	print "<div>\n" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base"), -class => "title"}, esc_html($co{'title'})) . "\n" .
-	      "</div>\n";
+	git_header_div('commit', esc_html($co{'title'}), $hash_base);
 	if (!defined $hash && defined $file_name) {
 		$hash = git_get_hash_by_path($hash_base, $file_name);
 	}
@@ -2440,10 +2424,8 @@ sub git_search {
 	}
 	git_header_html();
 	git_page_nav('','', $hash,$co{'tree'},$hash);
+	git_header_div('commit', esc_html($co{'title'}), $hash);
 
-	print "<div>\n" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash"), -class => "title"}, esc_html($co{'title'})) . "\n" .
-	      "</div>\n";
 	print "<table cellspacing=\"0\">\n";
 	my $alternate = 0;
 	if ($commit_search) {
@@ -2570,10 +2552,8 @@ sub git_shortlog {
 
 	git_header_html();
 	git_page_nav('shortlog','', $hash,$hash,$hash, $paging_nav);
+	git_header_div('summary', $project);
 
-	print "<div>\n" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary"), -class => "title"}, "&nbsp;") .
-	      "</div>\n";
 	print "<table cellspacing=\"0\">\n";
 	my $alternate = 0;
 	for (my $i = ($page * 100); $i <= $#revlist; $i++) {
-- 
1.4.0
