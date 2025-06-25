Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00FA263C9B
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861563; cv=none; b=Rl11CHAwSVnk79o7tIsdOR2z9ZWX5NGgoVt3FqXC9OHG/XitdowQTnbkAb/PFJeO8YUt24nwvnWtaABBNWo/mrGg1QLGK72rRDxUZ013OVLUvcuHjy3m1RyiMTwIOyes6goOuua42wgGk00O484wobUzvgbWby7CKUhJM8IcgMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861563; c=relaxed/simple;
	bh=ZNAmcqspUL+e0xk9UtS/BfqRr6PjoIYOlMXfMcdrMpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNJdS5NyjxRp5C48Bd77TMNCQydEXiciEJ9iCQyWnrgJh7sj0oHW0bMM+qyCvuWvkGqz4tfTUXjMMWt5MnqgyX1RIbBtdCCOMpp+0Gbmbco0CoqaRFeJPlc8FJd63+jwT5JJyqGkST7VmjntHerbl6LbCFovJbYVuzQE7LPlR9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop; spf=pass smtp.mailfrom=guixotic.coop; dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b=si41cxxM; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b="si41cxxM"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <maxim@guixotic.coop>)
	id 1uUR4R-00E57r-QB
	for git@vger.kernel.org; Wed, 25 Jun 2025 16:25:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=guixotic.coop; s=selector1; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From;
	bh=eXaK2I4vr8126utYNSC4NtNipAbeX2y5aaKJnHjTXzo=; b=si41cxxM0FDd8fjK7OlXelgBG/
	o9dFxGualoNXgcyR2/D1b1HbIHy1mdw02ITXzBjrVQNbhbvVCSO55bqMKo8QqXC4cvy1hbQSDOY+d
	6GboK4EJ+kSYh6la8Mn0v0mFtcD1ETpczjN0b6qJAZT21H5Owb/qJPRBW9uAUvYprJL2yuTcYDnWV
	xxG4xySIMP+X4mJapXF9tO45s8sfgPPXAI/YmBV1OKaeAs5N5ey+w93AnxIyVec+Ec2y97Snaid3t
	0EKnW5MbkzQLjJ7Z2e/uPs/8iYpjYGsupK4jkSETvE9nACQV2AUZsIZ1RaYM53wsuAAw25wJPfUtD
	UExW05EQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <maxim@guixotic.coop>)
	id 1uUR4R-0002p4-G9
	for git@vger.kernel.org; Wed, 25 Jun 2025 16:25:51 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1476852)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uUR4M-00317J-LB; Wed, 25 Jun 2025 16:25:47 +0200
From: Maxim Cournoyer <maxim@guixotic.coop>
To: git@vger.kernel.org
Cc: Maxim Cournoyer <maxim@guixotic.coop>
Subject: [PATCH v4 3/3] contrib: better support symbolic port names in git-credential-netrc
Date: Wed, 25 Jun 2025 23:25:11 +0900
Message-ID: <20250625142511.28857-4-maxim@guixotic.coop>
X-Mailer: git-send-email 2.50.0.84.g5fc0c030e3
In-Reply-To: <20250625142511.28857-1-maxim@guixotic.coop>
References: <87ecv8k4y9.fsf@terra.mail-host-address-is-not-set>
 <20250625142511.28857-1-maxim@guixotic.coop>
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
 contrib/credential/netrc/git-credential-netrc.perl | 11 +++++++----
 contrib/credential/netrc/test.pl                   |  8 ++++----
 git-send-email.perl                                | 11 +++++++++++
 perl/Git.pm                                        | 13 +++++++++++++
 t/t9001-send-email.sh                              |  7 +++++++
 5 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/contrib/credential/netrc/git-credential-netrc.perl b/contrib/credential/netrc/git-credential-netrc.perl
index 09d77b4f69..3c0a532d0e 100755
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
+			$num_port = Git::port_num($nentry->{port});
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
index 659e6c588b..d2cf9b717a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -2101,6 +2101,17 @@ sub initialize_modified_loop_vars {
 		}
 	}
 
+	# Validate the SMTP server port, if provided.
+	if (defined $smtp_server_port) {
+		my $port = Git::port_num($smtp_server_port);
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
index 6f47d653ab..090cf77dab 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1061,6 +1061,19 @@ sub _close_cat_blob {
 	delete @$self{@vars};
 }
 
+# Given PORT, a port number or service name, return its numerical
+# value else undef.
+sub port_num {
+    my ($port) = @_;
+
+    # Port can be either a positive integer within the 16-bit range...
+    if ($port =~ /^\d+$/ && $port > 0 && $port <= (2**16 - 1)) {
+        return $port;
+    }
+
+    # ... or a symbolic port (service name).
+    return scalar getservbyname($port, '');
+}
 
 =item credential_read( FILEHANDLE )
 
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 0c1af43f6f..e56e0c8d77 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -201,6 +201,13 @@ test_expect_success $PREREQ 'cc trailer with get_maintainer.pl output' '
 	test_cmp expected-cc commandline1
 '
 
+test_expect_failure $PREREQ 'invalid smtp server port value' '
+	clean_fake_sendmail &&
+	git send-email -1 --to=recipient@example.com \
+		--smtp-server-port=bogus-symbolic-name \
+		--smtp-server="$(pwd)/fake.sendmail"
+'
+
 test_expect_success $PREREQ 'setup expect' "
 cat >expected-show-all-headers <<\EOF
 0001-Second.patch
-- 
2.49.0

