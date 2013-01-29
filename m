From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCHv2] git-send-email: add ~/.authinfo parsing
Date: Tue, 29 Jan 2013 22:08:49 +0100
Message-ID: <d58b0709cd86e0d336902b52d72e06dd9b52d70d.1359493459.git.mina86@mina86.com>
References: <7vvcafojf4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Krzysztof Mazur <krzysiek@podlesie.net>,
	Michal Nazarewicz <mina86@mina86.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 22:09:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0IQq-0007kO-V8
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 22:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282Ab3A2VJD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2013 16:09:03 -0500
Received: from mail-wi0-f179.google.com ([209.85.212.179]:50126 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab3A2VJB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 16:09:01 -0500
Received: by mail-wi0-f179.google.com with SMTP id o1so893208wic.6
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 13:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=1qeC8/a0lNSdn5yFY9f1aD/sOEW+TAvYexmmB0BAcow=;
        b=UYMf8OTDwzvA9KhV2zSTJgI+5ZwKrOJbhElHWAdu1xJJRSOeHbq/VfUO9Qg7sgaPaa
         2xfZdrOT55Bw53RGPOLTImFARg2MqTWInCs7Kf5LbHl7TUp5Hdx3WJCFmZHerPXsBQuF
         nWkTVQSSHlhXM8O8CvidY0jluW9PToWlgdTBIm4WpbUGbOrBGwd1T1FJFJRebmTtmjPo
         47gJYpp6OumVoWpk/KM8bdxb+kMCE+Mf1Kd913PF/qSB1cXb9pDImR4ix7Zq5UIKPkiB
         Ff6BZt2u9g3UbW6cSooC25VrWxH2svok8hVkOFSgeSlgR5RuWKQEuzZJ8h3PQnDuwn18
         zVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=1qeC8/a0lNSdn5yFY9f1aD/sOEW+TAvYexmmB0BAcow=;
        b=kxd/SESvU44m8csgZOKFIw2Nwk2MSHOm0fd63fLSRMslSljB96B1k1eE07Ks8BoBje
         /+wVLAW4iLCOU46Srl5kDrGVxZX3DW+Rr0PqG/uww4oR9RFIKq/zpbc07ahfHsLn+jzn
         cPKoGVlHtchPfvwk+2zHNedux9A2HfsAoTSE5UB20NBUBeZv5etEP2IgMY27v2mP+UMM
         OcTp/zGhdABqHrvh/arj+LcY50bNodxBwg9gWVXRgCMn2Mf9Ef51dW4Drqu79R3KKtFT
         tWe3WDIQO00du1jE+0qCKSzswEA0zzPfu/T1bm/uidjxbRrgThCZqpWRy3TElRgijfKq
         6Uxg==
X-Received: by 10.180.86.36 with SMTP id m4mr5034488wiz.5.1359493739687;
        Tue, 29 Jan 2013 13:08:59 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:11cb:a088:c857:76de])
        by mx.google.com with ESMTPS id ge2sm5387014wib.4.2013.01.29.13.08.58
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jan 2013 13:08:58 -0800 (PST)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <7vvcafojf4.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQlH5JIHrKX+Go7QRxrJR6CwfZULRcuwAqg0/DA5tXBtch56AVIVpCteBMJkOtGY56Wmb0DMflYVbfdItqN/ba9tmfWli6MfibNtwU2KuP4HOva+OXuOdoIyNDuSX3TKt0sR7/4uswOKIc89jk5L4aKbzpB+/FraN7KjFBpt9Dz84WROKIs7p6g+wzEyDgWE1UBCL5D7RaDNmexbVv8I3pT8e2A9CA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214972>

=46rom: Michal Nazarewicz <mina86@mina86.com>

Make git-send-email read password from a ~/.authinfo or a ~/.netrc
file instead of requiring it to be stored in git configuration, passed
as command line argument or typed in.

There are various other applications that use this file for
authentication information so letting users use it for git-send-email
is convinient.  Furthermore, some users store their ~/.gitconfig file
in a public repository and having to store password there makes it
easy to publish the password.

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 Documentation/git-send-email.txt |  34 +++++++++--
 git-send-email.perl              | 124 +++++++++++++++++++++++++++++++=
++++----
 2 files changed, 140 insertions(+), 18 deletions(-)

On Tue, Jan 29 2013, Junio C Hamano wrote:
> Makes one wonder why .authinfo and not .netrc;=20

=46ine=E2=80=A6 Let's parse both. ;)

> Either way it still encourages a plaintext password to be on disk,
> which may not be what we want, even though it may be slight if not
> really much of an improvement.

Well=E2=80=A6 Users store passwords on disks in a lot of places.  I wag=
er that
most have mail clients configured not to ask for password but instead
store it on hard drive.  I don't see that changing any time soon, so
at least we can try and minimise number of places where a password is
stored.

> It is rather strange to require a comma-separated-values parser to
> read a file format this simple, isn't it?

