From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCHv2 GSOC 11/11] gitweb: Create Gitweb::Parse module
Date: Thu, 15 Jul 2010 12:59:11 +0530
Message-ID: <1279178951-23712-12-git-send-email-pavan.sss1991@gmail.com>
References: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Thu Jul 15 09:30:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZItz-0003W1-2Q
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 09:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564Ab0GOHad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 03:30:33 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:46630 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932555Ab0GOHab (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 03:30:31 -0400
Received: by pxi14 with SMTP id 14so278963pxi.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 00:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hqv22hmY7j0QIiT8BxWGSJx2jyLcqxxTt7bdOuLtnCc=;
        b=eaPkXNSe0j7nj7ZA9g86PNUe4pws29yzU1BWc0uID+w6LDRBa4orMOlxGfcuGwq3ht
         d456voLCITDMA5UoyK5MpRyVgtsHCgD3ljQ7B7fijkD8bJ/msU0lkjx94O+aMUCiyLxC
         1JGVcRtTczhKVJlfZmL83No8ztn8kGO6tQjhY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jRoi8rnnPn5Q8P9nT2qJNoNf9jLybePhvE6Q9UWfaMJoLFt56dFtgaIqe6XobEIhCQ
         NTxcgHZlw6fU8gOz2yPzfWAXHr6yOJ2kbimZdIuIXnIN6LwVQoPrQB3ms6uYSnbl3zAe
         tbHgY7f9hXyTsH66rOY5+tr1hOCYlk40XQGJc=
Received: by 10.142.188.13 with SMTP id l13mr22014653wff.54.1279179003155;
        Thu, 15 Jul 2010 00:30:03 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.132])
        by mx.google.com with ESMTPS id l29sm8484428rvb.7.2010.07.15.00.29.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 00:30:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.455.g8f441
In-Reply-To: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151059>

Create Gitweb::Parse module in 'gitweb/lib/Gitweb/Parse.pm'
to store the subroutines which related to parsing functions
required for gitweb.

This module depends on Git.pm, Escape.pm, View.pm and Util.pm.

Subroutines moved:
	unquote
	parse_date
	parse_tag
	parse_commit_text
	parse_commit
	parse_commits
	parse_difftree_raw_line
	parsed_difftree_line
	parse_ls_tree_line
	parse_from_to_diffinfo

Update 'gitweb/Makefile' to install Gitweb::Parse alongside gitweb.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 gitweb/Makefile            |    1 +
 gitweb/gitweb.perl         |  392 +-----------------------------------------
 gitweb/lib/Gitweb/Parse.pm |  414 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 416 insertions(+), 391 deletions(-)
 create mode 100644 gitweb/lib/Gitweb/Parse.pm

diff --git a/gitweb/Makefile b/gitweb/Makefile
index f1803f5..1c1bdca 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -120,6 +120,7 @@ GITWEB_MODULES += lib/Gitweb/RepoConfig.pm
 GITWEB_MODULES += lib/Gitweb/View.pm
 GITWEB_MODULES += lib/Gitweb/Util.pm
 GITWEB_MODULES += lib/Gitweb/Format.pm
+GITWEB_MODULES += lib/Gitweb/Parse.pm
 
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3de3de5..efa9bdb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -33,6 +33,7 @@ use Gitweb::RepoConfig;
 use Gitweb::View;
 use Gitweb::Util;
 use Gitweb::Format;
