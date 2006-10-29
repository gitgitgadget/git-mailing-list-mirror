X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] gitweb: New improved patchset view
Date: Sun, 29 Oct 2006 11:22:30 +0100
Message-ID: <200610291122.30852.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 29 Oct 2006 10:22:55 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:content-disposition:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:message-id;
        b=KkCoOLNTMi9i+Wr5Pr4A6B5bN8zoD8GhBIrtUaPySV/6cDHS3prXae5eDf2kAoZ51s6uNvlYGo8dmqkXA8OaU8mA6LFar8CfvVlJiL4xYpbhNN68u9fM0EgCdYlTElSjAgpwxKyJ0LBdivmkwDf8VAr0r4zYQypDSlRCvBTo6SU=
Content-Disposition: inline
User-Agent: KMail/1.9.3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30424>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge7oY-00072j-IM for gcvg-git@gmane.org; Sun, 29 Oct
 2006 11:22:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932160AbWJ2KWh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 05:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWJ2KWh
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 05:22:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:28638 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1750923AbWJ2KWg
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 05:22:36 -0500
Received: by ug-out-1314.google.com with SMTP id 32so960721ugm for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 02:22:34 -0800 (PST)
Received: by 10.67.30.6 with SMTP id h6mr2368543ugj; Sun, 29 Oct 2006
 02:22:34 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id j2sm1544492ugf.2006.10.29.02.22.32; Sun, 29 Oct
 2006 02:22:33 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

You should be able to check new commitdiff view at
  http://roke_DOT_dyndns_DOT_info/cgi-bin/gitweb/gitweb.cgi
(URL mangling courtesy vger banned words list, aaaarrghhh)
if I didn't screwed something again with firewall, and when my machine
is up; should be for at least an hour. Check for example:
  ?p=git.git;a=commitdiff;h=origin
  ?p=git.git;a=commitdiff;h=161332a521fe10c41979bcd493d95e2ac562b7f
  ?p=git.git;a=commitdiff;h=e12c095aa69d8aca0326eb11960427d9bf9e2db7
  ?p=git.git;a=commitdiff;h=82560983997c961d9deafe0074b787c8484c2e1d
and compare to (for example)
  http://repo.or.cz/w/git.git?a=commitdiff;h=82560983997c961d9deafe0074b787c8484c2e1d
or (even older gitweb)
  http://www.kernel.org/git/?p=git/git.git;a=commitdiff;h=887a612fef942dd3e7dae452e2dc582738b0fb41
BTW. this gitweb has also my previous "Slight improvement" patch applied.

Do you like it? What should be changed (code, output, style)?
-- >8 --
Replace "gitweb diff header" with its full sha1 of blobs with
"git diff" header and extended diff header. Change also
highlighting of diffs.

Changes:
* "gitweb diff header" which looked for example like below:
    file:_<sha1 before>_ -> file:_<sha1 after>_
  where 'file' is file type and '<sha1>' is full sha1 of blob, is link
  and uses default link style is changed to
    diff --git a/<file before> b/<file after>
  where <file> is hidden link (i.e. underline on hover, only)
  to appropriate version of file. If file is added, a/<file> is not
  hyperlinked, if file is deleted, b/<file> is not hyperlinked.
* there is added "extended diff header", with <path> and <hash>
  hyperlinked (and <hash> shortened to 7 characters), and <mode>
  explained: '<mode>' is extnded to '<mode>/<symbolic mode> (<file type>)'.
* <file> hyperlinking should work also when <file> is originally
  quoted. For now we present filename quoted. This needed changes to
  parse_difftree_raw_line subroutine.
* from-file/to-file two-line header lines have slightly darker color
  than removed/added lines.
* chunk header has now delicate line above for easier finding chunk
  boundary, and top margin of 1px.

Controversial ideas:
* All links in patch header are hidden
* Hashes are shortened to 7 characters
* Filenames are presented quoted
* Marking of chunk beginning
* No hyperlink for renamed from/to header (bug)

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.css  |   46 ++++++++++++---
 gitweb/gitweb.perl |  159 ++++++++++++++++++++++++++++++---------------------
 2 files changed, 131 insertions(+), 74 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 83d900d..3aeceed 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -303,6 +303,33 @@ td.mode {
 	font-family: monospace;
 }
 
