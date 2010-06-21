From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH 09/11 GSoC] gitweb: Create Gitweb::Util module
Date: Tue, 22 Jun 2010 03:30:45 +0530
Message-ID: <1277157648-6029-10-git-send-email-pavan.sss1991@gmail.com>
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
	id 1OQp6M-0000ac-3p
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 00:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab0FUWEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 18:04:16 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36311 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024Ab0FUWEO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 18:04:14 -0400
Received: by pwj8 with SMTP id 8so529457pwj.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 15:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=kiBSwzQ9kRkDc5QSAXHbKwXefwlpwnWJXuvgn9V++bU=;
        b=ZcDhGIrhAx/QwM6x8J4aiAG9QibEJZKl/7y0n0H6/rL2bT+rFzbeHROb1HX/ZGOrCx
         MMewfA99B9VdsxE7SA3LliEDxF3qWb4ZlmBQFaHoBNf6R9GjbzqAsxM0JtZq5pJvAMw7
         x19YSguAi+16p+JNWYuyPvW4s53qI4WGpNTV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VdI0R3qnyt/bcfOTVlDP7LHWbqk+/OSCz+gbYkeA2J0XBhagBseTrjRsfjyJL4yzm2
         vIenfpEzs2Ep7792vwgn6BTfPvp59DtNGuM6t+u2mjKysQeq2tE57jjil8evonIu9j23
         S/zoTZ3IeScrnZsORPauJrdJGBYVypfl5vQNI=
Received: by 10.142.7.11 with SMTP id 11mr4049291wfg.136.1277157852131;
        Mon, 21 Jun 2010 15:04:12 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.132])
        by mx.google.com with ESMTPS id y27sm525703wfi.17.2010.06.21.15.04.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jun 2010 15:04:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.454.g6bbe9.dirty
In-Reply-To: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149451>

Create Gitweb::Util module in 'gitweb/lib/Gitweb/Util.pm'
to store the git utility subroutines related to gitweb.

This module include subroutines in various categories
such as git utility subs invoking git commands, git
utility subs accessing git repository, mimetype related
subs and HTML output utility subs.

Subroutines moved:
	git_get_head_hash
	git_get_full_hash
	git_get_short_hash
	git_get_hash
	git_get_type
	git_get_hash_by_path
	git_get_path_by_hash
	git_get_last_activity
	git_get_references
	git_get_rev_name_tags
	git_get_heads_list
	git_get_tags_list
	mimetype_guess_file
	mimetype_guess
	blob_mimetype
	blob_contenttype
	guess_file_syntax
	run_highlighter
	fill_from_file_info
	is_deleted
	is_patch_split

Update 'gitweb/Makefile' to install Gitweb::Util alongside gitweb.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 gitweb/Makefile           |    1 +
 gitweb/gitweb.perl        |  420 +------------------------------------------
 gitweb/lib/Gitweb/Util.pm |  447 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 449 insertions(+), 419 deletions(-)
 create mode 100644 gitweb/lib/Gitweb/Util.pm

diff --git a/gitweb/Makefile b/gitweb/Makefile
index cd2555d..280ff6d 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -118,6 +118,7 @@ GITWEB_MODULES += lib/Gitweb/Request.pm
 GITWEB_MODULES += lib/Gitweb/Escape.pm
 GITWEB_MODULES += lib/Gitweb/RepoConfig.pm
 GITWEB_MODULES += lib/Gitweb/View.pm
+GITWEB_MODULES += lib/Gitweb/Util.pm
 
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 909dd81..a3de63e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -31,6 +31,7 @@ use Gitweb::Request;
 use Gitweb::Escape;
 use Gitweb::RepoConfig;
 use Gitweb::View;
