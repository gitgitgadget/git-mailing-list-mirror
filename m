From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCHv4 6/6] git-send-email: use git credential to obtain password
Date: Tue, 12 Feb 2013 15:02:33 +0100
Message-ID: <32bae1f3c7159035ea3fb5f61ab622cbff30293a.1360677646.git.mina86@mina86.com>
References: <cover.1360677646.git.mina86@mina86.com>
Cc: git@vger.kernel.org
To: peff@peff.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 12 15:03:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5GST-0007nR-4w
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 15:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933261Ab3BLODK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 09:03:10 -0500
Received: from mail-ea0-f172.google.com ([209.85.215.172]:43060 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933221Ab3BLODJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 09:03:09 -0500
Received: by mail-ea0-f172.google.com with SMTP id f13so48365eaa.17
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 06:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=nNTy10NJqLifmJIjfqkwm5wr8P7XArvT8TvMBNduk8o=;
        b=cnG+bcpUdViw5EVWcBO2Hop5PvkFV6KCjlO0WPSLrZGn5YKmishk5DFwqXJfFD/jbc
         COk+dr/N+tPxVKTtf5ez/wYZrOyMXaA12awf3z3oBKp37ONRqyjOlg0pm1ixZ/7DCKxk
         T80XGpqwJ5CSeR2s+EStxvm1gVEMwZjfbOU+TLSEhzhUDBgT4HFJ5U4R+vLSWUYnHnxg
         xYnjTqFMYG+I61FGN2ZxLG4v8H2YW/0/XMg7Wx4Adk3tsZaNsXvBKQ+UrOKb54cxInFv
         +xxEtZnL+ZzyMwcxRNp1BaYIaHhmVK/koo2uXNY0yMTvpBFg7RIrJFwZZzbIIEeGcLOX
         WiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=nNTy10NJqLifmJIjfqkwm5wr8P7XArvT8TvMBNduk8o=;
        b=mn7s/PMCgJR+mecOJfBLUNjYNy8cMSVzmNwz3ZWZoIVFdEXq5pktU+8UwgcaR2s7wf
         ESC7jq87wEVKmPsxeXxETRraA7/FrbzgyTtFpp6e4qyT1U+vm10zXTNS5QyQGr5ACkAk
         zCwpl1+7C2dX/GF9fOBm8RwxuVWavPQFqjBYxnLshx44qQgMIwUQHyCzQhP0ggfvUO5Z
         TYkhFAT76Ks80PZPQO6w+h+jA/QsI0FqOX9R+BEgGqMGpdQky2a57b+/FJQo9thSJH3n
         +tfJSCruek7WPQksZ56ErCx7HMvXpX0QGGDjsqSmUN+ZAoT+GKG7NSJSg0WXO0yUb5QC
         peLg==
X-Received: by 10.14.4.69 with SMTP id 45mr64316429eei.0.1360677787367;
        Tue, 12 Feb 2013 06:03:07 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:6552:be17:7596:e60d])
        by mx.google.com with ESMTPS id 44sm68000941eek.5.2013.02.12.06.03.05
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 06:03:06 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.572.g32bae1f
In-Reply-To: <cover.1360677646.git.mina86@mina86.com>
In-Reply-To: <cover.1360677646.git.mina86@mina86.com>
References: <cover.1360677646.git.mina86@mina86.com>
X-Gm-Message-State: ALoCoQkbiIyuw6pdU1yJJ++Gwdi9+w8MDan+wWXaxbUJbx7gwJbFPwizIOo64VthnlZJlHRmSNI4rSdVSkXE404eTH/mnq1Tj1AJQeXbJJQv3pRtxpkAgT7jrhgokTH7ex3kbJ7hyLW+miHP4qBcKC7XlsWBhzwqPx4Bp+i+XwekoJevDaY+yXlbqcwKhzxM/Zl9NP/YrNYB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216152>

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
1.8.1.3.572.g32bae1f
