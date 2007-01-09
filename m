From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/5] gitweb: git_patchset_body fixes
Date: Tue, 9 Jan 2007 17:44:46 +0100
Message-ID: <200701091744.46729.jnareb@gmail.com>
References: <351088.61033.qm@web31801.mail.mud.yahoo.com> <200701091127.01930.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 17:44:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4K5d-0002z9-Gd
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 17:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbXAIQom (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 11:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbXAIQom
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 11:44:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:25642 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932227AbXAIQol (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 11:44:41 -0500
Received: by ug-out-1314.google.com with SMTP id 44so6618024uga
        for <git@vger.kernel.org>; Tue, 09 Jan 2007 08:44:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=P4ARL1VdAMt+aSwbf8YlFJ+SPidCOtHqE9NIYRFYZJRIFuDByQReWCQqXZ9mC1iR7tNxx5Ic2Oecs4djDOkAQTwow556o3WAfAmied+RI5yCNYjwh+MR42fQkc8bHIYISDRZ9G5zrPPsYOSFveGgkAFZNhu1zNGkZrSCgmdJ43o=
Received: by 10.67.96.14 with SMTP id y14mr802993ugl.1168361079632;
        Tue, 09 Jan 2007 08:44:39 -0800 (PST)
Received: from host-81-190-18-145.torun.mm.pl ( [81.190.18.145])
        by mx.google.com with ESMTP id y1sm30019382uge.2007.01.09.08.44.38;
        Tue, 09 Jan 2007 08:44:38 -0800 (PST)
To: Luben Tuikov <ltuikov@yahoo.com>
User-Agent: KMail/1.9.3
In-Reply-To: <200701091127.01930.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36376>

Jakub Narebski wrote:
> Luben Tuikov wrote:
> 
>> Ok, I see that Junio has committed the fixes to "next" -- thanks!
>> That saved me time having to manually apply them.
>> 
>> Now, the results are that I see the same bug.
>  
> (The same bug = no closing div).
> 
> I'll try to reproduce this.

I failed to reproduce this error.

Could you apply the following patch, and report the result of
  grep "</div>\|<div" | grep -v "<div.*</div>
(find all opening and closing <div> elements, but omitting
those which are opened and closed in the same line)?

-- >8 --
gitweb: Mark closing </div>'s in code and output
    
Add Perl comments and HTML comments (<!-- ... -->) to </div> output,
to mark which 'div' element the closing </div> corresponds to.
    
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

 gitweb/gitweb.perl |   81 ++++++++++++++++++++++++++-------------------------
 1 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 25e5079..7b6cb4c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1800,14 +1800,14 @@ EOF
 		      $cgi->hidden(-name => "a") . "\n" .
 		      $cgi->hidden(-name => "h") . "\n" .
 		      $cgi->popup_menu(-name => 'st', -default => 'commit',
-				       -values => ['commit', 'author', 'committer', 'pickaxe']) .
+		                       -values => ['commit', 'author', 'committer', 'pickaxe']) .
 		      $cgi->sup($cgi->a({-href => href(action=>"search_help")}, "?")) .
 		      " search:\n",
 		      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
-		      "</div>" .
+		      "</div><!-- search -->\n" . # class="search"
 		      $cgi->end_form() . "\n";
 	}
