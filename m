From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: [PATCH 1/2] git-svn, perl/Git.pm: add central method for prompting
 passwords honoring GIT_ASKPASS and SSH_ASKPASS
Date: Sun, 11 Nov 2012 17:40:51 +0100
Message-ID: <509FD513.4070206@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de> <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de> <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de> <7v39c41keo.fsf@alter.siamese.dyndns.org> <7vpqf8z8a6.fsf@alter.siamese.dyndns.org> <4F00B7F3.1060105@tu-clausthal.de> <4F038E49.9080809@tu-clausthal.de> <7vy5toqqab.fsf@alter.siamese.dyndns.org> <
 50704BB8.1020603@tu-clausthal.de> <7vmwzzqwud.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 17:54:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXao0-00035R-VT
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 17:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821Ab2KKQyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 11:54:31 -0500
Received: from mailrelay2.rz.tu-clausthal.de ([139.174.2.43]:45319 "EHLO
	mailrelay2.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752627Ab2KKQya (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Nov 2012 11:54:30 -0500
X-Greylist: delayed 808 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Nov 2012 11:54:29 EST
Received: from poseidon.rz.tu-clausthal.de (poseidon.rz.tu-clausthal.de [139.174.2.21])
	by mailrelay2.rz.tu-clausthal.de (Postfix) with ESMTP id 47860289D1D;
	Sun, 11 Nov 2012 17:40:52 +0100 (CET)
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 1F89927D9DB;
	Sun, 11 Nov 2012 17:40:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=OmijzX6M8sEC3bnJ56K44xxEVic=; b=OHPnRKgGLFOUE7IJXBPmub6E9brJ
	Efx4x/CpMNUc4hHKeXDVaFiodZiMlSxPAQqb6BS3iA0hDEpotlpyZ8hxe4OWuuh+
	kzH2HoTqzyNaViYkSeeKqrhWiyZrVunye1gMShrnWa/jQvcnArNLlcUCEE7s4+rh
	K8lQx3rQ6cOlURs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=tQSX8SA7OhwgZgV3EJGflK+Fz9zjaWc9smvDxThoygnny/JU9GjYUFX
	cD9o0kuYzN1pP8dykUSoHgL7jIqeIWJN9sDKqlLs5Y3gy7Zabg35DhcH18IQVj57
	vqljWnjsBuPAwXBWU3gmuRTSQEuBU324DLt0P4UsCwmynBQVwgZ0=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id 97E3B24D0F;
	Sun, 11 Nov 2012 17:40:51 +0100 (CET)
Received: from [91.3.179.231] (account sstri@tu-clausthal.de HELO [192.168.178.22])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.8)
  with ESMTPSA id 40204221; Sun, 11 Nov 2012 17:40:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <7vmwzzqwud.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.5
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (9%, '
 MULTIPLE_RCPTS 0.1, RCVD_FROM_IP_DATE 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODY_SIZE_3000_3999 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, DKIM_SIGNATURE 0, DOMAINKEY_SIG 0, ECARD_KNOWN_DOMAINS 0, __ANY_URI 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_FROM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MOZILLA_USER_AGENT 0, __MULTIPLE_RCPTS_CC_X2 0, __PHISH_SPEAR_ACCOUNT_1 0, __SANE_MSGID 0, __TO_MALFORMED_2 0, __URI_NO_WWW 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209401>

git-svn reads passwords from an interactive terminal or by using
GIT_ASKPASS helper tool. But if GIT_ASKPASS environment variable is not
set, git-svn does not try to use SSH_ASKPASS as git-core does. This
cause GUIs (w/o STDIN connected) to hang waiting forever for git-svn to
complete (http://code.google.com/p/tortoisegit/issues/detail?id=967).

Commit 56a853b62c0ae7ebaad0a7a0a704f5ef561eb795 also tried to solve
this issue, but was incomplete as described above.

Instead of using hand-rolled prompt-response code that only works with the
interactive terminal, a reusable prompt() method is introduced in this commit.
This change also adds a fallback to SSH_ASKPASS.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 perl/Git.pm            | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 perl/Git/SVN/Prompt.pm | 20 +-------------------
 2 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 497f420..0a0fe91 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -58,7 +58,7 @@ require Exporter;
                 command_output_pipe command_input_pipe command_close_pipe
                 command_bidi_pipe command_close_bidi_pipe
                 version exec_path html_path hash_object git_cmd_try
-                remote_refs
+                remote_refs prompt
                 temp_acquire temp_release temp_reset temp_path);
 
 
@@ -511,6 +511,52 @@ C<git --html-path>). Useful mostly only internally.
 
 sub html_path { command_oneline('--html-path') }
 
+=item prompt ( PROMPT )
+
+Query user C<PROMPT> and return answer from user.
+
+Honours GIT_ASKPASS, SSH_ASKPASS environment variables for querying
+the user. If no *_ASKPASS variable is set or an error occoured,
+the terminal is tried as a fallback.
+
+=cut
+
+sub prompt {
+	my ($prompt) = @_;
+	my $ret;
+	if (exists $ENV{'GIT_ASKPASS'}) {
+		$ret = _prompt($ENV{'GIT_ASKPASS'}, $prompt);
+	}
+	if (!defined $ret && exists $ENV{'SSH_ASKPASS'}) {
+		$ret = _prompt($ENV{'SSH_ASKPASS'}, $prompt);
+	}
+	if (!defined $ret) {
+		print STDERR $prompt;
+		STDERR->flush;
+		require Term::ReadKey;
+		Term::ReadKey::ReadMode('noecho');
+		$ret = '';
+		while (defined(my $key = Term::ReadKey::ReadKey(0))) {
+			last if $key =~ /[\012\015]/; # \n\r
+			$ret .= $key;
+		}
+		Term::ReadKey::ReadMode('restore');
+		print STDERR "\n";
+		STDERR->flush;
+	}
+	return $ret;
+}
+
+sub _prompt {
+	my ($askpass, $prompt) = @_;
+	return unless length $askpass;
+	my $ret;
+	open my $fh, "-|", $askpass, $prompt or return;
+	$ret = <$fh>;
+	$ret =~ s/[\015\012]//g; # strip \r\n, chomp does not work on all systems (i.e. windows) as expected
+	close ($fh);
+	return $ret;
+}
 
 =item repo_path ()
 
diff --git a/perl/Git/SVN/Prompt.pm b/perl/Git/SVN/Prompt.pm
index 3a6f8af..a2cbcc8 100644
--- a/perl/Git/SVN/Prompt.pm
+++ b/perl/Git/SVN/Prompt.pm
@@ -120,25 +120,7 @@ sub username {
 
 sub _read_password {
 	my ($prompt, $realm) = @_;
-	my $password = '';
-	if (exists $ENV{GIT_ASKPASS}) {
-		open(PH, "-|", $ENV{GIT_ASKPASS}, $prompt);
-		$password = <PH>;
-		$password =~ s/[\012\015]//; # \n\r
-		close(PH);
-	} else {
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
+	my $password = Git::prompt($prompt);
 	$password;
 }
 
-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
