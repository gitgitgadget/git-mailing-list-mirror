From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: [PATCH 3/3] git-svn, perl/Git.pm: extend and use Git->prompt method
 for querying users
Date: Tue, 18 Dec 2012 01:28:48 +0100
Message-ID: <50CFB8C0.5040107@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de> <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de> <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de> <7v39c41keo.fsf@alter.siamese.dyndns.org> <7vpqf8z8a6.fsf@alter.siamese.dyndns.org> <4F00B7F3.1060105@tu-clausthal.de> <4F038E49.9080809@tu-clausthal.de> <7vy5toqqab.fsf@alter.siamese.dyndns.org> <7vmwzzqwud.fsf@alter.siamese.dyndns.org> <509FD4F6.5050606@gym-oha.de> <50B11AF5.2090701@tu-clausthal.de> <7vtxsdvug3.fsf@alter.siamese.dyndns.org> <50CF4020.4090901@tu-clausthal.de
 > <7vehiol9w2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 01:29:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkl3X-0002Xx-71
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 01:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910Ab2LRA2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 19:28:48 -0500
Received: from mailrelay2.rz.tu-clausthal.de ([139.174.2.43]:20288 "EHLO
	mailrelay2.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753067Ab2LRA2n (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2012 19:28:43 -0500
Received: from poseidon.rz.tu-clausthal.de (poseidon.rz.tu-clausthal.de [139.174.2.21])
	by mailrelay2.rz.tu-clausthal.de (Postfix) with ESMTP id 9BA32289CCA;
	Tue, 18 Dec 2012 01:28:42 +0100 (CET)
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 82360295558;
	Tue, 18 Dec 2012 01:28:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=5gM6K0qtWteusG4X0N4Y/NOiTzY=; b=4rZ8coDUKbLoYeugwJpOJP3CSGsx
	v/DzIp0o21X84U4dKURrnKzAKvwhSrPT97nPkPTpoq4LzbJV7iawCb5BXX+CO2KV
	cwJnq1uGTAhFJqAtk2bze1CVo63q2f0wZoiE4zt6ffajXowzVGfdkvSVr26uF97V
	XobMqMDbFjNh/a4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=4TqMG9NNzrBF9cTIHk+O9bZR326sIsle9en1C1q8k5Nd79WPdImz2yr
	FHS3JDccaKCot7XTPBMrLLS3s0f7ZAPIdVuewff/3PfB9Huu+JXqNi6/H5i+gNH+
	r2PGv8WeoPUXDlsfc9JlcOfWJ0/MiVcuixncyfyR6ZFKSOOAPoUo=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id 31A36295543;
	Tue, 18 Dec 2012 01:28:42 +0100 (CET)
Received: from [139.174.242.80] (account sstri@tu-clausthal.de [139.174.242.80] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.8)
  with ESMTPSA id 41972639; Tue, 18 Dec 2012 01:28:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vehiol9w2.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODY_SIZE_3000_3999 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, DKIM_SIGNATURE 0, DOMAINKEY_SIG 0, ECARD_KNOWN_DOMAINS 0, __ANY_URI 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_FROM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MOZILLA_USER_AGENT 0, __MULTIPLE_RCPTS_CC_X2 0, __PHISH_SPEAR_ACCOUNT_1 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __URI_NO_WWW 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211722>

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
index 8dfca65..931047c 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -511,18 +511,19 @@ C<git --html-path>). Useful mostly only internally.
 
 sub html_path { command_oneline('--html-path') }
 
-=item prompt ( PROMPT )
+=item prompt ( PROMPT , ISPASSWORD  )
 
 Query user C<PROMPT> and return answer from user.
 
 Honours GIT_ASKPASS and SSH_ASKPASS environment variables for querying
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
