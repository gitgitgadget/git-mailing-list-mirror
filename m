From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCHv2 5/5] git-send-email: use git credential to obtain password
Date: Thu,  7 Feb 2013 15:01:21 +0100
Message-ID: <0b3c9b66ccb6c8343dafd210b82c7765891d3785.1360242782.git.mina86@mina86.com>
References: <cover.1360242782.git.mina86@mina86.com>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 07 15:02:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3S3M-0005g7-Ew
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 15:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758736Ab3BGOBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 09:01:46 -0500
Received: from mail-ea0-f176.google.com ([209.85.215.176]:49697 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985Ab3BGOBl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 09:01:41 -0500
Received: by mail-ea0-f176.google.com with SMTP id a13so1209040eaa.35
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 06:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=+xwtar54+4LjDHk3hn7vd0+cJl0dzgX0bXgJAEMPCfk=;
        b=YYbfVaw7gTciL65a4fSl1Kh05EMhONkeCeDJtQGNmsarn5cltdP3TLP+DEP53UFUhm
         71K7Z6QcZVwU9IjYYePUxHSmYkipE5EN44qkDgnyFegxjn/Vj/yJyYwK/9sYwe3pOKqN
         FnJ1zc4bo/lhn7MY6LnQCx8MAnMcxQKI8U8UsOGaFhRnmXTwyhSCkFs7tmC04Moj9W9K
         7GGunwr+KHeY2uzyp/lKiF6+QAJPzct8iYanScDzRf506zXTbBC51VX8Hey9rUn8LETn
         q5CQpAWl/7dlg6S6oyAT87xrzDv8Ki0g0sFZZXXYQc3FKktb12QAUm1An3onEHa3Ehey
         HF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=+xwtar54+4LjDHk3hn7vd0+cJl0dzgX0bXgJAEMPCfk=;
        b=a8Quql7+ILD4l+WDfa7E0jaz6Vi04ir55d7fXzIklB6sJyA1kVF5Big7nlH/GHD/fh
         +TVP2rlEmdZoySIqhwKcJ3UadQ8K1yTOA+0OZMA+PmexCsGoRTna1eV9jrB4RYQz2mq4
         QkyE1HeIsDw5apZpkMHzauNgkRnnTYCSTyeA6+bXoVZL4CVIYWUMBZXnEZKzU7kdGFqt
         7xuBLcvqZHyzF7Dhflrv+LDkclwJqR3ZROWZ3LPgc7xpQduy2WmFt6BYENy3JgorU5zU
         8I8NsYI+SncGW7ETcb2H0v9ruuXXtvFlhXT61y52A3G9550DH8sImFto2SY8aKu7suaC
         kupg==
X-Received: by 10.14.2.5 with SMTP id 5mr4348563eee.30.1360245699711;
        Thu, 07 Feb 2013 06:01:39 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:bdef:84b9:750e:31d0])
        by mx.google.com with ESMTPS id f6sm42214479eeo.7.2013.02.07.06.01.38
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Feb 2013 06:01:39 -0800 (PST)
X-Mailer: git-send-email 1.8.1.2.550.g0b3c9b6
In-Reply-To: <cover.1360242782.git.mina86@mina86.com>
In-Reply-To: <cover.1360242782.git.mina86@mina86.com>
References: <cover.1360242782.git.mina86@mina86.com>
X-Gm-Message-State: ALoCoQn+WC4b59H7sZFMQ+RReQnnbXMfkax9CkuwwHyl6gSqxgtMBc+z421AEludaoJcYUH0fPnX7qvATPSzSXcI0WSxo1Dq5+CnS/eTrP2soILL6YkrhGRa05lLdd1uptgrV67fHviq7Mj2LVMkcyxWKKDlAkUsdwy62sfs60x3nq3JoYwAQjfTj6///atmDcQyWlrJIRPI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215697>

From: Michal Nazarewicz <mina86@mina86.com>

If smtp_user is provided but smtp_pass is not, instead of
prompting for password, make git-send-email use git
credential command instead.

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 Documentation/git-send-email.txt |  4 +--
 git-send-email.perl              | 59 +++++++++++++++++++++++-----------------
 2 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 44a1f7c..0cffef8 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -164,8 +164,8 @@ Sending
 Furthermore, passwords need not be specified in configuration files
 or on the command line. If a username has been specified (with
 '--smtp-user' or a 'sendemail.smtpuser'), but no password has been
-specified (with '--smtp-pass' or 'sendemail.smtppass'), then the
-user is prompted for a password while the input is masked for privacy.
+specified (with '--smtp-pass' or 'sendemail.smtppass'), then
+a password is obtained using 'git-credential'.
 
 --smtp-server=<host>::
 	If set, specifies the outgoing SMTP server to use (e.g.
diff --git a/git-send-email.perl b/git-send-email.perl
index be809e5..76bbfc3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1045,6 +1045,39 @@ sub maildomain {
 	return maildomain_net() || maildomain_mta() || 'localhost.localdomain';
 }
 
+# Returns 1 if authentication succeeded or was not necessary
+# (smtp_user was not specified), and 0 otherwise.
+
+sub smtp_auth_maybe {
+	if (!defined $smtp_authuser || $auth) {
+		return 1;
+	}
+
+	# Workaround AUTH PLAIN/LOGIN interaction defect
+	# with Authen::SASL::Cyrus
+	eval {
+		require Authen::SASL;
+		Authen::SASL->import(qw(Perl));
+	};
+
+	# TODO: Authentication may fail not because credentials were
+	# invalid but due to other reasons, in which we should not
+	# reject credentials.
+	$auth = Git::credential({
+		'protocol' => 'smtp',
+		'host' => join(':', $smtp_server, $smtp_server_port),
+		'username' => $smtp_authuser,
+		# if there's no password, "git credential fill" will
+		# give us one, otherwise it'll just pass this one.
+		'password' => $smtp_authpass
+	}, sub {
+		my $cred = shift;
+		return !!$smtp->auth($cred->{'username'}, $cred->{'password'});
+	});
+
+	return $auth;
+}
+
 # Returns 1 if the message was sent, and 0 otherwise.
 # In actuality, the whole program dies when there
 # is an error sending a message.
@@ -1185,31 +1218,7 @@ X-Mailer: git-send-email $gitversion
 			    defined $smtp_server_port ? " port=$smtp_server_port" : "";
 		}
 
-		if (defined $smtp_authuser) {
-			# Workaround AUTH PLAIN/LOGIN interaction defect
-			# with Authen::SASL::Cyrus
-			eval {
-				require Authen::SASL;
-				Authen::SASL->import(qw(Perl));
-			};
-
-			if (!defined $smtp_authpass) {
-
-				system "stty -echo";
-
-				do {
-					print "Password: ";
-					$_ = <STDIN>;
-					print "\n";
-				} while (!defined $_);
-
-				chomp($smtp_authpass = $_);
-
-				system "stty echo";
-			}
-
-			$auth ||= $smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
-		}
+		smtp_auth_maybe or die $smtp->message;
 
 		$smtp->mail( $raw_from ) or die $smtp->message;
 		$smtp->to( @recipients ) or die $smtp->message;
-- 
1.8.1.2.549.g1d13f9f
