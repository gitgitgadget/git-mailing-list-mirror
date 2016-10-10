Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_PH_SURBL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 964A720986
	for <e@80x24.org>; Mon, 10 Oct 2016 12:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbcJJMzi (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 08:55:38 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:53677 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751713AbcJJMzg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 08:55:36 -0400
Received: (qmail 10292 invoked from network); 10 Oct 2016 12:55:34 -0000
Received: (qmail 11725 invoked from network); 10 Oct 2016 12:55:32 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 10 Oct 2016 12:55:27 -0000
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
Subject: [PATCH v4 00/14] Mark strings in Perl scripts for translation
Date:   Mon, 10 Oct 2016 12:54:35 +0000
Message-Id: <20161010125449.7929-1-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.10.1.396.g621fe23
MIME-Version: 1.0
In-Reply-To: <20161005172110.30801-1-vascomalmeida@sapo.pt>
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark messages in some perl scripts for translation.

Fix minor stuff and follow Jakub Narębski's suggestion to use N__() instead of
__() in the hash tables.

Interdiff included below.

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
 git-add--interactive.perl | 322 ++++++++++++++++++++++++++++++----------------
 git-difftool.perl         |  22 ++--
 git-send-email.perl       | 176 +++++++++++++------------
 perl/Git/I18N.pm          |  17 ++-
 t/t0202/test.pl           |  14 +-
 7 files changed, 353 insertions(+), 211 deletions(-)


diff --git a/Makefile b/Makefile
index 4ef0344..9dc95cb 100644
--- a/Makefile
+++ b/Makefile
@@ -2112,7 +2112,7 @@ XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
 XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 	--keyword=gettextln --keyword=eval_gettextln
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
-	--keyword=__ --keyword="__n:1,2"
+	--keyword=__ --keyword=N__ --keyword="__n:1,2"
 LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
 LOCALIZED_SH = $(SCRIPT_SH)
 LOCALIZED_SH += git-parse-remote.sh
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 0b4a27c..4754104 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -601,7 +601,7 @@ sub list_and_choose {
 				}
 			}
 			if ($opts->{SINGLETON} && $bottom != $top) {
-				error_msg sprintf(__("Huh (%s)?"), $choice);
+				error_msg sprintf(__("Huh (%s)?\n"), $choice);
 				next TOPLOOP;
 			}
 			for ($i = $bottom-1; $i <= $top-1; $i++) {
@@ -704,7 +704,7 @@ sub revert_cmd {
 				    $_->{INDEX_ADDDEL} eq 'create') {
 					system(qw(git update-index --force-remove --),
 					       $_->{VALUE});
-					print "note: $_->{VALUE} is untracked now.\n";
+					printf(__("note: %s is untracked now.\n"), $_->{VALUE});
 				}
 			}
 		}
