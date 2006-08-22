From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] gitweb: Whitespace cleanup: realign, reindent
Date: Tue, 22 Aug 2006 16:52:50 +0200
Message-ID: <200608221652.50443.jnareb@gmail.com>
References: <200608221651.19629.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 22 17:00:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFXjG-0006mJ-Oy
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 16:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWHVO7i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 10:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWHVO7i
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 10:59:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:11134 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932287AbWHVO7g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 10:59:36 -0400
Received: by nf-out-0910.google.com with SMTP id o25so78030nfa
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 07:59:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bufyVOhxUl+mdTBL9uPItTRufN7m38L+1NdXtdL6iQQWEa9JWVpZB6SlkIJEZGD2LG7vzlluHEZKLeDAVEdoXbV0cVti+q1fkRhrSCtsegxSPiv5h4vIMKRyVV9YMFQIaGc/PyLQEX66Ls8IXJF5/rELr5cYxaZ2aeiIkX1Ww24=
Received: by 10.48.14.4 with SMTP id 4mr544664nfn;
        Tue, 22 Aug 2006 07:59:35 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id o9sm639373nfa.2006.08.22.07.59.33;
        Tue, 22 Aug 2006 07:59:35 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608221651.19629.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25856>

This patch tries (but no too hard) to fit gitweb source in 80 columns,
for 2 columns wide tabs, and indent and align source for better
readibility.

