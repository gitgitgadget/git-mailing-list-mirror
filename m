Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 232241F597
	for <e@80x24.org>; Thu, 26 Jul 2018 10:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbeGZLit (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 07:38:49 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:13011 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbeGZLis (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 07:38:48 -0400
Received: from lindisfarne.localdomain ([92.22.19.104])
        by smtp.talktalk.net with SMTP
        id idPhfHPXuoI6LidPmfsjbV; Thu, 26 Jul 2018 11:22:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1532600555;
        bh=B3SCemmWv5Axyh2LZ/IIW4+YedjmQ7y4nbWg0glx+WQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=hvfuYk17ndfACnJaXpO5GCfMQOHpq9kLa/kzfaIKQFiBOVslDrZfBNCUPoxkGzXLQ
         rEriYw0rXM4Zd/yxjTucezh/0hpx6Xow8mYNUnC8CgjJVcJ+40LrtNIa0mQAvkWCOt
         qTE986Wf4pYr9dq12wp52wG+8zuAepPDOH/oYaoM=
X-Originating-IP: [92.22.19.104]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=f/8ZdrXn5sPnqdHA06GUHw==:117
 a=f/8ZdrXn5sPnqdHA06GUHw==:17 a=evINK-nbAAAA:8 a=1W4N-_JYX9s5umQv8zsA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=a98qYcV3JrzpHg4G:21 a=YJhMPCpDgCEJ4KJW:21
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 1/4] add -p: select individual hunk lines
Date:   Thu, 26 Jul 2018 11:22:24 +0100
Message-Id: <20180726102227.997-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726102227.997-1-phillip.wood@talktalk.net>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180726102227.997-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfJa7AviMq9zSC+2X0IBrx0/g9jAyeNKlpNWdpgLUYo3Mkn0SoeBNcvEb4GNgvZC71s7wsp9FHf2kIiG/JjWEUGVPx+qxZ/KoPnp1fm2gBN62uXM1TWTp
 DV+80FAicO1b0V2Gwc7uimWGqsT66U1Hq40V07cAun6eM7dsTtyN9qG7e+F2TTrjFONLK5QDsBd9otfIv+InmliNTL5A9dujhHLdJ1DaJvT59Iuo6hqs2y2L
 74QEiL93jlNL+hFi3CKM4UbR3ZdwuoAOOYLKMY3lLWNYq9ZTzRqQ04sTa2fm2Pk/zzR0fKf74ZLjHEMMul81r601IRsLR1hWHHDZmpazkao=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When I end up editing hunks it is almost always because I want to
stage a subset of the lines in the hunk. Doing this by editing the
hunk is inconvenient and error prone (especially so if the patch is
going to be reversed before being applied). Instead offer an option
for add -p to stage individual lines. When the user presses 'l' the
hunk is redrawn with labels by the insertions and deletions and they
are prompted to enter a list of the lines they wish to stage. Ranges
of lines may be specified using 'a-b' where 'b' may be omitted to mean
all lines from 'a' to the end of the hunk. Modified lines are not
handled correctly, that will be fixed in the next commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-add.txt  |   8 ++
 git-add--interactive.perl  | 181 +++++++++++++++++++++++++++++++++++++
 t/t3701-add-interactive.sh | 103 +++++++++++++++++++++
 3 files changed, 292 insertions(+)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index d50fa339dc..965e192a09 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -332,10 +332,18 @@ patch::
        J - leave this hunk undecided, see next hunk
        k - leave this hunk undecided, see previous undecided hunk
        K - leave this hunk undecided, see previous hunk
+       l - select hunk lines to use
        s - split the current hunk into smaller hunks
        e - manually edit the current hunk
        ? - print help
 +
+If you press "l" then the hunk will be reprinted with each insertion or
+deletion labelled with a number and you will be prompted to enter which
+lines you wish to select. Individual line numbers should be separated by
+a space or comma, to specify a range of lines use a dash between
+them. If the upper bound of a range of lines is omitted it defaults to
+the last line.
++
 After deciding the fate for all hunks, if there is any hunk
 that was chosen, the index is updated with the selected hunks.
 +
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 8361ef45e7..cbc9e5698a 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1013,6 +1013,171 @@ sub color_diff {
 	} @_;
 }
 
