From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCHv2 4/5] Git.pm: add interface for git credential command
Date: Thu,  7 Feb 2013 15:01:20 +0100
Message-ID: <78516627e893e54d5aafe0694d1face9a37893de.1360242782.git.mina86@mina86.com>
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
	id 1U3S3L-0005g7-EK
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 15:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758730Ab3BGOBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 09:01:42 -0500
Received: from mail-ea0-f182.google.com ([209.85.215.182]:58827 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758702Ab3BGOBj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 09:01:39 -0500
Received: by mail-ea0-f182.google.com with SMTP id a12so1160254eaa.27
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 06:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=NZ9dZKKRW4LcmL/w3cznseiH5/9h+tg4Ee0EszJTod0=;
        b=QYZgIFWQ+DE6CofWu+szzSJeKZrfn4I+gFLCpQlywvEIxwExsla1FS5c2RsO5tp29w
         S4wLkyIqYENBYLU7ZY+ctHlaCYXXG92XpnRpiywQP2lfi5mmUEvDS2HLWhZig6TliNu7
         2nSAh79+8m2+eHiLfxqyGa2vlX6zzbAoBAxRvMEkOHoBjeD7J+HzgbCu9RC+myjWQ/TD
         OmMVEfHFTErpuWFMcYcJyLC3LLVLTujw5RT2T7qnf+rGSUqSawLcFbtEmGJxraWalWoR
         9FKfTQnZ7nVGRBIMc01+P95JZL7xt1IFN6vr0F5pRqHin81ET54z14uk7PI47QBtTIGg
         nlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=NZ9dZKKRW4LcmL/w3cznseiH5/9h+tg4Ee0EszJTod0=;
        b=ah2UitRc7XICmoh0tCBqhrY1Z515kSNd1kBXTP3/7Iax/ITNbVs6nTRWd32gF/U0z1
         pz03Xhnqym+z0vCQTZCv1F/wfHXh8jr+oLtfnFT4gC7iwbEpB3/i/Ax9JApCO3UjVm8G
         1CKoNhriXy694THVd5slfDNIdXf8V+4vhc4mUxTPKBWGukm1nJb17nLXY4X/31Cpe+wM
         vMhpvcvssGZDwtcI1bj+lJJOjhzqpGTlNX5BKcdKIr3FpBdJCoR7boq78OtZ3rLvC4bP
         8sZw8v0JqM8VRJLnRQ+kF13n15+4pHQTWV2H/QxJWuRGu4/67l+IAtHIpTuznrYOKE78
         pP0Q==
X-Received: by 10.14.2.196 with SMTP id 44mr4391533eef.25.1360245698255;
        Thu, 07 Feb 2013 06:01:38 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:bdef:84b9:750e:31d0])
        by mx.google.com with ESMTPS id f6sm42214479eeo.7.2013.02.07.06.01.36
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Feb 2013 06:01:37 -0800 (PST)
X-Mailer: git-send-email 1.8.1.2.550.g0b3c9b6
In-Reply-To: <cover.1360242782.git.mina86@mina86.com>
In-Reply-To: <cover.1360242782.git.mina86@mina86.com>
References: <cover.1360242782.git.mina86@mina86.com>
X-Gm-Message-State: ALoCoQl/CauVo+RplKfmH9dot6WjHqUexFF1bDI2SEFt7C4tUFRpOSKqlQ9AFMTz3mpSI8J6myluWZqWWSy0NUdJSGUfWI2bPlobxAx2wfLDd1StV9/+/PewbgfNnDwRwZ04l3lqQgkkLUhBlCs7SsNhV/nb0bRpjm+ejNn7fBbD0bu0vxCO5ebTzTVoyHXxXnYOJ+d9Fn0s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215693>

From: Michal Nazarewicz <mina86@mina86.com>

