From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCHv3 4/5] Git.pm: add interface for git credential command
Date: Mon, 11 Feb 2013 17:23:38 +0100
Message-ID: <2ec5dd694878055e9ce9d650889ee85369073568.1360599712.git.mina86@mina86.com>
References: <cover.1360599057.git.mina86@mina86.com>
Cc: git@vger.kernel.org, Michal Nazarewicz <mina86@mina86.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:24:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4wBP-0002HU-6J
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 17:24:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757928Ab3BKQYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 11:24:18 -0500
Received: from mail-ea0-f180.google.com ([209.85.215.180]:45606 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757914Ab3BKQYE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 11:24:04 -0500
Received: by mail-ea0-f180.google.com with SMTP id c1so2730798eaa.39
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 08:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=ZVudROll/qjCAujPVeK5rP0nw6xpuSZuWBQqyoKnnIA=;
        b=V65aOr5TPLhyGHWLR2ynK4KLb6Zc90RGqHIq0Qp2m75j+rPFZDFiEw3oEJ401SA5wH
         w5MMGH8lHKY/cRQJAobWhxMnI/BPKWVX3ahiT0WPq8WPVU3Se7Lf1FWYzyPlWQJiU8Ia
         +oZPWnBSu2HKr0cvUaCfz2o1w0Lc+HzuclS1sBGvZ0bRu6sVlFqNhrbejUI9dK89LMfF
         NZoDbWQcw7/bvprenpabKtOxcGng+mBNuBTUZlCBLHoPW/iNJcF26x6gROI9s9AcF0VI
         4r3fLv/zlKTlCkMqtFCBhpMrDtpvFGmajjWXWbOr7TfLCkdKKaM9JIe+zbalE2TtDBwO
         lK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=ZVudROll/qjCAujPVeK5rP0nw6xpuSZuWBQqyoKnnIA=;
        b=lDtLsrtVaZNkg19SP2KVQuzc88hqeRV/ZtMSAs2I6ly3qLQVTeSe6ER++80KqqTb00
         h8Z1Ct71Idb8K/sPGy/MMs4SgwKugiacmcf701IzbMLVBkznQyJxEi512adYnfnPhanm
         zZQcVvLCjNjveWHNZLIivih55oPPjufX+DIuA5+qVXb+QlLB4Qy8I9GwIMJANXG7LyN3
         sV15FoxHkuOImjzbp495h/AQ9MhBUs+2gFBiIw2kMHkPYxbtN4+ikHEZN9TXUtbPzeXi
         TMxbpYCwoRpezhvbZZf9fehQSGJF/X1g5z23ojNPNgjNj83O9J8YzwFnSRxZUMMLsxYs
         esSw==
X-Received: by 10.14.213.131 with SMTP id a3mr51950671eep.24.1360599842785;
        Mon, 11 Feb 2013 08:24:02 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:1d0a:8048:51b4:44a9])
        by mx.google.com with ESMTPS id 3sm63347527eej.6.2013.02.11.08.24.01
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Feb 2013 08:24:01 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.571.g3f8bed7.dirty
In-Reply-To: <cover.1360599057.git.mina86@mina86.com>
In-Reply-To: <cover.1360599057.git.mina86@mina86.com>
References: <cover.1360599057.git.mina86@mina86.com>
X-Gm-Message-State: ALoCoQn4/sZhA0JAy87uP/1zVG68vbpaKQoNT8FcIw3afthc9oUi8q1fW6TUqiRIRHVWAXBdN/npipy7e9xBemocWbQZunMHYKPW8V8Ni59oW5+ANcq011vhh0mbZtWukwDd8PxK/0Jz6rPd6JWjRfaPHtubyIRj0emoM0JGEx0LntiaPsQbRlEe9k177mOn2HrlkOqDVnIf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216045>

From: Michal Nazarewicz <mina86@mina86.com>

Add a credential() function which is an interface to the git
credential command.  The code is heavily based on credential_*
functions in <contrib/mw-to-git/git-remote-mediawiki>.

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 perl/Git.pm | 148 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 147 insertions(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 9dded54..0e6fcf9 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -59,7 +59,8 @@ require Exporter;
                 command_bidi_pipe command_close_bidi_pipe
                 version exec_path html_path hash_object git_cmd_try
                 remote_refs prompt
-                temp_acquire temp_release temp_reset temp_path);
+                temp_acquire temp_release temp_reset temp_path
+                credential credential_read credential_write);
 
 
 =head1 DESCRIPTION
@@ -1013,6 +1014,151 @@ sub _close_cat_blob {
 }
 
 
+=item credential_read( FILE_HANDLE )
+
+Reads credential key-value pairs from C<FILE_HANDLE>.  Reading stops at EOF or
+when an empty line is encountered.  Each line must be of the form C<key=value>
+with a non-empty key.  Function returns a hash with all read values.  Any
+white space (other then new-line character) is preserved.
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
+=item credential_read( FILE_HANDLE, CREDENTIAL_HASH )
+
+Writes credential key-value pairs from hash referenced by C<CREDENTIAL_HASH>
+to C<FILE_HANDLE>.  Keys and values cannot contain new-line or NUL byte
+characters, and key cannot contain equal sign nor be empty (if they do
+Error::Simple is thrown).  Any white space is preserved.  If value for a key
+is C<undef>, it will be skipped.
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
+
+	my ($pid, $reader, $writer, $ctx) = command_bidi_pipe('credential', $op);
+
+	credential_write $writer, $credential;
+	close $writer;
+
+	if ($op eq "fill") {
+		%$credential = credential_read $reader;
+	} elsif (<$reader>) {
+		throw Error::Simple("unexpected output from git credential $op response:\n$_\n");
+	}
+
+	command_close_bidi_pipe($pid, $reader, undef, $ctx);
+}
+
+=item credential( CREDENTIAL_HASH [, OPERATION ] )
+
+=item credential( CREDENTIAL_HASH, CODE )
+
+Executes C<git credential> for a given set of credentials and
+specified operation.  In both form C<CREDENTIAL_HASH> needs to be
+a reference to a hash which stores credentials.  Under certain
+conditions the hash can change.
+
+In the first form, C<OPERATION> can be C<'fill'> (or omitted),
+C<'approve'> or C<'reject'>, and function will execute corresponding
+C<git credential> sub-command.  In case of C<'fill'> the values stored
+in C<CREDENTIAL_HASH> will be changed to the ones returned by the
+C<git credential> command.  The usual usage would look something like:
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
+In the second form, C<CODE> needs to be a reference to a subroutine.
+The function will execute C<git credential fill> to fill provided
+credential hash, than call C<CODE> with C<CREDENTIAL> as the sole
+argument, and finally depending on C<CODE>'s return value execute
+C<git credential approve> (if return value yields true) or C<git
+credential reject> (otherwise).  The return value is the same as what
+C<CODE> returned.  With this form, the usage might look as follows:
+
+	if (Git::credential {
+		'protocol' => 'https',
+		'host' => 'example.com',
+		'username' => 'bob'
+	}, sub {
+		my $cred = shift;
+		return try_to_authenticate($cred->{'username'}, $cred->{'password'});
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
+		_credential_run $credential, $ret ? 'approve' : 'reject';
+		return $ret;
+	} else {
+		_credential_run $credential, $op_or_code;
+	}
+}
+
 { # %TEMP_* Lexical Context
 
 my (%TEMP_FILEMAP, %TEMP_FILES);
-- 
1.8.1.3.571.g3f8bed7.dirty
