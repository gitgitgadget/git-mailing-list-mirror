From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH 08/11 GSoC] gitweb: Create Gitweb::View module
Date: Tue, 22 Jun 2010 03:30:44 +0530
Message-ID: <1277157648-6029-9-git-send-email-pavan.sss1991@gmail.com>
References: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Tue Jun 22 00:03:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQp5o-0000An-Mc
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 00:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932913Ab0FUWDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 18:03:40 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53611 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932882Ab0FUWDj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 18:03:39 -0400
Received: by pwj8 with SMTP id 8so529181pwj.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 15:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=PtMRO9JtSRQC7WsV86yeUblNXRmDapNyN0gd6/apVX8=;
        b=H7uvTl1BlYyMAdwiLPDJseKb+wk6Rp9yJoeX4fsLtTPjaewdzkeBbk6zgRt3rU29Db
         XGydbvMSi3qx2Fru48jbyPkJ/lqbJf9KMlWmxnDQcu2hiuQdQwgF2mxA9yhKTtTFEddB
         FWHT/6YTdME1A78KExKfvRDUYBSUsyIO4R9dw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MZGhy7AsdL36bfdnEXLL4gaEV7QJUmbDV9r7rbu00hx3Bfm5aa8hIQwHIZnKp7SKiC
         OsmGASvZ8PaLHaL09ED+fpEayHtzthJuDdTUOJjmEBqemcJrQeamKjL1unr28InQQZe7
         PFV1xK6d3UBjcP12H4bAot3j5ksMZRI035dcg=
Received: by 10.142.74.6 with SMTP id w6mr4170370wfa.249.1277157818474;
        Mon, 21 Jun 2010 15:03:38 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.132])
        by mx.google.com with ESMTPS id y27sm525703wfi.17.2010.06.21.15.03.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jun 2010 15:03:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.454.g6bbe9.dirty
In-Reply-To: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149450>

Create Gitweb::View module in 'gitweb/lib/Gitweb/View.pm'
to store the subroutines related to the HTML output
for gitweb.

This module depends on Git.pm, Config.pm, Request.pm,
Escape.pm and RepoConfig.pm. Some subroutines which
output HTML but are not included in this module due
to unmet dependencies

Subroutines moved:
	href
	chop_str
	chop_and_escape_str
	age_class
	age_string
	S_ISGITLINK
	mode_str
	file_type
	file_type_long
	get_page_title
	git_header_html
	git_footer_html
	die_error
	git_print_page_nav
	format_paging_nav
	get_feed_info
	insert_file
	git_print_header_div
	print_local_time
	format_local_time
	git_print_page_path
	git_get_link_target
	normalize_link_target
	git_print_tree_entry
	print_sort_th
	format_sort_th

Update 'gitweb/Makefile' to install Gitweb::View alongside gitweb.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 gitweb/Makefile           |    1 +
 gitweb/gitweb.perl        |  996 +-------------------------------------------
 gitweb/lib/Gitweb/View.pm | 1022 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1024 insertions(+), 995 deletions(-)
 create mode 100644 gitweb/lib/Gitweb/View.pm

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 3ae6745..cd2555d 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -117,6 +117,7 @@ GITWEB_MODULES += lib/Gitweb/Config.pm
 GITWEB_MODULES += lib/Gitweb/Request.pm
 GITWEB_MODULES += lib/Gitweb/Escape.pm
 GITWEB_MODULES += lib/Gitweb/RepoConfig.pm
+GITWEB_MODULES += lib/Gitweb/View.pm
 
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 87f52d2..909dd81 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -30,6 +30,7 @@ use Gitweb::Config;
 use Gitweb::Request;
 use Gitweb::Escape;
 use Gitweb::RepoConfig;
