Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F96B1F744
	for <e@80x24.org>; Tue, 21 Jun 2016 11:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbcFULqV (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 07:46:21 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:47676 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752125AbcFULqS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 07:46:18 -0400
Received: (qmail 29279 invoked from network); 21 Jun 2016 11:46:14 -0000
Received: (qmail 6208 invoked from network); 21 Jun 2016 11:46:14 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 21 Jun 2016 11:46:09 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 09/11] i18n: send-email: mark warnings and errors for translation
Date:	Tue, 21 Jun 2016 11:44:11 +0000
Message-Id: <20160621114413.9467-9-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.9.0.47.g9ba0c31
In-Reply-To: <20160621114413.9467-1-vascomalmeida@sapo.pt>
References: <20160621114413.9467-1-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Mark warnings, errors and other messages for translation.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-send-email.perl | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2521832..e7f712e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -118,20 +118,20 @@ sub format_2822_time {
 	my $localmin = $localtm[1] + $localtm[2] * 60;
 	my $gmtmin = $gmttm[1] + $gmttm[2] * 60;
 	if ($localtm[0] != $gmttm[0]) {
-		die "local zone differs from GMT by a non-minute interval\n";
+		die __("local zone differs from GMT by a non-minute interval\n");
 	}
 	if ((($gmttm[6] + 1) % 7) == $localtm[6]) {
 		$localmin += 1440;
 	} elsif ((($gmttm[6] - 1) % 7) == $localtm[6]) {
 		$localmin -= 1440;
 	} elsif ($gmttm[6] != $localtm[6]) {
-		die "local time offset greater than or equal to 24 hours\n";
+		die __("local time offset greater than or equal to 24 hours\n");
 	}
 	my $offset = $localmin - $gmtmin;
 	my $offhour = $offset / 60;
 	my $offmin = abs($offset % 60);
 	if (abs($offhour) >= 24) {
-		die ("local time offset greater than or equal to 24 hours\n");
+		die __("local time offset greater than or equal to 24 hours\n");
 	}
 
 	return sprintf("%s, %2d %s %d %02d:%02d:%02d %s%02d%02d",
@@ -199,13 +199,13 @@ sub do_edit {
 		map {
 			system('sh', '-c', $editor.' "$@"', $editor, $_);
 			if (($? & 127) || ($? >> 8)) {
-				die("the editor exited uncleanly, aborting everything");
+				die(__("the editor exited uncleanly, aborting everything"));
 			}
 		} @_;
 	} else {
 		system('sh', '-c', $editor.' "$@"', $editor, @_);
 		if (($? & 127) || ($? >> 8)) {
-			die("the editor exited uncleanly, aborting everything");
+			die(__("the editor exited uncleanly, aborting everything"));
 		}
 	}
 }
@@ -299,7 +299,7 @@ my $help;
 my $rc = GetOptions("h" => \$help,
                     "dump-aliases" => \$dump_aliases);
 usage() unless $rc;
-die "--dump-aliases incompatible with other options\n"
+die __("--dump-aliases incompatible with other options\n")
     if !$help and $dump_aliases and @ARGV;
 $rc = GetOptions(
 		    "sender|from=s" => \$sender,
@@ -362,7 +362,7 @@ unless ($rc) {
     usage();
 }
 
-die "Cannot run git format-patch from outside a repository\n"
+die __("Cannot run git format-patch from outside a repository\n")
 	if $format_patch and not $repo;
 
 # Now, let's fill any that aren't set in with defaults:
@@ -617,7 +617,7 @@ while (defined(my $f = shift @ARGV)) {
 }
 
 if (@rev_list_opts) {
-	die "Cannot run git format-patch from outside a repository\n"
+	die __("Cannot run git format-patch from outside a repository\n")
 		unless $repo;
 	push @files, $repo->command('format-patch', '-o', tempdir(CLEANUP => 1), @rev_list_opts);
 }
@@ -636,7 +636,7 @@ if (@files) {
 		print $_,"\n" for (@files);
 	}
 } else {
-	print STDERR "\nNo patch files specified!\n\n";
+	print STDERR __("\nNo patch files specified!\n\n");
 	usage();
 }
 
@@ -728,7 +728,7 @@ EOT
 			$sender = $1;
 			next;
 		} elsif (/^(?:To|Cc|Bcc):/i) {
-			print "To/Cc/Bcc fields are not interpreted yet, they have been ignored\n";
+			print __("To/Cc/Bcc fields are not interpreted yet, they have been ignored\n");
 			next;
 		}
 		print $c2 $_;
@@ -737,7 +737,7 @@ EOT
 	close $c2;
 
 	if ($summary_empty) {
-		print "Summary email is empty, skipping it\n";
+		print __("Summary email is empty, skipping it\n");
 		$compose = -1;
 	}
 } elsif ($annotate) {
@@ -1313,7 +1313,7 @@ Message-Id: $message_id
 		$_ = ask(__("Send this email? ([y]es|[n]o|[q]uit|[a]ll): "),
 		         valid_re => qr/^(?:yes|y|no|n|quit|q|all|a)/i,
 		         default => $ask_default);
-		die "Send this email reply required" unless defined $_;
+		die __("Send this email reply required") unless defined $_;
 		if (/^n/i) {
 			return 0;
 		} elsif (/^q/i) {
@@ -1339,7 +1339,7 @@ Message-Id: $message_id
 	} else {
 
 		if (!defined $smtp_server) {
-			die "The required SMTP server is not properly defined."
+			die __("The required SMTP server is not properly defined.")
 		}
 
 		if ($smtp_encryption eq 'ssl') {
@@ -1410,7 +1410,7 @@ Message-Id: $message_id
 		$smtp->code =~ /250|200/ or die "Failed to send $subject\n".$smtp->message;
 	}
 	if ($quiet) {
-		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
+		printf (($dry_run ? "Dry-" : ""). __("Sent %s\n"), $subject);
 	} else {
 		print (($dry_run ? "Dry-" : ""). __("OK. Log says:\n"));
 		if (!file_name_is_absolute($smtp_server)) {
@@ -1424,10 +1424,10 @@ Message-Id: $message_id
 		}
 		print $header, "\n";
 		if ($smtp) {
-			print "Result: ", $smtp->code, ' ',
+			print __("Result: "), $smtp->code, ' ',
 				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
 		} else {
-			print "Result: OK\n";
+			print __("Result: OK\n");
 		}
 	}
 
@@ -1700,7 +1700,7 @@ sub apply_transfer_encoding {
 	$message = MIME::Base64::decode($message)
 		if ($from eq 'base64');
 
-	die "cannot send message as 7bit"
+	die __("cannot send message as 7bit")
 		if ($to eq '7bit' and $message =~ /[^[:ascii:]]/);
 	return $message
 		if ($to eq '7bit' or $to eq '8bit');
@@ -1708,7 +1708,7 @@ sub apply_transfer_encoding {
 		if ($to eq 'quoted-printable');
 	return MIME::Base64::encode($message, "\n")
 		if ($to eq 'base64');
-	die "invalid transfer encoding";
+	die __("invalid transfer encoding");
 }
 
 sub unique_email_list {
-- 
2.6.6