While at it added comment to 'snapshot' entry defaults for %feature
hash, corrected "blobl" action in git_blame2 and git_blame to "blob",
key of argument to $cgi->a from 'class' to '-class'.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Quite a large patch, but it doesn't change much.

 gitweb/gitweb.perl |  257 ++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 178 insertions(+), 79 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 607b8b7..182fe33 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -69,22 +69,30 @@ our $mimetypes_file = undef;
 
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
-our %feature =
-(
-
-# feature  => {'sub' => feature-sub, 'override' => allow-override, 'default' => [ default options...]
-
-'blame'         => {'sub' => \&feature_blame, 'override' => 0, 'default' => [0]},
-'snapshot'      => {'sub' => \&feature_snapshot, 'override' => 0, 'default' => ['x-gzip', 'gz', 'gzip']},
-
+our %feature = (
+	# feature => {'sub' => feature-sub, 'override' => allow-override, 'default' => [ default options...]
+	# if feature is overridable, feature-sub will be called with default options;
+	# return value indicates if to enable specified feature
+
+	'blame' => {
+		'sub' => \&feature_blame,
+		'override' => 0,
+		'default' => [0]},
+
+	'snapshot' => {
+		'sub' => \&feature_snapshot,
+		'override' => 0,
+		#         => [content-encoding, suffix, program]
+		'default' => ['x-gzip', 'gz', 'gzip']},
 );
 
 sub gitweb_check_feature {
 	my ($name) = @_;
 	return undef unless exists $feature{$name};
-	my ($sub, $override, @defaults) = ($feature{$name}{'sub'},
-						$feature{$name}{'override'},
-						@{$feature{$name}{'default'}});
+	my ($sub, $override, @defaults) = (
+		$feature{$name}{'sub'},
+		$feature{$name}{'override'},
+		@{$feature{$name}{'default'}});
 	if (!$override) { return @defaults; }
 	return $sub->(@defaults);
 }
@@ -463,7 +471,9 @@ sub format_log_line_html {
 	if ($line =~ m/([0-9a-fA-F]{40})/) {
 		my $hash_text = $1;
 		if (git_get_type($hash_text) eq "commit") {
-			my $link = $cgi->a({-class => "text", -href => href(action=>"commit", hash=>$hash_text)}, $hash_text);
+			my $link =
+				$cgi->a({-href => href(action=>"commit", hash=>$hash_text),
+				        -class => "text"}, $hash_text);
 			$line =~ s/$hash_text/$link/;
 		}
 	}
@@ -734,8 +744,10 @@ sub parse_date {
 	$date{'mday'} = $mday;
 	$date{'day'} = $days[$wday];
 	$date{'month'} = $months[$mon];
-	$date{'rfc2822'} = sprintf "%s, %d %s %4d %02d:%02d:%02d +0000", $days[$wday], $mday, $months[$mon], 1900+$year, $hour ,$min, $sec;
-	$date{'mday-time'} = sprintf "%d %s %02d:%02d", $mday, $months[$mon], $hour ,$min;
+	$date{'rfc2822'} = sprintf "%s, %d %s %4d %02d:%02d:%02d +0000",
+	                   $days[$wday], $mday, $months[$mon], 1900+$year, $hour ,$min, $sec;
+	$date{'mday-time'} = sprintf "%d %s %02d:%02d",
+	                     $mday, $months[$mon], $hour ,$min;
 
 	$tz =~ m/^([+\-][0-9][0-9])([0-9][0-9])$/;
 	my $local = $epoch + ((int $1 + ($2/60)) * 3600);
@@ -792,7 +804,8 @@ sub parse_commit {
 		@commit_lines = @$commit_text;
 	} else {
 		$/ = "\0";
-		open my $fd, "-|", $GIT, "rev-list", "--header", "--parents", "--max-count=1", $commit_id or return;
+		open my $fd, "-|", $GIT, "rev-list", "--header", "--parents", "--max-count=1", $commit_id
+			or return;
 		@commit_lines = split '\n', <$fd>;
 		close $fd or return;
 		$/ = "\n";
@@ -1086,12 +1099,15 @@ sub git_header_html {
 	# 'application/xhtml+xml', otherwise send it as plain old 'text/html'.
 	# we have to do this because MSIE sometimes globs '*/*', pretending to
 	# support xhtml+xml but choking when it gets what it asked for.
-	if (defined $cgi->http('HTTP_ACCEPT') && $cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ && $cgi->Accept('application/xhtml+xml') != 0) {
+	if (defined $cgi->http('HTTP_ACCEPT') &&
+	    $cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ &&
+	    $cgi->Accept('application/xhtml+xml') != 0) {
 		$content_type = 'application/xhtml+xml';
 	} else {
 		$content_type = 'text/html';
 	}
-	print $cgi->header(-type=>$content_type, -charset => 'utf-8', -status=> $status, -expires => $expires);
+	print $cgi->header(-type=>$content_type, -charset => 'utf-8',
+	                   -status=> $status, -expires => $expires);
 	print <<EOF;
 <?xml version="1.0" encoding="utf-8"?>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
@@ -1271,9 +1287,12 @@ sub git_print_page_path {
 	} elsif (defined $type && $type eq 'blob') {
 		print "<div class=\"page_path\">";
 		if (defined $hb) {
-			print $cgi->a({-href => href(action=>"blob_plain", hash_base=>$hb, file_name=>$file_name)}, esc_html($name));
+			print $cgi->a({-href => href(action=>"blob_plain", file_name=>$file_name,
+			                             hash_base=>$hb)},
+			              esc_html($name));
 		} else {
-			print $cgi->a({-href => href(action=>"blob_plain", file_name=>$file_name)}, esc_html($name));
+			print $cgi->a({-href => href(action=>"blob_plain", file_name=>$file_name)},
+			              esc_html($name));
 		}
 		print "<br/></div>\n";
 	} else {
@@ -1523,7 +1542,8 @@ sub git_shortlog_body {
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
 		      "<td><i>" . esc_html(chop_str($co{'author_name'}, 10)) . "</i></td>\n" .
 		      "<td>";
-		print format_subject_html($co{'title'}, $co{'title_short'}, href(action=>"commit", hash=>$commit), $ref);
+		print format_subject_html($co{'title'}, $co{'title_short'},
+		                          href(action=>"commit", hash=>$commit), $ref);
 		print "</td>\n" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") . " | " .
@@ -1576,7 +1596,8 @@ sub git_history_body {
 		      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 3)) . "</i></td>\n" .
 		      "<td>";
 		# originally git_history used chop_str($co{'title'}, 50)
-		print format_subject_html($co{'title'}, $co{'title_short'}, href(action=>"commit", hash=>$commit), $ref);
+		print format_subject_html($co{'title'}, $co{'title_short'},
+		                          href(action=>"commit", hash=>$commit), $ref);
 		print "</td>\n" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") . " | " .
@@ -1589,7 +1610,8 @@ sub git_history_body {
 			if (defined $blob_current && defined $blob_parent &&
 					$blob_current ne $blob_parent) {
 				print " | " .
-					$cgi->a({-href => href(action=>"blobdiff", hash=>$blob_current, hash_parent=>$blob_parent, hash_base=>$commit, file_name=>$file_name)},
+					$cgi->a({-href => href(action=>"blobdiff", hash=>$blob_current, hash_parent=>$blob_parent,
+					                       hash_base=>$commit, file_name=>$file_name)},
 					        "diff to current");
 			}
 		}
@@ -1634,7 +1656,8 @@ sub git_tags_body {
 		      "</td>\n" .
 		      "<td>";
 		if (defined $comment) {
-			print format_subject_html($comment, $comment_short, href(action=>"tag", hash=>$tag{'id'}));
+			print format_subject_html($comment, $comment_short,
+			                          href(action=>"tag", hash=>$tag{'id'}));
 		}
 		print "</td>\n" .
 		      "<td class=\"selflink\">";
@@ -1945,13 +1968,17 @@ sub git_tag {
 	      "<table cellspacing=\"0\">\n" .
 	      "<tr>\n" .
 	      "<td>object</td>\n" .
-	      "<td>" . $cgi->a({-class => "list", -href => href(action=>$tag{'type'}, hash=>$tag{'object'})}, $tag{'object'}) . "</td>\n" .
-	      "<td class=\"link\">" . $cgi->a({-href => href(action=>$tag{'type'}, hash=>$tag{'object'})}, $tag{'type'}) . "</td>\n" .
+	      "<td>" . $cgi->a({-class => "list", -href => href(action=>$tag{'type'}, hash=>$tag{'object'})},
+	                       $tag{'object'}) . "</td>\n" .
+	      "<td class=\"link\">" . $cgi->a({-href => href(action=>$tag{'type'}, hash=>$tag{'object'})},
+	                                      $tag{'type'}) . "</td>\n" .
 	      "</tr>\n";
 	if (defined($tag{'author'})) {
 		my %ad = parse_date($tag{'epoch'}, $tag{'tz'});
 		print "<tr><td>author</td><td>" . esc_html($tag{'author'}) . "</td></tr>\n";
-		print "<tr><td></td><td>" . $ad{'rfc2822'} . sprintf(" (%02d:%02d %s)", $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'}) . "</td></tr>\n";
+		print "<tr><td></td><td>" . $ad{'rfc2822'} .
+			sprintf(" (%02d:%02d %s)", $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'}) .
+			"</td></tr>\n";
 	}
 	print "</table>\n\n" .
 	      "</div>\n";
@@ -1988,8 +2015,11 @@ sub git_blame2 {
 		or die_error(undef, "Open git-blame failed");
 	git_header_html();
 	my $formats_nav =
-		$cgi->a({-href => href(action=>"blobl", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)}, "blob") .
-		" | " . $cgi->a({-href => href(action=>"blame", file_name=>$file_name)}, "head");
+		$cgi->a({-href => href(action=>"blob", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
+		        "blob") .
+		" | " .
+		$cgi->a({-href => href(action=>"blame", file_name=>$file_name)},
+		        "head");
 	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	git_print_page_path($file_name, $ftype, $hash_base);
@@ -2015,14 +2045,17 @@ sub git_blame2 {
 		}
 		print "<tr class=\"$rev_color[$current_color]\">\n";
 		print "<td class=\"sha1\">" .
-			$cgi->a({-href => href(action=>"commit", hash=>$full_rev, file_name=>$file_name)}, esc_html($rev)) . "</td>\n";
-		print "<td class=\"linenr\"><a id=\"l$lineno\" href=\"#l$lineno\" class=\"linenr\">" . esc_html($lineno) . "</a></td>\n";
+			$cgi->a({-href => href(action=>"commit", hash=>$full_rev, file_name=>$file_name)},
+			        esc_html($rev)) . "</td>\n";
+		print "<td class=\"linenr\"><a id=\"l$lineno\" href=\"#l$lineno\" class=\"linenr\">" .
+		      esc_html($lineno) . "</a></td>\n";
 		print "<td class=\"pre\">" . esc_html($data) . "</td>\n";
 		print "</tr>\n";
 	}
 	print "</table>\n";
 	print "</div>";
-	close $fd or print "Reading blob failed\n";
+	close $fd
+		or print "Reading blob failed\n";
 	git_footer_html();
 }
 
@@ -2045,8 +2078,11 @@ sub git_blame {
 		or die_error(undef, "Open git-annotate failed");
 	git_header_html();
 	my $formats_nav =
-		$cgi->a({-href => href(action=>"blobl", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)}, "blob") .
-		" | " . $cgi->a({-href => href(action=>"blame", file_name=>$file_name)}, "head");
+		$cgi->a({-href => href(action=>"blob", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
+		        "blob") .
+		" | " .
+		$cgi->a({-href => href(action=>"blame", file_name=>$file_name)},
+		        "head");
 	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	git_print_page_path($file_name, 'blob', $hash_base);
@@ -2110,7 +2146,8 @@ HTML
 HTML
 	} # while (my $line = <$fd>)
 	print "</table>\n\n";
-	close $fd or print "Reading blob failed.\n";
+	close $fd 
+		or print "Reading blob failed.\n";
 	print "</div>";
 	git_footer_html();
 }
@@ -2197,13 +2234,23 @@ sub git_blob {
 	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 		if (defined $file_name) {
 			if ($have_blame) {
-				$formats_nav .= $cgi->a({-href => href(action=>"blame", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)}, "blame") . " | ";
+				$formats_nav .=
+					$cgi->a({-href => href(action=>"blame", hash_base=>$hash_base,
+					                       hash=>$hash, file_name=>$file_name)},
+					        "blame") .
+					" | ";
 			}
 			$formats_nav .=
-				$cgi->a({-href => href(action=>"blob_plain", hash=>$hash, file_name=>$file_name)}, "plain") .
-				" | " . $cgi->a({-href => href(action=>"blob", hash_base=>"HEAD", file_name=>$file_name)}, "head");
+				$cgi->a({-href => href(action=>"blob_plain",
+				                       hash=>$hash, file_name=>$file_name)},
+				        "plain") .
+				" | " .
+				$cgi->a({-href => href(action=>"blob",
+				                       hash_base=>"HEAD", file_name=>$file_name)},
+				        "head");
 		} else {
-			$formats_nav .= $cgi->a({-href => href(action=>"blob_plain", hash=>$hash)}, "plain");
+			$formats_nav .=
+				$cgi->a({-href => href(action=>"blob_plain", hash=>$hash)}, "plain");
 		}
 		git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
@@ -2219,9 +2266,11 @@ sub git_blob {
 		chomp $line;
 		$nr++;
 		$line = untabify($line);
-		printf "<div class=\"pre\"><a id=\"l%i\" href=\"#l%i\" class=\"linenr\">%4i</a> %s</div>\n", $nr, $nr, $nr, esc_html($line);
+		printf "<div class=\"pre\"><a id=\"l%i\" href=\"#l%i\" class=\"linenr\">%4i</a> %s</div>\n",
+		       $nr, $nr, $nr, esc_html($line);
 	}
-	close $fd or print "Reading blob failed.\n";
+	close $fd 
+		or print "Reading blob failed.\n";
 	print "</div>";
 	git_footer_html();
 }
@@ -2282,23 +2331,37 @@ sub git_tree {
 		print "<td class=\"mode\">" . mode_str($t_mode) . "</td>\n";
 		if ($t_type eq "blob") {
 			print "<td class=\"list\">" .
-			      $cgi->a({-href => href(action=>"blob", hash=>$t_hash, file_name=>"$base$t_name", %base_key), -class => "list"}, esc_html($t_name)) .
+			      $cgi->a({-href => href(action=>"blob", hash=>$t_hash, file_name=>"$base$t_name", %base_key),
+			              -class => "list"}, esc_html($t_name)) .
 			      "</td>\n" .
 			      "<td class=\"link\">" .
-			      $cgi->a({-href => href(action=>"blob", hash=>$t_hash, file_name=>"$base$t_name", %base_key)}, "blob");
+			      $cgi->a({-href => href(action=>"blob", hash=>$t_hash, file_name=>"$base$t_name", %base_key)},
+			              "blob");
 			if ($have_blame) {
-				print " | " . $cgi->a({-href => href(action=>"blame", hash=>$t_hash, file_name=>"$base$t_name", %base_key)}, "blame");
+				print " | " .
+					$cgi->a({-href => href(action=>"blame", hash=>$t_hash, file_name=>"$base$t_name", %base_key)},
+					        "blame");
 			}
-			print " | " . $cgi->a({-href => href(action=>"history", hash=>$t_hash, hash_base=>$hash_base, file_name=>"$base$t_name")}, "history") .
-			      " | " . $cgi->a({-href => href(action=>"blob_plain", hash=>$t_hash, file_name=>"$base$t_name")}, "raw") .
+			print " | " .
+			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
+			                             hash=>$t_hash, file_name=>"$base$t_name")},
+			              "history") .
+			      " | " .
+			      $cgi->a({-href => href(action=>"blob_plain",
+			                             hash=>$t_hash, file_name=>"$base$t_name")},
+			              "raw") .
 			      "</td>\n";
 		} elsif ($t_type eq "tree") {
 			print "<td class=\"list\">" .
-			      $cgi->a({-href => href(action=>"tree", hash=>$t_hash, file_name=>"$base$t_name", %base_key)}, esc_html($t_name)) .
+			      $cgi->a({-href => href(action=>"tree", hash=>$t_hash, file_name=>"$base$t_name", %base_key)},
+			              esc_html($t_name)) .
 			      "</td>\n" .
 			      "<td class=\"link\">" .
-			      $cgi->a({-href => href(action=>"tree", hash=>$t_hash, file_name=>"$base$t_name", %base_key)}, "tree") .
-			      " | " . $cgi->a({-href => href(action=>"history", hash_base=>$hash_base, file_name=>"$base$t_name")}, "history") .
+			      $cgi->a({-href => href(action=>"tree", hash=>$t_hash, file_name=>"$base$t_name", %base_key)},
+			              "tree") .
+			      " | " .
+			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base, file_name=>"$base$t_name")},
+			              "history") .
 			      "</td>\n";
 		}
 		print "</tr>\n";
@@ -2323,10 +2386,9 @@ sub git_snapshot {
 	my $filename = basename($project) . "-$hash.tar.$suffix";
 
 	print $cgi->header(-type => 'application/x-tar',
-			   -content-encoding => $ctype,
-			   '-content-disposition' =>
-			   "inline; filename=\"$filename\"",
-			   -status => '200 OK');
+	                   -content-encoding => $ctype,
+	                  '-content-disposition' => "inline; filename=\"$filename\"",
+	                   -status => '200 OK');
 
 	open my $fd, "-|", "$GIT tar-tree $hash \'$project\' | $command" or
 		die_error(undef, "Execute git-tar-tree failed.");
@@ -2377,7 +2439,8 @@ sub git_log {
 		print "<div class=\"title_text\">\n" .
 		      "<div class=\"log_link\">\n" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") .
-		      " | " . $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") .
+		      " | " .
+		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") .
 		      "<br/>\n" .
 		      "</div>\n" .
 		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i><br/>\n" .
@@ -2421,12 +2484,14 @@ sub git_commit {
 	my $formats_nav = '';
 	if (defined $file_name && defined $co{'parent'}) {
 		my $parent = $co{'parent'};
-		$formats_nav .= $cgi->a({-href => href(action=>"blame", hash_parent=>$parent, file_name=>$file_name)}, "blame");
+		$formats_nav .=
+			$cgi->a({-href => href(action=>"blame", hash_parent=>$parent, file_name=>$file_name)},
+			        "blame");
 	}
 	git_header_html(undef, $expires);
 	git_print_page_nav('commit', defined $co{'parent'} ? '' : 'commitdiff',
-	             $hash, $co{'tree'}, $hash,
-	             $formats_nav);
+	                   $hash, $co{'tree'}, $hash,
+	                   $formats_nav);
 
 	if (defined $co{'parent'}) {
 		git_print_header_div('commitdiff', esc_html($co{'title'}) . $ref, $hash);
@@ -2439,23 +2504,31 @@ sub git_commit {
 	      "<tr>" .
 	      "<td></td><td> $ad{'rfc2822'}";
 	if ($ad{'hour_local'} < 6) {
-		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)", $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
+		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
+		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
 	} else {
-		printf(" (%02d:%02d %s)", $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
+		printf(" (%02d:%02d %s)",
+		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
 	}
 	print "</td>" .
 	      "</tr>\n";
 	print "<tr><td>committer</td><td>" . esc_html($co{'committer'}) . "</td></tr>\n";
-	print "<tr><td></td><td> $cd{'rfc2822'}" . sprintf(" (%02d:%02d %s)", $cd{'hour_local'}, $cd{'minute_local'}, $cd{'tz_local'}) . "</td></tr>\n";
+	print "<tr><td></td><td> $cd{'rfc2822'}" .
+	      sprintf(" (%02d:%02d %s)", $cd{'hour_local'}, $cd{'minute_local'}, $cd{'tz_local'}) .
+	      "</td></tr>\n";
 	print "<tr><td>commit</td><td class=\"sha1\">$co{'id'}</td></tr>\n";
 	print "<tr>" .
 	      "<td>tree</td>" .
 	      "<td class=\"sha1\">" .
-	      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$hash), class => "list"}, $co{'tree'}) .
+	      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$hash),
+	               class => "list"}, $co{'tree'}) .
 	      "</td>" .
-	      "<td class=\"link\">" . $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$hash)}, "tree");
+	      "<td class=\"link\">" .
+	      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$hash)},
+	              "tree");
 	if ($have_snapshot) {
-		print " | " .  $cgi->a({-href => href(action=>"snapshot", hash=>$hash)}, "snapshot");
+		print " | " .
+		      $cgi->a({-href => href(action=>"snapshot", hash=>$hash)}, "snapshot");
 	}
 	print "</td>" .
 	      "</tr>\n";
@@ -2463,10 +2536,14 @@ sub git_commit {
 	foreach my $par (@$parents) {
 		print "<tr>" .
 		      "<td>parent</td>" .
-		      "<td class=\"sha1\">" . $cgi->a({-href => href(action=>"commit", hash=>$par), class => "list"}, $par) . "</td>" .
+		      "<td class=\"sha1\">" .
+		      $cgi->a({-href => href(action=>"commit", hash=>$par),
+		               class => "list"}, $par) .
+		      "</td>" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$par)}, "commit") .
-		      " | " . $cgi->a({-href => href(action=>"commitdiff", hash=>$hash, hash_parent=>$par)}, "commitdiff") .
+		      " | " .
+		      $cgi->a({-href => href(action=>"commitdiff", hash=>$hash, hash_parent=>$par)}, "commitdiff") .
 		      "</td>" .
 		      "</tr>\n";
 	}
