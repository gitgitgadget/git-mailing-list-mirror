From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC 09/10] send-email: Minor cleanup of $smtp_server usage and send_message()
Date: Sat, 11 Apr 2009 14:08:27 -0500
Message-ID: <1239476908-25944-9-git-send-email-mfwitten@gmail.com>
References: <1239476908-25944-1-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-2-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-3-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-4-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-5-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-6-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-7-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-8-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 11 21:19:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsije-0003bn-H1
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758255AbZDKTRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 15:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757590AbZDKTRQ
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:17:16 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:62774 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755642AbZDKTRP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:17:15 -0400
Received: by yx-out-2324.google.com with SMTP id 31so1618315yxl.1
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 12:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=N1I8cXnEojx2oRZpuH3CbFiuxpXLSq+pmUNySh52wCM=;
        b=N+mlRoAmw1jm6xGvJZTz6WDZWT6XYr1xbl/e+/D3k+bvycZ1RVQwmuS3j5Ce7croI6
         45BFWqtt+SX+Y2SAM6i4h26K8w34VXfp1IPapu+fxbTFAlKO29UvOttMWJE9b8Hx85CH
         bKSyjTVxpUa9cPuOHGx7lzTo7JUWiZU03Ftak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Mr/JhMxu8RWSZld3qRyNBurObvDulUmxs5L53ARHx+Ao2EQuZr81erNwOpEdn4oIs4
         98EEJ0QRuZo6DySlsp6qblqWRSt98vJ/OwgK+rqBBfKJUhTtryDe6fnooh1bGbEy8WKh
         zLa0coStT8pdAmKNQZ63bs9ePUEESwN5HPw3w=
Received: by 10.100.242.20 with SMTP id p20mr1082612anh.119.1239477434172;
        Sat, 11 Apr 2009 12:17:14 -0700 (PDT)
Received: from localhost.localdomain (97-116-109-29.mpls.qwest.net [97.116.109.29])
        by mx.google.com with ESMTPS id 9sm5461438ywf.6.2009.04.11.12.17.13
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 11 Apr 2009 12:17:13 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1239476908-25944-8-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116318>

Note that the output has been changed; the server return code
now appears after the `(Sendmail|Server):' line, rather than
after the headers.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |    3 +-
 git-send-email.perl              |   39 +++++++++++++++++++++++--------------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index f0c2e7b..07c831e 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -135,7 +135,8 @@ user is prompted for a password while the input is masked for privacy.
 	be specified by the 'sendemail.smtpserver' configuration
 	option; the built-in default is `/usr/sbin/sendmail` or
 	`/usr/lib/sendmail` if such program is available, or
-	`localhost` otherwise.
+	`127.0.0.1` otherwise. Also, if <host> is the empty string,
+	then a built-in default is used.
 
 --smtp-server-port=<port>::
 	Specifies a port different from the default port (SMTP
diff --git a/git-send-email.perl b/git-send-email.perl
index c26a1b5..e771720 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -196,7 +196,8 @@ sub do_edit {
 
 # Variables with corresponding config settings
 my ($sleep, $thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
-my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption);
+my ($smtp_server, $smtp_server_is_a_command);
+my ($smtp_server_port, $smtp_authuser, $smtp_encryption);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
 my ($validate, $confirm);
 my (@suppress_cc);
@@ -761,14 +762,18 @@ if (defined $initial_reply_to) {
 	$initial_reply_to = "<$initial_reply_to>" if $initial_reply_to ne '';
 }
 
-if (!defined $smtp_server) {
+if (defined $smtp_server and $smtp_server ne '') {
+	$smtp_server_is_a_command = ($smtp_server =~ m{^/});
+} else {
 	foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
 		if (-x $_) {
 			$smtp_server = $_;
+			$smtp_server_is_a_command = 1;
 			last;
 		}
 	}
-	$smtp_server ||= 'localhost'; # could be 127.0.0.1, too... *shrug*
+	$smtp_server_is_a_command = 0;
+	$smtp_server ||= '127.0.0.1';
 }
 
 if ($compose && $compose > 0) {
@@ -977,7 +982,7 @@ X-Mailer: git-send-email $gitversion
 
 	if ($dry_run) {
 		# We don't want to send the email.
-	} elsif ($smtp_server =~ m#^/#) {
+	} elsif ($smtp_server_is_a_command) {
 		my $pid = open my $sm, '|-';
 		defined $pid or die $!;
 		if (!$pid) {
@@ -1053,24 +1058,28 @@ X-Mailer: git-send-email $gitversion
 		$smtp->dataend() or die $smtp->message;
 		$smtp->code =~ /250|200/ or die "Failed to send $subject\n".$smtp->message;
 	}
+
+	print 'Dry-' if $dry_run;
+
 	if ($quiet) {
-		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
+		print "Sent $subject\n";
 	} else {
-		print (($dry_run ? "Dry-" : "")."OK. Log says:\n");
-		if ($smtp_server !~ m#^/#) {
+		print "OK. Log says:\n";
+
+		if ($smtp_server_is_a_command) {
+			print "Sendmail: $smtp_server ".join(' ',@sendmail_parameters)."\n";
+			print "Result: OK\n";
+		} else {
 			print "Server: $smtp_server\n";
+
+			$dry_run and print "Result: OK\n" or
+			print "Result: ", $smtp->code, ' ', ($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
+
 			print "MAIL FROM:<$raw_from>\n";
 			print "RCPT TO:".join(',',(map { "<$_>" } @recipients))."\n";
-		} else {
-			print "Sendmail: $smtp_server ".join(' ',@sendmail_parameters)."\n";
 		}
+
 		print $header, "\n";
-		if ($smtp) {
-			print "Result: ", $smtp->code, ' ',
-				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
-		} else {
-			print "Result: OK\n";
-		}
 	}
 
 	return 1;
-- 
1.6.2.2.479.g2aec
