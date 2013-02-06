From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCH 4/4] git-send-email: Use git credential to obtain password.
Date: Wed,  6 Feb 2013 21:47:06 +0100
Message-ID: <1d13f9fb587b8ea740cdd774173b8f63f45f86af.1360183427.git.mina86@mina86.com>
References: <cover.1360183427.git.mina86@mina86.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Ted Zlatanov <tzz@lifelogs.com>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:47:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3BuN-0005mO-Ud
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 21:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758638Ab3BFUrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 15:47:31 -0500
Received: from mail-ee0-f44.google.com ([74.125.83.44]:38064 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758623Ab3BFUr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 15:47:26 -0500
Received: by mail-ee0-f44.google.com with SMTP id l10so1009297eei.31
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 12:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=SA9bX3MrPpWVjgJxLqPUhzgnZ/VjqHqnto09bd6k6jk=;
        b=VSmWLrqiraD6JPKDn95xzYobjEibAKrh3f8PCYmkULCW+5J74vQQMbz2Pj7INr5uAg
         vm2Tj8y+hEXX+B+ZTwccQ6KEJ+zqDyIlE4cytvx6HbIVVJJ4MvEgMVjjW0fBMMTtrwa3
         OnJmBrnpxcui1HEvyGuvv5rHJ0uTBZWgkf2nyPw6AeFAspcp0gdKAImI3j9xBSaFqMAF
         Iav1WtH2+kdcY5ECT8BbwyUWQ0V7y3aE9eyBIVP7QpXEGPMd2CmyJGWGKqOCahdsPdMm
         yh2bfvDnfrkc2ejqip/8/jY+O8XP/T4XGWQhKx5NgMs82dGt3lHXzSBZS7orIpuTPtqd
         0LrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=SA9bX3MrPpWVjgJxLqPUhzgnZ/VjqHqnto09bd6k6jk=;
        b=GcsERwkMgz+N+PLZ5ys/13JRl7sBsa1Yp+GY1b9Gpzl+WNR7bHsoiA4y1btc7/Szi1
         EsO3MnYYIvIqf0Ec9M5drvbi4dWZzieM+NlYxKxUjgOE0Q94DIEC6zJVcsOFvJnVmy07
         9DtoSncmTd4iiLegPnYfJq81Ta2fdjT9E/8VjYeoZjKIwUtykVYB6MxSV4eMYpFiPf7x
         wWA0gKrm4FMlYi4/bv0E8qwrHIP7gqGDlSZ7uuX8Gz3g9ZLjkIYDQ0zCouRQbJVzpO0D
         iJwkW/y4hyTy/wHb8pkD5yuccfFI+AtXXDUZYZcsdEh+bTZmyy6Cotgar5LHv1D8URVj
         RTKQ==
X-Received: by 10.14.176.133 with SMTP id b5mr86455478eem.37.1360183644663;
        Wed, 06 Feb 2013 12:47:24 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:e809:df2d:46af:f661])
        by mx.google.com with ESMTPS id z5sm294639eep.16.2013.02.06.12.47.23
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Feb 2013 12:47:23 -0800 (PST)
X-Mailer: git-send-email 1.8.1.2.549.g1d13f9f
In-Reply-To: <cover.1360183427.git.mina86@mina86.com>
In-Reply-To: <cover.1360183427.git.mina86@mina86.com>
References: <cover.1360183427.git.mina86@mina86.com>
X-Gm-Message-State: ALoCoQnuIvNUE7QrzB2NsphDvgAJg5+eaGBBXpG9Pnt+vdRyDNLRDTKDC3klmQWgVUUXN/5wbfVMfDl6s4dT/JGtU3WOfiKe7GTIsohWfGqieny26KlzeGDvW3b1372mifbo3T51qaa5IeBE60L1G8TFmAiIQEciT/jhsdAyhQs9WZhdq8A8haqoHzBRQemUhMrJuWaWijEz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215638>

From: Michal Nazarewicz <mina86@mina86.com>

If smtp_user is provided but smtp_pass is not, instead of prompting
for password, make git-send-email use git credential command
instead.

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
1.8.1.2.549.g4fa355e
