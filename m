From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: [PATCH 3/5] honour *_ASKPASS for querying username and for querying
 further actions like unknown certificates
Date: Tue, 27 Dec 2011 17:07:00 +0100
Message-ID: <4EF9ED24.2040902@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 27 17:07:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfZYR-0002pT-SQ
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 17:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188Ab1L0QHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 11:07:04 -0500
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:40680 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028Ab1L0QHB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 11:07:01 -0500
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 6E502422105;
	Tue, 27 Dec 2011 17:07:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=+fUX/VNGhS2XYR4a/owfXMli690=; b=nkv7updyo8ht6YBAqZsgTK9pLIYn
	ZHPB4XvU9e3FHJlXj8zor7JwMcT3WDXXLJaRWwRfa+e9iMb+UKUmy8aca2gRCcUD
	mZmr7nAHp6SE1xlEovsvjh+HVQCOdtypSHhUaKjEoUF2ZHoTNkI5af7TH4QSId+D
	GgCsD0I76OPbgAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=jPx8Yr3iZmNLJ8d6i3i6FSmJfshQ2zQBS6z0kg1rjt+ULGp9TJps1o8
	oGt0zW2nc/gpgYdK+IuiRTH3AG3RuTPTgTk50QgWvFGCfjyreLWzSyQDkJCjA8VE
	di3oa76NUJfWKgDas/eV8mSxA7jPAxbghn2jWAhbi9IvpHACC/pk=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 216934220F4;
	Tue, 27 Dec 2011 17:07:00 +0100 (CET)
Received: from [91.4.99.60] (account sstri@tu-clausthal.de HELO [192.168.178.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25242405; Tue, 27 Dec 2011 17:07:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <4EF9EBF4.7070200@tu-clausthal.de>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187719>

git-svn reads usernames (and other stuff) from an interactive terminal.
This behavior cause GUIs to hang waiting for git-svn to complete (http://code.google.com/p/tortoisegit/issues/detail?id=967).

Also see commit 56a853b62c0ae7ebaad0a7a0a704f5ef561eb795.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 git-svn.perl |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 25d5da7..2c99aaa 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4357,11 +4357,15 @@ sub ssl_server_trust {
 	                               issuer_dname fingerprint);
 	my $choice;
 prompt:
-	print STDERR $may_save ?
+	my $options = $may_save ?
 	      "(R)eject, accept (t)emporarily or accept (p)ermanently? " :
 	      "(R)eject or accept (t)emporarily? ";
-	STDERR->flush;
-	$choice = lc(substr(<STDIN> || 'R', 0, 1));
+	$choice = Git->askpass_prompt("Certificate unknown. " . $options);
+	if (!defined $choice) {
+		print STDERR $options;
+		STDERR->flush;
+		$choice = lc(substr(<STDIN> || 'R', 0, 1));
+	}
 	if ($choice =~ /^t$/i) {
 		$cred->may_save(undef);
 	} elsif ($choice =~ /^r$/i) {
@@ -4378,9 +4382,12 @@ prompt:
 sub ssl_client_cert {
 	my ($cred, $realm, $may_save, $pool) = @_;
 	$may_save = undef if $_no_auth_cache;
-	print STDERR "Client certificate filename: ";
-	STDERR->flush;
-	chomp(my $filename = <STDIN>);
+	my $filename = Git->askpass_prompt("Client certificate filename:");
+	if (!defined $filename) {
+		print STDERR "Client certificate filename: ";
+		STDERR->flush;
+		chomp($filename = <STDIN>);
+	}
 	$cred->cert_file($filename);
 	$cred->may_save($may_save);
 	$SVN::_Core::SVN_NO_ERROR;
@@ -4404,6 +4411,9 @@ sub username {
 	if (defined $_username) {
 		$username = $_username;
 	} else {
+		$username = Git->askpass_prompt("Username");
+	}
+	if (!defined $username) {
 		print STDERR "Username: ";
 		STDERR->flush;
 		chomp($username = <STDIN>);
-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
