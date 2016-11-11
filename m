Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_PH_SURBL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51D862035F
	for <e@80x24.org>; Fri, 11 Nov 2016 12:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756562AbcKKMp5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 07:45:57 -0500
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:53728 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756324AbcKKMp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 07:45:56 -0500
Received: (qmail 15067 invoked from network); 11 Nov 2016 12:45:54 -0000
Received: (qmail 2090 invoked from network); 11 Nov 2016 12:45:54 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 11 Nov 2016 12:45:54 -0000
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
Subject: [PATCH v6 00/16] Mark strings in Perl scripts for translation
Date:   Fri, 11 Nov 2016 11:45:25 -0100
Message-Id: <20161111124541.8216-1-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.11.0.rc0.33.gec17dab
In-Reply-To: <20161005172110.30801-1-vascomalmeida@sapo.pt>
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark messages in some perl scripts for translation.

Changes in this re-roll v6:
- Change implementation of prefix_lines subroutine to allow arbitrary
  number of strings as arguments.
- Change a few marks for translation hopefully to be easier on the eyes.

Interdiff included below.


Vasco Almeida (16):
  Git.pm: add subroutines for commenting lines
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
  i18n: send-email: mark composing message for translation
  i18n: difftool: mark warnings for translation

 Makefile                  |   3 +-
 builtin/clean.c           |  10 +-
 git-add--interactive.perl | 329 ++++++++++++++++++++++++++++++----------------
 git-difftool.perl         |  22 ++--
 git-send-email.perl       | 191 +++++++++++++++------------
 perl/Git.pm               |  24 ++++
 perl/Git/I18N.pm          |  19 ++-
 t/t0202/test.pl           |  14 +-
 8 files changed, 394 insertions(+), 218 deletions(-)

-- >8 --
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 56e6889..3a6d846 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1068,22 +1068,24 @@ sub edit_hunk_manually {
 	my $fh;
 	open $fh, '>', $hunkfile
 		or die sprintf(__("failed to open hunk edit file for writing: %s"), $!);
-	print $fh Git::comment_lines __("Manual hunk edit mode -- see bottom for a quick guide\n");
+	print $fh Git::comment_lines __("Manual hunk edit mode -- see bottom for a quick guide.\n");
 	print $fh @$oldtext;
 	my $is_reverse = $patch_mode_flavour{IS_REVERSE};
 	my ($remove_plus, $remove_minus) = $is_reverse ? ('-', '+') : ('+', '-');
 	my $comment_line_char = Git::config("core.commentchar") || '#';
-	print $fh Git::comment_lines sprintf(__(
-"---
+	print $fh Git::comment_lines sprintf(__ <<EOF, $remove_minus, $remove_plus, $comment_line_char),
+---
 To remove '%s' lines, make them ' ' lines (context).
 To remove '%s' lines, delete them.
 Lines starting with %s will be removed.
-\n"), $remove_minus, $remove_plus, $comment_line_char) .
-__($edit_hunk_manually_modes{$patch_mode}) ."\n". __(
+EOF
+__($edit_hunk_manually_modes{$patch_mode}),
 # TRANSLATORS: 'it' refers to the patch mentioned in the previous messages.
-"If it does not apply cleanly, you will be given an opportunity to
+__ <<EOF2 ;
+If it does not apply cleanly, you will be given an opportunity to
 edit again.  If all lines of the hunk are removed, then the edit is
-aborted and the hunk is left unchanged.\n");
+aborted and the hunk is left unchanged.
+EOF2
 	close $fh;
 
 	chomp(my $editor = run_cmd_pipe(qw(git var GIT_EDITOR)));
diff --git a/git-send-email.perl b/git-send-email.perl
index bbeb9fb..068d60b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -585,12 +585,13 @@ sub is_format_patch_arg {
 		if (defined($format_patch)) {
 			return $format_patch;
 		}
-		die sprintf(__(
-"File '%s' exists but it could also be the range of commits
+		die sprintf(__ <<EOF, $f, $f);
+File '%s' exists but it could also be the range of commits
 to produce patches for.  Please disambiguate by...
 
-    * Saying \"./%s\" if you mean a file; or
-    * Giving --format-patch option if you mean a range."), $f, $f);
+    * Saying "./%s" if you mean a file; or
+    * Giving --format-patch option if you mean a range.
+EOF
 	} catch Git::Error::Command with {
 		# Not a valid revision.  Treat it as a filename.
 		return 0;
@@ -654,7 +655,7 @@ sub get_patch_subject {
 		return "GIT: $1\n";
 	}
 	close $fh;
-	die sprintf(__("No subject line in %s ?"), $fn);
+	die sprintf(__("No subject line in %s?"), $fn);
 }
 
 if ($compose) {
@@ -697,10 +698,10 @@ EOT3
 	}
 
 	open my $c2, ">", $compose_filename . ".final"
-		or die sprintf(__("Failed to open %s.final : %s"), $compose_filename, $!);
+		or die sprintf(__("Failed to open %s.final: %s"), $compose_filename, $!);
 
 	open $c, "<", $compose_filename
-		or die sprintf(__("Failed to open %s : %s"), $compose_filename, $!);
+		or die sprintf(__("Failed to open %s: %s"), $compose_filename, $!);
 
 	my $need_8bit_cte = file_has_nonascii($compose_filename);
 	my $in_body = 0;
@@ -1304,8 +1305,8 @@ Message-Id: $message_id
 		if ($needs_confirm eq "inform") {
 			$confirm_unconfigured = 0; # squelch this message for the rest of this run
 			$ask_default = "y"; # assume yes on EOF since user hasn't explicitly asked for confirmation
-			print __(
-"    The Cc list above has been expanded by additional
+			print __ <<EOF ;
+    The Cc list above has been expanded by additional
     addresses found in the patch commit message. By default
     send-email prompts before sending whenever this occurs.
     This behavior is controlled by the sendemail.confirm
@@ -1313,7 +1314,9 @@ Message-Id: $message_id
 
     For additional information, run 'git send-email --help'.
     To retain the current behavior, but squelch this message,
-    run 'git config --global sendemail.confirm auto'."), "\n\n";
+    run 'git config --global sendemail.confirm auto'.
+
+EOF
 		}
 		# TRANSLATORS: Make sure to include [y] [n] [q] [a] in your
 		# translation. The program will only accept English input
diff --git a/perl/Git.pm b/perl/Git.pm
index 17be59f..69cd1dd 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1438,19 +1438,20 @@ sub END {
 
 } # %TEMP_* Lexical Context
 
-=item prefix_lines ( PREFIX, STRING )
+=item prefix_lines ( PREFIX, STRING [, STRING... ])
 
 Prefixes lines in C<STRING> with C<PREFIX>.
 
 =cut
 
 sub prefix_lines {
-	my ($prefix, $string) = @_;
+	my $prefix = shift;
+	my $string = join("\n", @_);
 	$string =~ s/^/$prefix/mg;
 	return $string;
 }
 
-=item comment_lines ( STRING )
+=item comment_lines ( STRING [, STRING... ])
 
 Comments lines following core.commentchar configuration.
 
-- >8 --

-- 
2.11.0.rc0.33.gec17dab

