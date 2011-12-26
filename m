From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH] honour GIT_ASKPASS for querying username in git-svn
Date: Tue, 27 Dec 2011 00:49:05 +0100
Message-ID: <4EF907F1.1030801@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 27 00:49:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfKIE-00058L-8Y
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 00:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464Ab1LZXtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Dec 2011 18:49:09 -0500
Received: from poseidon.rz.tu-clausthal.de ([139.174.2.21]:59903 "EHLO
	poseidon.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752214Ab1LZXtI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Dec 2011 18:49:08 -0500
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 3D90622916;
	Tue, 27 Dec 2011 00:49:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=Ufu3YOwgS0fd3u2+1D4dtg+MH74=; b=lX1DlLOF3OH2U/wmbiXSlQfB+hs3
	c43J2bIIZpEUAn4GWOQzm/lJCj//f8Y8XBJ7FFA5tgLlns0x5HuJXiwuNZgQZJDr
	XK3/KTKP6C6YSPmT42pkloIbzIcPyfXJmYpKo+gkQfoBtmRuQWnYzB6NetXj2lGB
	uaBhi3bv61CH0N0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=1tJ5RqX6YQbZfzXtc56mDUNCJesB6SsgvZzwcjvvpcbDgv1TyOxBNWD
	iLGIYzUFzhGCQMb8cKRzLq3oJme2jCNQUmaff1FWlCv0AnXSltJb2QhIVmEeh1YI
	Oeom0fEI+h0O4FYolIherpOcjQdDruvrD2MXBFO5OWCrntH9nJko=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id 0FC8A22910;
	Tue, 27 Dec 2011 00:49:05 +0100 (CET)
Received: from [84.132.157.21] (account sstri@tu-clausthal.de HELO [192.168.178.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25229166; Tue, 27 Dec 2011 00:49:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <20111130064401.GC5317@sigill.intra.peff.net>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187702>

Hi,

Am 30.11.2011 07:44 schrieb Jeff King:
> That aside, I think this is an improvement over the current code.
>   1. Regular git will also respect SSH_ASKPASS
>   2. Regular git will ignore an askpass variable that is set but empty.
> Perhaps git-svn should be refactored to have a reusable "prompt"
> function that respects askpass and tries to behave like C git? It could
> even go into the Git perl module.

I honoured all your ideas. Hopefully the patches can be applied now. The new patches
follow (you can also pull from git://github.com/csware/git.git askpass-prompt):

>From b760546c59d1b9982296c19f8eaea6dc225b5a4f Mon Sep 17 00:00:00 2001
From: Sven Strickroth <email@cs-ware.de>
Date: Tue, 27 Dec 2011 00:33:46 +0100
Subject: [PATCH 1/4] add central method for prompting a user using
 GIT_ASKPASS or SSH_ASKPASS

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 perl/Git.pm |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index f7ce511..8176d47 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -58,7 +58,7 @@ require Exporter;
                 command_output_pipe command_input_pipe command_close_pipe
                 command_bidi_pipe command_close_bidi_pipe
                 version exec_path html_path hash_object git_cmd_try
-                remote_refs
+                remote_refs prompt
                 temp_acquire temp_release temp_reset temp_path);


@@ -512,6 +512,35 @@ C<git --html-path>). Useful mostly only internally.
 sub html_path { command_oneline('--html-path') }


+=item prompt ( PROMPT)
+
+Checks if GIT_ASKPASS or SSH_ASKPASS is set, and if yes
+use it and return answer from user.
+
+=cut
+
+sub prompt {
+	my ($self, $prompt) = _maybe_self(@_);
+	if (exists $ENV{'GIT_ASKPASS'}) {
+		return _prompt($ENV{'GIT_ASKPASS'}, $prompt);
+	} elsif (exists $ENV{'SSH_ASKPASS'}) {
+		return _prompt($ENV{'SSH_ASKPASS'}, $prompt);
+	} else {
+		return undef;
+	}
+}
+
+sub _prompt {
+	my ($self, $askpass, $prompt) = _maybe_self(@_);
+	my $ret;
+	open(PH, "-|", $askpass, $prompt);
+	$ret = <PH>;
+	$ret =~ s/[\012\015]//g; # strip \n\r
+	close(PH);
+	return $ret;
+}
+
+
 =item repo_path ()

 Return path to the git repository. Must be called on a repository instance.
-- 
1.7.7.1.msysgit.0

>From ef4c6557d1b0e33440d13c64742d44b2a22143f3 Mon Sep 17 00:00:00 2001
From: Sven Strickroth <email@cs-ware.de>
Date: Tue, 27 Dec 2011 00:34:09 +0100
Subject: [PATCH 2/4] switch to central prompt method

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 git-svn.perl |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index eeb83d3..4fd4eca 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4415,13 +4415,8 @@ sub username {

 sub _read_password {
 	my ($prompt, $realm) = @_;
-	my $password = '';
-	if (exists $ENV{GIT_ASKPASS}) {
-		open(PH, "-|", $ENV{GIT_ASKPASS}, $prompt);
-		$password = <PH>;
-		$password =~ s/[\012\015]//; # \n\r
-		close(PH);
-	} else {
+	my $password = Git->prompt($prompt);;
+	if (!defined $password) {
 		print STDERR $prompt;
 		STDERR->flush;
 		require Term::ReadKey;
-- 
1.7.7.1.msysgit.0

>From d58f41d7b9b8e690c9839f6f7539774da88aa3a4 Mon Sep 17 00:00:00 2001
From: Sven Strickroth <email@cs-ware.de>
Date: Tue, 27 Dec 2011 00:37:43 +0100
Subject: [PATCH 3/4] honour *_ASKPASS for querying username and for querying
 further actions on unknown certificates

git-svn reads usernames (and answers for certificate errors) from an interactive terminal.
This behavior cause GUIs to hang waiting for git-svn to complete (http://code.google.com/p/tortoisegit/issues/detail?id=967).

Also see commit 56a853b62c0ae7ebaad0a7a0a704f5ef561eb795.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 git-svn.perl |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 4fd4eca..b85a7de 100755
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
+	$choice = Git->prompt("Certificate unknown. " . $options);
+	if (!defined $choice) {
+		print STDERR $options;
+		STDERR->flush;
+		$choice = lc(substr(<STDIN> || 'R', 0, 1));
+	}
 	if ($choice =~ /^t$/i) {
 		$cred->may_save(undef);
 	} elsif ($choice =~ /^r$/i) {
@@ -4404,6 +4408,9 @@ sub username {
 	if (defined $_username) {
 		$username = $_username;
 	} else {
+		$username = Git->prompt("Username");
+	}
+	if (!defined $username) {
 		print STDERR "Username: ";
 		STDERR->flush;
 		chomp($username = <STDIN>);
-- 
1.7.7.1.msysgit.0

>From 2c1dbdae8024f28d17abfbdc7e45865a1277151a Mon Sep 17 00:00:00 2001
From: Sven Strickroth <email@cs-ware.de>
Date: Tue, 27 Dec 2011 00:42:07 +0100
Subject: [PATCH 4/4] ignore empty *_ASKPASS variables

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 perl/Git.pm |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 8176d47..fade617 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -532,6 +532,9 @@ sub prompt {

 sub _prompt {
 	my ($self, $askpass, $prompt) = _maybe_self(@_);
+	unless ($askpass) {
+		return undef;
+	}
 	my $ret;
 	open(PH, "-|", $askpass, $prompt);
 	$ret = <PH>;
-- 
1.7.7.1.msysgit.0

-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
