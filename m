Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49EE11F42D
	for <e@80x24.org>; Fri, 16 Mar 2018 10:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753061AbeCPKN7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 06:13:59 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:24806 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751783AbeCPKN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 06:13:57 -0400
Received: from lindisfarne.localdomain ([92.22.2.60])
        by smtp.talktalk.net with SMTP
        id wmMuefAH1C0WbwmN1espwU; Fri, 16 Mar 2018 10:13:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521195236;
        bh=IFZqdmLoTQKaFYrgx5ce88HaqBXw/TRp9RiKyIXsuvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=eTOr5IcGH0YZTFI2LPk6WktrRJcKjQrUAHuQ3V4peqISB3krhOk1nZx2YYZ4Qr4VQ
         27p97Gz6Vk4PfJ28qM+hXV9ZDoze1IVnlH+JbIAU1UHBqSU11JsvZUFKsRE9nK2IFo
         IGyWga6pZP68HbAEdUuTeHlGABxflI341BLDjmuY=
X-Originating-IP: [92.22.2.60]
X-Spam: 0
X-OAuthority: v=2.3 cv=Q+T8Hb+a c=1 sm=1 tr=0 a=pcfIiQRzx6UxJOplHTSsng==:117
 a=pcfIiQRzx6UxJOplHTSsng==:17 a=evINK-nbAAAA:8 a=XbrJMvtceDulOWkQ35YA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=L_g5_PAOpBqGSA1i:21 a=4stXpJiOzY38WXmf:21
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gustavo Leite <gustavoleite.ti@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 1/3] add -p: select individual hunk lines
Date:   Fri, 16 Mar 2018 10:13:44 +0000
Message-Id: <20180316101346.7137-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316101346.7137-1-phillip.wood@talktalk.net>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180316101346.7137-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfPwJZMM99MjpD9xfwZJVlUqj2t6LbiDD4fzaymXk/iv41QKDvKvPaBSZuzEgGA9+aWg8P1h0I4ob7RA47XIik/0/mAW7QSgphI+B8Fl87gELvhgej5oy
 L0lgL7/Bp7jQ05IOYRy5MG5qGDPQfeRfWoKmgWQDbvPao+RehKwkG2MpAzq5VDHcsOnuk0H9QlAbYQK4RqbdzvfG6RYI0nbspZHH4wdkaGEGGey+2KTQ9fKT
 gZgsuUOH0T5BCDVVNVN5wBVi1zjEf9ApvcPj0KSxLfI7bpQ3/CuJzAFpi4oczNbvGP+gUdP/KCpHkA2cZXNWokhnOvNmEWKwHzvhmzwicHE=
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
all lines from 'a' to the end of the hunk.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    changes since v2:
     - remove support for omitting the lower bound of a range of lines as
       this clashes with using '-' for inverting the selection.
     - document that the upper bound can be omitted.

 Documentation/git-add.txt  |   8 +++
 git-add--interactive.perl  | 140 +++++++++++++++++++++++++++++++++++++++++++++
 t/t3701-add-interactive.sh |  65 +++++++++++++++++++++
 3 files changed, 213 insertions(+)

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
index f83e7450ad..712226b34c 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1013,6 +1013,130 @@ sub color_diff {
 	} @_;
 }
 
