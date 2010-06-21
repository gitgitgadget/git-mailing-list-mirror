From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH 10/11 GSoC] gitweb: Create Gitweb::Format module
Date: Tue, 22 Jun 2010 03:30:46 +0530
Message-ID: <1277157648-6029-11-git-send-email-pavan.sss1991@gmail.com>
References: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Tue Jun 22 00:04:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQp6N-0000ac-9c
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 00:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755548Ab0FUWEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 18:04:20 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36311 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755065Ab0FUWET (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 18:04:19 -0400
Received: by mail-pw0-f46.google.com with SMTP id 8so529457pwj.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 15:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fD0VV75Qw7q7wRmKApgKGdsDVU5SA2GgjlnSuZfzN4g=;
        b=GEJeylInS2RZTPoPuLuUXaM+nDwH3co1R+z141A3rq8a01J08cAGLVRcZmY7yRenZy
         h3792D7Ag3idGyNhNFLIyXDug+FVpDJDkfMV5Bzp00grPNcJNQtqXHf190XJtM6nWxWO
         Lf22E3gaSVQ707lyStGBm1p8jPbCAhVdQekuU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=X2djwaTFBbcJcES6OgBTf3tm7Bbv8/ScWkfJvCcvAilI4XZdEUv5q9DfB0NTl4yG/q
         kPPHdXnpgwzst1oSUb71gLzrdszhQnsv/2i3Nq+IhUgJfL7VGejG4hBXCNSbVLACxGkb
         WNmsXL6NOEMMq29kLv8mxolwqeOyJnCjvIUqo=
Received: by 10.142.67.30 with SMTP id p30mr4030149wfa.154.1277157858835;
        Mon, 21 Jun 2010 15:04:18 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.132])
        by mx.google.com with ESMTPS id y27sm525703wfi.17.2010.06.21.15.04.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jun 2010 15:04:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.454.g6bbe9.dirty
In-Reply-To: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149452>

Create Gitweb::Format module in 'gitweb/lib/Gitweb/Format.pm'
to store the subroutines related to formatting of HTML
fragments required for gitweb.

This module depends on Config.pm, View.pm, Escape.pm,
Util.pm and Request.pm. It mainly contain functions returning
short HTML fragments or transforming HTML fragments. Also
include subroutines regarding avatar formatting.

Subroutines moved:
	format_log_line_html
	format_ref_marker
	format_subject_html
	picon_url
	gravatar_url
	git_get_avatar
	format_search_author
	format_author_html
	format_git_diff_header_line
	format_extended_diff_header_line
	format_diff_from_to_header
	format_diff_cc_simplified
	format_diff_line
	format_snapshot_links

Update 'gitweb/Makefile' to install Gitweb::Format alongside gitweb.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 gitweb/Makefile             |    1 +
 gitweb/gitweb.perl          |  512 +----------------------------------------
 gitweb/lib/Gitweb/Format.pm |  537 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 539 insertions(+), 511 deletions(-)
 create mode 100644 gitweb/lib/Gitweb/Format.pm

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 280ff6d..1ef0b7a 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -119,6 +119,7 @@ GITWEB_MODULES += lib/Gitweb/Escape.pm
 GITWEB_MODULES += lib/Gitweb/RepoConfig.pm
 GITWEB_MODULES += lib/Gitweb/View.pm
 GITWEB_MODULES += lib/Gitweb/Util.pm
+GITWEB_MODULES += lib/Gitweb/Format.pm
 
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a3de63e..e5f3cc6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -32,6 +32,7 @@ use Gitweb::Escape;
 use Gitweb::RepoConfig;
 use Gitweb::View;
 use Gitweb::Util;
