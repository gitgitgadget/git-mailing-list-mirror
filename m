From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCH 3/4] Git.pm: Add interface for git credential command.
Date: Wed,  6 Feb 2013 21:47:05 +0100
Message-ID: <f4b5413b0a55474346daa7b0866c7a4fed55778d.1360183427.git.mina86@mina86.com>
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
	id 1U3BuN-0005mO-Dj
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 21:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758635Ab3BFUr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 15:47:29 -0500
Received: from mail-ee0-f43.google.com ([74.125.83.43]:40769 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758625Ab3BFUrY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 15:47:24 -0500
Received: by mail-ee0-f43.google.com with SMTP id c50so1010486eek.2
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 12:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=j0jrvsBAjVQ0ZmXAEsuuDmrgvivSGvAWPPjoYoLwKAk=;
        b=Hc/i9s7qrn6qmfM6vASZKUEVWm+NVhKlFL3piGItN/c+jJilZorTDY7z79LsvU5h+o
         r9JdcCi6fVfSID2bnUwOVCZQiGfaoeI/PHWi0duPSuyLioI0b3OcdvCKXDuAIs3kBDqU
         Z1xSOLUuKHKD+d8d7x6VUUq2UqQp+673j0yl9gSL9mitpgm/ZKwGXLJOx1xqTp0D6Uri
         GGSgE8M2KwBW5F/fUz6m+X/FPZL11XU68VVaeEK09awvXXnp0qpz9Ix4p54IvZ0Y3yv1
         KjPJ6PNDURy3XZSDRXKtImaSxI/jXoWqKrT6qlQnT/kGleZfyDihVnekm5chOSoYyfYw
         DlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=j0jrvsBAjVQ0ZmXAEsuuDmrgvivSGvAWPPjoYoLwKAk=;
        b=PkwYiFnHKo/6VlR7Y89OO20lpAklWYQSLl87pgJLHHgew6etExplhoT/l0Ov01BdLo
         qRxtoVBZ/2UxkH61zsuzMcgCWLECqDZGCLvyMFp3oUxn2GUqlomuQDcdtHo6opCfD2VG
         er+Qiwd/uJ8fK6tbr2rf4egW3xa3ftfpwopfVFB/DGwwn/Dn8vgymT9iO3f4JdPfAeID
         W/QI6cl9s/uSEVS20q8mg/oAOfHvpUFPYVmjrvTO7yifrEAzalogBwCzTLt+SxxYFsvI
         Phly5v6W5JzQa7kh7ESEidXkkQSBgeDiUCBp85N7kGuj0pExRghcO3trnUPGdWFpc/og
         vPnw==
X-Received: by 10.14.199.135 with SMTP id x7mr694759een.18.1360183643229;
        Wed, 06 Feb 2013 12:47:23 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:e809:df2d:46af:f661])
        by mx.google.com with ESMTPS id z5sm294639eep.16.2013.02.06.12.47.21
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Feb 2013 12:47:22 -0800 (PST)
X-Mailer: git-send-email 1.8.1.2.549.g1d13f9f
In-Reply-To: <cover.1360183427.git.mina86@mina86.com>
In-Reply-To: <cover.1360183427.git.mina86@mina86.com>
References: <cover.1360183427.git.mina86@mina86.com>
X-Gm-Message-State: ALoCoQlUnNHTzZ7y3vK1XhtUvRFWncCpRNOxRuRaElSLxUl6VFUrSHhYmoFNvvBtpOasbJ2c1W82mStv6g10GlIYH/+0/iJ+8NLyfhea8QitIzBtW5dY5/EMb4EVKqO5/uCZgULzlDf6B+njdF3sN/Txzc7YteiomSGDiviIdXSaNkTv7XDwDXXPaFMAM6inavOof9VUVQL0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215639>

From: Michal Nazarewicz <mina86@mina86.com>

Add a credential() function which is an interface to the
git credential command.

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 perl/Git.pm | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 6a2d52d..5a18921 100644
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
@@ -1000,6 +1001,115 @@ sub _close_cat_blob {
 }
 
 
+sub _credential_read {
+	my %credential;
+	my ($reader, $op) = (@_);
+	while (<$reader>) {
+		chomp;
+		my ($key, $value) = /([^=]*)=(.*)/;
+		if (not defined $key) {
+			throw Error::Simple("unable to parse git credential $op response:\n$_\n");
+		}
+		$credential{$key} = $value;
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
1.8.1.2.549.g4fa355e
