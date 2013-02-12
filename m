From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCHv4 5/6] Git.pm: add interface for git credential command
Date: Tue, 12 Feb 2013 15:02:32 +0100
Message-ID: <e5834c9b5ccb66a88b64b3d07982ad41205fb97e.1360677646.git.mina86@mina86.com>
References: <cover.1360677646.git.mina86@mina86.com>
Cc: git@vger.kernel.org
To: peff@peff.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 12 15:04:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5GSy-0000kl-TG
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 15:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933279Ab3BLODV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 09:03:21 -0500
Received: from mail-ea0-f169.google.com ([209.85.215.169]:33508 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933221Ab3BLODS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 09:03:18 -0500
Received: by mail-ea0-f169.google.com with SMTP id d13so52061eaa.0
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 06:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=c3bVIsf+H5eFOlGJclbZ28IYN71S4HiJPSGdpgqPZTg=;
        b=ln96YXSVvc8FK0qt6BlU+3c0cJI/CXbURRSkfLILZZXuiHH/TPBN6eyOg0XkFo6QFy
         IjlPrl/GPtP4ogaW82MKKp1jj+eV4cgM+UKTuPW2FciteTbY/arTSruZAMMSJuZHL+52
         jQmdAkBOcTvfd1A/neIYD/poHeEOt6Ixtqg8eJ5RKgpDSn0kIIpRDvlccqGp3MB1A3gk
         qV3upNv2sR89VahqmVrwaerhKBRl2hZsYjJFtI4xg4HkNP3+Ue5FlBcY/HJGipAOUgR+
         Ywnb1KIzkYyQVwQu6MoHakdOgZx33hEDf/tsJLmSirtl3NnjTGVjJZOhtzHlHbTPD1NN
         6ZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=c3bVIsf+H5eFOlGJclbZ28IYN71S4HiJPSGdpgqPZTg=;
        b=MpsKJTmAHWcnSJE5T/zTsTVAk2W3st+4Gqp7GkBrycmLxM1t61wTre24arbQQod2RH
         p1cLLRk4AFxR3zgHDcQEIwHC25iGc/UlDXTqZDTG4WbCi3i8yzoVz83T2Oqg9keYV7vs
         PUs88cTlc5YG0HFUFGFKQG0+NyguJp4lC1Zu0IDPLjml5X0n58vUAv0EzSIt9axHc1Rh
         sZaEi/mwHaCSZLH9zEsrxbBjF9eZITmrdA6t/JYpRJYkb4MZXyITeH+U0RuV1K9be3yx
         6ahKlQnwy/WRP6RICJQHCZoHuBKgc0q+PNnV37i59CX7vymeNG4tV7c6B+3E26lF2SXf
         eDHQ==
X-Received: by 10.14.176.133 with SMTP id b5mr63487166eem.37.1360677785888;
        Tue, 12 Feb 2013 06:03:05 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:6552:be17:7596:e60d])
        by mx.google.com with ESMTPS id 44sm68000941eek.5.2013.02.12.06.03.04
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 06:03:05 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.572.g32bae1f
In-Reply-To: <cover.1360677646.git.mina86@mina86.com>
In-Reply-To: <cover.1360677646.git.mina86@mina86.com>
References: <cover.1360677646.git.mina86@mina86.com>
X-Gm-Message-State: ALoCoQler2iMWSvZVa2QY/H3dxg1FIHYonw0E5cpKzr+C86hvUNViOGZXFMHncf8iytI0R+MdI6GK2ZrtyrnLrow8a6N/qcWeePW+rTb+1mFNEra0/aTC9ZFLOmhCmU23HN/0li0o5SCFmWcmDeoVnmNDyfTV8t4yj/jKCgPzWbf422X4FGM/Fe+tB7toTxe/+zrnZgbauCh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216157>

From: Michal Nazarewicz <mina86@mina86.com>

Add a credential() function which is an interface to the git
credential command.  The code is heavily based on credential_*
functions in <contrib/mw-to-git/git-remote-mediawiki>.

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 perl/Git.pm | 151 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/perl/Git.pm b/perl/Git.pm
index d6e6c9e..a24458c 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -59,6 +59,7 @@ require Exporter;
                 command_bidi_pipe command_close_bidi_pipe
                 version exec_path html_path hash_object git_cmd_try
                 remote_refs prompt
+                credential credential_read credential_write
                 temp_acquire temp_release temp_reset temp_path);
 
 
@@ -1003,6 +1004,156 @@ sub _close_cat_blob {
 }
 
 
