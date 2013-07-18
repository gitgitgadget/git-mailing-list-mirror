From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] send-email: improve SSL certificate verification
Date: Thu, 18 Jul 2013 09:53:11 -0700
Message-ID: <7vd2qf4xoo.fsf_-_@alter.siamese.dyndns.org>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
	<1373025947-26495-2-git-send-email-artagnon@gmail.com>
	<51D82970.5070108@web.de>
	<20130706143256.GX862789@vauxhall.crustytoothpaste.net>
	<51D83C7E.8000902@web.de>
	<CALkWK0kAfZLqyCO+e+0PH0-MmjMYX1nJmit5Qb5L3Qf6nyhC9Q@mail.gmail.com>
	<20130714170316.GE11097@vauxhall.crustytoothpaste.net>
	<51E3677D.6040903@web.de>
	<20130716001506.GG11097@vauxhall.crustytoothpaste.net>
	<51E4B113.8000009@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Git List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 18:53:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzrSG-0000ft-CN
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 18:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262Ab3GRQxS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jul 2013 12:53:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58001 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759223Ab3GRQxP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jul 2013 12:53:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A05163104A;
	Thu, 18 Jul 2013 16:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=SkGcvT94F/P5
	dRVrPhnGgRFopPA=; b=GmLV0sxEhQcmsma4g67hBw9O4v5CGTQGH21tuL5Km+K3
	0f+UMMyaH9l6wr+RlsQj+w50XYE6/M3salbzQpq0i0Jq/YePORGGkW4188I1BTx6
	AVNJW3y8QrkOd04YgkiwSIm6oOned08x8TOTFCJsQ3yMacvSV19VNTLkfXdr4Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OmdsCL
	MdK/b+VU6xsejb2AturvvcVH1SSmzV2JbyMnSEgcTrGeaU7WSLTrQM0i/RtKP1IG
	Z4OfENflkTUyIYazVb/zILDzmE93e4egCagLKdFAhcoJXRJzajG/Men5CHah2KDr
	O+TUNYk/BzDglcC7mAs7DgB7DhPZ6jlYTxOqA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93B5031049;
	Thu, 18 Jul 2013 16:53:14 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9741C31045;
	Thu, 18 Jul 2013 16:53:13 +0000 (UTC)
In-Reply-To: <51E4B113.8000009@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 16 Jul 2013 04:33:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 890D5C8C-EFCA-11E2-81DD-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230700>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> I wasn't sure where to apply the patch, so I manually copy/paste it
> on top of pu:
> commit 6b1ca0f4d443ee8716857b871b0513ae85c9f112
> Merge: bce90ab f351fcf
>
> Thanks, t9001 passes on Mac OS X 10.6.
> To be sure I didn't messed it up, please see the diff below.
> When it shows up on pu, I can re-test of course.

As the history of rr/send-email-ssl-verify needs rewriting to squash
this change in, here is a single patch with which I would propose to
replace all the commits accumulated on that branch.

Ramkumar, as you will still be the primary author of the resulting
commit, I tentatively added a line for your sign-off even though you
haven't signed off _this_ version yet, so that I would not forget.
If this version looks good, please tell us you would.

Torsten, I have Tested-by with your name, again so that I would not
forget, but obviously this one hasn't been tested by you yet.  If
this tests OK, please tell us so.

Thanks.

-- >8 --
=46rom: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: send-email: be explicit with SSL certificate verification

When initiating an SSL connection without explicitly specifying the
SSL certificate verification mode, Net::SMTP::SSL defaults to no
verification, but recent versions of the module gives a warning
against this use of the default.

Enable certificate verification by default, using /etc/ssl/certs as
the default path for certificates of certificate authorities.  This
path can be overriden by the --smtp-ssl-cert-path command line
option and the sendemail.smtpSSLCertPath configuration variable.

Passing an empty string as the path for CA certificates path disables
the SSL certificate verification explicitly, which does not trigger
the warning from recent versions of Net::SMTP::SSL.

(PROVISO) Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Helped-by: Brian M. Carlson <sandals@crustytoothpaste.net>
(PROVISO) Tested-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt         |  4 ++++
 Documentation/git-send-email.txt |  6 ++++++
 git-send-email.perl              | 41 ++++++++++++++++++++++++++++++++=
+++++---
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6e53fc5..4de154c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2022,6 +2022,10 @@ sendemail.smtpencryption::
 sendemail.smtpssl::
 	Deprecated alias for 'sendemail.smtpencryption =3D ssl'.
=20
+sendemail.smtpsslcertpath::
+	Path to ca-certificates (either a directory or a single file).
+	Set it to an empty string to disable certificate verification.
+
 sendemail.<identity>.*::
 	Identity-specific versions of the 'sendemail.*' parameters
 	found below, taking precedence over those when the this
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-=
email.txt
index 40a9a9a..f0e57a5 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -198,6 +198,12 @@ must be used for each option.
 --smtp-ssl::
 	Legacy alias for '--smtp-encryption ssl'.