+use Gitweb::Util;
 
 BEGIN {
 	CGI->compile() if $ENV{'MOD_PERL'};
@@ -1086,164 +1087,6 @@ sub format_snapshot_links {
 }
 
 ## ----------------------------------------------------------------------
-## git utility subroutines, invoking git commands
-
-# get HEAD ref of given project as hash
-sub git_get_head_hash {
-	return git_get_full_hash(shift, 'HEAD');
-}
-
-sub git_get_full_hash {
-	return git_get_hash(@_);
-}
-
-sub git_get_short_hash {
-	return git_get_hash(@_, '--short=7');
-}
-
-sub git_get_hash {
-	my ($project, $hash, @options) = @_;
-	my $o_git_dir = $git_dir;
-	my $retval = undef;
-	$git_dir = "$projectroot/$project";
-	if (open my $fd, '-|', git_cmd(), 'rev-parse',
-	    '--verify', '-q', @options, $hash) {
-		$retval = <$fd>;
-		chomp $retval if defined $retval;
-		close $fd;
-	}
-	if (defined $o_git_dir) {
-		$git_dir = $o_git_dir;
-	}
-	return $retval;
-}
-
-# get type of given object
-sub git_get_type {
-	my $hash = shift;
-
-	open my $fd, "-|", git_cmd(), "cat-file", '-t', $hash or return;
-	my $type = <$fd>;
-	close $fd or return;
-	chomp $type;
-	return $type;
-}
-
-# get hash of given path at given ref
-sub git_get_hash_by_path {
-	my $base = shift;
-	my $path = shift || return undef;
-	my $type = shift;
-
-	$path =~ s,/+$,,;
-
-	open my $fd, "-|", git_cmd(), "ls-tree", $base, "--", $path
-		or die_error(500, "Open git-ls-tree failed");
-	my $line = <$fd>;
-	close $fd or return undef;
-
-	if (!defined $line) {
-		# there is no tree or hash given by $path at $base
-		return undef;
-	}
-
-	#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
-	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t/;
-	if (defined $type && $type ne $2) {
-		# type doesn't match
-		return undef;
-	}
-	return $3;
-}
-
-# get path of entry with given hash at given tree-ish (ref)
-# used to get 'from' filename for combined diff (merge commit) for renames
-sub git_get_path_by_hash {
-	my $base = shift || return;
-	my $hash = shift || return;
-
-	local $/ = "\0";
-
-	open my $fd, "-|", git_cmd(), "ls-tree", '-r', '-t', '-z', $base
-		or return undef;
-	while (my $line = <$fd>) {
-		chomp $line;
-
-		#'040000 tree 595596a6a9117ddba9fe379b6b012b558bac8423	gitweb'
-		#'100644 blob e02e90f0429be0d2a69b76571101f20b8f75530f	gitweb/README'
-		if ($line =~ m/(?:[0-9]+) (?:.+) $hash\t(.+)$/) {
-			close $fd;
-			return $1;
-		}
-	}
-	close $fd;
-	return undef;
-}
-
-## ......................................................................
-## git utility functions, directly accessing git repository
-
-sub git_get_last_activity {
-	my ($path) = @_;
-	my $fd;
-
-	$git_dir = "$projectroot/$path";
-	open($fd, "-|", git_cmd(), 'for-each-ref',
-	     '--format=%(committer)',
-	     '--sort=-committerdate',
-	     '--count=1',
-	     'refs/heads') or return;
-	my $most_recent = <$fd>;
-	close $fd or return;
-	if (defined $most_recent &&
-	    $most_recent =~ / (\d+) [-+][01]\d\d\d$/) {
-		my $timestamp = $1;
-		my $age = time - $timestamp;
-		return ($age, age_string($age));
-	}
-	return (undef, undef);
-}
-
-sub git_get_references {
-	my $type = shift || "";
-	my %refs;
-	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c refs/tags/v2.6.11
-	# c39ae07f393806ccf406ef966e9a15afc43cc36a refs/tags/v2.6.11^{}
-	open my $fd, "-|", git_cmd(), "show-ref", "--dereference",
-		($type ? ("--", "refs/$type") : ()) # use -- <pattern> if $type
-		or return;
-
-	while (my $line = <$fd>) {
-		chomp $line;
-		if ($line =~ m!^([0-9a-fA-F]{40})\srefs/($type.*)$!) {
-			if (defined $refs{$1}) {
-				push @{$refs{$1}}, $2;
-			} else {
-				$refs{$1} = [ $2 ];
-			}
-		}
-	}
-	close $fd or return;
-	return \%refs;
-}
-
-sub git_get_rev_name_tags {
-	my $hash = shift || return undef;
-
-	open my $fd, "-|", git_cmd(), "name-rev", "--tags", $hash
-		or return;
-	my $name_rev = <$fd>;
-	close $fd;
-
-	if ($name_rev =~ m|^$hash tags/(.*)$|) {
-		return $1;
-	} else {
-		# catches also '$hash undefined' output
-		return undef;
-	}
-}
-
-## ----------------------------------------------------------------------
 ## parse to hash functions
 
 sub parse_date {
@@ -1599,231 +1442,6 @@ sub parse_from_to_diffinfo {
 }
 
 ## ......................................................................
-## parse to array of hashes functions
-
-sub git_get_heads_list {
-	my $limit = shift;
-	my @headslist;
-
-	open my $fd, '-|', git_cmd(), 'for-each-ref',
-		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
-		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
-		'refs/heads'
-		or return;
-	while (my $line = <$fd>) {
-		my %ref_item;
-
-		chomp $line;
-		my ($refinfo, $committerinfo) = split(/\0/, $line);
-		my ($hash, $name, $title) = split(' ', $refinfo, 3);
-		my ($committer, $epoch, $tz) =
-			($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
-		$ref_item{'fullname'}  = $name;
-		$name =~ s!^refs/heads/!!;
-
-		$ref_item{'name'}  = $name;
-		$ref_item{'id'}    = $hash;
-		$ref_item{'title'} = $title || '(no commit message)';
-		$ref_item{'epoch'} = $epoch;
-		if ($epoch) {
-			$ref_item{'age'} = age_string(time - $ref_item{'epoch'});
-		} else {
-			$ref_item{'age'} = "unknown";
-		}
-
-		push @headslist, \%ref_item;
-	}
-	close $fd;
-
-	return wantarray ? @headslist : \@headslist;
-}
-
-sub git_get_tags_list {
-	my $limit = shift;
-	my @tagslist;
-
-	open my $fd, '-|', git_cmd(), 'for-each-ref',
-		($limit ? '--count='.($limit+1) : ()), '--sort=-creatordate',
-		'--format=%(objectname) %(objecttype) %(refname) '.
-		'%(*objectname) %(*objecttype) %(subject)%00%(creator)',
-		'refs/tags'
-		or return;
-	while (my $line = <$fd>) {
-		my %ref_item;
-
-		chomp $line;
-		my ($refinfo, $creatorinfo) = split(/\0/, $line);
-		my ($id, $type, $name, $refid, $reftype, $title) = split(' ', $refinfo, 6);
-		my ($creator, $epoch, $tz) =
-			($creatorinfo =~ /^(.*) ([0-9]+) (.*)$/);
-		$ref_item{'fullname'} = $name;
-		$name =~ s!^refs/tags/!!;
-
-		$ref_item{'type'} = $type;
-		$ref_item{'id'} = $id;
-		$ref_item{'name'} = $name;
-		if ($type eq "tag") {
-			$ref_item{'subject'} = $title;
-			$ref_item{'reftype'} = $reftype;
-			$ref_item{'refid'}   = $refid;
-		} else {
-			$ref_item{'reftype'} = $type;
-			$ref_item{'refid'}   = $id;
-		}
-
-		if ($type eq "tag" || $type eq "commit") {
-			$ref_item{'epoch'} = $epoch;
-			if ($epoch) {
-				$ref_item{'age'} = age_string(time - $ref_item{'epoch'});
-			} else {
-				$ref_item{'age'} = "unknown";
-			}
-		}
-
-		push @tagslist, \%ref_item;
-	}
-	close $fd;
-
-	return wantarray ? @tagslist : \@tagslist;
-}
-
-## ......................................................................
-## mimetype related functions
-
-sub mimetype_guess_file {
-	my $filename = shift;
-	my $mimemap = shift;
-	-r $mimemap or return undef;
-
-	my %mimemap;
-	open(my $mh, '<', $mimemap) or return undef;
-	while (<$mh>) {
-		next if m/^#/; # skip comments
-		my ($mimetype, $exts) = split(/\t+/);
-		if (defined $exts) {
-			my @exts = split(/\s+/, $exts);
-			foreach my $ext (@exts) {
-				$mimemap{$ext} = $mimetype;
-			}
-		}
-	}
-	close($mh);
-
-	$filename =~ /\.([^.]*)$/;
-	return $mimemap{$1};
-}
-
-sub mimetype_guess {
-	my $filename = shift;
-	my $mime;
-	$filename =~ /\./ or return undef;
-
-	if ($mimetypes_file) {
-		my $file = $mimetypes_file;
-		if ($file !~ m!^/!) { # if it is relative path
-			# it is relative to project
-			$file = "$projectroot/$project/$file";
-		}
-		$mime = mimetype_guess_file($filename, $file);
-	}
-	$mime ||= mimetype_guess_file($filename, '/etc/mime.types');
-	return $mime;
-}
-
-sub blob_mimetype {
-	my $fd = shift;
-	my $filename = shift;
-
-	if ($filename) {
-		my $mime = mimetype_guess($filename);
-		$mime and return $mime;
-	}
-
-	# just in case
-	return $default_blob_plain_mimetype unless $fd;
-
-	if (-T $fd) {
-		return 'text/plain';
-	} elsif (! $filename) {
-		return 'application/octet-stream';
-	} elsif ($filename =~ m/\.png$/i) {
-		return 'image/png';
-	} elsif ($filename =~ m/\.gif$/i) {
-		return 'image/gif';
-	} elsif ($filename =~ m/\.jpe?g$/i) {
-		return 'image/jpeg';
-	} else {
-		return 'application/octet-stream';
-	}
-}
-
-sub blob_contenttype {
-	my ($fd, $file_name, $type) = @_;
-
-	$type ||= blob_mimetype($fd, $file_name);
-	if ($type eq 'text/plain' && defined $default_text_plain_charset) {
-		$type .= "; charset=$default_text_plain_charset";
-	}
-
-	return $type;
-}
-
-# guess file syntax for syntax highlighting; return undef if no highlighting
-# the name of syntax can (in the future) depend on syntax highlighter used
-sub guess_file_syntax {
-	my ($highlight, $mimetype, $file_name) = @_;
-	return undef unless ($highlight && defined $file_name);
-
-	# configuration for 'highlight' (http://www.andre-simon.de/)
-	# match by basename
-	my %highlight_basename = (
-		#'Program' => 'py',
-		#'Library' => 'py',
-		'SConstruct' => 'py', # SCons equivalent of Makefile
-		'Makefile' => 'make',
-	);
-	# match by extension
-	my %highlight_ext = (
-		# main extensions, defining name of syntax;
-		# see files in /usr/share/highlight/langDefs/ directory
-		map { $_ => $_ }
-			qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tcl),
-		# alternate extensions, see /etc/highlight/filetypes.conf
-		'h' => 'c',
-		map { $_ => 'cpp' } qw(cxx c++ cc),
-		map { $_ => 'php' } qw(php3 php4),
-		map { $_ => 'pl'  } qw(perl pm), # perhaps also 'cgi'
-		'mak' => 'make',
-		map { $_ => 'xml' } qw(xhtml html htm),
-	);
-
-	my $basename = basename($file_name, '.in');
-	return $highlight_basename{$basename}
-		if exists $highlight_basename{$basename};
-
-	$basename =~ /\.([^.]*)$/;
-	my $ext = $1 or return undef;
-	return $highlight_ext{$ext}
-		if exists $highlight_ext{$ext};
-
-	return undef;
-}
-
-# run highlighter and return FD of its output,
-# or return original FD if no highlighting
-sub run_highlighter {
-	my ($fd, $highlight, $syntax) = @_;
-	return $fd unless ($highlight && defined $syntax);
-
-	close $fd
-		or die_error(404, "Reading blob failed");
-	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
-	          "highlight --xhtml --fragment --syntax $syntax |"
-		or die_error(500, "Couldn't open file or run syntax highlighter");
-	return $fd;
-}
-
-## ......................................................................
 ## functions printing or outputting HTML: div
 
 # Outputs the author name and date in long form
@@ -1922,42 +1540,6 @@ sub git_print_log {
 ## ......................................................................
 ## functions printing large fragments of HTML
 
-# get pre-image filenames for merge (combined) diff
-sub fill_from_file_info {
-	my ($diff, @parents) = @_;
-
-	$diff->{'from_file'} = [ ];
-	$diff->{'from_file'}[$diff->{'nparents'} - 1] = undef;
-	for (my $i = 0; $i < $diff->{'nparents'}; $i++) {
-		if ($diff->{'status'}[$i] eq 'R' ||
-		    $diff->{'status'}[$i] eq 'C') {
-			$diff->{'from_file'}[$i] =
-				git_get_path_by_hash($parents[$i], $diff->{'from_id'}[$i]);
-		}
-	}
-
-	return $diff;
-}
-
-# is current raw difftree line of file deletion
-sub is_deleted {
-	my $diffinfo = shift;
-
-	return $diffinfo->{'to_id'} eq ('0' x 40);
-}
-
-# does patch correspond to [previous] difftree raw line
-# $diffinfo  - hashref of parsed raw diff format
-# $patchinfo - hashref of parsed patch diff format
-#              (the same keys as in $diffinfo)
-sub is_patch_split {
-	my ($diffinfo, $patchinfo) = @_;
-
-	return defined $diffinfo && defined $patchinfo
-		&& $diffinfo->{'to_file'} eq $patchinfo->{'to_file'};
-}
-
-
 sub git_difftree_body {
 	my ($difftree, $hash, @parents) = @_;
 	my ($parent) = $parents[0];
diff --git a/gitweb/lib/Gitweb/Util.pm b/gitweb/lib/Gitweb/Util.pm
new file mode 100644
index 0000000..4d0f5d8
--- /dev/null
+++ b/gitweb/lib/Gitweb/Util.pm
@@ -0,0 +1,447 @@
+#!/usr/bin/perl
+#
+# Gitweb::Util -- gitweb's utility function subs package
+#
+# This program is licensed under the GPLv2
+
+package Gitweb::Util;
+
+use strict;
+use warnings;
+use Exporter qw(import);
+
+our @EXPORT = qw(guess_file_syntax run_highlighter git_get_head_hash git_get_hash
+                 git_get_full_hash git_get_short_hash git_get_type git_get_hash_by_path
+                 git_get_path_by_hash git_get_last_activity git_get_references
+                 git_get_rev_name_tags git_get_heads_list git_get_tags_list blob_mimetype
+                 blob_contenttype fill_from_file_info is_deleted is_patch_split);
+
+use File::Basename qw(basename);
+use Gitweb::Git qw(git_cmd $git_dir quote_command);
+use Gitweb::Config qw($projectroot $mimetypes_file $default_text_plain_charset
+                      $default_blob_plain_mimetype);
+use Gitweb::Request qw($project $hash);
+use Gitweb::View qw(die_error age_string);
+
+## ----------------------------------------------------------------------
+## git utility subroutines, invoking git commands
+
+# get HEAD ref of given project as hash
+sub git_get_head_hash {
+	return git_get_full_hash(shift, 'HEAD');
+}
+
+sub git_get_full_hash {
+	return git_get_hash(@_);
+}
+
+sub git_get_short_hash {
+	return git_get_hash(@_, '--short=7');
+}
+
+sub git_get_hash {
+	my ($project, $hash, @options) = @_;
+	my $o_git_dir = $git_dir;
+	my $retval = undef;
+	$git_dir = "$projectroot/$project";
+	if (open my $fd, '-|', git_cmd(), 'rev-parse',
+	    '--verify', '-q', @options, $hash) {
+		$retval = <$fd>;
+		chomp $retval if defined $retval;
+		close $fd;
+	}
+	if (defined $o_git_dir) {
+		$git_dir = $o_git_dir;
+	}
+	return $retval;
+}
+
+# get type of given object
+sub git_get_type {
+	my $hash = shift;
+
+	open my $fd, "-|", git_cmd(), "cat-file", '-t', $hash or return;
+	my $type = <$fd>;
+	close $fd or return;
+	chomp $type;
+	return $type;
+}
+
+# get hash of given path at given ref
+sub git_get_hash_by_path {
+	my $base = shift;
+	my $path = shift || return undef;
+	my $type = shift;
+
+	$path =~ s,/+$,,;
+
+	open my $fd, "-|", git_cmd(), "ls-tree", $base, "--", $path
+		or die_error(500, "Open git-ls-tree failed");
+	my $line = <$fd>;
+	close $fd or return undef;
+
+	if (!defined $line) {
+		# there is no tree or hash given by $path at $base
+		return undef;
+	}
+
+	#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
+	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t/;
+	if (defined $type && $type ne $2) {
+		# type doesn't match
+		return undef;
+	}
+	return $3;
+}
+
+# get path of entry with given hash at given tree-ish (ref)
+# used to get 'from' filename for combined diff (merge commit) for renames
+sub git_get_path_by_hash {
+	my $base = shift || return;
+	my $hash = shift || return;
+
+	local $/ = "\0";
+
+	open my $fd, "-|", git_cmd(), "ls-tree", '-r', '-t', '-z', $base
+		or return undef;
+	while (my $line = <$fd>) {
+		chomp $line;
+
+		#'040000 tree 595596a6a9117ddba9fe379b6b012b558bac8423	gitweb'
+		#'100644 blob e02e90f0429be0d2a69b76571101f20b8f75530f	gitweb/README'
+		if ($line =~ m/(?:[0-9]+) (?:.+) $hash\t(.+)$/) {
+			close $fd;
+			return $1;
+		}
+	}
+	close $fd;
+	return undef;
+}
+
+## ......................................................................
+## git utility functions, directly accessing git repository
+
+sub git_get_last_activity {
+	my ($path) = @_;
+	my $fd;
+
+	$git_dir = "$projectroot/$path";
+	open($fd, "-|", git_cmd(), 'for-each-ref',
+	     '--format=%(committer)',
+	     '--sort=-committerdate',
+	     '--count=1',
+	     'refs/heads') or return;
+	my $most_recent = <$fd>;
+	close $fd or return;
+	if (defined $most_recent &&
+	    $most_recent =~ / (\d+) [-+][01]\d\d\d$/) {
+		my $timestamp = $1;
+		my $age = time - $timestamp;
+		return ($age, age_string($age));
+	}
+	return (undef, undef);
+}
+
+sub git_get_references {
+	my $type = shift || "";
+	my %refs;
+	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c refs/tags/v2.6.11
+	# c39ae07f393806ccf406ef966e9a15afc43cc36a refs/tags/v2.6.11^{}
+	open my $fd, "-|", git_cmd(), "show-ref", "--dereference",
+		($type ? ("--", "refs/$type") : ()) # use -- <pattern> if $type
+		or return;
+
+	while (my $line = <$fd>) {
+		chomp $line;
+		if ($line =~ m!^([0-9a-fA-F]{40})\srefs/($type.*)$!) {
+			if (defined $refs{$1}) {
+				push @{$refs{$1}}, $2;
+			} else {
+				$refs{$1} = [ $2 ];
+			}
+		}
+	}
+	close $fd or return;
+	return \%refs;
+}
+
+sub git_get_rev_name_tags {
+	my $hash = shift || return undef;
+
+	open my $fd, "-|", git_cmd(), "name-rev", "--tags", $hash
+		or return;
+	my $name_rev = <$fd>;
+	close $fd;
+
+	if ($name_rev =~ m|^$hash tags/(.*)$|) {
+		return $1;
+	} else {
+		# catches also '$hash undefined' output
+		return undef;
+	}
+}
+
+## ......................................................................
+## parse to array of hashes functions
+
+sub git_get_heads_list {
+	my $limit = shift;
+	my @headslist;
+
+	open my $fd, '-|', git_cmd(), 'for-each-ref',
+		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
+		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
+		'refs/heads'
+		or return;
+	while (my $line = <$fd>) {
+		my %ref_item;
+
+		chomp $line;
+		my ($refinfo, $committerinfo) = split(/\0/, $line);
+		my ($hash, $name, $title) = split(' ', $refinfo, 3);
+		my ($committer, $epoch, $tz) =
+			($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
+		$ref_item{'fullname'}  = $name;
+		$name =~ s!^refs/heads/!!;
+
+		$ref_item{'name'}  = $name;
+		$ref_item{'id'}    = $hash;
+		$ref_item{'title'} = $title || '(no commit message)';
+		$ref_item{'epoch'} = $epoch;
+		if ($epoch) {
+			$ref_item{'age'} = age_string(time - $ref_item{'epoch'});
+		} else {
+			$ref_item{'age'} = "unknown";
+		}
+
+		push @headslist, \%ref_item;
+	}
+	close $fd;
+
+	return wantarray ? @headslist : \@headslist;
+}
+
+sub git_get_tags_list {
+	my $limit = shift;
+	my @tagslist;
+
+	open my $fd, '-|', git_cmd(), 'for-each-ref',
+		($limit ? '--count='.($limit+1) : ()), '--sort=-creatordate',
+		'--format=%(objectname) %(objecttype) %(refname) '.
+		'%(*objectname) %(*objecttype) %(subject)%00%(creator)',
+		'refs/tags'
+		or return;
+	while (my $line = <$fd>) {
+		my %ref_item;
+
+		chomp $line;
+		my ($refinfo, $creatorinfo) = split(/\0/, $line);
+		my ($id, $type, $name, $refid, $reftype, $title) = split(' ', $refinfo, 6);
+		my ($creator, $epoch, $tz) =
+			($creatorinfo =~ /^(.*) ([0-9]+) (.*)$/);
+		$ref_item{'fullname'} = $name;
+		$name =~ s!^refs/tags/!!;
+
+		$ref_item{'type'} = $type;
+		$ref_item{'id'} = $id;
+		$ref_item{'name'} = $name;
+		if ($type eq "tag") {
+			$ref_item{'subject'} = $title;
+			$ref_item{'reftype'} = $reftype;
+			$ref_item{'refid'}   = $refid;
+		} else {
+			$ref_item{'reftype'} = $type;
+			$ref_item{'refid'}   = $id;
+		}
+
+		if ($type eq "tag" || $type eq "commit") {
+			$ref_item{'epoch'} = $epoch;
+			if ($epoch) {
+				$ref_item{'age'} = age_string(time - $ref_item{'epoch'});
+			} else {
+				$ref_item{'age'} = "unknown";
+			}
+		}
+
+		push @tagslist, \%ref_item;
+	}
+	close $fd;
+
+	return wantarray ? @tagslist : \@tagslist;
+}
+
+## ......................................................................
+## mimetype related functions
+
+sub mimetype_guess_file {
+	my $filename = shift;
+	my $mimemap = shift;
+	-r $mimemap or return undef;
+
+	my %mimemap;
+	open(my $mh, '<', $mimemap) or return undef;
+	while (<$mh>) {
+		next if m/^#/; # skip comments
+		my ($mimetype, $exts) = split(/\t+/);
+		if (defined $exts) {
+			my @exts = split(/\s+/, $exts);
+			foreach my $ext (@exts) {
+				$mimemap{$ext} = $mimetype;
+			}
+		}
+	}
+	close($mh);
+
+	$filename =~ /\.([^.]*)$/;
+	return $mimemap{$1};
+}
+
+sub mimetype_guess {
+	my $filename = shift;
+	my $mime;
+	$filename =~ /\./ or return undef;
+
+	if ($mimetypes_file) {
+		my $file = $mimetypes_file;
+		if ($file !~ m!^/!) { # if it is relative path
+			# it is relative to project
+			$file = "$projectroot/$project/$file";
+		}
+		$mime = mimetype_guess_file($filename, $file);
+	}
+	$mime ||= mimetype_guess_file($filename, '/etc/mime.types');
+	return $mime;
+}
+
+sub blob_mimetype {
+	my $fd = shift;
+	my $filename = shift;
+
+	if ($filename) {
+		my $mime = mimetype_guess($filename);
+		$mime and return $mime;
+	}
+
+	# just in case
+	return $default_blob_plain_mimetype unless $fd;
+
+	if (-T $fd) {
+		return 'text/plain';
+	} elsif (! $filename) {
+		return 'application/octet-stream';
+	} elsif ($filename =~ m/\.png$/i) {
+		return 'image/png';
+	} elsif ($filename =~ m/\.gif$/i) {
+		return 'image/gif';
+	} elsif ($filename =~ m/\.jpe?g$/i) {
+		return 'image/jpeg';
+	} else {
+		return 'application/octet-stream';
+	}
+}
+
+sub blob_contenttype {
+	my ($fd, $file_name, $type) = @_;
+
+	$type ||= blob_mimetype($fd, $file_name);
+	if ($type eq 'text/plain' && defined $default_text_plain_charset) {
+		$type .= "; charset=$default_text_plain_charset";
+	}
+
+	return $type;
+}
+
+# guess file syntax for syntax highlighting; return undef if no highlighting
+# the name of syntax can (in the future) depend on syntax highlighter used
+sub guess_file_syntax {
+	my ($highlight, $mimetype, $file_name) = @_;
+	return undef unless ($highlight && defined $file_name);
+
+	# configuration for 'highlight' (http://www.andre-simon.de/)
+	# match by basename
+	my %highlight_basename = (
+		#'Program' => 'py',
+		#'Library' => 'py',
+		'SConstruct' => 'py', # SCons equivalent of Makefile
+		'Makefile' => 'make',
+	);
+	# match by extension
+	my %highlight_ext = (
+		# main extensions, defining name of syntax;
+		# see files in /usr/share/highlight/langDefs/ directory
+		map { $_ => $_ }
+			qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tcl),
+		# alternate extensions, see /etc/highlight/filetypes.conf
+		'h' => 'c',
+		map { $_ => 'cpp' } qw(cxx c++ cc),
+		map { $_ => 'php' } qw(php3 php4),
+		map { $_ => 'pl'  } qw(perl pm), # perhaps also 'cgi'
+		'mak' => 'make',
+		map { $_ => 'xml' } qw(xhtml html htm),
+	);
+
+	my $basename = basename($file_name, '.in');
+	return $highlight_basename{$basename}
+		if exists $highlight_basename{$basename};
+
+	$basename =~ /\.([^.]*)$/;
+	my $ext = $1 or return undef;
+	return $highlight_ext{$ext}
+		if exists $highlight_ext{$ext};
+
+	return undef;
+}
+
+# run highlighter and return FD of its output,
+# or return original FD if no highlighting
+sub run_highlighter {
+	my ($fd, $highlight, $syntax) = @_;
+	return $fd unless ($highlight && defined $syntax);
+
+	close $fd
+		or die_error(404, "Reading blob failed");
+	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
+	          "highlight --xhtml --fragment --syntax $syntax |"
+		or die_error(500, "Couldn't open file or run syntax highlighter");
+	return $fd;
+}
+
+## ......................................................................
+## functions printing large fragments of HTML
+
+# get pre-image filenames for merge (combined) diff
+sub fill_from_file_info {
+	my ($diff, @parents) = @_;
+
+	$diff->{'from_file'} = [ ];
+	$diff->{'from_file'}[$diff->{'nparents'} - 1] = undef;
+	for (my $i = 0; $i < $diff->{'nparents'}; $i++) {
+		if ($diff->{'status'}[$i] eq 'R' ||
+		    $diff->{'status'}[$i] eq 'C') {
+			$diff->{'from_file'}[$i] =
+				git_get_path_by_hash($parents[$i], $diff->{'from_id'}[$i]);
+		}
+	}
+
+	return $diff;
+}
+
+# is current raw difftree line of file deletion
+sub is_deleted {
+	my $diffinfo = shift;
+
+	return $diffinfo->{'to_id'} eq ('0' x 40);
+}
+
+# does patch correspond to [previous] difftree raw line
+# $diffinfo  - hashref of parsed raw diff format
+# $patchinfo - hashref of parsed patch diff format
+#              (the same keys as in $diffinfo)
+sub is_patch_split {
+	my ($diffinfo, $patchinfo) = @_;
+
+	return defined $diffinfo && defined $patchinfo
+		&& $diffinfo->{'to_file'} eq $patchinfo->{'to_file'};
+}
+
+1;
-- 
1.7.1.454.g276eb9.dirty