+use Gitweb::Format;
 
 BEGIN {
 	CGI->compile() if $ENV{'MOD_PERL'};
@@ -576,517 +577,6 @@ sub validate_project {
 }
 
 ## ----------------------------------------------------------------------
-## functions returning short HTML fragments, or transforming HTML fragments
-## which don't belong to other sections
-
-# format line of commit message.
-sub format_log_line_html {
-	my $line = shift;
-
-	$line = esc_html($line, -nbsp=>1);
-	$line =~ s{\b([0-9a-fA-F]{8,40})\b}{
-		$cgi->a({-href => href(action=>"object", hash=>$1),
-					-class => "text"}, $1);
-	}eg;
-
-	return $line;
-}
-
-# format marker of refs pointing to given object
-
-# the destination action is chosen based on object type and current context:
-# - for annotated tags, we choose the tag view unless it's the current view
-#   already, in which case we go to shortlog view
-# - for other refs, we keep the current view if we're in history, shortlog or
-#   log view, and select shortlog otherwise
-sub format_ref_marker {
-	my ($refs, $id) = @_;
-	my $markers = '';
-
-	if (defined $refs->{$id}) {
-		foreach my $ref (@{$refs->{$id}}) {
-			# this code exploits the fact that non-lightweight tags are the
-			# only indirect objects, and that they are the only objects for which
-			# we want to use tag instead of shortlog as action
-			my ($type, $name) = qw();
-			my $indirect = ($ref =~ s/\^\{\}$//);
-			# e.g. tags/v2.6.11 or heads/next
-			if ($ref =~ m!^(.*?)s?/(.*)$!) {
-				$type = $1;
-				$name = $2;
-			} else {
-				$type = "ref";
-				$name = $ref;
-			}
-
-			my $class = $type;
-			$class .= " indirect" if $indirect;
-
-			my $dest_action = "shortlog";
-
-			if ($indirect) {
-				$dest_action = "tag" unless $action eq "tag";
-			} elsif ($action =~ /^(history|(short)?log)$/) {
-				$dest_action = $action;
-			}
-
-			my $dest = "";
-			$dest .= "refs/" unless $ref =~ m!^refs/!;
-			$dest .= $ref;
-
-			my $link = $cgi->a({
-				-href => href(
-					action=>$dest_action,
-					hash=>$dest
-				)}, $name);
-
-			$markers .= " <span class=\"$class\" title=\"$ref\">" .
-				$link . "</span>";
-		}
-	}
-
-	if ($markers) {
-		return ' <span class="refs">'. $markers . '</span>';
-	} else {
-		return "";
-	}
-}
-
-# format, perhaps shortened and with markers, title line
-sub format_subject_html {
-	my ($long, $short, $href, $extra) = @_;
-	$extra = '' unless defined($extra);
-
-	if (length($short) < length($long)) {
-		$long =~ s/[[:cntrl:]]/?/g;
-		return $cgi->a({-href => $href, -class => "list subject",
-		                -title => to_utf8($long)},
-		       esc_html($short)) . $extra;
-	} else {
-		return $cgi->a({-href => $href, -class => "list subject"},
-		       esc_html($long)) . $extra;
-	}
-}
-
-# Rather than recomputing the url for an email multiple times, we cache it
-# after the first hit. This gives a visible benefit in views where the avatar
-# for the same email is used repeatedly (e.g. shortlog).
-# The cache is shared by all avatar engines (currently gravatar only), which
-# are free to use it as preferred. Since only one avatar engine is used for any
-# given page, there's no risk for cache conflicts.
-our %avatar_cache = ();
-
-# Compute the picon url for a given email, by using the picon search service over at
-# http://www.cs.indiana.edu/picons/search.html
-sub picon_url {
-	my $email = lc shift;
-	if (!$avatar_cache{$email}) {
-		my ($user, $domain) = split('@', $email);
-		$avatar_cache{$email} =
-			"http://www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/" .
-			"$domain/$user/" .
-			"users+domains+unknown/up/single";
-	}
-	return $avatar_cache{$email};
-}
-
-# Compute the gravatar url for a given email, if it's not in the cache already.
-# Gravatar stores only the part of the URL before the size, since that's the
-# one computationally more expensive. This also allows reuse of the cache for
-# different sizes (for this particular engine).
-sub gravatar_url {
-	my $email = lc shift;
-	my $size = shift;
-	$avatar_cache{$email} ||=
-		"http://www.gravatar.com/avatar/" .
-			Digest::MD5::md5_hex($email) . "?s=";
-	return $avatar_cache{$email} . $size;
-}
-
-# Insert an avatar for the given $email at the given $size if the feature
-# is enabled.
-sub git_get_avatar {
-	my ($email, %opts) = @_;
-	my $pre_white  = ($opts{-pad_before} ? "&nbsp;" : "");
-	my $post_white = ($opts{-pad_after}  ? "&nbsp;" : "");
-	$opts{-size} ||= 'default';
-	my $size = $avatar_size{$opts{-size}} || $avatar_size{'default'};
-	my $url = "";
-	if ($git_avatar eq 'gravatar') {
-		$url = gravatar_url($email, $size);
-	} elsif ($git_avatar eq 'picon') {
-		$url = picon_url($email);
-	}
-	# Other providers can be added by extending the if chain, defining $url
-	# as needed. If no variant puts something in $url, we assume avatars
-	# are completely disabled/unavailable.
-	if ($url) {
-		return $pre_white .
-		       "<img width=\"$size\" " .
-		            "class=\"avatar\" " .
-		            "src=\"$url\" " .
-			    "alt=\"\" " .
-		       "/>" . $post_white;
-	} else {
-		return "";
-	}
-}
-
-sub format_search_author {
-	my ($author, $searchtype, $displaytext) = @_;
-	my $have_search = gitweb_check_feature('search');
-
-	if ($have_search) {
-		my $performed = "";
-		if ($searchtype eq 'author') {
-			$performed = "authored";
-		} elsif ($searchtype eq 'committer') {
-			$performed = "committed";
-		}
-
-		return $cgi->a({-href => href(action=>"search", hash=>$hash,
-				searchtext=>$author,
-				searchtype=>$searchtype), class=>"list",
-				title=>"Search for commits $performed by $author"},
-				$displaytext);
-
-	} else {
-		return $displaytext;
-	}
-}
-
-# format the author name of the given commit with the given tag
-# the author name is chopped and escaped according to the other
-# optional parameters (see chop_str).
-sub format_author_html {
-	my $tag = shift;
-	my $co = shift;
-	my $author = chop_and_escape_str($co->{'author_name'}, @_);
-	return "<$tag class=\"author\">" .
-	       format_search_author($co->{'author_name'}, "author",
-		       git_get_avatar($co->{'author_email'}, -pad_after => 1) .
-		       $author) .
-	       "</$tag>";
-}
-
-# format git diff header line, i.e. "diff --(git|combined|cc) ..."
-sub format_git_diff_header_line {
-	my $line = shift;
-	my $diffinfo = shift;
-	my ($from, $to) = @_;
-
-	if ($diffinfo->{'nparents'}) {
-		# combined diff
-		$line =~ s!^(diff (.*?) )"?.*$!$1!;
-		if ($to->{'href'}) {
-			$line .= $cgi->a({-href => $to->{'href'}, -class => "path"},
-			                 esc_path($to->{'file'}));
-		} else { # file was deleted (no href)
-			$line .= esc_path($to->{'file'});
-		}
-	} else {
-		# "ordinary" diff
-		$line =~ s!^(diff (.*?) )"?a/.*$!$1!;
-		if ($from->{'href'}) {
-			$line .= $cgi->a({-href => $from->{'href'}, -class => "path"},
-			                 'a/' . esc_path($from->{'file'}));
-		} else { # file was added (no href)
-			$line .= 'a/' . esc_path($from->{'file'});
-		}
-		$line .= ' ';
-		if ($to->{'href'}) {
-			$line .= $cgi->a({-href => $to->{'href'}, -class => "path"},
-			                 'b/' . esc_path($to->{'file'}));
-		} else { # file was deleted
-			$line .= 'b/' . esc_path($to->{'file'});
-		}
-	}
-
-	return "<div class=\"diff header\">$line</div>\n";
-}
-
-# format extended diff header line, before patch itself
-sub format_extended_diff_header_line {
-	my $line = shift;
-	my $diffinfo = shift;
-	my ($from, $to) = @_;
-
-	# match <path>
-	if ($line =~ s!^((copy|rename) from ).*$!$1! && $from->{'href'}) {
-		$line .= $cgi->a({-href=>$from->{'href'}, -class=>"path"},
-		                       esc_path($from->{'file'}));
-	}
-	if ($line =~ s!^((copy|rename) to ).*$!$1! && $to->{'href'}) {
-		$line .= $cgi->a({-href=>$to->{'href'}, -class=>"path"},
-		                 esc_path($to->{'file'}));
-	}
-	# match single <mode>
-	if ($line =~ m/\s(\d{6})$/) {
-		$line .= '<span class="info"> (' .
-		         file_type_long($1) .
-		         ')</span>';
-	}
-	# match <hash>
-	if ($line =~ m/^index [0-9a-fA-F]{40},[0-9a-fA-F]{40}/) {
-		# can match only for combined diff
-		$line = 'index ';
-		for (my $i = 0; $i < $diffinfo->{'nparents'}; $i++) {
-			if ($from->{'href'}[$i]) {
-				$line .= $cgi->a({-href=>$from->{'href'}[$i],
-				                  -class=>"hash"},
-				                 substr($diffinfo->{'from_id'}[$i],0,7));
-			} else {
-				$line .= '0' x 7;
-			}
-			# separator
-			$line .= ',' if ($i < $diffinfo->{'nparents'} - 1);
-		}
-		$line .= '..';
-		if ($to->{'href'}) {
-			$line .= $cgi->a({-href=>$to->{'href'}, -class=>"hash"},
-			                 substr($diffinfo->{'to_id'},0,7));
-		} else {
-			$line .= '0' x 7;
-		}
-
-	} elsif ($line =~ m/^index [0-9a-fA-F]{40}..[0-9a-fA-F]{40}/) {
-		# can match only for ordinary diff
-		my ($from_link, $to_link);
-		if ($from->{'href'}) {
-			$from_link = $cgi->a({-href=>$from->{'href'}, -class=>"hash"},
-			                     substr($diffinfo->{'from_id'},0,7));
-		} else {
-			$from_link = '0' x 7;
-		}
-		if ($to->{'href'}) {
-			$to_link = $cgi->a({-href=>$to->{'href'}, -class=>"hash"},
-			                   substr($diffinfo->{'to_id'},0,7));
-		} else {
-			$to_link = '0' x 7;
-		}
-		my ($from_id, $to_id) = ($diffinfo->{'from_id'}, $diffinfo->{'to_id'});
-		$line =~ s!$from_id\.\.$to_id!$from_link..$to_link!;
-	}
-
-	return $line . "<br/>\n";
-}
-
-# format from-file/to-file diff header
-sub format_diff_from_to_header {
-	my ($from_line, $to_line, $diffinfo, $from, $to, @parents) = @_;
-	my $line;
-	my $result = '';
-
-	$line = $from_line;
-	#assert($line =~ m/^---/) if DEBUG;
-	# no extra formatting for "^--- /dev/null"
-	if (! $diffinfo->{'nparents'}) {
-		# ordinary (single parent) diff
-		if ($line =~ m!^--- "?a/!) {
-			if ($from->{'href'}) {
-				$line = '--- a/' .
-				        $cgi->a({-href=>$from->{'href'}, -class=>"path"},
-				                esc_path($from->{'file'}));
-			} else {
-				$line = '--- a/' .
-				        esc_path($from->{'file'});
-			}
-		}
-		$result .= qq!<div class="diff from_file">$line</div>\n!;
-
-	} else {
-		# combined diff (merge commit)
-		for (my $i = 0; $i < $diffinfo->{'nparents'}; $i++) {
-			if ($from->{'href'}[$i]) {
-				$line = '--- ' .
-				        $cgi->a({-href=>href(action=>"blobdiff",
-				                             hash_parent=>$diffinfo->{'from_id'}[$i],
-				                             hash_parent_base=>$parents[$i],
-				                             file_parent=>$from->{'file'}[$i],
-				                             hash=>$diffinfo->{'to_id'},
-				                             hash_base=>$hash,
-				                             file_name=>$to->{'file'}),
-				                 -class=>"path",
-				                 -title=>"diff" . ($i+1)},
-				                $i+1) .
-				        '/' .
-				        $cgi->a({-href=>$from->{'href'}[$i], -class=>"path"},
-				                esc_path($from->{'file'}[$i]));
-			} else {
-				$line = '--- /dev/null';
-			}
-			$result .= qq!<div class="diff from_file">$line</div>\n!;
-		}
-	}
-
-	$line = $to_line;
-	#assert($line =~ m/^\+\+\+/) if DEBUG;
-	# no extra formatting for "^+++ /dev/null"
-	if ($line =~ m!^\+\+\+ "?b/!) {
-		if ($to->{'href'}) {
-			$line = '+++ b/' .
-			        $cgi->a({-href=>$to->{'href'}, -class=>"path"},
-			                esc_path($to->{'file'}));
-		} else {
-			$line = '+++ b/' .
-			        esc_path($to->{'file'});
-		}
-	}
-	$result .= qq!<div class="diff to_file">$line</div>\n!;
-
-	return $result;
-}
-
-# create note for patch simplified by combined diff
-sub format_diff_cc_simplified {
-	my ($diffinfo, @parents) = @_;
-	my $result = '';
-
-	$result .= "<div class=\"diff header\">" .
-	           "diff --cc ";
-	if (!is_deleted($diffinfo)) {
-		$result .= $cgi->a({-href => href(action=>"blob",
-		                                  hash_base=>$hash,
-		                                  hash=>$diffinfo->{'to_id'},
-		                                  file_name=>$diffinfo->{'to_file'}),
-		                    -class => "path"},
-		                   esc_path($diffinfo->{'to_file'}));
-	} else {
-		$result .= esc_path($diffinfo->{'to_file'});
-	}
-	$result .= "</div>\n" . # class="diff header"
-	           "<div class=\"diff nodifferences\">" .
-	           "Simple merge" .
-	           "</div>\n"; # class="diff nodifferences"
-
-	return $result;
-}
-
-# format patch (diff) line (not to be used for diff headers)
-sub format_diff_line {
-	my $line = shift;
-	my ($from, $to) = @_;
-	my $diff_class = "";
-
-	chomp $line;
-
-	if ($from && $to && ref($from->{'href'}) eq "ARRAY") {
-		# combined diff
-		my $prefix = substr($line, 0, scalar @{$from->{'href'}});
-		if ($line =~ m/^\@{3}/) {
-			$diff_class = " chunk_header";
-		} elsif ($line =~ m/^\\/) {
-			$diff_class = " incomplete";
-		} elsif ($prefix =~ tr/+/+/) {
-			$diff_class = " add";
-		} elsif ($prefix =~ tr/-/-/) {
-			$diff_class = " rem";
-		}
-	} else {
-		# assume ordinary diff
-		my $char = substr($line, 0, 1);
-		if ($char eq '+') {
-			$diff_class = " add";
-		} elsif ($char eq '-') {
-			$diff_class = " rem";
-		} elsif ($char eq '@') {
-			$diff_class = " chunk_header";
-		} elsif ($char eq "\\") {
-			$diff_class = " incomplete";
-		}
-	}
-	$line = untabify($line);
-	if ($from && $to && $line =~ m/^\@{2} /) {
-		my ($from_text, $from_start, $from_lines, $to_text, $to_start, $to_lines, $section) =
-			$line =~ m/^\@{2} (-(\d+)(?:,(\d+))?) (\+(\d+)(?:,(\d+))?) \@{2}(.*)$/;
-
-		$from_lines = 0 unless defined $from_lines;
-		$to_lines   = 0 unless defined $to_lines;
-
-		if ($from->{'href'}) {
-			$from_text = $cgi->a({-href=>"$from->{'href'}#l$from_start",
-			                     -class=>"list"}, $from_text);
-		}
-		if ($to->{'href'}) {
-			$to_text   = $cgi->a({-href=>"$to->{'href'}#l$to_start",
-			                     -class=>"list"}, $to_text);
-		}
-		$line = "<span class=\"chunk_info\">@@ $from_text $to_text @@</span>" .
-		        "<span class=\"section\">" . esc_html($section, -nbsp=>1) . "</span>";
-		return "<div class=\"diff$diff_class\">$line</div>\n";
-	} elsif ($from && $to && $line =~ m/^\@{3}/) {
-		my ($prefix, $ranges, $section) = $line =~ m/^(\@+) (.*?) \@+(.*)$/;
-		my (@from_text, @from_start, @from_nlines, $to_text, $to_start, $to_nlines);
-
-		@from_text = split(' ', $ranges);
-		for (my $i = 0; $i < @from_text; ++$i) {
-			($from_start[$i], $from_nlines[$i]) =
-				(split(',', substr($from_text[$i], 1)), 0);
-		}
-
-		$to_text   = pop @from_text;
-		$to_start  = pop @from_start;
-		$to_nlines = pop @from_nlines;
-
-		$line = "<span class=\"chunk_info\">$prefix ";
-		for (my $i = 0; $i < @from_text; ++$i) {
-			if ($from->{'href'}[$i]) {
-				$line .= $cgi->a({-href=>"$from->{'href'}[$i]#l$from_start[$i]",
-				                  -class=>"list"}, $from_text[$i]);
-			} else {
-				$line .= $from_text[$i];
-			}
-			$line .= " ";
-		}
-		if ($to->{'href'}) {
-			$line .= $cgi->a({-href=>"$to->{'href'}#l$to_start",
-			                  -class=>"list"}, $to_text);
-		} else {
-			$line .= $to_text;
-		}
-		$line .= " $prefix</span>" .
-		         "<span class=\"section\">" . esc_html($section, -nbsp=>1) . "</span>";
-		return "<div class=\"diff$diff_class\">$line</div>\n";
-	}
-	return "<div class=\"diff$diff_class\">" . esc_html($line, -nbsp=>1) . "</div>\n";
-}
-
-# Generates undef or something like "_snapshot_" or "snapshot (_tbz2_ _zip_)",
-# linked.  Pass the hash of the tree/commit to snapshot.
-sub format_snapshot_links {
-	my ($hash) = @_;
-	my $num_fmts = @snapshot_fmts;
-	if ($num_fmts > 1) {
-		# A parenthesized list of links bearing format names.
-		# e.g. "snapshot (_tar.gz_ _zip_)"
-		return "snapshot (" . join(' ', map
-			$cgi->a({
-				-href => href(
-					action=>"snapshot",
-					hash=>$hash,
-					snapshot_format=>$_
-				)
-			}, $known_snapshot_formats{$_}{'display'})
-		, @snapshot_fmts) . ")";
-	} elsif ($num_fmts == 1) {
-		# A single "snapshot" link whose tooltip bears the format name.
-		# i.e. "_snapshot_"
-		my ($fmt) = @snapshot_fmts;
-		return
-			$cgi->a({
-				-href => href(
-					action=>"snapshot",
-					hash=>$hash,
-					snapshot_format=>$fmt
-				),
-				-title => "in format: $known_snapshot_formats{$fmt}{'display'}"
-			}, "snapshot");
-	} else { # $num_fmts == 0
-		return undef;
-	}
-}
-
-## ----------------------------------------------------------------------
 ## parse to hash functions
 
 sub parse_date {
diff --git a/gitweb/lib/Gitweb/Format.pm b/gitweb/lib/Gitweb/Format.pm
new file mode 100644
index 0000000..dc535bd
--- /dev/null
+++ b/gitweb/lib/Gitweb/Format.pm
@@ -0,0 +1,537 @@
+#!/usr/bin/perl
+#
+# Gitweb::Format -- gitweb's format_* subs package
+#
+# This program is licensed under the GPLv2
+
+package Gitweb::Format;
+
+use strict;
+use warnings;
+use Exporter qw(import);
+
+our @EXPORT = qw(format_log_line_html format_ref_marker format_subject_html
+                 git_get_avatar format_search_author format_author_html
+                 format_git_diff_header_line format_extended_diff_header_line
+                 format_diff_from_to_header format_diff_cc_simplified
+                 format_diff_line format_snapshot_links);
+
+use Gitweb::Config qw($git_avatar gitweb_check_feature @snapshot_fmts
+                      %known_snapshot_formats %avatar_size);
+use Gitweb::Request qw($cgi $action $hash);
+use Gitweb::Escape qw(to_utf8 esc_html esc_path untabify);
+use Gitweb::View qw(href chop_and_escape_str file_type_long);
+use Gitweb::Util qw(is_deleted);
+
+## ----------------------------------------------------------------------
+## functions returning short HTML fragments, or transforming HTML fragments
+## which don't belong to other sections
+
+# format line of commit message.
+sub format_log_line_html {
+	my $line = shift;
+
+	$line = esc_html($line, -nbsp=>1);
+	$line =~ s{\b([0-9a-fA-F]{8,40})\b}{
+		$cgi->a({-href => href(action=>"object", hash=>$1),
+					-class => "text"}, $1);
+	}eg;
+
+	return $line;
+}
+
+# format marker of refs pointing to given object
+
+# the destination action is chosen based on object type and current context:
+# - for annotated tags, we choose the tag view unless it's the current view
+#   already, in which case we go to shortlog view
+# - for other refs, we keep the current view if we're in history, shortlog or
+#   log view, and select shortlog otherwise
+sub format_ref_marker {
+	my ($refs, $id) = @_;
+	my $markers = '';
+
+	if (defined $refs->{$id}) {
+		foreach my $ref (@{$refs->{$id}}) {
+			# this code exploits the fact that non-lightweight tags are the
+			# only indirect objects, and that they are the only objects for which
+			# we want to use tag instead of shortlog as action
+			my ($type, $name) = qw();
+			my $indirect = ($ref =~ s/\^\{\}$//);
+			# e.g. tags/v2.6.11 or heads/next
+			if ($ref =~ m!^(.*?)s?/(.*)$!) {
+				$type = $1;
+				$name = $2;
+			} else {
+				$type = "ref";
+				$name = $ref;
+			}
+
+			my $class = $type;
+			$class .= " indirect" if $indirect;
+
+			my $dest_action = "shortlog";
+
+			if ($indirect) {
+				$dest_action = "tag" unless $action eq "tag";
+			} elsif ($action =~ /^(history|(short)?log)$/) {
+				$dest_action = $action;
+			}
+
+			my $dest = "";
+			$dest .= "refs/" unless $ref =~ m!^refs/!;
+			$dest .= $ref;
+
+			my $link = $cgi->a({
+				-href => href(
+					action=>$dest_action,
+					hash=>$dest
+				)}, $name);
+
+			$markers .= " <span class=\"$class\" title=\"$ref\">" .
+				$link . "</span>";
+		}
+	}
+
+	if ($markers) {
+		return ' <span class="refs">'. $markers . '</span>';
+	} else {
+		return "";
+	}
+}
+
+# format, perhaps shortened and with markers, title line
+sub format_subject_html {
+	my ($long, $short, $href, $extra) = @_;
+	$extra = '' unless defined($extra);
+
+	if (length($short) < length($long)) {
+		$long =~ s/[[:cntrl:]]/?/g;
+		return $cgi->a({-href => $href, -class => "list subject",
+		                -title => to_utf8($long)},
+		       esc_html($short)) . $extra;
+	} else {
+		return $cgi->a({-href => $href, -class => "list subject"},
+		       esc_html($long)) . $extra;
+	}
+}
+
+# Rather than recomputing the url for an email multiple times, we cache it
+# after the first hit. This gives a visible benefit in views where the avatar
+# for the same email is used repeatedly (e.g. shortlog).
+# The cache is shared by all avatar engines (currently gravatar only), which
+# are free to use it as preferred. Since only one avatar engine is used for any
+# given page, there's no risk for cache conflicts.
+our %avatar_cache = ();
+
+# Compute the picon url for a given email, by using the picon search service over at
+# http://www.cs.indiana.edu/picons/search.html
+sub picon_url {
+	my $email = lc shift;
+	if (!$avatar_cache{$email}) {
+		my ($user, $domain) = split('@', $email);
+		$avatar_cache{$email} =
+			"http://www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/" .
+			"$domain/$user/" .
+			"users+domains+unknown/up/single";
+	}
+	return $avatar_cache{$email};
+}
+
+# Compute the gravatar url for a given email, if it's not in the cache already.
+# Gravatar stores only the part of the URL before the size, since that's the
+# one computationally more expensive. This also allows reuse of the cache for
+# different sizes (for this particular engine).
+sub gravatar_url {
+	my $email = lc shift;
+	my $size = shift;
+	$avatar_cache{$email} ||=
+		"http://www.gravatar.com/avatar/" .
+			Digest::MD5::md5_hex($email) . "?s=";
+	return $avatar_cache{$email} . $size;
+}
+
+# Insert an avatar for the given $email at the given $size if the feature
+# is enabled.
+sub git_get_avatar {
+	my ($email, %opts) = @_;
+	my $pre_white  = ($opts{-pad_before} ? "&nbsp;" : "");
+	my $post_white = ($opts{-pad_after}  ? "&nbsp;" : "");
+	$opts{-size} ||= 'default';
+	my $size = $avatar_size{$opts{-size}} || $avatar_size{'default'};
+	my $url = "";
+	if ($git_avatar eq 'gravatar') {
+		$url = gravatar_url($email, $size);
+	} elsif ($git_avatar eq 'picon') {
+		$url = picon_url($email);
+	}
+	# Other providers can be added by extending the if chain, defining $url
+	# as needed. If no variant puts something in $url, we assume avatars
+	# are completely disabled/unavailable.
+	if ($url) {
+		return $pre_white .
+		       "<img width=\"$size\" " .
+		            "class=\"avatar\" " .
+		            "src=\"$url\" " .
+			    "alt=\"\" " .
+		       "/>" . $post_white;
+	} else {
+		return "";
+	}
+}
+
+sub format_search_author {
+	my ($author, $searchtype, $displaytext) = @_;
+	my $have_search = gitweb_check_feature('search');
+
+	if ($have_search) {
+		my $performed = "";
+		if ($searchtype eq 'author') {
+			$performed = "authored";
+		} elsif ($searchtype eq 'committer') {
+			$performed = "committed";
+		}
+
+		return $cgi->a({-href => href(action=>"search", hash=>$hash,
+				searchtext=>$author,
+				searchtype=>$searchtype), class=>"list",
+				title=>"Search for commits $performed by $author"},
+				$displaytext);
+
+	} else {
+		return $displaytext;
+	}
+}
+
+# format the author name of the given commit with the given tag
+# the author name is chopped and escaped according to the other
+# optional parameters (see chop_str).
+sub format_author_html {
+	my $tag = shift;
+	my $co = shift;
+	my $author = chop_and_escape_str($co->{'author_name'}, @_);
+	return "<$tag class=\"author\">" .
+	       format_search_author($co->{'author_name'}, "author",
+		       git_get_avatar($co->{'author_email'}, -pad_after => 1) .
+		       $author) .
+	       "</$tag>";
+}
+
+# format git diff header line, i.e. "diff --(git|combined|cc) ..."
+sub format_git_diff_header_line {
+	my $line = shift;
+	my $diffinfo = shift;
+	my ($from, $to) = @_;
+
+	if ($diffinfo->{'nparents'}) {
+		# combined diff
+		$line =~ s!^(diff (.*?) )"?.*$!$1!;
+		if ($to->{'href'}) {
+			$line .= $cgi->a({-href => $to->{'href'}, -class => "path"},
+			                 esc_path($to->{'file'}));
+		} else { # file was deleted (no href)
+			$line .= esc_path($to->{'file'});
+		}
+	} else {
+		# "ordinary" diff
+		$line =~ s!^(diff (.*?) )"?a/.*$!$1!;
+		if ($from->{'href'}) {
+			$line .= $cgi->a({-href => $from->{'href'}, -class => "path"},
+			                 'a/' . esc_path($from->{'file'}));
+		} else { # file was added (no href)
+			$line .= 'a/' . esc_path($from->{'file'});
+		}
+		$line .= ' ';
+		if ($to->{'href'}) {
+			$line .= $cgi->a({-href => $to->{'href'}, -class => "path"},
+			                 'b/' . esc_path($to->{'file'}));
+		} else { # file was deleted
+			$line .= 'b/' . esc_path($to->{'file'});
+		}
+	}
+
+	return "<div class=\"diff header\">$line</div>\n";
+}
+
+# format extended diff header line, before patch itself
+sub format_extended_diff_header_line {
+	my $line = shift;
+	my $diffinfo = shift;
+	my ($from, $to) = @_;
+
+	# match <path>
+	if ($line =~ s!^((copy|rename) from ).*$!$1! && $from->{'href'}) {
+		$line .= $cgi->a({-href=>$from->{'href'}, -class=>"path"},
+		                       esc_path($from->{'file'}));
+	}
+	if ($line =~ s!^((copy|rename) to ).*$!$1! && $to->{'href'}) {
+		$line .= $cgi->a({-href=>$to->{'href'}, -class=>"path"},
+		                 esc_path($to->{'file'}));
+	}
+	# match single <mode>
+	if ($line =~ m/\s(\d{6})$/) {
+		$line .= '<span class="info"> (' .
+		         file_type_long($1) .
+		         ')</span>';
+	}
+	# match <hash>
+	if ($line =~ m/^index [0-9a-fA-F]{40},[0-9a-fA-F]{40}/) {
+		# can match only for combined diff
+		$line = 'index ';
+		for (my $i = 0; $i < $diffinfo->{'nparents'}; $i++) {
+			if ($from->{'href'}[$i]) {
+				$line .= $cgi->a({-href=>$from->{'href'}[$i],
+				                  -class=>"hash"},
+				                 substr($diffinfo->{'from_id'}[$i],0,7));
+			} else {
+				$line .= '0' x 7;
+			}
+			# separator
+			$line .= ',' if ($i < $diffinfo->{'nparents'} - 1);
+		}
+		$line .= '..';
+		if ($to->{'href'}) {
+			$line .= $cgi->a({-href=>$to->{'href'}, -class=>"hash"},
+			                 substr($diffinfo->{'to_id'},0,7));
+		} else {
+			$line .= '0' x 7;
+		}
+
+	} elsif ($line =~ m/^index [0-9a-fA-F]{40}..[0-9a-fA-F]{40}/) {
+		# can match only for ordinary diff
+		my ($from_link, $to_link);
+		if ($from->{'href'}) {
+			$from_link = $cgi->a({-href=>$from->{'href'}, -class=>"hash"},
+			                     substr($diffinfo->{'from_id'},0,7));
+		} else {
+			$from_link = '0' x 7;
+		}
+		if ($to->{'href'}) {
+			$to_link = $cgi->a({-href=>$to->{'href'}, -class=>"hash"},
+			                   substr($diffinfo->{'to_id'},0,7));
+		} else {
+			$to_link = '0' x 7;
+		}
+		my ($from_id, $to_id) = ($diffinfo->{'from_id'}, $diffinfo->{'to_id'});
+		$line =~ s!$from_id\.\.$to_id!$from_link..$to_link!;
+	}
+
+	return $line . "<br/>\n";
+}
+
+# format from-file/to-file diff header
+sub format_diff_from_to_header {
+	my ($from_line, $to_line, $diffinfo, $from, $to, @parents) = @_;
+	my $line;
+	my $result = '';
+
+	$line = $from_line;
+	#assert($line =~ m/^---/) if DEBUG;
+	# no extra formatting for "^--- /dev/null"
+	if (! $diffinfo->{'nparents'}) {
+		# ordinary (single parent) diff
+		if ($line =~ m!^--- "?a/!) {
+			if ($from->{'href'}) {
+				$line = '--- a/' .
+				        $cgi->a({-href=>$from->{'href'}, -class=>"path"},
+				                esc_path($from->{'file'}));
+			} else {
+				$line = '--- a/' .
+				        esc_path($from->{'file'});
+			}
+		}
+		$result .= qq!<div class="diff from_file">$line</div>\n!;
+
+	} else {
+		# combined diff (merge commit)
+		for (my $i = 0; $i < $diffinfo->{'nparents'}; $i++) {
+			if ($from->{'href'}[$i]) {
+				$line = '--- ' .
+				        $cgi->a({-href=>href(action=>"blobdiff",
+				                             hash_parent=>$diffinfo->{'from_id'}[$i],
+				                             hash_parent_base=>$parents[$i],
+				                             file_parent=>$from->{'file'}[$i],
+				                             hash=>$diffinfo->{'to_id'},
+				                             hash_base=>$hash,
+				                             file_name=>$to->{'file'}),
+				                 -class=>"path",
+				                 -title=>"diff" . ($i+1)},
+				                $i+1) .
+				        '/' .
+				        $cgi->a({-href=>$from->{'href'}[$i], -class=>"path"},
+				                esc_path($from->{'file'}[$i]));
+			} else {
+				$line = '--- /dev/null';
+			}
+			$result .= qq!<div class="diff from_file">$line</div>\n!;
+		}
+	}
+
+	$line = $to_line;
+	#assert($line =~ m/^\+\+\+/) if DEBUG;
+	# no extra formatting for "^+++ /dev/null"
+	if ($line =~ m!^\+\+\+ "?b/!) {
+		if ($to->{'href'}) {
+			$line = '+++ b/' .
+			        $cgi->a({-href=>$to->{'href'}, -class=>"path"},
+			                esc_path($to->{'file'}));
+		} else {
+			$line = '+++ b/' .
+			        esc_path($to->{'file'});
+		}
+	}
+	$result .= qq!<div class="diff to_file">$line</div>\n!;
+
+	return $result;
+}
+
+# create note for patch simplified by combined diff
+sub format_diff_cc_simplified {
+	my ($diffinfo, @parents) = @_;
+	my $result = '';
+
+	$result .= "<div class=\"diff header\">" .
+	           "diff --cc ";
+	if (!is_deleted($diffinfo)) {
+		$result .= $cgi->a({-href => href(action=>"blob",
+		                                  hash_base=>$hash,
+		                                  hash=>$diffinfo->{'to_id'},
+		                                  file_name=>$diffinfo->{'to_file'}),
+		                    -class => "path"},
+		                   esc_path($diffinfo->{'to_file'}));
+	} else {
+		$result .= esc_path($diffinfo->{'to_file'});
+	}
+	$result .= "</div>\n" . # class="diff header"
+	           "<div class=\"diff nodifferences\">" .
+	           "Simple merge" .
+	           "</div>\n"; # class="diff nodifferences"
+
+	return $result;
+}
+
+# format patch (diff) line (not to be used for diff headers)
+sub format_diff_line {
+	my $line = shift;
+	my ($from, $to) = @_;
+	my $diff_class = "";
+
+	chomp $line;
+
+	if ($from && $to && ref($from->{'href'}) eq "ARRAY") {
+		# combined diff
+		my $prefix = substr($line, 0, scalar @{$from->{'href'}});
+		if ($line =~ m/^\@{3}/) {
+			$diff_class = " chunk_header";
+		} elsif ($line =~ m/^\\/) {
+			$diff_class = " incomplete";
+		} elsif ($prefix =~ tr/+/+/) {
+			$diff_class = " add";
+		} elsif ($prefix =~ tr/-/-/) {
+			$diff_class = " rem";
+		}
+	} else {
+		# assume ordinary diff
+		my $char = substr($line, 0, 1);
+		if ($char eq '+') {
+			$diff_class = " add";
+		} elsif ($char eq '-') {
+			$diff_class = " rem";
+		} elsif ($char eq '@') {
+			$diff_class = " chunk_header";
+		} elsif ($char eq "\\") {
+			$diff_class = " incomplete";
+		}
+	}
+	$line = untabify($line);
+	if ($from && $to && $line =~ m/^\@{2} /) {
+		my ($from_text, $from_start, $from_lines, $to_text, $to_start, $to_lines, $section) =
+			$line =~ m/^\@{2} (-(\d+)(?:,(\d+))?) (\+(\d+)(?:,(\d+))?) \@{2}(.*)$/;
+
+		$from_lines = 0 unless defined $from_lines;
+		$to_lines   = 0 unless defined $to_lines;
+
+		if ($from->{'href'}) {
+			$from_text = $cgi->a({-href=>"$from->{'href'}#l$from_start",
+			                     -class=>"list"}, $from_text);
+		}
+		if ($to->{'href'}) {
+			$to_text   = $cgi->a({-href=>"$to->{'href'}#l$to_start",
+			                     -class=>"list"}, $to_text);
+		}
+		$line = "<span class=\"chunk_info\">@@ $from_text $to_text @@</span>" .
+		        "<span class=\"section\">" . esc_html($section, -nbsp=>1) . "</span>";
+		return "<div class=\"diff$diff_class\">$line</div>\n";
+	} elsif ($from && $to && $line =~ m/^\@{3}/) {
+		my ($prefix, $ranges, $section) = $line =~ m/^(\@+) (.*?) \@+(.*)$/;
+		my (@from_text, @from_start, @from_nlines, $to_text, $to_start, $to_nlines);
+
+		@from_text = split(' ', $ranges);
+		for (my $i = 0; $i < @from_text; ++$i) {
+			($from_start[$i], $from_nlines[$i]) =
+				(split(',', substr($from_text[$i], 1)), 0);
+		}
+
+		$to_text   = pop @from_text;
+		$to_start  = pop @from_start;
+		$to_nlines = pop @from_nlines;
+
+		$line = "<span class=\"chunk_info\">$prefix ";
+		for (my $i = 0; $i < @from_text; ++$i) {
+			if ($from->{'href'}[$i]) {
+				$line .= $cgi->a({-href=>"$from->{'href'}[$i]#l$from_start[$i]",
+				                  -class=>"list"}, $from_text[$i]);
+			} else {
+				$line .= $from_text[$i];
+			}
+			$line .= " ";
+		}
+		if ($to->{'href'}) {
+			$line .= $cgi->a({-href=>"$to->{'href'}#l$to_start",
+			                  -class=>"list"}, $to_text);
+		} else {
+			$line .= $to_text;
+		}
+		$line .= " $prefix</span>" .
+		         "<span class=\"section\">" . esc_html($section, -nbsp=>1) . "</span>";
+		return "<div class=\"diff$diff_class\">$line</div>\n";
+	}
+	return "<div class=\"diff$diff_class\">" . esc_html($line, -nbsp=>1) . "</div>\n";
+}
+
+# Generates undef or something like "_snapshot_" or "snapshot (_tbz2_ _zip_)",
+# linked.  Pass the hash of the tree/commit to snapshot.
+sub format_snapshot_links {
+	my ($hash) = @_;
+	my $num_fmts = @snapshot_fmts;
+	if ($num_fmts > 1) {
+		# A parenthesized list of links bearing format names.
+		# e.g. "snapshot (_tar.gz_ _zip_)"
+		return "snapshot (" . join(' ', map
+			$cgi->a({
+				-href => href(
+					action=>"snapshot",
+					hash=>$hash,
+					snapshot_format=>$_
+				)
+			}, $known_snapshot_formats{$_}{'display'})
+		, @snapshot_fmts) . ")";
+	} elsif ($num_fmts == 1) {
+		# A single "snapshot" link whose tooltip bears the format name.
+		# i.e. "_snapshot_"
+		my ($fmt) = @snapshot_fmts;
+		return
+			$cgi->a({
+				-href => href(
+					action=>"snapshot",
+					hash=>$hash,
+					snapshot_format=>$fmt
+				),
+				-title => "in format: $known_snapshot_formats{$fmt}{'display'}"
+			}, "snapshot");
+	} else { # $num_fmts == 0
+		return undef;
+	}
+}
+
+1;
-- 
1.7.1.454.g276eb9.dirty
