From: Robert Richter <robert.richter@amd.com>
Subject: [PATCH] git-send-email: add option for output in mbox format
Date: Fri, 16 May 2008 17:23:20 +0200
Message-ID: <20080516152320.803658050@erda.amd.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 17:24:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx1nJ-0006lu-BU
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 17:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761231AbYEPPXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 11:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761166AbYEPPXg
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 11:23:36 -0400
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]:28171 "EHLO
	WA4EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1761117AbYEPPXe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2008 11:23:34 -0400
Received: from mail126-wa4-R.bigfish.com (10.8.14.250) by
 WA4EHSOBE001.bigfish.com (10.8.40.21) with Microsoft SMTP Server id
 8.1.240.5; Fri, 16 May 2008 15:23:29 +0000
Received: from mail126-wa4 (localhost.localdomain [127.0.0.1])	by
 mail126-wa4-R.bigfish.com (Postfix) with ESMTP id 02472195066F	for
 <git@vger.kernel.org>; Fri, 16 May 2008 15:23:30 +0000 (UTC)
X-BigFish: VP
Received: by mail126-wa4 (MessageSwitch) id 1210951408779462_11206; Fri, 16
 May 2008 15:23:28 +0000 (UCT)
Received: from ausb3extmailp02.amd.com (ausb3extmailp02.amd.com
 [163.181.251.22])	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)	by mail126-wa4.bigfish.com (Postfix) with
 ESMTP id 5FF35BE8074	for <git@vger.kernel.org>; Fri, 16 May 2008 15:23:28
 +0000 (UTC)
Received: from ausb3twp01.amd.com ([163.181.250.37])	by
 ausb3extmailp02.amd.com (Switch-3.2.7/Switch-3.2.7) with ESMTP id
 m4GFTnjM001131	for <git@vger.kernel.org>; Fri, 16 May 2008 10:29:53 -0500
X-WSS-ID: 0K0YW2R-01-KDS-01
Received: from sausexbh1.amd.com (sausexbh1.amd.com [163.181.22.101])	by
 ausb3twp01.amd.com (Tumbleweed MailGate 3.5.1) with ESMTP id 21E0B49C029	for
 <git@vger.kernel.org>; Fri, 16 May 2008 10:23:15 -0500 (CDT)
Received: from sausexmb4.amd.com ([163.181.3.15]) by sausexbh1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Fri, 16 May 2008 10:23:22 -0500
Received: from SDRSEXMB1.amd.com ([172.20.3.116]) by sausexmb4.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Fri, 16 May 2008 10:23:22 -0500
Received: from erda.amd.com ([165.204.85.17]) by SDRSEXMB1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Fri, 16 May 2008 17:23:20 +0200
Received: by erda.amd.com (Postfix, from userid 35569)	id 803658050; Fri, 16
 May 2008 17:23:20 +0200 (CEST)
X-OriginalArrivalTime: 16 May 2008 15:23:20.0646 (UTC) FILETIME=[C6007660:01C8B768]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82304>

This patch adds an option for output in mbox format. Instead of
sending, all messages are printed to standard out in mbox format.

Example:

git-send-email --mbox --compose --no-chain-reply-to patches > patches.mbox

Signed-off-by: Robert Richter <robert.richter@amd.com>
---
 Documentation/git-send-email.txt |    4 ++
 git-send-email.perl              |   57 ++++++++++++++++++++++++++++++++------
 2 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 9d0a10c..1f1a06f 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -81,6 +81,10 @@ The --cc option must be repeated for each user you want on the cc list.
 	values in the 'sendemail' section. The default identity is
 	the value of 'sendemail.identity'.
 
+--mbox::
+	Print all messages to the standard output in mbox format,
+	instead of sending each one.
+
 --smtp-server::
 	If set, specifies the outgoing SMTP server to use (e.g.
 	`smtp.example.com` or a raw IP address).  Alternatively it can
diff --git a/git-send-email.perl b/git-send-email.perl
index 1e1d986..48ac994 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -7,6 +7,8 @@
 #
 # Ported to support git "mbox" format files by Ryan Anderson <ryan@michonline.com>
 #
+# Support of mbox output format by Robert Richter <robert.richter@amd.com>
+#
 # Sends a collection of emails to the given email addresses, disturbingly fast.
 #
 # Supports two formats:
@@ -74,6 +76,9 @@ Options:
    --identity     The configuration identity, a subsection to prioritise over
                   the default section.
 
+   --mbox         Print all messages to the standard output in mbox format,
+                  instead of sending each one.
+
    --smtp-server  If set, specifies the outgoing SMTP server to use.
                   Defaults to localhost.  Port number can be specified here with
                   hostname:port format or by using --smtp-server-port option.
@@ -149,6 +154,12 @@ sub format_2822_time {
 		       );
 }
 
+sub format_2822_to_ctime {
+	my $date = shift;
+	$date =~ s/(\w{3}), (\d{2}) (\w{3}) (\d{4}) (\d\d:\d\d:\d\d)/$1 $3 $2 $5 $4/;
+	return $date;
+}
+
 my $have_email_valid = eval { require Email::Valid; 1 };
 my $smtp;
 my $auth;
