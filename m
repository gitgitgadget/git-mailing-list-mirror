Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_PH_SURBL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 902491F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 17:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754533AbcJERVh (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 13:21:37 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:44324 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752820AbcJERVg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 13:21:36 -0400
Received: (qmail 21718 invoked from network); 5 Oct 2016 17:21:33 -0000
Received: (qmail 4772 invoked from network); 5 Oct 2016 17:21:30 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 5 Oct 2016 17:21:25 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/14] Mark strings in Perl scripts for translation
Date:   Wed,  5 Oct 2016 17:20:56 +0000
Message-Id: <20161005172110.30801-1-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.10.1.366.g8a57a7a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark messages in some perl scripts for translation.

Thanks for the reviews of Junio Hamano and Jakub Narębski.  Although I think
Jakub Narębski's suggestions are overall good, I am not willing to go that path
because I cannot see huge benefits from them given what we already have and
also I lack Perl skills.

Interdiff bellow.

Vasco Almeida (14):
  i18n: add--interactive: mark strings for translation
  i18n: add--interactive: mark simple here-documents for translation
  i18n: add--interactive: mark strings with interpolation for
    translation
  i18n: clean.c: match string with git-add--interactive.perl
  i18n: add--interactive: mark plural strings
  i18n: add--interactive: mark patch prompt for translation
  i18n: add--interactive: i18n of help_patch_cmd
  i18n: add--interactive: mark edit_hunk_manually message for
    translation
  i18n: add--interactive: remove %patch_modes entries
  i18n: add--interactive: mark status words for translation
  i18n: send-email: mark strings for translation
  i18n: send-email: mark warnings and errors for translation
  i18n: send-email: mark string with interpolation for translation
  i18n: difftool: mark warnings for translation

 Makefile                  |   3 +-
 builtin/clean.c           |  10 +-
 git-add--interactive.perl | 318 ++++++++++++++++++++++++++++++----------------
 git-difftool.perl         |  22 ++--
 git-send-email.perl       | 176 +++++++++++++------------
 perl/Git/I18N.pm          |   9 +-
 t/t0202/test.pl           |  11 +-
 7 files changed, 340 insertions(+), 209 deletions(-)


diff --git a/Makefile b/Makefile
index fc29d85..4ef0344 100644
--- a/Makefile
+++ b/Makefile
@@ -2112,7 +2112,7 @@ XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
 XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 	--keyword=gettextln --keyword=eval_gettextln
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
-	--keyword=__ --keyword="Q__:1,2"
+	--keyword=__ --keyword="__n:1,2"
 LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
 LOCALIZED_SH = $(SCRIPT_SH)
 LOCALIZED_SH += git-parse-remote.sh
diff --git a/builtin/clean.c b/builtin/clean.c
index 0371010..d6bc3aa 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -287,11 +287,11 @@ static void pretty_print_menus(struct string_list *menu_list)
 static void prompt_help_cmd(int singleton)
 {
 	clean_print_color(CLEAN_COLOR_HELP);
-	printf_ln(singleton ?
+	printf(singleton ?
 		  _("Prompt help:\n"
 		    "1          - select a numbered item\n"
 		    "foo        - select item based on unique prefix\n"
-		    "           - (empty) select nothing") :
+		    "           - (empty) select nothing\n") :
 		  _("Prompt help:\n"
 		    "1          - select a single item\n"
 		    "3-5        - select a range of items\n"
@@ -299,7 +299,7 @@ static void prompt_help_cmd(int singleton)
 		    "foo        - select item based on unique prefix\n"
 		    "-...       - unselect specified items\n"
 		    "*          - choose all items\n"
-		    "           - (empty) finish selecting"));
+		    "           - (empty) finish selecting\n"));
 	clean_print_color(CLEAN_COLOR_RESET);
 }
 