@@ -1038,25 +1038,25 @@ sub color_diff {
 }
 
 my %edit_hunk_manually_modes = (
-	stage => __(
+	stage => N__(
 "# If the patch applies cleanly, the edited hunk will immediately be
 # marked for staging."),
-	stash => __(
+	stash => N__(
 "# If the patch applies cleanly, the edited hunk will immediately be
 # marked for stashing."),
-	reset_head => __(
+	reset_head => N__(
 "# If the patch applies cleanly, the edited hunk will immediately be
 # marked for unstaging."),
-	reset_nothead => __(
+	reset_nothead => N__(
 "# If the patch applies cleanly, the edited hunk will immediately be
 # marked for applying."),
-	checkout_index => __(
+	checkout_index => N__(
 "# If the patch applies cleanly, the edited hunk will immediately be
 # marked for discarding"),
-	checkout_head => __(
+	checkout_head => N__(
 "# If the patch applies cleanly, the edited hunk will immediately be
 # marked for discarding."),
-	checkout_nothead => __(
+	checkout_nothead => N__(
 "# If the patch applies cleanly, the edited hunk will immediately be
 # marked for applying."),
 );
@@ -1078,7 +1078,7 @@ sub edit_hunk_manually {
 # To remove '%s' lines, delete them.
 # Lines starting with # will be removed.
 #\n"), $remove_minus, $remove_plus),
-$edit_hunk_manually_modes{$patch_mode}, __(
+__($edit_hunk_manually_modes{$patch_mode}), __(
 # TRANSLATORS: 'it' refers to the patch mentioned in the previous messages.
 " If it does not apply cleanly, you will be given
 # an opportunity to edit again. If all lines of the hunk are removed,
@@ -1192,43 +1192,43 @@ sub edit_hunk_loop {
 }
 
 my %help_patch_modes = (
-	stage => __(
+	stage => N__(
 "y - stage this hunk
 n - do not stage this hunk
 q - quit; do not stage this hunk or any of the remaining ones
 a - stage this hunk and all later hunks in the file
 d - do not stage this hunk or any of the later hunks in the file"),
-	stash => __(
+	stash => N__(
 "y - stash this hunk
 n - do not stash this hunk
 q - quit; do not stash this hunk or any of the remaining ones
 a - stash this hunk and all later hunks in the file
 d - do not stash this hunk or any of the later hunks in the file"),
-	reset_head => __(
+	reset_head => N__(
 "y - unstage this hunk
 n - do not unstage this hunk
 q - quit; do not unstage this hunk or any of the remaining ones
 a - unstage this hunk and all later hunks in the file
 d - do not unstage this hunk or any of the later hunks in the file"),
-	reset_nothead => __(
+	reset_nothead => N__(
 "y - apply this hunk to index
 n - do not apply this hunk to index
 q - quit; do not apply this hunk or any of the remaining ones
 a - apply this hunk and all later hunks in the file
 d - do not apply this hunk or any of the later hunks in the file"),
-	checkout_index => __(
+	checkout_index => N__(
 "y - discard this hunk from worktree
 n - do not discard this hunk from worktree
 q - quit; do not discard this hunk or any of the remaining ones
 a - discard this hunk and all later hunks in the file
 d - do not discard this hunk or any of the later hunks in the file"),
-	checkout_head => __(
+	checkout_head => N__(
 "y - discard this hunk from index and worktree
 n - do not discard this hunk from index and worktree
 q - quit; do not discard this hunk or any of the remaining ones
 a - discard this hunk and all later hunks in the file
 d - do not discard this hunk or any of the later hunks in the file"),
-	checkout_nothead => __(
+	checkout_nothead => N__(
 "y - apply this hunk to index and worktree
 n - do not apply this hunk to index and worktree
 q - quit; do not apply this hunk or any of the remaining ones
@@ -1237,7 +1237,7 @@ d - do not apply this hunk or any of the later hunks in the file"),
 );
 
 sub help_patch_cmd {
-	print colored $help_color, $help_patch_modes{$patch_mode}, "\n", __ <<EOF ;
+	print colored $help_color, __($help_patch_modes{$patch_mode}), "\n", __ <<EOF ;
 g - select a hunk to go to
 / - search for a hunk matching the given regex
 j - leave this hunk undecided, see next undecided hunk
@@ -1303,7 +1303,7 @@ sub patch_update_cmd {
 		@them = @mods;
 	}
 	else {
-		@them = list_and_choose({ PROMPT => 'Patch update',
+		@them = list_and_choose({ PROMPT => __('Patch update'),
 					  HEADER => $status_head, },
 					@mods);
 	}
@@ -1355,39 +1355,39 @@ sub display_hunks {
 
 my %patch_update_prompt_modes = (
 	stage => {
-		mode => __("Stage mode change [y,n,q,a,d,/%s,?]? "),
-		deletion => __("Stage deletion [y,n,q,a,d,/%s,?]? "),
-		hunk => __("Stage this hunk [y,n,q,a,d,/%s,?]? "),
+		mode => N__("Stage mode change [y,n,q,a,d,/%s,?]? "),
+		deletion => N__("Stage deletion [y,n,q,a,d,/%s,?]? "),
+		hunk => N__("Stage this hunk [y,n,q,a,d,/%s,?]? "),
 	},
 	stash => {
-		mode => __("Stash mode change [y,n,q,a,d,/%s,?]? "),
-		deletion => __("Stash deletion [y,n,q,a,d,/%s,?]? "),
-		hunk => __("Stash this hunk [y,n,q,a,d,/%s,?]? "),
+		mode => N__("Stash mode change [y,n,q,a,d,/%s,?]? "),
+		deletion => N__("Stash deletion [y,n,q,a,d,/%s,?]? "),
+		hunk => N__("Stash this hunk [y,n,q,a,d,/%s,?]? "),
 	},
 	reset_head => {
-		mode => __("Unstage mode change [y,n,q,a,d,/%s,?]? "),
-		deletion => __("Unstage deletion [y,n,q,a,d,/%s,?]? "),
-		hunk => __("Unstage this hunk [y,n,q,a,d,/%s,?]? "),
+		mode => N__("Unstage mode change [y,n,q,a,d,/%s,?]? "),
+		deletion => N__("Unstage deletion [y,n,q,a,d,/%s,?]? "),
+		hunk => N__("Unstage this hunk [y,n,q,a,d,/%s,?]? "),
 	},
 	reset_nothead => {
-		mode => __("Apply mode change to index [y,n,q,a,d,/%s,?]? "),
-		deletion => __("Apply deletion to index [y,n,q,a,d,/%s,?]? "),
-		hunk => __("Apply this hunk to index [y,n,q,a,d,/%s,?]? "),
+		mode => N__("Apply mode change to index [y,n,q,a,d,/%s,?]? "),
+		deletion => N__("Apply deletion to index [y,n,q,a,d,/%s,?]? "),
+		hunk => N__("Apply this hunk to index [y,n,q,a,d,/%s,?]? "),
 	},
 	checkout_index => {
-		mode => __("Discard mode change from worktree [y,n,q,a,d,/%s,?]? "),
-		deletion => __("Discard deletion from worktree [y,n,q,a,d,/%s,?]? "),
-		hunk => __("Discard this hunk from worktree [y,n,q,a,d,/%s,?]? "),
+		mode => N__("Discard mode change from worktree [y,n,q,a,d,/%s,?]? "),
+		deletion => N__("Discard deletion from worktree [y,n,q,a,d,/%s,?]? "),
+		hunk => N__("Discard this hunk from worktree [y,n,q,a,d,/%s,?]? "),
 	},
 	checkout_head => {
-		mode => __("Discard mode change from index and worktree [y,n,q,a,d,/%s,?]? "),
-		deletion => __("Discard deletion from index and worktree [y,n,q,a,d,/%s,?]? "),
-		hunk => __("Discard this hunk from index and worktree [y,n,q,a,d,/%s,?]? "),
+		mode => N__("Discard mode change from index and worktree [y,n,q,a,d,/%s,?]? "),
+		deletion => N__("Discard deletion from index and worktree [y,n,q,a,d,/%s,?]? "),
+		hunk => N__("Discard this hunk from index and worktree [y,n,q,a,d,/%s,?]? "),
 	},
 	checkout_nothead => {
-		mode => __("Apply mode change to index and worktree [y,n,q,a,d,/%s,?]? "),
-		deletion => __("Apply deletion to index and worktree [y,n,q,a,d,/%s,?]? "),
-		hunk => __("Apply this hunk to index and worktree [y,n,q,a,d,/%s,?]? "),
+		mode => N__("Apply mode change to index and worktree [y,n,q,a,d,/%s,?]? "),
+		deletion => N__("Apply deletion to index and worktree [y,n,q,a,d,/%s,?]? "),
+		hunk => N__("Apply this hunk to index and worktree [y,n,q,a,d,/%s,?]? "),
 	},
 );
 
@@ -1464,7 +1464,7 @@ sub patch_update_file {
 			print;
 		}
 		print colored $prompt_color,
-			sprintf($patch_update_prompt_modes{$patch_mode}{$hunk[$ix]{TYPE}}, $other);
+			sprintf(__($patch_update_prompt_modes{$patch_mode}{$hunk[$ix]{TYPE}}), $other);
 
 		my $line = prompt_single_character;
 		last unless defined $line;
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index 3f7ac25..32c4568 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -13,7 +13,7 @@ BEGIN {
 	}
 }
 
-our @EXPORT = qw(__ __n);
+our @EXPORT = qw(__ __n N__);
 our @EXPORT_OK = @EXPORT;
 
 sub __bootstrap_locale_messages {
@@ -54,6 +54,8 @@ BEGIN
 		*__ = sub ($) { $_[0] };
 		*__n = sub ($$$) { $_[2] == 1 ? $_[0] : $_[1] };
 	};
+
+	sub N__($) { return shift; }
 }
 
 1;
@@ -74,6 +76,7 @@ Git::I18N - Perl interface to Git's Gettext localizations
 
 	printf __n("commited %d file", "commited %d files", $files), $files;
 
+
 =head1 DESCRIPTION
 
 Git's internal Perl interface to gettext via L<Locale::Messages>. If
@@ -94,6 +97,11 @@ passthrough fallback function.
 =head2 __n($$$)
 L<Locale::Messages>'s ngettext function or passthrough fallback function.
 
+=head2 N__($)
+No-op that only returns its argument. Use this if you want xgettext to
+extract the text to the pot template but do not want to trigger retrival of
+the translation at run time.
+
 =head1 AUTHOR
 
 E<AElig>var ArnfjE<ouml>rE<eth> Bjarmason <avarab@gmail.com>
diff --git a/t/t0202/test.pl b/t/t0202/test.pl
index 4101833..2cbf7b9 100755
--- a/t/t0202/test.pl
+++ b/t/t0202/test.pl
@@ -4,7 +4,7 @@ use lib (split(/:/, $ENV{GITPERLLIB}));
 use strict;
 use warnings;
 use POSIX qw(:locale_h);
-use Test::More tests => 11;
+use Test::More tests => 13;
 use Git::I18N;
 
 my $has_gettext_library = $Git::I18N::__HAS_LIBRARY;
@@ -32,6 +32,7 @@ is_deeply(\@Git::I18N::EXPORT, \@Git::I18N::EXPORT_OK, "sanity: Git::I18N export
 	my %prototypes = (qw(
 		__	$
 		__n	$$$
+		N__	$
 	));
 	while (my ($sub, $proto) = each %prototypes) {
 		is(prototype(\&{"Git::I18N::$sub"}), $proto, "sanity: $sub has a $proto prototype");
@@ -55,6 +56,8 @@ is_deeply(\@Git::I18N::EXPORT, \@Git::I18N::EXPORT_OK, "sanity: Git::I18N export
 		"Get singular string through __n() in C locale");
 	is(__n($got_singular, $got_plural, 2), $expect_plural,
 		"Get plural string through __n() in C locale");
+
+	is(N__($got), $expect, "Passing a string through N__() in the C locale works");
 }
 
 # Test a basic message on different locales
-- 
2.7.4

