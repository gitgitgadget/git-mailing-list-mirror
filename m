From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Sun, 01 Jan 2012 21:55:59 +0100
Message-ID: <4F00C85F.7060401@tu-clausthal.de>
References: <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de> <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de> <7v39c41keo.fsf@alter.siamese.dyndns.org> <7vpqf8z8a6.fsf@alter.siamese.dyndns.org> <4EFB8E78.4090205@tu-clausthal.de> <7vlipwz5xs.fsf@alter.siamese.dyndns.org> <4EFD40CF.8000801@tu-clausthal.de> <20111230135423.GA1684@sigill.intra.peff.net> <4EFDD06A.3010708@tu-clausthal.de> <7v8vlrwzw9.fsf@alter.siamese.dyndns.org> <4F00BAA6.9050104@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 01 21:56:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RhSRr-0005kX-2l
	for gcvg-git-2@lo.gmane.org; Sun, 01 Jan 2012 21:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052Ab2AAU4D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jan 2012 15:56:03 -0500
Received: from poseidon.rz.tu-clausthal.de ([139.174.2.21]:44990 "EHLO
	poseidon.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752969Ab2AAU4A (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Jan 2012 15:56:00 -0500
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 742FB23AC5;
	Sun,  1 Jan 2012 21:55:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=oHsf8k5y7zfBTm8Uo8mvK9ZCUK0=; b=Q4pF8b95olngdKwPikbzf/L+Ld79
	ioPb/ls+qEaVxYpt824DHWRXxWsYiNA8g+Y+mSPi4UE8EfXsVeou4ptW3buaOKCY
	f3E7SgqmXqt5Qd+oJBzw6S9ztN6PJezqb3Rwp98KtCqYWdakfJcYVX8kUsPjfrWC
	APjPTomxGijeh1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=6NBWynd5N+IjUmWaKX0CuNSih2rk6WSazfyub3iXBckJmRKHYysaWKf
	RSgyWqo4X9Uoy2PeiVfV5FI7fYyyOP86HY5o+T61wqcM1Dujnz1QGVrNnj+Y/yYH
	3QJ0GoO3n0weWEMxESmblPUT0moYvq7dmbWwD9wDuU5E6N3mpsHU=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id 469A123AC4;
	Sun,  1 Jan 2012 21:55:59 +0100 (CET)
Received: from [139.174.242.80] (account sstri@tu-clausthal.de [139.174.242.80] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25589880; Sun, 01 Jan 2012 21:55:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <4F00BAA6.9050104@tu-clausthal.de>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187832>

Following you can find my first proposal, based upon patch 1. It's only the
perl part, because I haven't checked out Peffs git_prompt patch(es) and to
avoid double work.

ATM I'm unsure about the 'username' type, but I think it's quite necessary
to make git-svn behave like git-core in case of asking for a username. A type
'userpass' (username and password in one dialog) isn't mentioned here, because
it's not necessary for the git-svn part, but we should also specify/document it
if we want to use it in the future.

Btw. happy new year! ;)

---
 git-svn.perl |   24 +++++++------------
 perl/Git.pm  |   70 ++++++++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 58 insertions(+), 36 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 26d3559..54cf77f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4356,17 +4356,16 @@ sub ssl_server_trust {
 	        map $cert_info->$_, qw(hostname valid_from valid_until
 	                               issuer_dname fingerprint);
 	my $choice;
-prompt:
-	print STDERR $may_save ?
+	my $prompt = $may_save ?
 	      "(R)eject, accept (t)emporarily or accept (p)ermanently? " :
 	      "(R)eject or accept (t)emporarily? ";
-	STDERR->flush;
-	$choice = lc(substr(<STDIN> || 'R', 0, 1));
-	if ($choice =~ /^t$/i) {
+prompt:
+	$choice = lc(substr(Git->prompt($prompt) || 'R', 0, 1));
+	if ($choice eq "t") {
 		$cred->may_save(undef);
-	} elsif ($choice =~ /^r$/i) {
+	} elsif ($choice eq "r") {
 		return -1;
-	} elsif ($may_save && $choice =~ /^p$/i) {
+	} elsif ($may_save && $choice eq "p") {
 		$cred->may_save($may_save);
 	} else {
 		goto prompt;
@@ -4378,10 +4377,7 @@ prompt:
 sub ssl_client_cert {
 	my ($cred, $realm, $may_save, $pool) = @_;
 	$may_save = undef if $_no_auth_cache;
-	print STDERR "Client certificate filename: ";
-	STDERR->flush;
-	chomp(my $filename = <STDIN>);
-	$cred->cert_file($filename);
+	$cred->cert_file(Git->prompt("Client certificate filename: ", 'filename'));
 	$cred->may_save($may_save);
 	$SVN::_Core::SVN_NO_ERROR;
 }
@@ -4404,9 +4400,7 @@ sub username {
 	if (defined $_username) {
 		$username = $_username;
 	} else {
-		print STDERR "Username: ";
-		STDERR->flush;
-		chomp($username = <STDIN>);
+		$username = Git->prompt("Username: ", 'username');
 	}
 	$cred->username($username);
 	$cred->may_save($may_save);
@@ -4415,7 +4409,7 @@ sub username {

 sub _read_password {
 	my ($prompt, $realm) = @_;
-	my $password = Git->prompt($prompt);
+	my $password = Git->prompt($prompt, 'pass');
 	$password;
 }

diff --git a/perl/Git.pm b/perl/Git.pm
index ba9a5f2..17ddf40 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -512,52 +512,80 @@ C<git --html-path>). Useful mostly only internally.
 sub html_path { command_oneline('--html-path') }


-=item prompt ( PROMPT )
+=item prompt ( PROMPT , TYPE )

 Query user C<PROMPT> and return answer from user.

-If an external helper is specified via GIT_ASKPASS or SSH_ASKPASS, it
-is used to interact with the user; otherwise the prompt is given to
-and the answer is read from the terminal.
+If an external helper is specified via GIT_DIALOG, GIT_ASKPASS or
+SSH_ASKPASS, it is used to interact with the user; otherwise the
+prompt is given to and the answer is read from the terminal.
+
+Possible values for C<TYPE>:
+- '' or 'text': prompt for normal text (only GIT_DIALOG)
+- 'username': prompt for username (behaves exactly as 'text', but also
+              uses *_ASKPASS)
+- 'pass': prompt for password, echoing of what is typed is disabled on
+          the terminal, GUI tool shows asterisks.
+- 'filename': prompt for a filename, GUI tool migh provide file chooser
+              (only GIT_DIALOG)

 =cut

 sub prompt {
-	my ($self, $prompt) = _maybe_self(@_);
+	my ($self, $prompt, $type) = _maybe_self(@_);
+	$type = 'text' unless ($type);
+	my $useAskPass = ($type eq 'pass' || $type eq 'username');
 	my $ret;
 	if (!defined $ret) {
-		$ret = _prompt($ENV{'GIT_ASKPASS'}, $prompt);
+		$ret = _promptgitdialog($ENV{'GIT_DIALOG'}, $prompt, $type);
 	}
-	if (!defined $ret) {
-		$ret = _prompt($ENV{'SSH_ASKPASS'}, $prompt);
+	if ($useAskPass && !defined $ret) {
+		$ret = _promptaskpass($ENV{'GIT_ASKPASS'}, $prompt);
+	}
+	if ($useAskPass && !defined $ret) {
+		$ret = _promptaskpass($ENV{'SSH_ASKPASS'}, $prompt);
 	}
 	if (!defined $ret) {
 		$ret = '';
 		print STDERR $prompt;
 		STDERR->flush;
-		require Term::ReadKey;
-		Term::ReadKey::ReadMode('noecho');
-		while (defined(my $key = Term::ReadKey::ReadKey(0))) {
-			last if $key =~ /[\012\015]/; # \n\r
-			$ret .= $key;
+		if ($type eq 'pass') {
+			require Term::ReadKey;
+			Term::ReadKey::ReadMode('noecho');
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

-sub _prompt {
+sub _promptgitdialog {
+	my ($gitdialog, $prompt, $type) = @_;
+	return undef unless ($askpass);
+	my $ret;
+	open my $fh, "-|", $gitdialog, $type, $prompt
+		or return undef;
+	$ret = <$fh>;
+	$ret =~ s/\r?\n$//; # strip \r\n, chomp does not work on all systems (i.e. windows) as expected
+	close ($fh);
+	return $ret;
+}
+
+sub _promptaskpass {
 	my ($askpass, $prompt) = @_;
-	unless ($askpass) {
-		return undef;
-	}
+	return undef unless ($askpass);
 	my $ret;
 	open my $fh, "-|", $askpass, $prompt
 		or return undef;
 	$ret = <$fh>;
-	$ret =~ s/[\012\015]//g; # \n\r
+	$ret =~ s/\r?\n$//; # strip \r\n, chomp does not work on all systems (i.e. windows) as expected
 	close ($fh);
 	return $ret;
 }
-- 

-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