+
+div.diff.header,
+div.diff.extended_header {
+	white-space: normal;
+}
+
+div.diff.header {
+	font-weight: bold;
+
+	background-color: #edece6;
+
+	margin-top: 4px;
+	padding: 4px 0px 2px 0px;
+	border: solid #d9d8d1;
+	border-width: 1px 0px 1px 0px;
+}
+
+div.diff.extended_header,
+div.diff.extended_header a.list {
+	color: #777777;
+}
+
+div.diff.extended_header {
+	background-color: #f6f5ee;
+	padding: 2px 0px 2px 0px;
+}
+
 div.diff a.list {
 	text-decoration: none;
 }
@@ -312,31 +339,34 @@ div.diff a.list:hover {
 }
 
 div.diff.to_file a.list,
-div.diff.to_file,
+div.diff.to_file {
+	color: #007000;
+}
+
 div.diff.add {
 	color: #008800;
 }
 
 div.diff.from_file a.list,
-div.diff.from_file,
+div.diff.from_file {
+	color: #aa0000;
+}
+
 div.diff.rem {
 	color: #cc0000;
 }
 
 div.diff.chunk_header {
 	color: #990099;
+	border: dotted #ffbbff;
+	border-width: 1px 0px 0px 0px;
+	margin-top: 1px;
 }
 
 div.diff.incomplete {
 	color: #cccccc;
 }
 
-div.diff_info {
-	font-family: monospace;
-	color: #000099;
-	background-color: #edece6;
-	font-style: italic;
-}
 
 div.index_include {
 	border: solid #d9d8d1;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cbab3c9..2d971ac 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1255,9 +1255,12 @@ sub parse_difftree_raw_line {
 		$res{'status'} = $5;
 		$res{'similarity'} = $6;
 		if ($res{'status'} eq 'R' || $res{'status'} eq 'C') { # renamed or copied
-			($res{'from_file'}, $res{'to_file'}) = map { unquote($_) } split("\t", $7);
+			($res{'from_file_raw'}, $res{'to_file_raw'}) = split("\t", $7);
+			$res{'from_file'} = unquote($res{'from_file_raw'});
+			$res{'to_file'}   = unquote($res{'to_file_raw'});
 		} else {
-			$res{'file'} = unquote($7);
+			$res{'file_raw'} = $7;
+			$res{'file'} = unquote($res{'file_raw'});
 		}
 	}
 	# 'c512b523472485aef4fff9e57b229d9d243c967f'