+use Gitweb::Parse;
 
 BEGIN {
 	CGI->compile() if $ENV{'MOD_PERL'};
@@ -568,397 +569,6 @@ sub validate_refname {
 	return $input;
 }
 
-# git may return quoted and escaped filenames
-sub unquote {
-	my $str = shift;
-
-	sub unq {
-		my $seq = shift;
-		my %es = ( # character escape codes, aka escape sequences
-			't' => "\t",   # tab            (HT, TAB)
-			'n' => "\n",   # newline        (NL)
-			'r' => "\r",   # return         (CR)
-			'f' => "\f",   # form feed      (FF)
-			'b' => "\b",   # backspace      (BS)
-			'a' => "\a",   # alarm (bell)   (BEL)
-			'e' => "\e",   # escape         (ESC)
-			'v' => "\013", # vertical tab   (VT)
-		);
-
-		if ($seq =~ m/^[0-7]{1,3}$/) {
-			# octal char sequence
-			return chr(oct($seq));
-		} elsif (exists $es{$seq}) {
-			# C escape sequence, aka character escape code
-			return $es{$seq};
-		}
-		# quoted ordinary character
-		return $seq;
-	}
-
-	if ($str =~ m/^"(.*)"$/) {
-		# needs unquoting
-		$str = $1;
-		$str =~ s/\\([^0-7]|[0-7]{1,3})/unq($1)/eg;
-	}
-	return $str;
-}
-
-## ----------------------------------------------------------------------
-## parse to hash functions
-
-sub parse_date {
-	my $epoch = shift;
-	my $tz = shift || "-0000";
-
-	my %date;
-	my @months = ("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
-	my @days = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");
-	my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) = gmtime($epoch);
-	$date{'hour'} = $hour;
-	$date{'minute'} = $min;
-	$date{'mday'} = $mday;
-	$date{'day'} = $days[$wday];
-	$date{'month'} = $months[$mon];
-	$date{'rfc2822'}   = sprintf "%s, %d %s %4d %02d:%02d:%02d +0000",
-	                     $days[$wday], $mday, $months[$mon], 1900+$year, $hour ,$min, $sec;
-	$date{'mday-time'} = sprintf "%d %s %02d:%02d",
-	                     $mday, $months[$mon], $hour ,$min;
-	$date{'iso-8601'}  = sprintf "%04d-%02d-%02dT%02d:%02d:%02dZ",
-	                     1900+$year, 1+$mon, $mday, $hour ,$min, $sec;
-
-	$tz =~ m/^([+\-][0-9][0-9])([0-9][0-9])$/;
-	my $local = $epoch + ((int $1 + ($2/60)) * 3600);
-	($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) = gmtime($local);
-	$date{'hour_local'} = $hour;
-	$date{'minute_local'} = $min;
-	$date{'tz_local'} = $tz;
-	$date{'iso-tz'} = sprintf("%04d-%02d-%02d %02d:%02d:%02d %s",
-	                          1900+$year, $mon+1, $mday,
-	                          $hour, $min, $sec, $tz);
-	return %date;
-}
-
-sub parse_tag {
-	my $tag_id = shift;
-	my %tag;
-	my @comment;
-
-	open my $fd, "-|", git_cmd(), "cat-file", "tag", $tag_id or return;
-	$tag{'id'} = $tag_id;
-	while (my $line = <$fd>) {
-		chomp $line;
-		if ($line =~ m/^object ([0-9a-fA-F]{40})$/) {
-			$tag{'object'} = $1;
-		} elsif ($line =~ m/^type (.+)$/) {
-			$tag{'type'} = $1;
-		} elsif ($line =~ m/^tag (.+)$/) {
-			$tag{'name'} = $1;
-		} elsif ($line =~ m/^tagger (.*) ([0-9]+) (.*)$/) {
-			$tag{'author'} = $1;
-			$tag{'author_epoch'} = $2;
-			$tag{'author_tz'} = $3;
-			if ($tag{'author'} =~ m/^([^<]+) <([^>]*)>/) {
-				$tag{'author_name'}  = $1;
-				$tag{'author_email'} = $2;
-			} else {
-				$tag{'author_name'} = $tag{'author'};
-			}
-		} elsif ($line =~ m/--BEGIN/) {
-			push @comment, $line;
-			last;
-		} elsif ($line eq "") {
-			last;
-		}
-	}
-	push @comment, <$fd>;
-	$tag{'comment'} = \@comment;
-	close $fd or return;
-	if (!defined $tag{'name'}) {
-		return
-	};
-	return %tag
-}
-
-sub parse_commit_text {
-	my ($commit_text, $withparents) = @_;
-	my @commit_lines = split '\n', $commit_text;
-	my %co;
-
-	pop @commit_lines; # Remove '\0'
-
-	if (! @commit_lines) {
-		return;
-	}
-
-	my $header = shift @commit_lines;
-	if ($header !~ m/^[0-9a-fA-F]{40}/) {
-		return;
-	}
-	($co{'id'}, my @parents) = split ' ', $header;
-	while (my $line = shift @commit_lines) {
-		last if $line eq "\n";
-		if ($line =~ m/^tree ([0-9a-fA-F]{40})$/) {
-			$co{'tree'} = $1;
-		} elsif ((!defined $withparents) && ($line =~ m/^parent ([0-9a-fA-F]{40})$/)) {
-			push @parents, $1;
-		} elsif ($line =~ m/^author (.*) ([0-9]+) (.*)$/) {
-			$co{'author'} = to_utf8($1);
-			$co{'author_epoch'} = $2;
-			$co{'author_tz'} = $3;
-			if ($co{'author'} =~ m/^([^<]+) <([^>]*)>/) {
-				$co{'author_name'}  = $1;
-				$co{'author_email'} = $2;
-			} else {
-				$co{'author_name'} = $co{'author'};
-			}
-		} elsif ($line =~ m/^committer (.*) ([0-9]+) (.*)$/) {
-			$co{'committer'} = to_utf8($1);
-			$co{'committer_epoch'} = $2;
-			$co{'committer_tz'} = $3;
-			if ($co{'committer'} =~ m/^([^<]+) <([^>]*)>/) {
-				$co{'committer_name'}  = $1;
-				$co{'committer_email'} = $2;
-			} else {
-				$co{'committer_name'} = $co{'committer'};
-			}
-		}
-	}
-	if (!defined $co{'tree'}) {
-		return;
-	};
-	$co{'parents'} = \@parents;
-	$co{'parent'} = $parents[0];
-
-	foreach my $title (@commit_lines) {
-		$title =~ s/^    //;
-		if ($title ne "") {
-			$co{'title'} = chop_str($title, 80, 5);
-			# remove leading stuff of merges to make the interesting part visible
-			if (length($title) > 50) {
-				$title =~ s/^Automatic //;
-				$title =~ s/^merge (of|with) /Merge ... /i;
-				if (length($title) > 50) {
-					$title =~ s/(http|rsync):\/\///;
-				}
-				if (length($title) > 50) {
-					$title =~ s/(master|www|rsync)\.//;
-				}
-				if (length($title) > 50) {
-					$title =~ s/kernel.org:?//;
-				}
-				if (length($title) > 50) {
-					$title =~ s/\/pub\/scm//;
-				}
-			}
-			$co{'title_short'} = chop_str($title, 50, 5);
-			last;
-		}
-	}
-	if (! defined $co{'title'} || $co{'title'} eq "") {
-		$co{'title'} = $co{'title_short'} = '(no commit message)';
-	}
-	# remove added spaces
-	foreach my $line (@commit_lines) {
-		$line =~ s/^    //;
-	}
-	$co{'comment'} = \@commit_lines;
-
-	my $age = time - $co{'committer_epoch'};
-	$co{'age'} = $age;
-	$co{'age_string'} = age_string($age);
-	my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) = gmtime($co{'committer_epoch'});
-	if ($age > 60*60*24*7*2) {
-		$co{'age_string_date'} = sprintf "%4i-%02u-%02i", 1900 + $year, $mon+1, $mday;
-		$co{'age_string_age'} = $co{'age_string'};
-	} else {
-		$co{'age_string_date'} = $co{'age_string'};
-		$co{'age_string_age'} = sprintf "%4i-%02u-%02i", 1900 + $year, $mon+1, $mday;
-	}
-	return %co;
-}
-
-sub parse_commit {
-	my ($commit_id) = @_;
-	my %co;
-
-	local $/ = "\0";
-
-	open my $fd, "-|", git_cmd(), "rev-list",
-		"--parents",
-		"--header",
-		"--max-count=1",
-		$commit_id,
-		"--",
-		or die_error(500, "Open git-rev-list failed");
-	%co = parse_commit_text(<$fd>, 1);
-	close $fd;
-
-	return %co;
-}
-
-sub parse_commits {
-	my ($commit_id, $maxcount, $skip, $filename, @args) = @_;
-	my @cos;
-
-	$maxcount ||= 1;
-	$skip ||= 0;
-
-	local $/ = "\0";
-
-	open my $fd, "-|", git_cmd(), "rev-list",
-		"--header",
-		@args,
-		("--max-count=" . $maxcount),
-		("--skip=" . $skip),
-		@extra_options,
-		$commit_id,
-		"--",
-		($filename ? ($filename) : ())
-		or die_error(500, "Open git-rev-list failed");
-	while (my $line = <$fd>) {
-		my %co = parse_commit_text($line);
-		push @cos, \%co;
-	}
-	close $fd;
-
-	return wantarray ? @cos : \@cos;
-}
-
-# parse line of git-diff-tree "raw" output
-sub parse_difftree_raw_line {
-	my $line = shift;
-	my %res;
-
-	# ':100644 100644 03b218260e99b78c6df0ed378e59ed9205ccc96d 3b93d5e7cc7f7dd4ebed13a5cc1a4ad976fc94d8 M	ls-files.c'
-	# ':100644 100644 7f9281985086971d3877aca27704f2aaf9c448ce bc190ebc71bbd923f2b728e505408f5e54bd073a M	rev-tree.c'
-	if ($line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/) {
-		$res{'from_mode'} = $1;
-		$res{'to_mode'} = $2;
-		$res{'from_id'} = $3;
-		$res{'to_id'} = $4;
-		$res{'status'} = $5;
-		$res{'similarity'} = $6;
-		if ($res{'status'} eq 'R' || $res{'status'} eq 'C') { # renamed or copied
-			($res{'from_file'}, $res{'to_file'}) = map { unquote($_) } split("\t", $7);
-		} else {
-			$res{'from_file'} = $res{'to_file'} = $res{'file'} = unquote($7);
-		}
-	}
-	# '::100755 100755 100755 60e79ca1b01bc8b057abe17ddab484699a7f5fdb 94067cc5f73388f33722d52ae02f44692bc07490 94067cc5f73388f33722d52ae02f44692bc07490 MR	git-gui/git-gui.sh'
-	# combined diff (for merge commit)
-	elsif ($line =~ s/^(::+)((?:[0-7]{6} )+)((?:[0-9a-fA-F]{40} )+)([a-zA-Z]+)\t(.*)$//) {
-		$res{'nparents'}  = length($1);
-		$res{'from_mode'} = [ split(' ', $2) ];
-		$res{'to_mode'} = pop @{$res{'from_mode'}};
-		$res{'from_id'} = [ split(' ', $3) ];
-		$res{'to_id'} = pop @{$res{'from_id'}};
-		$res{'status'} = [ split('', $4) ];
-		$res{'to_file'} = unquote($5);
-	}
-	# 'c512b523472485aef4fff9e57b229d9d243c967f'
-	elsif ($line =~ m/^([0-9a-fA-F]{40})$/) {
-		$res{'commit'} = $1;
-	}
-
-	return wantarray ? %res : \%res;
-}
-
-# wrapper: return parsed line of git-diff-tree "raw" output
-# (the argument might be raw line, or parsed info)
-sub parsed_difftree_line {
-	my $line_or_ref = shift;
-
-	if (ref($line_or_ref) eq "HASH") {
-		# pre-parsed (or generated by hand)
-		return $line_or_ref;
-	} else {
-		return parse_difftree_raw_line($line_or_ref);
-	}
-}
-
-# parse line of git-ls-tree output
-sub parse_ls_tree_line {
-	my $line = shift;
-	my %opts = @_;
-	my %res;
-
-	if ($opts{'-l'}) {
-		#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa   16717	panic.c'
-		$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40}) +(-|[0-9]+)\t(.+)$/s;
-
-		$res{'mode'} = $1;
-		$res{'type'} = $2;
-		$res{'hash'} = $3;
-		$res{'size'} = $4;
-		if ($opts{'-z'}) {
-			$res{'name'} = $5;
-		} else {
-			$res{'name'} = unquote($5);
-		}
-	} else {
-		#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
-		$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/s;
-
-		$res{'mode'} = $1;
-		$res{'type'} = $2;
-		$res{'hash'} = $3;
-		if ($opts{'-z'}) {
-			$res{'name'} = $4;
-		} else {
-			$res{'name'} = unquote($4);
-		}
-	}
-
-	return wantarray ? %res : \%res;
-}
-
-# generates _two_ hashes, references to which are passed as 2 and 3 argument
-sub parse_from_to_diffinfo {
-	my ($diffinfo, $from, $to, @parents) = @_;
-
-	if ($diffinfo->{'nparents'}) {
-		# combined diff
-		$from->{'file'} = [];
-		$from->{'href'} = [];
-		fill_from_file_info($diffinfo, @parents)
-			unless exists $diffinfo->{'from_file'};
-		for (my $i = 0; $i < $diffinfo->{'nparents'}; $i++) {
-			$from->{'file'}[$i] =
-				defined $diffinfo->{'from_file'}[$i] ?
-				        $diffinfo->{'from_file'}[$i] :
-				        $diffinfo->{'to_file'};
-			if ($diffinfo->{'status'}[$i] ne "A") { # not new (added) file
-				$from->{'href'}[$i] = href(action=>"blob",
-				                           hash_base=>$parents[$i],
-				                           hash=>$diffinfo->{'from_id'}[$i],
-				                           file_name=>$from->{'file'}[$i]);
-			} else {
-				$from->{'href'}[$i] = undef;
-			}
-		}
-	} else {
-		# ordinary (not combined) diff
-		$from->{'file'} = $diffinfo->{'from_file'};
-		if ($diffinfo->{'status'} ne "A") { # not new (added) file
-			$from->{'href'} = href(action=>"blob", hash_base=>$hash_parent,
-			                       hash=>$diffinfo->{'from_id'},
-			                       file_name=>$from->{'file'});
-		} else {
-			delete $from->{'href'};
-		}
-	}
-
-	$to->{'file'} = $diffinfo->{'to_file'};
-	if (!is_deleted($diffinfo)) { # file exists in result
-		$to->{'href'} = href(action=>"blob", hash_base=>$hash,
-		                     hash=>$diffinfo->{'to_id'},
-		                     file_name=>$to->{'file'});
-	} else {
-		delete $to->{'href'};
-	}
-}
-
 ## ......................................................................
 ## functions printing or outputting HTML: div
 