@@ -2487,7 +2564,9 @@ sub git_blobdiff {
 	git_header_html();
 	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 		my $formats_nav =
-			$cgi->a({-href => href(action=>"blobdiff_plain", hash=>$hash, hash_parent=>$hash_parent)}, "plain");
+			$cgi->a({-href => href(action=>"blobdiff_plain",
+			                       hash=>$hash, hash_parent=>$hash_parent)},
+			        "plain");
 		git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	} else {
@@ -2498,12 +2577,16 @@ sub git_blobdiff {
 	git_print_page_path($file_name, "blob", $hash_base);
 	print "<div class=\"page_body\">\n" .
 	      "<div class=\"diff_info\">blob:" .
-	      $cgi->a({-href => href(action=>"blob", hash=>$hash_parent, hash_base=>$hash_base, file_name=>($file_parent || $file_name))}, $hash_parent) .
+	      $cgi->a({-href => href(action=>"blob", hash=>$hash_parent,
+	                             hash_base=>$hash_base, file_name=>($file_parent || $file_name))},
+	              $hash_parent) .
 	      " -> blob:" .
-	      $cgi->a({-href => href(action=>"blob", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)}, $hash) .
+	      $cgi->a({-href => href(action=>"blob", hash=>$hash,
+	                             hash_base=>$hash_base, file_name=>$file_name)},
+	              $hash) .
 	      "</div>\n";
 	git_diff_print($hash_parent, $file_name || $hash_parent, $hash, $file_name || $hash);
-	print "</div>";
+	print "</div>"; # page_body
 	git_footer_html();
 }
 
@@ -2535,7 +2618,8 @@ sub git_commitdiff {
 	my $refs = git_get_references();
 	my $ref = format_ref_marker($refs, $co{'id'});
 	my $formats_nav =
-		$cgi->a({-href => href(action=>"commitdiff_plain", hash=>$hash, hash_parent=>$hash_parent)}, "plain");
+		$cgi->a({-href => href(action=>"commitdiff_plain", hash=>$hash, hash_parent=>$hash_parent)},
+		        "plain");
 	git_header_html(undef, $expires);
 	git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
 	git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
@@ -2556,22 +2640,30 @@ sub git_commitdiff {
 		my $file = validate_input(unquote($6));
 		if ($status eq "A") {
 			print "<div class=\"diff_info\">" . file_type($to_mode) . ":" .
-			      $cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$file)}, $to_id) . "(new)" .
+			      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
+			                             hash=>$to_id, file_name=>$file)},
+			              $to_id) . "(new)" .
 			      "</div>\n";
 			git_diff_print(undef, "/dev/null", $to_id, "b/$file");
 		} elsif ($status eq "D") {
 			print "<div class=\"diff_info\">" . file_type($from_mode) . ":" .
-			      $cgi->a({-href => href(action=>"blob", hash=>$from_id, hash_base=>$hash_parent, file_name=>$file)}, $from_id) . "(deleted)" .
+			      $cgi->a({-href => href(action=>"blob", hash_base=>$hash_parent,
+			                             hash=>$from_id, file_name=>$file)},
+			              $from_id) . "(deleted)" .
 			      "</div>\n";
 			git_diff_print($from_id, "a/$file", undef, "/dev/null");
 		} elsif ($status eq "M") {
 			if ($from_id ne $to_id) {
 				print "<div class=\"diff_info\">" .
 				      file_type($from_mode) . ":" .
-				      $cgi->a({-href => href(action=>"blob", hash=>$from_id, hash_base=>$hash_parent, file_name=>$file)}, $from_id) .
+				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash_parent,
+				                             hash=>$from_id, file_name=>$file)},
+				              $from_id) .
 				      " -> " .
 				      file_type($to_mode) . ":" .