+use Gitweb::View;
 
 BEGIN {
 	CGI->compile() if $ENV{'MOD_PERL'};
@@ -553,128 +554,6 @@ if (defined caller) {
 }
 
 ## ======================================================================
-## action links
-
-# possible values of extra options
-# -full => 0|1      - use absolute/full URL ($my_uri/$my_url as base)
-# -replay => 1      - start from a current view (replay with modifications)
-# -path_info => 0|1 - don't use/use path_info URL (if possible)
-sub href {
-	my %params = @_;
-	# default is to use -absolute url() i.e. $my_uri
-	my $href = $params{-full} ? $my_url : $my_uri;
-
-	$params{'project'} = $project unless exists $params{'project'};
-
-	if ($params{-replay}) {
-		while (my ($name, $symbol) = each %cgi_param_mapping) {
-			if (!exists $params{$name}) {
-				$params{$name} = $input_params{$name};
-			}
-		}
-	}
-
-	my $use_pathinfo = gitweb_check_feature('pathinfo');
-	if (defined $params{'project'} &&
-	    (exists $params{-path_info} ? $params{-path_info} : $use_pathinfo)) {
-		# try to put as many parameters as possible in PATH_INFO:
-		#   - project name
-		#   - action
-		#   - hash_parent or hash_parent_base:/file_parent
-		#   - hash or hash_base:/filename
-		#   - the snapshot_format as an appropriate suffix
-
-		# When the script is the root DirectoryIndex for the domain,
-		# $href here would be something like http://gitweb.example.com/
-		# Thus, we strip any trailing / from $href, to spare us double
-		# slashes in the final URL
-		$href =~ s,/$,,;
-
-		# Then add the project name, if present
-		$href .= "/".esc_url($params{'project'});
-		delete $params{'project'};
-
-		# since we destructively absorb parameters, we keep this
-		# boolean that remembers if we're handling a snapshot
-		my $is_snapshot = $params{'action'} eq 'snapshot';
-
-		# Summary just uses the project path URL, any other action is
-		# added to the URL
-		if (defined $params{'action'}) {
-			$href .= "/".esc_url($params{'action'}) unless $params{'action'} eq 'summary';
-			delete $params{'action'};
-		}
-
-		# Next, we put hash_parent_base:/file_parent..hash_base:/file_name,
-		# stripping nonexistent or useless pieces
-		$href .= "/" if ($params{'hash_base'} || $params{'hash_parent_base'}
-			|| $params{'hash_parent'} || $params{'hash'});
-		if (defined $params{'hash_base'}) {
-			if (defined $params{'hash_parent_base'}) {
-				$href .= esc_url($params{'hash_parent_base'});
-				# skip the file_parent if it's the same as the file_name
-				if (defined $params{'file_parent'}) {
-					if (defined $params{'file_name'} && $params{'file_parent'} eq $params{'file_name'}) {
-						delete $params{'file_parent'};
-					} elsif ($params{'file_parent'} !~ /\.\./) {
-						$href .= ":/".esc_url($params{'file_parent'});
-						delete $params{'file_parent'};
-					}
-				}
-				$href .= "..";
-				delete $params{'hash_parent'};
-				delete $params{'hash_parent_base'};
-			} elsif (defined $params{'hash_parent'}) {
-				$href .= esc_url($params{'hash_parent'}). "..";
-				delete $params{'hash_parent'};
-			}
-
-			$href .= esc_url($params{'hash_base'});
-			if (defined $params{'file_name'} && $params{'file_name'} !~ /\.\./) {
-				$href .= ":/".esc_url($params{'file_name'});
-				delete $params{'file_name'};
-			}
-			delete $params{'hash'};
-			delete $params{'hash_base'};
-		} elsif (defined $params{'hash'}) {
-			$href .= esc_url($params{'hash'});
-			delete $params{'hash'};
-		}
-
-		# If the action was a snapshot, we can absorb the
-		# snapshot_format parameter too
-		if ($is_snapshot) {
-			my $fmt = $params{'snapshot_format'};
-			# snapshot_format should always be defined when href()
-			# is called, but just in case some code forgets, we
-			# fall back to the default
-			$fmt ||= $snapshot_fmts[0];
-			$href .= $known_snapshot_formats{$fmt}{'suffix'};
-			delete $params{'snapshot_format'};
-		}
-	}
-
-	# now encode the parameters explicitly
-	my @result = ();
-	for (my $i = 0; $i < @cgi_param_mapping; $i += 2) {
-		my ($name, $symbol) = ($cgi_param_mapping[$i], $cgi_param_mapping[$i+1]);
-		if (defined $params{$name}) {
-			if (ref($params{$name}) eq "ARRAY") {
-				foreach my $par (@{$params{$name}}) {
-					push @result, $symbol . "=" . esc_param($par);
-				}
-			} else {
-				push @result, $symbol . "=" . esc_param($params{$name});
-			}
-		}
-	}
-	$href .= "?" . join(';', @result) if scalar @result;
-
-	return $href;
-}
-
-
-## ======================================================================
 ## validation, quoting/unquoting and escaping
 
 sub validate_action {
@@ -696,219 +575,6 @@ sub validate_project {
 }
 
 ## ----------------------------------------------------------------------
-## HTML aware string manipulation
-
-# Try to chop given string on a word boundary between position
-# $len and $len+$add_len. If there is no word boundary there,
-# chop at $len+$add_len. Do not chop if chopped part plus ellipsis
-# (marking chopped part) would be longer than given string.
-sub chop_str {
-	my $str = shift;
-	my $len = shift;
-	my $add_len = shift || 10;
-	my $where = shift || 'right'; # 'left' | 'center' | 'right'
-
-	# Make sure perl knows it is utf8 encoded so we don't
-	# cut in the middle of a utf8 multibyte char.
-	$str = to_utf8($str);
-
-	# allow only $len chars, but don't cut a word if it would fit in $add_len
-	# if it doesn't fit, cut it if it's still longer than the dots we would add
-	# remove chopped character entities entirely
-
-	# when chopping in the middle, distribute $len into left and right part
-	# return early if chopping wouldn't make string shorter
-	if ($where eq 'center') {
-		return $str if ($len + 5 >= length($str)); # filler is length 5
-		$len = int($len/2);
-	} else {
-		return $str if ($len + 4 >= length($str)); # filler is length 4
-	}
-
-	# regexps: ending and beginning with word part up to $add_len
-	my $endre = qr/.{$len}\w{0,$add_len}/;
-	my $begre = qr/\w{0,$add_len}.{$len}/;
-
-	if ($where eq 'left') {
-		$str =~ m/^(.*?)($begre)$/;
-		my ($lead, $body) = ($1, $2);
-		if (length($lead) > 4) {
-			$lead = " ...";
-		}
-		return "$lead$body";
-
-	} elsif ($where eq 'center') {
-		$str =~ m/^($endre)(.*)$/;
-		my ($left, $str)  = ($1, $2);
-		$str =~ m/^(.*?)($begre)$/;
-		my ($mid, $right) = ($1, $2);
-		if (length($mid) > 5) {
-			$mid = " ... ";
-		}
-		return "$left$mid$right";
-
-	} else {
-		$str =~ m/^($endre)(.*)$/;
-		my $body = $1;
-		my $tail = $2;
-		if (length($tail) > 4) {
-			$tail = "... ";
-		}
-		return "$body$tail";
-	}
-}
-
-# takes the same arguments as chop_str, but also wraps a <span> around the
-# result with a title attribute if it does get chopped. Additionally, the
-# string is HTML-escaped.
-sub chop_and_escape_str {
-	my ($str) = @_;
-
-	my $chopped = chop_str(@_);
-	if ($chopped eq $str) {
-		return esc_html($chopped);
-	} else {
-		$str =~ s/[[:cntrl:]]/?/g;
-		return $cgi->span({-title=>$str}, esc_html($chopped));
-	}
-}
-
-## ----------------------------------------------------------------------
-## functions returning short strings
-
-# CSS class for given age value (in seconds)
-sub age_class {
-	my $age = shift;
-
-	if (!defined $age) {
-		return "noage";
-	} elsif ($age < 60*60*2) {
-		return "age0";
-	} elsif ($age < 60*60*24*2) {
-		return "age1";
-	} else {
-		return "age2";
-	}
-}
-
-# convert age in seconds to "nn units ago" string
-sub age_string {
-	my $age = shift;
-	my $age_str;
-
-	if ($age > 60*60*24*365*2) {
-		$age_str = (int $age/60/60/24/365);
-		$age_str .= " years ago";
-	} elsif ($age > 60*60*24*(365/12)*2) {
-		$age_str = int $age/60/60/24/(365/12);
-		$age_str .= " months ago";
-	} elsif ($age > 60*60*24*7*2) {
-		$age_str = int $age/60/60/24/7;
-		$age_str .= " weeks ago";
-	} elsif ($age > 60*60*24*2) {
-		$age_str = int $age/60/60/24;
-		$age_str .= " days ago";
-	} elsif ($age > 60*60*2) {
-		$age_str = int $age/60/60;
-		$age_str .= " hours ago";
-	} elsif ($age > 60*2) {
-		$age_str = int $age/60;
-		$age_str .= " min ago";
-	} elsif ($age > 2) {
-		$age_str = int $age;
-		$age_str .= " sec ago";
-	} else {
-		$age_str .= " right now";
-	}
-	return $age_str;
-}
-
-use constant {
-	S_IFINVALID => 0030000,
-	S_IFGITLINK => 0160000,
-};
-
-# submodule/subproject, a commit object reference
-sub S_ISGITLINK {
-	my $mode = shift;
-
-	return (($mode & S_IFMT) == S_IFGITLINK)
-}
-
-# convert file mode in octal to symbolic file mode string
-sub mode_str {
-	my $mode = oct shift;
-
-	if (S_ISGITLINK($mode)) {
-		return 'm---------';
-	} elsif (S_ISDIR($mode & S_IFMT)) {
-		return 'drwxr-xr-x';
-	} elsif (S_ISLNK($mode)) {
-		return 'lrwxrwxrwx';
-	} elsif (S_ISREG($mode)) {
-		# git cares only about the executable bit
-		if ($mode & S_IXUSR) {
-			return '-rwxr-xr-x';
-		} else {
-			return '-rw-r--r--';
-		};
-	} else {
-		return '----------';
-	}
-}
-
-# convert file mode in octal to file type string
-sub file_type {
-	my $mode = shift;
-
-	if ($mode !~ m/^[0-7]+$/) {
-		return $mode;
-	} else {
-		$mode = oct $mode;
-	}
-
-	if (S_ISGITLINK($mode)) {
-		return "submodule";
-	} elsif (S_ISDIR($mode & S_IFMT)) {
-		return "directory";
-	} elsif (S_ISLNK($mode)) {
-		return "symlink";
-	} elsif (S_ISREG($mode)) {
-		return "file";
-	} else {
-		return "unknown";
-	}
-}
-
-# convert file mode in octal to file type description string
-sub file_type_long {
-	my $mode = shift;
-
-	if ($mode !~ m/^[0-7]+$/) {
-		return $mode;
-	} else {
-		$mode = oct $mode;
-	}
-
-	if (S_ISGITLINK($mode)) {
-		return "submodule";
-	} elsif (S_ISDIR($mode & S_IFMT)) {
-		return "directory";
-	} elsif (S_ISLNK($mode)) {
-		return "symlink";
-	} elsif (S_ISREG($mode)) {
-		if ($mode & S_IXUSR) {
-			return "executable";
-		} else {
-			return "file";
-		};
-	} else {
-		return "unknown";
-	}
-}
-
-
-## ----------------------------------------------------------------------
 ## functions returning short HTML fragments, or transforming HTML fragments
 ## which don't belong to other sections
 
@@ -1419,46 +1085,6 @@ sub format_snapshot_links {
 	}
 }
 
-## ......................................................................
-## functions returning values to be passed, perhaps after some
-## transformation, to other functions; e.g. returning arguments to href()
-
-# returns hash to be passed to href to generate gitweb URL
-# in -title key it returns description of link
-sub get_feed_info {
-	my $format = shift || 'Atom';
-	my %res = (action => lc($format));
-
-	# feed links are possible only for project views
-	return unless (defined $project);
-	# some views should link to OPML, or to generic project feed,
-	# or don't have specific feed yet (so they should use generic)
-	return if ($action =~ /^(?:tags|heads|forks|tag|search)$/x);
-
-	my $branch;
-	# branches refs uses 'refs/heads/' prefix (fullname) to differentiate
-	# from tag links; this also makes possible to detect branch links
-	if ((defined $hash_base && $hash_base =~ m!^refs/heads/(.*)$!) ||
-	    (defined $hash      && $hash      =~ m!^refs/heads/(.*)$!)) {
-		$branch = $1;
-	}
-	# find log type for feed description (title)
-	my $type = 'log';
-	if (defined $file_name) {
-		$type  = "history of $file_name";
-		$type .= "/" if ($action eq 'tree');
-		$type .= " on '$branch'" if (defined $branch);
-	} else {
-		$type = "log of $branch" if (defined $branch);
-	}
-
-	$res{-title} = $type;
-	$res{'hash'} = (defined $branch ? "refs/heads/$branch" : undef);
-	$res{'file_name'} = $file_name;
-
-	return %res;
-}
-
 ## ----------------------------------------------------------------------
 ## git utility subroutines, invoking git commands
 
@@ -2061,18 +1687,6 @@ sub git_get_tags_list {
 	return wantarray ? @tagslist : \@tagslist;
 }
 
-## ----------------------------------------------------------------------
-## filesystem-related functions
-
-# assume that file exists
-sub insert_file {
-	my $filename = shift;
-
-	open my $fd, '<', $filename;
-	print map { to_utf8($_) } <$fd>;
-	close $fd;
-}
-
 ## ......................................................................
 ## mimetype related functions
 
@@ -2209,405 +1823,9 @@ sub run_highlighter {
 	return $fd;
 }
 
-## ======================================================================
-## functions printing HTML: header, footer, error page
-
-sub get_page_title {
-	my $title = to_utf8($site_name);
-
-	return $title unless (defined $project);
-	$title .= " - " . to_utf8($project);
-
-	return $title unless (defined $action);
-	$title .= "/$action"; # $action is US-ASCII (7bit ASCII)
-
-	return $title unless (defined $file_name);
-	$title .= " - " . esc_path($file_name);
-	if ($action eq "tree" && $file_name !~ m|/$|) {
-		$title .= "/";
-	}
-
-	return $title;
-}
-
-sub git_header_html {
-	my $status = shift || "200 OK";
-	my $expires = shift;
-	my %opts = @_;
-
-	my $title = get_page_title();
-	my $content_type;
-	# require explicit support from the UA if we are to send the page as
-	# 'application/xhtml+xml', otherwise send it as plain old 'text/html'.
-	# we have to do this because MSIE sometimes globs '*/*', pretending to
-	# support xhtml+xml but choking when it gets what it asked for.
-	if (defined $cgi->http('HTTP_ACCEPT') &&
-	    $cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ &&
-	    $cgi->Accept('application/xhtml+xml') != 0) {
-		$content_type = 'application/xhtml+xml';
-	} else {
-		$content_type = 'text/html';
-	}
-	print $cgi->header(-type=>$content_type, -charset => 'utf-8',
-	                   -status=> $status, -expires => $expires)
-		unless ($opts{'-no_http_header'});
-	my $mod_perl_version = $ENV{'MOD_PERL'} ? " $ENV{'MOD_PERL'}" : '';
-	print <<EOF;
-<?xml version="1.0" encoding="utf-8"?>
-<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
-<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
-<!-- git web interface version $version, (C) 2005-2006, Kay Sievers <kay.sievers\@vrfy.org>, Christian Gierke -->
-<!-- git core binaries version $git_version -->
-<head>
-<meta http-equiv="content-type" content="$content_type; charset=utf-8"/>
-<meta name="generator" content="gitweb/$version git/$git_version$mod_perl_version"/>
-<meta name="robots" content="index, nofollow"/>
-<title>$title</title>
-EOF
-	# the stylesheet, favicon etc urls won't work correctly with path_info
-	# unless we set the appropriate base URL
-	if ($ENV{'PATH_INFO'}) {
-		print "<base href=\"".esc_url($base_url)."\" />\n";
-	}
-	# print out each stylesheet that exist, providing backwards capability
-	# for those people who defined $stylesheet in a config file
-	if (defined $stylesheet) {
-		print '<link rel="stylesheet" type="text/css" href="'.$stylesheet.'"/>'."\n";
-	} else {
-		foreach my $stylesheet (@stylesheets) {
-			next unless $stylesheet;
-			print '<link rel="stylesheet" type="text/css" href="'.$stylesheet.'"/>'."\n";
-		}
-	}
-	if (defined $project) {
-		my %href_params = get_feed_info();
-		if (!exists $href_params{'-title'}) {
-			$href_params{'-title'} = 'log';
-		}
-
-		foreach my $format qw(RSS Atom) {
-			my $type = lc($format);
-			my %link_attr = (
-				'-rel' => 'alternate',
-				'-title' => "$project - $href_params{'-title'} - $format feed",
-				'-type' => "application/$type+xml"
-			);
-
-			$href_params{'action'} = $type;
-			$link_attr{'-href'} = href(%href_params);
-			print "<link ".
-			      "rel=\"$link_attr{'-rel'}\" ".
-			      "title=\"$link_attr{'-title'}\" ".
-			      "href=\"$link_attr{'-href'}\" ".
-			      "type=\"$link_attr{'-type'}\" ".
-			      "/>\n";
-
-			$href_params{'extra_options'} = '--no-merges';
-			$link_attr{'-href'} = href(%href_params);
-			$link_attr{'-title'} .= ' (no merges)';
-			print "<link ".
-			      "rel=\"$link_attr{'-rel'}\" ".
-			      "title=\"$link_attr{'-title'}\" ".
-			      "href=\"$link_attr{'-href'}\" ".
-			      "type=\"$link_attr{'-type'}\" ".
-			      "/>\n";
-		}
-
-	} else {
-		printf('<link rel="alternate" title="%s projects list" '.
-		       'href="%s" type="text/plain; charset=utf-8" />'."\n",
-		       $site_name, href(project=>undef, action=>"project_index"));
-		printf('<link rel="alternate" title="%s projects feeds" '.
-		       'href="%s" type="text/x-opml" />'."\n",
-		       $site_name, href(project=>undef, action=>"opml"));
-	}
-	if (defined $favicon) {
-		print qq(<link rel="shortcut icon" href="$favicon" type="image/png" />\n);
-	}
-
-	print "</head>\n" .
-	      "<body>\n";
-
-	if (defined $site_header && -f $site_header) {
-		insert_file($site_header);
-	}
-
-	print "<div class=\"page_header\">\n" .
-	      $cgi->a({-href => esc_url($logo_url),
-	               -title => $logo_label},
-	              qq(<img src="$logo" width="72" height="27" alt="git" class="logo"/>));
-	print $cgi->a({-href => esc_url($home_link)}, $home_link_str) . " / ";
-	if (defined $project) {
-		print $cgi->a({-href => href(action=>"summary")}, esc_html($project));
-		if (defined $action) {
-			print " / $action";
-		}
-		print "\n";
-	}
-	print "</div>\n";
-
-	my $have_search = gitweb_check_feature('search');
-	if (defined $project && $have_search) {
-		if (!defined $searchtext) {
-			$searchtext = "";
-		}
-		my $search_hash;
-		if (defined $hash_base) {
-			$search_hash = $hash_base;
-		} elsif (defined $hash) {
-			$search_hash = $hash;
-		} else {
-			$search_hash = "HEAD";
-		}
-		my $action = $my_uri;
-		my $use_pathinfo = gitweb_check_feature('pathinfo');
-		if ($use_pathinfo) {
-			$action .= "/".esc_url($project);
-		}
-		print $cgi->startform(-method => "get", -action => $action) .
-		      "<div class=\"search\">\n" .
-		      (!$use_pathinfo &&
-		      $cgi->input({-name=>"p", -value=>$project, -type=>"hidden"}) . "\n") .
-		      $cgi->input({-name=>"a", -value=>"search", -type=>"hidden"}) . "\n" .
-		      $cgi->input({-name=>"h", -value=>$search_hash, -type=>"hidden"}) . "\n" .
-		      $cgi->popup_menu(-name => 'st', -default => 'commit',
-		                       -values => ['commit', 'grep', 'author', 'committer', 'pickaxe']) .
-		      $cgi->sup($cgi->a({-href => href(action=>"search_help")}, "?")) .
-		      " search:\n",
-		      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
-		      "<span title=\"Extended regular expression\">" .
-		      $cgi->checkbox(-name => 'sr', -value => 1, -label => 're',
-		                     -checked => $search_use_regexp) .
-		      "</span>" .
-		      "</div>" .
-		      $cgi->end_form() . "\n";
-	}
-}
-
-sub git_footer_html {
-	my $feed_class = 'rss_logo';
-
-	print "<div class=\"page_footer\">\n";
-	if (defined $project) {
-		my $descr = git_get_project_description($project);
-		if (defined $descr) {
-			print "<div class=\"page_footer_text\">" . esc_html($descr) . "</div>\n";
-		}
-
-		my %href_params = get_feed_info();
-		if (!%href_params) {
-			$feed_class .= ' generic';
-		}
-		$href_params{'-title'} ||= 'log';
-
-		foreach my $format qw(RSS Atom) {
-			$href_params{'action'} = lc($format);
-			print $cgi->a({-href => href(%href_params),
-			              -title => "$href_params{'-title'} $format feed",
-			              -class => $feed_class}, $format)."\n";
-		}
-
-	} else {
-		print $cgi->a({-href => href(project=>undef, action=>"opml"),
-		              -class => $feed_class}, "OPML") . " ";
-		print $cgi->a({-href => href(project=>undef, action=>"project_index"),
-		              -class => $feed_class}, "TXT") . "\n";
-	}
-	print "</div>\n"; # class="page_footer"
-
-	if (defined $t0 && gitweb_check_feature('timed')) {
-		print "<div id=\"generating_info\">\n";
-		print 'This page took '.
-		      '<span id="generating_time" class="time_span">'.
-		      Time::HiRes::tv_interval($t0, [Time::HiRes::gettimeofday()]).
-		      ' seconds </span>'.
-		      ' and '.
-		      '<span id="generating_cmd">'.
-		      $number_of_git_cmds.
-		      '</span> git commands '.
-		      " to generate.\n";
-		print "</div>\n"; # class="page_footer"
-	}
-
-	if (defined $site_footer && -f $site_footer) {
-		insert_file($site_footer);
-	}
-
-	print qq!<script type="text/javascript" src="$javascript"></script>\n!;
-	if (defined $action &&
-	    $action eq 'blame_incremental') {
-		print qq!<script type="text/javascript">\n!.
-		      qq!startBlame("!. href(action=>"blame_data", -replay=>1) .qq!",\n!.
-		      qq!           "!. href() .qq!");\n!.
-		      qq!</script>\n!;
-	} elsif (gitweb_check_feature('javascript-actions')) {
-		print qq!<script type="text/javascript">\n!.
-		      qq!window.onload = fixLinks;\n!.
-		      qq!</script>\n!;
-	}
-
-	print "</body>\n" .
-	      "</html>";
-}
-
-# die_error(<http_status_code>, <error_message>[, <detailed_html_description>])
-# Example: die_error(404, 'Hash not found')
-# By convention, use the following status codes (as defined in RFC 2616):
-# 400: Invalid or missing CGI parameters, or
-#      requested object exists but has wrong type.
-# 403: Requested feature (like "pickaxe" or "snapshot") not enabled on
-#      this server or project.
-# 404: Requested object/revision/project doesn't exist.
-# 500: The server isn't configured properly, or
-#      an internal error occurred (e.g. failed assertions caused by bugs), or
-#      an unknown error occurred (e.g. the git binary died unexpectedly).
-# 503: The server is currently unavailable (because it is overloaded,
-#      or down for maintenance).  Generally, this is a temporary state.
-sub die_error {
-	my $status = shift || 500;
-	my $error = esc_html(shift) || "Internal Server Error";
-	my $extra = shift;
-	my %opts = @_;
-
-	my %http_responses = (
-		400 => '400 Bad Request',
-		403 => '403 Forbidden',
-		404 => '404 Not Found',
-		500 => '500 Internal Server Error',
-		503 => '503 Service Unavailable',
-	);
-	git_header_html($http_responses{$status}, undef, %opts);
-	print <<EOF;
-<div class="page_body">
-<br /><br />
-$status - $error
-<br />
-EOF
-	if (defined $extra) {
-		print "<hr />\n" .
-		      "$extra\n";
-	}
-	print "</div>\n";
-
-	git_footer_html();
-	goto DONE_GITWEB
-		unless ($opts{'-error_handler'});
-}
-
-## ----------------------------------------------------------------------
-## functions printing or outputting HTML: navigation
-
-sub git_print_page_nav {
-	my ($current, $suppress, $head, $treehead, $treebase, $extra) = @_;
-	$extra = '' if !defined $extra; # pager or formats
-
-	my @navs = qw(summary shortlog log commit commitdiff tree);
-	if ($suppress) {
-		@navs = grep { $_ ne $suppress } @navs;
-	}
-
-	my %arg = map { $_ => {action=>$_} } @navs;
-	if (defined $head) {
-		for (qw(commit commitdiff)) {
-			$arg{$_}{'hash'} = $head;
-		}
-		if ($current =~ m/^(tree | log | shortlog | commit | commitdiff | search)$/x) {
-			for (qw(shortlog log)) {
-				$arg{$_}{'hash'} = $head;
-			}
-		}
-	}
-
-	$arg{'tree'}{'hash'} = $treehead if defined $treehead;
-	$arg{'tree'}{'hash_base'} = $treebase if defined $treebase;
-
-	my @actions = gitweb_get_feature('actions');
-	my %repl = (
-		'%' => '%',
-		'n' => $project,         # project name
-		'f' => $git_dir,         # project path within filesystem
-		'h' => $treehead || '',  # current hash ('h' parameter)
-		'b' => $treebase || '',  # hash base ('hb' parameter)
-	);
-	while (@actions) {
-		my ($label, $link, $pos) = splice(@actions,0,3);
-		# insert
-		@navs = map { $_ eq $pos ? ($_, $label) : $_ } @navs;
-		# munch munch
-		$link =~ s/%([%nfhb])/$repl{$1}/g;
-		$arg{$label}{'_href'} = $link;
-	}
-
-	print "<div class=\"page_nav\">\n" .
-		(join " | ",
-		 map { $_ eq $current ?
-		       $_ : $cgi->a({-href => ($arg{$_}{_href} ? $arg{$_}{_href} : href(%{$arg{$_}}))}, "$_")
-		 } @navs);
-	print "<br/>\n$extra<br/>\n" .
-	      "</div>\n";
-}
-
-sub format_paging_nav {
-	my ($action, $page, $has_next_link) = @_;
-	my $paging_nav;
-
-
-	if ($page > 0) {
-		$paging_nav .=
-			$cgi->a({-href => href(-replay=>1, page=>undef)}, "first") .
-			" &sdot; " .
-			$cgi->a({-href => href(-replay=>1, page=>$page-1),
-			         -accesskey => "p", -title => "Alt-p"}, "prev");
-	} else {
-		$paging_nav .= "first &sdot; prev";
-	}
-
-	if ($has_next_link) {
-		$paging_nav .= " &sdot; " .
-			$cgi->a({-href => href(-replay=>1, page=>$page+1),
-			         -accesskey => "n", -title => "Alt-n"}, "next");
-	} else {
-		$paging_nav .= " &sdot; next";
-	}
-
-	return $paging_nav;
-}
-
 ## ......................................................................
 ## functions printing or outputting HTML: div
 
-sub git_print_header_div {
-	my ($action, $title, $hash, $hash_base) = @_;
-	my %args = ();
-
-	$args{'action'} = $action;
-	$args{'hash'} = $hash if $hash;
-	$args{'hash_base'} = $hash_base if $hash_base;
-
-	print "<div class=\"header\">\n" .
-	      $cgi->a({-href => href(%args), -class => "title"},
-	      $title ? $title : $action) .
-	      "\n</div>\n";
-}
-
-sub print_local_time {
-	print format_local_time(@_);
-}
-
-sub format_local_time {
-	my $localtime = '';
-	my %date = @_;
-	if ($date{'hour_local'} < 6) {
-		$localtime .= sprintf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
-			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
-	} else {
-		$localtime .= sprintf(" (%02d:%02d %s)",
-			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
-	}
-
-	return $localtime;
-}
-
 # Outputs the author name and date in long form
 sub git_print_authorship {
 	my $co = shift;
@@ -2652,44 +1870,6 @@ sub git_print_authorship_rows {
 	}
 }
 
-sub git_print_page_path {
-	my $name = shift;
-	my $type = shift;
-	my $hb = shift;
-
-
-	print "<div class=\"page_path\">";
-	print $cgi->a({-href => href(action=>"tree", hash_base=>$hb),
-	              -title => 'tree root'}, to_utf8("[$project]"));
-	print " / ";
-	if (defined $name) {
-		my @dirname = split '/', $name;
-		my $basename = pop @dirname;
-		my $fullname = '';
-
-		foreach my $dir (@dirname) {
-			$fullname .= ($fullname ? '/' : '') . $dir;
-			print $cgi->a({-href => href(action=>"tree", file_name=>$fullname,
-			                             hash_base=>$hb),
-			              -title => $fullname}, esc_path($dir));
-			print " / ";
-		}
-		if (defined $type && $type eq 'blob') {
-			print $cgi->a({-href => href(action=>"blob_plain", file_name=>$file_name,
-			                             hash_base=>$hb),
-			              -title => $name}, esc_path($basename));
-		} elsif (defined $type && $type eq 'tree') {
-			print $cgi->a({-href => href(action=>"tree", file_name=>$file_name,
-			                             hash_base=>$hb),
-			              -title => $name}, esc_path($basename));
-			print " / ";
-		} else {
-			print esc_path($basename);
-		}
-	}
-	print "<br/></div>\n";
-}
-
 sub git_print_log {
 	my $log = shift;
 	my %opts = @_;
@@ -2739,157 +1919,6 @@ sub git_print_log {
 	}
 }
 
-# return link target (what link points to)
-sub git_get_link_target {
-	my $hash = shift;
-	my $link_target;
-
-	# read link
-	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
-		or return;
-	{
-		local $/ = undef;
-		$link_target = <$fd>;
-	}
-	close $fd
-		or return;
-
-	return $link_target;
-}
-
-# given link target, and the directory (basedir) the link is in,
-# return target of link relative to top directory (top tree);
-# return undef if it is not possible (including absolute links).
-sub normalize_link_target {
-	my ($link_target, $basedir) = @_;
-
-	# absolute symlinks (beginning with '/') cannot be normalized
-	return if (substr($link_target, 0, 1) eq '/');
-
-	# normalize link target to path from top (root) tree (dir)
-	my $path;
-	if ($basedir) {
-		$path = $basedir . '/' . $link_target;
-	} else {
-		# we are in top (root) tree (dir)
-		$path = $link_target;
-	}
-
-	# remove //, /./, and /../
-	my @path_parts;
-	foreach my $part (split('/', $path)) {
-		# discard '.' and ''
-		next if (!$part || $part eq '.');
-		# handle '..'
-		if ($part eq '..') {
-			if (@path_parts) {
-				pop @path_parts;
-			} else {
-				# link leads outside repository (outside top dir)
-				return;
-			}
-		} else {
-			push @path_parts, $part;
-		}
-	}
-	$path = join('/', @path_parts);
-
-	return $path;
-}
-
-# print tree entry (row of git_tree), but without encompassing <tr> element
-sub git_print_tree_entry {
-	my ($t, $basedir, $hash_base, $have_blame) = @_;
-
-	my %base_key = ();
-	$base_key{'hash_base'} = $hash_base if defined $hash_base;
-
-	# The format of a table row is: mode list link.  Where mode is
-	# the mode of the entry, list is the name of the entry, an href,
-	# and link is the action links of the entry.
-
-	print "<td class=\"mode\">" . mode_str($t->{'mode'}) . "</td>\n";
-	if (exists $t->{'size'}) {
-		print "<td class=\"size\">$t->{'size'}</td>\n";
-	}
-	if ($t->{'type'} eq "blob") {
-		print "<td class=\"list\">" .
-			$cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
-			                       file_name=>"$basedir$t->{'name'}", %base_key),
-			        -class => "list"}, esc_path($t->{'name'}));
-		if (S_ISLNK(oct $t->{'mode'})) {
-			my $link_target = git_get_link_target($t->{'hash'});
-			if ($link_target) {
-				my $norm_target = normalize_link_target($link_target, $basedir);
-				if (defined $norm_target) {
-					print " -> " .
-					      $cgi->a({-href => href(action=>"object", hash_base=>$hash_base,
-					                             file_name=>$norm_target),
-					               -title => $norm_target}, esc_path($link_target));
-				} else {
-					print " -> " . esc_path($link_target);
-				}
-			}
-		}
-		print "</td>\n";
-		print "<td class=\"link\">";
-		print $cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
-		                             file_name=>"$basedir$t->{'name'}", %base_key)},
-		              "blob");
-		if ($have_blame) {
-			print " | " .
-			      $cgi->a({-href => href(action=>"blame", hash=>$t->{'hash'},
-			                             file_name=>"$basedir$t->{'name'}", %base_key)},
-			              "blame");
-		}
-		if (defined $hash_base) {
-			print " | " .
-			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
-			                             hash=>$t->{'hash'}, file_name=>"$basedir$t->{'name'}")},
-			              "history");
-		}
-		print " | " .
-			$cgi->a({-href => href(action=>"blob_plain", hash_base=>$hash_base,
-			                       file_name=>"$basedir$t->{'name'}")},
-			        "raw");
-		print "</td>\n";
-
-	} elsif ($t->{'type'} eq "tree") {
-		print "<td class=\"list\">";
-		print $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
-		                             file_name=>"$basedir$t->{'name'}",
-		                             %base_key)},
-		              esc_path($t->{'name'}));
-		print "</td>\n";
-		print "<td class=\"link\">";
-		print $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
-		                             file_name=>"$basedir$t->{'name'}",
-		                             %base_key)},
-		              "tree");
-		if (defined $hash_base) {
-			print " | " .
-			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
-			                             file_name=>"$basedir$t->{'name'}")},
-			              "history");
-		}
-		print "</td>\n";
-	} else {
-		# unknown object: we can only present history for it
-		# (this includes 'commit' object, i.e. submodule support)
-		print "<td class=\"list\">" .
-		      esc_path($t->{'name'}) .
-		      "</td>\n";
-		print "<td class=\"link\">";
-		if (defined $hash_base) {
-			print $cgi->a({-href => href(action=>"history",
-			                             hash_base=>$hash_base,
-			                             file_name=>"$basedir$t->{'name'}")},
-			              "history");
-		}
-		print "</td>\n";
-	}
-}
-
 ## ......................................................................
 ## functions printing large fragments of HTML
 
