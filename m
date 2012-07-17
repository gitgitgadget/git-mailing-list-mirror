From: Michael G Schwern <schwern@pobox.com>
Subject: Extract Git classes from git-svn (3/10) (was Re: Fix git-svn tests
 for SVN 1.7.5.)
Date: Tue, 17 Jul 2012 16:13:12 -0700
Message-ID: <5005F188.1090203@pobox.com>
References: <5004B772.3090806@pobox.com> <20120717174446.GA14244@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 01:13:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrGxF-0002d4-2v
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 01:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755051Ab2GQXNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 19:13:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46539 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708Ab2GQXNO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 19:13:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDD918469;
	Tue, 17 Jul 2012 19:13:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=ZcyT/lUMxqGE
	OS5kBvtuPCMROvg=; b=Cxvl9X8EcgIMYC2eXkCUzVACfMDo8G/uBKcbU/QQbAa1
	iioRXKWvl9yIcPhUOb8BBsRgc+NtJ82BDUEbKeh3o+ZFIEfvIWYNqYJHr84GO9Ls
	4KTNpUYPJYH2HsCf0uizM0Ui1PAyAZPdbgL49OyD52bwgDdKxJFWQ90kDjvvym0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mkGmpJ
	2qEgeWYA3hryV7lYNgBZcwyLPvoWuqAdIbwQdyMjgXxp2eZn+282nQYhxzWBLf9a
	6N2XDbKJYKDVKXo3/u+FcN/u67MX0gm8XA39iMVyzopHXR9y1VUgxLO3m4RLdHCd
	FjK7MswDiuANxxJ7EeG0T0d5SY0jfjUrQelDQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA9E68468;
	Tue, 17 Jul 2012 19:13:13 -0400 (EDT)
Received: from windhund.local (unknown [67.23.204.5]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7C4E8467; Tue, 17 Jul
 2012 19:13:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:13.0)
 Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <20120717174446.GA14244@burratino>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: FB83CD9A-D064-11E1-918A-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201628>

>From 5f0b609e9b0a70c86c46b48f0b180c96c3355a14 Mon Sep 17 00:00:00 2001
From: "Michael G. Schwern" <schwern@pobox.com>
Date: Tue, 17 Jul 2012 15:40:03 -0700
Subject: [PATCH 04/11] Extract Git::SVN::Log from git-svn.

This is a straight cut & paste.  Next commit will make it work.  This will
make it easier to see the differences in Git::SVN::Log.
---
 git-svn.perl        | 387 ---------------------------------------------------
 perl/Git/SVN/Log.pm | 388 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 388 insertions(+), 387 deletions(-)
 create mode 100644 perl/Git/SVN/Log.pm

diff --git a/git-svn.perl b/git-svn.perl
index 8a02d1c..5e6e3b5 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2041,393 +2041,6 @@ sub gc_directory {
 }


