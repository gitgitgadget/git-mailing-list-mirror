From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3 11/13] send-email: Minor cleanup of $smtp_server usage and send_message()
Date: Mon, 13 Apr 2009 13:23:55 -0500
Message-ID: <1239647037-15381-12-git-send-email-mfwitten@gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-7-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-8-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-9-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-10-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-11-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 20:38:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtR1z-0004Tf-ME
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 20:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbZDMSff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 14:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbZDMSff
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 14:35:35 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:29536 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbZDMSfe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 14:35:34 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2203238rvb.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 11:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bw6ys158FnXH6wNu4O1w/qTx03i9QIzWKyDo/iKOJNw=;
        b=VZ1xcQkBfZfkpC6loRE0eNzzydQDrmPR3rBsYi+weyiVeBfCE1zLVPQr9NV7Pvhnwk
         4RSzckNIDNkEapMPOlP5sWuMllL9eX8n8S8maczafm4VnAl9yCJQppd/Ju7ga3CH1xQv
         1IpA311rpduV1drylXmbDb2MzvgkH6h6fHkik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=a+i9nV/R1nXTfItB6D2mhjDGbeQ6yRB7kbdhQ9cLKXtZ0l2IKB7IjCdy+b8bFfIqAK
         LsiCulPdn8RRzGYO0cmqr14MuIKELT+Swh5ItR7a3ehqEh+NQE1OVIXqYFTpWSQDMUeU
         QrhwfixenioIYvU5TksHdRho5GpISO0cLcxDw=
Received: by 10.114.95.12 with SMTP id s12mr3276768wab.223.1239647734287;
        Mon, 13 Apr 2009 11:35:34 -0700 (PDT)
Received: from localhost.localdomain (97-116-116-167.mpls.qwest.net [97.116.116.167])
        by mx.google.com with ESMTPS id m30sm5963707wag.12.2009.04.13.11.35.32
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 11:35:33 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1239647037-15381-11-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116472>

Note that the output has been changed; the server return code
now appears after the `(Sendmail|Server):' line, rather than
after the headers.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |    8 ++++--
 git-send-email.perl              |   41 ++++++++++++++++++++++++-------------
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 236e578..93cfb34 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -130,9 +130,11 @@ user is prompted for a password while the input is masked for privacy.
 	specify a full pathname of a sendmail-like program instead;
 	the program must support the `-i` option.  Default value can
 	be specified by the 'sendemail.smtpserver' configuration
-	option; the built-in default is `/usr/sbin/sendmail` or
-	`/usr/lib/sendmail` if such program is available, or
-	`localhost` otherwise.
+	variable; the built-in default is `/usr/sbin/sendmail` or
+	`/usr/lib/sendmail` if such a program is available, or
+	`localhost` otherwise. Also, a built-in default is used if
+	<host> is the empty string (for example, if '--smtp-server ""'
+	is specified on the command line).
 
 --smtp-server-port=<port>::
 	Specifies a port different from the default port (SMTP
diff --git a/git-send-email.perl b/git-send-email.perl
index a394663..8ce9d3b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -191,7 +191,8 @@ sub do_edit {
 
 # Variables with corresponding config settings
 my ($sleep, $thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
-my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption);
+my ($smtp_server, $smtp_server_is_a_command);
+my ($smtp_server_port, $smtp_authuser, $smtp_encryption);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
 my ($validate, $confirm);
 my (@suppress_cc);
@@ -753,14 +754,20 @@ if (defined $initial_reply_to) {
 	$initial_reply_to = "<$initial_reply_to>" if $initial_reply_to ne '';
 }
 
-if (!defined $smtp_server) {
+if (defined $smtp_server && $smtp_server ne '') {
+	$smtp_server_is_a_command = ($smtp_server =~ m{^/});
+} else {
+
 	foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
 		if (-x $_) {
 			$smtp_server = $_;
+			$smtp_server_is_a_command = 1;
 			last;
 		}
 	}
-	$smtp_server ||= 'localhost'; # could be 127.0.0.1, too... *shrug*
+
+	$smtp_server = 'localhost'; # 127.0.0.1 is not compatible with IPv6
+	$smtp_server_is_a_command = 0;
 }
 
 if ($compose && $compose > 0) {
@@ -969,7 +976,7 @@ X-Mailer: git-send-email $gitversion
 
 	if ($dry_run) {
 		# We don't want to send the email.
-	} elsif ($smtp_server =~ m#^/#) {
+	} elsif ($smtp_server_is_a_command) {
 		my $pid = open my $sm, '|-';
 		defined $pid or die $!;
 		if (!$pid) {
@@ -1045,24 +1052,28 @@ X-Mailer: git-send-email $gitversion
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