@@ -180,7 +191,7 @@ if ($@) {
 }
 
 # Behavior modification variables
-my ($quiet, $dry_run) = (0, 0);
+my ($mbox, $quiet, $dry_run) = (0, 0, 0);
 
 # Variables with corresponding config settings
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
@@ -244,6 +255,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "cc=s" => \@initial_cc,
 		    "bcc=s" => \@bcclist,
 		    "chain-reply-to!" => \$chain_reply_to,
+		    "mbox" => \$mbox,
 		    "smtp-server=s" => \$smtp_server,
 		    "smtp-server-port=s" => \$smtp_server_port,
 		    "smtp-user=s" => \$smtp_authuser,
@@ -408,7 +420,7 @@ if (!$no_validate) {
 }
 
 if (@files) {
-	unless ($quiet) {
+	unless ($quiet || $mbox) {
 		print $_,"\n" for (@files);
 	}
 } else {
@@ -427,7 +439,7 @@ if (!defined $sender) {
 	}
 
 	$sender = $_ if ($_);
-	print "Emails will be sent from: ", $sender, "\n";
+	print ("Emails will be sent from: ", $sender, "\n") unless $mbox;
 	$prompting++;
 }
 
@@ -512,8 +524,20 @@ GIT: for the patch you are writing.
 EOT
 	close(C);
 
+	# Open editor in console
 	my $editor = $ENV{GIT_EDITOR} || Git::config(@repo, "core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
+	my ($console, $consoleOUT) = $term->findConsole;
+	open(COPYIN,  "<&STDIN");
+	open(COPYOUT, ">&STDOUT");
+	open(STDIN,   "<$console");
+	open(STDOUT,  ">$consoleOUT");
 	system('sh', '-c', $editor.' "$@"', $editor, $compose_filename);
+	close(STDOUT);
+	close(STDIN);
+	open(STDIN,  "<&COPYIN");
+	open(STDOUT, ">&COPYOUT");
+	close(COPYOUT);
+	close(COPYIN);
 
 	open(C2,">",$compose_filename . ".final")
 		or die "Failed to open $compose_filename.final : " . $!;
@@ -692,7 +716,12 @@ X-Mailer: git-send-email $gitversion
 	unshift (@sendmail_parameters,
 			'-f', $raw_from) if(defined $envelope_sender);
 
-	if ($dry_run) {
+	if ($mbox) {
+		# print to stdout in mbox format
+		printf ("From %s %s\n", $raw_from, format_2822_to_ctime($date));
+		print ("$header\n");
+		print escape_from($message);
+	} elsif ($dry_run) {
 		# We don't want to send the email.
 	} elsif ($smtp_server =~ m#^/#) {
 		my $pid = open my $sm, '|-';
@@ -751,7 +780,10 @@ X-Mailer: git-send-email $gitversion
 		$smtp->dataend() or die $smtp->message;
 		$smtp->ok or die "Failed to send $subject\n".$smtp->message;
 	}
-	if ($quiet) {
+	if ($mbox) {
+		# Nop
+		;
+	} elsif ($quiet) {
 		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
 	} else {
 		print (($dry_run ? "Dry-" : "")."OK. Log says:\n");
@@ -815,7 +847,7 @@ foreach my $t (@files) {
 						next if ($suppress_cc{'cc'});
 					}
 					printf("(mbox) Adding cc: %s from line '%s'\n",
-						$2, $_) unless $quiet;
+						$2, $_) unless ($quiet || $mbox);
 					push @cc, $2;
 				}
 				elsif (/^Content-type:/i) {
@@ -841,7 +873,7 @@ foreach my $t (@files) {
 				$input_format = 'lots';
 				if (@cc == 0 && !$suppress_cc{'cc'}) {
 					printf("(non-mbox) Adding cc: %s from line '%s'\n",
-						$_, $_) unless $quiet;
+						$_, $_) unless ($quiet || $mbox);
 
 					push @cc, $_;
 
@@ -864,7 +896,7 @@ foreach my $t (@files) {
 				next if ($c eq $sender and $suppress_cc{'self'});
 				push @cc, $c;
 				printf("(sob) Adding cc: %s from line '%s'\n",
-					$c, $_) unless $quiet;
+					$c, $_) unless ($quiet || $mbox);
 			}
 		}
 	}
@@ -880,7 +912,7 @@ foreach my $t (@files) {
 			next if ($c eq $sender and $suppress_from);
 			push @cc, $c;
 			printf("(cc-cmd) Adding cc: %s from: '%s'\n",
-				$c, $cc_cmd) unless $quiet;
+				$c, $cc_cmd) unless ($quiet || $mbox);
 		}
 		close F
 			or die "(cc-cmd) failed to close pipe to '$cc_cmd'";
@@ -959,3 +991,10 @@ sub validate_patch {
 	}
 	return undef;
 }
+
+# credits to Mail::Internet
+sub escape_from {
+    my $body = shift;
+    $body =~ s/\A(>*From) />$1 /og;
+    return $body;
+}
-- 
1.5.3.7
