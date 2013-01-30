From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCHv3] git-send-email: add ~/.authinfo parsing
Date: Wed, 30 Jan 2013 01:03:51 +0100
Message-ID: <5d18d777d6ddf6f01bbf460f37af637d3dc28ed5.1359503987.git.mina86@mina86.com>
References: <7vehh3obs0.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Krzysztof Mazur <krzysiek@podlesie.net>,
	Michal Nazarewicz <mina86@mina86.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 01:04:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0LA6-0007HC-4H
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 01:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695Ab3A3AEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 19:04:00 -0500
Received: from mail-ee0-f48.google.com ([74.125.83.48]:61384 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586Ab3A3AD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 19:03:59 -0500
Received: by mail-ee0-f48.google.com with SMTP id t10so515118eei.7
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 16:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=i77CgcprIq3hs3qwV15KGeSIxF2PLw3cJQIqNQr28Kk=;
        b=XCeMTDu2eBh74LMxdFM0Oyv134ZZe9ODi1s4e6k8ywJ34DRdv+bq1HQCos7oCnvfVy
         WKZtg/Jgw+pX2j2N2rvt40VD+DJwW+7IBpIHJOPlRa5z58L2PsEktIPbahfsMzevCp63
         DXQ8hoBdzxzr2cw437eC/FslLCQA60Ra2v71s+SrHQxkbE2SUW340TiXyHuAlHlXo/5i
         YslDfShd6Gy2YF61Iu5dKUiaKanlRoEBSzV5dAj2SeQ2w59No3XFdWgkQd/EYMW6LRYd
         HNVqZHucphFf1XKu12mkKJXPa6YJzC6f07AP9qQKyTjC21skfp1eFrsdZ/TdXlmdzWfg
         sm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=i77CgcprIq3hs3qwV15KGeSIxF2PLw3cJQIqNQr28Kk=;
        b=M7U1aH5nguR+A6nkPQSgrRSf5Zwwx9ql9kB5AXQLt4K2LyMXWda41QYJJIkz1ZPdWz
         TLKa5O5DrazDvQ9qX3CrQ89lkmCu3+ZWFdXUn0S431/JyRrwpOQY2Ayhib3JsxMES1st
         k+/vHVg8cadartvMZBSx4MOwNFPhPLoVCtSkFXCBvXrIj/l37uY0ZXTM6kPH0/0dy0qI
         kGxa4+PjH1uWVtE/lyiw2KvfhcAfij3RL+DnAEu9E2agJYbuusFZSQb3XDaQYqec2J+4
         z0scGpCJR1pj940/x+e0lnJhiLQ4fqNWOa+7POw8oYncp2/rfOsbwwPsOC8MvmASsEvI
         2aTQ==
X-Received: by 10.14.224.137 with SMTP id x9mr8710309eep.11.1359504237459;
        Tue, 29 Jan 2013 16:03:57 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:11cb:a088:c857:76de])
        by mx.google.com with ESMTPS id q5sm22053995eep.11.2013.01.29.16.03.55
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jan 2013 16:03:56 -0800 (PST)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <7vehh3obs0.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkoJH06tcSNyli13TYIFfCYDsJONO4cNWzpG0TkAapadGrcYEsoOhO06RgWOtbcJRgUxLaUjEX/cpVXR69qc5vGfGiNtlWvLwUdZwtKzmAy0ummJ3Lw0hopW25TevVABoBG4yf7lb6lo2Fgb22T022caaCAupZqn4G+dAqKQQYS9OXhDqT9Wr+a616Xcx6ORHVLRzZmixHw5WED5u0KbQBCNyp2Og==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214982>

From: Michal Nazarewicz <mina86@mina86.com>

Make git-send-email read password from a ~/.authinfo or ~/.netrc file
instead of requiring it to be stored in git configuration, passed as
command line argument or typed in.

There are various other applications that use this file for
authentication information so letting users use it for git-send-email
is convinient.  Furthermore, some users store their ~/.gitconfig file
in a public repository and having to store password there makes it
easy to publish the password.

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 Documentation/git-send-email.txt | 47 +++++++++++++++++---
 git-send-email.perl              | 93 ++++++++++++++++++++++++++++++++++------
 2 files changed, 122 insertions(+), 18 deletions(-)

On Tue, Jan 29 2013, Junio C Hamano wrote:
> But .netrc/.authinfo format separates its entries with SP, HT, or
> LF.  An entry begins with "machine <remote-hostname>" token pair.
>
> split(/\s+/) will not work for an entry that span multiple lines but
> CSV will not help, either.
>
> Is it bad to use Net::Netrc instead?  This looks like exactly the
> use case that module was written for, no?

I don't think that's the case.  For one, Net::Netrc does not seem to
process port number.

There is a Text::Authinfo module but it just uses Text::CSV.

I can change the code to use Net::Netrc, but I dunno if that's really
the best option, since I feel people would expect parsing to be
somehow compatible with
<http://www.gnu.org/software/emacs/manual/html_node/gnus/NNTP.html>
rather than the original .netrc file format.

> Hmph.  I would have expected to see getservbyname.