=20
+--smtp-ssl-cert-path::
+	Path to ca-certificates (either a directory or a single file).
+	Set it to an empty string to disable certificate verification.
+	Defaults to the value set to the 'sendemail.smtpsslcertpath'
+	configuration variable, if set, or `/etc/ssl/certs` otherwise.
+
 --smtp-user=3D<user>::
 	Username for SMTP-AUTH. Default is the value of 'sendemail.smtpuser';
 	if a username is not specified (with '--smtp-user' or 'sendemail.smtp=
user'),
diff --git a/git-send-email.perl b/git-send-email.perl
index bd13cc8..60eaed3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -69,6 +69,9 @@ sub usage {
     --smtp-pass             <str>  * Password for SMTP-AUTH; not neces=
sary.
     --smtp-encryption       <str>  * tls or ssl; anything else disable=
s.
     --smtp-ssl                     * Deprecated. Use '--smtp-encryptio=
n ssl'.
+    --smtp-ssl-cert-path    <str>  * Path to ca-certificates (either d=
irectory or file).
+                                     Pass an empty string to disable c=
ertificate
+                                     verification.
     --smtp-domain           <str>  * The domain name sent to HELO/EHLO=
 handshake
     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
=20
@@ -194,7 +197,7 @@ sub do_edit {
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc);
 my ($to_cmd, $cc_cmd);
 my ($smtp_server, $smtp_server_port, @smtp_server_options);
-my ($smtp_authuser, $smtp_encryption);
+my ($smtp_authuser, $smtp_encryption, $smtp_ssl_cert_path);
 my ($identity, $aliasfiletype, @alias_files, $smtp_domain);
 my ($validate, $confirm);
 my (@suppress_cc);
@@ -222,6 +225,7 @@ sub do_edit {
     "smtpserveroption" =3D> \@smtp_server_options,
     "smtpuser" =3D> \$smtp_authuser,
     "smtppass" =3D> \$smtp_authpass,
+    "smtpsslcertpath" =3D> \$smtp_ssl_cert_path,
     "smtpdomain" =3D> \$smtp_domain,
     "to" =3D> \@initial_to,
     "tocmd" =3D> \$to_cmd,
@@ -302,6 +306,7 @@ sub signal_handler {
 		    "smtp-pass:s" =3D> \$smtp_authpass,
 		    "smtp-ssl" =3D> sub { $smtp_encryption =3D 'ssl' },
 		    "smtp-encryption=3Ds" =3D> \$smtp_encryption,
+		    "smtp-ssl-cert-path" =3D> \$smtp_ssl_cert_path,
 		    "smtp-debug:i" =3D> \$debug_net_smtp,
 		    "smtp-domain:s" =3D> \$smtp_domain,
 		    "identity=3Ds" =3D> \$identity,
@@ -1089,6 +1094,34 @@ sub smtp_auth_maybe {
 	return $auth;
 }
=20
+sub ssl_verify_params {
+	eval {
+		require IO::Socket::SSL;
+		IO::Socket::SSL->import(qw/SSL_VERIFY_PEER SSL_VERIFY_NONE/);
+	};
+	if ($@) {
+		print STDERR "Not using SSL_VERIFY_PEER due to out-of-date IO::Socke=
t::SSL.\n";
+		return;
+	}
+
+	if (!defined $smtp_ssl_cert_path) {
+		$smtp_ssl_cert_path =3D "/etc/ssl/certs";
+	}
+
+	if ($smtp_ssl_cert_path eq "") {
+		return (SSL_verify_mode =3D> SSL_VERIFY_NONE());
+	} elsif (-d $smtp_ssl_cert_path) {
+		return (SSL_verify_mode =3D> SSL_VERIFY_PEER(),
+			SSL_ca_path =3D> $smtp_ssl_cert_path);
+	} elsif (-f $smtp_ssl_cert_path) {
+		return (SSL_verify_mode =3D> SSL_VERIFY_PEER(),
+			SSL_ca_file =3D> $smtp_ssl_cert_path);
+	} else {
+		print STDERR "Not using SSL_VERIFY_PEER because the CA path does not=
 exist.\n";
+		return (SSL_verify_mode =3D> SSL_VERIFY_NONE());
+	}
+}
+
 # Returns 1 if the message was sent, and 0 otherwise.
 # In actuality, the whole program dies when there
 # is an error sending a message.
@@ -1194,7 +1227,8 @@ sub send_message {
 			$smtp_domain ||=3D maildomain();
 			$smtp ||=3D Net::SMTP::SSL->new($smtp_server,
 						      Hello =3D> $smtp_domain,
-						      Port =3D> $smtp_server_port);
+						      Port =3D> $smtp_server_port,
+						      ssl_verify_params());
 		}
 		else {
 			require Net::SMTP;
@@ -1207,7 +1241,8 @@ sub send_message {
 				$smtp->command('STARTTLS');
 				$smtp->response();
 				if ($smtp->code =3D=3D 220) {
-					$smtp =3D Net::SMTP::SSL->start_SSL($smtp)
+					$smtp =3D Net::SMTP::SSL->start_SSL($smtp,
+									  ssl_verify_params())
 						or die "STARTTLS failed! ".$smtp->message;
 					$smtp_encryption =3D '';
 					# Send EHLO again to receive fresh
--=20
1.8.3.3-992-gf0e5e44
