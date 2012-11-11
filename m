From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt method
 for querying users
Date: Sun, 11 Nov 2012 17:41:11 +0100
Message-ID: <509FD527.70605@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de> <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de> <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de> <7v39c41keo.fsf@alter.siamese.dyndns.org> <7vpqf8z8a6.fsf@alter.siamese.dyndns.org> <4F00B7F3.1060105@tu-clausthal.de> <4F038E49.9080809@tu-clausthal.de> <7vy5toqqab.fsf@alter.siamese.dyndns.org> <
 50704BB8.1020603@tu-clausthal.de> <7vmwzzqwud.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 17:57:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXaqH-00049k-F4
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 17:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839Ab2KKQ4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 11:56:51 -0500
Received: from mailrelay1.rz.tu-clausthal.de ([139.174.2.42]:30971 "EHLO
	mailrelay1.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751445Ab2KKQ4u (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Nov 2012 11:56:50 -0500
Received: from hades.rz.tu-clausthal.de (mailrelay1.rz.tu-clausthal.de [139.174.2.42])
	by mailrelay1.rz.tu-clausthal.de (Postfix) with ESMTP id B31B742DCEA;
	Sun, 11 Nov 2012 17:41:12 +0100 (CET)
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 4BFE442238B;
	Sun, 11 Nov 2012 17:41:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=FEb2MJto3Mb08m1Y1JtIJD4YeUU=; b=nlW9DDLxRlvJpna3d4EmAEhU+4QL
	QrL1qe3U18driRfyEE8ltY/ZIz6BkBYR6vvYYs0PSFic4R9f8vBn3IF3kd+gzUIf
	+5EgJvWCQ1KHkgvoAw1cm0OxfGbbIBTr/45JNHH+h8so+2Q749rRxb3Lw5huDkSh
	No3kptxa1R8mqHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=t0lrD2XTf9MCtjthg+yfH0bBBJ0Zbp5yYsWL0dhK30zZ5vADYBZjHbj
	8kq/sbZJyFIw+SCvb1gEi6alZwxhrIeywo0wysrNkuCUf1SsyRFbVWoiPC1osilD
	ZJHDZ/hga5j/7b9tQaS09FGhcGRWxX5SoeXkDn/6YWQvvlX6R43s=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 64238422386;
	Sun, 11 Nov 2012 17:41:11 +0100 (CET)
Received: from [91.3.179.231] (account sstri@tu-clausthal.de HELO [192.168.178.22])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.8)
  with ESMTPSA id 40204253; Sun, 11 Nov 2012 17:41:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <7vmwzzqwud.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.5
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (9%, '
 MULTIPLE_RCPTS 0.1, RCVD_FROM_IP_DATE 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODY_SIZE_3000_3999 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, DKIM_SIGNATURE 0, DOMAINKEY_SIG 0, ECARD_KNOWN_DOMAINS 0, __ANY_URI 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_FROM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MOZILLA_USER_AGENT 0, __MULTIPLE_RCPTS_CC_X2 0, __PHISH_SPEAR_ACCOUNT_1 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __URI_NO_WWW 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209405>

git-svn reads usernames and other user queries from an interactive
terminal. This cause GUIs (w/o STDIN connected) to hang waiting forever
for git-svn to complete (http://code.google.com/p/tortoisegit/issues/detail?id=967).

This change extends the Git::prompt helper, so that it can also be used
for non password queries, and makes use of it instead of using
hand-rolled prompt-response code that only works with the interactive
terminal.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 perl/Git.pm            | 28 +++++++++++++++++-----------
 perl/Git/SVN/Prompt.pm | 16 +++++++---------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 0a0fe91..3200f4d 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -511,18 +511,19 @@ C<git --html-path>). Useful mostly only internally.
 
 sub html_path { command_oneline('--html-path') }
 
-=item prompt ( PROMPT )
+=item prompt ( PROMPT , ISPASSWORD  )
 
 Query user C<PROMPT> and return answer from user.
 
 Honours GIT_ASKPASS, SSH_ASKPASS environment variables for querying
 the user. If no *_ASKPASS variable is set or an error occoured,
 the terminal is tried as a fallback.
+If C<ISPASSWORD> is set and true, the terminal disables echo.
 
 =cut
 
 sub prompt {
-	my ($prompt) = @_;
+	my ($prompt, $isPassword) = @_;
 	my $ret;
 	if (exists $ENV{'GIT_ASKPASS'}) {
 		$ret = _prompt($ENV{'GIT_ASKPASS'}, $prompt);
@@ -533,16 +534,20 @@ sub prompt {
 	if (!defined $ret) {
 		print STDERR $prompt;
 		STDERR->flush;
-		require Term::ReadKey;
-		Term::ReadKey::ReadMode('noecho');
-		$ret = '';
-		while (defined(my $key = Term::ReadKey::ReadKey(0))) {
-			last if $key =~ /[\012\015]/; # \n\r
-			$ret .= $key;
+		if (defined $isPassword && $isPassword) {
+			require Term::ReadKey;
+			Term::ReadKey::ReadMode('noecho');
+			$ret = '';
+			while (defined(my $key = Term::ReadKey::ReadKey(0))) {
+				last if $key =~ /[\012\015]/; # \n\r
+				$ret .= $key;
+			}
+			Term::ReadKey::ReadMode('restore');
+			print STDERR "\n";
+			STDERR->flush;
+		} else {
+			chomp($ret = <STDIN>);
 		}
-		Term::ReadKey::ReadMode('restore');
-		print STDERR "\n";
-		STDERR->flush;
 	}
 	return $ret;
 }
@@ -550,6 +555,7 @@ sub prompt {
 sub _prompt {
 	my ($askpass, $prompt) = @_;
 	return unless length $askpass;
+	$prompt =~ s/\n/ /g;
 	my $ret;
 	open my $fh, "-|", $askpass, $prompt or return;
 	$ret = <$fh>;
diff --git a/perl/Git/SVN/Prompt.pm b/perl/Git/SVN/Prompt.pm
index a2cbcc8..74daa7a 100644
--- a/perl/Git/SVN/Prompt.pm
+++ b/perl/Git/SVN/Prompt.pm
@@ -62,16 +62,16 @@ sub ssl_server_trust {
 	                               issuer_dname fingerprint);
 	my $choice;
 prompt:
-	print STDERR $may_save ?
+	my $options = $may_save ?
 	      "(R)eject, accept (t)emporarily or accept (p)ermanently? " :
 	      "(R)eject or accept (t)emporarily? ";
 	STDERR->flush;
-	$choice = lc(substr(<STDIN> || 'R', 0, 1));
-	if ($choice =~ /^t$/i) {
+	$choice = lc(substr(Git::prompt("Certificate problem.\n" . $options) || 'R', 0, 1));
+	if ($choice eq 't') {
 		$cred->may_save(undef);
-	} elsif ($choice =~ /^r$/i) {
+	} elsif ($choice eq 'r') {
 		return -1;
-	} elsif ($may_save && $choice =~ /^p$/i) {
+	} elsif ($may_save && $choice eq 'p') {
 		$cred->may_save($may_save);
 	} else {
 		goto prompt;
@@ -109,9 +109,7 @@ sub username {
 	if (defined $_username) {
 		$username = $_username;
 	} else {
-		print STDERR "Username: ";
-		STDERR->flush;
-		chomp($username = <STDIN>);
+		$username = Git::prompt("Username: ");
 	}
 	$cred->username($username);
 	$cred->may_save($may_save);
@@ -120,7 +118,7 @@ sub username {
 
 sub _read_password {
 	my ($prompt, $realm) = @_;
-	my $password = Git::prompt($prompt);
+	my $password = Git::prompt($prompt, 1);
 	$password;
 }
 
-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