Ha!  Even better. :]

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index eeb561c..ac020d1 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -158,14 +158,49 @@ Sending
 --smtp-pass[=<password>]::
 	Password for SMTP-AUTH. The argument is optional: If no
 	argument is specified, then the empty string is used as
-	the password. Default is the value of 'sendemail.smtppass',
-	however '--smtp-pass' always overrides this value.
+	the password. Default is the value of 'sendemail.smtppass'
+	or value read from ~/.authinfo file, however '--smtp-pass'
+	always overrides this value.
 +
-Furthermore, passwords need not be specified in configuration files
-or on the command line. If a username has been specified (with
+Furthermore, passwords need not be specified in configuration files or
+on the command line. If a username has been specified (with
 '--smtp-user' or a 'sendemail.smtpuser'), but no password has been
-specified (with '--smtp-pass' or 'sendemail.smtppass'), then the
-user is prompted for a password while the input is masked for privacy.
+specified (with '--smtp-pass', 'sendemail.smtppass' or via
+~/.authinfo file), then the user is prompted for a password while
+the input is masked for privacy.
++
+The ~/.authinfo file should contain a line with the following
+format:
++
+  machine <domain> port <port> login <user> password <pass>
++
+Instead of `machine <domain>` pair a `default` token can be used
+instead in which case all domains will match.  Similarly, `port
+<port>` and `login <user>` pairs can be omitted in which case matching
+of the given value will be skipped.  `<port>` can be either an integer
+or a symbolic name.  Lines are interpreted in order and password from
+the first line that matches will be used.  For instance, one may end
+up with:
++
+  machine example.com login jane port ssmtp password smtppassword
+  machine example.com login jane            password janepassword
+  default             login janedoe         password doepassword
++
+if she wants to use `smtppassword` for authenticating as `jane` to
+a service at example.com:465 (SSMTP), `janepassword` for all other
+services at example.com; and `doepassword` when authonticating as
+`janedoe` to any service.  If ~/.authinfo file is missing,
+'git-send-email' will also try ~/.netrc file (even though parsing is
+not fully compatible with ftp's .netrc file format).
++
+Note that you should never make ~/.authinfo file world-readable.  To
+help guarantee that, you might want to create the file with the
+following command:
++
+  ( umask 077; cat >~/.authinfo <<EOF
+  ... file contents ...
+  EOF
+  )
 
 --smtp-server=<host>::
 	If set, specifies the outgoing SMTP server to use (e.g.
diff --git a/git-send-email.perl b/git-send-email.perl
index be809e5..a62dfa4 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1045,6 +1045,86 @@ sub maildomain {
 	return maildomain_net() || maildomain_mta() || 'localhost.localdomain';
 }
 
+
+sub read_password_from_stdin {
+	my $line;
+
+	system "stty -echo";
+
+	do {
+		print "Password: ";
+		$line = <STDIN>;
+		print "\n";
+	} while (!defined $line);
+
+	system "stty echo";
+
+	chomp $line;
+	return $line;
+}
+
+sub authinfo_is_port_eq {
+	my ($from_file, $value, $filename) = @_;
+
+	if (!defined $from_file) {
+		return 1;
+	} elsif ($from_file =~ /^\d+$/) {
+		return $from_file == $value;
+	}
+
+	my $port = getservbyname $from_file, 'tcp';
+	if (!defined $port) {
+		print STDERR "$filename: invalid port name: $from_file\n";
+		return;
+	}
+
+	return $port == $value;
+}
+
+sub read_password_from_authinfo {
+	my $filename = join '/', $ENV{'HOME'}, $_[0] // '.authinfo';
+	my $fd;
+	if (!open $fd, '<', $filename) {
+		return;
+	}
+
+	my $password;
+	while (my $line = <$fd>) {
+		$line =~ s/^\s+|\s+$//g;
+		my @line = split /\s+/, $line;
+		my %line;
+		while (@line) {
+			my $token = shift @line;
+			if ($token eq 'default') {
+				$line{'machine'} = $smtp_server;
+			} elsif (@line) {
+				$line{$token} = shift @line;
+			}
+		}
+
+		if (defined $line{'password'} &&
+		    defined $line{'machine'} &&
+		    $line{'machine'} eq $smtp_server &&
+		    (!defined $line{'login'} ||
+		     $line{'login'} eq $smtp_authuser) &&
+		    authinfo_is_port_eq($line{'port'}, $smtp_server_port, $filename)) {
+			$password = $line{'password'};
+			last;
+		}
+	}
+
+	close $fd;
+	return $password;
+}
+
+sub read_password {
+	return
+	  read_password_from_authinfo '.authinfo' ||
+	  read_password_from_authinfo '.netrc' ||
+	  read_password_from_stdin;
+}
+
+
 # Returns 1 if the message was sent, and 0 otherwise.
 # In actuality, the whole program dies when there
 # is an error sending a message.
@@ -1194,18 +1274,7 @@ X-Mailer: git-send-email $gitversion
 			};
 
 			if (!defined $smtp_authpass) {
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
+				$smtp_authpass = read_password
 			}
 
 			$auth ||= $smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
-- 
1.8.1