@@ -508,7 +508,7 @@ static int parse_choice(struct menu_stuff *menu_stuff,
 		if (top <= 0 || bottom <= 0 || top > menu_stuff->nr || bottom > top ||
 		    (is_single && bottom != top)) {
 			clean_print_color(CLEAN_COLOR_ERROR);
-			printf_ln(_("Huh (%s)?"), (*ptr)->buf);
+			printf(_("Huh (%s)?\n"), (*ptr)->buf);
 			clean_print_color(CLEAN_COLOR_RESET);
 			continue;
 		}
@@ -774,7 +774,7 @@ static int ask_each_cmd(void)
 static int quit_cmd(void)
 {
 	string_list_clear(&del_list, 0);
-	printf_ln(_("Bye."));
+	printf(_("Bye.\n"));
 	return MENU_RETURN_NO_LOOP;
 }
 
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index b72cc97..0b4a27c 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -106,9 +106,6 @@ my %patch_modes = (
 		DIFF => 'diff-files -p',
 		APPLY => sub { apply_patch 'apply --cached', @_; },
 		APPLY_CHECK => 'apply --cached',
-		VERB => 'Stage',
-		TARGET => '',
-		PARTICIPLE => 'staging',
 		FILTER => 'file-only',
 		IS_REVERSE => 0,
 	},
@@ -116,9 +113,6 @@ my %patch_modes = (
 		DIFF => 'diff-index -p HEAD',
 		APPLY => sub { apply_patch 'apply --cached', @_; },
 		APPLY_CHECK => 'apply --cached',
-		VERB => 'Stash',
-		TARGET => '',
-		PARTICIPLE => 'stashing',
 		FILTER => undef,
 		IS_REVERSE => 0,
 	},
@@ -126,9 +120,6 @@ my %patch_modes = (
 		DIFF => 'diff-index -p --cached',
 		APPLY => sub { apply_patch 'apply -R --cached', @_; },
 		APPLY_CHECK => 'apply -R --cached',
-		VERB => 'Unstage',
-		TARGET => '',
-		PARTICIPLE => 'unstaging',
 		FILTER => 'index-only',
 		IS_REVERSE => 1,
 	},
@@ -136,9 +127,6 @@ my %patch_modes = (
 		DIFF => 'diff-index -R -p --cached',
 		APPLY => sub { apply_patch 'apply --cached', @_; },
 		APPLY_CHECK => 'apply --cached',
-		VERB => 'Apply',
-		TARGET => ' to index',
-		PARTICIPLE => 'applying',
 		FILTER => 'index-only',
 		IS_REVERSE => 0,
 	},
@@ -146,9 +134,6 @@ my %patch_modes = (
 		DIFF => 'diff-files -p',
 		APPLY => sub { apply_patch 'apply -R', @_; },
 		APPLY_CHECK => 'apply -R',
-		VERB => 'Discard',
-		TARGET => ' from worktree',
-		PARTICIPLE => 'discarding',
 		FILTER => 'file-only',
 		IS_REVERSE => 1,
 	},
@@ -156,9 +141,6 @@ my %patch_modes = (
 		DIFF => 'diff-index -p',
 		APPLY => sub { apply_patch_for_checkout_commit '-R', @_ },
 		APPLY_CHECK => 'apply -R',
-		VERB => 'Discard',
-		TARGET => ' from index and worktree',
-		PARTICIPLE => 'discarding',
 		FILTER => undef,
 		IS_REVERSE => 1,
 	},
@@ -166,9 +148,6 @@ my %patch_modes = (
 		DIFF => 'diff-index -R -p',
 		APPLY => sub { apply_patch_for_checkout_commit '', @_ },
 		APPLY_CHECK => 'apply',
-		VERB => 'Apply',
-		TARGET => ' to index and worktree',
-		PARTICIPLE => 'applying',
 		FILTER => undef,
 		IS_REVERSE => 0,
 	},
@@ -256,7 +235,8 @@ sub list_untracked {
 	run_cmd_pipe(qw(git ls-files --others --exclude-standard --), @ARGV);
 }
 
-my $status_fmt = '%12s %12s %s';
+# TRANSLATORS: you can adjust this to align "git add -i" status menu
+my $status_fmt = __('%12s %12s %s');
 my $status_head = sprintf($status_fmt, __('staged'), __('unstaged'), __('path'));
 
 {
@@ -315,7 +295,7 @@ sub list_modified {
 			my ($change, $bin);
 			$file = unquote_path($file);
 			if ($add eq '-' && $del eq '-') {
-				$change = 'binary';
+				$change = __('binary');
 				$bin = 1;
 			}
 			else {
@@ -324,7 +304,7 @@ sub list_modified {
 			$data{$file} = {
 				INDEX => $change,
 				BINARY => $bin,
-				FILE => 'nothing',
+				FILE => __('nothing'),
 			}
 		}
 		elsif (($adddel, $file) =
@@ -340,7 +320,7 @@ sub list_modified {
 			$file = unquote_path($file);
 			my ($change, $bin);
 			if ($add eq '-' && $del eq '-') {
-				$change = 'binary';
+				$change = __('binary');
 				$bin = 1;
 			}
 			else {
@@ -360,7 +340,7 @@ sub list_modified {
 			$file = unquote_path($2);
 			if (!exists $data{$file}) {
 				$data{$file} = +{
-					INDEX => 'unchanged',
+					INDEX => __('unchanged'),
 					BINARY => 0,
 				};
 			}
@@ -375,10 +355,10 @@ sub list_modified {
 
 		if ($only) {
 			if ($only eq 'index-only') {
-				next if ($it->{INDEX} eq 'unchanged');
+				next if ($it->{INDEX} eq __('unchanged'));
 			}
 			if ($only eq 'file-only') {
-				next if ($it->{FILE} eq 'nothing');
+				next if ($it->{FILE} eq __('nothing'));
 			}
 		}
 		push @return, +{
@@ -621,7 +601,7 @@ sub list_and_choose {
 				}
 			}
 			if ($opts->{SINGLETON} && $bottom != $top) {
-				error_msg sprintf(__("Huh (%s)?\n"), $choice);
+				error_msg sprintf(__("Huh (%s)?"), $choice);
 				next TOPLOOP;
 			}
 			for ($i = $bottom-1; $i <= $top-1; $i++) {
@@ -640,25 +620,25 @@ sub list_and_choose {
 }
 
 sub singleton_prompt_help_cmd {
-	print colored $help_color, __(
-"Prompt help:
+	print colored $help_color, __ <<'EOF' ;
+Prompt help:
 1          - select a numbered item
 foo        - select item based on unique prefix
-           - (empty) select nothing"),
-"\n";
+           - (empty) select nothing
+EOF
 }
 
 sub prompt_help_cmd {
-	print colored $help_color, __(
-"Prompt help:
+	print colored $help_color, __ <<'EOF' ;
+Prompt help:
 1          - select a single item
 3-5        - select a range of items
 2-3,6-9    - select multiple ranges
 foo        - select item based on unique prefix
 -...       - unselect specified items
 *          - choose all items
-           - (empty) finish selecting"),
-"\n";
+           - (empty) finish selecting
+EOF
 }
 
 sub status_cmd {
@@ -671,16 +651,16 @@ sub say_n_paths {
 	my $did = shift @_;
 	my $cnt = scalar @_;
 	if ($did eq 'added') {
-		printf(Q__("added one path\n", "added %d paths\n",
+		printf(__n("added %d path\n", "added %d paths\n",
 			   $cnt), $cnt);
 	} elsif ($did eq 'updated') {
-		printf(Q__("updated one path\n", "updated %d paths\n",
+		printf(__n("updated %d path\n", "updated %d paths\n",
 			   $cnt), $cnt);
-	} elsif ($did eq 'reversed') {
-		printf(Q__("reversed one path\n", "reversed %d paths\n",
+	} elsif ($did eq 'reverted') {
+		printf(__n("reverted %d path\n", "reverted %d paths\n",
 			   $cnt), $cnt);
 	} else {
-		printf(Q__("touched one path\n", "touched %d paths\n",
+		printf(__n("touched %d path\n", "touched %d paths\n",
 			   $cnt), $cnt);
 	}
 }
@@ -1057,6 +1037,30 @@ sub color_diff {
 	} @_;
 }
 
+my %edit_hunk_manually_modes = (
+	stage => __(
+"# If the patch applies cleanly, the edited hunk will immediately be
+# marked for staging."),
+	stash => __(
+"# If the patch applies cleanly, the edited hunk will immediately be
+# marked for stashing."),
+	reset_head => __(
+"# If the patch applies cleanly, the edited hunk will immediately be
+# marked for unstaging."),
+	reset_nothead => __(
+"# If the patch applies cleanly, the edited hunk will immediately be
+# marked for applying."),
+	checkout_index => __(
+"# If the patch applies cleanly, the edited hunk will immediately be
+# marked for discarding"),
+	checkout_head => __(
+"# If the patch applies cleanly, the edited hunk will immediately be
+# marked for discarding."),
+	checkout_nothead => __(
+"# If the patch applies cleanly, the edited hunk will immediately be
+# marked for applying."),
+);
+
 sub edit_hunk_manually {
 	my ($oldtext) = @_;
 
@@ -1073,51 +1077,12 @@ sub edit_hunk_manually {
 # To remove '%s' lines, make them ' ' lines (context).
 # To remove '%s' lines, delete them.
 # Lines starting with # will be removed.
-#"), $remove_minus, $remove_plus),
-"\n";
-	if ($patch_mode eq 'stage') {
-		print $fh __(
-"# If the patch applies cleanly, the edited hunk will immediately be
-# marked for staging. If it does not apply cleanly, you will be given
-# an opportunity to edit again. If all lines of the hunk are removed,
-# then the edit is aborted and the hunk is left unchanged.");
-	} elsif ($patch_mode eq 'stash') {
-		print $fh __(
-"# If the patch applies cleanly, the edited hunk will immediately be
-# marked for stashing. If it does not apply cleanly, you will be given
-# an opportunity to edit again. If all lines of the hunk are removed,
-# then the edit is aborted and the hunk is left unchanged.");
-	} elsif ($patch_mode eq 'reset_head') {
-		print $fh __(
-"# If the patch applies cleanly, the edited hunk will immediately be
-# marked for unstaging. If it does not apply cleanly, you will be given
+#\n"), $remove_minus, $remove_plus),
+$edit_hunk_manually_modes{$patch_mode}, __(
+# TRANSLATORS: 'it' refers to the patch mentioned in the previous messages.
+" If it does not apply cleanly, you will be given
 # an opportunity to edit again. If all lines of the hunk are removed,
-# then the edit is aborted and the hunk is left unchanged.");
-	} elsif ($patch_mode eq 'reset_nothead') {
-		print $fh __(
-"# If the patch applies cleanly, the edited hunk will immediately be
-# marked for applying. If it does not apply cleanly, you will be given
-# an opportunity to edit again. If all lines of the hunk are removed,
-# then the edit is aborted and the hunk is left unchanged.");
-	} elsif ($patch_mode eq 'checkout_index') {
-		print $fh __(
-"# If the patch applies cleanly, the edited hunk will immediately be
-# marked for discarding. If it does not apply cleanly, you will be given
-# an opportunity to edit again. If all lines of the hunk are removed,
-# then the edit is aborted and the hunk is left unchanged.");
-	} elsif ($patch_mode eq 'checkout_head') {
-		print $fh __(
-"# If the patch applies cleanly, the edited hunk will immediately be
-# marked for discarding. If it does not apply cleanly, you will be given
-# an opportunity to edit again. If all lines of the hunk are removed,
-# then the edit is aborted and the hunk is left unchanged.");
-	} elsif ($patch_mode eq 'checkout_nothead') {
-		print $fh __(
-"# If the patch applies cleanly, the edited hunk will immediately be
-# marked for applying. If it does not apply cleanly, you will be given
-# an opportunity to edit again. If all lines of the hunk are removed,
-# then the edit is aborted and the hunk is left unchanged.");
-	}
+# then the edit is aborted and the hunk is left unchanged.\n");
 	close $fh;
 
 	chomp(my $editor = run_cmd_pipe(qw(git var GIT_EDITOR)));
@@ -1216,6 +1181,9 @@ sub edit_hunk_loop {
 				# TRANSLATORS: do not translate [y/n]
 				# The program will only accept that input
 				# at this point.
+				# Consider translating (saying "no" discards!) as
+				# (saying "n" for "no" discards!) if the translation
+				# of the word "no" does not start with n.
 				__('Your edited hunk does not apply. Edit again '
 				   . '(saying "no" discards!) [y/n]? ')
 				) or return undef;
@@ -1223,59 +1191,54 @@ sub edit_hunk_loop {
 	}
 }
 
-sub help_patch_cmd {
-	if ($patch_mode eq 'stage') {
-		print colored $help_color, __(
+my %help_patch_modes = (
+	stage => __(
 "y - stage this hunk
 n - do not stage this hunk
 q - quit; do not stage this hunk or any of the remaining ones
 a - stage this hunk and all later hunks in the file
-d - do not stage this hunk or any of the later hunks in the file");
-	} elsif ($patch_mode eq 'stash') {
-		print colored $help_color, __(
+d - do not stage this hunk or any of the later hunks in the file"),
+	stash => __(
 "y - stash this hunk
 n - do not stash this hunk
 q - quit; do not stash this hunk or any of the remaining ones
 a - stash this hunk and all later hunks in the file
-d - do not stash this hunk or any of the later hunks in the file");
-	} elsif ($patch_mode eq 'reset_head') {
-		print colored $help_color, __(
+d - do not stash this hunk or any of the later hunks in the file"),
+	reset_head => __(
 "y - unstage this hunk
 n - do not unstage this hunk
 q - quit; do not unstage this hunk or any of the remaining ones
 a - unstage this hunk and all later hunks in the file
-d - do not unstage this hunk or any of the later hunks in the file");
-	} elsif ($patch_mode eq 'reset_nothead') {
-		print colored $help_color, __(
+d - do not unstage this hunk or any of the later hunks in the file"),
+	reset_nothead => __(
 "y - apply this hunk to index
 n - do not apply this hunk to index
 q - quit; do not apply this hunk or any of the remaining ones
 a - apply this hunk and all later hunks in the file
-d - do not apply this hunk or any of the later hunks in the file");
-	} elsif ($patch_mode eq 'checkout_index') {
-		print colored $help_color, __(
+d - do not apply this hunk or any of the later hunks in the file"),
+	checkout_index => __(
 "y - discard this hunk from worktree
 n - do not discard this hunk from worktree
 q - quit; do not discard this hunk or any of the remaining ones
 a - discard this hunk and all later hunks in the file
-d - do not discard this hunk or any of the later hunks in the file");
-	} elsif ($patch_mode eq 'checkout_head') {
-		print colored $help_color, __(
+d - do not discard this hunk or any of the later hunks in the file"),
+	checkout_head => __(
 "y - discard this hunk from index and worktree
 n - do not discard this hunk from index and worktree
 q - quit; do not discard this hunk or any of the remaining ones
 a - discard this hunk and all later hunks in the file
-d - do not discard this hunk or any of the later hunks in the file");
-	} elsif ($patch_mode eq 'checkout_nothead') {
-		print colored $help_color, __(
+d - do not discard this hunk or any of the later hunks in the file"),
+	checkout_nothead => __(
 "y - apply this hunk to index and worktree
 n - do not apply this hunk to index and worktree
 q - quit; do not apply this hunk or any of the remaining ones
 a - apply this hunk and all later hunks in the file
-d - do not apply this hunk or any of the later hunks in the file");
-	}
-	print colored $help_color, "\n", __(
-"g - select a hunk to go to
+d - do not apply this hunk or any of the later hunks in the file"),
+);
+
+sub help_patch_cmd {
+	print colored $help_color, $help_patch_modes{$patch_mode}, "\n", __ <<EOF ;
+g - select a hunk to go to
 / - search for a hunk matching the given regex
 j - leave this hunk undecided, see next undecided hunk
 J - leave this hunk undecided, see next hunk
@@ -1283,8 +1246,8 @@ k - leave this hunk undecided, see previous undecided hunk
 K - leave this hunk undecided, see previous hunk
 s - split the current hunk into smaller hunks
 e - manually edit the current hunk
-? - print help"),
-"\n";
+? - print help
+EOF
 }
 
 sub apply_patch {
@@ -1390,6 +1353,44 @@ sub display_hunks {
 	return $i;
 }
 
+my %patch_update_prompt_modes = (
+	stage => {
+		mode => __("Stage mode change [y,n,q,a,d,/%s,?]? "),
+		deletion => __("Stage deletion [y,n,q,a,d,/%s,?]? "),
+		hunk => __("Stage this hunk [y,n,q,a,d,/%s,?]? "),
+	},
+	stash => {
+		mode => __("Stash mode change [y,n,q,a,d,/%s,?]? "),
+		deletion => __("Stash deletion [y,n,q,a,d,/%s,?]? "),
+		hunk => __("Stash this hunk [y,n,q,a,d,/%s,?]? "),
+	},
+	reset_head => {
+		mode => __("Unstage mode change [y,n,q,a,d,/%s,?]? "),
+		deletion => __("Unstage deletion [y,n,q,a,d,/%s,?]? "),
+		hunk => __("Unstage this hunk [y,n,q,a,d,/%s,?]? "),
+	},
+	reset_nothead => {
+		mode => __("Apply mode change to index [y,n,q,a,d,/%s,?]? "),
+		deletion => __("Apply deletion to index [y,n,q,a,d,/%s,?]? "),
+		hunk => __("Apply this hunk to index [y,n,q,a,d,/%s,?]? "),
+	},
+	checkout_index => {
+		mode => __("Discard mode change from worktree [y,n,q,a,d,/%s,?]? "),
+		deletion => __("Discard deletion from worktree [y,n,q,a,d,/%s,?]? "),
+		hunk => __("Discard this hunk from worktree [y,n,q,a,d,/%s,?]? "),
+	},
+	checkout_head => {
+		mode => __("Discard mode change from index and worktree [y,n,q,a,d,/%s,?]? "),
+		deletion => __("Discard deletion from index and worktree [y,n,q,a,d,/%s,?]? "),
+		hunk => __("Discard this hunk from index and worktree [y,n,q,a,d,/%s,?]? "),
+	},
+	checkout_nothead => {
+		mode => __("Apply mode change to index and worktree [y,n,q,a,d,/%s,?]? "),
+		deletion => __("Apply deletion to index and worktree [y,n,q,a,d,/%s,?]? "),
+		hunk => __("Apply this hunk to index and worktree [y,n,q,a,d,/%s,?]? "),
+	},
+);
+
 sub patch_update_file {
 	my $quit = 0;
 	my ($ix, $num);
@@ -1462,84 +1463,9 @@ sub patch_update_file {
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
-		if ($patch_mode eq 'stage') {
-			if ($hunk[$ix]{TYPE} eq 'mode') {
-			  print colored $prompt_color,
-			    sprintf(__("Stage mode change [y,n,q,a,d,/%s,?]? "), $other);
-			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
-			  print colored $prompt_color,
-			    sprintf(__("Stage deletion [y,n,q,a,d,/%s,?]? "), $other);
-			} else {
-			  print colored $prompt_color,
-			    sprintf(__("Stage this hunk [y,n,q,a,d,/%s,?]? "), $other);
-			}
-		} elsif ($patch_mode eq 'stash') {
-			if ($hunk[$ix]{TYPE} eq 'mode') {
-			  print colored $prompt_color,
-			    sprintf(__("Stash mode change [y,n,q,a,d,/%s,?]? "), $other);
-			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
-			  print colored $prompt_color,
-			    sprintf(__("Stash deletion [y,n,q,a,d,/%s,?]? "), $other);
-			} else {
-			  print colored $prompt_color,
-			    sprintf(__("Stash this hunk [y,n,q,a,d,/%s,?]? "), $other);
-			}
-		} elsif ($patch_mode eq 'reset_head') {
-			if ($hunk[$ix]{TYPE} eq 'mode') {
-			  print colored $prompt_color,
-			    sprintf(__("Unstage mode change [y,n,q,a,d,/%s,?]? "), $other);
-			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
-			  print colored $prompt_color,
-			    sprintf(__("Unstage deletion [y,n,q,a,d,/%s,?]? "), $other);
-			} else {
-			  print colored $prompt_color,
-			    sprintf(__("Unstage this hunk [y,n,q,a,d,/%s,?]? "), $other);
-			}
-		} elsif ($patch_mode eq 'reset_nothead') {
-			if ($hunk[$ix]{TYPE} eq 'mode') {
-			  print colored $prompt_color,
-			    sprintf(__("Apply mode change to index [y,n,q,a,d,/%s,?]? "), $other);
-			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
-			  print colored $prompt_color,
-			    sprintf(__("Apply deletion to index [y,n,q,a,d,/%s,?]? "), $other);
-			} else {
-			  print colored $prompt_color,
-			    sprintf(__("Apply this hunk to index [y,n,q,a,d,/%s,?]? "), $other);
-			}
-		} elsif ($patch_mode eq 'checkout_index') {
-			if ($hunk[$ix]{TYPE} eq 'mode') {
-			  print colored $prompt_color,
-			    sprintf(__("Discard mode change from worktree [y,n,q,a,d,/%s,?]? "), $other);
-			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
-			  print colored $prompt_color,
-			    sprintf(__("Discard deletion from worktree [y,n,q,a,d,/%s,?]? "), $other);
-			} else {
-			  print colored $prompt_color,
-			    sprintf(__("Discard this hunk from worktree [y,n,q,a,d,/%s,?]? "), $other);
-			}
-		} elsif ($patch_mode eq 'checkout_head') {
-			if ($hunk[$ix]{TYPE} eq 'mode') {
-			  print colored $prompt_color,
-			    sprintf(__("Discard mode change from index and worktree [y,n,q,a,d,/%s,?]? "), $other);
-			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
-			  print colored $prompt_color,
-			    sprintf(__("Discard deletion from index and worktree [y,n,q,a,d,/%s,?]? "), $other);
-			} else {
-			  print colored $prompt_color,
-			    sprintf(__("Discard this hunk from index and worktree [y,n,q,a,d,/%s,?]? "), $other);
-			}
-		} elsif ($patch_mode eq 'checkout_nothead') {
-			if ($hunk[$ix]{TYPE} eq 'mode') {
-			  print colored $prompt_color,
-			    sprintf(__("Apply mode change to index and worktree [y,n,q,a,d,/%s,?]? "), $other);
-			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
-			  print colored $prompt_color,
-			    sprintf(__("Apply deletion to index and worktree [y,n,q,a,d,/%s,?]? "), $other);
-			} else {
-			  print colored $prompt_color,
-			    sprintf(__("Apply this hunk to index and worktree [y,n,q,a,d,/%s,?]? "), $other);
-			}
-		}
+		print colored $prompt_color,
+			sprintf($patch_update_prompt_modes{$patch_mode}{$hunk[$ix]{TYPE}}, $other);
+
 		my $line = prompt_single_character;
 		last unless defined $line;
 		if ($line) {
@@ -1580,8 +1506,8 @@ sub patch_update_file {
 				} elsif (0 < $response && $response <= $num) {
 					$ix = $response - 1;
 				} else {
-					error_msg sprintf(__("Sorry, only %s hunks available.\n"),
-							     $num);
+					error_msg sprintf(__n("Sorry, only %d hunk available.\n",
+							      "Sorry, only %d hunks available.\n", $num), $num);
 				}
 				next;
 			}
@@ -1677,7 +1603,7 @@ sub patch_update_file {
 				my @split = split_hunk($hunk[$ix]{TEXT}, $hunk[$ix]{DISPLAY});
 				if (1 < @split) {
 					print colored $header_color, sprintf(
-						Q__("Split into %d hunk.\n",
+						__n("Split into %d hunk.\n",
 						    "Split into %d hunks.\n",
 						    scalar(@split)), scalar(@split));
 				}
@@ -1745,14 +1671,16 @@ sub quit_cmd {
 }
 
 sub help_cmd {
-	print colored $help_color, __(
-"status        - show paths with changes
+# TRANSLATORS: please do not translate the command names
+# 'status', 'update', 'revert', etc.
+	print colored $help_color, __ <<'EOF' ;
+status        - show paths with changes
 update        - add working tree state to the staged set of changes
 revert        - revert staged set of changes back to the HEAD version
 patch         - pick hunks and update selectively
 diff	      - view diff between HEAD and index
-add untracked - add contents of untracked files to the staged set of changes"),
-"\n";
+add untracked - add contents of untracked files to the staged set of changes
+EOF
 }
 
 sub process_args {
diff --git a/git-difftool.perl b/git-difftool.perl
index 0140c66..8d3632e 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -339,7 +339,7 @@ sub main
 		if (length($opts{difftool_cmd}) > 0) {
 			$ENV{GIT_DIFF_TOOL} = $opts{difftool_cmd};
 		} else {
-			print "No <tool> given for --tool=<tool>\n";
+			print __("No <tool> given for --tool=<tool>\n");
 			usage(1);
 		}
 	}
@@ -347,7 +347,7 @@ sub main
 		if (length($opts{extcmd}) > 0) {
 			$ENV{GIT_DIFFTOOL_EXTCMD} = $opts{extcmd};
 		} else {
-			print "No <cmd> given for --extcmd=<cmd>\n";
+			print __("No <cmd> given for --extcmd=<cmd>\n");
 			usage(1);
 		}
 	}
diff --git a/git-send-email.perl b/git-send-email.perl
index d4c72a9..5c01425 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -772,8 +772,8 @@ sub ask {
 			return $resp;
 		}
 		if ($confirm_only) {
-			# TRANSLATORS: Keep [y/N] as is.
 			my $yesno = $term->readline(
+				# TRANSLATORS: please keep [y/N] as is.
 				sprintf(__("Are you sure you want to use <%s> [y/N]? "), $resp));
 			if (defined $yesno && $yesno =~ /y/i) {
 				return $resp;
@@ -816,9 +816,9 @@ if (!defined $auto_8bit_encoding && scalar %broken_encoding) {
 if (!$force) {
 	for my $f (@files) {
 		if (get_patch_subject($f) =~ /\Q*** SUBJECT HERE ***\E/) {
-			die "Refusing to send because the patch\n\t$f\n"
+			die sprintf(__("Refusing to send because the patch\n\t%s\n"
 				. "has the template subject '*** SUBJECT HERE ***'. "
-				. "Pass --force if you really want to send.\n";
+				. "Pass --force if you really want to send.\n"), $f);
 		}
 	}
 }
@@ -1311,8 +1311,7 @@ Message-Id: $message_id
 
     For additional information, run 'git send-email --help'.
     To retain the current behavior, but squelch this message,
-    run 'git config --global sendemail.confirm auto'."),
-"\n\n";
+    run 'git config --global sendemail.confirm auto'."), "\n\n";
 		}
 		# TRANSLATORS: Make sure to include [y] [n] [q] [a] in your
 		# translation. The program will only accept English input
@@ -1396,8 +1395,8 @@ Message-Id: $message_id
 		}
 
 		if (!$smtp) {
-			die "Unable to initialize SMTP properly. Check config and use --smtp-debug. ",
-			    "VALUES: server=$smtp_server ",
+			die __("Unable to initialize SMTP properly. Check config and use --smtp-debug."),
+			    " VALUES: server=$smtp_server ",
 			    "encryption=$smtp_encryption ",
 			    "hello=$smtp_domain",
 			    defined $smtp_server_port ? " port=$smtp_server_port" : "";
@@ -1414,12 +1413,12 @@ Message-Id: $message_id
 			$smtp->datasend("$line") or die $smtp->message;
 		}
 		$smtp->dataend() or die $smtp->message;
-		$smtp->code =~ /250|200/ or die "Failed to send $subject\n".$smtp->message;
+		$smtp->code =~ /250|200/ or die sprintf(__("Failed to send %s\n"), $subject).$smtp->message;
 	}
 	if ($quiet) {
-		printf (($dry_run ? "Dry-" : ""). __("Sent %s\n"), $subject);
+		printf($dry_run ? __("Dry-Sent %s\n") : __("Sent %s\n"), $subject);
 	} else {
-		print (($dry_run ? "Dry-" : ""). __("OK. Log says:\n"));
+		print($dry_run ? __("Dry-OK. Log says:\n") : __("OK. Log says:\n"));
 		if (!file_name_is_absolute($smtp_server)) {
 			print "Server: $smtp_server\n";
 			print "MAIL FROM:<$raw_from>\n";
@@ -1669,7 +1668,7 @@ sub recipients_cmd {
 
 	my @addresses = ();
 	open my $fh, "-|", "$cmd \Q$file\E"
-	    or die "($prefix) Could not execute '$cmd'";
+	    or die sprintf(__("(%s) Could not execute '%s'"), $prefix, $cmd);
 	while (my $address = <$fh>) {
 		$address =~ s/^\s*//g;
 		$address =~ s/\s*$//g;
@@ -1753,10 +1752,11 @@ sub handle_backup {
 	    (substr($file, 0, $lastlen) eq $last) &&
 	    ($suffix = substr($file, $lastlen)) !~ /^[a-z0-9]/i) {
 		if (defined $known_suffix && $suffix eq $known_suffix) {
-			print "Skipping $file with backup suffix '$known_suffix'.\n";
+			printf(__("Skipping %s with backup suffix '%s'.\n"), $file, $known_suffix);
 			$skip = 1;
 		} else {
-			my $answer = ask("Do you really want to send $file? (y|N): ",
+			# TRANSLATORS: please keep "[y|N]" as is.
+			my $answer = ask(sprintf(__("Do you really want to send %s? [y|N]: "), $file),
 					 valid_re => qr/^(?:y|n)/i,
 					 default => 'n');
 			$skip = ($answer ne 'y');
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index 5a75dd5..3f7ac25 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -13,7 +13,7 @@ BEGIN {
 	}
 }
 
-our @EXPORT = qw(__ Q__);
+our @EXPORT = qw(__ __n);
 our @EXPORT_OK = @EXPORT;
 
 sub __bootstrap_locale_messages {
@@ -44,7 +44,7 @@ BEGIN
 	eval {
 		__bootstrap_locale_messages();
 		*__ = \&Locale::Messages::gettext;
-		*Q__ = \&Locale::Messages::ngettext;
+		*__n = \&Locale::Messages::ngettext;
 		1;
 	} or do {
 		# Tell test.pl that we couldn't load the gettext library.
@@ -52,7 +52,7 @@ BEGIN
 
 		# Just a fall-through no-op
 		*__ = sub ($) { $_[0] };
-		*Q__ = sub ($$$) { $_[2] == 1 ? $_[0] : $_[1] };
+		*__n = sub ($$$) { $_[2] == 1 ? $_[0] : $_[1] };
 	};
 }
 
@@ -72,6 +72,8 @@ Git::I18N - Perl interface to Git's Gettext localizations
 
 	printf __("The following error occurred: %s\n"), $error;
 
+	printf __n("commited %d file", "commited %d files", $files), $files;
+
 =head1 DESCRIPTION
 
 Git's internal Perl interface to gettext via L<Locale::Messages>. If
@@ -89,6 +91,9 @@ it.
 L<Locale::Messages>'s gettext function if all goes well, otherwise our
 passthrough fallback function.
 
+=head2 __n($$$)
+L<Locale::Messages>'s ngettext function or passthrough fallback function.
+
 =head1 AUTHOR
 
 E<AElig>var ArnfjE<ouml>rE<eth> Bjarmason <avarab@gmail.com>
diff --git a/t/t0202/test.pl b/t/t0202/test.pl
index 98aa9a3..4101833 100755
--- a/t/t0202/test.pl
+++ b/t/t0202/test.pl
@@ -31,7 +31,7 @@ is_deeply(\@Git::I18N::EXPORT, \@Git::I18N::EXPORT_OK, "sanity: Git::I18N export
 	# more gettext wrapper functions.
 	my %prototypes = (qw(
 		__	$
-		Q__	$$$
+		__n	$$$
 	));
 	while (my ($sub, $proto) = each %prototypes) {
 		is(prototype(\&{"Git::I18N::$sub"}), $proto, "sanity: $sub has a $proto prototype");
@@ -51,10 +51,10 @@ is_deeply(\@Git::I18N::EXPORT, \@Git::I18N::EXPORT_OK, "sanity: Git::I18N export
 	my ($got_singular, $got_plural, $expect_singular, $expect_plural) =
 		(('TEST: 1 file', 'TEST: n files') x 2);
 
-	is(Q__($got_singular, $got_plural, 1), $expect_singular,
-		"Get singular string through Q__() in C locale");
-	is(Q__($got_singular, $got_plural, 2), $expect_plural,
-		"Get plural string through Q__() in C locale");
+	is(__n($got_singular, $got_plural, 1), $expect_singular,
+		"Get singular string through __n() in C locale");
+	is(__n($got_singular, $got_plural, 2), $expect_plural,
+		"Get plural string through __n() in C locale");
 }
 
 # Test a basic message on different locales

-- 
2.7.4