-package Git::SVN::Log;
-use strict;
-use warnings;
-use Git::SVN::Utils qw(fatal);
-use POSIX qw/strftime/;
-use constant commit_log_separator => ('-' x 72) . "\n";
-use vars qw/$TZ $limit $color $pager $non_recursive $verbose $oneline
-            %rusers $show_commit $incremental/;
-my $l_fmt;
-
-sub cmt_showable {
-	my ($c) = @_;
-	return 1 if defined $c->{r};
-
-	# big commit message got truncated by the 16k pretty buffer in rev-list
-	if ($c->{l} && $c->{l}->[-1] eq "...\n" &&
-				$c->{a_raw} =~ /\@([a-f\d\-]+)>$/) {
-		@{$c->{l}} = ();
-		my @log = command(qw/cat-file commit/, $c->{c});
-
-		# shift off the headers
-		shift @log while ($log[0] ne '');
-		shift @log;
-
-		# TODO: make $c->{l} not have a trailing newline in the future
-		@{$c->{l}} = map { "$_\n" } grep !/^git-svn-id: /, @log;
-
-		(undef, $c->{r}, undef) = ::extract_metadata(
-				(grep(/^git-svn-id: /, @log))[-1]);
-	}
-	return defined $c->{r};
-}
-
-sub log_use_color {
-	return $color || Git->repository->get_colorbool('color.diff');
-}
-
-sub git_svn_log_cmd {
-	my ($r_min, $r_max, @args) = @_;
-	my $head = 'HEAD';
-	my (@files, @log_opts);
-	foreach my $x (@args) {
-		if ($x eq '--' || @files) {
-			push @files, $x;
-		} else {
-			if (::verify_ref("$x^0")) {
-				$head = $x;
-			} else {
-				push @log_opts, $x;
-			}
-		}
-	}
-
-	my ($url, $rev, $uuid, $gs) = ::working_head_info($head);
-	$gs ||= Git::SVN->_new;
-	my @cmd = (qw/log --abbrev-commit --pretty=raw --default/,
-	           $gs->refname);
-	push @cmd, '-r' unless $non_recursive;
-	push @cmd, qw/--raw --name-status/ if $verbose;
-	push @cmd, '--color' if log_use_color();
-	push @cmd, @log_opts;
-	if (defined $r_max && $r_max == $r_min) {
-		push @cmd, '--max-count=1';
-		if (my $c = $gs->rev_map_get($r_max)) {
-			push @cmd, $c;
-		}
-	} elsif (defined $r_max) {
-		if ($r_max < $r_min) {
-			($r_min, $r_max) = ($r_max, $r_min);
-		}
-		my (undef, $c_max) = $gs->find_rev_before($r_max, 1, $r_min);
-		my (undef, $c_min) = $gs->find_rev_after($r_min, 1, $r_max);
-		# If there are no commits in the range, both $c_max and $c_min
-		# will be undefined.  If there is at least 1 commit in the
-		# range, both will be defined.
-		return () if !defined $c_min || !defined $c_max;
-		if ($c_min eq $c_max) {
-			push @cmd, '--max-count=1', $c_min;
-		} else {
-			push @cmd, '--boundary', "$c_min..$c_max";
-		}
-	}
-	return (@cmd, @files);
-}
-
-# adapted from pager.c
-sub config_pager {
-	if (! -t *STDOUT) {
-		$ENV{GIT_PAGER_IN_USE} = 'false';
-		$pager = undef;
-		return;
-	}
-	chomp($pager = command_oneline(qw(var GIT_PAGER)));
-	if ($pager eq 'cat') {
-		$pager = undef;
-	}
-	$ENV{GIT_PAGER_IN_USE} = defined($pager);
-}
-
-sub run_pager {
-	return unless defined $pager;
-	pipe my ($rfd, $wfd) or return;
-	defined(my $pid = fork) or fatal "Can't fork: $!";
-	if (!$pid) {
-		open STDOUT, '>&', $wfd or
-		                     fatal "Can't redirect to stdout: $!";
-		return;
-	}
-	open STDIN, '<&', $rfd or fatal "Can't redirect stdin: $!";
-	$ENV{LESS} ||= 'FRSX';
-	exec $pager or fatal "Can't run pager: $! ($pager)";
-}
-
-sub format_svn_date {
-	my $t = shift || time;
-	my $gmoff = Git::SVN::get_tz($t);
-	return strftime("%Y-%m-%d %H:%M:%S $gmoff (%a, %d %b %Y)", localtime($t));
-}
-
-sub parse_git_date {
-	my ($t, $tz) = @_;
-	# Date::Parse isn't in the standard Perl distro :(
-	if ($tz =~ s/^\+//) {
-		$t += tz_to_s_offset($tz);
-	} elsif ($tz =~ s/^\-//) {
-		$t -= tz_to_s_offset($tz);
-	}
-	return $t;
-}
-
-sub set_local_timezone {
-	if (defined $TZ) {
-		$ENV{TZ} = $TZ;
-	} else {
-		delete $ENV{TZ};
-	}
-}
-
-sub tz_to_s_offset {
-	my ($tz) = @_;
-	$tz =~ s/(\d\d)$//;
-	return ($1 * 60) + ($tz * 3600);
-}
-
-sub get_author_info {
-	my ($dest, $author, $t, $tz) = @_;
-	$author =~ s/(?:^\s*|\s*$)//g;
-	$dest->{a_raw} = $author;
-	my $au;
-	if ($::_authors) {
-		$au = $rusers{$author} || undef;
-	}
-	if (!$au) {
-		($au) = ($author =~ /<([^>]+)\@[^>]+>$/);
-	}
-	$dest->{t} = $t;
-	$dest->{tz} = $tz;
-	$dest->{a} = $au;
-	$dest->{t_utc} = parse_git_date($t, $tz);
-}
-
-sub process_commit {
-	my ($c, $r_min, $r_max, $defer) = @_;
-	if (defined $r_min && defined $r_max) {
-		if ($r_min == $c->{r} && $r_min == $r_max) {
-			show_commit($c);
-			return 0;
-		}
-		return 1 if $r_min == $r_max;
-		if ($r_min < $r_max) {
-			# we need to reverse the print order
-			return 0 if (defined $limit && --$limit < 0);
-			push @$defer, $c;
-			return 1;
-		}
-		if ($r_min != $r_max) {
-			return 1 if ($r_min < $c->{r});
-			return 1 if ($r_max > $c->{r});
-		}
-	}
-	return 0 if (defined $limit && --$limit < 0);
-	show_commit($c);
-	return 1;
-}
-
-sub show_commit {
-	my $c = shift;
-	if ($oneline) {
-		my $x = "\n";
-		if (my $l = $c->{l}) {
-			while ($l->[0] =~ /^\s*$/) { shift @$l }
-			$x = $l->[0];
-		}
-		$l_fmt ||= 'A' . length($c->{r});
-		print 'r',pack($l_fmt, $c->{r}),' | ';
-		print "$c->{c} | " if $show_commit;
-		print $x;
-	} else {
-		show_commit_normal($c);
-	}
-}
-
-sub show_commit_changed_paths {
-	my ($c) = @_;
-	return unless $c->{changed};
-	print "Changed paths:\n", @{$c->{changed}};
-}
-
-sub show_commit_normal {
-	my ($c) = @_;
-	print commit_log_separator, "r$c->{r} | ";
-	print "$c->{c} | " if $show_commit;
-	print "$c->{a} | ", format_svn_date($c->{t_utc}), ' | ';
-	my $nr_line = 0;
-
-	if (my $l = $c->{l}) {
-		while ($l->[$#$l] eq "\n" && $#$l > 0
-		                          && $l->[($#$l - 1)] eq "\n") {
-			pop @$l;
-		}
-		$nr_line = scalar @$l;
-		if (!$nr_line) {
-			print "1 line\n\n\n";
-		} else {
-			if ($nr_line == 1) {
-				$nr_line = '1 line';
-			} else {
-				$nr_line .= ' lines';
-			}
-			print $nr_line, "\n";
-			show_commit_changed_paths($c);
-			print "\n";
-			print $_ foreach @$l;
-		}
-	} else {
-		print "1 line\n";
-		show_commit_changed_paths($c);
-		print "\n";
-
-	}
-	foreach my $x (qw/raw stat diff/) {
-		if ($c->{$x}) {
-			print "\n";
-			print $_ foreach @{$c->{$x}}
-		}
-	}
-}
-
-sub cmd_show_log {
-	my (@args) = @_;
-	my ($r_min, $r_max);
-	my $r_last = -1; # prevent dupes
-	set_local_timezone();
-	if (defined $::_revision) {
-		if ($::_revision =~ /^(\d+):(\d+)$/) {
-			($r_min, $r_max) = ($1, $2);
-		} elsif ($::_revision =~ /^\d+$/) {
-			$r_min = $r_max = $::_revision;
-		} else {
-			fatal "-r$::_revision is not supported, use ",
-				"standard 'git log' arguments instead";
-		}
-	}
-
-	config_pager();
-	@args = git_svn_log_cmd($r_min, $r_max, @args);
-	if (!@args) {
-		print commit_log_separator unless $incremental || $oneline;
-		return;
-	}
-	my $log = command_output_pipe(@args);
-	run_pager();
-	my (@k, $c, $d, $stat);
-	my $esc_color = qr/(?:\033\[(?:(?:\d+;)*\d*)?m)*/;
-	while (<$log>) {
-		if (/^${esc_color}commit (?:- )?($::sha1_short)/o) {
-			my $cmt = $1;
-			if ($c && cmt_showable($c) && $c->{r} != $r_last) {
-				$r_last = $c->{r};
-				process_commit($c, $r_min, $r_max, \@k) or
-								goto out;
-			}
-			$d = undef;
-			$c = { c => $cmt };
-		} elsif (/^${esc_color}author (.+) (\d+) ([\-\+]?\d+)$/o) {
-			get_author_info($c, $1, $2, $3);
-		} elsif (/^${esc_color}(?:tree|parent|committer) /o) {
-			# ignore
-		} elsif (/^${esc_color}:\d{6} \d{6} $::sha1_short/o) {
-			push @{$c->{raw}}, $_;
-		} elsif (/^${esc_color}[ACRMDT]\t/) {
-			# we could add $SVN->{svn_path} here, but that requires
-			# remote access at the moment (repo_path_split)...
-			s#^(${esc_color})([ACRMDT])\t#$1   $2 #o;
-			push @{$c->{changed}}, $_;
-		} elsif (/^${esc_color}diff /o) {
-			$d = 1;
-			push @{$c->{diff}}, $_;
-		} elsif ($d) {
-			push @{$c->{diff}}, $_;
-		} elsif (/^\ .+\ \|\s*\d+\ $esc_color[\+\-]*
-		          $esc_color*[\+\-]*$esc_color$/x) {
-			$stat = 1;
-			push @{$c->{stat}}, $_;
-		} elsif ($stat && /^ \d+ files changed, \d+ insertions/) {
-			push @{$c->{stat}}, $_;
-			$stat = undef;
-		} elsif (/^${esc_color}    (git-svn-id:.+)$/o) {
-			($c->{url}, $c->{r}, undef) = ::extract_metadata($1);
-		} elsif (s/^${esc_color}    //o) {
-			push @{$c->{l}}, $_;
-		}
-	}
-	if ($c && defined $c->{r} && $c->{r} != $r_last) {
-		$r_last = $c->{r};
-		process_commit($c, $r_min, $r_max, \@k);
-	}
-	if (@k) {
-		($r_min, $r_max) = ($r_max, $r_min);
-		process_commit($_, $r_min, $r_max) foreach reverse @k;
-	}
-out:
-	close $log;
-	print commit_log_separator unless $incremental || $oneline;
-}
-
-sub cmd_blame {
-	my $path = pop;
-
-	config_pager();
-	run_pager();
-
-	my ($fh, $ctx, $rev);
-
-	if ($_git_format) {
-		($fh, $ctx) = command_output_pipe('blame', @_, $path);
-		while (my $line = <$fh>) {
-			if ($line =~ /^\^?([[:xdigit:]]+)\s/) {
-				# Uncommitted edits show up as a rev ID of
-				# all zeros, which we can't look up with
-				# cmt_metadata
-				if ($1 !~ /^0+$/) {
-					(undef, $rev, undef) =
-						::cmt_metadata($1);
-					$rev = '0' if (!$rev);
-				} else {
-					$rev = '0';
-				}
-				$rev = sprintf('%-10s', $rev);
-				$line =~ s/^\^?[[:xdigit:]]+(\s)/$rev$1/;
-			}
-			print $line;
-		}
-	} else {
-		($fh, $ctx) = command_output_pipe('blame', '-p', @_, 'HEAD',
-						  '--', $path);
-		my ($sha1);
-		my %authors;
-		my @buffer;
-		my %dsha; #distinct sha keys
-
-		while (my $line = <$fh>) {
-			push @buffer, $line;
-			if ($line =~ /^([[:xdigit:]]{40})\s\d+\s\d+/) {
-				$dsha{$1} = 1;
-			}
-		}
-
-		my $s2r = ::cmt_sha2rev_batch([keys %dsha]);
-
-		foreach my $line (@buffer) {
-			if ($line =~ /^([[:xdigit:]]{40})\s\d+\s\d+/) {
-				$rev = $s2r->{$1};
-				$rev = '0' if (!$rev)
-			}
-			elsif ($line =~ /^author (.*)/) {
-				$authors{$rev} = $1;
-				$authors{$rev} =~ s/\s/_/g;
-			}
-			elsif ($line =~ /^\t(.*)$/) {
-				printf("%6s %10s %s\n", $rev, $authors{$rev}, $1);
-			}
-		}
-	}
-	command_close_pipe($fh, $ctx);
-}
-
 package Git::SVN::Migration;
 # these version numbers do NOT correspond to actual version numbers
 # of git nor git-svn.  They are just relative.
diff --git a/perl/Git/SVN/Log.pm b/perl/Git/SVN/Log.pm
new file mode 100644
index 0000000..bbec3b0
--- /dev/null
+++ b/perl/Git/SVN/Log.pm
@@ -0,0 +1,388 @@
+package Git::SVN::Log;
+use strict;
+use warnings;
+use Git::SVN::Utils qw(fatal);
+use POSIX qw/strftime/;
+use constant commit_log_separator => ('-' x 72) . "\n";
+use vars qw/$TZ $limit $color $pager $non_recursive $verbose $oneline
+            %rusers $show_commit $incremental/;
+my $l_fmt;
+
+sub cmt_showable {
+	my ($c) = @_;
+	return 1 if defined $c->{r};
+
+	# big commit message got truncated by the 16k pretty buffer in rev-list
+	if ($c->{l} && $c->{l}->[-1] eq "...\n" &&
+				$c->{a_raw} =~ /\@([a-f\d\-]+)>$/) {
+		@{$c->{l}} = ();
+		my @log = command(qw/cat-file commit/, $c->{c});
+
+		# shift off the headers
+		shift @log while ($log[0] ne '');
+		shift @log;
+
+		# TODO: make $c->{l} not have a trailing newline in the future
+		@{$c->{l}} = map { "$_\n" } grep !/^git-svn-id: /, @log;
+
+		(undef, $c->{r}, undef) = ::extract_metadata(
+				(grep(/^git-svn-id: /, @log))[-1]);
+	}
+	return defined $c->{r};
+}
+
+sub log_use_color {
+	return $color || Git->repository->get_colorbool('color.diff');
+}
+
+sub git_svn_log_cmd {
+	my ($r_min, $r_max, @args) = @_;
+	my $head = 'HEAD';
+	my (@files, @log_opts);
+	foreach my $x (@args) {
+		if ($x eq '--' || @files) {
+			push @files, $x;
+		} else {
+			if (::verify_ref("$x^0")) {
+				$head = $x;
+			} else {
+				push @log_opts, $x;
+			}
+		}
+	}
+
+	my ($url, $rev, $uuid, $gs) = ::working_head_info($head);
+	$gs ||= Git::SVN->_new;
+	my @cmd = (qw/log --abbrev-commit --pretty=raw --default/,
+	           $gs->refname);
+	push @cmd, '-r' unless $non_recursive;
+	push @cmd, qw/--raw --name-status/ if $verbose;
+	push @cmd, '--color' if log_use_color();
+	push @cmd, @log_opts;
+	if (defined $r_max && $r_max == $r_min) {
+		push @cmd, '--max-count=1';
+		if (my $c = $gs->rev_map_get($r_max)) {
+			push @cmd, $c;
+		}
+	} elsif (defined $r_max) {
+		if ($r_max < $r_min) {
+			($r_min, $r_max) = ($r_max, $r_min);
+		}
+		my (undef, $c_max) = $gs->find_rev_before($r_max, 1, $r_min);
+		my (undef, $c_min) = $gs->find_rev_after($r_min, 1, $r_max);
+		# If there are no commits in the range, both $c_max and $c_min
+		# will be undefined.  If there is at least 1 commit in the
+		# range, both will be defined.
+		return () if !defined $c_min || !defined $c_max;
+		if ($c_min eq $c_max) {
+			push @cmd, '--max-count=1', $c_min;
+		} else {
+			push @cmd, '--boundary', "$c_min..$c_max";
+		}
+	}
+	return (@cmd, @files);
+}
+
+# adapted from pager.c
+sub config_pager {
+	if (! -t *STDOUT) {
+		$ENV{GIT_PAGER_IN_USE} = 'false';
+		$pager = undef;
+		return;
+	}
+	chomp($pager = command_oneline(qw(var GIT_PAGER)));
+	if ($pager eq 'cat') {
+		$pager = undef;
+	}
+	$ENV{GIT_PAGER_IN_USE} = defined($pager);
+}
+
+sub run_pager {
+	return unless defined $pager;
+	pipe my ($rfd, $wfd) or return;
+	defined(my $pid = fork) or fatal "Can't fork: $!";
+	if (!$pid) {
+		open STDOUT, '>&', $wfd or
+		                     fatal "Can't redirect to stdout: $!";
+		return;
+	}
+	open STDIN, '<&', $rfd or fatal "Can't redirect stdin: $!";
+	$ENV{LESS} ||= 'FRSX';
+	exec $pager or fatal "Can't run pager: $! ($pager)";
+}
+
+sub format_svn_date {
+	my $t = shift || time;
+	my $gmoff = Git::SVN::get_tz($t);
+	return strftime("%Y-%m-%d %H:%M:%S $gmoff (%a, %d %b %Y)", localtime($t));
+}
+
+sub parse_git_date {
+	my ($t, $tz) = @_;
+	# Date::Parse isn't in the standard Perl distro :(
+	if ($tz =~ s/^\+//) {
+		$t += tz_to_s_offset($tz);
+	} elsif ($tz =~ s/^\-//) {
+		$t -= tz_to_s_offset($tz);
+	}
+	return $t;
+}
+
+sub set_local_timezone {
+	if (defined $TZ) {
+		$ENV{TZ} = $TZ;
+	} else {
+		delete $ENV{TZ};
+	}
+}
+
+sub tz_to_s_offset {
+	my ($tz) = @_;
+	$tz =~ s/(\d\d)$//;
+	return ($1 * 60) + ($tz * 3600);
+}
+
+sub get_author_info {
+	my ($dest, $author, $t, $tz) = @_;
+	$author =~ s/(?:^\s*|\s*$)//g;
+	$dest->{a_raw} = $author;
+	my $au;
+	if ($::_authors) {
+		$au = $rusers{$author} || undef;
+	}
+	if (!$au) {
+		($au) = ($author =~ /<([^>]+)\@[^>]+>$/);
+	}
+	$dest->{t} = $t;
+	$dest->{tz} = $tz;
+	$dest->{a} = $au;
+	$dest->{t_utc} = parse_git_date($t, $tz);
+}
+
+sub process_commit {
+	my ($c, $r_min, $r_max, $defer) = @_;
+	if (defined $r_min && defined $r_max) {
+		if ($r_min == $c->{r} && $r_min == $r_max) {
+			show_commit($c);
+			return 0;
+		}
+		return 1 if $r_min == $r_max;
+		if ($r_min < $r_max) {
+			# we need to reverse the print order
+			return 0 if (defined $limit && --$limit < 0);
+			push @$defer, $c;
+			return 1;
+		}
+		if ($r_min != $r_max) {
+			return 1 if ($r_min < $c->{r});
+			return 1 if ($r_max > $c->{r});
+		}
+	}
+	return 0 if (defined $limit && --$limit < 0);
+	show_commit($c);
+	return 1;
+}
+
+sub show_commit {
+	my $c = shift;
+	if ($oneline) {
+		my $x = "\n";
+		if (my $l = $c->{l}) {
+			while ($l->[0] =~ /^\s*$/) { shift @$l }
+			$x = $l->[0];
+		}
+		$l_fmt ||= 'A' . length($c->{r});
+		print 'r',pack($l_fmt, $c->{r}),' | ';
+		print "$c->{c} | " if $show_commit;
+		print $x;
+	} else {
+		show_commit_normal($c);
+	}
+}
+
+sub show_commit_changed_paths {
+	my ($c) = @_;
+	return unless $c->{changed};
+	print "Changed paths:\n", @{$c->{changed}};
+}
+
+sub show_commit_normal {
+	my ($c) = @_;
+	print commit_log_separator, "r$c->{r} | ";
+	print "$c->{c} | " if $show_commit;
+	print "$c->{a} | ", format_svn_date($c->{t_utc}), ' | ';
+	my $nr_line = 0;
+
+	if (my $l = $c->{l}) {
+		while ($l->[$#$l] eq "\n" && $#$l > 0
+		                          && $l->[($#$l - 1)] eq "\n") {
+			pop @$l;
+		}
+		$nr_line = scalar @$l;
+		if (!$nr_line) {
+			print "1 line\n\n\n";
+		} else {
+			if ($nr_line == 1) {
+				$nr_line = '1 line';
+			} else {
+				$nr_line .= ' lines';
+			}
+			print $nr_line, "\n";
+			show_commit_changed_paths($c);
+			print "\n";
+			print $_ foreach @$l;
+		}
+	} else {
+		print "1 line\n";
+		show_commit_changed_paths($c);
+		print "\n";
+
+	}
+	foreach my $x (qw/raw stat diff/) {
+		if ($c->{$x}) {
+			print "\n";
+			print $_ foreach @{$c->{$x}}
+		}
+	}
+}
+
+sub cmd_show_log {
+	my (@args) = @_;
+	my ($r_min, $r_max);
+	my $r_last = -1; # prevent dupes
+	set_local_timezone();
+	if (defined $::_revision) {
+		if ($::_revision =~ /^(\d+):(\d+)$/) {
+			($r_min, $r_max) = ($1, $2);
+		} elsif ($::_revision =~ /^\d+$/) {
+			$r_min = $r_max = $::_revision;
+		} else {
+			fatal "-r$::_revision is not supported, use ",
+				"standard 'git log' arguments instead";
+		}
+	}
+
+	config_pager();
+	@args = git_svn_log_cmd($r_min, $r_max, @args);
+	if (!@args) {
+		print commit_log_separator unless $incremental || $oneline;
+		return;
+	}
+	my $log = command_output_pipe(@args);
+	run_pager();
+	my (@k, $c, $d, $stat);
+	my $esc_color = qr/(?:\033\[(?:(?:\d+;)*\d*)?m)*/;
+	while (<$log>) {
+		if (/^${esc_color}commit (?:- )?($::sha1_short)/o) {
+			my $cmt = $1;
+			if ($c && cmt_showable($c) && $c->{r} != $r_last) {
+				$r_last = $c->{r};
+				process_commit($c, $r_min, $r_max, \@k) or
+								goto out;
+			}
+			$d = undef;
+			$c = { c => $cmt };
+		} elsif (/^${esc_color}author (.+) (\d+) ([\-\+]?\d+)$/o) {
+			get_author_info($c, $1, $2, $3);
+		} elsif (/^${esc_color}(?:tree|parent|committer) /o) {
+			# ignore
+		} elsif (/^${esc_color}:\d{6} \d{6} $::sha1_short/o) {
+			push @{$c->{raw}}, $_;
+		} elsif (/^${esc_color}[ACRMDT]\t/) {
+			# we could add $SVN->{svn_path} here, but that requires
+			# remote access at the moment (repo_path_split)...
+			s#^(${esc_color})([ACRMDT])\t#$1   $2 #o;
+			push @{$c->{changed}}, $_;
+		} elsif (/^${esc_color}diff /o) {
+			$d = 1;
+			push @{$c->{diff}}, $_;
+		} elsif ($d) {
+			push @{$c->{diff}}, $_;
+		} elsif (/^\ .+\ \|\s*\d+\ $esc_color[\+\-]*
+		          $esc_color*[\+\-]*$esc_color$/x) {
+			$stat = 1;
+			push @{$c->{stat}}, $_;
+		} elsif ($stat && /^ \d+ files changed, \d+ insertions/) {
+			push @{$c->{stat}}, $_;
+			$stat = undef;
+		} elsif (/^${esc_color}    (git-svn-id:.+)$/o) {
+			($c->{url}, $c->{r}, undef) = ::extract_metadata($1);
+		} elsif (s/^${esc_color}    //o) {
+			push @{$c->{l}}, $_;
+		}
+	}
+	if ($c && defined $c->{r} && $c->{r} != $r_last) {
+		$r_last = $c->{r};
+		process_commit($c, $r_min, $r_max, \@k);
+	}
+	if (@k) {
+		($r_min, $r_max) = ($r_max, $r_min);
+		process_commit($_, $r_min, $r_max) foreach reverse @k;
+	}
+out:
+	close $log;
+	print commit_log_separator unless $incremental || $oneline;
+}
+
+sub cmd_blame {
+	my $path = pop;
+
+	config_pager();
+	run_pager();
+
+	my ($fh, $ctx, $rev);
+
+	if ($_git_format) {
+		($fh, $ctx) = command_output_pipe('blame', @_, $path);
+		while (my $line = <$fh>) {
+			if ($line =~ /^\^?([[:xdigit:]]+)\s/) {
+				# Uncommitted edits show up as a rev ID of
+				# all zeros, which we can't look up with
+				# cmt_metadata
+				if ($1 !~ /^0+$/) {
+					(undef, $rev, undef) =
+						::cmt_metadata($1);
+					$rev = '0' if (!$rev);
+				} else {
+					$rev = '0';
+				}
+				$rev = sprintf('%-10s', $rev);
+				$line =~ s/^\^?[[:xdigit:]]+(\s)/$rev$1/;
+			}
+			print $line;
+		}
+	} else {
+		($fh, $ctx) = command_output_pipe('blame', '-p', @_, 'HEAD',
+						  '--', $path);
+		my ($sha1);
+		my %authors;
+		my @buffer;
+		my %dsha; #distinct sha keys
+
+		while (my $line = <$fh>) {
+			push @buffer, $line;
+			if ($line =~ /^([[:xdigit:]]{40})\s\d+\s\d+/) {
+				$dsha{$1} = 1;
+			}
+		}
+
+		my $s2r = ::cmt_sha2rev_batch([keys %dsha]);
+
+		foreach my $line (@buffer) {
+			if ($line =~ /^([[:xdigit:]]{40})\s\d+\s\d+/) {
+				$rev = $s2r->{$1};
+				$rev = '0' if (!$rev)
+			}
+			elsif ($line =~ /^author (.*)/) {
+				$authors{$rev} = $1;
+				$authors{$rev} =~ s/\s/_/g;
+			}
+			elsif ($line =~ /^\t(.*)$/) {
+				printf("%6s %10s %s\n", $rev, $authors{$rev}, $1);
+			}
+		}
+	}
+	command_close_pipe($fh, $ctx);
+}
+
+1;
-- 
1.7.11.1