-	print "</div>\n";
+	print "</div><!-- page_header -->\n"; # class="page_header"
 }
 
 sub git_footer_html {
@@ -1827,7 +1827,7 @@ sub git_footer_html {
 		print $cgi->a({-href => href(project=>undef, action=>"project_index"),
 		              -class => "rss_logo"}, "TXT") . "\n";
 	}
-	print "</div>\n" ;
+	print "</div><!-- page_footer -->\n" ; # class="page_footer"
 
 	if (-f $site_footer) {
 		open (my $fd, $site_footer);
@@ -1849,7 +1849,7 @@ sub die_error {
 <br /><br />
 $status - $error
 <br />
-</div>
+</div><!-- page_body -->
 EOF
 	git_footer_html();
 	exit;
@@ -1887,7 +1887,7 @@ sub git_print_page_nav {
 		       $_ : $cgi->a({-href => href(%{$arg{$_}})}, "$_")
 		 } @navs);
 	print "<br/>\n$extra<br/>\n" .
-	      "</div>\n";
+	      "</div><!-- page_nav -->\n"; # class="page_nav"
 }
 
 sub format_paging_nav {
@@ -1934,7 +1934,7 @@ sub git_print_header_div {
 	print "<div class=\"header\">\n" .
 	      $cgi->a({-href => href(%args), -class => "title"},
 	      $title ? $title : $action) .
-	      "\n</div>\n";
+	      "\n</div><!-- header -->\n"; # class="header"
 }
 
 #sub git_print_authorship (\%) {
@@ -1952,7 +1952,7 @@ sub git_print_authorship {
 		printf(" (%02d:%02d %s)",
 		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
 	}
-	print "]</div>\n";
+	print "]</div>\n"; # class="author_date"
 }
 
 sub git_print_page_path {
@@ -1990,7 +1990,7 @@ sub git_print_page_path {
 			print esc_path($basename);
 		}
 	}
-	print "<br/></div>\n";
+	print "<br/></div><!-- page_path -->\n"; # class="page_path"
 }
 
 # sub git_print_log (\@;%) {
@@ -2188,7 +2188,7 @@ sub git_difftree_body {
 	if ($#{$difftree} > 10) {
 		print(($#{$difftree} + 1) . " files changed:\n");
 	}
-	print "</div>\n";
+	print "</div><!-- list_head -->\n"; # class="list_head"
 
 	print "<table class=\"diff_tree\">\n";
 	my $alternate = 1;
@@ -2518,7 +2518,8 @@ sub git_patchset_body {
 			}
 			print $patch_line . "<br/>\n";
 		}
-		print "</div>\n"  if (@diff_header > 0); # class="diff extended_header"
+		print "</div><!-- diff extended_header -->\n"
+			if (@diff_header > 0); # class="diff extended_header"
 
 		# from-file/to-file diff header
 		$patch_line = $last_patch_line;
@@ -2555,10 +2556,10 @@ sub git_patchset_body {
 		}
 
 	} continue {
-		print "</div>\n"; # class="patch"
+		print "</div><!-- patch $patch_idx -->\n"; # class="patch"
 	}
 
-	print "</div>\n"; # class="patchset"
+	print "</div><!-- patchset -->\n"; # class="patchset"
 }
 
 # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
@@ -2971,7 +2972,7 @@ sub git_project_list {
 		open (my $fd, $home_text);
 		print <$fd>;
 		close $fd;
-		print "</div>\n";
+		print "</div><!-- index_include -->\n"; # class="index_include"
 	}
 	git_project_list_body(\@list, $order);
 	git_footer_html();
@@ -3123,14 +3124,14 @@ sub git_tag {
 			"</td></tr>\n";
 	}
 	print "</table>\n\n" .
-	      "</div>\n";
+	      "</div><!-- title_text -->\n"; # class="title_text"
 	print "<div class=\"page_body\">";
 	my $comment = $tag{'comment'};
 	foreach my $line (@$comment) {
 		chomp $line;
 		print esc_html($line, -nbsp=>1) . "<br/>\n";
 	}
-	print "</div>\n";
+	print "</div><!-- page_body -->\n"; # class="page_body"
 	git_footer_html();
 }
 
@@ -3201,7 +3202,7 @@ HTML
 		my $rev = substr($full_rev, 0, 8);
 		my $author = $meta->{'author'};
 		my %date = parse_date($meta->{'author-time'},
-				      $meta->{'author-tz'});
+		                      $meta->{'author-tz'});
 		my $date = $date{'iso-tz'};
 		if ($group_size) {
 			$current_color = ++$current_color % $num_colors;
@@ -3213,9 +3214,9 @@ HTML
 			print " rowspan=\"$group_size\"" if ($group_size > 1);
 			print ">";
 			print $cgi->a({-href => href(action=>"commit",
-						     hash=>$full_rev,
-						     file_name=>$file_name)},
-				      esc_html($rev));
+			                             hash=>$full_rev,
+			                             file_name=>$file_name)},
+			              esc_html($rev));
 			print "</td>\n";
 		}
 		open (my $dd, "-|", git_cmd(), "rev-parse", "$full_rev^")
@@ -3224,19 +3225,19 @@ HTML
 		close $dd;
 		chomp($parent_commit);
 		my $blamed = href(action => 'blame',
-				  file_name => $meta->{'filename'},
-				  hash_base => $parent_commit);
+		                  file_name => $meta->{'filename'},
+		                  hash_base => $parent_commit);
 		print "<td class=\"linenr\">";
 		print $cgi->a({ -href => "$blamed#l$orig_lineno",
-				-id => "l$lineno",
-				-class => "linenr" },
-			      esc_html($lineno));
+		                -id => "l$lineno",
+		                -class => "linenr" },
+		              esc_html($lineno));
 		print "</td>";
 		print "<td class=\"pre\">" . esc_html($data) . "</td>\n";
 		print "</tr>\n";
 	}
 	print "</table>\n";