+sub label_hunk_lines {
+	local $_;
+	my $hunk = shift;
+	my $i = 0;
+	my $labels = [ map { /^[-+]/ ? ++$i : 0 } @{$hunk->{TEXT}} ];
+	if ($i > 1) {
+		@{$hunk}{qw(LABELS MAX_LABEL)} = ($labels, $i);
+		return 1;
+	}
+	return 0;
+}
+
+sub select_hunk_lines {
+	my ($hunk, $selected) = @_;
+	my ($text, $labels) = @{$hunk}{qw(TEXT LABELS)};
+	my ($i, $o_cnt, $n_cnt) = (0, 0, 0);
+	my ($push_eol, @newtext);
+	# Lines with this mode will become context lines if they are
+	# not selected
+	my $context_mode = $patch_mode_flavour{IS_REVERSE} ? '+' : '-';
+	for $i (1..$#{$text}) {
+		my $mode = substr($text->[$i], 0, 1);
+		if ($mode eq '\\') {
+			push @newtext, $text->[$i] if ($push_eol);
+			undef $push_eol;
+		} elsif ($labels->[$i] and $selected->[$labels->[$i]]) {
+			push @newtext, $text->[$i];
+			if ($mode eq '+') {
+				$n_cnt++;
+			} else {
+				$o_cnt++;
+			}
+			$push_eol = 1;
+		} elsif ($mode eq ' ' or $mode eq $context_mode) {
+			push @newtext, ' ' . substr($text->[$i], 1);
+			$o_cnt++; $n_cnt++;
+			$push_eol = 1;
+		} else {
+			undef $push_eol;
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
+	my ($max_label, $label) = ($_[0]->{MAX_LABEL}, $_[1]);
+	if ($label < 1 or $label > $max_label) {
+		error_msg sprintf(__("invalid hunk line '%d'\n"), $label);
+		return 0;
+	}
+	return 1;
+}
+
+sub parse_hunk_selection {
+	local $_;
+	my ($hunk, $line) = @_;
+	my $max_label = $hunk->{MAX_LABEL};
+	my @selected = (0) x ($max_label + 1);
+	my @fields = split(/[,\s]+/, $line);
+	for (@fields) {
+		if (my ($lo, $hi) = /^([0-9]+)-([0-9]*)$/) {
+			if ($hi eq '') {
+				$hi = $max_label;
+			}
+			check_hunk_label($hunk, $lo) or return undef;
+			check_hunk_label($hunk, $hi) or return undef;
+			if ($hi < $lo) {
+				($lo, $hi) = ($hi, $lo);
+			}
+			@selected[$lo..$hi] = (1) x (1 + $hi - $lo);
+		} elsif (/^([0-9]+)$/) {
+			check_hunk_label($hunk, $1) or return undef;
+			$selected[$1] = 1;
+		} else {
+			error_msg sprintf(__("invalid hunk line '%s'\n"), $_);
+			return undef;
+		}
+	}
+	return \@selected;
+}
+
+sub display_hunk_lines {
+	my ($display, $labels, $max_label) =
+				@{$_[0]}{qw(DISPLAY LABELS MAX_LABEL)};
+	my $width = int(log($max_label) / log(10)) + 1;
+	my $padding = ' ' x ($width + 1);
+	for my $i (0..$#{$display}) {
+		if ($labels->[$i]) {
+			printf '%*d %s', $width, $labels->[$i], $display->[$i];
+		} else {
+			print $padding . $display->[$i];
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
@@ -1255,6 +1379,7 @@ j - leave this hunk undecided, see next undecided hunk
 J - leave this hunk undecided, see next hunk
 k - leave this hunk undecided, see previous undecided hunk
 K - leave this hunk undecided, see previous hunk
+l - select hunk lines to use
 s - split the current hunk into smaller hunks
 e - manually edit the current hunk
 ? - print help
@@ -1471,6 +1596,9 @@ sub patch_update_file {
 		if ($hunk[$ix]{TYPE} eq 'hunk') {
 			$other .= ',e';
 		}
+		if (label_hunk_lines($hunk[$ix])) {
+			$other .= ',l';
+		}
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
@@ -1610,6 +1738,18 @@ sub patch_update_file {
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
index a9a9478a29..5f3fcb1758 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -360,6 +360,63 @@ test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
 	! grep "^+31" actual
 '
 
+test_expect_success 'setup expected diff' '
+	cat >expected <<-\EOF
+	diff --git a/test b/test
+	index 0889435..341cc6b 100644
+	--- a/test
+	+++ b/test
+	@@ -1,6 +1,9 @@
+	+5
+	 10
+	 20
+	+21
+	 30
+	 40
+	 50
+	 60
+	+61
+	\ No newline at end of file
+	EOF
+'
+
+test_expect_success 'can stage individual lines of patch' '
+	git reset &&
+	printf 61 >>test &&
+	printf "%s\n" l "1,2 4-" |
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
+	@@ -1,6 +1,8 @@
+	+5
+	 10
+	 20
+	 30
+	 40
+	 50
+	 60
+	+61
+	\ No newline at end of file
+	EOF
+'
+
+test_expect_success 'can reset individual lines of patch' '
+	printf "%s\n" l 2 |
+	EDITOR=: git reset -p 2>error &&
+	test_must_be_empty error &&
+	git diff --cached HEAD >actual &&
+	diff_cmp expected actual
+'
+
 test_expect_success 'patch mode ignores unmerged entries' '
 	git reset --hard &&
 	test_commit conflict &&
@@ -576,4 +633,12 @@ test_expect_success 'add -p patch editing works with pathological context lines'
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
2.16.2

