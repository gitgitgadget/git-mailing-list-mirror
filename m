From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCHv3 2/2] gitweb: Create Gitweb::Util module
Date: Tue,  6 Mar 2012 23:41:42 +0100
Message-ID: <1331073702-9071-3-git-send-email-jnareb@gmail.com>
References: <1331073702-9071-1-git-send-email-jnareb@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 23:42:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S535B-0007l5-OV
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 23:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372Ab2CFWmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 17:42:07 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52136 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759249Ab2CFWmF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 17:42:05 -0500
Received: by mail-ey0-f174.google.com with SMTP id q12so2014017eaa.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 14:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=80cBJma7IP4QJFNlHMePrs3EH5J4QrTBAMAVbEEYS7M=;
        b=B90rSuq86ZW5+pF0YMD/d3eOq/TvkRyv0XN/LUexdHA3d4XjJ4hDv6f3+qSMSVymYn
         0JUy8UjSHrjthN0XUwu1xvt9p/UuJpgMyIjDLbbrd65zTXGOrHRA5IqOfzFiSnS3lCiN
         pXlYsTMnyQPLKuGR8LcwiGiX4lBhoyu7Pr8DI33wJ0iALxLIkQA1vh1VUq/sJ7rBFEo0
         HrW8PZNcggioaiJRZzAIQz//s87hxUPjjai3J5RNfApyspyLcCNYMsqgyeHqQexrgCB0
         u5yv89QIQOFWeyugMPu0Wnx0fJCo2PkwDeepXkmZU4dAWyPeLrLKN5nlUb7zmtV/c/X4
         zg7Q==
Received: by 10.213.14.207 with SMTP id h15mr40889eba.296.1331073724649;
        Tue, 06 Mar 2012 14:42:04 -0800 (PST)