-	print "</div>";
+	print "</div><!-- page_body -->\n"; # class="page_body"
 	close $fd
 		or print "Reading blob failed\n";
 	git_footer_html();
@@ -3335,7 +3336,7 @@ HTML
 	print "</table>\n\n";
 	close $fd
 		or print "Reading blob failed.\n";
-	print "</div>";
+	print "</div><!-- page_body -->"; # class="page_body"
 	git_footer_html();
 }
 
@@ -3465,7 +3466,7 @@ sub git_blob {
 		git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	} else {
 		print "<div class=\"page_nav\">\n" .
-		      "<br/><br/></div>\n" .
+		      "<br/><br/></div>\n" . # class="page_nav"
 		      "<div class=\"title\">$hash</div>\n";
 	}
 	git_print_page_path($file_name, "blob", $hash_base);
@@ -3491,7 +3492,7 @@ sub git_blob {
 	}
 	close $fd
 		or print "Reading blob failed.\n";
-	print "</div>";
+	print "</div><!-- page_body -->"; # class="page_body"
 	git_footer_html();
 }
 
@@ -3542,7 +3543,7 @@ sub git_tree {
 	} else {
 		undef $hash_base;
 		print "<div class=\"page_nav\">\n";
-		print "<br/><br/></div>\n";
+		print "<br/><br/></div>\n"; # class="page_nav"
 		print "<div class=\"title\">$hash</div>\n";
 	}
 	if (defined $file_name) {
@@ -3594,7 +3595,7 @@ sub git_tree {
 		print "</tr>\n";
 	}
 	print "</table>\n" .
-	      "</div>";
+	      "</div><!-- page_body -->"; # class="page_body";
 	git_footer_html();
 }
 
@@ -3671,19 +3672,19 @@ sub git_log {
 		      " | " .
 		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree") .
 		      "<br/>\n" .
-		      "</div>\n" .
+		      "</div><!-- log_link -->\n" . # class="log_link"
 		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i><br/>\n" .
-		      "</div>\n";
+		      "</div><!-- title_text -->\n";  # class="title_text"
 
 		print "<div class=\"log_body\">\n";
 		git_print_log($co{'comment'}, -final_empty_line=> 1);
-		print "</div>\n";
+		print "</div><!-- log_body -->\n"; # class="log_body"
 	}
 	if ($#commitlist >= 100) {
 		print "<div class=\"page_nav\">\n";
 		print $cgi->a({-href => href(action=>"log", hash=>$hash, page=>$page+1),
 			       -accesskey => "n", -title => "Alt-n"}, "next");
-		print "</div>\n";
+		print "</div><!-- page_nav -->\n"; # class="page_nav"
 	}
 	git_footer_html();
 }
@@ -3808,11 +3809,11 @@ sub git_commit {
 		      "</tr>\n";
 	}
 	print "</table>".
-	      "</div>\n";
+	      "</div><!-- title_text -->\n"; # class="title_text"
 
 	print "<div class=\"page_body\">\n";
 	git_print_log($co{'comment'});
-	print "</div>\n";
+	print "</div><!-- page_body -->\n"; # class="page_body"
 
 	if (@$parents <= 1) {
 		# do not output difftree/whatchanged for merges
@@ -4018,7 +4019,7 @@ sub git_blobdiff {
 		git_patchset_body($fd, [ \%diffinfo ], $hash_base, $hash_parent_base);
 		close $fd;
 
-		print "</div>\n"; # class="page_body"
+		print "</div><!-- page_body -->\n"; # class="page_body"
 		git_footer_html();
 
 	} else {
@@ -4140,7 +4141,7 @@ sub git_commitdiff {
 		if (@{$co{'comment'}} > 1) {
 			print "<div class=\"log\">\n";
 			git_print_log($co{'comment'}, -final_empty_line=> 1, -remove_title => 1);
-			print "</div>\n"; # class="log"
+			print "</div><!-- log -->\n"; # class="log"
 		}
 
 	} elsif ($format eq 'plain') {
@@ -4175,7 +4176,7 @@ TEXT
 
 		git_patchset_body($fd, \@difftree, $hash, $hash_parent);
 		close $fd;
-		print "</div>\n"; # class="page_body"
+		print "</div><!-- page_body -->\n"; # class="page_body"
 		git_footer_html();
 
 	} elsif ($format eq 'plain') {


-- 
Jakub Narebski
Poland