+=item credential_read( FILEHANDLE )
+
+Reads credential key-value pairs from C<FILEHANDLE>.  Reading stops at EOF or
+when an empty line is encountered.  Each line must be of the form C<key=value>
+with a non-empty key.  Function returns hash with all read values.  Any white
+space (other then new-line character) is preserved.
+
+=cut
+
+sub credential_read {
+	my ($self, $reader) = _maybe_self(@_);
+	my %credential;
+	while (<$reader>) {
+		chomp;
+		if ($_ eq '') {
+			last;
+		} elsif (!/^([^=]+)=(.*)$/) {
+			throw Error::Simple("unable to parse git credential data:\n$_");
+		}
+		$credential{$1} = $2;
+	}
+	return %credential;
+}
+
+=item credential_write( FILEHANDLE, CREDENTIAL_HASHREF )
+
+Writes credential key-value pairs from hash referenced by
+C<CREDENTIAL_HASHREF> to C<FILEHANDLE>.  Keys and values cannot contain
+new-lines or NUL bytes characters, and key cannot contain equal signs nor be
+empty (if they do Error::Simple is thrown).  Any white space is preserved.  If
+value for a key is C<undef>, it will be skipped.
+
+If C<'url'> key exists it will be written first.  (All the other key-value
+pairs are written in sorted order but you should not depend on that).  Once
+all lines are written, an empty line is printed.
+
+=cut
+
+sub credential_write {
+	my ($self, $writer, $credential) = _maybe_self(@_);
+	my ($key, $value);
+
+	# Check if $credential is valid prior to writing anything
+	while (($key, $value) = each %$credential) {
+		if (!defined $key || !length $key) {
+			throw Error::Simple("credential key empty or undefined");
+		} elsif ($key =~ /[=\n\0]/) {
+			throw Error::Simple("credential key contains invalid characters: $key");
+		} elsif (defined $value && $value =~ /[\n\0]/) {
+			throw Error::Simple("credential value for key=$key contains invalid characters: $value");
+		}
+	}
+
+	for $key (sort {
+		# url overwrites other fields, so it must come first
+		return -1 if $a eq 'url';
+		return  1 if $b eq 'url';
+		return $a cmp $b;
+	} keys %$credential) {
+		if (defined $credential->{$key}) {
+			print $writer $key, '=', $credential->{$key}, "\n";
+		}
+	}
+	print $writer "\n";
+}
+
+sub _credential_run {
+	my ($self, $credential, $op) = _maybe_self(@_);
+	my ($pid, $reader, $writer, $ctx) = command_bidi_pipe('credential', $op);
+
+	credential_write $writer, $credential;
+	close $writer;
+
+	if ($op eq "fill") {
+		%$credential = credential_read $reader;
+	}
+	if (<$reader>) {
+		throw Error::Simple("unexpected output from git credential $op response:\n$_\n");
+	}
+
+	command_close_bidi_pipe($pid, $reader, undef, $ctx);
+}
+
+=item credential( CREDENTIAL_HASHREF [, OPERATION ] )
+
+=item credential( CREDENTIAL_HASHREF, CODE )
+
+Executes C<git credential> for a given set of credentials and specified
+operation.  In both forms C<CREDENTIAL_HASHREF> needs to be a reference to
+a hash which stores credentials.  Under certain conditions the hash can
+change.
+
+In the first form, C<OPERATION> can be C<'fill'>, C<'approve'> or C<'reject'>,
+and function will execute corresponding C<git credential> sub-command.  If
+it's omitted C<'fill'> is assumed.  In case of C<'fill'> the values stored in
+C<CREDENTIAL_HASHREF> will be changed to the ones returned by the C<git
+credential fill> command.  The usual usage would look something like:
+
+	my %cred = (
+		'protocol' => 'https',
+		'host' => 'example.com',
+		'username' => 'bob'
+	);
+	Git::credential \%cred;
+	if (try_to_authenticate($cred{'username'}, $cred{'password'})) {
+		Git::credential \%cred, 'approve';
+		... do more stuff ...
+	} else {
+		Git::credential \%cred, 'reject';
+	}
+
+In the second form, C<CODE> needs to be a reference to a subroutine.  The
+function will execute C<git credential fill> to fill the provided credential
+hash, then call C<CODE> with C<CREDENTIAL_HASHREF> as the sole argument.  If
+C<CODE>'s return value is defined, the function will execute C<git credential
+approve> (if return value yields true) or C<git credential reject> (if return
+value is false).  If the return value is undef, nothing at all is executed;
+this is useful, for example, if the credential could neither be verified nor
+rejected due to an unrelated network error.  The return value is the same as
+what C<CODE> returns.  With this form, the usage might look as follows:
+
+	if (Git::credential {
+		'protocol' => 'https',
+		'host' => 'example.com',
+		'username' => 'bob'
+	}, sub {
+		my $cred = shift;
+		return !!try_to_authenticate($cred->{'username'},
+		                             $cred->{'password'});
+	}) {
+		... do more stuff ...
+	}
+
+=cut
+
+sub credential {
+	my ($self, $credential, $op_or_code) = (_maybe_self(@_), 'fill');
+
+	if ('CODE' eq ref $op_or_code) {
+		_credential_run $credential, 'fill';
+		my $ret = $op_or_code->($credential);
+		if (defined $ret) {
+			_credential_run $credential, $ret ? 'approve' : 'reject';
+		}
+		return $ret;
+	} else {
+		_credential_run $credential, $op_or_code;
+	}
+}
+
 { # %TEMP_* Lexical Context
 
 my (%TEMP_FILEMAP, %TEMP_FILES);
-- 
1.8.1.3.572.g32bae1f