Add a credential() function which is an interface to the git
credential command.  The code is heavily based on credential_*
functions in <contrib/mw-to-git/git-remote-mediawiki>.

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 perl/Git.pm | 110 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

 On Thu, Feb 07 2013, Jeff King <peff@peff.net> wrote:
 > On Wed, Feb 06, 2013 at 09:47:05PM +0100, Michal Nazarewicz wrote:
 >
 >> +sub _credential_read {
 >> +	my %credential;
 >> +	my ($reader, $op) = (@_);
 >> +	while (<$reader>) {
 >> +		chomp;
 >> +		my ($key, $value) = /([^=]*)=(.*)/;
 >
 > Empty keys are not valid. Can we make this:
 >
 >   /^([^=]+)=(.*)/
 >
 > to fail the regex? Otherwise, I think this check:
 >
 >> +		if (not defined $key) {
 >> +			throw Error::Simple("unable to parse git credential $op response:\n$_\n");
 >> +		}
 >
 > would not pass because $key would be the empty string.

 Right, fixed.  

 >> +sub _credential_write {
 >> +	my ($credential, $writer) = @_;
 >> +
 >> +	for my $key (sort {
 >> +		# url overwrites other fields, so it must come first
 >> +		return -1 if $a eq 'url';
 >> +		return  1 if $b eq 'url';
 >> +		return $a cmp $b;
 >> +	} keys %$credential) {
 >> +		if (defined $credential->{$key} && length $credential->{$key}) {
 >> +			print $writer $key, '=', $credential->{$key}, "\n";
 >> +		}
 >> +	}
 >
 > There are a few disallowed characters, like "\n" in key or value, and
 > "=" in a key. They should never happen unless the caller is buggy, but
 > should we check and catch them here?

 I left it as is for now since it's not entairly clear to me what to
 do in all cases.  In particular:
 
 - when reading, what to do if the line is " foo = bar ",
 - when reading, what to do if the line is "foo=" (ie. empty value),
 - when writing, what to do if value is a single space,
 - when writing, what to do if value ends with a new line,
 - when writing, what to do if value is empty (currently not printed at all),

 On Thu, Feb 07 2013, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
 > I think you should credit git-remote-mediawiki for the code in the
 > commit message. Perhaps have a first "copy/paste" commit, and then an
 > "adaptation" commit to add sort, ^ anchor in regexp, doc and your
 > callback mechanism, but I won't insist on that.

 Good point.  Creating additional commit is a bit too much for my
 licking, but added note in commit message.

diff --git a/perl/Git.pm b/perl/Git.pm
index 9dded54..b4adead 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -59,7 +59,8 @@ require Exporter;
                 command_bidi_pipe command_close_bidi_pipe
                 version exec_path html_path hash_object git_cmd_try
                 remote_refs prompt
-                temp_acquire temp_release temp_reset temp_path);
+                temp_acquire temp_release temp_reset temp_path
+                credential);
 
 
 =head1 DESCRIPTION
@@ -1013,6 +1014,113 @@ sub _close_cat_blob {
 }
 
 
+sub _credential_read {
+	my %credential;
+	my ($reader, $op) = (@_);
+	while (<$reader>) {
+		if (!/^([^=\s]+)=(.*?)\s*$/) {
+			throw Error::Simple("unable to parse git credential $op response:\n$_");
+		}
+		$credential{$1} = $2;
+	}
+	return %credential;
+}
+
+sub _credential_write {
+	my ($credential, $writer) = @_;
+
+	for my $key (sort {
+		# url overwrites other fields, so it must come first
+		return -1 if $a eq 'url';
+		return  1 if $b eq 'url';
+		return $a cmp $b;
+	} keys %$credential) {
+		if (defined $credential->{$key} && length $credential->{$key}) {
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
+	_credential_write $credential, $writer;
+	close $writer;
+
+	if ($op eq "fill") {
+		%$credential = _credential_read $reader, $op;
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
+credential hash, than call C<CODE> with C<CREDENTIAL_HASH> as the sole
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
1.8.1.2.549.g1d13f9f