+use constant {
+	NO_NEWLINE => 1,
+};
+
+sub label_hunk_lines {
+	my $hunk = shift;
+	my $text = $hunk->{TEXT};
+	my (@line_flags, @lines);
+	my ($block, $label, $last_mode) = (0, 0, '');
+	for my $line (1..$#{$text}) {
+		$line_flags[$line] = 0;
+		my $mode = substr($text->[$line], 0, 1);
+		if ($mode eq '\\') {
+			$line_flags[$line - 1] |= NO_NEWLINE;
+		}
+		if ($mode eq '-' or $mode eq '+') {
+			$lines[++$label] = $line;
+		}
+	}
+	if ($label > 1) {
+		$hunk->{LABELS} = {
+			LINES => \@lines,
+		};
+		$hunk->{LINE_FLAGS} = \@line_flags;
+		return 1;
+	}
+	return 0;
+}
+
+sub select_hunk_lines {
+	my ($hunk, $selected) = @_;
+	my ($line_flags, $text) = @{$hunk}{qw(LINE_FLAGS TEXT)};
+	my ($i, $o_cnt, $n_cnt) = (0, 0, 0);
+	my @newtext;
+
+	my $select_lines = sub {
+		for my $i (@_) {
+			my $line = $text->[$i];
+			my $mode = substr($line, 0, 1);
+			push @newtext, $line;
+			if ($mode eq '+') {
+				$n_cnt++;
+			} elsif ($mode eq '-') {
+				$o_cnt++;
+			}
+		}
+	};
+
+	my ($lo, $hi) = splice(@$selected, 0, 2);
+	# Lines with this mode will become context lines if they are
+	# not selected
+	my $context_mode = $patch_mode_flavour{IS_REVERSE} ? '+' : '-';
+	for $i (1..$#{$text}) {
+		if ($lo <= $i and $i <= $hi) {
+			$select_lines->($i);
+		} else {
+			my $line = $text->[$i];
+			my $mode = substr($line, 0, 1);
+			if ($mode eq ' ' or $mode eq $context_mode) {
+				push @newtext, ' ' . substr($line, 1);
+				$o_cnt++; $n_cnt++;
+				if ($line_flags->[$i] & NO_NEWLINE) {
+					push @newtext, $text->[$i + 1];
+				}
+			}
+		}
+		if ($i == $hi) {
+			if (@$selected) {
+				($lo, $hi) = splice(@$selected, 0, 2);
+			}
+		}
+	}
+	my ($o_ofs, $orig_o_cnt, $n_ofs, $orig_n_cnt) =
+					parse_hunk_header($text->[0]);
+	unshift @newtext, format_hunk_header($o_ofs, $o_cnt, $n_ofs, $n_cnt);
+	my $newhunk = {
+		TEXT => \@newtext,
+		DISPLAY => [ color_diff(@newtext) ],
+		OFS_DELTA => $orig_o_cnt - $orig_n_cnt - $o_cnt + $n_cnt,
+		TYPE => $hunk->{TYPE},
+		USE => 1,
+	};
+	# If this hunk has previously been edited add the offset delta
+	# of the old hunk to get the real delta from the original
+	# hunk.
+	if ($hunk->{OFS_DELTA}) {
+		$newhunk->{OFS_DELTA} += $hunk->{OFS_DELTA};
+	}
+	return $newhunk;
+}
+
+sub check_hunk_label {
+	my ($max_label, $label) = @_;
+	if ($label < 1 or $label > $max_label) {
+		error_msg sprintf(__("invalid hunk line '%d'\n"), $label);
+		return 0;
+	}
+	return 1;
+}
+
+sub parse_hunk_selection {
+	my ($hunk, $line) = @_;
+	my $lines = $hunk->{LABELS}->{LINES};
+	my $max_label = $#{$lines};
+	my %selected;
+	my @fields = split(/[,\s]+/, $line);
+	for my $f (@fields) {
+		if (my ($lo, $hi) = ($f =~ /^([0-9]+)-([0-9]*)$/)) {
+			if ($hi eq '') {
+				$hi = $max_label;
+			}
+			check_hunk_label($max_label, $lo) or return undef;
+			check_hunk_label($max_label, $hi) or return undef;
+			if ($hi < $lo) {
+				($lo, $hi) = ($hi, $lo);
+			}
+			undef @selected{$lo..$hi};
+		} elsif (my ($label) = ($f =~ /^([0-9]+)$/)) {
+			check_hunk_label($max_label, $label) or return undef;
+			undef $selected{$label};
+		} else {
+			error_msg sprintf(__("invalid hunk line '%s'\n"), $f);
+			return undef;
+		}
+	}
+	[ map {
+		my $line = $lines->[$_];
+		if ($hunk->{LINE_FLAGS}->[$line] & NO_NEWLINE) {
+			($line, $line + 1);
+		} else {
+			($line, $line);
+		}
+	} sort { $a <=> $b } keys(%selected) ];
+}
+
+sub display_hunk_lines {
+	my $hunk = shift;
+	my ($display, $lines) = ($hunk->{DISPLAY}, $hunk->{LABELS}->{LINES});
+	my $max_label = $#{$lines};
+	my $width = int(log($max_label) / log(10)) + 1;
+	my $padding = ' ' x ($width + 1);
+	my $label = 1;
+	for my $line (0..$#{$display}) {
+		if ($lines->[$label] == $line) {
+			printf '%*d %s', $width, $label, $display->[$line];
+			$label++ if ($label < $max_label);
+		} else {
+			print $padding . $display->[$line];
+		}
+	}
+}
+
+sub select_lines_loop {
+	my $hunk = shift;
+	display_hunk_lines($hunk);
+	my $selection = undef;
+	until (defined $selection) {
+		print colored $prompt_color, __("select lines? ");
+		my $text = <STDIN>;
+		defined $text and $text =~ /\S/ or return undef;
+		$selection = parse_hunk_selection($hunk, $text);
+	}
+	return select_hunk_lines($hunk, $selection);
+}
+
 my %edit_hunk_manually_modes = (
 	stage => N__(
 "If the patch applies cleanly, the edited hunk will immediately be
@@ -1255,6 +1420,7 @@ j - leave this hunk undecided, see next undecided hunk
 J - leave this hunk undecided, see next hunk
 k - leave this hunk undecided, see previous undecided hunk
 K - leave this hunk undecided, see previous hunk
+l - select hunk lines to use
 s - split the current hunk into smaller hunks
 e - manually edit the current hunk
 ? - print help
@@ -1471,6 +1637,9 @@ sub patch_update_file {
 		if ($hunk[$ix]{TYPE} eq 'hunk') {
 			$other .= ',e';
 		}
+		if (label_hunk_lines($hunk[$ix])) {
+			$other .= ',l';
+		}
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
@@ -1610,6 +1779,18 @@ sub patch_update_file {
 					next;
 				}
 			}
+			elsif ($line =~ /^l/) {
+				unless ($other =~ /l/) {
+					error_msg __("Cannot select line by line\n");
+					next;
+				}
+				my $newhunk = select_lines_loop($hunk[$ix]);
+				if ($newhunk) {
+					splice @hunk, $ix, 1, $newhunk;
+				} else {
+					next;
+				}
+			}
 			elsif ($other =~ /s/ && $line =~ /^s/) {
 				my @split = split_hunk($hunk[$ix]{TEXT}, $hunk[$ix]{DISPLAY});
 				if (1 < @split) {
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index f1bb879ea4..5b535a22d5 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -403,6 +403,101 @@ test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
 	! grep "^+31" actual
 '
 
+test_expect_success 'setup test file' '
+	test_write_lines 10 31 32 33 60 >test &&
+	printf 61 >>test
+'
+
+test_expect_success 'setup expected diff' '
+	cat >expected <<-\EOF
+	diff --git a/test b/test
+	index 0889435..341cc6b 100644
+	--- a/test
+	+++ b/test
+	@@ -1,6 +1,6 @@
+	 10
+	 20
+	-30
+	-40
+	-50
+	+31
+	+33
+	 60
+	+61
+	\ No newline at end of file
+	EOF
+'
+
+test_expect_success 'can stage individual lines of patch' '
+	git reset &&
+	printf "%s\n" l "5-2,7-" |
+	EDITOR=: git add -p 2>error &&
+	test_must_be_empty error &&
+	git diff --cached HEAD >actual &&
+	diff_cmp expected actual
+'
+
+test_expect_success 'setup expected diff' '
+	cat >expected <<-\EOF
+	diff --git a/test b/test
+	index 0889435..cc6163b 100644
+	--- a/test
+	+++ b/test
+	@@ -1,6 +1,7 @@
+	 10
+	 20
+	 30
+	-40
+	 50
+	+33
+	 60
+	+61
+	\ No newline at end of file
+	EOF
+'
+
+test_expect_success 'can reset individual lines of patch' '
+	printf "%s\n" l 4,1,3 |
+	EDITOR=: git reset -p 2>error &&
+	test_must_be_empty error &&
+	git diff --cached HEAD >actual &&
+	diff_cmp expected actual
+'
+
+test_expect_success 'setup file' '
+	test_write_lines ten twenty thirty forty fifty >test &&
+	printf sixty >>test
+'
+
+test_expect_success 'setup expected diff' '
+	cat >expected <<-\EOF
+	diff --git a/test b/test
+	index 0889435..cc6163b 100644
+	--- a/test
+	+++ b/test
+	@@ -1,6 +1,8 @@
+	-10
+	+ten
+	+twenty
+	+thirty
+	 20
+	-30
+	+sixty
+	 40
+	 50
+	 60
+	EOF
+'
+
+test_expect_failure 'can stage modified lines of patch (1)' '
+	git reset &&
+	printf "%s\n" l "1,3 7-9 12" |
+	EDITOR=: git add -p 2>error &&
+	test_must_be_empty error &&
+	git diff --cached HEAD >actual &&
+	diff_cmp expected actual
+'
+
 test_expect_success 'patch mode ignores unmerged entries' '
 	git reset --hard &&
 	test_commit conflict &&
@@ -571,4 +666,12 @@ test_expect_success 'add -p patch editing works with pathological context lines'
 	test_cmp expected-2 actual
 '
 
+test_expect_success 'add -p selecting lines works with pathological context lines' '
+	git reset &&
+	printf "%s\n" l 2 y |
+	GIT_EDITOR=./editor git add -p &&
+	git cat-file blob :a >actual &&
+	test_cmp expected-2 actual
+'
+
 test_done
-- 
2.18.0