diff --git a/gitweb/lib/Gitweb/Parse.pm b/gitweb/lib/Gitweb/Parse.pm
new file mode 100644
index 0000000..6eeef2c
--- /dev/null
+++ b/gitweb/lib/Gitweb/Parse.pm
@@ -0,0 +1,414 @@
+#!/usr/bin/perl
+#
+# Gitweb::Parse -- gitweb's parse_* subs package
+#
+# This program is licensed under the GPLv2
+
+package Gitweb::Parse;
+
+use strict;
+use warnings;
+use Exporter qw(import);
+
+our @EXPORT = qw(parse_date parse_tag parse_commit_text parse_commit
+                 parse_commits parse_difftree_raw_line parsed_difftree_line
+                 parse_ls_tree_line parse_from_to_diffinfo unquote);
+
+use Gitweb::Git qw(git_cmd);
+use Gitweb::Request qw(@extra_options $hash $hash_parent);
+use Gitweb::Escape qw(to_utf8);
+use Gitweb::View qw(href chop_str age_string die_error);
+use Gitweb::Util qw(fill_from_file_info is_deleted);
+
+# git may return quoted and escaped filenames
+sub unquote {
+	my $str = shift;
+
+	sub unq {
+		my $seq = shift;
+		my %es = ( # character escape codes, aka escape sequences
+			't' => "\t",   # tab            (HT, TAB)
+			'n' => "\n",   # newline        (NL)
+			'r' => "\r",   # return         (CR)
+			'f' => "\f",   # form feed      (FF)
+			'b' => "\b",   # backspace      (BS)
+			'a' => "\a",   # alarm (bell)   (BEL)
+			'e' => "\e",   # escape         (ESC)
+			'v' => "\013", # vertical tab   (VT)
+		);
+
+		if ($seq =~ m/^[0-7]{1,3}$/) {
+			# octal char sequence
+			return chr(oct($seq));
+		} elsif (exists $es{$seq}) {
+			# C escape sequence, aka character escape code
+			return $es{$seq};
+		}
+		# quoted ordinary character
+		return $seq;
+	}
+
+	if ($str =~ m/^"(.*)"$/) {
+		# needs unquoting
+		$str = $1;
+		$str =~ s/\\([^0-7]|[0-7]{1,3})/unq($1)/eg;
+	}
+	return $str;
+}
+
+## ----------------------------------------------------------------------
+## parse to hash functions
+
+sub parse_date {
+	my $epoch = shift;
+	my $tz = shift || "-0000";
+
+	my %date;
+	my @months = ("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
+	my @days = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");
+	my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) = gmtime($epoch);
+	$date{'hour'} = $hour;
+	$date{'minute'} = $min;
+	$date{'mday'} = $mday;
+	$date{'day'} = $days[$wday];
+	$date{'month'} = $months[$mon];
+	$date{'rfc2822'}   = sprintf "%s, %d %s %4d %02d:%02d:%02d +0000",
+	                     $days[$wday], $mday, $months[$mon], 1900+$year, $hour ,$min, $sec;
+	$date{'mday-time'} = sprintf "%d %s %02d:%02d",
+	                     $mday, $months[$mon], $hour ,$min;
+	$date{'iso-8601'}  = sprintf "%04d-%02d-%02dT%02d:%02d:%02dZ",
+	                     1900+$year, 1+$mon, $mday, $hour ,$min, $sec;
+
+	$tz =~ m/^([+\-][0-9][0-9])([0-9][0-9])$/;
+	my $local = $epoch + ((int $1 + ($2/60)) * 3600);
+	($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) = gmtime($local);
+	$date{'hour_local'} = $hour;
+	$date{'minute_local'} = $min;
+	$date{'tz_local'} = $tz;
+	$date{'iso-tz'} = sprintf("%04d-%02d-%02d %02d:%02d:%02d %s",
+	                          1900+$year, $mon+1, $mday,
+	                          $hour, $min, $sec, $tz);
+	return %date;
+}
+
+sub parse_tag {
+	my $tag_id = shift;
+	my %tag;
+	my @comment;
+
+	open my $fd, "-|", git_cmd(), "cat-file", "tag", $tag_id or return;
+	$tag{'id'} = $tag_id;
+	while (my $line = <$fd>) {
+		chomp $line;
+		if ($line =~ m/^object ([0-9a-fA-F]{40})$/) {
+			$tag{'object'} = $1;
+		} elsif ($line =~ m/^type (.+)$/) {
+			$tag{'type'} = $1;
+		} elsif ($line =~ m/^tag (.+)$/) {
+			$tag{'name'} = $1;
+		} elsif ($line =~ m/^tagger (.*) ([0-9]+) (.*)$/) {
+			$tag{'author'} = $1;
+			$tag{'author_epoch'} = $2;
+			$tag{'author_tz'} = $3;
+			if ($tag{'author'} =~ m/^([^<]+) <([^>]*)>/) {
+				$tag{'author_name'}  = $1;
+				$tag{'author_email'} = $2;
+			} else {
+				$tag{'author_name'} = $tag{'author'};
+			}
+		} elsif ($line =~ m/--BEGIN/) {
+			push @comment, $line;
+			last;
+		} elsif ($line eq "") {
+			last;
+		}
+	}
+	push @comment, <$fd>;
+	$tag{'comment'} = \@comment;
+	close $fd or return;
+	if (!defined $tag{'name'}) {
+		return
+	};
+	return %tag
+}
+
+sub parse_commit_text {
+	my ($commit_text, $withparents) = @_;
+	my @commit_lines = split '\n', $commit_text;
+	my %co;
+
+	pop @commit_lines; # Remove '\0'
+
+	if (! @commit_lines) {
+		return;
+	}
+
+	my $header = shift @commit_lines;
+	if ($header !~ m/^[0-9a-fA-F]{40}/) {
+		return;
+	}
+	($co{'id'}, my @parents) = split ' ', $header;
+	while (my $line = shift @commit_lines) {
+		last if $line eq "\n";
+		if ($line =~ m/^tree ([0-9a-fA-F]{40})$/) {
+			$co{'tree'} = $1;
+		} elsif ((!defined $withparents) && ($line =~ m/^parent ([0-9a-fA-F]{40})$/)) {
+			push @parents, $1;
+		} elsif ($line =~ m/^author (.*) ([0-9]+) (.*)$/) {
+			$co{'author'} = to_utf8($1);
+			$co{'author_epoch'} = $2;
+			$co{'author_tz'} = $3;
+			if ($co{'author'} =~ m/^([^<]+) <([^>]*)>/) {
+				$co{'author_name'}  = $1;
+				$co{'author_email'} = $2;
+			} else {
+				$co{'author_name'} = $co{'author'};
+			}
+		} elsif ($line =~ m/^committer (.*) ([0-9]+) (.*)$/) {
+			$co{'committer'} = to_utf8($1);
+			$co{'committer_epoch'} = $2;
+			$co{'committer_tz'} = $3;
+			if ($co{'committer'} =~ m/^([^<]+) <([^>]*)>/) {
+				$co{'committer_name'}  = $1;
+				$co{'committer_email'} = $2;
+			} else {
+				$co{'committer_name'} = $co{'committer'};
+			}
+		}
+	}
+	if (!defined $co{'tree'}) {
+		return;
+	};
+	$co{'parents'} = \@parents;
+	$co{'parent'} = $parents[0];
+
+	foreach my $title (@commit_lines) {
+		$title =~ s/^    //;
+		if ($title ne "") {
+			$co{'title'} = chop_str($title, 80, 5);
+			# remove leading stuff of merges to make the interesting part visible
+			if (length($title) > 50) {
+				$title =~ s/^Automatic //;
+				$title =~ s/^merge (of|with) /Merge ... /i;
+				if (length($title) > 50) {
+					$title =~ s/(http|rsync):\/\///;
+				}
+				if (length($title) > 50) {
+					$title =~ s/(master|www|rsync)\.//;
+				}
+				if (length($title) > 50) {
+					$title =~ s/kernel.org:?//;
+				}
+				if (length($title) > 50) {
+					$title =~ s/\/pub\/scm//;
+				}
+			}
+			$co{'title_short'} = chop_str($title, 50, 5);
+			last;
+		}
+	}
+	if (! defined $co{'title'} || $co{'title'} eq "") {
+		$co{'title'} = $co{'title_short'} = '(no commit message)';
+	}
+	# remove added spaces
+	foreach my $line (@commit_lines) {
+		$line =~ s/^    //;
+	}
+	$co{'comment'} = \@commit_lines;
+
+	my $age = time - $co{'committer_epoch'};
+	$co{'age'} = $age;
+	$co{'age_string'} = age_string($age);
+	my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) = gmtime($co{'committer_epoch'});
+	if ($age > 60*60*24*7*2) {
+		$co{'age_string_date'} = sprintf "%4i-%02u-%02i", 1900 + $year, $mon+1, $mday;
+		$co{'age_string_age'} = $co{'age_string'};
+	} else {
+		$co{'age_string_date'} = $co{'age_string'};
+		$co{'age_string_age'} = sprintf "%4i-%02u-%02i", 1900 + $year, $mon+1, $mday;
+	}
+	return %co;
+}
+
+sub parse_commit {
+	my ($commit_id) = @_;
+	my %co;
+
+	local $/ = "\0";
+
+	open my $fd, "-|", git_cmd(), "rev-list",
+		"--parents",
+		"--header",
+		"--max-count=1",
+		$commit_id,
+		"--",
+		or die_error(500, "Open git-rev-list failed");
+	%co = parse_commit_text(<$fd>, 1);
+	close $fd;
+
+	return %co;
+}
+
+sub parse_commits {
+	my ($commit_id, $maxcount, $skip, $filename, @args) = @_;
+	my @cos;
+
+	$maxcount ||= 1;
+	$skip ||= 0;
+
+	local $/ = "\0";
+
+	open my $fd, "-|", git_cmd(), "rev-list",
+		"--header",
+		@args,
+		("--max-count=" . $maxcount),
+		("--skip=" . $skip),
+		@extra_options,
+		$commit_id,
+		"--",
+		($filename ? ($filename) : ())
+		or die_error(500, "Open git-rev-list failed");
+	while (my $line = <$fd>) {
+		my %co = parse_commit_text($line);
+		push @cos, \%co;
+	}
+	close $fd;
+
+	return wantarray ? @cos : \@cos;
+}
+
+# parse line of git-diff-tree "raw" output
+sub parse_difftree_raw_line {
+	my $line = shift;
+	my %res;
+
+	# ':100644 100644 03b218260e99b78c6df0ed378e59ed9205ccc96d 3b93d5e7cc7f7dd4ebed13a5cc1a4ad976fc94d8 M	ls-files.c'
+	# ':100644 100644 7f9281985086971d3877aca27704f2aaf9c448ce bc190ebc71bbd923f2b728e505408f5e54bd073a M	rev-tree.c'
+	if ($line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/) {
+		$res{'from_mode'} = $1;
+		$res{'to_mode'} = $2;
+		$res{'from_id'} = $3;
+		$res{'to_id'} = $4;
+		$res{'status'} = $5;
+		$res{'similarity'} = $6;
+		if ($res{'status'} eq 'R' || $res{'status'} eq 'C') { # renamed or copied
+			($res{'from_file'}, $res{'to_file'}) = map { unquote($_) } split("\t", $7);
+		} else {
+			$res{'from_file'} = $res{'to_file'} = $res{'file'} = unquote($7);
+		}
+	}
+	# '::100755 100755 100755 60e79ca1b01bc8b057abe17ddab484699a7f5fdb 94067cc5f73388f33722d52ae02f44692bc07490 94067cc5f73388f33722d52ae02f44692bc07490 MR	git-gui/git-gui.sh'
+	# combined diff (for merge commit)
+	elsif ($line =~ s/^(::+)((?:[0-7]{6} )+)((?:[0-9a-fA-F]{40} )+)([a-zA-Z]+)\t(.*)$//) {
+		$res{'nparents'}  = length($1);
+		$res{'from_mode'} = [ split(' ', $2) ];
+		$res{'to_mode'} = pop @{$res{'from_mode'}};
+		$res{'from_id'} = [ split(' ', $3) ];
+		$res{'to_id'} = pop @{$res{'from_id'}};
+		$res{'status'} = [ split('', $4) ];
+		$res{'to_file'} = unquote($5);
+	}
+	# 'c512b523472485aef4fff9e57b229d9d243c967f'
+	elsif ($line =~ m/^([0-9a-fA-F]{40})$/) {
+		$res{'commit'} = $1;
+	}
+
+	return wantarray ? %res : \%res;
+}
+
+# wrapper: return parsed line of git-diff-tree "raw" output
+# (the argument might be raw line, or parsed info)
+sub parsed_difftree_line {
+	my $line_or_ref = shift;
+
+	if (ref($line_or_ref) eq "HASH") {
+		# pre-parsed (or generated by hand)
+		return $line_or_ref;
+	} else {
+		return parse_difftree_raw_line($line_or_ref);
+	}
+}
+
+# parse line of git-ls-tree output
+sub parse_ls_tree_line {
+	my $line = shift;
+	my %opts = @_;
+	my %res;
+
+	if ($opts{'-l'}) {
+		#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa   16717	panic.c'
+		$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40}) +(-|[0-9]+)\t(.+)$/s;
+
+		$res{'mode'} = $1;
+		$res{'type'} = $2;
+		$res{'hash'} = $3;
+		$res{'size'} = $4;
+		if ($opts{'-z'}) {
+			$res{'name'} = $5;
+		} else {
+			$res{'name'} = unquote($5);
+		}
+	} else {
+		#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
+		$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/s;
+
+		$res{'mode'} = $1;
+		$res{'type'} = $2;
+		$res{'hash'} = $3;
+		if ($opts{'-z'}) {
+			$res{'name'} = $4;
+		} else {
+			$res{'name'} = unquote($4);
+		}
+	}
+
+	return wantarray ? %res : \%res;
+}
+
+# generates _two_ hashes, references to which are passed as 2 and 3 argument
+sub parse_from_to_diffinfo {
+	my ($diffinfo, $from, $to, @parents) = @_;
+
+	if ($diffinfo->{'nparents'}) {
+		# combined diff
+		$from->{'file'} = [];
+		$from->{'href'} = [];
+		fill_from_file_info($diffinfo, @parents)
+			unless exists $diffinfo->{'from_file'};
+		for (my $i = 0; $i < $diffinfo->{'nparents'}; $i++) {
+			$from->{'file'}[$i] =
+				defined $diffinfo->{'from_file'}[$i] ?
+				        $diffinfo->{'from_file'}[$i] :
+				        $diffinfo->{'to_file'};
+			if ($diffinfo->{'status'}[$i] ne "A") { # not new (added) file
+				$from->{'href'}[$i] = href(action=>"blob",
+				                           hash_base=>$parents[$i],
+				                           hash=>$diffinfo->{'from_id'}[$i],
+				                           file_name=>$from->{'file'}[$i]);
+			} else {
+				$from->{'href'}[$i] = undef;
+			}
+		}
+	} else {
+		# ordinary (not combined) diff
+		$from->{'file'} = $diffinfo->{'from_file'};
+		if ($diffinfo->{'status'} ne "A") { # not new (added) file
+			$from->{'href'} = href(action=>"blob", hash_base=>$hash_parent,
+			                       hash=>$diffinfo->{'from_id'},
+			                       file_name=>$from->{'file'});
+		} else {
+			delete $from->{'href'};
+		}
+	}
+
+	$to->{'file'} = $diffinfo->{'to_file'};
+	if (!is_deleted($diffinfo)) { # file exists in result
+		$to->{'href'} = href(action=>"blob", hash_base=>$hash,
+		                     hash=>$diffinfo->{'to_id'},
+		                     file_name=>$to->{'file'});
+	} else {
+		delete $to->{'href'};
+	}
+}
+
+1;
-- 
1.7.1.455.g8f441