@@ -3426,29 +2455,6 @@ sub fill_project_list_info {
 	return @projects;
 }
 
-# print 'sort by' <th> element, generating 'sort by $name' replay link
-# if that order is not selected
-sub print_sort_th {
-	print format_sort_th(@_);
-}
-
-sub format_sort_th {
-	my ($name, $order, $header) = @_;
-	my $sort_th = "";
-	$header ||= ucfirst($name);
-
-	if ($order eq $name) {
-		$sort_th .= "<th>$header</th>\n";
-	} else {
-		$sort_th .= "<th>" .
-		            $cgi->a({-href => href(-replay=>1, order=>$name),
-		                     -class => "header"}, $header) .
-		            "</th>\n";
-	}
-
-	return $sort_th;
-}
-
 sub git_project_list_body {
 	# actually uses global variable $project
 	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
diff --git a/gitweb/lib/Gitweb/View.pm b/gitweb/lib/Gitweb/View.pm
new file mode 100644
index 0000000..3118f44
--- /dev/null
+++ b/gitweb/lib/Gitweb/View.pm
@@ -0,0 +1,1022 @@
+#!/usr/bin/perl
+#
+# Gitweb::View-- gitweb's viewing subs package
+#
+# This program is licensed under the GPLv2
+
+package Gitweb::View;
+
+use strict;
+use warnings;
+use Exporter qw(import);
+
+our @EXPORT = qw(href chop_str chop_and_escape_str age_class age_string mode_str
+                 file_type file_type_long git_header_html git_footer_html die_error
+                 git_print_page_nav format_paging_nav insert_file git_print_page_path
+                 git_print_header_div print_local_time format_local_time print_sort_th
+                 git_print_tree_entry git_get_link_target normalize_link_target
+                 format_sort_th);
+
+use Fcntl ':mode';
+use Gitweb::Git qw($git_version $number_of_git_cmds $git_dir git_cmd);
+use Gitweb::Config qw(gitweb_check_feature %known_snapshot_formats @snapshot_fmts
+                      $site_name $version $stylesheet @stylesheets $favicon $logo
+                      $site_header $logo_url $logo_label $javascript $home_link_str
+                      $site_footer gitweb_get_feature);
+use Gitweb::Request qw($cgi $project %cgi_param_mapping @cgi_param_mapping $my_url
+                       $my_uri %input_params $action $file_name $base_url $hash_base
+                       $searchtext $search_use_regexp $hash $t0 $home_link);
+use Gitweb::Escape;
+use Gitweb::RepoConfig qw(git_get_project_description);
+
+# possible values of extra options
+# -full => 0|1      - use absolute/full URL ($my_uri/$my_url as base)
+# -replay => 1      - start from a current view (replay with modifications)
+# -path_info => 0|1 - don't use/use path_info URL (if possible)
+sub href {
+	my %params = @_;
+	# default is to use -absolute url() i.e. $my_uri
+	my $href = $params{-full} ? $my_url : $my_uri;
+
+	$params{'project'} = $project unless exists $params{'project'};
+
+	if ($params{-replay}) {
+		while (my ($name, $symbol) = each %cgi_param_mapping) {
+			if (!exists $params{$name}) {
+				$params{$name} = $input_params{$name};
+			}
+		}
+	}
+
+	my $use_pathinfo = gitweb_check_feature('pathinfo');
+	if (defined $params{'project'} &&
+	    (exists $params{-path_info} ? $params{-path_info} : $use_pathinfo)) {
+		# try to put as many parameters as possible in PATH_INFO:
+		#   - project name
+		#   - action
+		#   - hash_parent or hash_parent_base:/file_parent
+		#   - hash or hash_base:/filename
+		#   - the snapshot_format as an appropriate suffix
+
+		# When the script is the root DirectoryIndex for the domain,
+		# $href here would be something like http://gitweb.example.com/
+		# Thus, we strip any trailing / from $href, to spare us double
+		# slashes in the final URL
+		$href =~ s,/$,,;
+
+		# Then add the project name, if present
+		$href .= "/".esc_url($params{'project'});
+		delete $params{'project'};
+
+		# since we destructively absorb parameters, we keep this
+		# boolean that remembers if we're handling a snapshot
+		my $is_snapshot = $params{'action'} eq 'snapshot';
+
+		# Summary just uses the project path URL, any other action is
+		# added to the URL
+		if (defined $params{'action'}) {
+			$href .= "/".esc_url($params{'action'}) unless $params{'action'} eq 'summary';
+			delete $params{'action'};
+		}
+
+		# Next, we put hash_parent_base:/file_parent..hash_base:/file_name,
+		# stripping nonexistent or useless pieces
+		$href .= "/" if ($params{'hash_base'} || $params{'hash_parent_base'}
+			|| $params{'hash_parent'} || $params{'hash'});
+		if (defined $params{'hash_base'}) {
+			if (defined $params{'hash_parent_base'}) {
+				$href .= esc_url($params{'hash_parent_base'});
+				# skip the file_parent if it's the same as the file_name
+				if (defined $params{'file_parent'}) {
+					if (defined $params{'file_name'} && $params{'file_parent'} eq $params{'file_name'}) {
+						delete $params{'file_parent'};
+					} elsif ($params{'file_parent'} !~ /\.\./) {
+						$href .= ":/".esc_url($params{'file_parent'});
+						delete $params{'file_parent'};
+					}
+				}
+				$href .= "..";
+				delete $params{'hash_parent'};
+				delete $params{'hash_parent_base'};
+			} elsif (defined $params{'hash_parent'}) {
+				$href .= esc_url($params{'hash_parent'}). "..";
+				delete $params{'hash_parent'};
+			}
+
+			$href .= esc_url($params{'hash_base'});
+			if (defined $params{'file_name'} && $params{'file_name'} !~ /\.\./) {
+				$href .= ":/".esc_url($params{'file_name'});
+				delete $params{'file_name'};
+			}
+			delete $params{'hash'};
+			delete $params{'hash_base'};
+		} elsif (defined $params{'hash'}) {
+			$href .= esc_url($params{'hash'});
+			delete $params{'hash'};
+		}
+
+		# If the action was a snapshot, we can absorb the
+		# snapshot_format parameter too
+		if ($is_snapshot) {
+			my $fmt = $params{'snapshot_format'};
+			# snapshot_format should always be defined when href()
+			# is called, but just in case some code forgets, we
+			# fall back to the default
+			$fmt ||= $snapshot_fmts[0];
+			$href .= $known_snapshot_formats{$fmt}{'suffix'};
+			delete $params{'snapshot_format'};
+		}
+	}
+
+	# now encode the parameters explicitly
+	my @result = ();
+	for (my $i = 0; $i < @cgi_param_mapping; $i += 2) {
+		my ($name, $symbol) = ($cgi_param_mapping[$i], $cgi_param_mapping[$i+1]);
+		if (defined $params{$name}) {
+			if (ref($params{$name}) eq "ARRAY") {
+				foreach my $par (@{$params{$name}}) {
+					push @result, $symbol . "=" . esc_param($par);
+				}
+			} else {
+				push @result, $symbol . "=" . esc_param($params{$name});
+			}
+		}
+	}
+	$href .= "?" . join(';', @result) if scalar @result;
+
+	return $href;
+}
+
+## ----------------------------------------------------------------------
+## HTML aware string manipulation
+
+# Try to chop given string on a word boundary between position
+# $len and $len+$add_len. If there is no word boundary there,
+# chop at $len+$add_len. Do not chop if chopped part plus ellipsis
+# (marking chopped part) would be longer than given string.
+sub chop_str {
+	my $str = shift;
+	my $len = shift;
+	my $add_len = shift || 10;
+	my $where = shift || 'right'; # 'left' | 'center' | 'right'
+
+	# Make sure perl knows it is utf8 encoded so we don't
+	# cut in the middle of a utf8 multibyte char.
+	$str = to_utf8($str);
+
+	# allow only $len chars, but don't cut a word if it would fit in $add_len
+	# if it doesn't fit, cut it if it's still longer than the dots we would add
+	# remove chopped character entities entirely
+
+	# when chopping in the middle, distribute $len into left and right part
+	# return early if chopping wouldn't make string shorter
+	if ($where eq 'center') {
+		return $str if ($len + 5 >= length($str)); # filler is length 5
+		$len = int($len/2);
+	} else {
+		return $str if ($len + 4 >= length($str)); # filler is length 4
+	}
+
+	# regexps: ending and beginning with word part up to $add_len
+	my $endre = qr/.{$len}\w{0,$add_len}/;
+	my $begre = qr/\w{0,$add_len}.{$len}/;
+
+	if ($where eq 'left') {
+		$str =~ m/^(.*?)($begre)$/;
+		my ($lead, $body) = ($1, $2);
+		if (length($lead) > 4) {
+			$lead = " ...";
+		}
+		return "$lead$body";
+
+	} elsif ($where eq 'center') {
+		$str =~ m/^($endre)(.*)$/;
+		my ($left, $str)  = ($1, $2);
+		$str =~ m/^(.*?)($begre)$/;
+		my ($mid, $right) = ($1, $2);
+		if (length($mid) > 5) {
+			$mid = " ... ";
+		}
+		return "$left$mid$right";
+
+	} else {
+		$str =~ m/^($endre)(.*)$/;
+		my $body = $1;
+		my $tail = $2;
+		if (length($tail) > 4) {
+			$tail = "... ";
+		}
+		return "$body$tail";
+	}
+}
+
+# takes the same arguments as chop_str, but also wraps a <span> around the
+# result with a title attribute if it does get chopped. Additionally, the
+# string is HTML-escaped.
+sub chop_and_escape_str {
+	my ($str) = @_;
+
+	my $chopped = chop_str(@_);
+	if ($chopped eq $str) {
+		return esc_html($chopped);
+	} else {
+		$str =~ s/[[:cntrl:]]/?/g;
+		return $cgi->span({-title=>$str}, esc_html($chopped));
+	}
+}
+
+## ----------------------------------------------------------------------
+## functions returning short strings
+
+# CSS class for given age value (in seconds)
+sub age_class {
+	my $age = shift;
+
+	if (!defined $age) {
+		return "noage";
+	} elsif ($age < 60*60*2) {
+		return "age0";
+	} elsif ($age < 60*60*24*2) {
+		return "age1";
+	} else {
+		return "age2";
+	}
+}
+
+# convert age in seconds to "nn units ago" string
+sub age_string {
+	my $age = shift;
+	my $age_str;
+
+	if ($age > 60*60*24*365*2) {
+		$age_str = (int $age/60/60/24/365);
+		$age_str .= " years ago";
+	} elsif ($age > 60*60*24*(365/12)*2) {
+		$age_str = int $age/60/60/24/(365/12);
+		$age_str .= " months ago";
+	} elsif ($age > 60*60*24*7*2) {
+		$age_str = int $age/60/60/24/7;
+		$age_str .= " weeks ago";
+	} elsif ($age > 60*60*24*2) {
+		$age_str = int $age/60/60/24;
+		$age_str .= " days ago";
+	} elsif ($age > 60*60*2) {
+		$age_str = int $age/60/60;
+		$age_str .= " hours ago";
+	} elsif ($age > 60*2) {
+		$age_str = int $age/60;
+		$age_str .= " min ago";
+	} elsif ($age > 2) {
+		$age_str = int $age;
+		$age_str .= " sec ago";
+	} else {
+		$age_str .= " right now";
+	}
+	return $age_str;
+}
+
+use constant {
+	S_IFINVALID => 0030000,
+	S_IFGITLINK => 0160000,
+};
+
+# submodule/subproject, a commit object reference
+sub S_ISGITLINK {
+	my $mode = shift;
+
+	return (($mode & S_IFMT) == S_IFGITLINK)
+}
+
+# convert file mode in octal to symbolic file mode string
+sub mode_str {
+	my $mode = oct shift;
+
+	if (S_ISGITLINK($mode)) {
+		return 'm---------';
+	} elsif (S_ISDIR($mode & S_IFMT)) {
+		return 'drwxr-xr-x';
+	} elsif (S_ISLNK($mode)) {
+		return 'lrwxrwxrwx';
+	} elsif (S_ISREG($mode)) {
+		# git cares only about the executable bit
+		if ($mode & S_IXUSR) {
+			return '-rwxr-xr-x';
+		} else {
+			return '-rw-r--r--';
+		};
+	} else {
+		return '----------';
+	}
+}
+
+# convert file mode in octal to file type string
+sub file_type {
+	my $mode = shift;
+
+	if ($mode !~ m/^[0-7]+$/) {
+		return $mode;
+	} else {
+		$mode = oct $mode;
+	}
+
+	if (S_ISGITLINK($mode)) {
+		return "submodule";
+	} elsif (S_ISDIR($mode & S_IFMT)) {
+		return "directory";
+	} elsif (S_ISLNK($mode)) {
+		return "symlink";
+	} elsif (S_ISREG($mode)) {
+		return "file";
+	} else {
+		return "unknown";
+	}
+}
+
+# convert file mode in octal to file type description string
+sub file_type_long {
+	my $mode = shift;
+
+	if ($mode !~ m/^[0-7]+$/) {
+		return $mode;
+	} else {
+		$mode = oct $mode;
+	}
+
+	if (S_ISGITLINK($mode)) {
+		return "submodule";
+	} elsif (S_ISDIR($mode & S_IFMT)) {
+		return "directory";
+	} elsif (S_ISLNK($mode)) {
+		return "symlink";
+	} elsif (S_ISREG($mode)) {
+		if ($mode & S_IXUSR) {
+			return "executable";
+		} else {
+			return "file";
+		};
+	} else {
+		return "unknown";
+	}
+}
+
+## ======================================================================
+## functions printing HTML: header, footer, error page
+
+sub get_page_title {
+	my $title = to_utf8($site_name);
+
+	return $title unless (defined $project);
+	$title .= " - " . to_utf8($project);
+
+	return $title unless (defined $action);
+	$title .= "/$action"; # $action is US-ASCII (7bit ASCII)
+
+	return $title unless (defined $file_name);
+	$title .= " - " . esc_path($file_name);
+	if ($action eq "tree" && $file_name !~ m|/$|) {
+		$title .= "/";
+	}
+
+	return $title;
+}
+
+sub git_header_html {
+	my $status = shift || "200 OK";
+	my $expires = shift;
+	my %opts = @_;
+
+	my $title = get_page_title();
+	my $content_type;
+	# require explicit support from the UA if we are to send the page as
+	# 'application/xhtml+xml', otherwise send it as plain old 'text/html'.
+	# we have to do this because MSIE sometimes globs '*/*', pretending to
+	# support xhtml+xml but choking when it gets what it asked for.
+	if (defined $cgi->http('HTTP_ACCEPT') &&
+	    $cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ &&
+	    $cgi->Accept('application/xhtml+xml') != 0) {
+		$content_type = 'application/xhtml+xml';
+	} else {
+		$content_type = 'text/html';
+	}
+	print $cgi->header(-type=>$content_type, -charset => 'utf-8',
+	                   -status=> $status, -expires => $expires)
+		unless ($opts{'-no_http_header'});
+	my $mod_perl_version = $ENV{'MOD_PERL'} ? " $ENV{'MOD_PERL'}" : '';
+	print <<EOF;
+<?xml version="1.0" encoding="utf-8"?>
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
+<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
+<!-- git web interface version $version, (C) 2005-2006, Kay Sievers <kay.sievers\@vrfy.org>, Christian Gierke -->
+<!-- git core binaries version $git_version -->
+<head>
+<meta http-equiv="content-type" content="$content_type; charset=utf-8"/>
+<meta name="generator" content="gitweb/$version git/$git_version$mod_perl_version"/>
+<meta name="robots" content="index, nofollow"/>
+<title>$title</title>
+EOF
+	# the stylesheet, favicon etc urls won't work correctly with path_info
+	# unless we set the appropriate base URL
+	if ($ENV{'PATH_INFO'}) {
+		print "<base href=\"".esc_url($base_url)."\" />\n";
+	}
+	# print out each stylesheet that exist, providing backwards capability
+	# for those people who defined $stylesheet in a config file
+	if (defined $stylesheet) {
+		print '<link rel="stylesheet" type="text/css" href="'.$stylesheet.'"/>'."\n";
+	} else {
+		foreach my $stylesheet (@stylesheets) {
+			next unless $stylesheet;
+			print '<link rel="stylesheet" type="text/css" href="'.$stylesheet.'"/>'."\n";
+		}
+	}
+	if (defined $project) {
+		my %href_params = get_feed_info();
+		if (!exists $href_params{'-title'}) {
+			$href_params{'-title'} = 'log';
+		}
+
+		foreach my $format qw(RSS Atom) {
+			my $type = lc($format);
+			my %link_attr = (
+				'-rel' => 'alternate',
+				'-title' => "$project - $href_params{'-title'} - $format feed",
+				'-type' => "application/$type+xml"
+			);
+
+			$href_params{'action'} = $type;
+			$link_attr{'-href'} = href(%href_params);
+			print "<link ".
+			      "rel=\"$link_attr{'-rel'}\" ".
+			      "title=\"$link_attr{'-title'}\" ".
+			      "href=\"$link_attr{'-href'}\" ".
+			      "type=\"$link_attr{'-type'}\" ".
+			      "/>\n";
+
+			$href_params{'extra_options'} = '--no-merges';
+			$link_attr{'-href'} = href(%href_params);
+			$link_attr{'-title'} .= ' (no merges)';
+			print "<link ".
+			      "rel=\"$link_attr{'-rel'}\" ".
+			      "title=\"$link_attr{'-title'}\" ".
+			      "href=\"$link_attr{'-href'}\" ".
+			      "type=\"$link_attr{'-type'}\" ".
+			      "/>\n";
+		}
+
+	} else {
+		printf('<link rel="alternate" title="%s projects list" '.
+		       'href="%s" type="text/plain; charset=utf-8" />'."\n",
+		       $site_name, href(project=>undef, action=>"project_index"));
+		printf('<link rel="alternate" title="%s projects feeds" '.
+		       'href="%s" type="text/x-opml" />'."\n",
+		       $site_name, href(project=>undef, action=>"opml"));
+	}
+	if (defined $favicon) {
+		print qq(<link rel="shortcut icon" href="$favicon" type="image/png" />\n);
+	}
+
+	print "</head>\n" .
+	      "<body>\n";
+
+	if (defined $site_header && -f $site_header) {
+		insert_file($site_header);
+	}
+
+	print "<div class=\"page_header\">\n" .
+	      $cgi->a({-href => esc_url($logo_url),
+	               -title => $logo_label},
+	              qq(<img src="$logo" width="72" height="27" alt="git" class="logo"/>));
+	print $cgi->a({-href => esc_url($home_link)}, $home_link_str) . " / ";
+	if (defined $project) {
+		print $cgi->a({-href => href(action=>"summary")}, esc_html($project));
+		if (defined $action) {
+			print " / $action";
+		}
+		print "\n";
+	}
+	print "</div>\n";
+
+	my $have_search = gitweb_check_feature('search');
+	if (defined $project && $have_search) {
+		if (!defined $searchtext) {
+			$searchtext = "";
+		}
+		my $search_hash;
+		if (defined $hash_base) {
+			$search_hash = $hash_base;
+		} elsif (defined $hash) {
+			$search_hash = $hash;
+		} else {
+			$search_hash = "HEAD";
+		}
+		my $action = $my_uri;
+		my $use_pathinfo = gitweb_check_feature('pathinfo');
+		if ($use_pathinfo) {
+			$action .= "/".esc_url($project);
+		}
+		print $cgi->startform(-method => "get", -action => $action) .
+		      "<div class=\"search\">\n" .
+		      (!$use_pathinfo &&
+		      $cgi->input({-name=>"p", -value=>$project, -type=>"hidden"}) . "\n") .
+		      $cgi->input({-name=>"a", -value=>"search", -type=>"hidden"}) . "\n" .
+		      $cgi->input({-name=>"h", -value=>$search_hash, -type=>"hidden"}) . "\n" .
+		      $cgi->popup_menu(-name => 'st', -default => 'commit',
+		                       -values => ['commit', 'grep', 'author', 'committer', 'pickaxe']) .
+		      $cgi->sup($cgi->a({-href => href(action=>"search_help")}, "?")) .
+		      " search:\n",
+		      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
+		      "<span title=\"Extended regular expression\">" .
+		      $cgi->checkbox(-name => 'sr', -value => 1, -label => 're',
+		                     -checked => $search_use_regexp) .
+		      "</span>" .
+		      "</div>" .
+		      $cgi->end_form() . "\n";
+	}
+}
+
+sub git_footer_html {
+	my $feed_class = 'rss_logo';
+
+	print "<div class=\"page_footer\">\n";
+	if (defined $project) {
+		my $descr = git_get_project_description($project);
+		if (defined $descr) {
+			print "<div class=\"page_footer_text\">" . esc_html($descr) . "</div>\n";
+		}
+
+		my %href_params = get_feed_info();
+		if (!%href_params) {
+			$feed_class .= ' generic';
+		}
+		$href_params{'-title'} ||= 'log';
+
+		foreach my $format qw(RSS Atom) {
+			$href_params{'action'} = lc($format);
+			print $cgi->a({-href => href(%href_params),
+			              -title => "$href_params{'-title'} $format feed",
+			              -class => $feed_class}, $format)."\n";
+		}
+
+	} else {
+		print $cgi->a({-href => href(project=>undef, action=>"opml"),
+		              -class => $feed_class}, "OPML") . " ";
+		print $cgi->a({-href => href(project=>undef, action=>"project_index"),
+		              -class => $feed_class}, "TXT") . "\n";
+	}
+	print "</div>\n"; # class="page_footer"
+
+	if (defined $t0 && gitweb_check_feature('timed')) {
+		print "<div id=\"generating_info\">\n";
+		print 'This page took '.
+		      '<span id="generating_time" class="time_span">'.
+		      Time::HiRes::tv_interval($t0, [Time::HiRes::gettimeofday()]).
+		      ' seconds </span>'.
+		      ' and '.
+		      '<span id="generating_cmd">'.
+		      $number_of_git_cmds.
+		      '</span> git commands '.
+		      " to generate.\n";
+		print "</div>\n"; # class="page_footer"
+	}
+
+	if (defined $site_footer && -f $site_footer) {
+		insert_file($site_footer);
+	}
+
+	print qq!<script type="text/javascript" src="$javascript"></script>\n!;
+	if (defined $action &&
+	    $action eq 'blame_incremental') {
+		print qq!<script type="text/javascript">\n!.
+		      qq!startBlame("!. href(action=>"blame_data", -replay=>1) .qq!",\n!.
+		      qq!           "!. href() .qq!");\n!.
+		      qq!</script>\n!;
+	} elsif (gitweb_check_feature('javascript-actions')) {
+		print qq!<script type="text/javascript">\n!.
+		      qq!window.onload = fixLinks;\n!.
+		      qq!</script>\n!;
+	}
+
+	print "</body>\n" .
+	      "</html>";
+}
+
+# die_error(<http_status_code>, <error_message>[, <detailed_html_description>])
+# Example: die_error(404, 'Hash not found')
+# By convention, use the following status codes (as defined in RFC 2616):
+# 400: Invalid or missing CGI parameters, or
+#      requested object exists but has wrong type.
+# 403: Requested feature (like "pickaxe" or "snapshot") not enabled on
+#      this server or project.
+# 404: Requested object/revision/project doesn't exist.
+# 500: The server isn't configured properly, or
+#      an internal error occurred (e.g. failed assertions caused by bugs), or
+#      an unknown error occurred (e.g. the git binary died unexpectedly).
+# 503: The server is currently unavailable (because it is overloaded,
+#      or down for maintenance).  Generally, this is a temporary state.
+sub die_error {
+	my $status = shift || 500;
+	my $error = esc_html(shift) || "Internal Server Error";
+	my $extra = shift;
+	my %opts = @_;
+
+	my %http_responses = (
+		400 => '400 Bad Request',
+		403 => '403 Forbidden',
+		404 => '404 Not Found',
+		500 => '500 Internal Server Error',
+		503 => '503 Service Unavailable',
+	);
+	git_header_html($http_responses{$status}, undef, %opts);
+	print <<EOF;
+<div class="page_body">
+<br /><br />
+$status - $error
+<br />
+EOF
+	if (defined $extra) {
+		print "<hr />\n" .
+		      "$extra\n";
+	}
+	print "</div>\n";
+
+	git_footer_html();
+	goto DONE_GITWEB
+		unless ($opts{'-error_handler'});
+}
+
+## ----------------------------------------------------------------------
+## functions printing or outputting HTML: navigation
+
+sub git_print_page_nav {
+	my ($current, $suppress, $head, $treehead, $treebase, $extra) = @_;
+	$extra = '' if !defined $extra; # pager or formats
+
+	my @navs = qw(summary shortlog log commit commitdiff tree);
+	if ($suppress) {
+		@navs = grep { $_ ne $suppress } @navs;
+	}
+
+	my %arg = map { $_ => {action=>$_} } @navs;
+	if (defined $head) {
+		for (qw(commit commitdiff)) {
+			$arg{$_}{'hash'} = $head;
+		}
+		if ($current =~ m/^(tree | log | shortlog | commit | commitdiff | search)$/x) {
+			for (qw(shortlog log)) {
+				$arg{$_}{'hash'} = $head;
+			}
+		}
+	}
+
+	$arg{'tree'}{'hash'} = $treehead if defined $treehead;
+	$arg{'tree'}{'hash_base'} = $treebase if defined $treebase;
+
+	my @actions = gitweb_get_feature('actions');
+	my %repl = (
+		'%' => '%',
+		'n' => $project,         # project name
+		'f' => $git_dir,         # project path within filesystem
+		'h' => $treehead || '',  # current hash ('h' parameter)
+		'b' => $treebase || '',  # hash base ('hb' parameter)
+	);
+	while (@actions) {
+		my ($label, $link, $pos) = splice(@actions,0,3);
+		# insert
+		@navs = map { $_ eq $pos ? ($_, $label) : $_ } @navs;
+		# munch munch
+		$link =~ s/%([%nfhb])/$repl{$1}/g;
+		$arg{$label}{'_href'} = $link;
+	}
+
+	print "<div class=\"page_nav\">\n" .
+		(join " | ",
+		 map { $_ eq $current ?
+		       $_ : $cgi->a({-href => ($arg{$_}{_href} ? $arg{$_}{_href} : href(%{$arg{$_}}))}, "$_")
+		 } @navs);
+	print "<br/>\n$extra<br/>\n" .
+	      "</div>\n";
+}
+
+sub format_paging_nav {
+	my ($action, $page, $has_next_link) = @_;
+	my $paging_nav;
+
+
+	if ($page > 0) {
+		$paging_nav .=
+			$cgi->a({-href => href(-replay=>1, page=>undef)}, "first") .
+			" &sdot; " .
+			$cgi->a({-href => href(-replay=>1, page=>$page-1),
+			         -accesskey => "p", -title => "Alt-p"}, "prev");
+	} else {
+		$paging_nav .= "first &sdot; prev";
+	}
+
+	if ($has_next_link) {
+		$paging_nav .= " &sdot; " .
+			$cgi->a({-href => href(-replay=>1, page=>$page+1),
+			         -accesskey => "n", -title => "Alt-n"}, "next");
+	} else {
+		$paging_nav .= " &sdot; next";
+	}
+
+	return $paging_nav;
+}
+
+## ......................................................................
+## functions returning values to be passed, perhaps after some
+## transformation, to other functions; e.g. returning arguments to href()
+
+# returns hash to be passed to href to generate gitweb URL
+# in -title key it returns description of link
+sub get_feed_info {
+	my $format = shift || 'Atom';
+	my %res = (action => lc($format));
+
+	# feed links are possible only for project views
+	return unless (defined $project);
+	# some views should link to OPML, or to generic project feed,
+	# or don't have specific feed yet (so they should use generic)
+	return if ($action =~ /^(?:tags|heads|forks|tag|search)$/x);
+
+	my $branch;
+	# branches refs uses 'refs/heads/' prefix (fullname) to differentiate
+	# from tag links; this also makes possible to detect branch links
+	if ((defined $hash_base && $hash_base =~ m!^refs/heads/(.*)$!) ||
+	    (defined $hash      && $hash      =~ m!^refs/heads/(.*)$!)) {
+		$branch = $1;
+	}
+	# find log type for feed description (title)
+	my $type = 'log';
+	if (defined $file_name) {
+		$type  = "history of $file_name";
+		$type .= "/" if ($action eq 'tree');
+		$type .= " on '$branch'" if (defined $branch);
+	} else {
+		$type = "log of $branch" if (defined $branch);
+	}
+
+	$res{-title} = $type;
+	$res{'hash'} = (defined $branch ? "refs/heads/$branch" : undef);
+	$res{'file_name'} = $file_name;
+
+	return %res;
+}
+
+# assume that file exists
+sub insert_file {
+	my $filename = shift;
+
+	open my $fd, '<', $filename;
+	print map { to_utf8($_) } <$fd>;
+	close $fd;
+}
+
+## ......................................................................
+## functions printing or outputting HTML: div
+
+sub git_print_header_div {
+	my ($action, $title, $hash, $hash_base) = @_;
+	my %args = ();
+
+	$args{'action'} = $action;
+	$args{'hash'} = $hash if $hash;
+	$args{'hash_base'} = $hash_base if $hash_base;
+
+	print "<div class=\"header\">\n" .
+	      $cgi->a({-href => href(%args), -class => "title"},
+	      $title ? $title : $action) .
+	      "\n</div>\n";
+}
+
+sub print_local_time {
+	print format_local_time(@_);
+}
+
+sub format_local_time {
+	my $localtime = '';
+	my %date = @_;
+	if ($date{'hour_local'} < 6) {
+		$localtime .= sprintf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
+			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
+	} else {
+		$localtime .= sprintf(" (%02d:%02d %s)",
+			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
+	}
+
+	return $localtime;
+}
+
+sub git_print_page_path {
+	my $name = shift;
+	my $type = shift;
+	my $hb = shift;
+
+
+	print "<div class=\"page_path\">";
+	print $cgi->a({-href => href(action=>"tree", hash_base=>$hb),
+	              -title => 'tree root'}, to_utf8("[$project]"));
+	print " / ";
+	if (defined $name) {
+		my @dirname = split '/', $name;
+		my $basename = pop @dirname;
+		my $fullname = '';
+
+		foreach my $dir (@dirname) {
+			$fullname .= ($fullname ? '/' : '') . $dir;
+			print $cgi->a({-href => href(action=>"tree", file_name=>$fullname,
+			                             hash_base=>$hb),
+			              -title => $fullname}, esc_path($dir));
+			print " / ";
+		}
+		if (defined $type && $type eq 'blob') {
+			print $cgi->a({-href => href(action=>"blob_plain", file_name=>$file_name,
+			                             hash_base=>$hb),
+			              -title => $name}, esc_path($basename));
+		} elsif (defined $type && $type eq 'tree') {
+			print $cgi->a({-href => href(action=>"tree", file_name=>$file_name,
+			                             hash_base=>$hb),
+			              -title => $name}, esc_path($basename));
+			print " / ";
+		} else {
+			print esc_path($basename);
+		}
+	}
+	print "<br/></div>\n";
+}
+
+# return link target (what link points to)
+sub git_get_link_target {
+	my $hash = shift;
+	my $link_target;
+
+	# read link
+	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
+		or return;
+	{
+		local $/ = undef;
+		$link_target = <$fd>;
+	}
+	close $fd
+		or return;
+
+	return $link_target;
+}
+
+# given link target, and the directory (basedir) the link is in,
+# return target of link relative to top directory (top tree);
+# return undef if it is not possible (including absolute links).
+sub normalize_link_target {
+	my ($link_target, $basedir) = @_;
+
+	# absolute symlinks (beginning with '/') cannot be normalized
+	return if (substr($link_target, 0, 1) eq '/');
+
+	# normalize link target to path from top (root) tree (dir)
+	my $path;
+	if ($basedir) {
+		$path = $basedir . '/' . $link_target;
+	} else {
+		# we are in top (root) tree (dir)
+		$path = $link_target;
+	}
+
+	# remove //, /./, and /../
+	my @path_parts;
+	foreach my $part (split('/', $path)) {
+		# discard '.' and ''
+		next if (!$part || $part eq '.');
+		# handle '..'
+		if ($part eq '..') {
+			if (@path_parts) {
+				pop @path_parts;
+			} else {
+				# link leads outside repository (outside top dir)
+				return;
+			}
+		} else {
+			push @path_parts, $part;
+		}
+	}
+	$path = join('/', @path_parts);
+
+	return $path;
+}
+
+# print tree entry (row of git_tree), but without encompassing <tr> element
+sub git_print_tree_entry {
+	my ($t, $basedir, $hash_base, $have_blame) = @_;
+
+	my %base_key = ();
+	$base_key{'hash_base'} = $hash_base if defined $hash_base;
+
+	# The format of a table row is: mode list link.  Where mode is
+	# the mode of the entry, list is the name of the entry, an href,
+	# and link is the action links of the entry.
+
+	print "<td class=\"mode\">" . mode_str($t->{'mode'}) . "</td>\n";
+	if (exists $t->{'size'}) {
+		print "<td class=\"size\">$t->{'size'}</td>\n";
+	}
+	if ($t->{'type'} eq "blob") {
+		print "<td class=\"list\">" .
+			$cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
+			                       file_name=>"$basedir$t->{'name'}", %base_key),
+			        -class => "list"}, esc_path($t->{'name'}));
+		if (S_ISLNK(oct $t->{'mode'})) {
+			my $link_target = git_get_link_target($t->{'hash'});
+			if ($link_target) {
+				my $norm_target = normalize_link_target($link_target, $basedir);
+				if (defined $norm_target) {
+					print " -> " .
+					      $cgi->a({-href => href(action=>"object", hash_base=>$hash_base,
+					                             file_name=>$norm_target),
+					               -title => $norm_target}, esc_path($link_target));
+				} else {
+					print " -> " . esc_path($link_target);
+				}
+			}
+		}
+		print "</td>\n";
+		print "<td class=\"link\">";
+		print $cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
+		                             file_name=>"$basedir$t->{'name'}", %base_key)},
+		              "blob");
+		if ($have_blame) {
+			print " | " .
+			      $cgi->a({-href => href(action=>"blame", hash=>$t->{'hash'},
+			                             file_name=>"$basedir$t->{'name'}", %base_key)},
+			              "blame");
+		}
+		if (defined $hash_base) {
+			print " | " .
+			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
+			                             hash=>$t->{'hash'}, file_name=>"$basedir$t->{'name'}")},
+			              "history");
+		}
+		print " | " .
+			$cgi->a({-href => href(action=>"blob_plain", hash_base=>$hash_base,
+			                       file_name=>"$basedir$t->{'name'}")},
+			        "raw");
+		print "</td>\n";
+
+	} elsif ($t->{'type'} eq "tree") {
+		print "<td class=\"list\">";
+		print $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
+		                             file_name=>"$basedir$t->{'name'}",
+		                             %base_key)},
+		              esc_path($t->{'name'}));
+		print "</td>\n";
+		print "<td class=\"link\">";
+		print $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
+		                             file_name=>"$basedir$t->{'name'}",
+		                             %base_key)},
+		              "tree");
+		if (defined $hash_base) {
+			print " | " .
+			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
+			                             file_name=>"$basedir$t->{'name'}")},
+			              "history");
+		}
+		print "</td>\n";
+	} else {
+		# unknown object: we can only present history for it
+		# (this includes 'commit' object, i.e. submodule support)
+		print "<td class=\"list\">" .
+		      esc_path($t->{'name'}) .
+		      "</td>\n";
+		print "<td class=\"link\">";
+		if (defined $hash_base) {
+			print $cgi->a({-href => href(action=>"history",
+			                             hash_base=>$hash_base,
+			                             file_name=>"$basedir$t->{'name'}")},
+			              "history");
+		}
+		print "</td>\n";
+	}
+}
+
+# print 'sort by' <th> element, generating 'sort by $name' replay link
+# if that order is not selected
+sub print_sort_th {
+	print format_sort_th(@_);
+}
+
+sub format_sort_th {
+	my ($name, $order, $header) = @_;
+	my $sort_th = "";
+	$header ||= ucfirst($name);
+
+	if ($order eq $name) {
+		$sort_th .= "<th>$header</th>\n";
+	} else {
+		$sort_th .= "<th>" .
+		            $cgi->a({-href => href(-replay=>1, order=>$name),
+		                     -class => "header"}, $header) .
+		            "</th>\n";
+	}
+
+	return $sort_th;
+}
+
+1;
-- 
1.7.1.454.g276eb9.dirty
