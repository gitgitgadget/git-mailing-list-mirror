Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D1761FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 12:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755713AbcLNM4C (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 07:56:02 -0500
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:56644 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755636AbcLNMzp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 07:55:45 -0500
Received: (qmail 2215 invoked from network); 14 Dec 2016 12:55:43 -0000
Received: (qmail 28108 invoked from network); 14 Dec 2016 12:55:43 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 14 Dec 2016 12:55:43 -0000
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
Subject: [PATCH v7 12/16] i18n: send-email: mark strings for translation
Date:   Wed, 14 Dec 2016 11:54:35 -0100
Message-Id: <20161214125439.8822-13-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.11.0.44.g7d42c6c
In-Reply-To: <20161214125439.8822-1-vascomalmeida@sapo.pt>
References: <20161214125439.8822-1-vascomalmeida@sapo.pt>
In-Reply-To: <20161005172110.30801-1-vascomalmeida@sapo.pt>
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark strings often displayed to the user for translation.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-send-email.perl | 54 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index da81be40c..06e64699b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -28,6 +28,7 @@ use File::Temp qw/ tempdir tempfile /;
 use File::Spec::Functions qw(catfile);
 use Error qw(:try);
 use Git;
+use Git::I18N;
 
 Getopt::Long::Configure qw/ pass_through /;
 
@@ -797,12 +798,12 @@ foreach my $f (@files) {
 }
 
 if (!defined $auto_8bit_encoding && scalar %broken_encoding) {
-	print "The following files are 8bit, but do not declare " .
-		"a Content-Transfer-Encoding.\n";
+	print __("The following files are 8bit, but do not declare " .
+		 "a Content-Transfer-Encoding.\n");
 	foreach my $f (sort keys %broken_encoding) {
 		print "    $f\n";
 	}
-	$auto_8bit_encoding = ask("Which 8bit encoding should I declare [UTF-8]? ",
+	$auto_8bit_encoding = ask(__("Which 8bit encoding should I declare [UTF-8]? "),
 				  valid_re => qr/.{4}/, confirm_only => 1,
 				  default => "UTF-8");
 }
@@ -829,7 +830,7 @@ if (defined $sender) {
 # But it's a no-op to run sanitize_address on an already sanitized address.
 $sender = sanitize_address($sender);
 
-my $to_whom = "To whom should the emails be sent (if anyone)?";
+my $to_whom = __("To whom should the emails be sent (if anyone)?");
 my $prompting = 0;
 if (!@initial_to && !defined $to_cmd) {
 	my $to = ask("$to_whom ",
@@ -859,7 +860,7 @@ sub expand_one_alias {
 
 if ($thread && !defined $initial_reply_to && $prompting) {
 	$initial_reply_to = ask(
-		"Message-ID to be used as In-Reply-To for the first email (if any)? ",
+		__("Message-ID to be used as In-Reply-To for the first email (if any)? "),
 		default => "",
 		valid_re => qr/\@.*\./, confirm_only => 1);
 }
@@ -918,7 +919,10 @@ sub validate_address {
 	my $address = shift;
 	while (!extract_valid_address($address)) {
 		print STDERR "error: unable to extract a valid address from: $address\n";
-		$_ = ask("What to do with this address? ([q]uit|[d]rop|[e]dit): ",
+		# TRANSLATORS: Make sure to include [q] [d] [e] in your
+		# translation. The program will only accept English input
+		# at this point.
+		$_ = ask(__("What to do with this address? ([q]uit|[d]rop|[e]dit): "),
 			valid_re => qr/^(?:quit|q|drop|d|edit|e)/i,
 			default => 'q');
 		if (/^d/i) {
@@ -1293,17 +1297,23 @@ Message-Id: $message_id
 		if ($needs_confirm eq "inform") {
 			$confirm_unconfigured = 0; # squelch this message for the rest of this run
 			$ask_default = "y"; # assume yes on EOF since user hasn't explicitly asked for confirmation
-			print "    The Cc list above has been expanded by additional\n";
-			print "    addresses found in the patch commit message. By default\n";
-			print "    send-email prompts before sending whenever this occurs.\n";
-			print "    This behavior is controlled by the sendemail.confirm\n";
-			print "    configuration setting.\n";
-			print "\n";
-			print "    For additional information, run 'git send-email --help'.\n";
-			print "    To retain the current behavior, but squelch this message,\n";
-			print "    run 'git config --global sendemail.confirm auto'.\n\n";
+			print __ <<EOF ;
+    The Cc list above has been expanded by additional
+    addresses found in the patch commit message. By default
+    send-email prompts before sending whenever this occurs.
+    This behavior is controlled by the sendemail.confirm
+    configuration setting.
+
+    For additional information, run 'git send-email --help'.
+    To retain the current behavior, but squelch this message,
+    run 'git config --global sendemail.confirm auto'.
+
+EOF
 		}
-		$_ = ask("Send this email? ([y]es|[n]o|[q]uit|[a]ll): ",
+		# TRANSLATORS: Make sure to include [y] [n] [q] [a] in your
+		# translation. The program will only accept English input
+		# at this point.
+		$_ = ask(__("Send this email? ([y]es|[n]o|[q]uit|[a]ll): "),
 		         valid_re => qr/^(?:yes|y|no|n|quit|q|all|a)/i,
 		         default => $ask_default);
 		die "Send this email reply required" unless defined $_;
@@ -1405,7 +1415,7 @@ Message-Id: $message_id
 	if ($quiet) {
 		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
 	} else {
-		print (($dry_run ? "Dry-" : "")."OK. Log says:\n");
+		print($dry_run ? __("Dry-OK. Log says:\n") : __("OK. Log says:\n"));
 		if (!file_name_is_absolute($smtp_server)) {
 			print "Server: $smtp_server\n";
 			print "MAIL FROM:<$raw_from>\n";
@@ -1480,13 +1490,13 @@ foreach my $t (@files) {
 				$sauthor = sanitize_address($author);
 				next if $suppress_cc{'author'};
 				next if $suppress_cc{'self'} and $sauthor eq $sender;
-				printf("(mbox) Adding cc: %s from line '%s'\n",
+				printf(__("(mbox) Adding cc: %s from line '%s'\n"),
 					$1, $_) unless $quiet;
 				push @cc, $1;
 			}
 			elsif (/^To:\s+(.*)$/i) {
 				foreach my $addr (parse_address_line($1)) {
-					printf("(mbox) Adding to: %s from line '%s'\n",
+					printf(__("(mbox) Adding to: %s from line '%s'\n"),
 						$addr, $_) unless $quiet;
 					push @to, $addr;
 				}
@@ -1500,7 +1510,7 @@ foreach my $t (@files) {
 					} else {
 						next if ($suppress_cc{'cc'});
 					}
-					printf("(mbox) Adding cc: %s from line '%s'\n",
+					printf(__("(mbox) Adding cc: %s from line '%s'\n"),
 						$addr, $_) unless $quiet;
 					push @cc, $addr;
 				}
@@ -1534,7 +1544,7 @@ foreach my $t (@files) {
 			# So let's support that, too.
 			$input_format = 'lots';
 			if (@cc == 0 && !$suppress_cc{'cc'}) {
-				printf("(non-mbox) Adding cc: %s from line '%s'\n",
+				printf(__("(non-mbox) Adding cc: %s from line '%s'\n"),
 					$_, $_) unless $quiet;
 				push @cc, $_;
 			} elsif (!defined $subject) {
@@ -1557,7 +1567,7 @@ foreach my $t (@files) {
 				next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
 			}
 			push @cc, $c;
-			printf("(body) Adding cc: %s from line '%s'\n",
+			printf(__("(body) Adding cc: %s from line '%s'\n"),
 				$c, $_) unless $quiet;
 		}
 	}
-- 
2.11.0.44.g7d42c6c