Received: from localhost.localdomain (abwo250.neoplus.adsl.tpnet.pl. [83.8.238.250])
        by mx.google.com with ESMTPS id o49sm79596627eeb.7.2012.03.06.14.42.01
        (version=SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 14:42:04 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1331073702-9071-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192410>

From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>

Create a Gitweb::Util module, which is meant to contain internal
utilities used by gitweb.  Currently it includes all the
quoting/unquoting and escaping subroutines that are used by the
gitweb, HTML-aware string manipulation subroutines, and some file
and filesystem operations.

The intent is to include in Gitweb::Util subroutines and variables
that do not require git or gitweb knowledge.

Update gitweb/Makefile to install Gitweb::Util module alongside
gitweb.

This was sort of part of [unfinished] Google Summer of Code 2010
project "Splitting gitweb and developing write functionalities
(Integrated web client for git)" by Pavan Kumar Sunkara, mentored by
Christian Couder and co-mentored by Petr Baudis.

[This reduces size of gitweb.perl by around 5%]

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This module was originally part of unfinished GSoC 2010 project with
Pavan Kumar Sunkara as a student

  git://repo.or.cz/git/gsoc2010-gitweb.git

The module was originally named Gitweb::Escape.


NOTE: I wanted to check if the change is pure code movement (and
reorganization: in some places ordering of subroutines changed) with
git-blame ("git blame -C -C -C -w")... but it couldn't correctly
detect code movement of 5% of file.


Changes from v2:
* gitweb still needs Encoding module for marking query parameters as
  UTF-8 with decode_utf8 (new in gitweb).

* Move sanitize (new), chop_str, chop_and_escape_str,
  esc_html_hl_regions (new), matchpos_list (new), esc_html_match_hl
  (new), esc_html_match_hl_chopped (new), hash_set_multi,
  get_file_owner, insert_file, normalize_link_target to Gitweb::Util

 gitweb/Makefile           |    2 +
 gitweb/gitweb.perl        |  390 +---------------------------------------
 gitweb/lib/Gitweb/Util.pm |  438 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 443 insertions(+), 387 deletions(-)
 create mode 100755 gitweb/lib/Gitweb/Util.pm

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 5f0a785..df5bcdc 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -127,6 +127,8 @@ GITWEB_JSLIB_FILES += static/js/javascript-detection.js
 GITWEB_JSLIB_FILES += static/js/adjust-timezone.js
 GITWEB_JSLIB_FILES += static/js/blame_incremental.js
 
+# Modules: Gitweb::*
+GITWEB_MODULES += Gitweb/Util.pm
 
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5902212..627364e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -29,6 +29,9 @@ use Fcntl ':mode';
 use File::Find qw();
 use File::Basename qw(basename);
 use Time::HiRes qw(gettimeofday tv_interval);
+
+use Gitweb::Util;
+
 binmode STDOUT, ':utf8';
 
 our $t0 = [ gettimeofday() ];
@@ -1467,139 +1470,6 @@ sub validate_refname {
 	return $input;
 }
 
-# decode sequences of octets in utf8 into Perl's internal form,
-# which is utf-8 with utf8 flag set if needed.  gitweb writes out
-# in utf-8 thanks to "binmode STDOUT, ':utf8'" at beginning
-sub to_utf8 {
-	my $str = shift;
-	return undef unless defined $str;
-
-	if (utf8::is_utf8($str) || utf8::decode($str)) {
-		return $str;
-	} else {
-		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
-	}
-}
-
-# quote unsafe chars, but keep the slash, even when it's not
-# correct, but quoted slashes look too horrible in bookmarks
-sub esc_param {
-	my $str = shift;
-	return undef unless defined $str;
-	$str =~ s/([^A-Za-z0-9\-_.~()\/:@ ]+)/CGI::escape($1)/eg;
-	$str =~ s/ /\+/g;
-	return $str;
-}
-
-# the quoting rules for path_info fragment are slightly different
-sub esc_path_info {
-	my $str = shift;
-	return undef unless defined $str;
-
-	# path_info doesn't treat '+' as space (specially), but '?' must be escaped
-	$str =~ s/([^A-Za-z0-9\-_.~();\/;:@&= +]+)/CGI::escape($1)/eg;
-
-	return $str;
-}
-
-# quote unsafe chars in whole URL, so some characters cannot be quoted
-sub esc_url {
-	my $str = shift;
-	return undef unless defined $str;
-	$str =~ s/([^A-Za-z0-9\-_.~();\/;?:@&= ]+)/CGI::escape($1)/eg;
-	$str =~ s/ /\+/g;
-	return $str;
-}
-
-# quote unsafe characters in HTML attributes
-sub esc_attr {
-
-	# for XHTML conformance escaping '"' to '&quot;' is not enough
-	return esc_html(@_);
-}
-
-# replace invalid utf8 character with SUBSTITUTION sequence
-sub esc_html {
-	my $str = shift;
-	my %opts = @_;
-
-	return undef unless defined $str;
-
-	$str = to_utf8($str);
-	$str = $cgi->escapeHTML($str);
-	if ($opts{'-nbsp'}) {
-		$str =~ s/ /&nbsp;/g;
-	}
-	$str =~ s|([[:cntrl:]])|(($1 ne "\t") ? quot_cec($1) : $1)|eg;
-	return $str;
-}
-
-# quote control characters and escape filename to HTML
-sub esc_path {
-	my $str = shift;
-	my %opts = @_;
-
-	return undef unless defined $str;
-
-	$str = to_utf8($str);
-	$str = $cgi->escapeHTML($str);
-	if ($opts{'-nbsp'}) {
-		$str =~ s/ /&nbsp;/g;
-	}
-	$str =~ s|([[:cntrl:]])|quot_cec($1)|eg;
-	return $str;
-}
-
-# Sanitize for use in XHTML + application/xml+xhtm (valid XML 1.0)
-sub sanitize {
-	my $str = shift;
-
-	return undef unless defined $str;
-
-	$str = to_utf8($str);
-	$str =~ s|([[:cntrl:]])|($1 =~ /[\t\n\r]/ ? $1 : quot_cec($1))|eg;
-	return $str;
-}
-
-# Make control characters "printable", using character escape codes (CEC)
-sub quot_cec {
-	my $cntrl = shift;
-	my %opts = @_;
-	my %es = ( # character escape codes, aka escape sequences
-		"\t" => '\t',   # tab            (HT)
-		"\n" => '\n',   # line feed      (LF)
-		"\r" => '\r',   # carrige return (CR)
-		"\f" => '\f',   # form feed      (FF)
-		"\b" => '\b',   # backspace      (BS)
-		"\a" => '\a',   # alarm (bell)   (BEL)
-		"\e" => '\e',   # escape         (ESC)
-		"\013" => '\v', # vertical tab   (VT)
-		"\000" => '\0', # nul character  (NUL)
-	);
-	my $chr = ( (exists $es{$cntrl})
-		    ? $es{$cntrl}
-		    : sprintf('\%2x', ord($cntrl)) );
-	if ($opts{-nohtml}) {
-		return $chr;
-	} else {
-		return "<span class=\"cntrl\">$chr</span>";
-	}
-}
-
-# Alternatively use unicode control pictures codepoints,
-# Unicode "printable representation" (PR)
-sub quot_upr {
-	my $cntrl = shift;
-	my %opts = @_;
-
-	my $chr = sprintf('&#%04d;', 0x2400+ord($cntrl));
-	if ($opts{-nohtml}) {
-		return $chr;
-	} else {
-		return "<span class=\"cntrl\">$chr</span>";
-	}
-}
-
 # git may return quoted and escaped filenames
 sub unquote {
 	my $str = shift;
@@ -1636,20 +1506,6 @@ sub unquote {
 	return $str;
 }
 
-# escape tabs (convert tabs to spaces)
-sub untabify {
-	my $line = shift;
-
-	while ((my $pos = index($line, "\t")) != -1) {
-		if (my $count = (8 - ($pos % 8))) {
-			my $spaces = ' ' x $count;
-			$line =~ s/\t/$spaces/;
-		}
-	}
-
-	return $line;
-}
-
 sub project_in_list {
 	my $project = shift;
 	my @list = git_get_projects_list();
@@ -1657,167 +1513,6 @@ sub project_in_list {
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
-	$str = to_utf8($str);
-	if ($chopped eq $str) {
-		return esc_html($chopped);
-	} else {
-		$str =~ s/[[:cntrl:]]/?/g;
-		return $cgi->span({-title=>$str}, esc_html($chopped));
-	}
-}
-
-# Highlight selected fragments of string, using given CSS class,
-# and escape HTML.  It is assumed that fragments do not overlap.
-# Regions are passed as list of pairs (array references).
-#
-# Example: esc_html_hl_regions("foobar", "mark", [ 0, 3 ]) returns
-# '<span class="mark">foo</span>bar'
-sub esc_html_hl_regions {
-	my ($str, $css_class, @sel) = @_;
-	return esc_html($str) unless @sel;
-
-	my $out = '';
-	my $pos = 0;
-
-	for my $s (@sel) {
-		$out .= esc_html(substr($str, $pos, $s->[0] - $pos))
-			if ($s->[0] - $pos > 0);
-		$out .= $cgi->span({-class => $css_class},
-		                   esc_html(substr($str, $s->[0], $s->[1] - $s->[0])));
-
-		$pos = $s->[1];
-	}
-	$out .= esc_html(substr($str, $pos))
-		if ($pos < length($str));
-
-	return $out;
-}
-
-# return positions of beginning and end of each match
-sub matchpos_list {
-	my ($str, $regexp) = @_;
-	return unless (defined $str && defined $regexp);
-
-	my @matches;
-	while ($str =~ /$regexp/g) {
-		push @matches, [$-[0], $+[0]];
-	}
-	return @matches;
-}
-
-# highlight match (if any), and escape HTML
-sub esc_html_match_hl {
-	my ($str, $regexp) = @_;
-	return esc_html($str) unless defined $regexp;
-
-	my @matches = matchpos_list($str, $regexp);
-	return esc_html($str) unless @matches;
-
-	return esc_html_hl_regions($str, 'match', @matches);
-}
-
-
-# highlight match (if any) of shortened string, and escape HTML
-sub esc_html_match_hl_chopped {
-	my ($str, $chopped, $regexp) = @_;
-	return esc_html_match_hl($str, $regexp) unless defined $chopped;
-
-	my @matches = matchpos_list($str, $regexp);
-	return esc_html($chopped) unless @matches;
-
-	# filter matches so that we mark chopped string
-	my $tail = "... "; # see chop_str
-	unless ($chopped =~ s/\Q$tail\E$//) {
-		$tail = '';
-	}
-	my $chop_len = length($chopped);
-	my $tail_len = length($tail);
-	my @filtered;
-
-	for my $m (@matches) {
-		if ($m->[0] > $chop_len) {
-			push @filtered, [ $chop_len, $chop_len + $tail_len ] if ($tail_len > 0);
-			last;
-		} elsif ($m->[1] > $chop_len) {
-			push @filtered, [ $m->[0], $chop_len + $tail_len ];
-			last;
-		}
-		push @filtered, $m;
-	}
-
-	return esc_html_hl_regions($chopped . $tail, 'match', @filtered);
-}
-
-## ----------------------------------------------------------------------
 ## functions returning short strings
 
 # CSS class for given age value (in seconds)
@@ -2592,20 +2287,6 @@ sub git_get_type {
 our $config_file = '';
 our %config;
 
-# store multiple values for single key as anonymous array reference
-# single values stored directly in the hash, not as [ <value> ]
-sub hash_set_multi {
-	my ($hash, $key, $value) = @_;
-
-	if (!exists $hash->{$key}) {
-		$hash->{$key} = $value;
-	} elsif (!ref $hash->{$key}) {
-		$hash->{$key} = [ $hash->{$key}, $value ];
-	} else {
-		push @{$hash->{$key}}, $value;
-	}
-}
-
 # return hash of git project configuration
 # optionally limited to some section, e.g. 'gitweb'
 sub git_parse_project_config {
@@ -3715,31 +3396,6 @@ sub git_get_tags_list {
 	return wantarray ? @tagslist : \@tagslist;
 }
 
-## ----------------------------------------------------------------------
-## filesystem-related functions
-
-sub get_file_owner {
-	my $path = shift;
-
-	my ($dev, $ino, $mode, $nlink, $st_uid, $st_gid, $rdev, $size) = stat($path);
-	my ($name, $passwd, $uid, $gid, $quota, $comment, $gcos, $dir, $shell) = getpwuid($st_uid);
-	if (!defined $gcos) {
-		return undef;
-	}
-	my $owner = $gcos;
-	$owner =~ s/[,;].*$//;
-	return to_utf8($owner);
-}
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
 
@@ -4531,46 +4187,6 @@ sub git_get_link_target {
 	return $link_target;
 }
 
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
 # print tree entry (row of git_tree), but without encompassing <tr> element
 sub git_print_tree_entry {
 	my ($t, $basedir, $hash_base, $have_blame) = @_;
diff --git a/gitweb/lib/Gitweb/Util.pm b/gitweb/lib/Gitweb/Util.pm
new file mode 100755
index 0000000..b792200
--- /dev/null
+++ b/gitweb/lib/Gitweb/Util.pm
@@ -0,0 +1,438 @@
+# Gitweb::Util -- Internal utilities used by gitweb (git web interface)
+#                 that do not contain Git- or Gitweb-specific knowledge
+#
+# This module is licensed under the GPLv2
+
+package Gitweb::Util;
+
+use strict;
+use warnings;
+use Exporter qw(import);
+
+our @EXPORT = qw(to_utf8
+                 esc_param esc_path_info esc_url
+                 esc_html esc_path esc_attr
+                 sanitize untabify
+                 chop_str chop_and_escape_str
+                 esc_html_hl_regions matchpos_list
+                 esc_html_match_hl esc_html_match_hl_chopped
+                 hash_set_multi
+                 get_file_owner insert_file normalize_link_target
+                 $fallback_encoding);
+our @EXPORT_OK = qw(quot_cec quot_upr);
+
+use Encode;
+use CGI;
+
+# ......................................................................
+# Perl encoding (utf-8)
+
+# decode sequences of octets in utf8 into Perl's internal form,
+# which is utf-8 with utf8 flag set if needed.  gitweb writes out
+# in utf-8 thanks to "binmode STDOUT, ':utf8'" at beginning of gitweb.perl
+our $fallback_encoding = 'latin1';
+sub to_utf8 {
+	my $str = shift;
+	return undef unless defined $str;
+
+	if (utf8::is_utf8($str) || utf8::decode($str)) {
+		return $str;
+	} else {
+		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
+	}
+}
+
+# ......................................................................
+# CGI encoding
+
+# quote unsafe chars, but keep the slash, even when it's not
+# correct, but quoted slashes look too horrible in bookmarks
+sub esc_param {
+	my $str = shift;
+	return undef unless defined $str;
+
+	$str =~ s/([^A-Za-z0-9\-_.~()\/:@ ]+)/CGI::escape($1)/eg;
+	$str =~ s/ /\+/g;
+
+	return $str;
+}
+
+# the quoting rules for path_info fragment are slightly different
+sub esc_path_info {
+	my $str = shift;
+	return undef unless defined $str;
+
+	# path_info doesn't treat '+' as space (specially), but '?' must be escaped
+	$str =~ s/([^A-Za-z0-9\-_.~();\/;:@&= +]+)/CGI::escape($1)/eg;
+
+	return $str;
+}
+
+# quote unsafe chars in whole URL, so some characters cannot be quoted
+sub esc_url {
+	my $str = shift;
+	return undef unless defined $str;
+
+	$str =~ s/([^A-Za-z0-9\-_.~();\/;?:@&= ]+)/CGI::escape($1)/eg;
+	$str =~ s/ /\+/g;
+
+	return $str;
+}
+
+# ......................................................................
+# (X)HTML escaping
+
+# replace invalid utf8 character with SUBSTITUTION sequence
+sub esc_html {
+	my $str = shift;
+	my %opts = @_;
+
+	return undef unless defined $str;
+
+	$str = to_utf8($str);
+	$str = CGI::escapeHTML($str);
+	if ($opts{'-nbsp'}) {
+		$str =~ s/ /&nbsp;/g;
+	}
+	$str =~ s|([[:cntrl:]])|(($1 ne "\t") ? quot_cec($1) : $1)|eg;
+	return $str;
+}
+
+# quote unsafe characters in HTML attributes
+sub esc_attr {
+
+	# for XHTML conformance escaping '"' to '&quot;' is not enough
+	return esc_html(@_);
+}
+
+# quote control characters and escape filename to HTML
+sub esc_path {
+	my $str = shift;
+	my %opts = @_;
+
+	return undef unless defined $str;
+
+	$str = to_utf8($str);
+	$str = CGI::escapeHTML($str);
+	if ($opts{'-nbsp'}) {
+		$str =~ s/ /&nbsp;/g;
+	}
+	$str =~ s|([[:cntrl:]])|quot_cec($1)|eg;
+	return $str;
+}
+
+# Sanitize for use in XHTML + application/xml+xhtm (valid XML 1.0)
+sub sanitize {
+	my $str = shift;
+
+	return undef unless defined $str;
+
+	$str = to_utf8($str);
+	$str =~ s|([[:cntrl:]])|($1 =~ /[\t\n\r]/ ? $1 : quot_cec($1))|eg;
+	return $str;
+}
+
+# ......................................................................
+# Pretty-printing
+
+# escape tabs (convert tabs to spaces)
+sub untabify {
+	my $line = shift;
+
+	while ((my $pos = index($line, "\t")) != -1) {
+		if (my $count = (8 - ($pos % 8))) {
+			my $spaces = ' ' x $count;
+			$line =~ s/\t/$spaces/;
+		}
+	}
+
+	return $line;
+}
+
+# ......................................................................
+# HTML aware string manipulation
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
+	$str = to_utf8($str);
+	if ($chopped eq $str) {
+		return esc_html($chopped);
+	} else {
+		$str =~ s/[[:cntrl:]]/?/g;
+		return CGI::span({-title=>$str}, esc_html($chopped));
+	}
+}
+
+# Highlight selected fragments of string, using given CSS class,
+# and escape HTML.  It is assumed that fragments do not overlap.
+# Regions are passed as list of pairs (array references).
+#
+# Example: esc_html_hl_regions("foobar", "mark", [ 0, 3 ]) returns
+# '<span class="mark">foo</span>bar'
+sub esc_html_hl_regions {
+	my ($str, $css_class, @sel) = @_;
+	return esc_html($str) unless @sel;
+
+	my $out = '';
+	my $pos = 0;
+
+	for my $s (@sel) {
+		$out .= esc_html(substr($str, $pos, $s->[0] - $pos))
+			if ($s->[0] - $pos > 0);
+		$out .= CGI::span({-class => $css_class},
+		                  esc_html(substr($str, $s->[0], $s->[1] - $s->[0])));
+
+		$pos = $s->[1];
+	}
+	$out .= esc_html(substr($str, $pos))
+		if ($pos < length($str));
+
+	return $out;
+}
+
+# return positions of beginning and end of each match
+sub matchpos_list {
+	my ($str, $regexp) = @_;
+	return unless (defined $str && defined $regexp);
+
+	my @matches;
+	while ($str =~ /$regexp/g) {
+		push @matches, [$-[0], $+[0]];
+	}
+	return @matches;
+}
+
+# highlight match (if any), and escape HTML
+sub esc_html_match_hl {
+	my ($str, $regexp) = @_;
+	return esc_html($str) unless defined $regexp;
+
+	my @matches = matchpos_list($str, $regexp);
+	return esc_html($str) unless @matches;
+
+	return esc_html_hl_regions($str, 'match', @matches);
+}
+
+
+# highlight match (if any) of shortened string, and escape HTML
+sub esc_html_match_hl_chopped {
+	my ($str, $chopped, $regexp) = @_;
+	return esc_html_match_hl($str, $regexp) unless defined $chopped;
+
+	my @matches = matchpos_list($str, $regexp);
+	return esc_html($chopped) unless @matches;
+
+	# filter matches so that we mark chopped string
+	my $tail = "... "; # see chop_str
+	unless ($chopped =~ s/\Q$tail\E$//) {
+		$tail = '';
+	}
+	my $chop_len = length($chopped);
+	my $tail_len = length($tail);
+	my @filtered;
+
+	for my $m (@matches) {
+		if ($m->[0] > $chop_len) {
+			push @filtered, [ $chop_len, $chop_len + $tail_len ] if ($tail_len > 0);
+			last;
+		} elsif ($m->[1] > $chop_len) {
+			push @filtered, [ $m->[0], $chop_len + $tail_len ];
+			last;
+		}
+		push @filtered, $m;
+	}
+
+	return esc_html_hl_regions($chopped . $tail, 'match', @filtered);
+}
+
+# ......................................................................
+# Data structures manipulation
+
+# store multiple values for single key as anonymous array reference
+# single values stored directly in the hash, not as [ <value> ]
+sub hash_set_multi {
+	my ($hash, $key, $value) = @_;
+
+	if (!exists $hash->{$key}) {
+		$hash->{$key} = $value;
+	} elsif (!ref $hash->{$key}) {
+		$hash->{$key} = [ $hash->{$key}, $value ];
+	} else {
+		push @{$hash->{$key}}, $value;
+	}
+}
+
+# ......................................................................
+# filesystem-related functions
+
+sub get_file_owner {
+	my $path = shift;
+
+	my ($dev, $ino, $mode, $nlink, $st_uid, $st_gid, $rdev, $size) = stat($path);
+	my ($name, $passwd, $uid, $gid, $quota, $comment, $gcos, $dir, $shell) = getpwuid($st_uid);
+	if (!defined $gcos) {
+		return undef;
+	}
+	my $owner = $gcos;
+	$owner =~ s/[,;].*$//;
+	return to_utf8($owner);
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
+# ----------------------------------------------------------------------
+# ......................................................................
+# Showing "unprintable" characters (utility functions)
+
+# Make control characters "printable", using character escape codes (CEC)
+sub quot_cec {
+	my $cntrl = shift;
+	my %opts = @_;
+	my %es = ( # character escape codes, aka escape sequences
+		"\t" => '\t',   # tab            (HT)
+		"\n" => '\n',   # line feed      (LF)
+		"\r" => '\r',   # carrige return (CR)
+		"\f" => '\f',   # form feed      (FF)
+		"\b" => '\b',   # backspace      (BS)
+		"\a" => '\a',   # alarm (bell)   (BEL)
+		"\e" => '\e',   # escape         (ESC)
+		"\013" => '\v', # vertical tab   (VT)
+		"\000" => '\0', # nul character  (NUL)
+	);
+	my $chr = ( (exists $es{$cntrl})
+		    ? $es{$cntrl}
+		    : sprintf('\%2x', ord($cntrl)) );
+	if ($opts{-nohtml}) {
+		return $chr;
+	} else {
+		return "<span class=\"cntrl\">$chr</span>";
+	}
+}
+
+# Alternatively use unicode control pictures codepoints,
+# Unicode "printable representation" (PR)
+sub quot_upr {
+	my $cntrl = shift;
+	my %opts = @_;
+
+	my $chr = sprintf('&#%04d;', 0x2400+ord($cntrl));
+	if ($opts{-nohtml}) {
+		return $chr;
+	} else {
+		return "<span class=\"cntrl\">$chr</span>";
+	}
+}
+
+1;
-- 
1.7.9