@@ -2024,6 +2027,7 @@ sub git_patchset_body {
 	my $in_header = 0;
 	my $patch_found = 0;
 	my $diffinfo;
+	my (@from_subst, @to_subst);
 
 	print "<div class=\"patchset\">\n";
 
@@ -2033,6 +2037,7 @@ sub git_patchset_body {
 
 		if ($patch_line =~ m/^diff /) { # "git diff" header
 			# beginning of patch (in patchset)
+
 			if ($patch_found) {
 				# close previous patch
 				print "</div>\n"; # class="patch"
@@ -2042,11 +2047,59 @@ sub git_patchset_body {
 			}
 			print "<div class=\"patch\" id=\"patch". ($patch_idx+1) ."\">\n";
 
+			# read and prepare patch information
 			if (ref($difftree->[$patch_idx]) eq "HASH") {
+				# pre-parsed (or generated by hand)
 				$diffinfo = $difftree->[$patch_idx];
 			} else {
 				$diffinfo = parse_difftree_raw_line($difftree->[$patch_idx]);
 			}
+			if ($diffinfo->{'status'} ne "A") { # not new (added) file
+				my $quot = '';
+				my $from_text;
+				my $file_raw = $diffinfo->{'from_file_raw'} || $diffinfo->{'file_raw'};
+				if ($file_raw =~ s/^"(.*)"$/\1/) {
+					$from_text = qq("a/$file_raw");
+					$quot = '"';
+				} else {
+					$from_text =  qq(a/$file_raw);
+				}
+				my $file = $diffinfo->{'from_file'} || $diffinfo->{'file'};
+				my $from_link =
+					$cgi->a({-href => href(action=>"blob", hash_base=>$hash_base,
+					                      hash=>$diffinfo->{'from_id'}, file_name=>$file),
+					        -class => "list"}, esc_html($file_raw));
+				my $hash_link =
+					$cgi->a({-href => href(action=>"blob", hash_base=>$hash_base,
+					                      hash=>$diffinfo->{'to_id'}, file_name=>$file),
+					        -class => "list"}, substr($diffinfo->{'from_id'},0,7));
+				@from_subst = 
+					($from_text, "${quot}a/$from_link${quot}",
+					$diffinfo->{'from_id'} . '\.\.', "$hash_link..");
+			}
+			if ($diffinfo->{'status'} ne "D") { # not deleted file
+				my $quot = '';
+				my $to_text;
+				my $file_raw = $diffinfo->{'to_file_raw'} || $diffinfo->{'file_raw'};
+				if ($file_raw =~ s/^"(.*)"$/\1/) {
+					$to_text = qq("b/$file_raw");
+					$quot = '"';
+				} else {
+					$to_text =  qq(b/$file_raw);
+				}
+				my $file = $diffinfo->{'to_file'} || $diffinfo->{'file'};
+				my $to_link =
+					$cgi->a({-href => href(action=>"blob", hash_base=>$hash_base,
+					                      hash=>$diffinfo->{'to_id'}, file_name=>$file),
+					        -class => "list"}, esc_html($file_raw));
+				my $hash_link =
+					$cgi->a({-href => href(action=>"blob", hash_base=>$hash_base,
+					                      hash=>$diffinfo->{'to_id'}, file_name=>$file),
+					        -class => "list"}, substr($diffinfo->{'to_id'},0,7));
+				@to_subst =
+					($to_text, "${quot}b/$to_link${quot}",
+					 '\.\.' . $diffinfo->{'to_id'}, "..$hash_link");
+			}
 			$patch_idx++;
 
 			# for now we skip empty patches
@@ -2056,82 +2109,56 @@ sub git_patchset_body {
 				next LINE;
 			}
 
-			if ($diffinfo->{'status'} eq "A") { # added
-				print "<div class=\"diff_info\">" . file_type($diffinfo->{'to_mode'}) . ":" .
-				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
-				                             hash=>$diffinfo->{'to_id'}, file_name=>$diffinfo->{'file'})},
-				              $diffinfo->{'to_id'}) . " (new)" .
-				      "</div>\n"; # class="diff_info"
-
-			} elsif ($diffinfo->{'status'} eq "D") { # deleted
-				print "<div class=\"diff_info\">" . file_type($diffinfo->{'from_mode'}) . ":" .
-				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash_parent,
-				                             hash=>$diffinfo->{'from_id'}, file_name=>$diffinfo->{'file'})},
-				              $diffinfo->{'from_id'}) . " (deleted)" .
-				      "</div>\n"; # class="diff_info"
-
-			} elsif ($diffinfo->{'status'} eq "R" || # renamed
-			         $diffinfo->{'status'} eq "C" || # copied
-			         $diffinfo->{'status'} eq "2") { # with two filenames (from git_blobdiff)
-				print "<div class=\"diff_info\">" .
-				      file_type($diffinfo->{'from_mode'}) . ":" .
-				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash_parent,
-				                             hash=>$diffinfo->{'from_id'}, file_name=>$diffinfo->{'from_file'})},
-				              $diffinfo->{'from_id'}) .
-				      " -> " .
-				      file_type($diffinfo->{'to_mode'}) . ":" .
-				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
-				                             hash=>$diffinfo->{'to_id'}, file_name=>$diffinfo->{'to_file'})},
-				              $diffinfo->{'to_id'});
-				print "</div>\n"; # class="diff_info"
-
-			} else { # modified, mode changed, ...
-				print "<div class=\"diff_info\">" .
-				      file_type($diffinfo->{'from_mode'}) . ":" .
-				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash_parent,
-				                             hash=>$diffinfo->{'from_id'}, file_name=>$diffinfo->{'file'})},
-				              $diffinfo->{'from_id'}) .
-				      " -> " .
-				      file_type($diffinfo->{'to_mode'}) . ":" .
-				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
-				                             hash=>$diffinfo->{'to_id'}, file_name=>$diffinfo->{'file'})},
-				              $diffinfo->{'to_id'});
-				print "</div>\n"; # class="diff_info"
-			}
+			# print "git diff" header
+			$patch_line =~ s/$from_subst[0]/$from_subst[1]/ if @from_subst;
+			$patch_line =~ s/$to_subst[0]/$to_subst[1]/ if @to_subst;
+			print "<div class=\"diff header\">$patch_line</div>\n";
 
