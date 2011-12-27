From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: [PATCH 5/5] make askpass_prompt a global prompt method for asking
 users
Date: Tue, 27 Dec 2011 17:07:52 +0100
Message-ID: <4EF9ED58.8080205@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 27 17:08:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfZZG-00069v-D8
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 17:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641Ab1L0QHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 11:07:54 -0500
Received: from poseidon.rz.tu-clausthal.de ([139.174.2.21]:24419 "EHLO
	poseidon.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754106Ab1L0QHx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Dec 2011 11:07:53 -0500
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 2897429A809;
	Tue, 27 Dec 2011 17:07:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=6Y6elapPWMsRwF8fJGfrv856W0E=; b=EVIQkiLxwENCH1ni8SiC86KSczLf
	2zwolq2Ur/pH6CBA4EDQ/E8h0ufybXsGeubSupN3B/dD/0zJyRbc1IIk542Ayo05
	cgB9wkuL5fcszuoqa3uCwNVMOQq8OMKqK73XMajR5xHk/hL+KEfw2mO/IegLREYv
	8f/L09djjIhx1ko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=pBjw94oJthnTyTumxdmP/Ptb+IS1FFKZNedyML9EW7IKm8lOxLnJmzz
	C/CR+AnTELR9SFZRydUNwKQFYrmXFE9xZuSyQl6ZVll0qPcyptj3UFWt1wPPOyKB
	8WCh+tSVfoyprKoVPUIU/gfbEQeEWYjs5u3GoJJ96iNHgO7EZijU=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id E6B6C29A808;
	Tue, 27 Dec 2011 17:07:51 +0100 (CET)
Received: from [91.4.99.60] (account sstri@tu-clausthal.de HELO [192.168.178.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25242591; Tue, 27 Dec 2011 17:07:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <4EF9EBF4.7070200@tu-clausthal.de>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187721>


Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 git-svn.perl |   37 ++++---------------------------------
 perl/Git.pm  |   43 +++++++++++++++++++++++++++++++------------
 2 files changed, 35 insertions(+), 45 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 2c99aaa..1f30dc2 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4360,12 +4360,7 @@ prompt:
 	my $options = $may_save ?
 	      "(R)eject, accept (t)emporarily or accept (p)ermanently? " :
 	      "(R)eject or accept (t)emporarily? ";
-	$choice = Git->askpass_prompt("Certificate unknown. " . $options);
-	if (!defined $choice) {
-		print STDERR $options;
-		STDERR->flush;
-		$choice = lc(substr(<STDIN> || 'R', 0, 1));
-	}
+	$choice = substr(Git->prompt("Certificate unknown. " . $options) || 'R', 0, 1);
 	if ($choice =~ /^t$/i) {
 		$cred->may_save(undef);
 	} elsif ($choice =~ /^r$/i) {
@@ -4382,13 +4377,7 @@ prompt:
 sub ssl_client_cert {
 	my ($cred, $realm, $may_save, $pool) = @_;
 	$may_save = undef if $_no_auth_cache;
-	my $filename = Git->askpass_prompt("Client certificate filename:");
-	if (!defined $filename) {
-		print STDERR "Client certificate filename: ";
-		STDERR->flush;
-		chomp($filename = <STDIN>);
-	}
-	$cred->cert_file($filename);
+	$cred->cert_file(Git->prompt("Client certificate filename: "));
 	$cred->may_save($may_save);
 	$SVN::_Core::SVN_NO_ERROR;
 }
@@ -4411,12 +4400,7 @@ sub username {
 	if (defined $_username) {
 		$username = $_username;
 	} else {
-		$username = Git->askpass_prompt("Username");
-	}
-	if (!defined $username) {
-		print STDERR "Username: ";
-		STDERR->flush;
-		chomp($username = <STDIN>);
+		$username = Git->prompt("Username: ");
 	}
 	$cred->username($username);
 	$cred->may_save($may_save);
@@ -4425,20 +4409,7 @@ sub username {

 sub _read_password {
 	my ($prompt, $realm) = @_;
-	my $password = Git->askpass_prompt($prompt);;
-	if (!defined $password) {
-		print STDERR $prompt;
-		STDERR->flush;
-		require Term::ReadKey;
-		Term::ReadKey::ReadMode('noecho');
-		while (defined(my $key = Term::ReadKey::ReadKey(0))) {
-			last if $key =~ /[\012\015]/; # \n\r
-			$password .= $key;
-		}
-		Term::ReadKey::ReadMode('restore');
-		print STDERR "\n";
-		STDERR->flush;
-	}
+	my $password = Git->prompt($prompt, 1);
 	$password;
 }

diff --git a/perl/Git.pm b/perl/Git.pm
index c6b3e11..acc00b4 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -58,7 +58,7 @@ require Exporter;
                 command_output_pipe command_input_pipe command_close_pipe
                 command_bidi_pipe command_close_bidi_pipe
                 version exec_path html_path hash_object git_cmd_try
-                remote_refs askpass_prompt
+                remote_refs prompt
                 temp_acquire temp_release temp_reset temp_path);


@@ -512,30 +512,49 @@ C<git --html-path>). Useful mostly only internally.
 sub html_path { command_oneline('--html-path') }


-=item askpass_prompt ( PROMPT)
+=item prompt ( PROMPT , ISPASSWORD )

-Asks user using *_ASKPASS programs and return answer from user.
+Asks user using *_ASKPASS programs or terminal the prompt C<PROMPT> and return answer from user.

 Checks if GIT_ASKPASS or SSH_ASKPASS is set, and use first matching for querying
 user and returns answer.

 If no *_ASKPASS variable is set, the variable is empty or an error occours,
-it returns undef and the caller has to ask the user (e.g. on terminal).
+the querying the user using terminal is tried. If C<ISPASSWORD> is set and true,
+the terminal disables echo.

 =cut

-sub askpass_prompt {
-	my ($self, $prompt) = _maybe_self(@_);
+sub prompt {
+	my ($self, $prompt, $isPassword) = _maybe_self(@_);
+	my $ret;
 	if (exists $ENV{'GIT_ASKPASS'}) {
-		return _askpass_prompt($ENV{'GIT_ASKPASS'}, $prompt);
-	} elsif (exists $ENV{'SSH_ASKPASS'}) {
-		return _askpass_prompt($ENV{'SSH_ASKPASS'}, $prompt);
-	} else {
-		return undef;
+		$ret = _prompt($ENV{'GIT_ASKPASS'}, $prompt);
 	}
+	if (!defined $ret && exists $ENV{'SSH_ASKPASS'}) {
+		$ret = _prompt($ENV{'SSH_ASKPASS'}, $prompt);
+	}
+	if (!defined $ret) {
+		print STDERR $prompt;
+		STDERR->flush;
+		if (defined $isPassword && $isPassword) {
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
+		}
+	}
+	return $ret;
 }

-sub _askpass_prompt {
+sub _prompt {
 	my ($self, $askpass, $prompt) = _maybe_self(@_);
 	unless ($askpass) {
 		return undef;
-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
