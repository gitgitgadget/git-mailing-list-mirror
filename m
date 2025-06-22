Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B161DE3C8
	for <git@vger.kernel.org>; Sun, 22 Jun 2025 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750605965; cv=none; b=fXNduIMHvOrK+SAq5IFrZckmoDqW+hlLXOHcKO0U7vFCJZAlU0KjaZqNqxzEPAq0U2AQbDaomhibtAdcFd12/lIUarEnNaESsQyMxxnG1OYKroRooHjLat9hwYGaBC517jYFpZmgkdyKQxy9JQ7PpdTNyfdlqzTIBdwMEDE0nxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750605965; c=relaxed/simple;
	bh=OQBJ/to7yNRmwO6q4saz9ptPp4tOS1m4W4iG/Dm9Jkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMMziEWE8PYCHFV3waSNWVZhkCaTbMJ4EGn03uc1qwfjVii9cZn9GUYJN2Rf4QK3dSbsMaedl4dGLXB38zp8Itxpo+ZMsdjVE8s4miyAmIkVS4/Y38c7ES0W9qvQfmDy0sjSkrhboNr1DzjNWXS+t/dctApMGLloKjiRNnQA9fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop; spf=pass smtp.mailfrom=guixotic.coop; dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b=VPGkLPkn; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b="VPGkLPkn"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <maxim@guixotic.coop>)
	id 1uTMZu-005c1e-0z
	for git@vger.kernel.org; Sun, 22 Jun 2025 17:25:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=guixotic.coop; s=selector1; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From;
	bh=2ZMbcEScVHaeWG4H94snpzZjz6OXlQkMgzlTR4bPlEw=; b=VPGkLPknVSFgJ9fG6jo5jpFlQm
	6DOYiz5pub/e2s4fUJ1+pPXwBBaKHOEAxRwpVdk5WXoCm76eZ1hjefFZ+FEJdz9sWVCiIokR+qwih
	5kv9M9djNTKCyXgN1tFDOsIborwQbH8gFTWnl3DqXnZZ9/XWuYXZTaYoSFo5AVAOdxlCHSo+DRxKw
	4wiTM2X2ZKvh99hHiPGiW+V10s/NpmsAPJag9PyzgzlCV0viMtytOKW65+oLEaD4kmCERFhtLgBW4
	pgpRXivUKBTnU91MCq3yNPTzOqr7B4vMr+LSVNQVNSSSbWFakBqtX1qrTIoEmMmUfxoLcSpGPk2Dw
	xax8iYxA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <maxim@guixotic.coop>)
	id 1uTMZt-0000TT-OE
	for git@vger.kernel.org; Sun, 22 Jun 2025 17:25:53 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1476852)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uTMZo-002aWd-7f; Sun, 22 Jun 2025 17:25:48 +0200
From: Maxim Cournoyer <maxim@guixotic.coop>
To: git@vger.kernel.org
Cc: Maxim Cournoyer <maxim@guixotic.coop>
Subject: [PATCH v2 3/3] contrib: better support symbolic port names in git-credential-netrc
Date: Mon, 23 Jun 2025 00:25:35 +0900
Message-ID: <20250622152535.11837-4-maxim@guixotic.coop>
X-Mailer: git-send-email 2.50.0.84.g5dea3a8a86
In-Reply-To: <20250620041239.27839-1-maxim@guixotic.coop>
References: <20250620041239.27839-1-maxim@guixotic.coop>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To improve support for symbolic port names in netrc files, this
changes does the following:

 - Treat symbolic port names as ports, not protocols in git-credential-netrc
 - Validate the SMTP server port provided to send-email
 - Convert the above symbolic port names to their numerical values.