I was worried about spaces in password.  CVS should handle such case
nicely, whereas simple split won't.  Nonetheless, I guess that in the
end this is not likely enough to add the dependency.

> Perhaps you can convert at least some popular ones yourself?  After
> all, the user may be using an _existing_ .authinfo/.netrc that she
> has been using with other programs that do understand symbolic port
> names.  Rather than forcing all such users to update their files,
> the patch can work a bit harder for them and the world will be a
> better place, no?

Parsing /etc/services added.

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-=
email.txt
index eeb561c..ee20714 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -158,14 +158,36 @@ Sending
 --smtp-pass[=3D<password>]::
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
+Each pair (expect for `password <pass>`) can be omitted which will
+skip matching of the given value.  Lines are interpreted in order and
+password from the first line that matches will be used.  `<port>` can
+be either an integer or a symbolic name.  In the latter case, it is
+looked up in `/etc/services` file (if it exists).  For instance, you
+can put
++
+  machine example.com login testuser port ssmtp password smtppassword
+  machine example.com login testuser            password testpassword
++
+if you want to use `smtppassword` for authenticating to a service at
+port 465 (SSMTP) and `testpassword` for all other services.  As shown
+in the example, `<port>` can use   If ~/.authinfo file is
+missing, 'git-send-email' will also try ~/.netrc file.
=20
 --smtp-server=3D<host>::
 	If set, specifies the outgoing SMTP server to use (e.g.
diff --git a/git-send-email.perl b/git-send-email.perl
index be809e5..2d8fd1b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1045,6 +1045,117 @@ sub maildomain {
 	return maildomain_net() || maildomain_mta() || 'localhost.localdomain=
';
 }
=20
+
+sub read_password_from_stdin {
+	my $line;
+
+	system "stty -echo";
+
+	do {
+		print "Password: ";
+		$line =3D <STDIN>;
+		print "\n";
+	} while (!defined $line);
+
+	system "stty echo";
+
+	chomp $line;
+	return $line;
+}
+
+sub read_etc_services {
+	my $fd;
+	if (!open $fd, '<', '/etc/services') {
+		return {};
+	}
+
+	my $ret =3D {};
+	while (my $line =3D <$fd>) {
+		$line =3D~ s/^\s+|\s*(?:#.*)?$//g;
+		my @line =3D split /\s+/, $line;
+		if (@line < 2 || $line[1] !~ m~^(\d+)/tcp$~) {
+			next;
+		}
+
+		my $num =3D int $1;
+		undef $line[1];
+		for my $service (@line) {
+			if (defined $service && !defined $ret->{$service}) {
+				$ret->{$service} =3D $num;
+			}
+		}
+	}
+
+	close $fd;
+	return $ret;
+}
+
+my $authinfo_parse_port;
+
+sub authinfo_is_eq_port {
+	my ($from_file, $value, $filename) =3D @_;
+
+	if (!defined $from_file) {
+		return 1;
+	} elsif ($from_file =3D~ /^\d+$/) {
+		return $from_file =3D=3D $value;
+	}
+
+	if (!defined $authinfo_parse_port) {
+		$authinfo_parse_port =3D read_etc_services;
+	}
+
+	my $port =3D $authinfo_parse_port->{$from_file};
+	if (!defined $port) {
+		print STDERR "$filename: invalid port name: $from_file\n";
+		return;
+	}
+
+	return $port =3D=3D $value;
+}
+
+sub authinfo_is_eq {
+	my ($from_file, $value) =3D @_;
+	return defined $from_file || $from_file eq $value;
+}
+
+sub read_password_from_authinfo {
+	my $filename =3D join '/', $ENV{'HOME'}, $_[0] // '.authinfo';
+	my $fd;
+	if (!open $fd, '<', $filename) {
+		return;
+	}
+
+	my $password;
+	while (my $line =3D <$fd>) {
+		$line =3D~ s/^\s+|\s+$//g;
+		my @line =3D split /\s+/, $line;
+		if (@line % 2) {
+			next;
+		}
+
+		my %line =3D @line;
+		if (defined $line{'password'} &&
+		    authinfo_is_eq $line{'machine'}, $smtp_server &&
+		    authinfo_is_eq $line{'login'}, $smtp_authuser &&
+		    authinfo_is_eq_port $line{'port'}, $smtp_server_port, $filename)=
 {
+			$password =3D $line{'password'};
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
@@ -1194,18 +1305,7 @@ X-Mailer: git-send-email $gitversion
 			};
=20
 			if (!defined $smtp_authpass) {
-
-				system "stty -echo";
-
-				do {
-					print "Password: ";
-					$_ =3D <STDIN>;
-					print "\n";
-				} while (!defined $_);
-
-				chomp($smtp_authpass =3D $_);
-
-				system "stty echo";
+				$smtp_authpass =3D read_password
 			}
=20
 			$auth ||=3D $smtp->auth( $smtp_authuser, $smtp_authpass ) or die $s=
mtp->message;
--=20
1.8.1