-			#print "<div class=\"diff extended_header\">\n";
+			print "<div class=\"diff extended_header\">\n";
 			$in_header = 1;
 			next LINE;
 		} # start of patch in patchset
 
+		if ($in_header) {
+			if ($patch_line !~ m/^---/) {
+				# match <path>
+				if ($patch_line =~ m|a/|) {
+					$patch_line =~ s/$from_subst[0]/$from_subst[1]/ if @from_subst;
+				}
+				if ($patch_line =~ m|b/|) {
+					$patch_line =~ s/$to_subst[0]/$to_subst[1]/ if @to_subst;
+				}
+				# match <mode>
+				if ($patch_line =~ m/\s(\d{6})$/) {
+					$patch_line .= '/' . mode_str($1) . ' (' . file_type($1) . ')';
+				}
+				# match <hash>
+				if ($patch_line =~ m/^index/) {
+					$patch_line =~ s/0{40}/'0' x 7/e;
+					$patch_line =~ s/$from_subst[2]/$from_subst[3]/ if @from_subst;
+					$patch_line =~ s/$to_subst[2]/$to_subst[3]/ if @to_subst;
+				}
+				print $patch_line . "<br/>\n";
 
-		if ($in_header && $patch_line =~ m/^---/) {
-			#print "</div>\n"; # class="diff extended_header"
-			$in_header = 0;
+			} else {
+				#$patch_line =~ m/^---/;
+				print "</div>\n"; # class="diff extended_header"
+				$in_header = 0;
+
+				$patch_line =~ s/$from_subst[0]/$from_subst[1]/ if @from_subst;
+				print "<div class=\"diff from_file\">$patch_line</div>\n";
 
-			my $file = $diffinfo->{'from_file'};
-			$file  ||= $diffinfo->{'file'};
-			$file = $cgi->a({-href => href(action=>"blob", hash_base=>$hash_parent,
-			                               hash=>$diffinfo->{'from_id'}, file_name=>$file),
-			                -class => "list"}, esc_html($file));
-			$patch_line =~ s|a/.*$|a/$file|g;
-			print "<div class=\"diff from_file\">$patch_line</div>\n";
+				$patch_line = <$fd>;
+				chomp $patch_line;
 
-			$patch_line = <$fd>;
-			chomp $patch_line;
+				#$patch_line =~ m/^+++/;
+				$patch_line =~ s/$to_subst[0]/$to_subst[1]/ if @to_subst;
+				print "<div class=\"diff to_file\">$patch_line</div>\n";
 
-			#$patch_line =~ m/^+++/;
-			$file    = $diffinfo->{'to_file'};
-			$file  ||= $diffinfo->{'file'};
-			$file = $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
-			                               hash=>$diffinfo->{'to_id'}, file_name=>$file),
-			                -class => "list"}, esc_html($file));
-			$patch_line =~ s|b/.*|b/$file|g;
-			print "<div class=\"diff to_file\">$patch_line</div>\n";
+			}
 
 			next LINE;
 		}
-		next LINE if $in_header;
 
 		print format_diff_line($patch_line);
 	}
-- 
1.4.3.3



-------------------------------------------------------

-- 
Jakub Narebski
