From: Todd Zullinger <tmz@pobox.com>
Subject: [PATCH] Use &#160; instead of &nbsp; for XHTML compliance
Date: Wed, 15 Apr 2009 11:40:12 -0400
Message-ID: <20090415154012.GX13966@inocybe.teonanacatl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Ricky Zhou <ricky@fedoraproject.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 17:42:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu7FV-0003J8-QY
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 17:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbZDOPkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 11:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753855AbZDOPkY
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 11:40:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58867 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbZDOPkU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 11:40:20 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A43ABAA236;
	Wed, 15 Apr 2009 11:40:18 -0400 (EDT)
Received: from inocybe.teonanacatl.org (unknown [98.117.8.36]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5F7F6AA233; Wed,
 15 Apr 2009 11:40:14 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Pobox-Relay-ID: B902C1BE-29D3-11DE-895B-C121C5FC92D5-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116615>

From: Ricky Zhou <ricky@fedoraproject.org>
---

This was noticed by the Fedora Infrastructure folks.  The pages
rendered fine in Firefox, but caused an XML error when run through tor
and privoxy together.  Part of this problem description may belong in
the commit message -- I was hesitant to add it, as I didn't read all
of the IRC log where the problem was noticed and debugged.

 gitweb/gitweb.perl |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 33ef190..55b56f7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1042,8 +1042,8 @@ sub esc_html ($;%) {
 
 	$str = to_utf8($str);
 	$str = $cgi->escapeHTML($str);
-	if ($opts{'-nbsp'}) {
-		$str =~ s/ /&nbsp;/g;
+	if ($opts{'-subspaces'}) {
+		$str =~ s/ /&#160;/g;
 	}
 	$str =~ s|([[:cntrl:]])|(($1 ne "\t") ? quot_cec($1) : $1)|eg;
 	return $str;
@@ -1056,8 +1056,8 @@ sub esc_path {
 
 	$str = to_utf8($str);
 	$str = $cgi->escapeHTML($str);
-	if ($opts{'-nbsp'}) {
-		$str =~ s/ /&nbsp;/g;
+	if ($opts{'-subspaces'}) {
+		$str =~ s/ /&#160;/g;
 	}
 	$str =~ s|([[:cntrl:]])|quot_cec($1)|eg;
 	return $str;
@@ -1383,7 +1383,7 @@ sub file_type_long {
 sub format_log_line_html {
 	my $line = shift;
 
-	$line = esc_html($line, -nbsp=>1);
+	$line = esc_html($line, -subspaces=>1);
 	$line =~ s{\b([0-9a-fA-F]{8,40})\b}{
 		$cgi->a({-href => href(action=>"object", hash=>$1),
 					-class => "text"}, $1);
@@ -1710,7 +1710,7 @@ sub format_diff_line {
 			                     -class=>"list"}, $to_text);
 		}
 		$line = "<span class=\"chunk_info\">@@ $from_text $to_text @@</span>" .
-		        "<span class=\"section\">" . esc_html($section, -nbsp=>1) . "</span>";
+		        "<span class=\"section\">" . esc_html($section, -subspaces=>1) . "</span>";
 		return "<div class=\"diff$diff_class\">$line</div>\n";
 	} elsif ($from && $to && $line =~ m/^\@{3}/) {
 		my ($prefix, $ranges, $section) = $line =~ m/^(\@+) (.*?) \@+(.*)$/;
@@ -1743,10 +1743,10 @@ sub format_diff_line {
 			$line .= $to_text;
 		}
 		$line .= " $prefix</span>" .
-		         "<span class=\"section\">" . esc_html($section, -nbsp=>1) . "</span>";
+		         "<span class=\"section\">" . esc_html($section, -subspaces=>1) . "</span>";
 		return "<div class=\"diff$diff_class\">$line</div>\n";
 	}
-	return "<div class=\"diff$diff_class\">" . esc_html($line, -nbsp=>1) . "</div>\n";
+	return "<div class=\"diff$diff_class\">" . esc_html($line, -subspaces=>1) . "</div>\n";
 }
 
 # Generates undef or something like "_snapshot_" or "snapshot (_tbz2_ _zip_)",
@@ -2101,9 +2101,9 @@ sub git_populate_project_tagcloud {
 			# Pad the title with spaces so that the cloud looks
 			# less crammed.
 			my $title = $ctags_lc{$_}->{topname};
-			$title =~ s/ /&nbsp;/g;
-			$title =~ s/^/&nbsp;/g;
-			$title =~ s/$/&nbsp;/g;
+			$title =~ s/ /&#160;/g;
+			$title =~ s/^/&#160;/g;
+			$title =~ s/$/&#160;/g;
 			$cloud->add($title, $home_link."?by_tag=".$_, $ctags_lc{$_}->{count});
 		}
 	} else {
@@ -3535,7 +3535,7 @@ sub git_difftree_body {
 			               -title => 'commitdiff to parent number ' .
 			                          ($i+1) . ': ' . substr($par,0,7)},
 			              $i+1) .
-			      "&nbsp;</th>\n";
+			      "&#160;</th>\n";
 		}
 		print "</tr></thead>\n<tbody>\n";
 	}
@@ -4275,7 +4275,7 @@ sub git_tags_body {
 		if ($tag{'type'} eq "tag") {
 			print $cgi->a({-href => href(action=>"tag", hash=>$tag{'id'})}, "tag");
 		} else {
-			print "&nbsp;";
+			print "&#160;";
 		}
 		print "</td>\n" .
 		      "<td class=\"link\">" . " | " .
@@ -4491,7 +4491,7 @@ sub git_summary {
 	git_header_html();
 	git_print_page_nav('summary','', $head);
 
-	print "<div class=\"title\">&nbsp;</div>\n";
+	print "<div class=\"title\">&#160;</div>\n";
 	print "<table class=\"projects_list\">\n" .
 	      "<tr id=\"metadata_desc\"><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
 	      "<tr id=\"metadata_owner\"><td>owner</td><td>" . esc_html($owner) . "</td></tr>\n";
@@ -4602,7 +4602,7 @@ sub git_tag {
 	my $comment = $tag{'comment'};
 	foreach my $line (@$comment) {
 		chomp $line;
-		print esc_html($line, -nbsp=>1) . "<br/>\n";
+		print esc_html($line, -subspaces=>1) . "<br/>\n";
 	}
 	print "</div>\n";
 	git_footer_html();
@@ -4888,7 +4888,7 @@ sub git_blob {
 			$nr++;
 			$line = untabify($line);
 			printf "<div class=\"pre\"><a id=\"l%i\" href=\"#l%i\" class=\"linenr\">%4i</a> %s</div>\n",
-			       $nr, $nr, $nr, esc_html($line, -nbsp=>1);
+			       $nr, $nr, $nr, esc_html($line, -subspaces=>1);
 		}
 	}
 	close $fd
@@ -5913,13 +5913,13 @@ sub git_search {
 			} else {
 				$ltext = untabify($ltext);
 				if ($ltext =~ m/^(.*)($search_regexp)(.*)$/i) {
-					$ltext = esc_html($1, -nbsp=>1);
+					$ltext = esc_html($1, -subspaces=>1);
 					$ltext .= '<span class="match">';
-					$ltext .= esc_html($2, -nbsp=>1);
+					$ltext .= esc_html($2, -subspaces=>1);
 					$ltext .= '</span>';
-					$ltext .= esc_html($3, -nbsp=>1);
+					$ltext .= esc_html($3, -subspaces=>1);
 				} else {
-					$ltext = esc_html($ltext, -nbsp=>1);
+					$ltext = esc_html($ltext, -subspaces=>1);
 				}
 				print "<div class=\"pre\">" .
 					$cgi->a({-href => href(action=>"blob", hash=>$co{'hash'},
-- 
1.6.0.6

-- 
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
To have a successful relationship, I must learn to make it look like
I'm giving as much as I'm getting.