Before this change, it was not possible to have a SMTP server port set
to "smtps" in a netrc file (e.g. Emacs' ~/.authinfo.gpg), as it would
be registered as a protocol and break the match for a "smtp" protocol
host, as queried for by git-send-email.

Signed-off-by: Maxim Cournoyer <maxim@guixotic.coop>
---
 .../credential/netrc/git-credential-netrc.perl    | 11 +++++++----
 contrib/credential/netrc/test.pl                  |  8 ++++----
 git-send-email.perl                               | 11 +++++++++++
 perl/Git.pm                                       | 15 +++++++++++++++
 t/t9001-send-email.sh                             |  7 +++++++
 5 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/contrib/credential/netrc/git-credential-netrc.perl b/contrib/credential/netrc/git-credential-netrc.perl
index 09d77b4f69..72d6b6a974 100755
--- a/contrib/credential/netrc/git-credential-netrc.perl
+++ b/contrib/credential/netrc/git-credential-netrc.perl
@@ -268,13 +268,16 @@ sub load_netrc {
 			next;
 		}
 		if (defined $nentry->{port}) {
-			if ($nentry->{port} =~ m/^\d+$/) {
-				$num_port = $nentry->{port};
-				delete $nentry->{port};
-			} else {
+			$num_port = Git::is_port($nentry->{port});
+			unless ($num_port) {
 				printf(STDERR "ignoring invalid port `%s' " .
 				       "from netrc file\n", $nentry->{port});
 			}
+			# Since we've already validated and converted
+			# the port to its numerical value, do not
+			# capture it as the `protocol' value, as used
+			# to be the case for symbolic port names.
+			delete $nentry->{port};
 		}
 
 		# create the new entry for the credential helper protocol
diff --git a/contrib/credential/netrc/test.pl b/contrib/credential/netrc/test.pl
index 67a0ede564..8a7fc2588a 100755
--- a/contrib/credential/netrc/test.pl
+++ b/contrib/credential/netrc/test.pl
@@ -45,7 +45,7 @@ BEGIN
 diag "Testing with invalid data\n";
 $cred = run_credential(['-f', $netrc, 'get'],
 		       "bad data");
-ok(scalar keys %$cred == 4, "Got first found keys with bad data");
+ok(scalar keys %$cred == 3, "Got first found keys with bad data");
 
 diag "Testing netrc file for a missing corovamilkbar entry\n";
 $cred = run_credential(['-f', $netrc, 'get'],
@@ -64,12 +64,12 @@ BEGIN
 
 diag "Testing netrc file for a username-specific entry\n";
 $cred = run_credential(['-f', $netrc, 'get'],
-		       { host => 'imap', username => 'bob' });
+		       { host => 'imap:993', username => 'bob' });
 
-ok(scalar keys %$cred == 2, "Got 2 username-specific keys");
+# Only the password field gets returned.
+ok(scalar keys %$cred == 1, "Got 1 username-specific keys");
 
 is($cred->{password}, 'bobwillknow', "Got correct user-specific password");
-is($cred->{protocol}, 'imaps', "Got correct user-specific protocol");
 
 diag "Testing netrc file for a host:port-specific entry\n";
 $cred = run_credential(['-f', $netrc, 'get'],
diff --git a/git-send-email.perl b/git-send-email.perl
index 659e6c588b..502c7d9e04 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -2101,6 +2101,17 @@ sub initialize_modified_loop_vars {
 		}
 	}
 
+	# Validate the SMTP server port, if provided.
+	if (defined $smtp_server_port) {
+		my $port = Git::is_port($smtp_server_port);
+		if ($port) {
+			$smtp_server_port = $port;
+		} else  {
+			die sprintf(__("error: invalid SMTP port '%s'\n"),
+				    $smtp_server_port);
+		}
+	}
+
 	# Run the loop once again to avoid gaps in the counter due to FIFO
 	# arguments provided by the user.
 	my $num = 1;
diff --git a/perl/Git.pm b/perl/Git.pm
index 6f47d653ab..1fa535e1ad 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1061,6 +1061,21 @@ sub _close_cat_blob {
 	delete @$self{@vars};
 }
 
+# Predicate to check whether PORT is a valid port number or service
+# name. The numerical value of PORT is returned, else undef if
+# invalid.
+sub is_port {
+    my ($port) = @_;
+
+    # Port can be either a positive integer within the 16-bit range...
+    if ($port =~ /^\d+$/ && $port > 0 && $port <= (2**16 - 1)) {
+        return $port;
+    }
+
+    # ... or a symbolic port (service name).
+    my $num = getservbyname($port, '');
+    return defined $num ? $num : undef;
+}
 
 =item credential_read( FILEHANDLE )
 
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 0c1af43f6f..3e749175ab 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -201,6 +201,13 @@ test_expect_success $PREREQ 'cc trailer with get_maintainer.pl output' '
 	test_cmp expected-cc commandline1
 '
 
+test_expect_failure $PREREQ 'invalid smtp server port value' '
+	clean_fake_sendmail &&
+	git send-email -1 --to=recipient@example.com \
+                --smtp-server-port=bogus-symbolic-name \
+		--smtp-server="$(pwd)/fake.sendmail"
+'
+
 test_expect_success $PREREQ 'setup expect' "
 cat >expected-show-all-headers <<\EOF
 0001-Second.patch
-- 
2.49.0