-				      $cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$file)}, $to_id);
+				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
+				                             hash=>$to_id, file_name=>$file)},
+				              $to_id);
 				print "</div>\n";
 				git_diff_print($from_id, "a/$file",  $to_id, "b/$file");
 			}
@@ -2611,7 +2703,9 @@ sub git_commitdiff_plain {
 		}
 	}
 
-	print $cgi->header(-type => "text/plain", -charset => 'utf-8', '-content-disposition' => "inline; filename=\"git-$hash.patch\"");
+	print $cgi->header(-type => "text/plain",
+	                   -charset => 'utf-8',
+	                  '-content-disposition' => "inline; filename=\"git-$hash.patch\"");
 	my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
 	my $comment = $co{'comment'};
 	print "From: $co{'author'}\n" .
@@ -2791,7 +2885,8 @@ sub git_search {
 			print "</td>\n" .
 			      "<td class=\"link\">" .
 			      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'})}, "commit") .
-			      " | " . $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$co{'id'})}, "tree");
+			      " | " .
+			      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$co{'id'})}, "tree");
 			print "</td>\n" .
 			      "</tr>\n";
 		}
@@ -2828,18 +2923,22 @@ sub git_search {
 					print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
 					      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 5)) . "</i></td>\n" .
 					      "<td>" .
-					      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}), -class => "list subject"},
+					      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}),
+					              -class => "list subject"},
 					              esc_html(chop_str($co{'title'}, 50)) . "<br/>");
 					while (my $setref = shift @files) {
 						my %set = %$setref;
-						print $cgi->a({-href => href(action=>"blob", hash=>$set{'id'}, hash_base=>$co{'id'}, file_name=>$set{'file'}), class => "list"},
-						      "<span class=\"match\">" . esc_html($set{'file'}) . "</span>") .
+						print $cgi->a({-href => href(action=>"blob", hash_base=>$co{'id'},
+						                             hash=>$set{'id'}, file_name=>$set{'file'}),
+						              -class => "list"},
+						              "<span class=\"match\">" . esc_html($set{'file'}) . "</span>") .
 						      "<br/>\n";
 					}
 					print "</td>\n" .
 					      "<td class=\"link\">" .
 					      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'})}, "commit") .
-					      " | " . $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$co{'id'})}, "tree");
+					      " | " .
+					      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$co{'id'})}, "tree");
 					print "</td>\n" .
 					      "</tr>\n";
 				}
-- 
1.4.1.1
